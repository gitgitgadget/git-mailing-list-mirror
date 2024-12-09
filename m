Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24A1BDC3
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733704453; cv=none; b=Ds7h+U1u2Qj1QaFjOLW3NO6dNQI0jRdMO5b2p3EwWm6hnJiXYRamqGQ451gT70EPNd2USYqpT9Ja5DCWyYTH3H/PGtuXhBFemNcozmNabRdTCD+jPdzIcjUYyVEc/odslRz82SZIFUEnb82lS+Y2uSgJdrRZQzX3Op69uQzgJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733704453; c=relaxed/simple;
	bh=cbv8z/2AIXrb6U7QWj9r4c2lpbngwmKDfCCyUzu6T3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0Zglk+8/lqcNZzw6UI2M6NyGu4kXHkpEXxCgMQQ4fwtNAMVANA2pmyIexgPbs+VGOWayTpIGarYYGXA2v4dMmZSLXWMEoRx1lEhzsEAzyoLipUZW0S26Srb8aWH/0t0mxeXTLy/nV01G3/zZWnELZUhvp/6fUUUkJl9k7rGVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hXzfX2Q/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hXzfX2Q/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AB14113838EF;
	Sun,  8 Dec 2024 19:34:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 08 Dec 2024 19:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733704449; x=1733790849; bh=6x09c++jCR/zrIgmOQqEA2q11AncR8oY8wz
	BWcVciBw=; b=hXzfX2Q/IZKWdEnwLg6d6AvJN0Y8DVSzvFFX1M8dsh2t5CRx8Qp
	ALKEEoTM/i2lrFwPCykbwKg0uEjgsv14TFTL78+pwqPJSkfBgZJ/4cD5wdm6IicQ
	pDXutDU93nMXrnqA0ikBrI5ezx4pXarCP8wR8OWamroRdlGXQ25j5E4VO66jIXUy
	Ryo5CI7I+tmvLt4voEpt5PRl30zOuRzmEdkcaJjS0jAnza+nWLfC81jaE1AVflf2
	013SnE3tldfj+DldZMafoYoY57aTYkaYAOxBGRd3XMmhcY70qMi/e92ZDxeyevMR
	GANWhzKgGjnsIY+U/2FCwpRZn1d8eSlJz6Q==
X-ME-Sender: <xms:ATtWZ7KElCtWAA1ke_JK4sW-0PymDyb6Aztmhhg25-0NIPBLiprhmQ>
    <xme:ATtWZ_KHgvUbaQaXqItHmlhwF8a3VJ7vn-OJucs20691eWSW6ew73CYqib_wU7MxE
    4siEOIZ8vyOuX3B7w>
X-ME-Received: <xmr:ATtWZzumL_Vw6Ie5yZlsyMvlbfCt4xHAecmAHEi3cHCdh1MGdxQsG1qeATrSYe5xR42AejWp43yX4h9AO9qZfJIm8ysEH7FUcj9KFH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeetheetgedtveefveetudekhfegvdfgkeeiheej
    teeludejveekteeitdfhfffhgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgsrg
    gtkhhfihhllhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepud
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:ATtWZ0Y16uGISu3AX-_TbSmcgZ6wMNcZgJ3JELhF0OJdkrrKVF9CeA>
    <xmx:ATtWZyZXYakQVKloZSvVjxE2bbYB34fORHu2vxn66rQLj_NVJR0_9Q>
    <xmx:ATtWZ4DbrF4ku8WDM_puWiwa-KsAOlkXmuAcz-Q_6MjNZiwJ2p1zAg>
    <xmx:ATtWZwYHbGlj-BfboPFyHDv9oohBK1F1ma8OyBbNkECIV1vCGYCiGg>
    <xmx:ATtWZ4wdA8Y5hQpTooidCmuTsQeUjJzAUwGMK5_Bwoc2XzISA8BARjT_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 19:34:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  christian.couder@gmail.com,  kristofferhaugsbakk@fastmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 0/5] PATH WALK III: Add 'git backfill' command
In-Reply-To: <xmqqy10qqwco.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	08 Dec 2024 19:53:43 +0900")
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
	<xmqqy10qqwco.fsf@gitster.g>
Date: Mon, 09 Dec 2024 09:34:07 +0900
Message-ID: <xmqqjzc9r8xs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> It seems that the result of calling init_revisions() from backfill
> is leaked?
>
> https://github.com/git/git/actions/runs/12218430154/job/34083929479 
>
> I did not dig further but the below is from my local leaksanitizer
> run.

The attached patch seems to plug the leaks observed by your backfill
tests.  If you agree with the implementation of the change, you are
welcome to squash it in.  I may be missing a better mechanism in the
path-walk API that I could use to plug the leaks, in which case, of
course a fix using such a better mechanism is very much welcomed.

A few things I noticed about path-walk API during my poking are:

 - struct path_walk_info has PATH_WALK_INFO_INIT() macro, but not a
   matching path_walk_info_init() helper function to help initialize
   any heap-allocated instances.  In general, anything that requires
   _INIT() macro by definition wants to be initialized with more
   than nul-initialized (otherwise, it would be fine to leave it
   uninitialized in the BSS, clear with = {0} initialization on the
   stack), so lack of matching path_walk_info_init() raises an
   eyebrow.

 - struct path_walk_info seems to lack a destructor.  In general,
   anything complex enough to require initializer should have one.

 - lack of destructor for path_walk_info requires users to release
   resources held by "struct pattern_list" instance at pwi.pl; if we
   had a destructor, we wouldn't have 2 of the three leaks we had to
   fix here.

Thanks.


diff --git c/builtin/backfill.c w/builtin/backfill.c
index 225764f17e..1cf2df9303 100644
--- c/builtin/backfill.c
+++ w/builtin/backfill.c
@@ -92,8 +92,11 @@ static int do_backfill(struct backfill_context *ctx)
 
 	if (ctx->sparse) {
 		CALLOC_ARRAY(info.pl, 1);
-		if (get_sparse_checkout_patterns(info.pl))
+		if (get_sparse_checkout_patterns(info.pl)) {
+			clear_pattern_list(info.pl);
+			free(info.pl);
 			return error(_("problem loading sparse-checkout"));
+		}
 	}
 
 	repo_init_revisions(ctx->repo, &revs, "");
@@ -113,6 +116,11 @@ static int do_backfill(struct backfill_context *ctx)
 		download_batch(ctx);
 
 	clear_backfill_context(ctx);
+	release_revisions(&revs);
+	if (info.pl) {
+		clear_pattern_list(info.pl);
+		free(info.pl);
+	}
 	return ret;
 }
 

