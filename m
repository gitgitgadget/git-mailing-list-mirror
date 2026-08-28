Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0883BED24
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902743; cv=pass; b=FRb5CyCtzx68irkja1alGldfpStu9KXgQNR39/QIb3FZOtpsFGqcePU51tgBP2AuQvixHO8F+90hTFIpiGRlA8sMPBzmqL1NW4JMJjaxF0MMskb/oubQKBtjP7qt+vwjX43CSPerHDmjgW3RTlJS1BfqS25sKcX9dHpXeppv4CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902743; c=relaxed/simple;
	bh=TydZAawOUuPtAnSH4vd3yoMhDTBFz7a15RAOjfIiMWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dtk9DMl258QFjtK5B3phfTZ+e7pwn1EDDI8mFm5rN22pkpFMOTDyd0qnQcnFvfM07ULr6xbbkgQh7oh5qyg3kul1m1FvY5zxEi1Cu8kW7O6+nkA/3DRD0cNnnnQHl+mU1rj0ySRzH/0lwdLY0w2cNu14hZzBLRSGqBD677yz/LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0Zy+0N6; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0Zy+0N6"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4ab70b882c5so712956b6e.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787902740; cv=none;
        d=google.com; s=arc-20260327;
        b=WpJKSxS9rNqJWMSRA1FZZFlRvO61coTxvQG+nhS4JXAJg9Q0Z+Yo0ENFdL/Eg/ta3g
         a4530uRvh7J/DxJgWQ22dSiavR2ed/kj69ko49AcWUybeFmgvKnF4n/Lbu6EBvOxh2I+
         4pT6bvJ5v4cTWlix/oWqEF23PwAsPZrTn8tA9Rs6Rca5yMbmHQPPb8mPev3hDLARCSWu
         Gqx6biXvVfVLsqnQ1YcBJy5ool336YnDJG0iHf5kNrC72c8JfJgaliziyHPlfv1BXKa/
         MUBHsI9APbq72+SWujUVPFbi4IvljyXyAM38yx8shZnLRlaXCAuTwg3aQ3oXOdZUkUML
         K5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+xINW8yvKCO7Y8zMJ7VHVV6joM/9IY6B1vM0WBUpc8c=;
        fh=icncnZY890ssC3a61rJeozZujtIl2bd/LJu6AbDbsMg=;
        b=JuB/htJgs0ZE7lvrYSrPduF+L8/xRDNMY0cw9HMUII2pHuOL8fBP6xskt1Nj7J7FlJ
         qe8K8VzIoBOEnYvEW8nV4snBQ7I8s9xQ3T2DdZLnLXsFWtknVZcdt17XKehRSBGzWWDb
         1EP2+V1VCl5XFjwkHqSNuOT8NMaNHWEKxHKEt9OvIUAHNZYVL6spzTCGkk3efUveXyib
         DTCh1rRkvegd+W/d2vQ07c+ocOf7RnGDgle1+8A6jdRYxzhkHlq9U+YoK4zC+hfdtADA
         Ckz8duSlrcmljJph6iegJDuHht9vuWENhwmm6kpDSDpe7/RiwpyDR07KApk30IcAgsk+
         tHyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787902740; x=1788507540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+xINW8yvKCO7Y8zMJ7VHVV6joM/9IY6B1vM0WBUpc8c=;
        b=I0Zy+0N6VWNQq77tNCaSK0wL1k5ULUPuHXeTwGx+yWQvDrDodCTWHveu/KA4Bb6hAd
         K5/u+RKe4zwpmC0XPY6zCBZeD/ChkiX1rvXe77UBntsl6IoqSygl5uWBb1HehIKXn78k
         oFlQDloJmbfAx5VurY23ffLOFDPQDjgub/6ACYz359fayMNkkjK3iDQR4MrVl7GXEvf1
         RRraN33fGNvLnsFrS0OvcvrYE1pnmKZpNTBof88apfyU3kAfRakLi9H0VFkuFGBX0hdT
         3mEsokOcHiwGviuEDaiymcOwf54kzBM4SuJ3Riwz2jslG7/cymCEBNKz0znqyfP9HViR
         74Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787902740; x=1788507540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xINW8yvKCO7Y8zMJ7VHVV6joM/9IY6B1vM0WBUpc8c=;
        b=afjGaxAQcC4kBdjGMUuhBgRmq1g5Qud4Qzi0NirzFhJLWbZJBS78c2pRcprMhQxz+w
         tVPpRj8hzh/OPKQK1nEXi8ii0iy8GOhHc2wZsTy4K+rvhBMm3/KAk7ab4W2yXv5jvZ0h
         64tLwoWuTyamLKkNtVlcj7+CaBjQ0QVJAy7kUmVqoW9M3sJEI78Db6k5/6x2oYpbvGqo
         FbeQF+vHkPC4CNAwqpClRNGvAmU/Kul8OQ6xZCHzU+ejNryguzhkFA7sl10KtRzlbw1k
         vvPxHBl/KPBZqtJyn1/cBv5Nx69odjjGlCu08Q8how1RBXA/JpMZ7GSkDKcqGl/p8eiC
         mUBg==
X-Forwarded-Encrypted: i=1; AHgh+RqlxQXcRoLlqis2CVAjWm8Jw1WAdAvLeguYHtqaRdIWkolHjuN1pPyXRq6Oe4a8b2OEQHM=@vger.kernel.org
X-Gm-Message-State: AFuF++ngJnFctsu35zeid1HDLWcCEEmIGDMyH8f2WJEpMsilBhVkXp8J
	RpkzC7k4TIN3RoJyQ/OGKeLCr3lUgrRF4I8LJ7iJk6aN0kxGl4+or+8mwt0n1UxCb8lkZD8FmDS
	ddHK7LxymsH4+gptQTR4202yZUJVeUuanPw==
X-Gm-Gg: AR+sD12vwc+a/Z4ppMecvXw8XdyaGTJ9XF+hMxyz49XBxxL46T4HPZLMV3nojDfHd7D
	mcmcWlq6VDOwn6zGr6JwGqaRxs0tHl95P5Uw+/Fr7u2vZepd7IL0dwBQ7vruP1XtKFwfkaW0Yk2
	jcQdtKfWKH1kf/YF0Rap6BGlIgFVa5nB2HyHLXQ8PRpVg8+GIaCqHAXKfUR4Lf9gEqMEFzZMIL+
	rpBeikB4WYRcEFMwDXwi7NyBKne6j5hdFbVOINf0iqp1BXpVR2FctBTctt9E5fA6Q4In5j0Yks2
	x6C97gdFK7N3RmbsUa6MZON+HJHjpU2QuosSV0nOVSBWm+uA7UcgL/6EtES3rAlhbgyNctadIwv
	zB5mXTth4wlNq2Y003TKt9jx8EBodL3aB8pgd/r5Hx8uJGCxP5zH+Qk0RiSiay2jH1fGhotk=
X-Received: by 2002:a05:6808:308f:b0:486:4892:d553 with SMTP id
 5614622812f47-4b397cbd1abmr5675654b6e.0.1787902740269; Fri, 28 Aug 2026
 00:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com> <65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
 <xmqq5x0vbjxd.fsf@gitster.g> <xmqq1pbjbj4x.fsf@gitster.g>
In-Reply-To: <xmqq1pbjbj4x.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Aug 2026 00:38:48 -0700
X-Gm-Features: AcwNN1XZ-kQedyInoYNeQ0PMJMOEVBQxxzlpNEk86IuLaAbIzOHJXpk6VkG3Zdg
Message-ID: <CABPp-BEtoN+zA=vyyEAgruNSy5SKWjTdVW=weDjbM8NcenRbGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] commit: reword the empty-commit rebase errors
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:52=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +                    die(_("cannot do a partial commit while resolving=
 a commit that became empty."));
> >
> > That is a mouthful.  It also is awkward to say "while resolving a commi=
t".
>
> This still stands, but I haven't come up with a better alternative yet.
>
> > More importantly, I am not sure if whence =3D=3D FROM_REBASE_PICK at
> > this point in the code flow is a sufficient sign to tell that we
> > were not just in the middle of a rebase, not just a rebase stopped
> > with _some_ conflict, but the way the rebase stopped was because a
> > step in rebase resulted in a commit that is no-op relative to the
> > previous commit.  What makes us certain that the rebase-pick is
> > empty?
>
> This confusion was because FROM_REBASE_PICK is a misleading name.
>
> sequencer_determine_whence() is the only place that declares the
> whence is FROM_REBASE_PICK, and it specifically checks if the
> rebase-head and cherry-pick-head are identical before yielding that
> value, so by definition we are dealing with an empty-pick situation.
>
> This came from 430b75f720 (commit: give correct advice for empty
> commit during a rebase, 2019-12-06); interestingly, the name of
> FROM_REBASE_PICK and is_from_rebase() seem to have confused even the
> originating commit ;-)  The lines in question
>
> +               else if (is_from_rebase(whence))
> +                       die(_("cannot do a partial commit during a rebase=
."));
>
> are from that commit, which wanted to "give correct advice for empty
> commit during a rebase".
>
> We may want to
>
>  * change the code that does whence =3D=3D FROM_REBASE_PICK to use
>    is_from_rebase(whence) everywhere (other than the implementation
>    of is_from_rebase() itself, of course).
>
>  * give FROM_REBASE_PICK and is_from_rebase() better names that
>    contain "empty" somewhere.
>
> to unconfuse me.

That really confused me too.  I figured my series was already growing
too quickly and decided to leave it out, but since it confused you as
well, I agree we should fix this up.  I'll add a preparatory patch in
v3.
