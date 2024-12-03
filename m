Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A35A32
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733199542; cv=none; b=FaVQtFHiT+424oU12eSnM3ZTy9JHo93XdLIaTIw23vcazYjnSQvGu3n6q8O+PpK6MA4FWJy+PaXLQeQFHO+pVAfyJ+hhdQ9uLuSPLTploLiLYnT2rCL4f1DCAaSU9nEMgXYHfFYuG3Lhs0SiQlyNFFPM01bqs0rcRyW4BAhI1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733199542; c=relaxed/simple;
	bh=tJy2dEb2+VqGELLsZF/+aaZmOzH3XtIjYLsDGDO1Xi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6eCI+jibI1/cCbUPZ8CIW3hp8SkbPJAClkXGZ43pbKFj8F8t+RJfw+iPEyulFPe+m2vYtBamJzCN0jgFEcs5TcNwdj2L7+s8G9cz42kpmEhr3PVdU2C8YDvgeuAzjmmBunpP6whi/qfrB8O48B3sc40uPc1ByOOdJebPB7yhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ob8feP/L; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ob8feP/L"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CFA3F114016C;
	Mon,  2 Dec 2024 23:18:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 23:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733199538; x=1733285938; bh=exgz/RNfze/kOpJvy5jbeBi5/U+kSN4DZnr
	RqE03SHc=; b=ob8feP/L57kL9bUnl9MRf0hSQOodd7dmKHJSugeFYT3kr5VepA0
	WXTnqO/exbtJtl6sY9Mq7ksO6bKlZxHKn0FMwg01Y+QWKP0ZDTxzelmGtbm8qzwF
	lGeBtsPtFxjt0SvosF2vRmcX7EChHyi/KqAhXrUabhh5pliJiPyaLls4S/8fWPOW
	8tc4l15pV6stezukRFOnaHyC+RcdI7jpDTPzUfUb1elI3mzbpiQDOXknB1mqWjnN
	xDweJO6s5hCkTxGPcqjh4efyDs2asXRxMDMYy36sXtaHNO8fK01qLl6DFZk80Qdq
	mXmI5gUonf0whDV0kwf41cErVz1DQQs8lvg==
X-ME-Sender: <xms:soZOZxBABMpF2rzkp1J3-Xe-IsnCJmcJ7N3B_u3dHUhM40J-4-YXbA>
    <xme:soZOZ_jCEww9xMfYH-1KqzP-y5o1BLo5TuQuqMkcZEGklgDOz-Zk7NWiOCAb1e6V4
    C-46fO1eQNM4rB2Fg>
X-ME-Received: <xmr:soZOZ8krlakmt8wMsBDKJzxsF6qpMTyrFSL2Fu5PYeS1Tjxa9ZbDahOJwgUun1-t4w6NWRzKGFIcymo0DRUbzPs-aV2xJp_-hrvFe1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptedttd
    evffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurghntg
    gvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:soZOZ7ymCSq2oCj6mx-JIjKfEa26nNSOKPhe5F44ANyqQhgYU3B_GA>
    <xmx:soZOZ2SqfItuSSHYoHO8I8sUIDlwoKgRoyZ8nEAKprKSdidbeFv6zA>
    <xmx:soZOZ-YAQbJg6tM_ri-oTP5BJQ_ShdMAwHqjUMYHJmogkKp0yNFzzg>
    <xmx:soZOZ3SXIQctgLoy_9skLc7AYyQQ-kDOnrCbN8aPlU5fIk5DMPd7hQ>
    <xmx:soZOZ8MgGw3rBa_RTrM8UIfRpEB1UTuuFCY5Ke3jDll9FpUTfzxZM39N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 23:18:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com
Subject: Re: [PATCH 0/3] Performance improvements for repacking non-promisor
 objects
In-Reply-To: <cover.1733170252.git.jonathantanmy@google.com> (Jonathan Tan's
	message of "Mon, 2 Dec 2024 12:18:37 -0800")
References: <cover.1733170252.git.jonathantanmy@google.com>
Date: Tue, 03 Dec 2024 13:18:56 +0900
Message-ID: <xmqqr06pe6vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> This is a follow-up to jt/repack-local-promisor [1] (but these patches
> are based on master, since that branch has already been merged).
>
> These patches speed up a fetch that takes 7 hours to take under 3
> minutes. More details are in the commit messages, especially that of
> patch 1.
>
> Thanks in advance to everyone who reviews. While review is going on,
> we'll also be testing these at $DAYJOB (I've tested it to work on one
> known big repo, but there may be others).
>
> [1] https://lore.kernel.org/git/cover.1730491845.git.jonathantanmy@google.com/
>
> Jonathan Tan (3):
>   index-pack: dedup first during outgoing link check
>   index-pack: no blobs during outgoing link check
>   index-pack: commit tree during outgoing link check
>
>  builtin/index-pack.c | 49 +++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)

When merged to 'seen', this seems to break quite a many tests, all
related to "pack".

I haven't tried running tests on the topic stand-alone.

Test Summary Report
-------------------
t5310-pack-bitmaps.sh                            (Wstat: 256 (exited 1) Tests: 230 Failed: 3)
  Failed tests:  26, 100, 179
  Non-zero exit status: 1
t5327-multi-pack-bitmaps-rev.sh                  (Wstat: 256 (exited 1) Tests: 314 Failed: 6)
  Failed tests:  25, 70, 136, 182, 227, 293
  Non-zero exit status: 1
t5616-partial-clone.sh                           (Wstat: 256 (exited 1) Tests: 47 Failed: 3)
  Failed tests:  5, 38-39
  Non-zero exit status: 1
t5326-multi-pack-bitmaps.sh                      (Wstat: 256 (exited 1) Tests: 357 Failed: 6)
  Failed tests:  25, 70, 146, 199, 244, 320
  Non-zero exit status: 1
t0410-partial-clone.sh                           (Wstat: 256 (exited 1) Tests: 38 Failed: 4)
  Failed tests:  11, 14-15, 38
  Non-zero exit status: 1
t6020-bundle-misc.sh                             (Wstat: 256 (exited 1) Tests: 30 Failed: 4)
  Failed tests:  16-19
  Non-zero exit status: 1
t9211-scalar-clone.sh                            (Wstat: 256 (exited 1) Tests: 13 Failed: 2)
  Failed tests:  4-5
  Non-zero exit status: 1
Files=1031, Tests=31721, 324 wallclock secs (11.58 usr  4.57 sys + 674.15 cusr 6136.28 csys = 6826.58 CPU)
Result: FAIL
g
