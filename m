Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D62E0914
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167934; cv=pass; b=XYK47pktotSDJRnRxTJscYiWPPzTbGI2CjqmQeuB0FbIil+wwxWMfYaIfg59iWuCj3NIk6+I7dPYOAbqHhaBSAVDwTiuvlc4gl6g1c4o0gasIoG0B04Ng/f6CrUqRgs6DfycE3NFxbeA8dEk9mj+cEkkLsdSlRCbWBzd/VPmGEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167934; c=relaxed/simple;
	bh=2zbj41rDY60k//Ojjdhy7kw5Fi+0XMvlW8sqapDemCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaJcJgclzmHQ1WmfslfbPwOHXX/TL7ML/dcq6TgA7z8/lPc5MY1Z3mh7c57TtfubDHs25q/hMFOz6myRFONs/U/fWHxRj0VkrbKpCSQavj97fg/CDHi+pPevjjB2I8uCItYiRqh4iY7WkOrHKBqlWqVCxQ5LoUyRVNvWNYuJmDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4XdVXut; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4XdVXut"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffcso4443115ad.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790167932; cv=none;
        d=google.com; s=arc-20260327;
        b=IWKGG5S3q4DOZQ25m+8iq6KZ71oEfcnVIRWVvyEyE9od2B935gB8+JQ4R71CaSzUVi
         iLpOU+Pb7KDDlrYD+Mp9B4FtBpFnpHJ859OCBegp/VWhVhbYChEeuxpgd+NS/rPFP0oR
         DfBTO2B5jyw3fQ7eejD9McXbdl0XvaHFi0TLdhsDH1IiW6pcUzWaHrqOKyndCie4+CS6
         sDDN4neycXFDoVPVLzan4JvmHkQjWVc4u3b4OKLdB2bPEuOeLtsm/oXKUgnNJngck6ER
         KrfsIwTzyBbwj1v8UDG43yzM5grDC2FGtGlhRS+NptF0qRmzA8p9Ui4xSs0HR1/lpkS2
         Pk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zbj41rDY60k//Ojjdhy7kw5Fi+0XMvlW8sqapDemCE=;
        fh=a+lzqW8XSfm5Qc549sXfDVNEb9hksmI4X+nHKIkiH5o=;
        b=bClPgNsmxzQJhNBuiJiWjixpnTzmJHx6mv0z7TZYfouaLxwBP7wMo8diYjIxQlqYBh
         NV4gaPVbS1kzLg06ER0AleoU6tbnl8G9FiCefG9tNk7NyCvUda66nYQ7njy9gomAdufB
         HfDBv9pFQtbZAs3FuU3rnG+SkMVRlQr7UmHoBKBMHvlpQJs/eEq65t3hF9Qah8ILDa5f
         Q5Q8eBANsKQdiaNoXZHrRnG4T6Iu8BBFTZ5l0jzl5id3rCBts4Cz5K2LBaJSo89US4zf
         Qzv8mIIhNnGZmZDHMfxcKgboUCf65EjS1iqvDjLmLRHe+93uHI689MJdjQcfjqbuseIg
         0MKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790167932; x=1790772732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2zbj41rDY60k//Ojjdhy7kw5Fi+0XMvlW8sqapDemCE=;
        b=N4XdVXutgzanr5bZaOJmwMxZKxaj/3FeViNDHy0n6me/N4EPM5P/WSDn2dlPm32tIw
         claCAjqzzav7JtMTQGHVzkqF4MFKV8lyqJN4LURaLrde9o6dIl1oARXavWY86vxdIR+f
         MEQBwXq6o/+052JkZnGfkrh25MHAXVbbrgB2+siuUPYaxoAlmbX6K5OXfjfsFmWevErw
         Qs+HtXw3k/fN1SXff0MZIw+gomw0hXt5lqWJxCAWZQaGnfEfatRQ0nQfNaUZgVvyKbGl
         EHs7eMqvqmDT/PkdvqTvqmu4hzwz20Spst1Pgw+HRVe/QKN6SfEZ5gZkC8xExOuT2u5F
         9kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167932; x=1790772732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zbj41rDY60k//Ojjdhy7kw5Fi+0XMvlW8sqapDemCE=;
        b=IclFqLd/I9Vn+ZitUMQVcg37kc2kutO6dFg5/hatrp1CjFxDppKkcYsHVRH1zvxjw5
         SYXZzg1+HfsX6ddfp/RSh12dy78MNLun3JvwSjfiuputjviri027ipYAOsRMnKxg0eT/
         oPRovFHlAQM05xIZ/Xtj5UG3Oe7DZqGrZmHX5lbqrMS4DT6iCF+vyGthg1aycKPkVMNX
         tWCbfPJTTOS/+DsiGkPPv7I5AJ55eWSjFmV10tMV0Ok2vX3yoLuFD7B/dMf+9jGMtHFf
         4mef9TRC5jNVF8f8XY8uB/IG53ExmPd4fB9MvXZqNSB99vjOODY+eWyoe5sUfBoBykj6
         pmQw==
X-Forwarded-Encrypted: i=1; AKwUvBzJcN04KOC7XY1agZA8qvDxzTPw41JNrxkdyFbHMGJBEe9KiCK4FM+PK9PQPUGmjKW5PFU=@vger.kernel.org
X-Gm-Message-State: AFuF++kw6HuS/Y06g5LI2TuXakUg3fFZeIRqUGQipE+6NQcigg4Wh40M
	PB+xKvHVmDng1qWA9w+tABb8hKpvaVrQq3TBpu2yo1tq981V62u8UYo9zRf8C48SgfsxjZDmYoh
	Lmhr02/Lr7rl8JQ2HQ5nm99+tLj5Byb8=
X-Gm-Gg: AYBFou0ivcLjLwo8/foaiaVDSSzUvtQ+a8folV7FeaUvJJ49nvp3PMooclgLGDwbv5n
	fehVOv6GjjrvxWJ7O+KsH3YUSddiMV0N5q3dKpOyOUcv0w9fVB/6wDHvZmeV637h/TXxTC3VxcF
	dYULH7j9SIbJSE5E3x3qJnyTGKqJ18RZK4hi09zRkGzKAlNrMr9KHin/WFC7rytZfj4Dl+gKGGa
	g+FKeC/FggLoUFSbXnVKvPjrNe0oLJGjWIX/V+fu7XFviHAgPVrf2dDU+fjDK/b5cuVNPKCLuP/
	GmGVpw+UJ5JzIYjKGsPNM/BDpnxu40TkepKLkIrbfaAqlQqT6cLFP2xwiIe3s2T0QimIT2R9Tyt
	HFius0m9qmxWx/F34KsLcfhHdH0OxKq9Ce+4Z5eu3lrdgHRFVBvqQ6sP/dlYF8/e02ZUZHhzOtE
	ZBCGLWUWV/BZtoZPbPQw==
X-Received: by 2002:a17:903:2f8a:b0:2dd:c100:80bc with SMTP id
 d9443c01a7336-2df69e1d69emr21710695ad.55.1790167932174; Wed, 23 Sep 2026
 05:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwlsei1pv.fsf@gitster.g> <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
 <xmqq4ifhgzvx.fsf@gitster.g> <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
In-Reply-To: <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 23 Sep 2026 08:52:01 -0400
X-Gm-Features: AcwNN1X_rFkSo6nfLXpeg_NsJWkkd1GcqW1YYoZfkOgNRqpCxii7rH0_RT4MhZc
Message-ID: <CALnO6CDTeOHzudAMx=Zbg26_PXY2WAYw+kG6Mr9pyU0rJXMReQ@mail.gmail.com>
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:45=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> I originally wrote this summary of the Git Contributor Summit only for my
> own records, but since you hinted at wanting some meeting notes, figured
> it might be interesting to other people, too. So here goes my distillatio=
n
> of the breakout-sessions from this year's Contributors' Summit. Many of
> these ideas still need discussion on the list; proposals below are not
> project-wide decisions.

Thanks for this!


> Git v3.0
>
> The proposed target is spring 2027: v2.56 in September 2026, v2.98 in
> December, then v2.99 and v3.0 next spring. The jump in version numbers is
> intended to signal the approaching breaking changes. March and April were
> both mentioned; the precise timing is not settled.
>
> There was agreement on releasing v2.99.1 and v3.0 together, differing onl=
y
> in the BREAKING_CHANGES (v3.0 switches them on). That keeps the transitio=
n
> separate from another round of feature development. Nobody in the room
> objected to Rust becoming mandatory in v3.0. (Personal note: probably
> because Randall wasn't there, to say that NonStop support would be a
> blocker and that Git please wait.) A v2.x LTS remains an open question,
> with Gentoo mentioned as an interested party. (Personal note: I am still
> advocating for an in-tree Long Term Support branch, and since Junio
> indicated that he's less than eager to take care of that, I would love fo=
r
> Patrick Steinhardt to be the "LTS lieutenant", I vaguely remember that he
> said he'd do it if asked, and I trust his judgement, so I'd ask.)

If you are able/willing to point me towards the [relevant] Gentoo
folks, I'd love to chat
with them. It's been my distribution of choice for the last year and, while=
 I've
helped some on the "packaging Git" side, I have to imagine the 2.x request =
comes
more from thinking about the surrounding things Git is used for (both devel=
oping
the system and running it, such as the 3rd-party repository syncs or live
package installs that use Git).

Anyway, I'd like to help them out :)

> Documentation
>
> Julia's work highlights the gap between documentation written by people
> who know Git inside out and users who do not yet know what objects, the
> index, or upstream mean. We need approachable learning material as well a=
s
> reference documentation. Both need work; keeping manpages concise does no=
t
> mean they cannot have better explanations and examples. (Personal note: I
> am beyond excited that Julia, whose work I have always admired, got
> interested in improving Git's documentation, which is in dear need of
> being improved, mainly because it does not cater to the majority of Git
> users out there who are unlikely to wander onto the Git mailing list,
> ever. I just hope that old-timers who really do not need the documentatio=
n
> nor understand the need of those who do need it show enough appreciation
> for the fresh views and for Julia's understanding of the target audience.=
)

Don't forget that Julia received a grant to continue working on docs!

https://www.sovereign.tech/news/meet-the-2026-sovereign-tech-fellows

> Protocol v2 for pushes

Did I understand correctly from a recent discussion that v2 also requires m=
ore
"setup" and is thus not easy to use for smaller "local" hosts? If so, makin=
g it
more accessible might also be nice.

> I am still a fan of the idea to have more frequent, smaller, virtual
> Contributor Summits, organized by a rotating cast. (Maybe I can get Emily=
 to
> host the next one.)

In other projects I've participated in, more frequent smaller check-ins hav=
e
been helpful. It also feels less icky to miss one for whatever reason, sinc=
e the
next one is not too far off!

--=20
D. Ben Knoble
