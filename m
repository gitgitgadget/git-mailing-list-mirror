Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3DB16F841
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582644; cv=none; b=L8U8Q7YhSMXLwCrdpqBGLnIIwE1d0BcbMvAOPoe2uqM7ZSR/afQRx4QPmyeOjkuszNAo4FFpctssAr7TYD95MXERRJmDt8EiMTme27FzJ6aezVXw4oXE8bdSY0xKla189n3/wrBpo8mbZ3707T1HOUPtFQe68XrP6mBAmrO4hpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582644; c=relaxed/simple;
	bh=6ZnmN18q3Y1mvbjPP8HF5PqB0HljVXgprM8m7u4Tj/w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GZi/PFJG0Y6Viphfar3Zphigcf02qugggrM+W6l7RqeZm2TJC1txwtigzd0qc2e8ZgOPtSz4UTCuA6hIXA5o5m3N9NCHb4FYsyYeQ9jXedkTHpmwhVPbyBOXqGswSQRV38M4+T1wKLcXVkIXwd1h7q6eut/sUjsHMheF8t1M23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z49JnuXV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z49JnuXV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so6150858f8f.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746582641; x=1747187441; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwqk2iQYeNDakTWQy9JkdYTlz5c+hwsuldRW0e+Mlz4=;
        b=Z49JnuXVU3EDDfILTNyl7z97ZyDK6ukpgJoNDfYAKRYPXFRFBNXUtwjn8ZifVD1i1A
         Zf71eQm1TT6ijjmObB7clYFjGHu9hiO0VwnQYt3ulIrw2J4pyELtjcM0D9G5brL7rClu
         4kkgP47qXj6OW3OkWBjI8+Fw1N5aPvEOzPOTY/+RfVe0tAdG92DRwPR+Xajb68sMywYn
         m9oIyOSctJy65q9mmNDeyulRu6PkjRazm1Ssq8nuzX0fccHp9XcrBkTaVlYhtI7evxQc
         SzHmx1dhOZg9Off9ku9BvbDfgaOvjMTcfMXkc/v8xBMBE3kdSGaQ8r56/ItnwOLPaS6k
         M4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746582641; x=1747187441;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwqk2iQYeNDakTWQy9JkdYTlz5c+hwsuldRW0e+Mlz4=;
        b=TR0TMfdGuKf01fv+lGWgbDnV6zUDQtKrOPDDJRvo1+vKiBMpBFl+uQ1dz7us5n7kex
         2Cg8Tqxjdf/N0fZCzWEIxaluNRD/eNWIheyJ0eZQa4D012G/ZWwgGvK9AM05kXBC6u5S
         Z9//lfHHOq0QBjwFNHeOXLcWhqFkOcSoC7bPQWj5qu2ReHkL0UgQ4JF/ouBfjqA7DVvk
         IcbjHFL3kBsYbn+1/9pP1+WUfLWqwq7ksLOSD/OJ2jqdfrKSGxZkf3zjHbRUiZTDb/PX
         9/4kVM7J6t/QwVc6DsztSeP3ckcS9UbSMI4muOW0IwkI8ogmyY0rWYSYF7Am4zqtXW1D
         3sVg==
X-Gm-Message-State: AOJu0YyJaa9yl45CwyDcPsNdzJLJ2S2o77Sj4zsiKLLNlKuzMQNauOFL
	fcycgCjJQvUx267rQ3cK1+Y9QKY6swvndNK44d1R6kh2HimnoiifEWAlfA==
X-Gm-Gg: ASbGncuSMSVEyU32+mnPlfujPZbyIIqCFlOtvs3LtWRaK3wC6QCvLab0R4S9GhO1xzf
	ypForC+WYefG8MSHSzcwZC+lJH41d1t7oi/3y9X4sRB7O+HImEWzAE9EmWMW7eTpmjkJHnLUrso
	lbANEGn00DMH78+A8AFgbB8bZYCRl3PqOU2Jpb2E90TyRewlBQc+QC5rLZOosYy3FybdTJRH3Sd
	svgJI8ecczwhXCh0vezIahpvonsTc3NFXF4VZjxFbgRa/t5TqnoBXMPS2CPu4Fwpx7501XQ/stA
	FLOd5AejxXLee+IUcQzelI6qwG6orpfjjwbz29j4VA==
X-Google-Smtp-Source: AGHT+IEz1JKTeQYZYzLaY6/fT8092pKUilpvGRbMd/GhCEVqSmu9myVa6jDWS5fjAQBhIFSww6fNEw==
X-Received: by 2002:a5d:5f8b:0:b0:39c:30cd:352c with SMTP id ffacd0b85a97d-3a0b4a05df1mr1070762f8f.8.1746582640856;
        Tue, 06 May 2025 18:50:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b1e8e8d8sm3102569f8f.33.2025.05.06.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:50:40 -0700 (PDT)
Message-Id: <e52b1282d93b795d077f169573487dca06b83bbe.1746582637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 01:50:36 +0000
Subject: [PATCH v3 3/4] scalar clone: add --no-maintenance option
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

When creating a new enlistment via 'scalar clone', the default is to set
up situations that work for most user scenarios. Background maintenance
is one of those highly-recommended options for most users.

However, when using 'scalar clone' to create an enlistment in a
different situation, such as prepping a VM image, it may be valuable to
disable background maintenance so the manual maintenance steps do not
get blocked by concurrent background maintenance activities.

Add a new --no-maintenance option to 'scalar clone'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc |  7 ++++++-
 scalar.c                  |  9 ++++++---
 t/t9211-scalar-clone.sh   | 11 ++++++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index b2b244a86499..7753df3b4352 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
-	[--[no-]src] <url> [<enlistment>]
+	[--[no-]src] [--[no-]tags] [--[no-]maintenance] <url> [<enlistment>]
 scalar list
 scalar register [--[no-]maintenance] [<enlistment>]
 scalar unregister [<enlistment>]
@@ -97,6 +97,11 @@ cloning. If the HEAD at the remote did not point at any branch when
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
 
+--[no-]maintenance::
+	By default, `scalar clone` configures the enlistment to use Git's
+	background maintenance feature. Use the `--no-maintenance` to skip
+	this configuration.
+
 List
 ~~~~
 
diff --git a/scalar.c b/scalar.c
index da0c46bc96cc..dd6e1447e086 100644
--- a/scalar.c
+++ b/scalar.c
@@ -426,7 +426,7 @@ static int cmd_clone(int argc, const char **argv)
 	const char *branch = NULL;
 	char *branch_to_free = NULL;
 	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
-	int src = 1, tags = 1;
+	int src = 1, tags = 1, maintenance = 1;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -439,11 +439,13 @@ static int cmd_clone(int argc, const char **argv)
 			 N_("create repository within 'src' directory")),
 		OPT_BOOL(0, "tags", &tags,
 			 N_("specify if tags should be fetched during clone")),
+		OPT_BOOL(0, "maintenance", &maintenance,
+			 N_("specify if background maintenance should be enabled")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
 		N_("scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]\n"
-		   "\t[--[no-]src] [--[no-]tags] <url> [<enlistment>]"),
+		   "\t[--[no-]src] [--[no-]tags] [--[no-]maintenance] <url> [<enlistment>]"),
 		NULL
 	};
 	const char *url;
@@ -565,7 +567,8 @@ static int cmd_clone(int argc, const char **argv)
 	if (res)
 		goto cleanup;
 
-	res = register_dir(1);
+	/* If --no-maintenance, then skip maintenance command entirely. */
+	res = register_dir(maintenance);
 
 cleanup:
 	free(branch_to_free);
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 01f71910f533..bfbf22a46218 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -177,7 +177,16 @@ test_expect_success 'progress without tty' '
 test_expect_success 'scalar clone warns when background maintenance fails' '
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
 		scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
-	grep "could not turn on maintenance" err
+	grep "could not toggle maintenance" err
+'
+
+test_expect_success 'scalar clone --no-maintenance' '
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+	GIT_TRACE2_EVENT="$(pwd)/no-maint.event" \
+	GIT_TRACE2_EVENT_DEPTH=100 \
+		scalar clone --no-maintenance "file://$(pwd)/to-clone" no-maint 2>err &&
+	! grep "could not toggle maintenance" err &&
+	test_subcommand ! git maintenance unregister --force <no-maint.event
 '
 
 test_expect_success '`scalar clone --no-src`' '
-- 
gitgitgadget

