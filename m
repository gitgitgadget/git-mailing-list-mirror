Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D2C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiBSQpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 11:45:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbiBSQpL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 11:45:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200615F4EC
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n8so7065332wms.3
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JeMQVge3pnF85LeDYjUr4sSDzJHFHq/dkQz6Z/0E+3Y=;
        b=bdg042TYYHJ5lY6y0zOm+yVAF5XKsRkRRAh4vlk55kSHWbdDVrSXgd4p4kG16Xzx6t
         HRQUsW1jMSJHniuYJZxaxraAgorFS4EIM8jr2BE7s4LiD1kTWLZNeQhAtcA/WqrUhWbf
         aS3H/kohvJ+e89kacK8hSokZPVhBOVC0/IrcohBMs1rj7RthU3O1NYh4xh9I9zZzEr4e
         apFbwx0a9SRl13JuF2JGArP2yWnF6165M199CxV+9BKqVmA+3BAxa005gL7Dq8DfzkV3
         VLEyzDN/NYnMOELY7I4nOLy2N8fZL/ysdxCUOCctsuDfzCn25x3jKy4B+yIyQlVqYPIL
         4oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JeMQVge3pnF85LeDYjUr4sSDzJHFHq/dkQz6Z/0E+3Y=;
        b=0YCNEbl4pTYVrrvdhFnqCEDUvCivWJ+5Y04NPX8qg+ezzki4q7YPkrd+c1Q5LiJ3r+
         KRnBaAvLp2ETDnq/weY2VULdf3p7IKcmuJpE6hevutAsFhsIiqvKyIGH78baqbwUTWF5
         csyqfczNTIskma85yfxm+oIt+H2Skzi6/xewkM4Oz0o/cKEnwEq9m9g8SRrFNS0PSiGY
         6+dHqwmK26dX5Ye5iWu69HIIZjTB1/pwsUgdt5OlpSkwXVHL42FUbpXmW17gXe8CI5vX
         Eut6H8SXMRO2ZQvqKf0aBtqoC0v0iNwLNDag+p0QLAdvJeWO23+ARd7L7xhYmj8dXro4
         px6Q==
X-Gm-Message-State: AOAM5313YmOjyrcBadJlrPnhM+D1OIKaSqmPz0ubr1Y1qAQXdjpHfpKM
        aJds6CFiv5vhEbSnlLLDK62ZrGfKwtE=
X-Google-Smtp-Source: ABdhPJy9OUwYQmSYJXcEnxIBNMAK+wRyW8yZOXPRYlbm3SrKM3KbgjnS1C6Sfh1tD5r8RW1WoV2lRQ==
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id l1-20020a7bc341000000b0037bc619c9f4mr15173940wmj.38.1645289090424;
        Sat, 19 Feb 2022 08:44:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm32648564wro.89.2022.02.19.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 08:44:49 -0800 (PST)
Message-Id: <06cf71bfca41ab0d9d4d15996fd8ebc78d7e3f7b.1645289086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
References: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
        <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 16:44:43 +0000
Subject: [PATCH v5 3/5] sparse-checkout: pay attention to prefix for {set,
 add}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In cone mode, non-option arguments to set & add are clearly paths, and
as such, we should pay attention to prefix.

In non-cone mode, it is not clear that folks intend to provide paths
since the inputs are gitignore-style patterns.  Paying attention to
prefix would prevent folks from doing things like
   git sparse-checkout add /.gitattributes
   git sparse-checkout add '/toplevel-dir/*'
In fact, the former will result in
   fatal: '/.gitattributes' is outside repository...
while the later will result in
   fatal: Invalid path '/toplevel-dir': No such file or directory
despite the fact that both are valid gitignore-style patterns that would
select real files if added to the sparse-checkout file.  This might lead
people to just use the path without the leading slash, potentially
resulting in them grabbing files with the same name throughout the
directory hierarchy contrary to their expectations.  See also [1] and
[2].  Adding prefix seems to just be fraught with error; so for now
simply throw an error in non-cone mode when sparse-checkout set/add are
run from a subdirectory.

[1] https://lore.kernel.org/git/e1934710-e228-adc4-d37c-f706883bd27c@gmail.com/
[2] https://lore.kernel.org/git/CABPp-BHXZ-XLxY0a3wCATfdq=6-EjW62RzbxKAoFPeXfJswD2w@mail.gmail.com/

Helped-by: Junio Hamano <gitster@pobox.com>
Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 26 +++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 41 ++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fb85a1459c3..3f828feb1f0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -684,6 +684,28 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
+static void sanitize_paths(int argc, const char **argv, const char *prefix)
+{
+	if (!argc)
+		return;
+
+	if (prefix && *prefix && core_sparse_checkout_cone) {
+		/*
+		 * The args are not pathspecs, so unfortunately we
+		 * cannot imitate how cmd_add() uses parse_pathspec().
+		 */
+		int i;
+		int prefix_len = strlen(prefix);
+
+		for (i = 0; i < argc; i++)
+			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
+	}
+
+	if (prefix && *prefix && !core_sparse_checkout_cone)
+		die(_("please run from the toplevel directory in non-cone mode"));
+
+}
+
 static char const * const builtin_sparse_checkout_add_usage[] = {
 	N_("git sparse-checkout add (--stdin | <patterns>)"),
 	NULL
@@ -711,6 +733,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	sanitize_paths(argc, argv, prefix);
+
 	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
 }
 
@@ -762,6 +786,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	if (!core_sparse_checkout_cone && argc == 0) {
 		argv = default_patterns;
 		argc = default_patterns_nr;
+	} else {
+		sanitize_paths(argc, argv, prefix);
 	}
 
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ce5e7c19efa..c1f86b0e02e 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -798,4 +798,45 @@ test_expect_success 'malformed cone-mode patterns' '
 	grep "warning: disabling cone pattern matching" err
 '
 
+test_expect_success 'set from subdir pays attention to prefix' '
+	git -C repo sparse-checkout disable &&
+	git -C repo/deep sparse-checkout set --cone deeper2 ../folder1 &&
+
+	git -C repo sparse-checkout list >actual &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper2
+	folder1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add from subdir pays attention to prefix' '
+	git -C repo sparse-checkout set --cone deep/deeper2 &&
+	git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 &&
+
+	git -C repo sparse-checkout list >actual &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper1/deepest
+	deep/deeper2
+	folder1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set from subdir in non-cone mode throws an error' '
+	git -C repo sparse-checkout disable &&
+	test_must_fail git -C repo/deep sparse-checkout set --no-cone deeper2 ../folder1 2>error &&
+
+	grep "run from the toplevel directory in non-cone mode" error
+'
+
+test_expect_success 'set from subdir in non-cone mode throws an error' '
+	git -C repo sparse-checkout set --no-cone deep/deeper2 &&
+	test_must_fail git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 2>error &&
+
+	grep "run from the toplevel directory in non-cone mode" error
+'
+
 test_done
-- 
gitgitgadget

