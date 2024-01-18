Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DB2573
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542926; cv=none; b=hG+n8tSVcnWM0VjB8Th5x+Z6RJ7kmSOzS2BbhTMfCJN4gTP0odSEG/SkxYYq1neFX/2C/yo+Z268yH2/8gBoGPpJto8053j58b5ZLFaSZ6F31sTtVPYQByMptH88tEpHIXkAMMgTU+2y74Ki4lltU8d5/jOBa1cWJcL9PmrHLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542926; c=relaxed/simple;
	bh=GB+N8gFzH4vTKIGCtmd+GCGSDkAcUu72ECNFI39JLaE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=t7vTeJiWur2FJ3dfA0Y84VrUcK03asX/TLuexi1kc1v4GibR7W/JmlTuHaS3aoGyUPjCtEPx773E6Uy7v8HXKiNtbqT4ZLnkIz4rjblkLxGGcgmwJXypGr8ZODcd37XxQ2yXPS/P6vMUkl0i+pjrs9iFpQzb0mYUm02bk0i8AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqClTPp6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqClTPp6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e8d3b32eeso9106895e9.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542922; x=1706147722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PavoUQAhhD9XkWJ25IHDPp+eG0+ToT+MytcUOPj1yQ8=;
        b=BqClTPp6skMhP/ebt7zMlirPyrf0D2ySl6oO6jetmv6s8Kmbuj61GZyQ4I5Yr89WHO
         vIi7G/GfZAZkysfOKv/uKxFGHPpOtIoSR1hhIQBs0LI2ixeU/pxcygKATG0f8AA2cmXA
         qABya11NbMe3duOGxJSLPDsdPPpW1PXYtgGuEUkf66HI0by5009NvZzc8hKLpCBelIeY
         q3mNTKBqQKdEzYVruYQwGOziggyZbBTnq4U1P3yFOolVIvBn0iX1CpCLoLZbc2pNclj6
         67gPJGgtAT8WfO6A3q8xTZMYmbHv1ESUMlbuNtz2yGHNXlkSnAUYlBd3FRSMb/Ya1k2j
         0cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542922; x=1706147722;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PavoUQAhhD9XkWJ25IHDPp+eG0+ToT+MytcUOPj1yQ8=;
        b=i/7519uXLyrlk4GirAcd/s6r3/HjjR6QFBLlj1qiYroxUXiV8u3nfKGXG5btn7wZPP
         nnpHUQoo4+TJRoLAHopd6wPTPL8B3DiNPxz4ABJfrMarY7qrKKm3H8TY0OuI77w8B0qa
         rDu+MOQK6Oqg6YtH6j8fnGpwX8cm78TiOpI1d5kQryYJXni71m+UJhhZkvrYym5/zwDu
         o2O7JW4SBWBsbhjf9jNOY+e9Id1teY+/fxBCwLMG4kWnM8iZsKBBBKYaznPF4Oc0HLOy
         fWBkYi5kM/rPOk9tinzVjsR2ClQFYW7Yqa3CUAgUv4KAdqk0iMPqVpj5PaVH7prGv5T6
         +oSA==
X-Gm-Message-State: AOJu0Yw+h4nzUW1BTi06J9Y83JK3ZXmeiCljRzK08/CgbTOvzaWbg1Zu
	DPfc5Avzt62DL2qwkhurQ4Z0W9xIdVoRCp79eA3lZNkGwgKiW82sn9a9WYiV
X-Google-Smtp-Source: AGHT+IHcba0Cml9zUwMS/xFjex7/mPazZhhBke7Lvvephm22myVo05VaOBJiFJT7WRrCESxxokyRvA==
X-Received: by 2002:a05:600c:2151:b0:40e:3cb0:b27c with SMTP id v17-20020a05600c215100b0040e3cb0b27cmr52827wml.71.1705542922181;
        Wed, 17 Jan 2024 17:55:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv17-20020a05600c549100b0040e5034d8e0sm28210933wmb.43.2024.01.17.17.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:55:21 -0800 (PST)
Message-ID: <b6843a58389170a45b5ef7809e0335a6425eadaa.1705542918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 01:55:17 +0000
Subject: [PATCH v2 3/4] t7450: test submodule urls
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add tests to 't7450-bad-git-dotfiles.sh' to check the validity of different
submodule URLs. To verify this directly (without setting up test
repositories & submodules), add a 'check-url' subcommand to 'test-tool
submodule' that calls 'check_submodule_url' in the same way that
'check-name' calls 'check_submodule_name'.

Add two tests to separately address cases where the URL check correctly
filters out invalid URLs and cases where the check misses invalid URLs. Mark
the latter ("url check misses invalid cases") with 'test_expect_failure' to
indicate that this not the undesired behavior.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/helper/test-submodule.c   | 35 +++++++++++++++++++++++++++++++----
 t/t7450-bad-git-dotfiles.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 9adbc8d1568..7197969a081 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -15,6 +15,13 @@ static const char *submodule_check_name_usage[] = {
 	NULL
 };
 
+#define TEST_TOOL_CHECK_URL_USAGE \
+	"test-tool submodule check-url"
+static const char *submodule_check_url_usage[] = {
+	TEST_TOOL_CHECK_URL_USAGE,
+	NULL
+};
+
 #define TEST_TOOL_IS_ACTIVE_USAGE \
 	"test-tool submodule is-active <name>"
 static const char *submodule_is_active_usage[] = {
@@ -31,17 +38,23 @@ static const char *submodule_resolve_relative_url_usage[] = {
 
 static const char *submodule_usage[] = {
 	TEST_TOOL_CHECK_NAME_USAGE,
+	TEST_TOOL_CHECK_URL_USAGE,
 	TEST_TOOL_IS_ACTIVE_USAGE,
 	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
 	NULL
 };
 
-/* Filter stdin to print only valid names. */
-static int check_name(void)
+typedef int (*check_fn_t)(const char *);
+
+/*
+ * Apply 'check_fn' to each line of stdin, printing values that pass the check
+ * to stdout.
+ */
+static int check_submodule(check_fn_t check_fn)
 {
 	struct strbuf buf = STRBUF_INIT;
 	while (strbuf_getline(&buf, stdin) != EOF) {
-		if (!check_submodule_name(buf.buf))
+		if (!check_fn(buf.buf))
 			printf("%s\n", buf.buf);
 	}
 	strbuf_release(&buf);
@@ -58,7 +71,20 @@ static int cmd__submodule_check_name(int argc, const char **argv)
 	if (argc)
 		usage_with_options(submodule_check_name_usage, options);
 
-	return check_name();
+	return check_submodule(check_submodule_name);
+}
+
+static int cmd__submodule_check_url(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, "test-tools", options,
+			     submodule_check_url_usage, 0);
+	if (argc)
+		usage_with_options(submodule_check_url_usage, options);
+
+	return check_submodule(check_submodule_url);
 }
 
 static int cmd__submodule_is_active(int argc, const char **argv)
@@ -184,6 +210,7 @@ static int cmd__submodule_config_writeable(int argc, const char **argv UNUSED)
 
 static struct test_cmd cmds[] = {
 	{ "check-name", cmd__submodule_check_name },
+	{ "check-url", cmd__submodule_check_url },
 	{ "is-active", cmd__submodule_is_active },
 	{ "resolve-relative-url", cmd__submodule_resolve_relative_url},
 	{ "config-list", cmd__submodule_config_list },
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 35a31acd4d7..c73b1c92ecc 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -45,6 +45,41 @@ test_expect_success 'check names' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check urls' '
+	cat >expect <<-\EOF &&
+	./bar/baz/foo.git
+	https://example.com/foo.git
+	http://example.com:80/deeper/foo.git
+	EOF
+
+	test-tool submodule check-url >actual <<-\EOF &&
+	./bar/baz/foo.git
+	https://example.com/foo.git
+	http://example.com:80/deeper/foo.git
+	-a./foo
+	../../..//test/foo.git
+	../../../../../:localhost:8080/foo.git
+	..\../.\../:example.com/foo.git
+	./%0ahost=example.com/foo.git
+	https://one.example.com/evil?%0ahost=two.example.com
+	https:///example.com/foo.git
+	https::example.com/foo.git
+	http:::example.com/foo.git
+	EOF
+
+	test_cmp expect actual
+'
+
+# NEEDSWORK: the URL checked here is not valid (and will not work as a remote if
+# a user attempts to clone it), but the fsck check passes.
+test_expect_failure 'url check misses invalid cases' '
+	test-tool submodule check-url >actual <<-\EOF &&
+	http://example.com:test/foo.git
+	EOF
+
+	test_must_be_empty actual
+'
+
 test_expect_success 'create innocent subrepo' '
 	git init innocent &&
 	git -C innocent commit --allow-empty -m foo
-- 
gitgitgadget

