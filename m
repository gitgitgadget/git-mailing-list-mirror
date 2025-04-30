Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBF221298
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008686; cv=none; b=IZGoBUNAavzWeEYfusGkwF5CVd1TBlPcV7vGq/nciEnYGFKgfxDEjTHC0d+uBz+L0A4r08fmOEMyuYEedref0c8qGRp1HgHQquSAjHiwLda1JwC56ZjJu+Wa6xNxA7gYMvXKWGxypcX3jY7n2+9qcHtJ/mPYkcVp/tkB4IWt/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008686; c=relaxed/simple;
	bh=Y9/mDX4aZIPJ08I91BuqkLxYZdlin9Kcm9pc7Ow5y/c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pOvgH0mcaTsCe2za5+6l0gIMJ1R/nmmy+cMvngb2q72vg7Px/K65qg8/2ORtVBi3517niAjxh6aRSMElN/VG754Rczlr2h4vXQpyKn/DqiQaZWpXLJ+9GxVlw95Ckfr5GD1vA+KYFeskLTEWhNGi//Mw8gP/KLcsM3g7dSkcyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1GPxQoA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1GPxQoA"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ee623fe64so6989831f8f.1
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746008683; x=1746613483; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcyc7RsC1z2W6O7aMTArEl9Y4eC2wf1R5l0f+xcFsMA=;
        b=N1GPxQoATjkifyt9GaDopheqyZQgvXxOvpmOzP6CLDhDvXbdn1A0iT7hJjL3SKMLil
         PoS9kpXM4O5JVR3OHMI3L3eb5B759RAKJiam2F+F5RnMsUqsigbqFtmR6tzzHY3ly8lc
         6lXk0pBou405Iw6W1e4khwBEd1NGhTNilN5H7srMH1UJBcC4dX+Q+yS3Gf1bPW5BGI+J
         pKGVlPczUekwcQso5FVAHLpHnboWGSmH8LRRMEtEFYL1gb7Sb/B+CPzGvTyiPrHU+ez3
         vJdYtWYMETSqYEJlc4XceSFteL2ZBIitGk2OgOHbSgcBiNdESRJ9Yy2mxOrFDIY8/N6U
         xJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746008683; x=1746613483;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcyc7RsC1z2W6O7aMTArEl9Y4eC2wf1R5l0f+xcFsMA=;
        b=gf1ys+xKQbu/DgScA7ATEpejIEuJSUqBuVJqZv1ruAhjrRcor8PW75a7Dme/KWVLsI
         4wUAg8Uiza169O8lEtUhgPYtC0aQ2yZTkbYegMs4Pf1EQdtjm8Kbto2jUsd6aGKze6W8
         UAf/AyF4qKHLdq4QR3rjQfJiNfduChnSq6oLxhstWBZORyfKGwOVE0sxEQ8wyO5kFU5h
         A3ycpW254wFjynA6Kmvip5WS5X73XYoaD/YeHzW2Ww/0bZq/Qspqqfr/LHs1ke6Be0hE
         UIGmWUUf8GfgBg4rmJFGwAP8jMQDu8R1QP12hFLtEQe252BnDdNCW9RWXZh9NYrXWlcA
         6bxg==
X-Gm-Message-State: AOJu0YwE7KLeTjfiYPjo4xBRGvp80CMuZDGD4QhYnkhEEnauZaCwHAH6
	NQm3xpn0crI2vyd5ZpPih6l0dNVb/yeZBrpytUni6CmxImb52pu67NZNPg==
X-Gm-Gg: ASbGncv4YpYTJ9aHSnzaByu68i0jevmZptyBYtDvgjw8aDPZ9sn27DrZSGltSZzkksc
	lszcFDD7PPhAnjYExNXq71yLS1b75NfYioZLgfCMSRqgL0AS/XFw4DNDS0VwAjobei0h+KS3rfv
	SDLWjaBeqLec0hHTXcWmhnFh0qIcKwFpp5sKBHJ4cdc8uZNbFWK42a1/xuvPaim8bsw1RrJIwjg
	/H9TgsQbEDS9fm2gGAlEFCWzyk2wbxWEJWJqxIXkVtAe0H99rjWmnquRpDcXk5Ezvx1V4dE4wWK
	Pq8Z0RfIQ87U23eUfurLwOBcxU22NfapATdhp9Amyw==
X-Google-Smtp-Source: AGHT+IHstjGwPwK5Oe4Oq5v2mrvrzDHSyB+5ynp0tzVMRDCdPtq+pHN47IuccWwvhOSDnta6V8GhdQ==
X-Received: by 2002:adf:fbc4:0:b0:3a0:7fd4:2848 with SMTP id ffacd0b85a97d-3a08f7a4abamr1770208f8f.52.1746008682530;
        Wed, 30 Apr 2025 03:24:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8ca72sm16257480f8f.4.2025.04.30.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:24:42 -0700 (PDT)
Message-Id: <4910bacd0524a29186e673a174a47cd46ac95b5e.1746008680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Apr 2025 10:24:39 +0000
Subject: [PATCH 1/2] scalar register: add --no-maintenance option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When registering a repository with Scalar to get the latest opinionated
configuration, the 'scalar register' command will also set up background
maintenance. This is a recommended feature for most user scenarios.

However, this is not always recommended in some scenarios where
background modifications may interfere with foreground activities.
Specifically, setting up a clone for use in automation may require doing
certain maintenance steps in the foreground that could become blocked by
concurrent background maintenance operations.

Allow the user to specify --no-maintenance to 'scalar register'. This
requires updating the method prototype for register_dir(), so use the
default of enabling this value when otherwise specified.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc |  8 +++++++-
 scalar.c                  | 17 ++++++++++-------
 t/t9210-scalar.sh         |  7 +++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 7e4259c6743f..b2b244a86499 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
 	[--[no-]src] <url> [<enlistment>]
 scalar list
-scalar register [<enlistment>]
+scalar register [--[no-]maintenance] [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
@@ -117,6 +117,12 @@ Note: when this subcommand is called in a worktree that is called `src/`, its
 parent directory is considered to be the Scalar enlistment. If the worktree is
 _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
 
+--[no-]maintenance::
+	By default, `scalar register` configures the enlistment to use Git's
+	background maintenance feature. Use the `--no-maintenance` to skip
+	this configuration. This does not disable any maintenance that may
+	already be enabled in other ways.
+
 Unregister
 ~~~~~~~~~~
 
diff --git a/scalar.c b/scalar.c
index d359f08bb8e2..2a21fd55f39b 100644
--- a/scalar.c
+++ b/scalar.c
@@ -259,7 +259,7 @@ static int stop_fsmonitor_daemon(void)
 	return 0;
 }
 
-static int register_dir(void)
+static int register_dir(int maintenance)
 {
 	if (add_or_remove_enlistment(1))
 		return error(_("could not add enlistment"));
@@ -267,7 +267,7 @@ static int register_dir(void)
 	if (set_recommended_config(0))
 		return error(_("could not set recommended config"));
 
-	if (toggle_maintenance(1))
+	if (toggle_maintenance(maintenance))
 		warning(_("could not turn on maintenance"));
 
 	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
@@ -550,7 +550,7 @@ static int cmd_clone(int argc, const char **argv)
 	if (res)
 		goto cleanup;
 
-	res = register_dir();
+	res = register_dir(1);
 
 cleanup:
 	free(branch_to_free);
@@ -597,11 +597,14 @@ static int cmd_list(int argc, const char **argv UNUSED)
 
 static int cmd_register(int argc, const char **argv)
 {
+	int maintenance = 1;
 	struct option options[] = {
+		OPT_BOOL(0, "maintenance", &maintenance,
+			 N_("specify if background maintenance should be enabled")),
 		OPT_END(),
 	};
 	const char * const usage[] = {
-		N_("scalar register [<enlistment>]"),
+		N_("scalar register [--[no-]maintenance] [<enlistment>]"),
 		NULL
 	};
 
@@ -610,7 +613,7 @@ static int cmd_register(int argc, const char **argv)
 
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
-	return register_dir();
+	return register_dir(maintenance);
 }
 
 static int get_scalar_repos(const char *key, const char *value,
@@ -803,13 +806,13 @@ static int cmd_run(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (i == 0)
-		return register_dir();
+		return register_dir(1);
 
 	if (i > 0)
 		return run_git("maintenance", "run",
 			       "--task", tasks[i].task, NULL);
 
-	if (register_dir())
+	if (register_dir(1))
 		return -1;
 	for (i = 1; tasks[i].arg; i++)
 		if (run_git("maintenance", "run",
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a81662713eb8..a488f72de9fe 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -129,6 +129,13 @@ test_expect_success 'scalar unregister' '
 	scalar unregister vanish
 '
 
+test_expect_success 'scalar register --no-maintenance' '
+	git init register-no-maint &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+		scalar register --no-maintenance register-no-maint 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'set up repository to clone' '
 	test_commit first &&
 	test_commit second &&
-- 
gitgitgadget

