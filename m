Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD442E8D0
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133558; cv=pass; b=FGFU5r309APhT68kpREXGiXbhTzFUlmo6bCC3DVJJna5y0QFxc40weuT3VO0F+NVpvWaDEVRkRLCcKAZSlCRjHxKU2+rAhhYzOL93BuMeAaQEKM8b5Pm2aIbPU/Md0L+M4zc9Domf2RCLZSgO18GrarB+Gxy0odQd4BixVHvcjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133558; c=relaxed/simple;
	bh=RLlvhtNe4yLN5vIypiI4/a4dtUHojOCw2eRMGKS9bY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVER70p/CPKp+HDgfdRiFMBfXPgCKOqpkKLHMB14N6B8MLxEtk3kaRdwLFajTpPwzMYZg+M7H7rH5wG0gu7FHY5XowtN9OwTWoHApV2UWmjUjn8R5lxNSs1yYCl8jCeXVGo9rkJj0F2gNxrI2SzWXt/BgXwm3K1pjlG1FPDKLFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKRKY0Jd; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKRKY0Jd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so40266045ad.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 13:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786133553; cv=none;
        d=google.com; s=arc-20260327;
        b=iDOENRe/AYGBDY/uMT/nd5l3ryydgp55kkt0Vag6toLNlJ15Iq6HjKfvffoGdUwshS
         sFT0p7wp9gMHY4tt+RWHSLL8uJOfd4jz+nVxrkMIaJ6eVMZ7XRuZv/DEJMS3ltRrk95u
         N3HwNttFrjlE8nq4YSWZ7SvsFUVFWmIhhbeirH9zszNgA5sVh1y+2jOaQUskFZqwpx3T
         +gx2p7nLLdpZntepccdrW36CgrSEm9SsFtlWbCFqejM4Xxlfezq8Uu40roycsepdQvyP
         8rr6yY82qT7LBB2xA0zjmrbygp6OqQTcD+LKhxrzivSX9sJwzKNWYYZHwjXMeBCdL2ZM
         jY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OziulW1ndCjzgtaYqxi3x6MXKBTHolIjAZAcF6UgNhc=;
        fh=yuk30xaZd/QAqzU/pcMGNW/Dyvedn/xAhOKxTQzpzJU=;
        b=jyL/6d04NmLuyhJcCPKmPXk5Rs72O+4Qu/BcbiG4azQYLqAajKw8saXnLVXP8P2Sw6
         wHz/U/fcjcx1SdoWihQbHLLamDLIsh8ZPgDgWVkaTPTiyoCZWUpxZRLgTHQhmqsBenoq
         DWF4yJ4xCvvqIoW3v/AV/wl4NpBSpZy1rPa1powTGiCf6fxBtiDmZo/WFIs+9k3bvps6
         KuXzOVgRL7ssHlQlEqik9XRiVuEE4gzJNK51zXfpq6mAPMXODygQHXh4sCg5Ewxq8gm/
         93QXRUVwGWYomPTyKGEEZIF1XDh6wLU1TkAo9G3K/oLK8j0cVtfyN3UYKzXJ3D4kK7XU
         Oqsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786133553; x=1786738353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OziulW1ndCjzgtaYqxi3x6MXKBTHolIjAZAcF6UgNhc=;
        b=DKRKY0JdT1MUkRctWfrDJGsQJDYoqev9InAuhoLj1V5nL/ui3Zf3J7s8Vl5RnxU+HG
         1Q6QMiZhL8SYRTimPk0KyWWAXacAT6wTacVsPbclEh2GiemXtyMzSQ/OyIYskmCKzTk+
         60JkvoWqt7B5rhCfdwBVhiHljKJuA05ld4h1cmTasUz105cKitmJRF54LCy6GlMi4WvK
         pZuGegdxnVsbS0V9oPOzegGN2eXw3womNc8Bb8gk8INjbtRFZBg31HKx74zz+GenWbrc
         gs02j3GTYa3NAbCWWuCo90mXFZsqHup47gIs1fsd+aL4J0b55GyEgxp9pdM+JxzJmtBk
         b+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786133553; x=1786738353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OziulW1ndCjzgtaYqxi3x6MXKBTHolIjAZAcF6UgNhc=;
        b=rQQN56n5bjNEDyn2Ukbo8S7pPQI4SjzgvzVwh/rh1gem64YXQRjQA1vB4hJlZOonff
         dlVbhd87eEROg/oEtcBjKVoQYwoLoDQwyj72PiOWJScD771MhMUUYKqix20zrnb4qjU+
         EqE9cwEIvU+JxJXG4lcTvGcjgnVQfVGTIa/j+jszBVxaUkm9G1VSabnYiAygLArZKq/G
         WeEfyku1UzcdTIyXWxN2Xag986TMD406kMbB6NHszJCRYSu6RX3gLvMLH4moZrqOa2gF
         Xe9vFEaxaWm2weL4+bkWf2IoRgwjB9U9MQkx/dqa88IPDpce2+6VIed2di6Ke3pP0sbS
         vURw==
X-Gm-Message-State: AOJu0Yzy1Perxd3dyxr5rhB+iPwu0Y0OY6sg+bOqbOBkOdT+rYWCeHqd
	WTCltwD5kHpMJTv7x5GKJZ6DF+mFfYA+OBE91/tih5k9Txjid6+gnjFB2nZm7+s/7EyzLc8AGRw
	6HPb/nwoqwclEL7LyKNO1ZjRq75VtY7s=
X-Gm-Gg: AR+sD13c7GFh8ApCIpbc45oL6qDKcxBSx/IS6khtufPE8RZxtXKq2Wb58HMqN1/y3e+
	oTpBm+6Ucvr8nXHL/G8bD2ylQ7Ti9vVY5Ly/ynotGNNs/pvRBzSWipYmh4UuajZXNdxZupG25yI
	7t2CSOOPJ3fv3AGwkoqK6hhdSXLh7lS+5QtG/h4R3VxDPfetz/31NwnUdsY8xATKv3ceSbTI+hW
	ov/rsq7bU5e/SkaQH+Ccdr14Rzjt+6TELJ4CxDQi/8bRlr1UG91OgUKMJ35zGjadQ6GzNTr0tMd
	Zi8EJRV7eoSrAPguHqvyWqksRanpO8ghrI1HBavG4fu81xyH1ktdzdKwUSEO6HQRIH6Ck1m+iQ4
	BhKu7F+TZ7c69uUfp9ZmzvnGGXuaRMTdq/DqbF56Tuw+Z6O5g5+RtWckqc/S7jUbY8AEI13f1CT
	q+GOg6KQ6AihV6NONyDfo=
X-Received: by 2002:a17:903:3806:b0:2cc:8267:31b5 with SMTP id
 d9443c01a7336-2d2a8e941d5mr42672455ad.19.1786133553216; Fri, 07 Aug 2026
 13:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq8q6ih924.fsf@gitster.g> <CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
 <xmqqfr0qexps.fsf@gitster.g>
In-Reply-To: <xmqqfr0qexps.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 7 Aug 2026 16:12:21 -0400
X-Gm-Features: AUfX_mwAAkVpfa2IJLOTWFDcRPy3tdpsiTaTS03bXLdf7zR5xmeuGSpY09l5KNw
Message-ID: <CALnO6CAEbiwRyJD+Uk_Aq0gKy-XB1=9PmOUwW6itOMCr+mBmwg@mail.gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <christian.couder@gmail.com>, "schacon@gmail.com" <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > I raise this as the kind of interface we could learn from: emulating
> > it might be a bit heavier (a full TUI?), but is certainly more
> > convenient to use than the prompt-loop over hunks.
>
> Yes, the 'one hunk at a time' model was easy to implement and start
> using, but its limitations are apparent.  Users want to be able to
> jump around, starting in the middle and returning to the top later,
> for example.
>
> It is more or less orthogonal to the reason I started this
> discussion, though, which is that limiting the direction in which
> modifications flow restricts the workflow, burdens the user, and
> makes the process error-prone.
>
> When I see a hunk, I can immediately tell if it is one of three
> kinds (i.e., those we want to add, those we want to leave in the
> working tree, and those we want to discard from the working tree).
> But with 'git add -p' (especially with the original version of the
> feature, before the 'e' (edit) command was introduced), the third
> kind must be treated the same way as the second.  Then, after I am
> done with 'git add -p', I must go through the remaining hunks, sift
> them into two categories (those we want to keep in the working tree
> and those we want to discard), and run 'git checkout -p' to deal
> with the latter.
>
> We should be able to improve this workflow without deviating from
> the 'one hunk at a time' model.

Perhaps I emphasized the wrong attributes; what initially brought
Fugitive to mind is the fact that one set of commands move hunks
between staged, unstaged, and reverted.

Whether that's in a more complex interface or not, that seemed like
the thrust of what you were after.

--=20
D. Ben Knoble
