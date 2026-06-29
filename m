Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA03BB4A
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735126; cv=pass; b=eTpRRTyzjsqPtv0SDCCnjfUto9IOpnAKYcwKRwASgCdS8zJPR4DnNKWIzpF0cfaOPn3rzVFLtcz2sA0uBXud0tjQno1Hs462wzvLD20BAHmJlNP2IEbyNWAdLAGWFrIR3yYwa/nVzoyZmlcB/CRh7u55UUtXLJUmWAaTch+CZ5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735126; c=relaxed/simple;
	bh=NVRAeVAjlDwbhXHlgvS8ir/J4b+PR+pR/Bthi13rgZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm2XZ1gd8qKWJJgfgO0Ll/TUI/Na1NFC1H+5Jf49gB8LNk3SlYT52OVeQfzYzN2kuGhNxgb2OLRGMSTBWuVevqESvKnChfg/T1axXz0wh0JMlFG9l+EElZMgwkoJVNv2XUFL482h0h3HvBOZrkv7XRueniFkPAnDO/IEiD8WBBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=JyMHgt3f; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="JyMHgt3f"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6647bc8f900so3870617d50.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 05:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782735124; cv=none;
        d=google.com; s=arc-20260327;
        b=dvaVijOGJNuDhBXXxdjRqgIAPXiIABEn2GFMvhML3j/2qbucHcisUJpriEQ5Ya2fDF
         dq5CcqRL1FAIrCYhy3p5TDVA91doYDZfWTtTXGqSNY7jTuzF75JFVQroYtnihkHisdOt
         aVuX8sIvIF2CGc07gZQAS8pIo6ldTzNOIE3/EY1qj/bfIEZ/ilI4gPv4wlBlndqKgHSc
         dOM/J9h9qW81Yt0V/ofmg4Y/flrsO0Q0Gvr6W2EyETeTudvLcbQv8QhxeBJwmW1XapnZ
         E61FE+G7Ukv6OwXQBbXcgSAktk+u0lpyBPGWGnm2+TOlK0Umg0wxxiK40hX4Z1UhUUi/
         4q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M6FLZvA8Pwfh3nUJdXEdRIbFisLwFVFAuq70Ux9RsJg=;
        fh=ts3H1UQbhaUrVqpNdcRXPigk2/9OLg9qfpi4paTEsA4=;
        b=RlqT7FwzkMB1gpbNdjVYRT3ViUo+3m/lWOFOR4kvet9W50m7jSuQ+s7PrfRB5ppA+7
         T9qkEEbMbMpmkXO+L/Zp3kjKv5S9GVQVRmbux0WRh6Y0DO/KSRz+3VZDKpSrkdxdi3HW
         DjPDFpY8D8kaERiDmU20ooCnIdX3TgNlJ3klCRZkqyI2EOtXwNbOkt7bD8zE4KaJgXd1
         wfhfxeIwNwrZ6+w4fs2Rwd8uX+NwOwzvfShRcK2rTdtQ6TTqe0kv217K6c7YA3+BN2DI
         L7SOOKfV75+IIqmfkur9Akhsne01fvs+WoMmbP1egfmkVNxC1+oacx6A8pUsWMNeF5j4
         paDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782735124; x=1783339924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M6FLZvA8Pwfh3nUJdXEdRIbFisLwFVFAuq70Ux9RsJg=;
        b=JyMHgt3fasD19yibzvtXd4M6CFHR80+7gW10PkNDLpsPGLRdWJK4GxjbO8jXpw01B5
         eUo7DZ9uXhvXdyTPwudqfCZllw1FmFw4ea3aa0rqk1LQ4okzAsMVp4yflBBCkcv5PlR8
         S+Su8NZWDw2ceDZri8EkIZ1Rg8eUjF1onkeyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782735124; x=1783339924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6FLZvA8Pwfh3nUJdXEdRIbFisLwFVFAuq70Ux9RsJg=;
        b=DRlMX/3jIWGAt5Z+Hq+1vIzrP0ETAiuNx+2f/qBydN57xJgLuSjg+3CTVEjeCfZyD0
         GAL8Q4+iaMRj9FOvrqH3wwfS853DMKCmtMmIipbDQc/YZsmdszuMOkKvHRAouPKoesp0
         V/70nTvPB7M+wU58HqRdhQoWZ44lRw7r9Jyv6kZB0cLXJTR4p0wzLbatmABEzPrFJRJP
         ZeslAYeMJp5AojUDhla0MD2NPA6AzZ/QAtf0uyWQCKcVhW8cVIbzohheRn6mb0kxgPgl
         grdmTKKGPyN6lgI1SntU2Qp8O0E/5+iEBcoWdkHin2CjoAFceu6YvssIrwAf+a6MLoZA
         r8Ow==
X-Forwarded-Encrypted: i=1; AHgh+RqQyoNEph/7Eprbdl11ItSM6YZbzxbEx7n8qySA2BbIrWIFtXCS3/uWAVAyuCnOe5giHdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9ralG0UL2Zikwk+fESuaBN4Qvx+gXngQk/cdntdeYQg4ne4N
	oasowg9RuNxUK/JeiK1wJqBRGOVJxahUKjAiV8V1Erwdjoiey+0PHS/OGwvvEdmGMsmYkKiJ+vg
	XWdocNuFu6BAeiY/vcaP1105bN1dtnFz2YgqY6lFGrw==
X-Gm-Gg: AfdE7ckO4zkThF4DeMXA1ZMmArv96o5gsLwNPAKBzCLThbRdXQQeZEdLXX3J7j5cWCq
	EWpdJOg9UgatEo/LbChyZvz7J5TjFktUq7WBGE+FsWMKxziIUknr2l/X7+g5crqQkguMwCPI5TV
	+D80bibxB9BecfQn/tZ0MzcNqVreQcYTYm1Qi5oAHZ1yNTSntW6l8V2X6Y1c24k2L5izl7XTWcw
	eJM3vI7xnVaYB1WwkeXhfu2R9xDJ1e7cbkkgiKvoJcxzgt2SLv3r99szcIRO1FqwxHWykdkhiEG
	cT1+6qBL
X-Received: by 2002:a05:690e:4885:20b0:660:5a88:6442 with SMTP id
 956f58d0204a3-664f628f0d3mr109832d50.64.1782735123580; Mon, 29 Jun 2026
 05:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com> <48bfdb11-2624-4aa6-8fbd-d3f894c33bcc@gmail.com>
In-Reply-To: <48bfdb11-2624-4aa6-8fbd-d3f894c33bcc@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 29 Jun 2026 14:11:51 +0200
X-Gm-Features: AVVi8CdRasuEFrS2GFBTzdZ3sTNdZIQ_sq5g3qdlZjJW3d5SgX8A27wFkj2NxKw
Message-ID: <CAL71e4O8gTLm4WUcPF-ZbOYTuEzuNSVh0Qjf8ys1w4LVF9Hi8Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jun 2026 at 17:16, Derrick Stolee <stolee@gmail.com> wrote:
>
> I reviewed the v3 discussion, the range-diff, and reread patch 8. I think
> that this version is good to go.

Thanks for all your reviews and feedback. However, I found one more
problem that needs to be resolved before this is good to go.

paint_down_to_common() has this fallback:

    if (!min_generation && !corrected_commit_dates_enabled(r))
        queue.pq.compare = compare_commits_by_commit_date;

When this fires, the queue uses commit-date ordering instead of
generation ordering. The side-exhaustion optimization and my older
patch for !FIND_ALL early exit both check for reaching the finite
generation, but with date ordering, that check is wrong --
a commit can have a finite topo level (it is in a v1 commit graph)
while the queue is not ordered by generation. This unfortunately
means there is a regression for the !FIND_ALL optimization that
I should fix before 2.55 is final. I will send a small patch for
that separately: add tests that demonstrate the problem, and disable
the !FIND_ALL early exit when generation ordering is not active.

I traced the history of this fallback. The queue was switched from
date ordering to generation ordering in 3afc679b (2018-05). Then in
091f4cf3 (2018-08) you added the date fallback after finding that v1
topo levels caused "git merge-base v4.8 v4.9" on the Linux kernel to
walk 636k commits instead of 167k -- a side branch with a low topo
level stayed in the queue behind a long chain, preventing early STALE
propagation. Later, 8d00d7c3 (2021-01) tightened the fallback to
only fire without corrected commit dates, since v2 does not have the
regression.

The problem that 091f4cf3 addresses looks closely related to what
side-exhaustion solves: the walk goes deep into a subgraph where
only one paint side has presence. With side-exhaustion, the walk
terminates as soon as one paint side is exhausted from the queue,
so the deep walk never happens regardless of queue ordering.

I benchmarked "git merge-base --all v4.8 v4.9" on the Linux kernel
(the same case from 091f4cf3) with three configurations:

                    master (--all)    side-exhaust (--all, gen ordering)
  no graph:           3212 ms            3268 ms
  v1 graph:            188 ms              17 ms
  v2 graph:            227 ms              17 ms

With side-exhaustion, the v1 case no longer shows a regression
compared to the date fallback -- if anything, it is slightly faster
since the walk terminates earlier. This suggests that the workaround
from 091f4cf3 may no longer be needed when side-exhaustion is
present.

It is also worth noting that commitGraph.generationVersion has
defaulted to 2 since 2021, so the v1 fallback path is rarely
exercised in practice. Any commit-graph rewrite produces v2 data,
and only repos that have not rewritten their commit graph in over
four years would still have v1-only data.

If that reasoning holds, the fix for v5 would be to remove the date
fallback entirely, always using compare_commits_by_gen_then_commit_date.
This would:

 1. Fix the bug (finite generation always means generation-ordered
    queue).
 2. Remove corrected_commit_dates_enabled() which has no other
    callers.

The alternative would be to keep the fallback and disable the
optimizations that depend on ordering (via a flag like
paint_state.gen_ordered).

Do you see any cases I might be missing where removing the fallback
could cause problems?

Thanks,
Kristofer
