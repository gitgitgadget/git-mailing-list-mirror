Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663D4A0F
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710379987; cv=none; b=CTuYmIkyUjHjpllUhL/dFlc2yqMT9xX70Y84Qx92VOrhcEEwSFMX3gXZ48aZJi9uDCgHcQILjS6lxovHSboYbUvAyfLinC95ZPttTNO3LnJucKvfX6Wb1+ATe8OF6+fZVu32jmSngeJNAmvqzZw+omDA0o1VanmZF1trULWFO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710379987; c=relaxed/simple;
	bh=MfrX5rsgbqObHSFCXuWFXs3dP593VIllT+QBxWHobTM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=gOfFbdX30d+OjesVlnLS1VV30CPiWQRhQraSwhyHYZBPphAzIm1hFSAOuJh0XSL7KikTBCXym3AXWv8uJaY5euDx+V9dDfp695o4lmF6PWi6/d5EU70W4EPKf4+eci0wOCGMhkdWt8KLzfNgA/7bedv7AV2gqgF3FANAblYd6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B83GC8Qc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B83GC8Qc"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ddd1624beso306007f8f.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710379984; x=1710984784; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOLy52DH+gT1RznmXQimcTuXgsZxXF2p7QewQzwpHe4=;
        b=B83GC8QceI51HckSUVrlP8QyECLLm6Th/wdTD7XJBgPQQncK454qzb8wWdqhVZtRC3
         p+4UyYSgidi/gjirglsBUaK5J5grI8Z384qV/hHg1ZYDI41luFe47XcNRqXArBdsrteO
         tTN4zrjZPqQPKHYIivXpTsQ7WOTURSmmoar+IBMbuAqIB6ivv0tUld9byeuIfn2rlCY6
         E+uUsrv65hO6leZzqraqSQ8VtEOfkWnjK3g4L0wGC8GvHlzkBuSazVUEoSGjz/T2j5Vp
         VWrAXjB9EljoxRSDI5/QGVUJILtskhGZjwUZWv8Fa6VeGnyH/yANIl8u+rgfVHCHy3o0
         ft5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710379984; x=1710984784;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOLy52DH+gT1RznmXQimcTuXgsZxXF2p7QewQzwpHe4=;
        b=MsW7oUYrllwWqO25sqm41DVEZUU1v+QVJXx6KRDipaeo517HDXjT6epYTkGFGiYD9q
         Uc6zTOacrfw7K0r5aFldxWfOTsBhobK17H1HX3LUKDoMJdp/V7OSQcGhtrVq3x6nhAeK
         F1Xbnt2plwxs7qI8eNs9fLhwAZxZ8m7MU1N854jQUwi0yfWtlb4qNv8h2NeVo+tkUw8T
         4I6TvMfRoOLaBruPWRtjTYnYLK9MEteBvPWs2XJ7kfvvPI65r7Gh8Y17zrAKHdJOKAqV
         q+N0u4myCnLfT7Fb4RC0GrOne3qcIURz+RWBkp3ezarNk14WvFkiLptDJeAIZQkG161Q
         ZwOg==
X-Gm-Message-State: AOJu0YwYzHFtNdAGp3d0b6YBCXuqbdTh1zticfZkd0wTL5dHTyeEy0Pl
	gQyR2ap3y4qbsTVHj9diLjK+2Swz+oD0OknPby4svstpJZj1JRtFpOh1zOlb
X-Google-Smtp-Source: AGHT+IHd3r7GTSarpR4+JRY7oktx/lPHieHg3sjCC4NsmJcuG1ls9+AZ8NRcahRPv+JDQAWL+Vw0fA==
X-Received: by 2002:adf:a395:0:b0:33e:83a1:227e with SMTP id l21-20020adfa395000000b0033e83a1227emr487472wrb.7.1710379983948;
        Wed, 13 Mar 2024 18:33:03 -0700 (PDT)
Received: from gmail.com (205.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.205])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b0033ec5ca5665sm383759wrp.95.2024.03.13.18.33.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 18:33:03 -0700 (PDT)
Message-ID: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
Date: Thu, 14 Mar 2024 02:32:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Subject: [PATCH] checkout: plug some leaks in git-restore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In git-restore we need to free the pathspec and pathspec_from_file
values from the struct checkout_opts.

A simple fix could be to free them in cmd_restore, after the call to
checkout_main returns, like we are doing [1][2] in the sibling function
cmd_checkout.

However, we can do better.

We have git-switch and git-restore, both of them spin-offs[3][4] of
git-checkout.  All three are implemented as thin wrappers around
checkout_main.  Considering this, it makes a lot of sense to do the
cleanup closer to checkout_main.

Factor out the call to checkout_main in a function that does both the
work and the cleanup, and use it in the three wrappers.

As a consequence, mark: t2070, t2071, t2072 and t6418 as leak-free.

 [1] 9081a421a6 (checkout: fix "branch info" memory leaks, 2021-11-16)

 [2] 7ce4088ab7 (parse-options: consistently allocate memory in
     fix_filename(), 2023-03-04)

 [3] d787d311db (checkout: split part of it to new command 'switch',
     2019-03-29)

 [4] 46e91b663b (checkout: split part of it to new command 'restore',
     2019-04-25)
---

 builtin/checkout.c               | 51 +++++++++++++++-----------------
 t/t2070-restore.sh               |  1 +
 t/t2071-restore-patch.sh         |  1 +
 t/t2072-restore-pathspec-file.sh |  1 +
 t/t6418-merge-text-auto.sh       |  1 +
 5 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4fe049cf37..2ff4cf88a6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1702,10 +1702,10 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 /* create-branch option (either b or c) */
 static char cb_option = 'b';
 
-static int checkout_main(int argc, const char **argv, const char *prefix,
-			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[],
-			 struct branch_info *new_branch_info)
+static int checkout_main_1(int argc, const char **argv, const char *prefix,
+			   struct checkout_opts *opts, struct option *options,
+			   const char * const usagestr[],
+			   struct branch_info *new_branch_info)
 {
 	int parseopt_flags = 0;
 
@@ -1907,6 +1907,20 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		return checkout_branch(opts, new_branch_info);
 }
 
+static int checkout_main(int argc, const char **argv, const char *prefix,
+			      struct checkout_opts *opts, struct option *options,
+			      const char * const usagestr[])
+{
+	struct branch_info new_branch_info = { 0 };
+	int ret = checkout_main_1(argc, argv, prefix, opts, options,
+				  checkout_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
+	clear_pathspec(&opts->pathspec);
+	free(opts->pathspec_from_file);
+	free(options);
+	return ret;
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -1922,8 +1936,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1953,13 +1965,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	options = add_common_switch_branch_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, checkout_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	clear_pathspec(&opts.pathspec);
-	free(opts.pathspec_from_file);
-	FREE_AND_NULL(options);
-	return ret;
+	return checkout_main(argc, argv, prefix, &opts, options,
+			     checkout_usage);
 }
 
 int cmd_switch(int argc, const char **argv, const char *prefix)
@@ -1977,8 +1984,6 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			 N_("throw away local modifications")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1997,11 +2002,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	cb_option = 'c';
 
-	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, switch_branch_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	FREE_AND_NULL(options);
-	return ret;
+	return checkout_main(argc, argv, prefix, &opts, options,
+			     switch_branch_usage);
 }
 
 int cmd_restore(int argc, const char **argv, const char *prefix)
@@ -2020,8 +2022,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
@@ -2036,9 +2036,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, restore_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	FREE_AND_NULL(options);
-	return ret;
+	return checkout_main(argc, argv, prefix, &opts, options,
+			     restore_usage);
 }
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 16d6348b69..ac404945d4 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -5,6 +5,7 @@ test_description='restore basic functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 27e85be40a..42d5522119 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -2,6 +2,7 @@
 
 test_description='git restore --patch'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index 8198a1e578..86c9c88788 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='restore --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 41288a60ce..48a62cb855 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -15,6 +15,7 @@ test_description='CRLF merge conflict across text=auto change
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
-- 
2.44.0.341.g37b2c3c964
