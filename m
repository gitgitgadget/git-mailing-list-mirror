Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87D61F404
	for <e@80x24.org>; Sun,  4 Feb 2018 02:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeBDCD2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 21:03:28 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41627 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeBDCD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 21:03:26 -0500
Received: by mail-pl0-f68.google.com with SMTP id k8so7035270pli.8
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 18:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rhwBjjxaLRXnvPg7r5hbJKh2ANNl7jRPgKfNsq/kXGg=;
        b=E4AgaZfMNRc9RIgpjfTezBXFpvjOhCR5AGhD21ezWlq5bDHNpHRV3CE02Q20QvsOmA
         LY2Y0/q0yb5o+s7+h4tqhy/2cE7XTa/85VE+2d+oRgrJetvR87ISI8j+YI28lT8Ixkv7
         TgBbGiZLEkVBRY3i3TIoFeizaOS8VfdtMlflmnjjpEb8uiTUDzG8br4NlFF5WindRmvD
         pxhO9mX6X+VvEcxx78xVps4lrBQTlIdf9zvZAqruGfUaDcDmSJ+9ohYXohj5QrMDR6OL
         UFmwFauB7K35Eeo4PWGh6Jvz9xgnf3rlq4Lb1DEcoRwjLDtNqAJ/3N+YUA2EE2T/XW5o
         NTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rhwBjjxaLRXnvPg7r5hbJKh2ANNl7jRPgKfNsq/kXGg=;
        b=pgULH/zJpqrftp4MByJBSZ3xKUyyOyNtiFjsviGGofaXctCOM0FXAA+qhdSzJgl6Zl
         RTsBvttiSFslS+3zOBcBHv2vadXzibaaYkUKVjrcrpgImb0oHpsYqqb+O5Uqr7F04i18
         9QxsMBeKsew7ZOheJ70fS6eCxHe0HEq2kFQKRYKocfoaFLY3+CnM8v6U1Y5OUZ/fLnid
         MDXLvv3vjTfRxjXPCB0ErvAWIF0494mGx0NkEIG2qNZvRv9aV7LiK/RidE6GHxtlLvEP
         sL6k2w/wORNoNMc0414in5rGoXLcPmf06yBfSEiV2o0xESadDDWiEQR/B1v/YsVp1AiY
         SWDw==
X-Gm-Message-State: APf1xPDlxTYzB6Spmsy6DiG3pKBlh/528rl954kLPSOTtLvVHCcZElFM
        4PQamdNxyafwL3FxG6LBOQEUDA==
X-Google-Smtp-Source: AH8x225/x5M5gWzQpsBKUffg4/HRnIkvpK3UaELLx/HTf38mpxO7V1blJQQT1mYz/oFNMXCr6Oqc6A==
X-Received: by 2002:a17:902:7d96:: with SMTP id a22-v6mr3141074plm.296.1517709805842;
        Sat, 03 Feb 2018 18:03:25 -0800 (PST)
Received: from localhost ([183.18.27.48])
        by smtp.gmail.com with ESMTPSA id y5sm10664740pfd.163.2018.02.03.18.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Feb 2018 18:03:25 -0800 (PST)
From:   Chen Jingpiao <chenjingpiao@gmail.com>
To:     git@vger.kernel.org
Cc:     Chen Jingpiao <chenjingpiao@gmail.com>
Subject: [GSoC][PATCH] commit: add a commit.signOff config variable
Date:   Sun,  4 Feb 2018 10:03:18 +0800
Message-Id: <20180204020318.4363-1-chenjingpiao@gmail.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the commit.signOff configuration variable to use the -s or --signoff
option of git commit by default.

Signed-off-by: Chen Jingpiao <chenjingpiao@gmail.com>
---

Though we can configure signoff using format.signOff variable. Someone like to
add Signed-off-by line by the committer.

 Documentation/config.txt     |  4 +++
 Documentation/git-commit.txt |  2 ++
 builtin/commit.c             |  4 +++
 t/t7501-commit.sh            | 69 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92..5dec3f0cb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1303,6 +1303,10 @@ commit.gpgSign::
 	convenient to use an agent to avoid typing your GPG passphrase
 	several times.
 
+commit.signOff::
+	A boolean value which lets you enable the `-s/--signoff` option of
+	`git commit` by default. See linkgit:git-commit[1].
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a4342..7a28ea765 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -166,6 +166,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	the rights to submit this work under the same license and
 	agrees to a Developer Certificate of Origin
 	(see http://developercertificate.org/ for more information).
+	See the `commit.signOff` configuration variable in
+	linkgit:git-config[1].
 
 -n::
 --no-verify::
diff --git a/builtin/commit.c b/builtin/commit.c
index 4610e3d8e..324213254 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1548,6 +1548,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.signoff")) {
+		signoff = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
 		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index fa61b1a4e..46733ed2a 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -505,6 +505,75 @@ Myfooter: x" &&
 	test_cmp expected actual
 '
 
+test_expect_success "commit.signoff=true and --signoff omitted" '
+	echo 7 >positive &&
+	git add positive &&
+	git -c commit.signoff=true commit -m "thank you" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	(
+		echo thank you
+		echo
+		git var GIT_COMMITTER_IDENT |
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success "commit.signoff=true and --signoff" '
+	echo 8 >positive &&
+	git add positive &&
+	git -c commit.signoff=true commit --signoff -m "thank you" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	(
+		echo thank you
+		echo
+		git var GIT_COMMITTER_IDENT |
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success "commit.signoff=true and --no-signoff" '
+	echo 9 >positive &&
+	git add positive &&
+	git -c commit.signoff=true commit --no-signoff -m "thank you" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	echo thank you >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success "commit.signoff=false and --signoff omitted" '
+	echo 10 >positive &&
+	git add positive &&
+	git -c commit.signoff=false commit -m "thank you" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	echo thank you >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success "commit.signoff=false and --signoff" '
+	echo 11 >positive &&
+	git add positive &&
+	git -c commit.signoff=false commit --signoff -m "thank you" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	(
+		echo thank you
+		echo
+		git var GIT_COMMITTER_IDENT |
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success "commit.signoff=false and --no-signoff" '
+	echo 12 >positive &&
+	git add positive &&
+	git -c commit.signoff=false commit --no-signoff -m "thank you" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	echo thank you >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
2.16.1.70.g5ccd54536

