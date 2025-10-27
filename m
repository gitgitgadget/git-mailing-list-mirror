Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FF2EFDB2
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553888; cv=none; b=Cn2ldkd6neTxdXbUKCXaDEx2Psjp+dvlgy9JXtOYMRkEMQSKdXZwTz2kmQvy5AoVWfUePWidOCbmyWlEDrFB8+NUkIQ/89edFFUuuLaEZBcD/Lzc0TwkTrRjbQjbNMmFRU8S3VXj25qBrBv/IJ0AX7ZEFanbAQyT7nT2fr78Qn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553888; c=relaxed/simple;
	bh=E8/91QDjNO/WPgduPhRndheoTPtbOljxleZnEfaUc/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jleyPCjrc5qXxBNMZc75jlujQrBYTP5HZeycqTTwJZzpC8FeNTtidxAIHAyTVlNZYEBSp/adFJwYk5Ijd2tBuknxXyBarkobcITADg5KqF3Mc4EFcfuSzTheYl66IEX9PynK5qDWtwd5bLYQ+DfG5wp5riolZqXPYaPXnGwpC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pGiCOh/b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RIBZjgRZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pGiCOh/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIBZjgRZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01621140014C;
	Mon, 27 Oct 2025 04:31:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 04:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553885;
	 x=1761640285; bh=vmMafV+w5tJfri/mPJGfb7tRGG04y/vGJMKX3lUc8PM=; b=
	pGiCOh/bZTGyl9y3vb87qKdiH8LYhlfqw98pas3viWqimiIPCRWmGAn9LGCBNDZv
	nVp5PZMoiGGmqna9HvDkbdUaEetilG+mIUaO2giymh2POx6b40bqDvS8r4SDVofp
	P1AFBpEKNXwnBgsbk5F0S1bdd/jnpIPpx2kbKO0uG/8ea0a3zloVoRl6jSe+l3pn
	hPqyhjDfYpGhmVdrPtEO2CglXYqKLZ6gXnGJoR2Xwd51vjV2ukHUHWo+DSXHFcpv
	mtgXNzdkL73FwAJEd73QrxziIamOj2pedAwUXJwNnGHpe5m2R7SMzzGlzyc/GDHs
	PpiT6o0AI/brL7klbyrYUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553885; x=
	1761640285; bh=vmMafV+w5tJfri/mPJGfb7tRGG04y/vGJMKX3lUc8PM=; b=R
	IBZjgRZc1AGbO4jaEieKb0KaYIMzUe1ifisKdV+nKcriCKZNbw2wKfNxQKt48HyJ
	UHOvdv0QZiBpd/xU9nza5r+k4IzWccaMinuSiNPbe3JWd+rYtnEnT2SvaCpMIXsZ
	/TMtE1yST4HWoinyOaf5BcsD2rKmcxA7Z3o0Kxx2+aQ/BeU/YAD+NI8AfwNutcep
	D7sY5IqQ3GrI/nPoDHbgs2IECTIU/3pGvFvyBC+sUErDLiBDukujATroiRCv8xFJ
	z4xDDX53e0W6lnuWFIftRHsHAw5TmZSlWtmcLtrqOgMoCz+quO2MV95SFwV61eG8
	twSnTBDj3wAeCUsxApONg==
X-ME-Sender: <xms:3S3_aI4tUSP-ZhGoSSzVdbc6Uf2wtgITFVc21fa8HHWMTYYfT_bjig>
    <xme:3S3_aAzgkjY8WH19QG_VeipgdhN4DgIEq4uG7bJZgD6vQiX-AZVcqrOs2ryNOoXjZ
    ghsvPIKbQYmHewHsKtUQR-NqIf_cXNjS-OcjhKxRUJCa7N5jfXZFA>
X-ME-Received: <xmr:3S3_aPy_9scVeTWxVwF_K8nrruZcBoS4gR8aTkl2DRn8JziShd2s52Mlgmi65LvnV4z39Vk9BAzBlTF3zffeX02tLI1k-9RkCfmy33o2RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3S3_aIxQfd440-sSs6xKWdauySrOs_XGxOHwDw-TRsHZhhG6NE35dA>
    <xmx:3S3_aJbQ3i8ErU5KWNMxQPf87PBgl82MPpdq7-e8elZ4W4YwjsabeA>
    <xmx:3S3_aJXtifPJ1fVRksM1Un49Io1rhGyCBzj6Y0pkEJLDUYOVLtvS4g>
    <xmx:3S3_aHhOwy6wxo3xBWR9yLU_PGggKdmEQdUixw9w78eAgpiFPqIKyw>
    <xmx:3S3_aNKUZhuxbDluA4oiyRLHd6G0AHiKJplBGPx469_TDYmJNwUG8IQz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee23214c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:59 +0100
Subject: [PATCH v4 09/10] builtin/maintenance: make "gc" strategy
 accessible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-9-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

While the user can pick the "incremental" maintenance strategy, it is
not possible to explicitly use the "gc" strategy. This has two
downsides:

  - It is impossible to use the default "gc" strategy for a specific
    repository when the strategy was globally set to a different strategy.

  - It is not possible to use git-gc(1) for scheduled maintenance.

Address these issues by making making the "gc" strategy configurable.
Furthermore, extend the strategy so that git-gc(1) runs for both manual
and scheduled maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  2 ++
 builtin/gc.c                          |  9 ++++++---
 t/t7900-maintenance.sh                | 14 +++++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b7e90a71a3d..b2bacdc8220 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -30,6 +30,8 @@ The possible strategies are:
 +
 * `none`: This strategy implies no tasks are run at all. This is the default
   strategy for scheduled maintenance.
+* `gc`: This strategy runs the `gc` task. This is the default strategy for
+  manual maintenance.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the
diff --git a/builtin/gc.c b/builtin/gc.c
index 3c0a9a2e5df..8cab1450095 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1843,10 +1843,11 @@ struct maintenance_strategy {
 
 static const struct maintenance_strategy none_strategy = { 0 };
 
-static const struct maintenance_strategy default_strategy = {
+static const struct maintenance_strategy gc_strategy = {
 	.tasks = {
 		[TASK_GC] = {
-			.type = MAINTENANCE_TYPE_MANUAL,
+			.type = MAINTENANCE_TYPE_MANUAL | MAINTENANCE_TYPE_SCHEDULED,
+			.schedule = SCHEDULE_DAILY,
 		},
 	},
 };
@@ -1894,6 +1895,8 @@ static struct maintenance_strategy parse_maintenance_strategy(const char *name)
 {
 	if (!strcasecmp(name, "incremental"))
 		return incremental_strategy;
+	if (!strcasecmp(name, "gc"))
+		return gc_strategy;
 	die(_("unknown maintenance strategy: '%s'"), name);
 }
 
@@ -1937,7 +1940,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strategy = none_strategy;
 		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
-		strategy = default_strategy;
+		strategy = gc_strategy;
 		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a791a38916e..65417a1e9c3 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -915,7 +915,7 @@ test_expect_success 'maintenance.strategy is respected' '
 		git gc --quiet --no-detach --skip-foreground-tasks
 		EOF
 
-		test_strategy incremental --schedule=weekly <<-\EOF
+		test_strategy incremental --schedule=weekly <<-\EOF &&
 		git pack-refs --all --prune
 		git prune-packed --quiet
 		git multi-pack-index write --no-progress
@@ -923,6 +923,18 @@ test_expect_success 'maintenance.strategy is respected' '
 		git multi-pack-index repack --no-progress --batch-size=1
 		git commit-graph write --split --reachable --no-progress
 		EOF
+
+		test_strategy gc <<-\EOF &&
+		git pack-refs --all --prune
+		git reflog expire --all
+		git gc --quiet --no-detach --skip-foreground-tasks
+		EOF
+
+		test_strategy gc --schedule=weekly <<-\EOF
+		git pack-refs --all --prune
+		git reflog expire --all
+		git gc --quiet --no-detach --skip-foreground-tasks
+		EOF
 	)
 '
 

-- 
2.51.1.930.gacf6e81ea2.dirty

