Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65E380FC4
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223784; cv=pass; b=XFhWAJvwosN1yTPNnN+Z1gglMt//l9SDbAaQLVASVc12AqtlO2yRW4xW2CW5viSNfKaotG4nh8CUYJK+/3dITIB3/xx2uN5kHXofTd4GPtZnmSeiWLRoHVwxX3asFb/u9EsjsL0ZFNQ2geykiqXHLWdLL0300HOJObMIzH2JCtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223784; c=relaxed/simple;
	bh=M2R2oV3we7oXEYD8f2rkR9OAtvoo9ruVE/JLlN9qkO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAshbVsF+Mwpc7rOIw3Q3HuUNsEd4baH7t8jUr7CoI6W7vXUpAu7dshAQj6K65ppuApDvoh9HiLqEszjU4jHQW4vDjlb32KF39QdWRh9HmUlyWbAoz5eUvfw19Ob16fTa9bMLe+b1VBLvFssNdsjNdn0ZKqpN40MD4//LDa2rMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=R8uFqoes; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="R8uFqoes"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-662d484ff3bso5682215d50.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 07:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782223781; cv=none;
        d=google.com; s=arc-20240605;
        b=TBuyTCQ7byazGF1snfLRBTqVA1PvjPkDk3nCOrMDtE/Px2ElCDQ8rfND7+9o7/Jw9Y
         10V8a0kMODnSJgqQnxepE6Hj4FLit5P/Xm8ORfTKSjHyq2qzWBR02TYAaFRV4aGAk2io
         EeYTXsUahFnvi9IKgqWXYJ3CPagmqNA+9EjdvIhXLCZD4gIYMsVFe1gFXGkI4JtKfLaA
         Fbu1q5s/zDI1BM0ATmZuu5eOXrw8rWHEwguzNhYg0+NmyklbHuaL47Y3n/4Xxiz/9DCI
         VJgqIbj6U/Y5/joMzIih6Q7sxfrukOqTrexsGXlTj34mP//PmttW0PdvUuNksEWQCFdQ
         CZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Se74YGdi+uUVI8J4rk93rPSbKRm8C16yTqJGi23heZI=;
        fh=a6SKnW6OeVuxY280KgTgLNBKuee8L+U1Vvjxw1yxsYM=;
        b=TpD4p+03HP0RypfIydCDKh3g/P+raRnQVmTka6GTFf8x583zmsU9wxe5Ygcv8z4sML
         T+xtfms1URKaMfP6vO7mVrDldukeuVUqJPM/YDwO6zVRASHdm7IPvmJ76eNeI8sFoaVm
         APSHl+bAFzS6UCGkgLQ4373NgCSNoCdovz/CY02OAgsqMTXcRx06UAiRhtabOajHXXXh
         uRDGtn4/SY6TnIarmchJ+AnzNBlluL31uxg+ZyHmxTzBNKdWQZ12knjqFeNIYyC+I9mH
         q05HUOlWiDRhy7GI/S1B7PXyfv7z84F2K355CTQL1ldU6jdnQZEBZ8dCZPsWDPiSqgaL
         aTlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782223781; x=1782828581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Se74YGdi+uUVI8J4rk93rPSbKRm8C16yTqJGi23heZI=;
        b=R8uFqoesulppk9Xgzk38XE12Yc23qmUKohxnWe5dSM5gc3o7zeZ884Zko3+wLSxrwY
         fX8aP8/dnxrsyvrHrAbry1pqx4czXsoWdNkwP+JX2q5vNoynMQKXnXosXQICW9una7pt
         Wr0YChg+EyG3BielWNNADCYklDvI9RrA0C1Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223781; x=1782828581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se74YGdi+uUVI8J4rk93rPSbKRm8C16yTqJGi23heZI=;
        b=VmetgGyNQ6iA3sRz6NQwojpXSHFsiAAOUTqUDdbUmMT7pNvARGGdOG9Ui0vtX0lW7Z
         ilme6Xq9mSTWh9ptsLxZhHL7yT0wSWrr1C+X1g7nrSqc2AjZrphjNx7q+3YcKEPnPP4K
         DIwFJRvxbB59wmh2J5ROC/+DaGgc8mMoztl+4YqLXSwx827PE7rNQyqP1KK71lxdTK3v
         fSiNjT3bCV1N8d3kyq4WP6lbjoFATH/Xg7WLVov1w9VQ5Y5rszeI+KYXkebkm3zowjA1
         T0TS9SH9kb1MaH96RECPdos/gF/QqevJtZRv9Xu1X+/IrII6gAmLsZYMUv3EJNP4kz3+
         hZJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpopoyH3npKFUUJjO7AjqUy4kAk5E6Qfr6ZIzNL9wn/K9r5DcqnWdyqTRWJrDC2xJdQd+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWuqeA9ZThW5Up0dXHUa0aiIzjLUPGz5I3lxzdmudZws5opcUM
	3iSFX5wdqjUOqoqvAMjmeqgEFR3vabz9yDegTlc35gFdBminAT7V5ANl3urFjJxfJkSUIL26flW
	9LCY5VH3JgSDtf1i5751qfP/wkrlmu6WosAcw3m6HjhExcwTfRfn4JUaUjw==
X-Gm-Gg: AfdE7cm6QnvW6MqAHZzYo0YhRLDIl9EPG4nWXLCLWb9lAJF4NaoTKF7IxCMK8xXI5sn
	uZ2pn6+IK8nvXG2MxlkPqDXHf/2rI+FQk6a8dkhUlL2kcuHreRbDXUATXLBSvgVIerWJjvVXqDy
	dg78sOWOTrVfTnXraxA5STNLf3iXf4L6u8IiMNqzSX1bpO5+IgyHWBVdMbdzBmgkD8ITQRAFcBe
	9jV2LTXc7IwbQ3b3ttcv6RijSeo1sXSiDqO4nLVa2hJ21NGFZ7lDMm0jZygFsrtQJpVNoMl3w==
X-Received: by 2002:a05:690e:11cd:b0:662:d600:8f99 with SMTP id
 956f58d0204a3-662ffe03fb2mr17364469d50.57.1782223780579; Tue, 23 Jun 2026
 07:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
 <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com> <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
 <8d07f5a9-82fa-4aed-b407-363e659f6851@gmail.com> <CAL71e4NFHz_zVCWPvmTO8UPNyaKkDFqNQdd3CJykoiGmEhfUTA@mail.gmail.com>
 <509fa950-fb9b-468d-b917-6c0eb7823d64@gmail.com>
In-Reply-To: <509fa950-fb9b-468d-b917-6c0eb7823d64@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 23 Jun 2026 16:09:28 +0200
X-Gm-Features: AVVi8CddOENrz737w1UPbj2ZblCKQPrwk5kn-vKRZof3-0-X0ZPSBFA5KrdfzxQ
Message-ID: <CAL71e4PzjdNCaVRtXg7wh9s6DxBeA4ock1aTzq8VPxKCmE-obA@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jun 2026 at 15:50, Derrick Stolee <stolee@gmail.com> wrote:
>
> > For the termination conditions, I moved them into paint_queue_get()
> > as you suggested.  The all-zero check was straightforward since it
> > only depends on the counters but the side-exhaustion check also
> > needs to know whether we have entered the finite-generation region,
> > so I pass last_gen (already a local in paint_down_to_common) as a
> > parameter:
> >
> >   static struct commit *paint_queue_get(struct paint_state *state,
> >                                         timestamp_t last_gen)
> >
> > Inside, the two conditions merge nicely under a shared guard:
> >
> >   if (!state->pending_merge_bases) {
> >       if (!state->p1_count && !state->p2_count)
> >           return NULL;
> >       if (last_gen < GENERATION_NUMBER_INFINITY &&
> >           (!state->p1_count || !state->p2_count))
> >           return NULL;
> >   }
>
> This looks good to me. I'm not even bothered by the last_gen
> parameter. You do make a good point about it being a potentially
> leaky abstraction.

Agreed, I am not also bothered by it.

> > Both conditions require pending_merge_bases == 0, so the nesting
> > felt natural. The first is "nothing non-stale left" (works in any
> > region). The second is "one side exhausted" (only in the finite
> > region where topological ordering holds).
> >
> > I think passing in last_gen into paint_queue_get() feels _slightly_
> > awkward but not too bad in practice.  However, we also have my
> > older (first) patch with the fast-exit if the caller only needs one
> > merge base -- that has a separate break that also could be folded
> > into paint_queue_get(). The messy part here is that we would need
> > to also pass the mb_flags parameter to paint_queue_get().
>
> How much of this data that you are passing into the method could be
> state in the paint_queue struct? Could we have the paint_queue manage
> all of the state necessary to make decisions around the walk
> termination?

Good idea, I think adding last_gen to the struct is doable and makes it cleaner.
If needed we could also add the mb_flags there (but would be a followup patch)
Minor note: I renamed the struct to paint_state so that I could rename
the prio_queue to queue and not have "queue.queue" which felt
confusing in the code.

> Or, could we do a peek into the queue to see the "top" commit, and
> check if it is a finite commit or not? I know that 'last_gen' is
> supposed to be the commit walked in the previous cycle, but it seems
> that we only care about "the remaining commits are finite" as our
> condition.

Yes, peeking into the queue would work too, but it would feel awkward,

  commit = prio_queue_peek();
  if (halt conditions) return NULL;
  prio_queue_get();

And if we get first, the condition is not valid - that said, it would be doable
to instead put the halt conditions _between_ popping the commit and
updating the counters. I am not sure how ugly or confusing it would be,
but I could add a comment to explain why that sequencing is important.
(Popping the commit and updating the counters may lead to temporary
0 counts, but then when we enqueue parents of the commits they
move away from the 0 anyway). It would become something like:

// dry-/pseudo-coded
  commit *paint_queue_pop() {
    commit = prio_queue_pop();
    if (!commit) return NULL;
    if (halt_condition(state, commit.generation)) return NULL;
    // important: don't decrement counters before checking the halt condition
    paint_count_update(state, commit->object.flags, -1);
    return commit;
  }

> > Right now I am leaning towards simply passing in last_gen and
> > containing all of the halt conditions there
> > (except the old !FIND_ALL).
>
> This is a good start, but hopefully storing the data in the
> struct would be a good way to handle that.

Sounds good, I will massage the code a bit, store the relevant pieces
in the struct
and see how clean I can make it.

Thanks,
Kristofer
