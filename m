Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF261370AE6
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209604; cv=pass; b=acrbULqHpm1O0g/QT+s1wyr95K2nNLBW919dARwh83bCIETD78bEU1gCQWSMAUaPA8BAeWUbp8L3oqFdf2mpySckwQvRPhyjfiU0FgqeAUPLCk71XLnxn/rqlaypSs3OV+zxAokdo1jojxspX//npA+PNfCbrPXU+RJYUZSG91Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209604; c=relaxed/simple;
	bh=qHIE1FHnhGkTUsqsjuCgMGy023C+xevkaKZ22nSEhMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8LBHLErCabDGgW9GqqaLw2v3pRWQ2cLB+ow30UG6S944fi/3tFOnEiP2ifpoTf7TqJ0c3S7BLCGBid/amtqpN/tASGHbYgv2yyvwrQLxqr86LIn6BQ7D8mE1dUU92QejFbEhTXJlAJJxzQHn+pGgxsJSEOR+a9Xa1dww58AQLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=GjHZeB3U; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="GjHZeB3U"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66310a69f65so3279310d50.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 03:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782209602; cv=none;
        d=google.com; s=arc-20240605;
        b=QsjD+TqmQxYyu2iJKVUBEcG7a0Fkg8Qae9Eli6Hg4IFykS+cjvNI5q9hkaytnGZo4i
         KADvKx268iTO5/qAob7prbXyT4nPLPBN+ZfxCPxqxlTLS+DC9onS8fthN/bCRtsQ2JbV
         Ixma/Yh5iVjv7ByjaDIn2w5aXd3wRIRApTtiKl+Z6xRbc4ER67AMlmH4u4WttyvZbMoN
         ob/zDi5nW5Nc8NUrQrkWJE8ajHigBAOQa8gbcwYxn3QcZxvJc+iFvcREJq673sJdyk+L
         PVvQhIEGjxUGa/ybmrx4J/I2QHF1LmVUymOmF0RRrve98QsFbnCV5xwvbR5eNl4Iy/or
         1yOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EvHiPy1udRxDQ1Chls+7JNAYfXOHq9dl1x4vzzvYMDI=;
        fh=fWSFuogQEoIeINmjIIWjh4LoFQey4NqSzym6SH8/2OU=;
        b=cFWiCW07oNbY2YEtyEqXOJloxqlA5Hp5y7qJrl+jxycHdzfNgipQhalzXY/VKZxesw
         jsGXCdqejigPR9VElEdPOCRmw11DEQIWIOotKQSKQsEDQZO+VZd45NvZX4W+D4nOvL0q
         XT8V6zjCNH7jT/IlpzkquVoSnafH+gNGl7kpGQzPcFdtQzcrGrf2fWA9Y8INA0miTGz/
         rPjeCcA94N58C4RF4priRbEuX1om4vNaqvozwmVEmLBt6T+gPgG6IM5UCEt4DPAS2HsY
         QDyFeY8xJwT2LgOrc3swqEhlydE3SVjlL7P8bCLlWVhZ1rRkxEdbkfm0b0z/8CUkRPbb
         oHaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782209602; x=1782814402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvHiPy1udRxDQ1Chls+7JNAYfXOHq9dl1x4vzzvYMDI=;
        b=GjHZeB3UQDMNUg1T7NG0oYXf7llRe1e49DP7m3jVIc1iJdUFKUVA6UdOmySI8PPAln
         CGxV053dtU46QBKvJ6JYoO2KClCfwAI8kB9jocF6ZQvSB2ZfdbOzJ6E1xeIYXcc77CXW
         vOd298oUb+CCfY4oIolaKFQ8Ktp+9ZadXVH9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209602; x=1782814402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvHiPy1udRxDQ1Chls+7JNAYfXOHq9dl1x4vzzvYMDI=;
        b=RauWPB/1aDGDbyao2sMmpgR7DLTJZaswcizu6TR3ALJbIdb7EeLFJqnlwFled3+kmw
         c8czlBrW5QIpdGd9/ShHB7KzwLco01Hr7XHDmtwex7RCJ2zdUorCZsFsaYsIaOZdBadt
         /esw6TJcXgveJGRzICDWbozjxO3LAhBTwJdVOL1PC4KaYYuwSEiCX3m5xo/i70BLCkI2
         Wmk2mslGzpVBu4DpUVuzB8G1x2RfrzO1nZReYFgfSP+w6m+zFp6RPX7CBjkXrDmGJFsz
         Twimj33ujyV3NQuOtfYoLFXp6Aff5PpUs37XamXRPLleA5WNUTwZAP7ynrtzlJPnVagJ
         sK5g==
X-Forwarded-Encrypted: i=1; AHgh+RrZT9pZYuoQFQP4qOPTDo5qOD24mSY+oGLpFcFvJR8cKa/7zun6VxXADnMlaBujcnkRh94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMB9diBvc1xzXNVBeVieolFJ4CmdO9CC7nIA4OI/ZyonGyxgr
	umcPTBGJiYRs/r51G3hkzSzAAA4XpsqGamV5zUu4irf35Z9ZcIJgdNBWiSVgLBr1ItIIHCaSEIr
	6WLlUg5BRgBB3OAi0wW8JnapQKAfwjl6aAPwK3AaCwA==
X-Gm-Gg: AfdE7clmv3s1Anu51K2yYoCF9/IY0XBhcl23CcofAvrrl9uanA/csz+IWGKNVcE7pJT
	aM8Q7wZDOys4S2WNDjDXzzpFDwtnJRpSljckBKRNkijAfFNuI0wd5kbFJDcU237YP5bU4PFSv7s
	rClWfcnZfdgQcFCC7sKyADK9RbA3VTBsgru/JTQENsNiodydO6E4a8aIBwuJ4iymYmF52tn9zjT
	tT93cdY0vuJKEL/CY3yVyGq0Wrvf+QlOJKBUVAZdYlCVnTky/7NKo1XCa2buYZaTrTUWzbT+g==
X-Received: by 2002:a05:690e:14cf:b0:660:933d:3057 with SMTP id
 956f58d0204a3-66359b5f8a1mr1696374d50.0.1782209601548; Tue, 23 Jun 2026
 03:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
 <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com> <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
 <8d07f5a9-82fa-4aed-b407-363e659f6851@gmail.com>
In-Reply-To: <8d07f5a9-82fa-4aed-b407-363e659f6851@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 23 Jun 2026 12:13:10 +0200
X-Gm-Features: AVVi8Cdx0SrVQomsDPHIjy-o1I37YIabd1yX5Fj-TV1aDfFFqyRWyjCB8O28uWU
Message-ID: <CAL71e4NFHz_zVCWPvmTO8UPNyaKkDFqNQdd3CJykoiGmEhfUTA@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 22:23, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/22/2026 3:14 PM, Kristofer Karlsson wrote:
> >
> > On Mon, 22 Jun 2026 at 20:10, Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> When possible, I like to try to make loops only have one terminating
> >> condition. Should we have paint_queue_get() return NULL when it sees
> >> this internal state condition?
> >
> > Possibly, but that would couple the paint_queue struct very tightly with
> > the usage. Not a problem in practice since it only has one call site, and
> > it's unlikely that we want to add more of them but it may feel more natural
> > to let the paint_queue purely have the queue semantics and counters,
> > and keep the halt condition within the function itself. I don't feel
> > super-strongly about this and can change it if needed, I will just need to
> > verify that nothing else gets complex as a result, I have not fully thought
> > through the effects.
>
> Hm. Interesting. The coupling is perhaps expected, because the data
> structure tracks counts that don't otherwise need to be tracked.
> Maybe the terminating condition method could be descriptively named
> to say why it would be completing.
>

I have been working on v2 locally and most of the changes landed
nicely and were clear improvements but there's one point I would
want to discuss a bit more.

For the termination conditions, I moved them into paint_queue_get()
as you suggested.  The all-zero check was straightforward since it
only depends on the counters but the side-exhaustion check also
needs to know whether we have entered the finite-generation region,
so I pass last_gen (already a local in paint_down_to_common) as a
parameter:

  static struct commit *paint_queue_get(struct paint_state *state,
                                        timestamp_t last_gen)

Inside, the two conditions merge nicely under a shared guard:

  if (!state->pending_merge_bases) {
      if (!state->p1_count && !state->p2_count)
          return NULL;
      if (last_gen < GENERATION_NUMBER_INFINITY &&
          (!state->p1_count || !state->p2_count))
          return NULL;
  }

Both conditions require pending_merge_bases == 0, so the nesting
felt natural. The first is "nothing non-stale left" (works in any
region). The second is "one side exhausted" (only in the finite
region where topological ordering holds).

I think passing in last_gen into paint_queue_get() feels _slightly_
awkward but not too bad in practice.  However, we also have my
older (first) patch with the fast-exit if the caller only needs one
merge base -- that has a separate break that also could be folded
into paint_queue_get(). The messy part here is that we would need
to also pass the mb_flags parameter to paint_queue_get().

Perhaps we should just let this remain as-is for now and follow up
with _removing_ that optimization. I think the value of having it
is much diminished (but not fully gone) by the side-exhaust approach.

Additionally there's a correctness argument to be made -- perhaps
all callers _should_ care about multiple merge bases existing, and
instead bail out if it finds more than one. The only use case
where this matters today is "git merge-base A B" without --all.

Right now I am leaning towards simply passing in last_gen and
containing all of the halt conditions there
(except the old !FIND_ALL).

The nicest alternative I can think of is to let this part only
break when the queue is empty:

  while ((commit = paint_queue_get(&state)))

and then adding a logical halt-section at the end of the while-loop
(where all the useful variables we need are already available), and
we could logically think of that as an optimization section, never
strictly needed for correctness.

> I just worry about the idea that a negative number (or an addition
> overflow) would create conditions for termination that we did not
> intend. That's why using the nonzero status as true/false combined
> with ands and ors is better.

Good point, I have addressed that locally too.

Thanks,
Kristofer
