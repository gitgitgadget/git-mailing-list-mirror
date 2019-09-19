Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132821F464
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfISOnR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40917 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732732AbfISOnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so4254762wmj.5
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EbCIxBjP1Gjy6pX4s2tXi7UGlubyPnXXNEjGv/7cmbA=;
        b=J4XzBC1kUXpQsuuVV/ENAbVeGzmvBIkI4Kcsi0HiO7Ye1CyzuceQA+u2stndrDnPcW
         apOZFz5QwRvD5h+/w973Vyh2NKLG+EmpSBQqBE8I+x2c5F34tBVWOJcDqPtpA9NAAK2+
         daJU10qiH1i2j4JK3AJCSMRh3fhgi/zaB0n90oJiifnhuWSu4HiKG8LjFLx9UIcez51q
         3BYtgzaF7geOAh2i/b0qOg+esZFfrCmW/GQMYhametLFfNDsPO1Dsyh10FucgyyxoAq3
         K/winSF1qU9hVAIhUDGlYH/TcT+FvHSqAI/0DCsoFQZxraSh3i/zT7wGWlNJzmhIAQX6
         SQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EbCIxBjP1Gjy6pX4s2tXi7UGlubyPnXXNEjGv/7cmbA=;
        b=lrp+SptScKTPItMx/UvYejzMZbTm0EOzO6bCUZNxzGK91G4wife6utox+cE+6SjnYX
         Ds+LAEzD8b82Zx6hT3vP3H6fAd8B+CUus5htB8UHWXsCYR6S44jCLlzqEBXNKHcvybUE
         uuYGGDhILxgEQGGhD3Ui2PR86pxYpM70qY3TbYIjWZItiLiKPyX7Nkr/DbKpnsDZKko6
         tHbe+dHKTIYK2XmbxdmajB/ahB55P9agBwasN6imGTaFrLytKFhGeV4jrZZunie+R/mm
         Ipt0kYZJsDuOqBnmv1s4wI4aDAZJt5ygAr66I5uHYsarvqYoHGMyvqZ/LeKDhl5SLfdJ
         TS0Q==
X-Gm-Message-State: APjAAAXvntsNTUCbAq/2B7/59/4H+TjNmTOZ6n48Vfve1OSmFsYHZteo
        uIyidWo4K1F/8aA90iY4IHbCpV/R
X-Google-Smtp-Source: APXvYqyYOzw9E4e1mvAwFSNswLe62905SEl/3wtOPa7h0YBbHxuPW8plw7qnf7cF180MX5/Y722i5w==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr3397747wmm.66.1568904193613;
        Thu, 19 Sep 2019 07:43:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm5161468wmc.3.2019.09.19.07.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:13 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:13 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:01 GMT
Message-Id: <9a78f9ea0fe8d1988654f52a86a01031607621fe.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/11] sparse-checkout: 'set' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git sparse-checkout set' subcommand takes a list of patterns
as arguments and writes them to the sparse-checkout file. Then, it
updates the working directory using 'git read-tree -mu HEAD'.

The 'set' subcommand will replace the entire contents of the
sparse-checkout file. The write_patterns_and_update() method is
extracted from cmd_sparse_checkout() to make it easier to implement
'add' and/or 'remove' subcommands in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  5 +++++
 builtin/sparse-checkout.c             | 31 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 19 ++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 9707ef93b1..87813e5797 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -34,6 +34,11 @@ COMMANDS
 	by Git. Add patterns to the sparse-checkout file to
 	repopulate the working directory.
 
+'set'::
+	Write a set of patterns to the sparse-checkout file, as given as
+	a list of arguments following the 'set' subcommand. Update the
+	working directory to match the new patterns.
+
 SPARSE CHECKOUT
 ----------------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 656e6ebdd5..13333fba6a 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [init|list]"),
+	N_("git sparse-checkout [init|list|set] <options>"),
 	NULL
 };
 
@@ -130,6 +130,33 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return update_working_directory();
 }
 
+static int write_patterns_and_update(struct pattern_list *pl)
+{
+	char *sparse_filename;
+	FILE *fp;
+
+	sparse_filename = get_sparse_checkout_filename();
+	fp = fopen(sparse_filename, "w");
+	write_patterns_to_file(fp, pl);
+	fclose(fp);
+	free(sparse_filename);
+
+	clear_pattern_list(pl);
+	return update_working_directory();
+}
+
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pattern_list pl;
+	memset(&pl, 0, sizeof(pl));
+
+	for (i = 1; i < argc; i++)
+		add_pattern(argv[i], NULL, 0, &pl, 0);
+
+	return write_patterns_and_update(&pl);
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -152,6 +179,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_list(argc, argv);
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
+		if (!strcmp(argv[0], "set"))
+			return sparse_checkout_set(argc, argv, prefix);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 26b4ce9acd..f21ea61494 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -101,5 +101,24 @@ test_expect_success 'clone --sparse' '
 	test_cmp expect dir
 '
 
+test_expect_success 'set sparse-checkout using builtin' '
+	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		*folder*
+	EOF
+	git -C repo sparse-checkout list >actual &&
+	test_cmp expect actual &&
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
 
-- 
gitgitgadget

