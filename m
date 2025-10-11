Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67296F9D9
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193877; cv=none; b=dwkiGCExn1p94OQkoYMSVcD4hcvhsQphNtzAMjngu010Rjd1XUFINje9YXuvlCkwxL7IOXOXyDp2hrazJGz+5nykVS6cNG7QD80TeSjhOd61R/UnGnizzbv5vDEI8NscnJ20Yz5SCmKZIpn3h4xdo7nl3CAmnICJCNWTT/DROl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193877; c=relaxed/simple;
	bh=JqWF8RMNBhEBuGnI6yZEINbjjm0ooCltdkDrLEkTC28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWhJNnUKMHhcMrBrtTYn6bJFc3mV4CdpESWvvIazUID2wZqoYWaWyH5YPqMCjXQkC/lOnWduMxXmlLjJRNLUvdhgv47GoEdEL3e/XBHNXGbpvrj1ziQ34bROq/I8Qum8x1J8h9TKInZJNfF9MJUG+TnXsmMp64mO+a7C0goPn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIMq80xV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIMq80xV"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-639df8d869fso5568166a12.0
        for <git@vger.kernel.org>; Sat, 11 Oct 2025 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760193874; x=1760798674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUVE6QUbfPBtTuv9suuSlrfXOnLo9iszzpL2D89hTZE=;
        b=aIMq80xVj5fzSzRXM8ADGDDzfwg6Z3Nhm1HYMLf9FknWMqbSUjRNyy8u4emLh8swqt
         l/v8ZTIzLQABYdtAqz+A0pWppFG10rvIYLsru9tYPUnuzlkVWJ995BT7Bf+V0vIZuBVc
         7wG7Q24QSX/Owv6xG7NL9afGRrbO7bDdnrAyZrkiQyDxmzgnu6O+0Ucc9TqB+RJiW48z
         ElTDV92V03/iCzuasLyfD+IZpau5Zf/VWFXzCqYP0g3bCcfpcQLAceYxq8xKRXryYWnF
         Xz/ZA+nLiq2zgbdKXN/b9L1Ty/hsYtPy3nbVReoz36ZyvrKBd6jK5oT6OGFsXohHsgnR
         xuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760193874; x=1760798674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUVE6QUbfPBtTuv9suuSlrfXOnLo9iszzpL2D89hTZE=;
        b=ngypCA/viQvmccge2L9b4pCdxU3G1EJ9L8vCJPvVPULBvSCFdxpGHibI837sCZTphE
         oTSC0LZ49lRp1JN7BaMJ46ZEiAvH4XqUkrub5XiZyfM7r9SpdoEsLUF2CgpVO0f92EQ9
         zSAyCA07CRzLRZUZUGV49J9cm1qNG8UKbCa050WoBsjZgonmUxC0KcEduXHNKe/Bdrz8
         h3Wj9T1HLJ1inE5eFK8FprKj1T1OWQ41ZcniDdHcpFmoNTHAp72yt+8cTfTwge1r6WzP
         aXfQPbEHn7Jh6xiv6HMLij4osdJOfh4ajYdSKFx15UtlH/hrEmt6KOfwwxzSEtr9L5xk
         8iBA==
X-Gm-Message-State: AOJu0YxV0urlU4GgQY2VNNLrgKtzkhfI5RUVrbYuU1sHM+a8J/YFa39B
	CR3MnWmohM8h1bKEzuyMGKr3qsqps9+n7Dg69lRWDWZ3trTqfqx0psbpcvazTeDhlGemOpHYlZA
	IKpnwZGWJ1paL9SKb0KAPg/zmtkR/gIQ=
X-Gm-Gg: ASbGnctDIARmML8ry/xkgmE0jsljxBRvaNOJk89KBP/ckowcDIDXjasTvGrIys1x0AH
	a5KadAvECgrNKJ/uspBX5qcX28OmJs2DMYLOUixp6FNC9mFrFPPqgzKeejA+TUi+7XgbhEqxjmx
	COmOeqc1+I2WVKTiEyAq7o5fvW3ySTVEKWxfB3JARR8NcglKBGA8RrvzEkO2yvanj5t430hOeKh
	ZNRHS0LTtc7MK7cC+Ww35dW5HY=
X-Google-Smtp-Source: AGHT+IEBh6VLoDHh3cjCiof0Cky/oqRTuNLN+2yc0kWfT1qJhDpGtGB4yWdlazfAPRqpSWh5xC+4tleiLVTuGMHnbGk=
X-Received: by 2002:a17:907:96a7:b0:b40:b6a9:f6f9 with SMTP id
 a640c23a62f3a-b50aa8a847emr1655918366b.19.1760193873508; Sat, 11 Oct 2025
 07:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b36d2dbf-7cf4-46cd-81bb-b502e0eed380@gmail.com>
 <d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.knoble+github@gmail.com>
 <e77d07d0-c26e-4d91-9777-ebaffffd764c@app.fastmail.com>
In-Reply-To: <e77d07d0-c26e-4d91-9777-ebaffffd764c@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sat, 11 Oct 2025 10:44:22 -0400
X-Gm-Features: AS18NWD6jw8COr-wGQcP1v_pJy9EdC5sDuyxQL_bxwaw7Yel1Me5z8jdQV546vI
Message-ID: <CALnO6CA0SEGrzsrS_yqZ3Ztep0Gi=zPFjjGzSW94EvDW8RZ2Bg@mail.gmail.com>
Subject: Re: [PATCH] doc: explain the impact of stash.index on --autostash options
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Glen Choo <glencbz@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Denton Liu <liu.denton@gmail.com>, motisd8@gmail.com, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 6:55=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> This follow-up patch makes sense.
>
> =E2=80=A2 It reads like a logical continuation of the previous commit 984=
2c0c749
> =E2=80=A2 The log message is clear (and with no spelling mistakes)
> =E2=80=A2 The markup is correct (list continuation, links)
> =E2=80=A2 `make lint-docs` passes
> =E2=80=A2 `./ci/check-whitespace.sh @^` passes
>
> On Mon, Oct 6, 2025, at 14:59, D. Ben Knoble wrote:
> > With 9842c0c749 (stash: honor stash.index in apply, pop modes,
> > 2025-09-21)
>
> Curiously, since this is also the base commit, referring to =E2=80=9Cthe
> previous commit=E2=80=9D would also work if this patch is indeed applied =
on top
> of that one. But maybe that contextual reference is a bad idea?

Generally I think so, but that's just my preference. Once commits have
stable reference points, I'd rather use that. But I'm not attached to
this one, so if we end up re-rolling, I can adjust either way.

> > merged in a5d4779e6e (Merge branch 'dk/stash-apply-index',
> > 2025-09-29),
>
> This is over-specified IMO. Like mentioned this patch could be applied
> on top of commit 9842c0c749. Then that merge commit will not be
> reachable from this resulting commit.
>
> I also don=E2=80=99t see the point of mentioning when things were merged =
in in
> the commit message.

Indeed. I think I wanted to call out the topic branch this was part
of, especially since my understanding of the process of queueing
patches on top of in-flight topics is shaky from parts of
Documentation/SubmittingPatches and =E2=80=A6/howto/maintain-git:

 * A topic already in 'next' can get fixes while still in
   'next'.  Such a topic will have many merges to 'next' (in
   other words, "git log --first-parent next" will show many
   "Merge branch 'ai/topic' to next" for the same topic.

So, idk. If the eventual merge to master won't have the prior "topic
merge," it's probably important to omit (since the final topology of
master won't contain the referenced commit). In this case, since that
merge _is_ part of master, it seemed worth explaining what topic we
were improving.

> > diff --git a/Documentation/config/stash.adoc b/Documentation/config/sta=
sh.adoc
> > index e556105a15..fcb9a4a7a0 100644
> > --- a/Documentation/config/stash.adoc
> > +++ b/Documentation/config/stash.adoc
> > @@ -2,6 +2,10 @@ stash.index::
> >       If this is set to true, `git stash apply` and `git stash pop` wil=
l
> >       behave as if `--index` was supplied. Defaults to false. See the
> >       descriptions in linkgit:git-stash[1].
> > ++
> > +This also affects invocations of linkgit:git-stash[1] via `--autostash=
` from
> > +commands like linkgit:git-merge[1], linkgit:git-rebase[1], and
> > +linkgit:git-pull[1].
>
> According to these
>
> =E2=80=A2 `git grep -- --autostash`
> =E2=80=A2 `git grep merge-options.adoc`
>
> This text exhaustively covers all commands which have this option.
>
> ... which might mean that =E2=80=9Clike=E2=80=9D is an unneeded hedge? (i=
t=E2=80=99s probably
> not intended to be a hedge)

Indeed. I'm not sure where autostash might be introduced in the future
(git-history?), so it might be more "hedge" by way of "listing
examples" than necessary.

I could go either way on all of this, so will defer to guidance from
others (but don't have the impetus to rewrite without a strong opinion
at the moment).
