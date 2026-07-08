Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D153C0633
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508414; cv=pass; b=OLH3FGb2P+5/EKiZgOJypkxArmsoTfJ+1I9L4XuEg/5fc7ph9Wb3bFitFAipIRNeOEIuH+p5TwRjZ6gD/wjZMLysvQz1dHXpyw7yPNQSVtKHmEO3MppZ6b3UOxEv2Q0GI/xpDYd7dQtB7z2YlMtO6GdIyU/SOPSdjj50cZVOI80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508414; c=relaxed/simple;
	bh=DKGt8GuIjZInKeKJ55cTvBvvSW/vxcms5axr2/3nawY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiKEqjkoJxdnF/v1x6/9WV3ZJ07OzpjfrDx4g6ue/X6rN9iMmRJrOtQ9St+Kxk2766rkClCx4I0nKgrqJ3vwIGKJofhM1q+6pTrXaVtNw4uVRKyjtRaS6yBBU2NsGVRYtKKPEw9tPiSZ4FNkU3LyPh9TO9JtgTn0oOb5d+/EJDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=RLSHiOGo; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="RLSHiOGo"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664d4478a64so642454d50.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 04:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783508408; cv=none;
        d=google.com; s=arc-20260327;
        b=Ugvpdl6Q+OaR7+Og5krgIkbjFA01d6gdKDKq8yoF5lkstdxUAQg6vkFTuVcW3ZUC3I
         ESfUyxhBELOg9IzY+RlpNwtCrP8kGdOeBrXJF1rtna2FDxr7woVS7czSi53Lk5iVbDla
         mNOkpvula5Mw8JrRQHPsJA7A1Yk0HWfQovnB5RMpwcSAshdIO7miCyLW1oIM/U0hG6bT
         gJMvPP+MrnO1Xi3xSC98NN2hX7uT6wnhAZZQTTENfYXEjON0IRNrvuH0WLePAPCqfgrP
         viH9D26TxPNVFomjfW4Vcde3KxZm7NrawSEOryrn/y/3/QScoZWVX10PEDk6Bb4CkIvr
         rCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H9YnkcLtgUrGkvi0T/Ee1WHWxtm9zBKpFA9ZpcipbNg=;
        fh=kGGpqh7vjVEL9//zHKhWhNOYPgfdVyUHyORUJcxvQYA=;
        b=USfdyBykMAEzTAMH9xZJnRZ4Uy3IkylwRkSHPYLkx3LpLW7uhGP2HQxrABQIxzzMu9
         saSW9ext0HToVA18rEw+o6DEPsOw3FwLCvddlaUllehpt/ZYDeqgiZbnJMZFrRpH2lCY
         IK8xAOeOw9Hfs/5mZOnIi80llxqClkeBhwyymMchEDANDYsZ4y1w56WyDEO6fIT3FLJO
         0BcswpWzxpC0byF2dn7xuUFGCrGoZt2Lyk6Vw+nqViAo9WVx8glg1jMUiu7/kGMWjJsq
         4WU97TfIcyjtiKqq7bPBRArJo/Ybuu8yle3YnF/wbVakNl16nUbNO9SLJEDg0nQoxHv8
         NAVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783508408; x=1784113208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9YnkcLtgUrGkvi0T/Ee1WHWxtm9zBKpFA9ZpcipbNg=;
        b=RLSHiOGoUL76ZIYUY31wfLq+Qz8MsJQgVzxoYeFCxGIdcN4/wFmocLUNUugT1bpUii
         jR1G3hmo6EYGcs0GQJbBrqDPaRD8BrJplHcHMMHXP+quYQN7BFTfb6KKeWkgZ1NslEq+
         bsnDt6ROYl2w48Lvl/iHsevsFkexI4iobEZcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508408; x=1784113208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9YnkcLtgUrGkvi0T/Ee1WHWxtm9zBKpFA9ZpcipbNg=;
        b=Xy6tdMVLfzwGrwrcikClqlOz7HCZ1zwqlgRwhpsLULTdgww38p82OpQk5RGIZZWYcG
         NjGiOCJw4+inpjHsPID+E+3wEMTEIqKAes9Y8TiEP2ojr8rg9h384+CpGujQ4iuEnvQr
         LrlTJrFHSP585MyxrJQhKlKKb//GGYe5A8Rvnve1qfJI6dKG8mqoe0KZf8Ss8DvTImsH
         WfeqZOV/I2TxSH6lrtnJbcjaqy2KdyFDDUaTGiMv/KiYdHnArDWRxc4+t4ZTTSe1tUlC
         pgcYATt4heK6SQGPPM5MIn03YEU4vgSzzcPkCI0RW+9bk07R/pmNzcX7IPOjzSnHdYrS
         Z3Tw==
X-Forwarded-Encrypted: i=1; AHgh+RpNNiHXACV7ih1AL5yQneT0nKbhrMS61eg/fmE1EKtWxLQVVQhabGHRwIr5s0ltqw8vsAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BvSdxns/iSl2shBCJF2aNGyRm3wDElWR8u1xbAjzA2+pULW/
	db+EIqd36880glUDO63Y0K0/pWk73oQzTgdziWnqGJ2TSgHw4JeVlkU+lZQiCWjHlTkoAaCY0b9
	9FWpuXqBZHmaasqrNscjJbDrxSNGls5P4Y4VBXhwIXw==
X-Gm-Gg: AfdE7cnsJ+fVzTAKFZbQnP5byaIixVBGZAK0PKs/aGgXDyh7wH/pa9hIAF4Qkk0S+PS
	aCQjH8RqJGkrbdeac5cGitwqLbNrvSHSOAML9UGSIoDah7OF4Bgba8hc4NL7lC7DulGFbp5SZXj
	SPoozToMcUbQcb+54SIRoCWHs9BEW9PvK2nXKFrKYwX1dhfZr3qvdP3siDareZTku6WaOQ9irf4
	mc1dmICWPkVrA5CA+JwnFJIAT/jqbNXmtZHiIiCozIUDifsgR04xvNCVa0Xx2GkW/JUcRU21A==
X-Received: by 2002:a53:b00b:0:b0:667:8b91:2425 with SMTP id
 956f58d0204a3-6679f26f8cdmr1125223d50.108.1783508407796; Wed, 08 Jul 2026
 04:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com> <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
 <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de> <CAL71e4NZYdpw5cvi6ARn1req8xaRGGg9X4xhZKp6S9Dz4K23aQ@mail.gmail.com>
 <57bb0e9e-221d-4234-b5bc-a87610e8263c@web.de>
In-Reply-To: <57bb0e9e-221d-4234-b5bc-a87610e8263c@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 8 Jul 2026 12:59:56 +0200
X-Gm-Features: AVVi8Ceid1pnEE0EHFM8HaDB1wFqQyVUM4lBwDofy5ubHFX920n05CK2XIyUi6U
Message-ID: <CAL71e4NiSSRgxO_L7vb5=ohnchOCvuhEZwMc0Ls+Xu-Q+YytDg@mail.gmail.com>
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jul 2026 at 12:44, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> tl;dr: Yes, please, but I'm biased.
>
> The text size of prio-queue.o on Apple silicon increases from 1351 to
> 1563 bytes for me, 212 bytes or 16% more.  OK.
>
> It makes intuitive sense to find the new position of the last item by
> searching from the bottom up instead of from the top down.  Timings
> confirm it.  Are there pathologic cases that perform worse, though?  I
> don't see how to construct one.  It would require an unbalanced heap,
> where the bottom items from one branch would rise high in other
> branches.  Is this even possible?

Agreed, I also struggle to come up with such a case. Perhaps
theoretically possible to construct, but would not invalidate
the general heuristic?

> For a full drain (only _get(), no _put()) of up to 12 items the answer
> is no, at least.  Cascade never needs more comparisons for any
> permutation; test code below.  Here are the aggregate numbers:
>
>        next           cascade
>     n  min max  mean  min max  mean
>     2    0   0   0.0    0   0   0.0
>     3    1   1   1.0    1   1   1.0
>     4    3   3   3.0    3   3   3.0
>     5    5   6   5.8    5   6   5.6
>     6    7  10   8.7    7   9   8.0
>     7   10  14  12.0    9  12  10.9
>     8   14  18  16.3   12  16  13.9
>     9   18  23  20.9   15  20  17.4
>    10   22  29  25.5   18  24  20.7
>    11   26  35  30.5   21  28  24.4
>    12   30  41  35.5   24  33  27.9

I am sincerely grateful that you took the time to analyze it
to this level of detail. Very nice analysis and data!

> sift_up_rebalance() is a combination of sift_down_root() with an empty
> root and the bubble-up operation from prio_queue_put().  The latter can
> easily be factored out into a sift-up function, reducing code
> duplication.

Good point! I am not sure how messy this gets in practice, but I
will see if I can implement this split for the next patch.

> Extending sift_down_root() to deal with an empty root would be easy as
> well, but also a bit tricky to avoid pointless checks for each caller.
> Not sure it's worth it.  Like this perhaps?
>
> static inline size_t sift_down_root(struct prio_queue *queue, bool empty)
> {
>         size_t ix, child;
>
>         /* Push down the one at the root */
>         for (ix =3D 0; ix * 2 + 1 < queue->nr_; ix =3D child) {
>                 child =3D ix * 2 + 1; /* left */
>                 if (child + 1 < queue->nr_ &&
>                     compare(queue, child, child + 1) >=3D 0)
>                         child++; /* use right child */
>
>                 if (empty)
>                         queue->array[ix] =3D queue->array[child];
>                 else if (compare(queue, ix, child) <=3D 0)
>                         break;
>                 else
>                         swap(queue, child, ix);
>         }
>         return ix;
> }

Yes, something like that would work, but I agree -- ideally we
could have something that's even nicer and avoids the boolean flag
for split behavior.

> Anyway, my point is that it's not "adding another sift function", but
> remixing existing ones, which I only count as half. :)
>
> I'd very much like to see this go in because it seems to be strictly
> faster, makes intuitive sense and adds only little code.   I didn't
> find this method used anywhere else, which is a warning sign, but I
> can't find any catch.

Thanks, I think that is enough motivation for me to at least attempt
another version and then it will be easier to reason about dropping
or keeping.

I am not sure why it's a warning sign to have no other usages,
especially when it's a file local static function. I guess it could
be inlined instead (though I would not prefer that).

Thanks for the very thorough and insightful review,
Kristofer
