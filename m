Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF70237701
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592425; cv=none; b=BVvRD/aVax7+fe4DMvDSC9WVtgv9cr0eQUHN5czasR30pOvF0Y8ykLdw4wX4wj9IAvO8PnZ3QINMEKzaoyYEEEfmckk01DSayS+Y2F0byl5K2f05QiXEf9dVHZiFiMeRn1vXaFzxV4qSgd9arUgY1ijNh8ek/5/pATvq2SkxUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592425; c=relaxed/simple;
	bh=1Mlmo3jrm2y5l/kMXkWAZUa7fQ+TPgUGXUJDgWAJOzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5zjdz/z3jhvKILwWYsvhNa2ccndj/Vwq1ZKDrKwPolRZnuN4OBe414GuJVTjW2whwxBZVbCFGQVRIPD2TfHux8Ms3oeuPeqmmSfPnLbKSIxAccsm6BXuMyiVmdnSr+icskOs9sqnkOoZoV/Ykm7fnSeLgkexPH84yUmvUINfdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IfvGFcaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxxSW3za; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IfvGFcaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxxSW3za"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 99D4211401F8;
	Wed,  2 Apr 2025 07:13:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Apr 2025 07:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592422;
	 x=1743678822; bh=/hqSzC10p62ofevxlOe8trzDjyUrdSUH25Z2V4bOqRw=; b=
	IfvGFcaaX/maKurAwJlGuoRXN/0o4M8uWIXseDJEdoXEI6ex4IBtO6ivJmVtGtEn
	4TjwRm0FtNY6KGAQv/Bt65I7nBF1mtCojr2rl4qeFUreDetcUJF4crf88B74vOFK
	RAh+N60Vac16xEaV8P08VmGgGJ1qwB0jSu7WrtSBFftYaCdqpsXqCifDS4G4FCT2
	L5DCao4p4kW+4aQkZC6woVETzZBYsoogDuVkwO3SHz4rQ2uG7aG7URb4izy0Nrl0
	VYuvlOCLs1U8kz3fpWR60ARdEYSSVmMy1OGxY686A+Sv7V6ibULdBj+f6tCyER7U
	NdoPoGeIpvrPaWDIuFD8PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592422; x=
	1743678822; bh=/hqSzC10p62ofevxlOe8trzDjyUrdSUH25Z2V4bOqRw=; b=R
	xxSW3zangBOQK8iF0gdxLNdq2RfO+S/ybOxuKTuGPtLBTV9zhbtOROWEiRcy3AEn
	q6iSfON78cCXTch7RlZpsZwNtR5Y+Ll2nPYsmch2oqqMLlHmdrxNFlRYVjzbSveU
	Am/xeGUVmYKZB5mfyH9cSp+LhhS+iH3wiVeX1yGoIOUNy8AAFka9vJzpuZ6AfecD
	3N7QmDQTxduAhnoVqd0vaTqBNv7feSDB7tZWemwKu32c+6qLdj0eznK1aSe4z0qU
	1PR0CFRelHd2MrG++3aHUz+5p8Si2TB0JAGySx5YafYmYOUD/ZrReyP21EzkQzTE
	yIa6BZ8b1yzL+EVLjRcVg==
X-ME-Sender: <xms:5hvtZ73bTy8vbMrddy0EqJvdGvSP-zrDZnbB1mU4unJ-zf1DVxrnFQ>
    <xme:5hvtZ6F5nqQi7I34UH3mgvRWXYlmb20gFIJKTfmbnhX3grD68LeNjLep91sRxPyGd
    FLXhTaf1ox6wfV9HA>
X-ME-Received: <xmr:5hvtZ77HjC79NONPNzWU7TuBamib4LFuEmSrSrjysGi45iOOUnpI0qF4G1jNqGKsDz4Fuh90vig3cQ6Zqj07591UTRbmkXP4V2AMIg_gP6ILxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5hvtZw0scXnmbQ1S7LHnk2jLfY2R-71TkG95b7ZqGVNTBuQ3S86q9g>
    <xmx:5hvtZ-EzA4Fqm-PhS14KV1cppuhCxho_P6FrTklU_d2fvxwxVUC8VA>
    <xmx:5hvtZx_ZS0GWSDeRCPxlYOloP07RnzR00UpKfJbcVm6meutNFA9Wng>
    <xmx:5hvtZ7ndjm8dvL31L9TKwwRaWaKXBKkRjCQqJBCKb82g8Wj2TMJvvQ>
    <xmx:5hvtZ7E9ajKEWU3YShChZvc3LiZ3tRCRbgQnZ8Ufc9dHxFmG9OKQTisV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc44df51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:36 +0200
Subject: [PATCH v3 01/11] builtin/cat-file: rename variable that tracks
 usage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-1-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The usage strings for git-cat-file(1) that we pass to `parse_options()`
and `usage_msg_optf()` are stored in a variable called `usage`. This
variable shadows the declaration of `usage()`, which we'll want to use
in a subsequent commit.

Rename the variable to `builtin_catfile_usage`, which is in line with
how the variable is typically called in other builtins.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b13561cf73b..b158b3acef9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -941,7 +941,7 @@ int cmd_cat_file(int argc,
 	int input_nul_terminated = 0;
 	int nul_terminated = 0;
 
-	const char * const usage[] = {
+	const char * const builtin_catfile_usage[] = {
 		N_("git cat-file <type> <object>"),
 		N_("git cat-file (-e | -p) <object>"),
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
@@ -1007,7 +1007,7 @@ int cmd_cat_file(int argc,
 
 	batch.buffer_output = -1;
 
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_catfile_usage, 0);
 	opt_cw = (opt == 'c' || opt == 'w');
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
@@ -1021,7 +1021,7 @@ int cmd_cat_file(int argc,
 	/* Option compatibility */
 	if (force_path && !opt_cw)
 		usage_msg_optf(_("'%s=<%s>' needs '%s' or '%s'"),
-			       usage, options,
+			       builtin_catfile_usage, options,
 			       "--path", _("path|tree-ish"), "--filters",
 			       "--textconv");
 
@@ -1029,20 +1029,20 @@ int cmd_cat_file(int argc,
 	if (batch.enabled)
 		;
 	else if (batch.follow_symlinks)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
-			       "--follow-symlinks");
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
+			       options, "--follow-symlinks");
 	else if (batch.buffer_output >= 0)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
-			       "--buffer");
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
+			       options, "--buffer");
 	else if (batch.all_objects)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
-			       "--batch-all-objects");
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
+			       options, "--batch-all-objects");
 	else if (input_nul_terminated)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
-			       "-z");
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
+			       options, "-z");
 	else if (nul_terminated)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
-			       "-Z");
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
+			       options, "-Z");
 
 	batch.input_delim = batch.output_delim = '\n';
 	if (input_nul_terminated)
@@ -1063,10 +1063,10 @@ int cmd_cat_file(int argc,
 			batch.transform_mode = opt;
 		else if (opt && opt != 'b')
 			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
-				       usage, options, opt);
+				       builtin_catfile_usage, options, opt);
 		else if (argc)
-			usage_msg_opt(_("batch modes take no arguments"), usage,
-				      options);
+			usage_msg_opt(_("batch modes take no arguments"),
+				      builtin_catfile_usage, options);
 
 		return batch_objects(&batch);
 	}
@@ -1074,22 +1074,25 @@ int cmd_cat_file(int argc,
 	if (opt) {
 		if (!argc && opt == 'c')
 			usage_msg_optf(_("<rev> required with '%s'"),
-				       usage, options, "--textconv");
+				       builtin_catfile_usage, options,
+				       "--textconv");
 		else if (!argc && opt == 'w')
 			usage_msg_optf(_("<rev> required with '%s'"),
-				       usage, options, "--filters");
+				       builtin_catfile_usage, options,
+				       "--filters");
 		else if (!argc && opt_epts)
 			usage_msg_optf(_("<object> required with '-%c'"),
-				       usage, options, opt);
+				       builtin_catfile_usage, options, opt);
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
-			usage_msg_opt(_("too many arguments"), usage, options);
+			usage_msg_opt(_("too many arguments"), builtin_catfile_usage,
+				      options);
 	} else if (!argc) {
-		usage_with_options(usage, options);
+		usage_with_options(builtin_catfile_usage, options);
 	} else if (argc != 2) {
 		usage_msg_optf(_("only two arguments allowed in <type> <object> mode, not %d"),
-			      usage, options, argc);
+			      builtin_catfile_usage, options, argc);
 	} else if (argc) {
 		exp_type = argv[0];
 		obj_name = argv[1];

-- 
2.49.0.604.gff1f9ca942.dirty

