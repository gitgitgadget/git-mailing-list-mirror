Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280FD3FC5B7
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491819; cv=none; b=rT+fZ4WeneLFU6wwbpDluVP7GMMpURghRWeo/C/NoTFjn8LuP2bzEWYTz+bGOLjSG4+8bUYtd8d+uLvPCizuoOOlD64T5f5F6772BZ168EfmOImaU0J7M6JpqKwKNpUoA7YsUKI1J6riNaTat2ezTwNES2LHhrV/gKD5CvTSmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491819; c=relaxed/simple;
	bh=YDD0vMpMj/lHV40X8+CDVGRKGrAh2IV1Sn3hqBbbrgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ndg9gphX9HL3Wo/rLcpurmw5wf8KT4I9ZMsry4PY/2Kqd/aHIynWZoVxf/3Fa8lBUWN95El+Cp2ULbzevf8f+0XF3KSeybYxDxDG+ulX6zlsUNjTWOIsaBB/TXqOfObMfTddB/So8I6AFAk6as6dd2GuguGh2ipIYrWhLXCyZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GE6Q/m/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWX6LE2T; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GE6Q/m/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWX6LE2T"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FB3C1D000E2;
	Fri, 26 Jun 2026 12:36:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 12:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782491817; x=1782578217; bh=rmP8EyN7nP
	EyANHdGydgTZGwz97P7o7kvcNllET5zmE=; b=GE6Q/m/q7efwCam99nt3AxHJM5
	EXv7BEKoiCknDKs//VbFNDu4tnfiELjKFCCTTDWaDLiTg/e1mdf0sNtHgoCJjrIj
	pnJ0vsYVEyxc8UMsJCsCByud6W3Jgwdr48cp9gB57aYQ6fHohppQd+wcb6sTaN4c
	98V3Ti86Cz9uPGaLO8fP3QSc3VUCAm9svM/6sPJC5PDmcylWaFauSoix7OznZiXY
	UHlR/o4RHVBevHxwuux8O9Tc7pwHlaePPtXumSSj6r6WmWP+foghfe9AfXRYngQV
	vyp3D92Px7QyEcCmx8kNrUhVrFznz9kLVDWDJA7PFu8qDT23Xproo3np+WfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782491817; x=1782578217; bh=rmP8EyN7nPEyANHdGydgTZGwz97P7o7kvcN
	llET5zmE=; b=hWX6LE2TTqVxP2cPhVe9z9pyywM630L9Rrk4Ztn86/5YPIzODM0
	3+SnUwT6to4cGuEzjAoUN19eckaonZHwJYGAuFrXSsxh4Yqotdtj0bEJndaTW6m6
	yQpR/i5NtIDZlIykuQsf1XW3QZKCD7f0eeVoSrDHIoK7nrmUPVeeLvXsZQfv7dWl
	dfO2qwsJEyJkKBXdd0nFiLOQpYgXd0SujHiIZTiDNB79RIoKNUVV7aySz9kVi6Cz
	h87AvOQRQgJ3DTKFSam4l22/OGY426YrrOFRy8PynKV4pwnvxKkERUtP0pOm/h94
	Klc2H2BL1UQSzhVYJ59D0Q2qMKYHQHU5unQ==
X-ME-Sender: <xms:qao-akg4zQPd06rNy0u-Yg72yzWLujD9EEPqLej5K89CDVQ0oykClg>
    <xme:qao-agvowkjXauMCZvnu3twQT6PrUMGQSnLqFkiSwQTbIpVVxkp_Ii3UkvABQMNkV
    5Ge-Qgj31_h3tC1IF4fbEIezS425fhHfKzPhI0LPii1-9ozIjpDig>
X-ME-Received: <xmr:qao-al4JXtTwmrdxVIrucOXn98ary_lN29Hppm_ixCXyqwyIJoHQiK-TpzROeH3-iG80VAWLeOshca6r-QS0vmjSP7icINjxZ8kK7CY>
X-ME-Proxy-Cause: dmFkZTGF5XvJXOG3wrroBb5ckLDJLHsYnsoecBfrUPx1CRQVjxbLQMTxgHdn7NHsqMY1Qt
    BWCH//BKt7H/VB+8BifqQ4TgXenvaxoF87wfsXs0cGtGjlFDqYIDDRnBWiamvbE77+EgYz
    SisnQrEB6TRSQ/sza0lE9CKabX9NKU5hvXY5qUYHNkZwoR8SLtt9av49vN2EX+mEtVWBzi
    EgS5HKmRsSHbX92FmWRrsP8MQsCv/m/sQSDBV+/5eQYMRauxBiPl47mjtidCoMF0Z6JPoz
    DJ26484Na79WBrd4KbuiW2NoPx9BNCaYtMWGGl6y5Q1uC5VfDw0nWz68jvZ5Q5561zpQHY
    TO/SLZWmAcp9uIVDFwAVOQan1D5pV+3K3MehQgai2sRdtftpHxDFCMqqDilgQZqbaB5cPN
    Uxn8aSpPub4VoPi6qf7+I6Vj5MXOWsngGR1usD5mOrCK/rgaCBa0Wg2bBPNEopeLe1Hi0T
    WwVVKCqkiDxQjbj8wEUMu5AiqUHk/B4mLKZoRU0bHeiKKMKxOmhlkv3egcQbMsPAjgjqSJ
    9fUE19IBn/x8EYLkfBAq8ox7DLEeVUTSCSWssVICLCtEXFFEv5F1ir9j26OyikCSi3G7dG
    H7arexFa6TUu6633MuCcl08JghY2laOcD9xWoS8sihmH1sfNkq69qkzGkidA
X-ME-Proxy: <xmx:qao-asPgCfMhwgJDqJYTQ3IK-Fqhe5lfzXpNybxtQ9Vr-aS6Uh-1QQ>
    <xmx:qao-aju0XQ_M8P5eTMlpotm7RO6jdZ3Nm0k6hlXmDVnrkatUmoBEMA>
    <xmx:qao-avbdZpotfQH-Y2bv1dYKd8y3HZzxVh2ZHsH8bIP8xodyao1mIA>
    <xmx:qao-alz8ByptG6rGJKVcZha7b5L3_v_jGZg9JJ5RO2MsB-0mhsqKsg>
    <xmx:qao-aoQnNMw0mHr10MTXPePhzjMtNjen-nvvtfEcqFMmvILHCjmg6NbE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 12:36:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3 0/8] commit-reach: terminate merge-base walk when one
 side is exhausted
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Fri, 26 Jun 2026 13:07:57
	+0000")
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 09:36:55 -0700
Message-ID: <xmqqjyrl8di0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v2:
>
>  * New patch 8/8: moved the min_generation termination check and the
>    last_gen monotonicity assertion into paint_queue_get(), consolidating
>    halt conditions. commit_graph_generation() is now called once per
>    dequeued commit and shared across all checks.
>
>  * Widened the generation-monotonicity BUG assertion to fire
>    unconditionally, not only when min_generation is set. The side-exhaustion
>    optimization depends on correct generation ordering, so the assertion
>    should always be active. This is a behavior change: the BUG() now fires
>    for any generation ordering violation, regardless of the caller.
>
>  * Moved all halt conditions inside paint_queue_get() with the "pop first"
>    form: pop, check, then decrement counters. This keeps the optimization
>    commit's diff minimal (just inserting the new checks between pop and
>    decrement).
>
>  * Shortened the doc comment on paint_queue_get() to describe what it does
>    rather than how. Inline comments on each return NULL explain the specific
>    halt condition.
>
>  * Replaced the manual commit-graph setup in the step-count test with
>    run_all_modes, which now sets GIT_TRACE2_EVENT per mode and produces
>    trace-mode-{none,full,half,no-gdat}.txt files.
>
>  * Added a test_paint_down_steps helper for concise 4-mode step assertions
>    with diagnostic output on mismatch (prints "expected X, got Y" instead of
>    a silent grep failure).
>
>  * Added step-count assertions to the single-walk edge-case tests:
>    in_merge_bases_many:self, pending-stale, infinity-both-sides,
>    mixed-finite-infinity.
>
>  * Included step counts alongside wall-clock times in the benchmark tables.

I am getting this failure standalone, when applied on the same base
as where v2 was applied earlier.  For now I'll eject it from 'seen'.

expecting success of 6600.12 'get_merge_bases_many': 
        cat >input <<-\EOF &&
        A:commit-5-7
        X:commit-4-8
        X:commit-6-6
        X:commit-8-3
        EOF
        {
                echo "get_merge_bases_many(A,X):" &&
                git rev-parse commit-5-6 \
                              commit-4-7 | sort
        } >expect &&
        test_all_modes get_merge_bases_many

BUG: commit-reach.c:152: bad generation skip 9 > 8 at 772be737f220103f706a39013c0d115009feefec
not ok 12 - get_merge_bases_many
#
#               cat >input <<-\EOF &&
#               A:commit-5-7
#               X:commit-4-8
