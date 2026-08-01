Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD66221F2F
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608390; cv=pass; b=DBPhZDXL/LbEacj+cvlcNgYT1LwkQyBtex32pxHsr9JWSNGVE8T/Hg82qniZvrnLjcsLEBce3RV6NCQhXjbDMzdzpwU/aasWJTShm4NCnvyzx6xw8+lnWIf5GUipHn04Mgv2z9hLP00AxyPPEEHBjV13LSLwsHL6IG7BPu5VfYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608390; c=relaxed/simple;
	bh=Sh0reZtr5HohfRfGfV/oj9uMZjKSGLEB0KYKzfW8DgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXnqA6m9+3sJ30yOON25igKt0nLy9lcUZPJRyVy0EzcNx9UoTL3lAvBGbOx27GHBdj21neuuyoA0WgZ2YGcsn6KegrtQud+FFkyP13g+f6cMggRGeXHQ/sU+0Jsto/iQlFAft4GI+sQsuGV3AANhHpXP3XKgTUJmI6TtmkRZx0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PobpntIc; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PobpntIc"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e507b079dso1480163b3a.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 11:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785608388; cv=none;
        d=google.com; s=arc-20260327;
        b=MjkyS6V5dqXhKuUCKT5aoG0zTy6lLbS37G3pSFaleAbpvKhtKVrapN3kAjo8FySdYU
         e6kM6lHQZGnoYRvdrRaaomqG9wd5LOIZWakt1pqsD4W5qEQCY3d+lb67sjB+Ri/vsarQ
         Wt1ydmTBpLgYWvBCg5zFOJU9HMWRoxyaVNNf8JaYX721dwLkbstB7+LjZNGbVphYfD4E
         phvkA5dyUcmrksmIdkhhUbGsL7M3l2eqnh4G08mFiVmvkeUX7Dpy4ETl71gJZdJThsEw
         nYd7RhsGavTRFJanPbeGPooU8dQ5dY6njcvNEjBeK+R1GE7CZgQxw4iwsyzQU1r1WbRy
         xN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uTzakTwHICEbk2q6mL3iL6sckMjOvriSAfN+wOI3VPs=;
        fh=y3V5UwWFAgYBdUKU8pgEnWKwjLkDM8nFOqclYH//408=;
        b=EQz7TRkN0E5umyyt/aJQDw/2qrbAndh1EJobsOpx5ZCnjGxUfiswqYExUwxIPOZJx9
         yWY+/q0AckB2/TAe4Hxd7wmLzLYuQvM7bA/fGPCzE/ehNJpoMg0nRAxdtMgi/GW8mZHc
         ss7hTVOmChNbCfnkeS2affQjCnkAdmDyudX3EbMVDghBgExPI4QJH9xOhV9VTGcUiM+u
         Z1u7hO+pO1oPlS8hIN2uj7HOCc2hjG4d7yDjWDweUVnyE+vkFkopFix6acIE+gTwShv3
         R8pK5Jbjaq+nrZb+Ct1SEjBXhe/zQ8jyO33y+R9tc/HwVMk8ei/EOY9LTX73rOg79Q1A
         /kcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785608388; x=1786213188; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTzakTwHICEbk2q6mL3iL6sckMjOvriSAfN+wOI3VPs=;
        b=PobpntIcfHnBjjnHgIADDeZWpdS3Y3Hkm5/yWuiDt7ufawssklzDuTDLC8N+tUfrZy
         s6juNuN9n/bwuYFsqBaFXpGDF9aKH3+q64WoRnfSlcC5Khp2qwhraO+D0rpzN+7oHemH
         HxZmymiIUtIuf5wAsABU1cDF/hAdtUfsxqMiNJqFUflVI/D9B1qrQCdkefCTY5RZNage
         2iuuAdXJ99xUTKIHZfaNV2rantR8Tx5ZcqK760qbh1eoVxc7TtgiUHe+4YqtfhF+Xbu1
         UoYxTkY1ECWR93/zVw/w2NQ5dF9rIjMVWNXktg0wd4d/jzlnsd+8NJaPtdq5ANBKoIud
         xGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785608388; x=1786213188;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uTzakTwHICEbk2q6mL3iL6sckMjOvriSAfN+wOI3VPs=;
        b=lwrz/dW64Elmd/0pxmoyxbQeOtUOXwTavbAXauYVZe9LkgDlrUA5grmyphd5a02dVl
         Gqj/DaYeTgECg5X7rWgvJUkwffTv9TavhwqCkoxfRV1oN/OZlZcndDJ7pz0DvG/Yz5GI
         z36bO1IRGbd5d+Q0axE990bAhPXK9FZCaT5h1MHtcmr60SBqrD9mSJyU0595AN32g2Rh
         zh8Q1th5IW79pD1/GyBsyQCvxogQ68fab06T78vN4sdVq36i5WPRAiV5md3faegK3T5r
         TqEZzj9Qb8dxZ6kMM21+M8OiEPnRj9Ddof+vV2m/zJoE98y/SvucAkrEB5Vk5lzdk7fC
         TuxQ==
X-Gm-Message-State: AOJu0YxaWJvvX/lp/XHmE4rFXkFoaUParGD9SvqG3835BqtLY53iB/Z6
	3/AcOZdgWS4z8DY2PEePM34DAkOkYrR3UBz4QayLnkeyW60rt9jrjErqsf/tfjKWjJZLdG428o7
	2kS4tmuR95Pmb5QUtteelD/qn0r7S3z4=
X-Gm-Gg: AR+sD125WUSRb6otrTIfz9yQtb1sfwuU/GOadTWeZ843xbTkRsApCxHonqTYADq16jZ
	JjfzWi0nfq2wPMKs8mG6MD30EojcAQHf9+Cl81+iWxRpjfEEbvXveg6C3kHCpscF9MVXDtdO/gW
	A2Cz6gMt6pvx5C6TyTfDkYL6s+I45ZGYGFixHx3/TK1+BeUTd3+73NKYknKgRXBlrtJvN9WbFwu
	FXAZy3nd4E2IDPTeEwqaqPvx5B96sD6n1E0kxBmt9EvJhjO/DOTRAnZ+u/HDUAoCzp0aD2LE0rV
	ky8I10pd12Se29gSjZyXZIPPdRlrflC6+5LCnQdoywQ69ZrhDDuNX74wZ9o/Tdi7q1bYrR6kGkp
	hRv4XX2hEscTYtgM+jM5MjkFQwj/ygQ==
X-Received: by 2002:a05:6a00:8d1:b0:847:9c06:2bef with SMTP id
 d2e1a72fcca58-84ee47f2c8fmr3448357b3a.29.1785608388200; Sat, 01 Aug 2026
 11:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com> <xmqqcxw3dvh5.fsf@gitster.g>
In-Reply-To: <xmqqcxw3dvh5.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sat, 1 Aug 2026 23:49:11 +0530
X-Gm-Features: AUfX_mwjGUvqsqr0dIyBjZ-1dcsy2xNnmZ15dWkjrYhR1e-mycFNbNSm7EKHPdk
Message-ID: <CAGWgyh8EPSufBZrk0xCqTr4gz6MtJHkfCy6JQKxCqKSPZ3gEgw@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 0/7] repack: add --drop-filtered to reclaim space
 in partial clones
To: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com
Cc: git@vger.kernel.org, me@ttaylorr.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de, ttaylorr@openai.com
Content-Type: text/plain; charset="UTF-8"

Hi,
thanks for the review Junio!

On Fri, 31 Jul 2026 at 21:04, Junio C Hamano <gitster@pobox.com> wrote:
> By 'by construction', do you mean 'It is guaranteed recoverable, as
> long as ODB_FOR_EACH_OBJECT_PROMISOR_ONLY is working correctly'?

yes, that is what I meant. the object is recoverable because it came from a
promisor pack (due to a .promisor file), so the remote has promised to
give it back.
"by construction" means "recoverable as long as the promisor-only walk correctly
picks out promisor objects".

> Since I do not use it, I do not personally trust promisor-based
> traversal all that much, and it would be great if we could hear from
> other practitioners that this really works well.

i'll also be glad to hear from people who actually use partial clone
about whether
leaning on the promisor-only walk here is a good idea for now, until the
remote-object-info side of the cat-file protocol lands, which would let us
verify against the remote directly.

> This is sensible, as long as this repacking is done only with
> locally available data, without dynamically pulling in lazy objects
> from the promisor (which would defeat the whole point ;-)).

right, i made sure of that :)
enumeration passes OBJECT_INFO_SKIP_FETCH_OBJECT on
every object-info lookup, so it never triggers a lazy fetch.
The rebuild is local too: it only repacks promisor objects that are
already present.
I confirmed this by tracing a real drop and by moving the promisor remote away
entirely before a drop, it still completed, so it clearly did not need
the remote

> Presumably, this rebuilding is done without an extra traversal,
> driven instead by the list of enumerated promisor objects we
> constructed above (excluding the unwanted ones)?

not quite, there are two walks right now. First,
enumerate_promisor_blobs() walks the
promisor objects to figure out what to drop. Then
repack_promisor_objects() does its own
promisor-only walk to rebuild the pack, skipping anything in that drop set.
so the rebuild does use the drop set, but through a second walk, not by directly
reusing the first list.

> I wonder whether size is the only criterion we would want to use
> when choosing what to discard among objects we know the promisor can
> give us on-demand.  It is, of course, perfectly fine to make it the
> only condition in this first effort, but it would help to imagine
> what other criteria we might want in the future and how they would
> fit into the framework you establish with this series.  Ensuring
> that the framework is easily extensible with a future set of rules
> will keep us from painting ourselves into a corner.

true, i agree..
size (blob:limit) is the only rule for now, but its easy to imagine others:
how old an object is or when it was last used, its path, its type, or whether
its still reachable from the current branch. The design should handle
those without
much trouble. Enumeration builds a set of promisor objects, and then one step
narrows that set down to what we actually drop.
Right now that step is just the blob:limit filter. A new rule would
plug in at the same spot,
narrowing the same set, so the overall "list them, then pick what to drop" shape
would not change

> I assume you do not mean a race where an operation wants to write a
> blob, finds that an identical one that came from the promisor remote
> already exists locally, refrains from writing another copy, and the
> drop-filtered operation removes the blob at the right moment.
> Rather, you likely have in mind an operation that stops, gives
> control back to the user, and, while the user ponders the situation,
> the drop-filtered operation kicks in and removes the blobs involved
> in the operation in progress.  Am I reading you correctly?

um yes, the case i had in mind is the second one: an operation stops halfway,
hands control back to the user, and drop-filtered runs in that gap and
removes blobs the paused operation was using

> Even in either of these situations, I do not quite see why the
> safeguards are necessary.  The operation completes, or stays stopped
> in the middle.  The user's next move (whether they issue a new
> command after completion or resume the interrupted operation) will
> automatically lazy-refetch what the drop-filtered operation
> discarded as needed, will it not?

yes, you got that right. Since the objects are promised, whatever gets dropped
will just be  lazy-refetched when the user runs the next command or resumes the
operation.
the guards avoid immediately re-downloading something we just dropped,
(which we can call as some wasted work : )), and a network fetch in
the middle of,
say, resolving a merge.
The index guard is the same story- the blob it protects would just be
re-fetched by
the next command anyway.
So they are a convenience to avoid pointless re-fetching, not a
correctness measure.
I am happy to drop them or keep them clearly documented as just that,
whichever the list prefers.

Thanks,
Siddharth Shrimali
