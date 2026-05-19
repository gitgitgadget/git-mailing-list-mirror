Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BAD3DB65A
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183213; cv=pass; b=jEDsL7wp/6g3XAQVtQofg/+XYpTyiYvYevspapGPris3exMWaE847Eno3HuH4qSZXYucyd/8LDqS7zf9IwW53PjK5xzfu5Gnt5K7AbJVCmwnFYsT88hRE/QQcqrr3dX478B5AkGXZCISnqZObs4XPocqnzQUI6+zGWFBV85MYVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183213; c=relaxed/simple;
	bh=nw/DvNZB9Rjuqz3SDGP9S4qxZS8/zx08wXIYSINZhPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHorjufrHb0VbJfcWLutZ34Uh1VLK0mLl9ANFgQGjRz796fZ/ThyAn/SFqFmswQdXuANlGchpOe05/s+OP1QZqr3d3B49xypvYlWvSlYKn3rfHnaw1XC2hMzmbct/Da5n8rTx6NC5tMwc7kGk2/dhs6Az96c9SE2mW12ahzRpkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=M/in8m5d; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="M/in8m5d"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7c52e49d978so27508087b3.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 02:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779183211; cv=none;
        d=google.com; s=arc-20240605;
        b=LJmRMC0nIQ4veo00D+O4rmmEpLoc4Uh/bdwxw+ojm6EoNcmAXwXr80enXBdxbPWH21
         5Cpgkcj+vsED4LkYRWJAIXhQD+IxDLkShuxSBhYxGn/tNJf+O5lKFH3VjLiYOAn92NKX
         2mGjPwBUdLWEXWLeMKlLue1Kxk2edUrSG+K/Vxax6AZFKNGZOWOud5OagE/JZc1AuGSg
         x/9QRR7rEsevgf1D3V9YDYLn0CVD8Ml6kOL8Mt+fah7p8l7y/9Jj7FIwejEHwihSVwhQ
         0eCqJbI10BKg/zmDzheL2ruyVsUMeBSklLFFBwNPtMTJ9ahZTNeBGE8n3mfARepiC3Ih
         pjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S8WUHUmwBvMJVE2s5GnIP8kY3JI/str7VB50nhmIaZw=;
        fh=77Cdu10HPJrSoxsDIxsXz7o1lrADaOs8FZjdpUhUffg=;
        b=CvvSMZyWGGbXU6vGb/7UnTYJ709KgYNMjjeekm8sD8Pui/YNhJLKg6HTqwqS1a4r8P
         slHDs0Ub7x66VDHAPNZMqW1RX3+JF6OBTj1z2cwweCJ1PWnKWI1y3tBgPCbo7XNZtSKS
         fDI374jDnlwlA9HsTpU70s+L3+8Ing6AN1Jptb32xJdUD2LsAcqGI1opOsPmbABpWFcr
         CA0LzHN9q7QElCHuJlUOSCfmfvzD79rwsvlmGQFXPH7TF2cxfr5PdpAtVpzbr56+3hiM
         33PgF7X0hLBdX7g8MQDWwki1wrL3OTyj01NEA0knogGxQ5lrt7IhRI6jy2ej7gBA76zm
         FDEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779183211; x=1779788011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S8WUHUmwBvMJVE2s5GnIP8kY3JI/str7VB50nhmIaZw=;
        b=M/in8m5dHw2rDRi13cjz8ZHEyMkDrD19y37WnfMmLqOSUTbTlO43/3SfsOaOE4NxC2
         9vwTQTx93mpxQh6yPBGpZVYjwq/DEXnLoyjpRklcA/PSl9KqzkHViUw7NkI0LN0nlXZN
         yfbWNU6WNEcD/EOpwlpnX2pCLRvyox4U2XoL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183211; x=1779788011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8WUHUmwBvMJVE2s5GnIP8kY3JI/str7VB50nhmIaZw=;
        b=FvhiWXfwsdW0AtXXYENUVgnoJRCQfBPaSqUHG8ohZ8/QAt1CzdSPcDrSTgkJeQaybP
         jYiXcMsyWK7g0qsNA1wbOQqRM9TcC9AOujyN6M+w3M3oNREvYgdLQ4LxatJoz0Yj7Vmq
         sQWbkuNFSdgMDZoZMFRSR2N+Pl+oKdbcofSTefzS1P4fiRVRjzntfcAd/P0BiEVeotrX
         awqQZMCywbXtX5mhoFEt0y2aPc0EKhbgoNHymioA8nSXw2ancYydflYUo07RiKOJ4IOw
         6V9Q5+JdEBdsOzRlhA4XULCxLwaIYxmH3veIQwdHmKMzompLa5BK2tsEY7g8KEyNSOEJ
         gWEw==
X-Forwarded-Encrypted: i=1; AFNElJ+vmGPUpWpYBc25mFSdFUrb86YUIbAIX5felDA7m2EPmXkxT4RXIDFECXP/s8UpcRTrrm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKfnjVAzCXgYFIHcMCLTAye3aAzKm59iYZlmN5uK9n1VbFfHp
	DHCFVoBOXB41FTLowHVPNqt2WyqBHPB9lUB+CU9duTZ7huJj0km6A4UgMo1kT7Exe9oqNGa4xh3
	KZroql90Wh6ugo5mKJABnjGtcqtiMDp9SUyc0QDx3vw==
X-Gm-Gg: Acq92OH5rGsbSHrjIopdkRvvUz0kOejNwpYo4WHOhiWTCPvRr70/FYgqba6s1dqgSGe
	a8c6HyNllK3YaXIsp57m6bwwjxsZepzw21+i5dA0tBYyFsY2FUNHkzziDEGls4GRVeIDTdwkPYZ
	qE/oJB12D9i/sT663k1/MB34OaX8zqwibmLyzMpR/OGutxnkYgl6HBwfOPFDHQSf6jO+o6kKnTP
	spxBeGxIjMduc0oX/JULmZLLWmM37hFwFVx+ybhySbUkTmKofNIxFQq1MT204jCVM/egiHrrand
	T8banTPKFx+7ilcTmho=
X-Received: by 2002:a05:690c:4424:b0:7b3:852d:eed8 with SMTP id
 00721157ae682-7c95a66e7damr186074097b3.20.1779183210824; Tue, 19 May 2026
 02:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
 <20260515041641.GA81292@coredump.intra.peff.net> <CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
 <aad34ac2-4cd5-4c85-b8ff-14c0caaa1c7b@gmail.com> <CAL71e4MxhcZqxPVEe38Shuqt7h5dxLDGi66hN2cFXnmg-POKWA@mail.gmail.com>
 <20260519005429.GD1612961@coredump.intra.peff.net>
In-Reply-To: <20260519005429.GD1612961@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 19 May 2026 11:33:19 +0200
X-Gm-Features: AVHnY4I7B87z-9rJ54D83A-Kw6c1rMtw2MGXZ8SCW_QGwH6lpHDWe5AmGNI7e54
Message-ID: <CAL71e4O6UcnqmxDgqyGqvgvfruSzeoz6Wj5muXiwEp_8y2wAcg@mail.gmail.com>
Subject: Re: [PATCH] revision: use priority queue in limit_list()
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 02:54, Jeff King <peff@peff.net> wrote:
>
> On Sun, May 17, 2026 at 05:26:06PM +0200, Kristofer Karlsson wrote:
>
> > Another note - I think I managed to apply the same change to
> > get_revision_1 too - speeding up a monorepo "git rev-list HEAD" by
> > 3.3x so it seems like a reasonable thing to do.
> > This simplifies process_parents and also makes
> > commit_list_insert_by_date dead code.
> >
> > The only caveat is that get_revision_1 starts to get messier and the
> > rev_info struct needs both a prio_queue and a linked list of commits -
> > and then flushing everything
> > from the list into the prio_queue when executing get_revision_1.
>
> IMHO it is worth replacing rev_info's list with a prio_queue and letting
> that be the source of authority. You do have to be careful to cover
> cases where the list _isn't_ date-sorted, but prio_queue supports that
> with a NULL comparator.
>
> You do still have to convert between list and queue at a few spots, but
> I think in the long run many of those could be converted to use a queue.
>
> You can see my patches to do so at:
>
>   https://github.com/peff/git jk/revs-commits-prio-queue
>
> I've been running with them locally for a few years. Mostly I hadn't
> gotten around to polishing them, and I think I had wanted to do some
> more perf testing. It sounds like you have a good candidate repo for
> showing off the improvement. ;)
>
> If you'd like to go in that direction, please feel free to pick out
> whatever is useful from what you find on that branch.
>
> > I don't want to pollute this patch with that change - should I start a
> > separate thread for it or just revisit this later?
> > (Perhaps I have too many optimization patches in flux already)
>
> Yes, it definitely makes sense to do that as a separate change. If you
> look at the patches I linked above, note that they'll get a bit simpler
> by rebasing on top of your limit_list() changes, since it does some of
> the same things.
>
> -Peff


I didn't know about your prior work on this -- very cool!

I took a look at your branch. Our approaches differ mainly in
how broadly the prio_queue replaces the linked list. Here's a summary
of the tradeoffs as I see them:

Your approach: replace commits entirely with struct prio_queue.
Every access site is converted, and boundary cases (bisect,
topo-sort, simplify_merges) convert queue->list->queue when they need
list-based APIs.

My approach: keep the linked list for setup and add a separate
commit_queue for the walk phase. External callers that read the
list between prepare_revision_walk() and the walk are unchanged.
The conversion happens once when the walk begins.

A quick size comparison:

  Your branch:  12 files changed, 167 insertions, 152 deletions
  My branch:     4 files changed, 138 insertions,  78 deletions

The main reason mine touches fewer files is that the list stays as a
list during setup, so bisect.c, builtin/rev-list.c, line-log.c, and
list-objects.c don't need changes.

On the walk side, my second and third commits refactor
get_revision_1() to use a vtable ("walk_ops") that selects the right
pop/expand strategy once and caches it:

    struct revision_walk_ops {
        void (*init)(struct rev_info *);
        struct commit *(*next)(struct rev_info *);
        int (*expand)(struct rev_info *, struct commit *);
    };

    static struct revision_walk_ops streaming_ops =
        { rev_info_commit_list_to_queue, next_streaming, expand_streaming };
    static struct revision_walk_ops limited_ops =
        { NULL, next_commit_list, NULL };
    /* ...reflog_ops, topo_ops, no_walk_ops... */

This replaces the nested if/else chain and makes each walk mode
self-contained. The init function for streaming_ops drains the list
into the queue; limited_ops just pops from the list directly.

The thing I'm less sure about is the prio_queue dual-mode usage in
your branch -- using compare=NULL for FIFO mode. It works, but it
means call sites need to reason about which mode the queue is in
(heap vs array), and the queue<->list conversions at boundaries add
up. In the two-field approach, the list is always a list and the
queue is always a heap.

That said, your approach is clearly cleaner long-term if the
remaining list consumers eventually migrate. And the single-field
design avoids the "only one should be non-empty" invariant that
mine relies on.

I benchmarked both approaches against a 2.4M-commit squash-merge-
heavy monorepo (best of 3 runs each, commit-graph present):

  Benchmark                             mainline    kk      jk
  rev-list HEAD (streaming, full DAG)    21.8s     6.9s    6.9s
  --ancestry-path ~100K (limited)        21.8s     4.8s    5.0s
  rev-list --count HEAD~10000..HEAD      17.7s     3.7s    3.8s
  log --oneline -1000                     0.1s     0.1s    0.1s

Both give ~3-5x speedups over mainline. The streaming walk is
identical. On limited walks kk is ~4% faster, which I think comes
from avoiding the queue rebuild at the end of limit_list() -- jk's
commit_list_to_queue() drains the result list back into the queue,
while kk leaves the result as a linked list (which the limited walk
then just pops from directly).

The perf profiles confirm this: compare_commits_by_commit_date is
11.3% in jk vs 8.0% in kk for the ancestry-path case, and
sift_down_root is 7.3% vs 5.8%. The rest of the profile is
identical.

I put up a draft PR with the two follow-up commits (on top of the
limit_list change) so you can see the full picture if you're
curious:

  https://github.com/gitgitgadget/git/pull/2118

I don't have a strong preference for which approach we end up with,
since both will achieve the same performance. So it's mainly a
question about which one is easier to maintain, where everyone else
in this thread has more stake than I have :)

- Kristofer
