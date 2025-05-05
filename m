Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9756136
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458851; cv=none; b=CorFEPjt2/k3PmKSK2UxeN3LwA/DgJNzPqExv8CCnVfTe14ia2/Pb3hzotpbp2ydwCtgIJwEc8RqJ2oGpRaJZPtGi0NniWvHVtG3AnIGgf9CKuE3hw/Oc9QWa373LgtRzmhX+aHn+hiGcw855zfejkJeKXJ4lk4ZW78BFfoZ2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458851; c=relaxed/simple;
	bh=gcFlFioENP4wWNVRC/cilSB1DCncYGQbOhTdpI9r8vs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mIMgWdM7UxNXy/kpg+zTFiWw2zVH7JBFoEfX9HRhfHTlMcU4n2LyDXLAXVAB8prtLJI9ygtoG4TzaggSoHM4WhSNa1MqkKzkb8Lgv0YiR/xr/2yVNPuCEcGsWsUzdxJlFfiGdUh7JHbOq8YvWUKJd/UOxtTQv9A099CVi0d4+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y435kKbL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y435kKbL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913d129c1aso2770089f8f.0
        for <git@vger.kernel.org>; Mon, 05 May 2025 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746458847; x=1747063647; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQc+0xCkZpLpnLZ/VOSigoKCx6d8Wn5GtG1NDlUZW4U=;
        b=Y435kKbLmUNHgONkexAyCXObsMCaJw9lgUxcUZXEI3Gmt67oqdxugnjJ5FgLqv0qMc
         Ct36w+4Qi2X9zqumnIEUH2FtVK+53LP32ADjqk5N6SkOVQOQ2b3c5aOFs//CNPEAnJDY
         8RAHdYPI2qbh/BsAW5qrP0NFxMX4jZUYEwfZuBYc9816oCnQDyWvk8Y/94iSal5IuDZC
         ViHyChSzhUNNHTk+5Ag2KCqrOygXtZM53aS6mR5Sf4ldcyqqOMQsJdPPuQeXLTwkoNh7
         O/AKGcLTTNzpIGWWyBZkc3aq6+vgeCBdARiEqGIjqVMyFEWLdjFBH3X5Zu4PJH80wPpF
         Pvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458847; x=1747063647;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQc+0xCkZpLpnLZ/VOSigoKCx6d8Wn5GtG1NDlUZW4U=;
        b=iOUOVHTMukQfWQWagGPNsfAsTk/rJmIafBv95NkyLVLeG7Itn42td7HEMHhZv55aLy
         yh63La0oDxqu0cKoTT85KG+qvyz/pMtN51rXrtBONLbQyNBRDymTeB2RcwHAtKJSSlG4
         6yiGWCy75IneC5n2IkFDTv0lTZesuXr6pOPP1Hqx/rGIqOV4svlgLK4Vdxl/Ch+SsuVU
         NxQg44gjkXwHNS1SJ3V/74XRwrXW04SMdLS5irfMDkBYPEk+j0p2/+GHWPvpThZMligu
         7IxW5zbkIkfZb3KRb9q6ooMB6krpnFtr0T7n5m0pS0pekJO8udsr7z62lumA9AMZ2+Lj
         XQTQ==
X-Gm-Message-State: AOJu0YyuTfFoaYySP54ViuHYdvL5Nvub6yrGjvSO5Q37BtOVHCrJ80pL
	8MxFKRpJfFkycqbYRI1UEiczQqm7LCKU43rQic8Ge4sbGpxX9RO/njMqNg==
X-Gm-Gg: ASbGncuOllILlkCmMXcjhmHQeq63DBVs7RiqLM0bvq5SEyXwswp7tkNjmU/zxM5HwcQ
	SqTOjCMr7/T1N2ntMBnbsbRhZhJ0i7XfLWoRDneIBjbI14hqjV78L+Xxpx5alu5Ahp3W7/S0RKc
	ylLPW1XNPdEWVe9SLsQSoaSyzv+n9m0SVz45helFqcRXH8aZXaT33DRbMaN6s4+vdXEuX1S/oOd
	gFSEob+eMdbKSgkPzCRhNgBYaSUCOaKNpKCdtUY6wtWaGoB1o5rV6YoI0SJokywvu7V7Pgfex1G
	mrgZKV8riIzeeybKSaPv/tMZ7kvl0/1G13OFP0Kasw==
X-Google-Smtp-Source: AGHT+IH2IIuI5sMcq+vKg/PqWbR4pjMXFhQKhdzA9kwJJuBqo3/PmpG7I1cj1yKmalD4thP9r6p2qQ==
X-Received: by 2002:a05:6000:188f:b0:3a0:6a8b:ae4a with SMTP id ffacd0b85a97d-3a098469eaemr9788818f8f.24.1746458847237;
        Mon, 05 May 2025 08:27:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3c1fsm10812822f8f.37.2025.05.05.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:27:26 -0700 (PDT)
Message-Id: <1b99a559520a8bfed143c6fe8265f76b1ac4283c.1746458844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 15:27:22 +0000
Subject: [PATCH v2 2/4] scalar register: add --no-maintenance option
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
    Patrick Steinhardt <ps@pks.im>,
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
 scalar.c                  |  8 ++++++--
 t/t9210-scalar.sh         | 13 ++++++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

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
index b20b063471a6..da0c46bc96cc 100644
--- a/scalar.c
+++ b/scalar.c
@@ -612,11 +612,14 @@ static int cmd_list(int argc, const char **argv UNUSED)
 
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
 
@@ -625,7 +628,8 @@ static int cmd_register(int argc, const char **argv)
 
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
-	return register_dir(1);
+	/* If --no-maintenance, then leave maintenance as-is. */
+	return register_dir(maintenance);
 }
 
 static int get_scalar_repos(const char *key, const char *value,
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a81662713eb8..89a6a2a24d8b 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -108,7 +108,7 @@ test_expect_success 'scalar register warns when background maintenance fails' '
 	git init register-repo &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
 		scalar register register-repo 2>err &&
-	grep "could not turn on maintenance" err
+	grep "could not toggle maintenance" err
 '
 
 test_expect_success 'scalar unregister' '
@@ -129,6 +129,17 @@ test_expect_success 'scalar unregister' '
 	scalar unregister vanish
 '
 
+test_expect_success 'scalar register --no-maintenance' '
+	git init register-no-maint &&
+	event_log="$(pwd)/no-maint.event" &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+	GIT_TRACE2_EVENT="$event_log" \
+	GIT_TRACE2_EVENT_DEPTH=100 \
+		scalar register --no-maintenance register-no-maint 2>err &&
+	test_must_be_empty err &&
+	test_subcommand ! git maintenance unregister --force <no-maint.event
+'
+
 test_expect_success 'set up repository to clone' '
 	test_commit first &&
 	test_commit second &&
-- 
gitgitgadget

