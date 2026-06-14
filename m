Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ADB2D5412
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781411557; cv=pass; b=ScGnktBGJCUW3b4nWWUlU3onciVU74vhQPTIJG1P+zhXTSc24xLjSv5R5F824s2YrcXWV0LykHtvkirioaLs1XVjjZbxtHojHW0pTwaNbSspdMxdNOOHlx1J0awZRlzUjRDohRN15MKknAn5WB5jR6cDjspWUKhVOki980Ewjho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781411557; c=relaxed/simple;
	bh=s4oKAn8TsvmuGJUsUl8g/TaWRTBRcRfcDglpvZTd6KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFRTWu3xtQFweMZZyWCkUIoN4w3CEle466c7cNAYvN/Iq40FXDm1fqueH+mIQisJ3IySmH1A9LjlrCvQt+zne4i/8rdyH14F6cA5x3uDINrZcEllWJK4ygXog2z0SzhnPRZ/tqRVHduWjLjqXN0Yt2KoMA/qRpKQySRTxrd/Ty8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G48iR85J; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G48iR85J"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e709dd1ab2so905860a34.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 21:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781411555; cv=none;
        d=google.com; s=arc-20240605;
        b=h3yvQuwP4frXPahmo8UM+qZpmfQlmVH/OBvyU63yIlq2aZMyF1Fd0G79p9G4jFL7uC
         iY+zWx3t5sVkCWRgTGT0deL6m7+urMOWaQSIDmAbWBB6/0iBfGoHdujXtZ2nzFLMrE1x
         YCL6JBhjIlETlNfqXF3TEJ8djszoaX5ySbA94CrBqJ0FNEJzZEwcv2iqFHc9oEwGxJJb
         87AgQeFPG0ILca7Ei55B42k/s7J4YQZrQ81jYv8UzSCYvFkUswLWuBOwqDmw8ZW80k+0
         O8sKNU5zUs8s8OAPMPyvlVeioWs8HzXisOrVvUfC8McAgDQaxmWHX333JGmb47Lt3s7t
         KZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I+54jRZvR7Y82oQLH/L5NsN0O/2QE4wYOgppQm2Qaqg=;
        fh=CnvDwwiKxpzhqfjheuulW7rjhJiTBDNH+8SVtOYaN3w=;
        b=Vz05S7SaGdC10T0A3beRiKbDCcSo4Lvm2I/qgIqmqlmdYY5V6yWM0xaGppGtMguVHx
         0Bi4QzPlLbINAShxUpkss0D7+bnX9RiU/5k8+V5J7egyVF2a9En3PRiRRO5OEG9oEFhb
         QrTZxKGzWlHP/WFzpxzmoiekSMYnCjh5tIyvPm9H1qhOHMNJJHZSvohKnW6g1Ao36pDG
         Jn2ypwv0O52O7pyPlPwHBoiesM9GSddvE7jVCxCFdqR/Occ3c8fg+na/ogsP0kLavxnC
         6d6bMNemdf+wz6vGvbzXd82rY9+aVA6gshyyKDfCiD+yklwDv0sroIFwIs4Hgq/kHpup
         pEtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781411555; x=1782016355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+54jRZvR7Y82oQLH/L5NsN0O/2QE4wYOgppQm2Qaqg=;
        b=G48iR85JFDg+7uaGAF1ItT5mlYXAZHlq3szYLXop82ljjRX+HWgYSXryV0RlZN+FNv
         0jkccPxzZcPMCDjPRmM9Ai7NFipj66nATyk0TyKMwCjv6xPuK4j0rtE1eQwE1jiXHNSY
         vRaGZBXO0WyY/LXb/T605DCKM+dxseK5GcDxb6+mig3CrcTp89GaC3H8HvVQj3iHP8FU
         k6u2DSN9ZYRpVgMF7AC9PjhNfFpBw9iR3KAptSzqK+SGrfRlu19TfD6tpP6oxtCFPUKy
         sF/2C9PofAi3JZziGg2rxYJgwilplpvFA9qS9PVY7nj3AUCglSoiRybz5vqUTjU0m0Os
         JmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781411555; x=1782016355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+54jRZvR7Y82oQLH/L5NsN0O/2QE4wYOgppQm2Qaqg=;
        b=aj+vwCnNhxpHLSYLB1BtsyT+fjCkqRqu1YE7oIukB21pTDwtlDEiEcoJCOeo/kqqZG
         LCbPuzq1Wh4ucIDCbec1iGVDoaP5kiAFyBALB6bhldwBZ4f69tip6V18sX+RlY1B2QKU
         /3Dm0dHwY1uakihQ6QKORP2qZlFbyAWDzJbcXe6QqjwhtrAhU0g6srC89QtaEK72hw3S
         ALf/dZVpPw210hGNEy+S3WLH5shom+RkQk4tCM25Q0r1HrwcBUMTErKNaJiV0VXFcaON
         Gp8Z8O3dyjwvRF5NXylGxy83jXp1PeCpIBanwJMsVtsrjhWO/tmrno9Zd4Wu2VXuPizF
         DotA==
X-Gm-Message-State: AOJu0Yxvw7zqEhITxCbrmFNp/aowL1WBr0SK2r066fiDcIlU4V9x52/Y
	ZKdSt5KdNesXXLvKvXqXDpMDBVSMgBOJZ2ZaYd0NcsWZt198PN6UMvg8bsZFBkWknkKXDfXgAYz
	GDD2rXTjzGqRu10e92MlF8lck5F9AoyRVyaR8
X-Gm-Gg: Acq92OEAg53YOvDGhDdz6ZjYDxkA8RwBYFfwy5T3oGgtUS8xSzixN/HEUXuA3/ej0zp
	iKXJo4s3WLVMbsFC5n9btK+w17/+tynTH9oraO3K82Wn8kuhPGr5pgXJ7FxFP0D43x0Jwjtkxcp
	zWQS3RgyEqc79ErgIo98SlbokQq8oOlb//CQfnewjMyesIGnQJXL7FelX1qpQsHVhapAZALPASN
	yKywsLwu44zkIf4fOseB8451cx2r9fg2LDC62uT5oengpnkeFwTCbkSKL9wu8tPurJoZZl2Frkf
	YaGOW9/+4p0FZjdQo7tOCVua8/84FguwDSbbiQ0gVwkCmexJnreKYjfgpV51TGEVMvLLPTnjQeW
	1YGVfnysjJE2bG/AaX2uZht+TGw==
X-Received: by 2002:a05:6808:1b2a:b0:485:467f:a306 with SMTP id
 5614622812f47-4872f352d35mr5966220b6e.4.1781411555138; Sat, 13 Jun 2026
 21:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
In-Reply-To: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 13 Jun 2026 21:32:23 -0700
X-Gm-Features: AVVi8CeNpeImZU0FTDFavdX1xK0yi3iNMhdY0JtDCwonIYPTsk5LtoubyS9_PFY
Message-ID: <CABPp-BGq8a-3ocJ+1HCgJutw1SBUvFg6YxtUamryfgEMx3qDYQ@mail.gmail.com>
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:18=E2=80=AFAM Kristofer Karlsson <krka@spotify.co=
m> wrote:
>
> Hi! I previously sent a patch[1] to optimize paint_down_to_common
> for the single merge-base case. I believe I have found a stronger
> optimization, but before sending a patch I wanted to discuss the
> correctness argument.
>
> The main problem to solve is that computing merge-bases is slow today
> in some scenarios, especially large monorepos with complex graphs.
> This affects multiple operations, including merge-base and merge-tree.
>
> The previous patch improved it for the special case of the
> merge-base being part of the commit-graph and the caller only
> needing to know about one merge-base.
>
> I have an idea to make it faster for fetching all merge-bases for
> common flows in large repos, as long as the commit graph is
> reasonably up to date.
>
> The key part is the exit condition in paint_down_to_common.
> Instead of waiting for the queue to only contain stale entries,
> it is enough to wait for one of the sides to be exhausted,
> i.e. side 1 is exhausted if no more commits exist in the
> traversal queue flagged with only PARENT1. For example, if
> the two sides are origin/HEAD and a small PR branch, the PR
> branch will quickly become exhausted at the merge-base, while
> the main side will continue.
>
> Now you may ask: why is that a safe condition?
>
> The traversal in paint_down_to_common has two logical phases
> due to the priority queue ordering:
>
>   1. Process all commits with infinite generation numbers.
>      This includes all commits when there is no commit-graph.
>   2. Process all commits with finite generation numbers.
>
> These happen in strict order -- all INFINITY commits are popped
> before any finite-generation commit.
>
> The optimization only applies after the walk enters the second phase.
> In the first phase, the traversal behaves exactly as today
> and uses the existing termination condition.
>
> In the second phase, traversal follows strict topological
> order -- descendants are processed before ancestors. Paint flags
> propagate from each processed commit to its parents, which have
> strictly lower generation and are therefore not yet examined.
>
> A new merge-base candidate can only form when a PARENT1-only path
> meets a PARENT2-only path. Once a commit acquires both paint flags
> in this phase, any descendant carrying both paint flags would
> already have been processed.
>
> Once one side is exhausted from the queue, no new meeting between
> pure sides can occur. Any commit that subsequently acquires both
> paint flags must inherit them from a commit that already had both
> flags -- it is deeper in the graph and cannot affect the final
> merge-base set. We can stop.
>
> On a large monorepo with previously expensive merge-base and
> merge-tree queries, I observed speedups ranging from roughly 300x
> to 1000x. The nice thing is that this works for merge-base --all
> and every internal caller of paint_down_to_common -- we no longer
> have to restrict the optimization to finding just the first merge-base.
>
> Does the correctness argument above hold?
>
> Happy to come back with a patch later if the logic holds and the
> overall approach is wanted.

Wow...it appears this optimization was discovered by 3 separate people
in the last month.  This optimization was implemented and is live at
GitHub...but it feels incomplete to me because my version doesn't
handle both sides having an infinite generation number (it just falls
back to the old algorithm when that happens).  I had meant to fix that
and then upstream it, but other fires have been keeping me busy.  And
I'm about to go on vacation on Monday.

I uploaded my version at
https://github.com/gitgitgadget/git/pull/2150.  Unfortunately, it
conflicts with your recent good work in the area due to being based on
a version of main from about a month ago.

Do you want to take this over, rebase it, and extend to the infinite
generation number case?  Or do you want me to rebase and see it
through after my vacation?  Or some other mixture?
