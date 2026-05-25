Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77253E3C72
	for <git@vger.kernel.org>; Mon, 25 May 2026 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699267; cv=pass; b=JAAmXXOUmGTdELhymx57F+PWKdY2zLm9TGwGdbS9Dcjxhn6a8yD+oydjPbzXYdAUyIsE4g5RFw5SX785C4x80x1X0UJqgHc6si9SCicyErUp1XwXAnQoRUq/l/HJ6F8vKNDfk9pTYAF4mOveeGjTj5IP8ODqfl/mntPAdJ+pHco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699267; c=relaxed/simple;
	bh=PhOgLsA/+zjDCVt3q5zhzVVbDVVyeiTbzG0Fw6JSvYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwS1IEJDeSlxM9IA+cLgQTJ9DvIW4c/q8zxJdlStdLkdXmaSWr+H1K7b6jKvSjTcEQzjZTQBaIrUuVAd0cDiT/O6tbTA+mKChgr16aGsEo6nW4WfOLTWs8xUAnZC0J6RAbpNx1wHYWsTJCWrmDYOSivplfiC2VF+AcCxr+N0faQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=GW4jiBEr; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="GW4jiBEr"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bd6f65c781so75866667b3.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 01:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779699264; cv=none;
        d=google.com; s=arc-20240605;
        b=Wif0oqWv97YztU+HijIfCFQZJxdoVP6N5jk1OaNTgOvYZ3C9zTYmFkrlYuZhQSmifj
         1gaa1X1kLZH4kwttC1xynjDcH5mIuOUd3yRKntIwIiukB/s08QarlRMkLNAk9PQ7vKqu
         p9wmbor+li/TpfgqlHuN4vNAnj39WXMOlG7NFguDSDWIaLpv0F7Lvd+9TbXvTDu9lYe/
         uJzBnu5Ub/1f+OzCFr8KYFU9pdDh0//SpNsFS9wLSA3Tl2pvl3Scqe+0oWzkr0UYlqFk
         pnIStRX9E4znh8F/Kj4zCyzsD4HyQtQaYm1MJw6r5X7MvJqCdDStIw4nJFD5rP9+rP6Y
         MarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tNFEzq5bOp/aNwoaPr0C6W9Lm3V84I97yenLbL3lTMU=;
        fh=A40sDa4gcQ/WFC/YqW0LeCnK2EYuXhWeczIDO+5X/yw=;
        b=allVdKXoAUfDDFpY5OOo0E4QNURnlFtKMdgW9ZPUTeNlJJEzdB6j2DH0L+HLtoHLTJ
         rfsgpkaDepw4bhw2Kg0iIciiyhi+a29uyCC763oH7pOh9s1+zRfaRyexkEXbbGgSIgt0
         lfhOGVINMzEKlaFKMMgyWuS6RfDct6QF26GDvpW067TgKOP9qIcIyydCd+4/hmdqamEZ
         jbpugCe3i0q6ZS/CYqQAEMc61ojFgmfrFymlNr+9/44VxnOflHlsO1fGifHEQQ/Wj4+0
         I80/4zntGPD/FijBl3SVNi50nbGHBsyez6duQunQbKH5fEAPYYWV+UrZhVfICc1Xs9oF
         GMwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779699264; x=1780304064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tNFEzq5bOp/aNwoaPr0C6W9Lm3V84I97yenLbL3lTMU=;
        b=GW4jiBEr25yfhCZ/sMve0DCFNWTnm1Z4jCe/c45xB4MGT2JYzbghzzG7tndvI6ZQmO
         LRPXC6QwnS+LuM5YzOFkS5PaOponAsSRcFwNNYlTftE3g4JvPvLDioQ5dIg94pFJmV6O
         7n/fUGOd+759KUhOTEF8j4EmWG4k3FzQuFDds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779699264; x=1780304064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNFEzq5bOp/aNwoaPr0C6W9Lm3V84I97yenLbL3lTMU=;
        b=EBbur8/1Vje5cAhYEe5o/wQ5Z9oGYV5RbyuuP1K52z4pQreorHibHbix4pTY2K0WJi
         ixMwsi9gtocHCDDlTy6DsETB5LRyDqPgIGrhBojQ7e/2VossBufc+ixZenJdymjMmxPy
         7Y7WDTN57cakUyBOL1PrenAurzbeP6bU5ovRewRV4HdDChYh58tvSq/ZPURn0egBcWsg
         TBLAuKT5s7LkRH88jYH+6UoO6gp9WgCxRn8cq6xTC0ECEKtY8N4K5e6NrHqATb4PdvZv
         2GlSiVetPfGoQTzD2MprP1F7vSH6j7tkPCKfD4pkDUGWJMFTVn5VmTnHWjwINnQhMeZ4
         Om4A==
X-Forwarded-Encrypted: i=1; AFNElJ8PRoSoNPccudLswTWiaRuzB6UpP91tNMTP2rT/dTMqvGU4Prk+dlvli7S2yafKIx6w0o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8co8hrIXwQ8H/NESoen1PAfNu9vsKfML+wj31Qq6waN9R8W6
	4CcoMH4Ew7sywtbDuT0v2REGO8TzfAb2ZqVSIWXMhppQCCU5yia/nMM6hiPJPevUs1hpHf3H4DM
	fqz1/09QoVZUroA7AHhp4rHvxTQDVBesQPhWJ1JFsxQ==
X-Gm-Gg: Acq92OEm7FM2LMHbl06KG/wPcXSuQAqs2dd2iTEoZyqjCo8acaUdkv+dd6zRAuUaBuo
	3cVE9t76hGxVXBHuoqXyGDcYRvWxUxTdDp0vPsi6fjaFEGZr2STczLRtchlpt4FIcXUV8od1dcu
	oKd2dDzQviUkvGFQwZOiDEU9aBhejMfZq2H279QjEW2K8QfuRdDSds6F8h0mIRZoPzFrHrrimBF
	NpBJn9FvHnfkwd+lydEay1gBUoSWT3FcylPeqxjLaNAoYbKeVntii+hZHG+X0XDjem0xjgnhgIn
	WkIu89zfJoI/JbURFbs=
X-Received: by 2002:a05:690c:260a:b0:7ba:f6b4:3582 with SMTP id
 00721157ae682-7d357426975mr112690337b3.16.1779699263932; Mon, 25 May 2026
 01:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <4742f5e634b55820f3b5a626ec97e24617fdae3d.1779644541.git.gitgitgadget@gmail.com>
 <42aef000-7952-482d-8532-2287cf32b275@gmail.com>
In-Reply-To: <42aef000-7952-482d-8532-2287cf32b275@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 25 May 2026 10:54:12 +0200
X-Gm-Features: AVHnY4KuHbgWi01oCP-EvbjmqJ7gEqH1g-_vLzL58S-sTgmG4EoCVenyrMbBncE
Message-ID: <CAL71e4PKL9e9empOBppF-RxufaQK95DJh0icAmtfd4cnGUN-Wg@mail.gmail.com>
Subject: Re: [PATCH 2/3] commit-reach: optimize queue scan in paint_down_to_common
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have been thinking a bit about encapsulation too - the problem is twofold:
1. ENQUEUED is a tag on the commit object but it represents membership
   inside the queue and so we already have an implicit assumption that it only
   matches one queue (at a time).
2. The counter is touched on enqueue/dequeue BUT also when mutating objects -
   that last part is tricky to encapsulate as a part of the queue.

That said, I think if we go in the direction of Jeff's idea with an amortized
O(1) staleness check, this becomes simpler - and we can perhaps do something
to structure _that_ code instead. Something like this perhaps:

struct stale_prio_queue {
  prio_queue pq;
  commit *nonstale_cache;
}

and add the corresponding wrapper functions.

I think the encapsulation idea becomes even stronger with that approach than
with the counter based approach.


- Kristofer

On Mon, 25 May 2026 at 03:59, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/24/26 1:42 PM, Kristofer Karlsson via GitGitGadget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > paint_down_to_common() terminates when every commit remaining in its
> > priority queue is STALE. This was checked by queue_has_nonstale(),
> > which performed an O(n) linear scan of the entire queue on every
> > iteration, resulting in O(n*m) total overhead where n is the queue
> > size and m is the number of commits processed.
> >
> > Replace this with an O(1) nonstale_count that tracks the number of
> > non-stale commits currently in the queue. The counter is incremented
> > by maybe_enqueue() and decremented on dequeue and by mark_stale()
> > when a commit transitions to STALE while still in the queue. Since
> > each commit appears at most once (guaranteed by the ENQUEUED flag
> > from the previous commit), the counter is exact.
>
> This idea has a lot of merit, but I'm a bit concerned about the
> organization of data. My ideas of how to improve things may also
> impact patch 1's use of ENQUEUED.
>
> > -static void maybe_enqueue(struct prio_queue *queue, struct commit *c)
> > +static void maybe_enqueue(struct prio_queue *queue, struct commit *c,
> > +                       int *nonstale_count)
> >   {
> >       if (c->object.flags & ENQUEUED)
> >               return;
> >       c->object.flags |= ENQUEUED;
> >       prio_queue_put(queue, c);
> > +     if (!(c->object.flags & STALE))
> > +             (*nonstale_count)++;
> > +}
> > +
> > +static void mark_stale(struct commit *c, unsigned queued_flag,
> > +                    int *nonstale_count)
> > +{
> > +     if (!(c->object.flags & STALE)) {
> > +             if (c->object.flags & queued_flag)
> > +                     (*nonstale_count)--;
> > +             c->object.flags |= STALE;
> > +     }
> >   }
>
> These two methods have some concerns on my end:
>
> 1. We need to store the nonstale count somewhere other than the
>     priority queue, even though it's necessarily representing a
>     subset of the commits within the queue.
>
> 2. mark_stale() needs a queued_flag. (I need to check to see if
>     this is indeed changing in multiple callers or should always
>     be ENQUEUED).
>
> >   static int queue_has_nonstale(struct prio_queue *queue)
> > @@ -68,6 +81,7 @@ static int paint_down_to_common(struct repository *r,
> >   {
> >       struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
> >       int i;
> > +     int nonstale_count = 0;
>
> My preference would be to create a new struct that contains a
> prio_queue as a member _and_ a nonstale_count. It could initialize
> with compare_commits_by_gen_then_commit_date by default.
>
> The important thing is that consumers of such a "stale-tracking"
> queue would not be setting the STALE or ENQUEUED bits themselves,
> but instead the queue would be responsible for that.
>
> This could allow us to simplify callers by always assuming we can
> "add" an element to the queue and the queue will use its ENQUEUED
> bit to prevent duplicates from reaching its internal prio_queue.
>
> Such a data structure could be private to commit-reach.c for now,
> since all the methods that would use it seem to be colocated there.
>
> This is a big ask, but I'm interested to see if such an approach
> would simplify things here.
>
> Here's a potential breakdown of how to build such a thing in
> "small" patches:
>
> 1. Create the data structure and update paint_down_to_common and
>     ahead_behind to use that structure, but still use the existing
>     prio_queue methods on its internal member.
>
> 2. Add the ENQUEUED bit and methods on the new struct that add
>     that bit as it adds commits to the inner prio_queue. It would
>     also ignore commits that already have that bit. (Should it
>     also remove the bit as commits are removed from the queue?)
>
> 3. Now add the nonstale_count (or stale count?) to the struct and
>     have it control the STALE bit modifications, with increasing
>     the stale count when ENQUEUED is live, and decreasing the stale
>     count as such a STALE object is dequeued.
>
> I like the idea of this being encapsulated within the struct and
> its helper methods. But the proof will be in the implementation.
>
> Thanks,
> -Stolee
>
