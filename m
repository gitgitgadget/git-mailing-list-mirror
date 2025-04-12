Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0948134BD
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744450165; cv=none; b=RtuiK2ZJtic74aVXnRcj+d/d3E/3gaU9+KeVBCjPfeii1hsLzZTZndvi4G6p4+3u1pNIeUmdMfzsTnf/nMP/v7xDoLgPFAD1ANceXuVArYe/GlimzLAdtigx6ov4WagOZz1jxA3F7M4gHzQRHKAnm/S8DOCFNn+lgZ7srb5SzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744450165; c=relaxed/simple;
	bh=hyuRTHbtFnJetgSpcjNl+ICXYS7TcVsVVbnoqnbKvbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8IIS+Kkfs2jK2EPt+x3fJut8pnV/HV5rxmXhSQ1leNRPzPp5GcR7ZrRT7oeDfKRdGrdZtsbCR2dpFWHaUKXjnd27BcgCCuPKyibt4UICOrBP8TcGJKpuvQuT4WJKUrF4H/+s4On1KAEohty1IFdxkz17tz4zTOCX7ULOI8y3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVGuU7R6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVGuU7R6"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476ab588f32so38871981cf.2
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744450162; x=1745054962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUpZAUNcdjfzyu7AzIA0LHL7ev/Nj48p1FOGmN6pwys=;
        b=WVGuU7R6yMGx7ACImNtJxSGo91zFmFjUPZKJ9tM9laiJZOSi8KzVgzCvaUe0BiLAWj
         W1F0ZsCfxBvgIxDr0P9CG6wD2EudPoo/dJFrtPj0rdJlkstl3vZ8MWooIoz+4w5UqFsJ
         xxGwl2TnHjqD4Dk61mLZf01+Wl4nqSGhXuc+LLr4BcAgUsdE/+G2BJhN2RB1k2PQpwon
         Na1Y4HYg41CL7k/UaXQVznhqtHlwPKXJAmXVgO4y03Oqm7sKlDt2hPaC4tBklSHRsVd5
         FUGWvmTQqFzNoxRzOXnKIBoXYTlzz5Oj2CHJC3PGVOFc/8/Jre5JTAeYXOYfpii3D5si
         iaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744450162; x=1745054962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUpZAUNcdjfzyu7AzIA0LHL7ev/Nj48p1FOGmN6pwys=;
        b=Zs34NP+oF2wfSGCOTWlI87WI2yHRGu7pih1TXSbACseN2xvHy2cnzDp1jZ6oVEse9P
         IjxVLmAQaUM5oHJeEwXFn1gcjiiaq1rAEYHK9Dh9Py2rLuCpZMHzdK85g/y3EFw5dsbr
         sMErHcpc2NMAA2/IfTQjmrvj4/VutsbPTj7QWmmpPKqewsZwjhT1XIE9lgDakfYMHgVX
         r08q4V+Rrcit3l2pW3IWgho7jJYKQ2UsPaUJ4tcmy2ZDUAxjtAgGu7Ekqfdldpgyd70D
         pUJMCVm9TnAOWa3SgCNEZ1YBWLj6fZF9c0fWoqpDtoThD+wQKkqFLwGx6+RldsgmFQNX
         JFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuGnpTX3oyPZ2xL0Y16oWf49/DfVkGcrw8POxdLDPovzzNXU7S8pA6YY0Kg8jdg8wwFQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT74AAP4MMl1+8NYuyElQHcfXBJ/QXLs1IcJ4m7gy+79ITQ91P
	D77sJ/fLJKm/rEB7FP4FJUV5neX84Y8cGgXGEWncOcf8Bsmwjcs0PfiLLRZmwZa3Wf6XUGt8NYk
	RiYXm5WWsspag/gVoswEXnCKMWTs=
X-Gm-Gg: ASbGncvwIqOxkL4mTL/TiLQl4gFrpLHzaeJiKsOXplJw1KgH1xzL0/qEkGBPyISWg+h
	5s+CtYtRZ4XUZJTMmMLWJVpU8mRNE0sVdW8ZFD/W602JQTNm63bU1VJsmFieDm2Yt7uQLkuzJHc
	RrlBY1FKXpCt1XmVHcdrYlaH3tZUmFaOVp+z4EuyU3PmYgX/bKUUpLSWQ=
X-Google-Smtp-Source: AGHT+IH54qsSoBrm6B8uMgGI61wNF5csuU7Bv+tHNzmpIdRJfcm+b5UFAVcfrtFN3ep+L5o4mAQBwtxA1O8VJaFOAz8=
X-Received: by 2002:ac8:5f51:0:b0:478:f00e:eed5 with SMTP id
 d75a77b69052e-479775e928amr80326311cf.48.1744450162315; Sat, 12 Apr 2025
 02:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM0=yBnaXojeC9WkHg08deR-VpjaVQwyrqt8mk+54qLXqSaAQ@mail.gmail.com>
 <20250412015748.7177-1-jayatheerthkulkarni2005@gmail.com> <CA+rGoLd-bSbaqfswD+qVrCv1fvG69QX+3BO1htbPJtinFkEQAA@mail.gmail.com>
 <20250412062753.GA3763415@coredump.intra.peff.net>
In-Reply-To: <20250412062753.GA3763415@coredump.intra.peff.net>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 12 Apr 2025 14:59:11 +0530
X-Gm-Features: ATxdqUE1WIaOzdSME3BVkjd_PCVE0baz3FQWwHXUKwAQdZLJwSXG2uznFjR1bBY
Message-ID: <CA+rGoLe=A61CRNUztHvDpPTUxW1TobS4vknyF3OGTEP0imnwjQ@mail.gmail.com>
Subject: Re: Bug: Git sometimes disregards wildcards in pathspecs if a file
 name matches exactly
To: Jeff King <peff@peff.net>
Cc: piotrsiupa@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 11:57=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Sat, Apr 12, 2025 at 08:30:00AM +0530, JAYATHEERTH K wrote:
>
> > Upon a much closer look into the Git source code, specifically
> > init_pathspec_item within pathspec.c, my previous hypothesis regarding
> > the optimization check in do_match_pathspec appears to be incorrect,
> > or at least not the root cause.
>
> I think you're still on the right track, but are just mis-interpreting
> the item->magic field. It's about user-specified "magic" flags, one of
> which is "treat this pathspec like a glob, even if the default (or an
> earlier "literal" magic flag) would tell you not to do so".
>

Ok that makes a lot of sense I was actually tweaking around with
has_wildcard but was confused with the chronology in cmd_add

> I don't think there is a bit flag in the pathspec item for "this item
> has glob meta characters". But we compute and record the offset of the
> first such character in the "nowildcard_len" field (which is for most
> cases much better, since we can optimize prefix matches for stuff like
> "foo/bar/*").
>
> And you can compare that to "len" to see if it does any globbing at all
> (which should also naturally handle stuff like ":(literal)" because we
> then mark the whole thing as "nowildcard").
>

Understood!! makes sense again.

> So something like this probably works:
>
> diff --git a/dir.c b/dir.c
> index cbd82be6c9..85cc08f4fc 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -519,7 +519,8 @@ static int do_match_pathspec(struct index_state *ista=
te,
>                     ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)=
))
>                         continue;
>
> -               if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
> +               if (seen && seen[i] =3D=3D MATCHED_EXACTLY &&
> +                   ps->items[i].nowildcard_len =3D=3D ps->items[i].len)
>                         continue;
>                 /*
>                  * Make exclude patterns optional and never report
>
> I think if you grep around for 'nowildcard_len =3D=3D' you'll find one or
> two similar spots.
>

I did and found this (nowildcard_len) in attr files after tracing it up!
Will send a patch in a new thread as soon as possible.


> -Peff

Thank you,
Jayatheerth
