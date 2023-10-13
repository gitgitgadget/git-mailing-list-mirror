Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4EA224F0
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXwtMk7S"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F225E120
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:39:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4054f790190so26958485e9.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218774; x=1697823574; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6hX5lKkvakXvjcS84xV1dirroc8iGIYTsDJRu98mMs=;
        b=JXwtMk7SIvWvE+/FG/DXyRfPU0PxRLbGITFrBoP2jDevyFg4pEezHxNZCFOlq9wBD1
         4R7LzoyzI9NePzyEufRjRU9DkYV8xPtg6rao7tpblk33pjCcM0k86aXkb+SbLJ9I2Fwx
         OWmT2XR5jcOmL3XodwMabDK+RZcq+pIfme55NTgxV7bK9oVVCAcZCBsHhAh5cchztI1k
         TuwZc573dd7CxH68blhW+7XmFVhBLz0l2Vo0xutMR4bc47R7l07UQAI+p6slfNTG5flC
         mViEcxCCfOBoaXYU9RtFh4dIojFTa4rhjvM+ijWEtZu1fdODB4MmfIrufActUqlhGEcd
         aiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218774; x=1697823574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6hX5lKkvakXvjcS84xV1dirroc8iGIYTsDJRu98mMs=;
        b=jgtR/VWqjdUSWAIVFVvnixbvdwKzZqeaKHle5OXA6pHfEDZz4iwT/TVnwdvwzu3vKp
         IzhxIZp+I9rxufBaw6e0Nsm5e4yDZ2j8ulhcPNJ8v4QdwIPBoZ+gFqEFpT6eXYJ4KeQo
         NX+htAznKOU49sd4XG4ijHoeYZBKhTjy0d17cX4t1qCOpH4shB1P/7S+qEBshIlKeaEu
         w5fxwGSr6xGocDRzEZvHpyYCE2Mx3ZxL1j1GRW1nQml11eoNHq9exlnzrUNHSsqO8Sl4
         S8GjniwFTR36b+Lr4FOYMrZJD3N1N9mCsqVZZ6vswy/SrqI1cmk1x2QTvN74HQsRQnUL
         1ccA==
X-Gm-Message-State: AOJu0YzYBBtPYuL7ef0WY4U1bWhVmvNtUIy2r6umxAXfZB9U9soaaDiQ
	NheveZCTfoDYSCMUCaTZf33YibsP5Mc=
X-Google-Smtp-Source: AGHT+IEbOmSNyZMNKlZdB8H1jm1pdPtLQpYcMjUkSefAh9/OdhtkA3H1MTuvnR1YZzgUwGrYZxza3Q==
X-Received: by 2002:a7b:c5c9:0:b0:405:40ab:7693 with SMTP id n9-20020a7bc5c9000000b0040540ab7693mr22993810wmk.31.1697218773617;
        Fri, 13 Oct 2023 10:39:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b004068e09a70bsm731956wmo.31.2023.10.13.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:32 -0700 (PDT)
Message-ID: <df4b3f5330987558ea1c04d8523489daef719c77.1697218770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
References: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
	<pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Oct 2023 17:39:30 +0000
Subject: [PATCH v5 2/2] attr: add attr.tree for setting the treeish to read
 attributes from
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
Cc: Jeff King <peff@peff.net>,
    Jonathan Tan <jonathantanmy@google.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: John Cai <johncai86@gmail.com>

44451a2 (attr: teach "--attr-source=<tree>" global option to "git",
2023-05-06) provided the ability to pass in a treeish as the attr
source. In the context of serving Git repositories as bare repos like we
do at GitLab however, it would be easier to point --attr-source to HEAD
for all commands by setting it once.

Add a new config attr.tree that allows this.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/config.txt      |  2 ++
 Documentation/config/attr.txt |  7 ++++
 attr.c                        |  7 ++++
 attr.h                        |  2 ++
 config.c                      | 16 +++++++++
 t/t0003-attributes.sh         | 61 +++++++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+)
 create mode 100644 Documentation/config/attr.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 229b63a454c..b1891c2b5af 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -371,6 +371,8 @@ other popular tools, and describe them in your documentation.
 
 include::config/advice.txt[]
 
+include::config/attr.txt[]
+
 include::config/core.txt[]
 
 include::config/add.txt[]
diff --git a/Documentation/config/attr.txt b/Documentation/config/attr.txt
new file mode 100644
index 00000000000..1a482d6af2b
--- /dev/null
+++ b/Documentation/config/attr.txt
@@ -0,0 +1,7 @@
+attr.tree::
+	A reference to a tree in the repository from which to read attributes,
+	instead of the `.gitattributes` file in the working tree. In a bare
+	repository, this defaults to `HEAD:.gitattributes`. If the value does
+	not resolve to a valid tree object, an empty tree is used instead.
+	When the `GIT_ATTR_SOURCE` environment variable or `--attr-source`
+	command line option are used, this configuration variable has no effect.
diff --git a/attr.c b/attr.c
index bf2ea1626a6..e62876dfd3e 100644
--- a/attr.c
+++ b/attr.c
@@ -24,6 +24,8 @@
 #include "tree-walk.h"
 #include "object-name.h"
 
+const char *git_attr_tree;
+
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
 static const char git_attr__unknown[] = "(builtin)unknown";
@@ -1206,6 +1208,11 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
+	if (!default_attr_source_tree_object_name && git_attr_tree) {
+		default_attr_source_tree_object_name = git_attr_tree;
+		ignore_bad_attr_tree = 1;
+	}
+
 	if (!default_attr_source_tree_object_name &&
 	    startup_info->have_repository &&
 	    is_bare_repository()) {
diff --git a/attr.h b/attr.h
index 2b745df4054..127998ae013 100644
--- a/attr.h
+++ b/attr.h
@@ -236,4 +236,6 @@ const char *git_attr_global_file(void);
 /* Return whether the system gitattributes file is enabled and should be used. */
 int git_attr_system_is_enabled(void);
 
+extern const char *git_attr_tree;
+
 #endif /* ATTR_H */
diff --git a/config.c b/config.c
index 3846a37be97..fb6a2db1d9b 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,7 @@
 #include "repository.h"
 #include "lockfile.h"
 #include "mailmap.h"
+#include "attr.h"
 #include "exec-cmd.h"
 #include "strbuf.h"
 #include "quote.h"
@@ -1904,6 +1905,18 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_attr_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "attr.tree"))
+		return git_config_string(&git_attr_tree, var, value);
+
+	/*
+	 * Add other attribute related config variables here and to
+	 * Documentation/config/attr.txt.
+	 */
+	return 0;
+}
+
 int git_default_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
@@ -1927,6 +1940,9 @@ int git_default_config(const char *var, const char *value,
 	if (starts_with(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
+	if (starts_with(var, "attr."))
+		return git_default_attr_config(var, value);
+
 	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
 		return git_default_advice_config(var, value);
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 5665cdc079f..ecf43ab5454 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -40,6 +40,10 @@ attr_check_source () {
 	test_cmp expect actual &&
 	test_must_be_empty err
 
+	git $git_opts -c "attr.tree=$source" check-attr test -- "$path" >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+
 	GIT_ATTR_SOURCE="$source" git $git_opts check-attr test -- "$path" >actual 2>err &&
 	test_cmp expect actual &&
 	test_must_be_empty err
@@ -342,6 +346,43 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
+
+test_expect_success '--attr-source is bad' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo "$bad_attr_source_err" >expect_err &&
+		test_must_fail git --attr-source=HEAD check-attr test -- f/path 2>err &&
+		test_cmp expect_err err
+	)
+'
+
+test_expect_success 'attr.tree when HEAD is unborn' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo "f/path: test: unspecified" >expect &&
+		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
+		test_must_be_empty err &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'bad attr source defaults to reading .gitattributes file' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo "f/path test=val" >.gitattributes &&
+		echo "f/path: test: val" >expect &&
+		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
+		test_must_be_empty err &&
+		test_cmp expect actual
+	)
+'
 
 test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
 	test_when_finished rm -rf test bare_with_gitattribute &&
@@ -353,6 +394,26 @@ test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success 'precedence of --attr-source, GIT_ATTR_SOURCE, then attr.tree' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		git checkout -b attr-source &&
+		test_commit "val1" .gitattributes "f/path test=val1" &&
+		git checkout -b attr-tree &&
+		test_commit "val2" .gitattributes "f/path test=val2" &&
+		git checkout attr-source &&
+		echo "f/path: test: val1" >expect &&
+		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree --attr-source=attr-source \
+		check-attr test -- f/path >actual &&
+		test_cmp expect actual &&
+		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree \
+		check-attr test -- f/path >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
-- 
gitgitgadget
