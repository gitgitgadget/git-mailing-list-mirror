Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6FEC636D4
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 03:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBEDq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 22:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBEDq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 22:46:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDC51EFC3
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 19:46:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk16so7682787wrb.11
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 19:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ANGdW31xA7qf86Hz/udtnnud76o+MVccQhRrfX8EuU=;
        b=amRX/kgiqsTwHd8aP4P4FGvwRozISlFjchh6XeUIr6jhjCLwpaOrHb+iRd7sAz54xW
         egzRhu1m5bhyuMKGKGz+algIrZvqnxz5tjAwGDGXabBIonHjvNGMyObV5lQ9mse8g1K3
         AlBIJ60uas4eYCw8Yt2ZST6s6jc+jbmBHtUT5whFMnwtV9oWmG34f+OLRiOVju5d+weK
         hq9uAbyLsfC1+v9E0/wnBmWfzo2ybdLvCcLg9p+KuRTwH3dg8586pZk3EuLIVI0JXeZF
         jdw9v31bkDxctijC8Hu5vhXq6bkfXSo7yR3znnkVGf3qa0pgAMXrSwMAi4p3kBt/0syv
         nNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ANGdW31xA7qf86Hz/udtnnud76o+MVccQhRrfX8EuU=;
        b=JSvsCU6hu/TjsVCkoFcT4NjlfJCMp8uaDBD60g6WfFVNLBgHz8C06FW62jScBRQmfO
         D8rgxk3YY9rESe4qWAIlmwIvdlXcRzOV9N+BnVqfolL65pI9q1jBtsQJvo2UyjZKzX7M
         cmXO3n1lWLvYcjNLeYorxNhUChgo+IDWT0VTX9Ir4/G0+GLSaS0C0akpM1fXZAb3nrAE
         mwUWMXerZK2rlLK5chtx3ZMJWxNGv4yduTo10Vh2BV3EyIucLq3YL8D0QnVXtDEY7TMV
         vrnKfGfvDOJw7gU1Q0UyHybolobNeQCl6inZIVWGm1fm7flKWW+WsztXnUmWSAqJXa+3
         dqHg==
X-Gm-Message-State: AO0yUKWXx5MuGrwrBa7Na0zbz2pn1WaVmDpCY86uRyCQxtQvFxJ8xKx7
        kN5+bkOAQarFmoC6d7xx7u1WC1NSefA=
X-Google-Smtp-Source: AK7set9bsOocJuN2aPFuzmlgfZVq9eXvb1llrveC7ELabGYeqLhenaNCL9wHXG1VShzCXYvjpPfFhg==
X-Received: by 2002:a05:6000:1c12:b0:2bf:b710:c0b with SMTP id ba18-20020a0560001c1200b002bfb7100c0bmr18595120wrb.1.1675568784192;
        Sat, 04 Feb 2023 19:46:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b002bdf3809f59sm5644154wrt.38.2023.02.04.19.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 19:46:23 -0800 (PST)
Message-Id: <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Feb 2023 03:46:21 +0000
Subject: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

It can be useful to specify diff algorithms per file type. For example,
one may want to use the minimal diff algorithm for .json files, another
for .c files, etc.

Teach the diff machinery to check attributes for a diff algorithm.
Enforce precedence by favoring the command line option, then looking at
attributes, then finally the config.

To enforce precedence order, set the `xdl_opts_command_line` member
during options pasing to indicate the diff algorithm was set via command
line args.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/gitattributes.txt | 23 +++++++++++++++++++++++
 diff.c                          | 25 +++++++++++++++++++++++++
 diff.h                          |  2 ++
 t/lib-diff-alternative.sh       | 27 ++++++++++++++++++++++++++-
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c19e64ea0ef..501dd536037 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -736,6 +736,29 @@ String::
 	by the configuration variables in the "diff.foo" section of the
 	Git config file.
 
+`diff-algorithm`
+^^^^^^^^^^^^^^^^
+
+The attribute `diff-algorithm` affects which algorithm Git uses to generate
+diffs. This allows defining diff algorithms per file extension. Precedence rules
+are as follows, in order from highest to lowest:
+
+*Command line option*
+
+Pass in the `--diff-algorithm` command line option int git-diff(1)
+
+*Git attributes*
+
+------------------------
+*.json	diff-algorithm=histogram
+------------------------
+
+*Git config*
+
+----------------------------------------------------------------
+[diff]
+	algorithm = histogram
+----------------------------------------------------------------
 
 Defining an external diff driver
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/diff.c b/diff.c
index a8a31c81fe7..c78e28daeb0 100644
--- a/diff.c
+++ b/diff.c
@@ -3652,6 +3652,27 @@ static void builtin_diff(const char *name_a,
 		ecbdata.opt = o;
 		if (header.len && !o->flags.suppress_diff_headers)
 			ecbdata.header = &header;
+
+		if (!o->xdl_opts_command_line) {
+			static struct attr_check *check;
+			const char *one_diff_algo;
+			const char *two_diff_algo;
+
+			check = attr_check_alloc();
+			attr_check_append(check, git_attr("diff-algorithm"));
+
+			git_check_attr(the_repository->index, NULL, one->path, check);
+			one_diff_algo = check->items[0].value;
+			git_check_attr(the_repository->index, NULL, two->path, check);
+			two_diff_algo = check->items[0].value;
+
+			if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(two_diff_algo) &&
+				!strcmp(one_diff_algo, two_diff_algo))
+				set_diff_algorithm(o, one_diff_algo);
+
+			attr_check_free(check);
+		}
+
 		xpp.flags = o->xdl_opts;
 		xpp.ignore_regex = o->ignore_regex;
 		xpp.ignore_regex_nr = o->ignore_regex_nr;
@@ -5130,6 +5151,8 @@ static int diff_opt_diff_algorithm(const struct option *opt,
 		return error(_("option diff-algorithm accepts \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
+	options->xdl_opts_command_line = 1;
+
 	return 0;
 }
 
@@ -5157,6 +5180,8 @@ static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
 		return error(_("available diff algorithms include \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
+	options->xdl_opts_command_line = 1;
+
 	return 0;
 }
 
diff --git a/diff.h b/diff.h
index 41eb2c3d428..46b565abfd4 100644
--- a/diff.h
+++ b/diff.h
@@ -333,6 +333,8 @@ struct diff_options {
 	int prefix_length;
 	const char *stat_sep;
 	int xdl_opts;
+	/* If xdl_opts has been set via the command line. */
+	int xdl_opts_command_line;
 
 	/* see Documentation/diff-options.txt */
 	char **anchors;
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 8d1e408bb58..630c98ea65a 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -107,8 +107,27 @@ EOF
 
 	STRATEGY=$1
 
+	test_expect_success "$STRATEGY diff from attributes" '
+		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
+		test_must_fail git diff --no-index file1 file2 > output &&
+		test_cmp expect output
+	'
+
 	test_expect_success "$STRATEGY diff" '
-		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
+		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "$STRATEGY diff command line precedence before attributes" '
+		echo "file* diff-algorithm=meyers" >.gitattributes &&
+		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "$STRATEGY diff attributes precedence before config" '
+		git config diff.algorithm default &&
+		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
+		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
 		test_cmp expect output
 	'
 
@@ -166,5 +185,11 @@ EOF
 		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > output &&
 		test_cmp expect output
 	'
+
+	test_expect_success "$STRATEGY diff from attributes" '
+		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
+		test_must_fail git diff --no-index uniq1 uniq2 > output &&
+		test_cmp expect output
+	'
 }
 
-- 
gitgitgadget
