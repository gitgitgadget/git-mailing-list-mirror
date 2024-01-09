Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D23BB29
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQZVkuJD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so36978835e9.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822819; x=1705427619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKHsLE/75B773wPi0pVAYT+gtmaXB/i1nthQGu9m2Nw=;
        b=iQZVkuJDMYhRB29NwZ2z9ZZeSpskJQiCi0/i30dxd7gQ4O/np7iQInuKjcCkPQ3tDs
         OZBEFB8jznMgCJQ/KBjdAiidZW/+6zEAr0PlIvUw1ZBv8C1IOzeiZBW7xwnh6mDGkmJo
         tJhWlU3Ub+4F2GCegZPAdLfmcbe5VBMSUtXcO7/+PbAWVQxh8OFKABMSo1iSWyKzdB86
         2hfH2PB6Gbn4v/YIY0Z/Tl3V8Hl0S3qf70uFtF9ic3cPiuwmNGcdXzp5lPEq4OxhXspZ
         tMURTuDHQ4I8k9t7bqUDjlMtyOL7fk6Tpk/qOWzk5axaKSgPNT4nuQdq/CWMG99Dx0oA
         NtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822819; x=1705427619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKHsLE/75B773wPi0pVAYT+gtmaXB/i1nthQGu9m2Nw=;
        b=kilfAbbXpxIUrq6u+bLyNA5+iIIQydksvXJu9I2TX0e3VlCQ8WJSPCLKi5bU2OTNDV
         fGWpcJOG2cpwX/593k+oqTneF+YAWTjf7kDk40VQCEXYxrpY7miFup1OKI3f4+aSXlcI
         nOyfMXQz5FJC1abhHAhdfDbWBjoT54I9/ISSUyjT/N7ZAxK8eMLFZ17eH0GWdTHangUp
         /zN8cskEvT2gX7hcQYC/pT6JEuMenI33fbOl8tJD4ZT08+lJsQRh0lO2puE5BCiWLYIF
         Ls1/B+tjqDRL78Cb8I1FzcMmEQSg78sKteA2c7VpoRgMzeZ+PKMki34c7XlPL3DvAYkn
         mDgg==
X-Gm-Message-State: AOJu0YxEgxifBDe04TS0bTvhdDL2xCjIcnvUBoVZ46QE1vvfgwtN9rf4
	RLFLOqHY+n5NSlAAHRFMs4IjDmpBkR8=
X-Google-Smtp-Source: AGHT+IHnIt8XsEtwp/ucgLd0wQ0o6fkQWZjCMxEl0U9GXPJAsHDwT8hZs0A954m+nqnZ7/fiRczJ8g==
X-Received: by 2002:a05:600c:a42:b0:40d:8f82:79bb with SMTP id c2-20020a05600c0a4200b0040d8f8279bbmr3194559wmq.182.1704822819520;
        Tue, 09 Jan 2024 09:53:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020adfe552000000b003365fcc1846sm2965010wrm.52.2024.01.09.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:53:39 -0800 (PST)
Message-ID: <cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jan 2024 17:53:36 +0000
Subject: [PATCH 2/3] t7450: test submodule urls
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add a test to 't7450-bad-git-dotfiles.sh' to check the validity of different
submodule URLs. To test this directly (without setting up test repositories
& submodules), add a 'check-url' subcommand to 'test-tool submodule' that
calls 'check_submodule_url' in the same way that 'check-name' calls
'check_submodule_name'.

Mark the test with 'test_expect_failure' because, as it stands,
'check_submodule_url' marks certain invalid URLs valid. Specifically, the
invalid URL "http://example.com:test/foo.git" is incorrectly marked valid in
the test.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/helper/test-submodule.c   | 31 +++++++++++++++++++++++++++----
 t/t7450-bad-git-dotfiles.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 50c154d0370..da89d265f0f 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -15,6 +15,13 @@ static const char *submodule_check_name_usage[] = {
 	NULL
 };
 
+#define TEST_TOOL_CHECK_URL_USAGE \
+	"test-tool submodule check-url <url>"
+static const char *submodule_check_url_usage[] = {
+	TEST_TOOL_CHECK_URL_USAGE,
+	NULL
+};
+
 #define TEST_TOOL_IS_ACTIVE_USAGE \
 	"test-tool submodule is-active <name>"
 static const char *submodule_is_active_usage[] = {
@@ -36,22 +43,24 @@ static const char *submodule_usage[] = {
 	NULL
 };
 
+typedef int (*check_fn_t)(const char *);
+
 /*
  * Exit non-zero if any of the submodule names given on the command line is
  * invalid. If no names are given, filter stdin to print only valid names
  * (which is primarily intended for testing).
  */
-static int check_name(int argc, const char **argv)
+static int check_submodule(int argc, const char **argv, check_fn_t check_fn)
 {
 	if (argc > 1) {
 		while (*++argv) {
-			if (check_submodule_name(*argv) < 0)
+			if (check_fn(*argv) < 0)
 				return 1;
 		}
 	} else {
 		struct strbuf buf = STRBUF_INIT;
 		while (strbuf_getline(&buf, stdin) != EOF) {
-			if (!check_submodule_name(buf.buf))
+			if (!check_fn(buf.buf))
 				printf("%s\n", buf.buf);
 		}
 		strbuf_release(&buf);
@@ -69,7 +78,20 @@ static int cmd__submodule_check_name(int argc, const char **argv)
 	if (argc)
 		usage_with_options(submodule_check_name_usage, options);
 
-	return check_name(argc, argv);
+	return check_submodule(argc, argv, check_submodule_name);
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
+	return check_submodule(argc, argv, check_submodule_url);
 }
 
 static int cmd__submodule_is_active(int argc, const char **argv)
@@ -195,6 +217,7 @@ static int cmd__submodule_config_writeable(int argc, const char **argv UNUSED)
 
 static struct test_cmd cmds[] = {
 	{ "check-name", cmd__submodule_check_name },
+	{ "check-url", cmd__submodule_check_url },
 	{ "is-active", cmd__submodule_is_active },
 	{ "resolve-relative-url", cmd__submodule_resolve_relative_url},
 	{ "config-list", cmd__submodule_config_list },
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 35a31acd4d7..0dbf13724f4 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -45,6 +45,32 @@ test_expect_success 'check names' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'check urls' '
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
+	http://example.com:test/foo.git
+	https::example.com/foo.git
+	http:::example.com/foo.git
+	EOF
+
+	test_cmp expect actual
+'
+
 test_expect_success 'create innocent subrepo' '
 	git init innocent &&
 	git -C innocent commit --allow-empty -m foo
-- 
gitgitgadget

