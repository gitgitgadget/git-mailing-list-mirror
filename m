Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055203C0A1A
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927034; cv=none; b=XJIlVRcHSc1mMSORFNI37btPlAA9bdSnnW2jt/g4MPlQRaXyuhF+Du8LKPH7RXHohU0BDfH8moOGpr7L950YnlJSvfhf+sWsGfK5MmT5EBsaMHIShXBCEJSvsbaVUadPcDCKELx0Nnn7FCzMUkylS9d7LXDUbhDlYUUyIWxTwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927034; c=relaxed/simple;
	bh=jBH8F3YpD4+an2h5Dktz02bY6yQAy57c1joE0oZN6VI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YsEgx5VxCQYacshNUxuqEommokJsD755+dD1uLsEZxWFdyDOvKPU0/fNKhbd2C/g4EZ8tykdAT4fbTeLIkHnxkqwBLnxyliKHx1Iv3o8+N+9tT13IQzkvoX7bcp8sOVD5gi9UHCy70EE6mnD/vW4yHy51isOt94EJhDM11QxBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glHfl6cW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glHfl6cW"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-915767ea2d0so330331885a.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780927032; x=1781531832; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1FpzeaCggks3yhpbJYF6VSWOd0Jkfl4sIP/k1Ku/EA=;
        b=glHfl6cWDr27BYJo6bChIAk/XZjMPhT/usWFvqhJNYd45df2YPCZRkfAiFlG+aETCC
         KgtU5cik1y0PxhHqOZzp1xgkNOG8hwZzFU8ocFnr3TjPZKbI6Kuz9i9XxvMvJIBj4Kob
         1qWmYXXzr+4o2SGD4hd6Z5etQrGy/6lt/FPDbceDd+77+lBWtujGWDLsYlLQu1LFkxu5
         +xz3cvha0Lzgw4cPpoQ9xs4TaVnA/4FmhuGlWN9A+S75msMWT/8u7QKAGPqlhy8lQOz8
         q2ohe4evegHkgBeG21d7OxMTKtcQplXA009whfuy3EvL3Z3HfOqqtF5tEjcWBLoD9Xlc
         eOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927032; x=1781531832;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1FpzeaCggks3yhpbJYF6VSWOd0Jkfl4sIP/k1Ku/EA=;
        b=hXywnwwezaIccEmWuAP29EWx71KzrxXLSBq+uiDj3JFXB7C2J7W98sMnmBNSOjbhLz
         76C/Ll7g2eIIvx2oOzKJ8s17qYMk6UDms79Z/duB40zqaZv4WoBRLmoiV8hXcMBVLir9
         yf8PTWFD+MK0T5dFgodrkwEKs+ByrXjI11doHufViaM3UJr9oaKnjTFwQ57yr6jwDRaF
         GY3d3EHPJrACSRKSa42a5YO9J/Fae0n18vnDoDxzlxWUvSqXszA0FYGX75zkgne9D2ev
         epTMQYnrRPbsRsMyQIStY9aF0++2Xggmkbv9EAW+0Veo1d8jp37pfw0fIioVtpLaIk9k
         kOag==
X-Gm-Message-State: AOJu0YyJ3vbL8EkBOx0/6bAO3u05/oVgc1DM7UCLaNwvT+h7uJ+H4KQn
	OXV1sSpXmVNunvl7SbjDHT+M6kHcTHXpivUU7cauMkGCtTgBNwo6oNi1iBp7dw==
X-Gm-Gg: Acq92OHlGunJtH050vvx8QKoGekTb+TAzSxyNU6FUaSQ/PedCkUasL4vMCv5QwUsSch
	ojh/yJH0v28K4fDxy3B/E7YZG5AEp0+EMGJzn8cEQaYTFJJXsPSaq5HHJl5MCsP1rzeCJuQLFMh
	z0jfau8qWk88B5CXBaM3oUzTQLJsax5Tg7F1uf5GZQGlSeWPNIS3K6fxrHt+LXpVtzMgfgyX3vX
	0KY17a/JnAr3mmpbkNUSFUpdzS97wveImRRnXVGBRzx49vtsw3zPBXhw+0pXng3twd7XVuIh17O
	FGt96T64TeOixr+1YB6sagMGMvLdQqmRgmbFV1td0jpE5/IwnTyTjKix6oxwS41E1+PnyeuXFYl
	EHNfQJJu3dMagMefrHP6De8YPU+RT/b/wNbdbUS3jNMYu81v4la+uM+w5Fe66zNhE1AHVxTEA2o
	gvqbS3djZescfKyYRN2bEDmmKEy2ztcl9ZhJOa6w==
X-Received: by 2002:a05:620a:171f:b0:915:b9f6:71a2 with SMTP id af79cd13be357-915b9f674d0mr1506863285a.48.1780927031896;
        Mon, 08 Jun 2026 06:57:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afbcsm1776903485a.9.2026.06.08.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:57:11 -0700 (PDT)
Message-Id: <1b4ae3cc0b9bc18f0b001587e93ce83cf3dfa819.1780927027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 13:57:06 +0000
Subject: [PATCH 3/3] git: add --no-includes top-level option
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change added a GIT_CONFIG_INCLUDES=0 override in the
environment, similar to GIT_ADVICE=0. Follow the same model as
--no-advice to add a --no-includes option to the top-level Git options.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git.adoc    | 6 +++++-
 git.c                     | 6 +++++-
 t/t1305-config-include.sh | 8 ++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d..f220427930 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -12,7 +12,7 @@ SYNOPSIS
 'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
-    [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
+    [--no-optional-locks] [--no-advice] [--no-includes] [--bare] [--git-dir=<path>]
     [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
     <command> [<args>]
 
@@ -194,6 +194,10 @@ If you just want to run git as if it was started in `<path>` then use
 --no-advice::
 	Disable all advice hints from being printed.
 
+--no-includes::
+	Disable all `include.path` and `includeIf.*` config directives.
+	See linkgit:git-config[1] for more information.
+
 --literal-pathspecs::
 	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
 	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
diff --git a/git.c b/git.c
index 36f08891ef..52cfbf0e23 100644
--- a/git.c
+++ b/git.c
@@ -40,7 +40,7 @@ const char git_usage_string[] =
 	N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]\n"
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]\n"
-	   "           [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]\n"
+	   "           [--no-optional-locks] [--no-advice] [--no-includes] [--bare] [--git-dir=<path>]\n"
 	   "           [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]\n"
 	   "           <command> [<args>]");
 
@@ -354,6 +354,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_ADVICE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-includes")) {
+			setenv(CONFIG_INCLUDES_ENVIRONMENT, "0", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 270e4b89ab..b636e5ae7b 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -409,8 +409,11 @@ test_expect_success 'GIT_CONFIG_INCLUDES=0 disables include.path and includeIf'
 		git config get foo.baz &&
 		test_must_fail env GIT_CONFIG_INCLUDES=0 git config get foo.bar &&
 		test_must_fail env GIT_CONFIG_INCLUDES=0 git config get foo.baz &&
+		test_must_fail git --no-includes config get foo.bar &&
+		test_must_fail git --no-includes config get foo.baz &&
 		git config get --includes foo.bar &&
-		test_must_fail env GIT_CONFIG_INCLUDES=0 git config get --includes foo.bar
+		test_must_fail env GIT_CONFIG_INCLUDES=0 git config get --includes foo.bar &&
+		test_must_fail git --no-includes config get --includes foo.bar
 	)
 '
 
@@ -423,7 +426,8 @@ test_expect_success 'GIT_CONFIG_INCLUDES=0 blocks included alias override' '
 		git config set include.path config.inc &&
 		git config set -f .git/config.inc alias.test status &&
 		git test &&
-		test_must_fail env GIT_CONFIG_INCLUDES=0 git test
+		test_must_fail env GIT_CONFIG_INCLUDES=0 git test &&
+		test_must_fail git --no-includes test
 	)
 '
 
-- 
gitgitgadget
