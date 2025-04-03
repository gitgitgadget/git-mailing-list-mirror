Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80C1A841E
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719894; cv=none; b=Xm0MrfRfn/VN4/ebOzsebOHKjv2j8Idf0Uz7ri6EjyFITyVSLbnEnZNFCSd5f6Yznwjn9W8gPJxktCW6qgV4TSbM1WqW10eHUckMb9hypEiRX20Jt3JBmx9ox/xpbrP7biPCZ/3zIPwkPmLABEN13xspSz2/ZSxUPttgfA6PzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719894; c=relaxed/simple;
	bh=Lekg2KTHzNQ5hrycRSwp6QaDYwYEddaP0q69EAUoleQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PjlX5khok9bjo3V4PYSwbOMUphTU0ispstPs3IG4adlzlhl7mtElGn5+bWAg4aZ/QHxhAu/EA0K8p13/t9a+YL1RKqc4VQ953fLIJSIGRQk/f6qKlsLCDnNNBp6ySVmEOQ47ts9dC1ReDcf7rHxUosgqOuR5pdRXXH8UzzutWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt8q4L+F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt8q4L+F"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso13470795e9.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743719890; x=1744324690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6IrqAMs6VTh4DmELN4+r3Mpyyvc8kslmKnCmh5EiDsE=;
        b=mt8q4L+FPiArbMohXIFlWOIvCYzz5uFq7vG/dSnT2h6MaUy25TZ8D5T8865eW8ePSe
         I3og+dh8JduRbxpC8Bb+nNUU3SxSi5+B/dGXpFClIXmn4yEd1K+ZXSU+RLIqjWWqN3b3
         LmXQBONO8KREFbyu70i+S0hReQAP3n4dbPbJcq9OFr+XYwewN2/SRreDkoSxC2Uty3KN
         x7/z9M/B2DDmEuEQrXdvWiypGkXJ9SE//dFI8SaGy7+E+Kt53nO/iVx1qey98jBlb/jt
         mrSne7KiAyGCSBPO0aO3aQ2BBtspKNQWsQFzcQGNztS233weGpZIXSXCsQNO1vz7MflQ
         za0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743719890; x=1744324690;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IrqAMs6VTh4DmELN4+r3Mpyyvc8kslmKnCmh5EiDsE=;
        b=QZ0nUD1UZGMKlm45EVjJFtDMkVZrQ7ccKG5t99JbpIQTfjn3X6QeGIlb1sdxiTsYE1
         iKypJg9Q7GrA10Df+FAmJPt5damknydWZM4buRfxZCMEMhdCoEP8jGxgm0YmGWEeiOIo
         19bTwosjXVwkeD/wj3hlpziuLu6QO6m1nzgSheBPZbF5+FA5RdIoSe/GWM02fB4H3nW3
         +13//Bt3Pn4oSjeOJr4bxMi65RPSv1SftvG4LULAAF5zojxWqIQl9BEQL+HSWRpBfzXx
         3iC3vjfDY6GYbMD9U7Auqa/c8RxThbTVMihziiLzQb1PP61ggnQIIkBwr8A+v1FF2xbz
         cbpQ==
X-Gm-Message-State: AOJu0Yxp9i43BkVJ+CIIu8L+WVD/goKfxXClXwk3d4XJQQVfsEaeaefE
	gk0e25687W2rwrqdO3ADA/p52lr77j/A/1j/WarNUrLq+ivUskRrutc3Ig==
X-Gm-Gg: ASbGncuua8ZpcWFrt26oNpe298o85NoWuQCBO1av0dXCP/RkNSV4vC1J8tNgaHH06E8
	TxyHEZOiEFviaD2sErgRTxNja3hO4DVITUhyd+qLvgWlinPzDn9tbSx+EPTHiOqxQMj/ni/e1vP
	4W5dkeA8nL9Y9srFO3h1a/0D9xZ4e4Kg7yot3TO0CwUBUoQrFalxH/OHoyY3NWQ6U8eWD3xA473
	whVzPlVwJpGwAFP1kueACCmcILS6jxziL84Xp0YRIF1ulDm5EeazB1EnFqTYkuXWsmuR2f385CN
	HLwL2icJhNBweUrmoaOYidLmGAGuXn4fivhFdC3ms5j+gAwualu6LzgR
X-Google-Smtp-Source: AGHT+IFSE0ny3d0G4WTavjETSy+qkVDz2g8MnRlQ5iDGFqKUylyYELne6JP/Yi9k8o5n/htxfFxX1w==
X-Received: by 2002:a05:600c:468c:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43ecf89dddcmr6230995e9.13.1743719889959;
        Thu, 03 Apr 2025 15:38:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec36691b3sm29997685e9.34.2025.04.03.15.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 15:38:09 -0700 (PDT)
Message-Id: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Apr 2025 22:38:08 +0000
Subject: [PATCH] git: add --no-hooks global option
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
    james@jamesliu.io,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Git has several hooks which are executed during certain events as long
as those hooks are enabled in the hooks directory (possibly moved from
.git/hooks via the core.hooksPath config option). These are configured
by the user, or perhaps by tooling the user has agreed to, and are not
required to operate a Git repository.

In some situations, these hooks have poor performance and expert users
may want to skip the hooks as they don't seem to affect the current
situation. One example is a pre-commit hook that checks for certain
structures in the local changes, but expert users are likely to have
done the right thing in advance.

I have come across users who have disabled hooks themselves either by
deleting hooks (supported, safe) or setting 'core.hooksPath' to some
bogus path (seems unsafe). The supported process is painful to swap
between the hook-enabled scenario and the hook-disabled scenario.

To that end, add a new --no-hooks global option to allow users to
disable hooks quickly. This option is modeled similarly to the
--no-advice option in b79deeb554 (advice: add --no-advice global option,
2024-05-03). This uses a GIT_HOOKS environment variable to communicate
to subprocesses as well as making this a backwards-compatible way for
tools to signal that they want to disable hooks.

The critical piece is that all hooks pass through run_hooks_opt() where
a static int will evaluate the environment variable and store that the
variable is initialized for faster repeated runs.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    git: add --no-hooks global option
    
    This is hopefully a helpful feature to more than just the experts I've
    been hearing from.
    
    Thanks,
    
     * Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1899%2Fderrickstolee%2Fno-hooks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1899/derrickstolee/no-hooks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1899

 Documentation/git.adoc       | 13 ++++++++++++-
 environment.h                |  6 ++++++
 git.c                        |  6 +++++-
 hook.c                       |  7 +++++++
 t/t1350-config-hooks-path.sh | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 743b7b00e4d..a34c8cfbe78 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -14,7 +14,7 @@ SYNOPSIS
     [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
     [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
     [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
-    <command> [<args>]
+    [--no-hooks] <command> [<args>]
 
 DESCRIPTION
 -----------
@@ -230,6 +230,12 @@ If you just want to run git as if it was started in `<path>` then use
 	linkgit:gitattributes[5]. This is equivalent to setting the
 	`GIT_ATTR_SOURCE` environment variable.
 
+--no-hooks::
+	Skip running local Git hooks, even if configured locally. Hooks
+	are an opt-in feature, so be sure that you know the impact of
+	ignoring hooks when running with this option. This is equivalent
+	to setting `GIT_HOOKS=0` environment variable.
+
 GIT COMMANDS
 ------------
 
@@ -771,6 +777,11 @@ for further details.
 	not set, Git will choose buffered or record-oriented flushing
 	based on whether stdout appears to be redirected to a file or not.
 
+`GIT_HOOKS`::
+	If this Boolean environment variable is set to false, then commands
+	will ignore any configured hooks as if the `--no-hooks` option was
+	provided.
+
 `GIT_TRACE`::
 	Enables general trace messages, e.g. alias expansion, built-in
 	command execution and external command execution.
diff --git a/environment.h b/environment.h
index 45e690f203f..22ddf201144 100644
--- a/environment.h
+++ b/environment.h
@@ -50,6 +50,12 @@
  */
 #define GIT_ADVICE_ENVIRONMENT "GIT_ADVICE"
 
+/*
+ * Environment variable used to propagate the --no-hooks global option to
+ * the hooks layer and to any child processes.
+ */
+#define GIT_HOOKS "GIT_HOOKS"
+
 /*
  * Environment variable used in handshaking the wire protocol.
  * Contains a colon ':' separated list of keys with optional values
diff --git a/git.c b/git.c
index 77c43595223..d7ebcf60947 100644
--- a/git.c
+++ b/git.c
@@ -41,7 +41,7 @@ const char git_usage_string[] =
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]\n"
 	   "           [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]\n"
 	   "           [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]\n"
-	   "           <command> [<args>]");
+	   "           [--no-hooks] <command> [<args>]");
 
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
@@ -349,6 +349,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_ADVICE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-hooks")) {
+			setenv(GIT_HOOKS, "0", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/hook.c b/hook.c
index b3de1048bf4..b209553d7a8 100644
--- a/hook.c
+++ b/hook.c
@@ -144,6 +144,13 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 
 		.data = &cb_data,
 	};
+	static int do_run_hooks = -1;
+
+	if (do_run_hooks < 0)
+		do_run_hooks = git_env_bool(GIT_HOOKS, 1);
+
+	if (!do_run_hooks)
+		goto cleanup;
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index 45a04929170..4c6a0eafe4e 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -48,4 +48,38 @@ test_expect_success 'core.hooksPath=/dev/null' '
 	{ test /dev/null = "$value" || test nul = "$value"; }
 '
 
+test_expect_success '--no-hooks' '
+	rm -f actual &&
+	test_might_fail git config --unset core.hooksPath &&
+
+	write_script .git/hooks/pre-commit <<-\EOF &&
+	echo HOOK >>actual
+	EOF
+
+	echo HOOK >expect &&
+
+	git commit --allow-empty -m "A" &&
+	test_cmp expect actual &&
+
+	git --no-hooks commit --allow-empty -m "B" &&
+	test_cmp expect actual
+'
+
+test_expect_success 'GIT_HOOKS' '
+	rm -f actual &&
+	test_might_fail git config --unset core.hooksPath &&
+
+	write_script .git/hooks/pre-commit <<-\EOF &&
+	echo HOOK >>actual
+	EOF
+
+	echo HOOK >expect &&
+
+	GIT_HOOKS=1 git commit --allow-empty -m "A" &&
+	test_cmp expect actual &&
+
+	GIT_HOOKS=0 git commit --allow-empty -m "B" &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
-- 
gitgitgadget
