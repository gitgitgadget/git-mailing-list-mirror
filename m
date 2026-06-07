Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E804274B23
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780834054; cv=pass; b=k65dKV9Lr1RjE1hVJW+CJxy+cmS4V2VxN0pT67/8dhNQKhwQL+DtHpzO0Eg4CD5WCON+XDKzXrjMZd0DSKFF0EJ6eVNjcg2G53EP8sn/93WvG2QBCL4A3Q2FPnpk2/zdWpiqnR2VHpsgCOSZ+siphl3THqD989P+l6NauwtKZlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780834054; c=relaxed/simple;
	bh=nbj0iFDJaL6AQYZrIIqZnj52Yzav5hB63xGyZZ3hoY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xwa5itDqVcAqKEPBaSgt+3DndpcjA71BWFk5c7LmNGIaLjatJXpq+0dIfxBEN5o7eafRQ/DRuBUNs/tF/5ckN3y1m76KM4rB0tJU7PZu9IZU+lAysQHIxG8tgTfKNdfycXBxVFudo9Yx+4f1Gsha7CQ23RlrGh/wjLyswgLAscs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=WdHtz4+d; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="WdHtz4+d"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e1c3f47d78so36063857b3.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 05:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780834052; cv=none;
        d=google.com; s=arc-20240605;
        b=eJEODtt/UPFKW/9hu4ueMW0yskseETvw8msl02bR/NT4TOiCZJNr/I+S7036gyUSdd
         ZcELl6vUrKWDGcXIfBsW2ZGp7GTPYQUvkUheXsiA7V6GRJy66/L1uJtwCQkn+fxg0lcq
         7xir9mv4wc6jv0BL6yuhJR07mPMxPIYwt1ONEmWy0Gha2+FlxP++Mb3Iw/Sv5hmbXjO9
         U1+E6YAzjvxjWTG4eiY2jvFI3Ba0ipdgNzfukppcQ5imhy1LEMGnux18NBwZtsmMZUBe
         tpOGmwax5flPbRC2X6Pl3XakC+jb0MdsFs+8ckQG2t5WtyiaUuq/tmo/CzYnRcqbhvbI
         IQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KntTYll/w+5cTx4FGaniFRdfMIXPI/LETeGZ1Vxsn5s=;
        fh=krWvwUmQW5o/xNqImQsCqJrZGQBpbBdQMMFYRB8wcyM=;
        b=hI3lM9qqe+BMKO3omZSXyUGNlqbdSkCyr4Ciu1iz9s01TmNHoiN6LX8UWpWW8pdrXh
         miTWPjvmmGW/p6LuecU1/UEbW9lCO+faecJd6CujBEgDWbv9bifXsVZn6C1uDDxAOFkD
         SArr7dAw+2AeuL7y26KqaR1KmNS/Wv6BJLamfWL4rMt4c+pArfy3PBZ/j45Xes8DJA0X
         3OMAXJ0+7xnOr+smPIJTWJhY6pqYMBTA5wELdJ8dHuETazMIxsHKSh0TOwmACyevkpRi
         KA3rqJD9zMny47i/UnHjTs03BaMqxqj1CYWTIxsgI+rvPpfmHkclGF2t66jmqpcmPT2N
         a3WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1780834052; x=1781438852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KntTYll/w+5cTx4FGaniFRdfMIXPI/LETeGZ1Vxsn5s=;
        b=WdHtz4+dMzp6bFlDDUF/JGdfXyZxgoeoIBuz+nRGPnNXNMiZAqT7ME9dC9ExoCvZOg
         dDXqFhEAYwfUK0U0PRSS/ctsYshlsNaS/41qBRww4TVAlngMQHdUrn7SQMNsJY4NglbQ
         pE9DF2p5o/thLQDCnRGBPbWi4cup8Xc1uaueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780834052; x=1781438852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KntTYll/w+5cTx4FGaniFRdfMIXPI/LETeGZ1Vxsn5s=;
        b=cZXBM3L01N+fWfKxPY+JtLQqq4L+VkjW5M9OKZvuQsxb6JwCCeCYy2XbWdqeQi+Cnt
         OQXhBqo+qpDXCMFbd2J6WabqN4L+47jtZZBS2hrIfLb5c5kwuZ1LTkiRqJVm6wvjOmKs
         o/gkrcrX2JTUJ+a4XO+WF/qXrjwDdE6Eln4R7uNuX0kBX8gffoALfovIp6rLoc0BgC2F
         1xKvMnsSDrGCB2t64CKesmbYdEesp2yVBMIaoJ5EHK1pMPIDHJTbpmc/qLvzgw8kqJyN
         wXX3e5n/08at+MTA+bEvfuEpfNQq8jIMValhlsjQBlESSaj3teEip0kUB3RCtNyiKjLp
         jnTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tn6xJxPUbrGWafGgTokbkAtwyDQojI5SI2b/5o38J7GCPoZtedxyu/2MZmnvh+L0sR6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrYqm9eQxO8EeFiyPQs52tk1xjD95T00QhJVficfxN73l9uje
	u1D28cfQdbbaC1JlMWA48LSlccmu97nFqqvJrdrX+Hwnecn7dASJnpO8V2K4U1j3meb3AhZBarK
	tWXqBOtqSQNjUBFglA/2JmZa9Dd1K38AYHVwu7GAbLA==
X-Gm-Gg: Acq92OHI0bmtFftBtQUvVMXg1GFNzez7qMUMprqe7SfP7AN1S0e9oywsYE229l21OgP
	2uHUmP785Ua0rraw/fXAba/qX4b0VFgkSHlG9u/t4YMdEX344oGt0uaq2mhm15mWdhLPplXITqz
	4SLLsdI01RxEoSHyng40TuDUhIy55cukXkSuVw8E5OzCDnX1c+W1uSqtuXmVRa/Ye8OYYPqxMZB
	s4s4HuvqDoXaT7C548bcSA4vFF3NuemxXyacD/92EkG9811Af7LldQHGzeegZBAiOqI87StUrJs
	d6Zyw0R10alXQr9RCg==
X-Received: by 2002:a05:690c:6810:b0:7cf:f7be:f4fc with SMTP id
 00721157ae682-7ed0a4f2a62mr103713747b3.3.1780834052167; Sun, 07 Jun 2026
 05:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com> <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com> <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
In-Reply-To: <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 7 Jun 2026 14:07:21 +0200
X-Gm-Features: AVVi8CdjwsziFqH6gKwOS9Oa6jPivJcasPlTXC07BXpVwfv0kLzZXNeH6Lhyp4Q
Message-ID: <CAL71e4MYNiScZjTwkApjDAjRh2LM0_SP59h5HCTywV-Pua03tw@mail.gmail.com>
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Jun 2026 at 09:30, Rene Scharfe <l.s.r@web.de> wrote:
>
> Right.  I was wondering, though: Why is sift-down so much faster than
> cascade in the describe benchmark from 30598ccc4d (describe: use oidset
> in finish_depth_computation(), 2025-09-02)?
>
> I think I mostly understand it now: cascade is better in prio_queue_get()
> because the sift-down item is from the bottom and will likely end up back
> at the bottom, just of a different branch of the heap.  Thus a sift-down
> costs 3 compares times the number of levels, while a cascade costs just
> 2 compares times the number of levels and there is likely little to no
> need to sift it back up.
>
> For prio_queue_replace() we sift down a random item, though; we don't
> know where it will end up.  If it belongs at the very top then sift-down
> just needs 3 compares, while cascade needs 2 compares times the number
> of levels to bring the hole down and the same to bring the item up.

Yes, I think that reasoning is correct. It depends on where the item
will land.

For get() the last array element came from the bottom of the heap
and will almost certainly end up back near the bottom, so
cascade's blind descent is a good default.

For replace() the new element is arbitrary -- in describe's pattern
it often belongs near the root, so sift-down's early exit after
2-3 compares dominates.

Your benchmark confirms this: v2 (cascade only in get) matches the
baseline exactly for describe, while the hybrid is 4% slower.

> So I guess we keep the full sift-down for prio_queue_replace(), knowing
> that sometimes we have a lot of items that end up at or close to the
> root of the heap.

Agreed. And with the lazy-fold series (v3 just sent), replace() is
removed as a public API entirely. But the same principle applies to
the fused replace path inside prio_queue_put(): when get_pending is
set and a put arrives, we write the new element at the root and
sift it down -- that path should keep sift-down for the same reason
your analysis shows.

If (that's a big if) both my patches eventually land,
the split would be:
 - unfused get-flush (in get() and peek()): use cascade
 - fused replace (in put()): keep sift-down

Which is exactly the split your analysis predicts is optimal.

Now I am thinking it would be easier to reason about this if the other
patch lands first, since the cascade change becomes simpler to evaluate
when replace is already gone and only the unfused paths remain.

- Kristofer
