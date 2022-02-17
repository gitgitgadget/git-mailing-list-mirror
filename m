Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED9C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 06:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiBQGzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:55:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiBQGzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 01:55:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0A27F296
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f3so7072761wrh.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f0OZN1ajAW18gNUvDd6eMnhicKRqBDk+zjM5HmxM5As=;
        b=RB/cNRMfxgffy0lDfglWWvfEdTqYizHv9xDfGDPkpOuZyJO5fc4jxM9NXish7lDd0Z
         RWlXjSAAAfWlQwvdfjWmk5Y0ua3FRcUTLd3UPMG2PPHhs3NCSXbupdpcM08Xt0Y3WJsW
         4FW4Pa70IRe6gdCudE9qoWoyY7m1QZnGHJGZTCPDwhEuAH6XNWSmiYUw5jBZhTkhgdVy
         bSwc8SJb+YDUzVtuvNMuXzu7bfupNI8WCqJcprLEHHdl4XYpCZDZ/BuhXhDaXGBOil9q
         k017tpoo5BePTEXqneM8715v2QtJUXpsUX8RzWyngM5iJigh4Bl7rzcZ9bm8nokWBh3e
         6ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f0OZN1ajAW18gNUvDd6eMnhicKRqBDk+zjM5HmxM5As=;
        b=WFguUuuVlx5PpfhPHlZQjSjXYHQ/d5sDIDqBxVqq/U6vobj/3QXqDGl2RShsBZXCIL
         fld3Jvhe0M7MdWW+pKDHCtE98YPVFRpmdhxzoDGUEXCOprhiU10wcm8CNwtwJ6tK+7OF
         4eH+ShGI+i/IyvDOpM0Imk73mcMJ+0mRP1jtPruKOPM5e3yRbqJZOTSZz5RtDJpb8IWj
         /wxg2R3wXTtQaAkhSAePBiVp4SbnHRSh6UTHgHS+gQjEskgIodcG3rapBzHHj+mrzLwZ
         oamIgTSMytcGb9CuL7JStct7TilddF1q1bZdAY9qdIJvgEBM3opd3VE3UT8G/SPeWYME
         nzfA==
X-Gm-Message-State: AOAM533Sg1ZHirEeOwV/xGBlgZUEO0XnaMNwGG5QNNS2Q2vuve/wlzVx
        1wtbBUbRpZGuG4yidFRhAVKpQiJHt8w=
X-Google-Smtp-Source: ABdhPJwEfj01rjGPiCcZGgCtKDTXNpHzwlhzG77E5oo6idk0CEbMpU3tLbEvDJZJLmrwhJ5KaRPP6w==
X-Received: by 2002:a05:6000:3ce:b0:1e4:b2ba:e3e3 with SMTP id b14-20020a05600003ce00b001e4b2bae3e3mr1145281wrg.204.1645080893750;
        Wed, 16 Feb 2022 22:54:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm29489657wrq.112.2022.02.16.22.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 22:54:53 -0800 (PST)
Message-Id: <e68b0a37ff37feb94850bec66a716145c9468ff8.1645080889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 06:54:47 +0000
Subject: [PATCH v4 3/5] sparse-checkout: pay attention to prefix for {set,
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
        Elijah Newren <newren@gmail.com>,
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
 builtin/sparse-checkout.c          | 25 ++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 41 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fb85a1459c3..a2192a69219 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -684,6 +684,27 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
+static void sanitize_paths(int argc, const char **argv, const char *prefix)
+{
+	if (!argc)
+		return;
+
+	if (prefix && *prefix) {
+		/*
+		 * The args are not pathspecs, so unfortunately we
+		 * cannot imitate how cmd_add() uses parse_pathspec().
+		 */
+		int i;
+		int prefix_len = strlen(prefix);
+
+		if (!core_sparse_checkout_cone)
+			die("please run from the toplevel directory in non-cone mode");
+
+		for (i = 0; i < argc; i++)
+			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
+	}
+}
+
 static char const * const builtin_sparse_checkout_add_usage[] = {
 	N_("git sparse-checkout add (--stdin | <patterns>)"),
 	NULL
@@ -711,6 +732,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	sanitize_paths(argc, argv, prefix);
+
 	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
 }
 
@@ -762,6 +785,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
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

