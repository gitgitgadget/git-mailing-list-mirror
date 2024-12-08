Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681353389
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733655229; cv=none; b=NlWUmplndqeQ3hgKd+j1b4cWerYDnFjeL4v3k1PD4UXzIXT2TjpKaFc5hAg4NNUCCpYJlK+btdpdUPf7sUrhJ77b+bZqyRMGJ9uYKZEAXq6/OsM6PfOlE97x93bN/J/35lgOwokHRHKkYPyrvLi1RuOzsFduxHB8JUytWzr1Td4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733655229; c=relaxed/simple;
	bh=d8yesOAoRuBtd1KsNUdEcxfZ3O6S8z17JRgtfvbxN0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4WdikEWGqXhuH9oE5B/PogHR4Tty+ZE2lsCaQlXuYCNwhXp6Xdd50E8TziusM9dXrv1miy1bNH3VCp/vfULOSSvtntd4+LEKalFKUvzOMrpcaAriEXS14odd0UOTQt6E0MpquuNboKyXZtRs2dzWpeOHrJGczW7teGuEPpViQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbAN/Flx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbAN/Flx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B983D114013D;
	Sun,  8 Dec 2024 05:53:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 08 Dec 2024 05:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733655225; x=1733741625; bh=hdn4SimLPf7i4jNFWXhWqUblisgbtu+q2IT
	IBtyUEo8=; b=JbAN/Flxvnkq4us5k0ZpzHPWrYdscbOQjKbnQpBwyLx0rPnnfRi
	HD5SXWavt7uyWT7PnCOpeGLbuLIBXoIFshlwKseU3gzcJYvKIiuBlbzHnq4PgNOh
	Ngtd5wC4GWNmycBXWO9PEK2Tt/2Fzv37ybS52052HH2mxS4t1QEcHq0O8ymx+m9f
	fGShHi0SjpoNp9GJSy/VkiBvpAeqWweju3FgvMwJmTnedlABM7Lt8RrdFSXlVHUp
	zIvRytUDRCzZKuIL1A141vwcKOGK+7rIwuSXY5igc334LxdwiASHHrHHkeDnhjGv
	Jg9w8StLOfNyPxahvB4YY1ee5/Eh6pK1fMA==
X-ME-Sender: <xms:uXpVZyDJFXC_HEriUnjawyBW_E2D6eQs50q0RTOc94HB3gj4CyH0cg>
    <xme:uXpVZ8h-b70tKQRoziMoMgNeZzZGWxGcxSmd9UmlkTh9u9PyvvgNJ_rHqUjf-BGdy
    O1UcZnzcPyskk-gMQ>
X-ME-Received: <xmr:uXpVZ1kDIRxzKt5DQ_26CcIYMnzjVQzmdHXbd6fBKJeUTpXma-mqpl81TyIPeMv00tBRP6LE9cD7l3Z2iWVGN500BtxVISXiy5BJAqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeefhfdt
    vdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uXpVZwzP_yuPNQRFB3eFAU6zUBUDBXZ5QA75ouq1QU6lNM5KWURC_Q>
    <xmx:uXpVZ3S0QxPUh-aTL2eo4eeCIvAw8dbGJ5dDB0_IrurbpzfotMJSiw>
    <xmx:uXpVZ7apynteNKannS9zfQKDMGiSQIM_jVdO8zfgEshZJwhA8uB8dw>
    <xmx:uXpVZwRYKYR49BkVODYxNoPxMhWaY-_IZKBGTwlZOgeyR__AbS2vDw>
    <xmx:uXpVZzqpPOOXXhVwyeVeYkYg7pKA51Dqjc-CUE04_PrE6wmjmcS7ZxCO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 05:53:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  christian.couder@gmail.com,  kristofferhaugsbakk@fastmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 0/5] PATH WALK III: Add 'git backfill' command
In-Reply-To: <pull.1820.git.1733515638.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Fri, 06 Dec 2024 20:07:13 +0000")
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
Date: Sun, 08 Dec 2024 19:53:43 +0900
Message-ID: <xmqqy10qqwco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

It seems that the result of calling init_revisions() from backfill
is leaked?

https://github.com/git/git/actions/runs/12218430154/job/34083929479 

I did not dig further but the below is from my local leaksanitizer
run.

Thanks.

=================================================================
==git==182342==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 576 byte(s) in 1 object(s) allocated from:
    #0 0x55d4b0e42915 in __interceptor_realloc (git+0x84915) (BuildId: c861e65ec43b0a3ef46b9555a81d6ddfc2358e8e)
    #1 0x55d4b119ce6d in xrealloc wrapper.c:140:8
    #2 0x55d4b11204d4 in add_rev_cmdline revision.c:1563:2
    #3 0x55d4b11187a1 in handle_revision_arg_1 revision.c:2263:2
    #4 0x55d4b1118398 in handle_revision_arg revision.c:2275:12
    #5 0x55d4b0e5233b in do_backfill builtin/backfill.c:100:2
    #6 0x55d4b0e52253 in cmd_backfill builtin/backfill.c:146:9
    #7 0x55d4b0e46b80 in run_builtin git.c:480:11
    #8 0x55d4b0e45502 in handle_builtin git.c:741:9
    #9 0x55d4b0e4649c in run_argv git.c:808:4
    #10 0x55d4b0e45274 in cmd_main git.c:948:19
    #11 0x55d4b0f6da8a in main common-main.c:9:11
    #12 0x7ff25f97ac89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #13 0x7ff25f97ad44 in __libc_start_main csu/../csu/libc-start.c:360:3
    #14 0x55d4b0e171e0 in _start (git+0x591e0) (BuildId: c861e65ec43b0a3ef46b9555a81d6ddfc2358e8e)

DEDUP_TOKEN: __interceptor_realloc--xrealloc--add_rev_cmdline--handle_revision_arg_1--handle_revision_arg--do_backfill--cmd_backfill--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main--_start
Indirect leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x55d4b0e424b6 in __interceptor_malloc (git+0x844b6) (BuildId: c861e65ec43b0a3ef46b9555a81d6ddfc2358e8e)
    #1 0x7ff25f9f34f9 in strdup string/strdup.c:42:15
    #2 0x55d4b119cb14 in xstrdup wrapper.c:43:14
    #3 0x55d4b1120506 in add_rev_cmdline revision.c:1565:23
    #4 0x55d4b11187a1 in handle_revision_arg_1 revision.c:2263:2
    #5 0x55d4b1118398 in handle_revision_arg revision.c:2275:12
    #6 0x55d4b0e5233b in do_backfill builtin/backfill.c:100:2
    #7 0x55d4b0e52253 in cmd_backfill builtin/backfill.c:146:9
    #8 0x55d4b0e46b80 in run_builtin git.c:480:11
    #9 0x55d4b0e45502 in handle_builtin git.c:741:9
    #10 0x55d4b0e4649c in run_argv git.c:808:4
    #11 0x55d4b0e45274 in cmd_main git.c:948:19
    #12 0x55d4b0f6da8a in main common-main.c:9:11
    #13 0x7ff25f97ac89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #14 0x7ff25f97ad44 in __libc_start_main csu/../csu/libc-start.c:360:3
    #15 0x55d4b0e171e0 in _start (git+0x591e0) (BuildId: c861e65ec43b0a3ef46b9555a81d6ddfc2358e8e)

DEDUP_TOKEN: __interceptor_malloc--strdup--xstrdup--add_rev_cmdline--handle_revision_arg_1--handle_revision_arg--do_backfill--cmd_backfill--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main--_start
SUMMARY: LeakSanitizer: 581 byte(s) leaked in 2 allocation(s).
Our logs revealed a memory leak...
++ rmdir /home/gitster/w/git.git/t/test-results/t5620-backfill.leak
++ :
++ exit 134
++ eval_ret=134
