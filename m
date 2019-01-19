Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F13A1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 03:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfASDg1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 22:36:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38936 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfASDg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 22:36:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id c21so9218197qkl.6
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 19:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe/83RyLunvMtqMLSsGD4MI8OBKD1rrzCoZLO30dkWw=;
        b=D91M/861NXGkZx+eycJmc9HrBiz7K7aryBJYxzuqvuH5I+iG6KmZrlQ427JtZrFJ7v
         GcSSIkxPAlpYIslCwfknD04kfa0ryKLkGTWP0hC9o0ZL9aXyWOkc0WOMUaRAqA7F1v5Z
         oAQohP005MS8Fh/lvp6CjUZqLMIkJ3ivTXmSnU0nDO27I/dLAAkykyCXRRSysYFzsB08
         K5CelqeluLNhap5ERRYGpeNjkNzq/Flqy0pUzqp0hBHqvqoQUvnhLLnyhOQIRfM3O894
         sd5B/VBBJbIeJLeE7xdFN47dywyzE8XYvo6KJ2Cjv8JbHn43ziuiHnG4/qJkArWgIt4v
         onCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe/83RyLunvMtqMLSsGD4MI8OBKD1rrzCoZLO30dkWw=;
        b=RNt3Fn8PoYQEi9SbINJQw7FL2J+H35B0HowOnr78PLDuMJVEXIjTbvjTwGSNxLgw2k
         8UjaYKaFkPmBOwvPyt1zUdwC7HOoZx7Dg71/fw3roNhtSyvqgbEIDtGI9YtETgqD6Usb
         si6lYh/Y52QqDxBUFKP7g1thYsqhBC0PxEujztQl5jJk+HA4FUt/I94cPDhs3Ea6J3lY
         qMPMPwbGCjG0cmZ8Z1+3yC0BzTjn/xHZFlYiQ/jn8UYdBMbfSwRjJjzPA39pvnlCKz04
         huf3tiZOIgBYiDTFnkTUmR+i7x/a/MSuEMOYO2TfCp6GnNAjS/UJh+uM2l2ZxEPNOXho
         geqA==
X-Gm-Message-State: AJcUukfP4rX+VO0GPD01qcb4WDs+CPInGgM/CryNSBr3l69DI1qYqeAI
        Io+4ADFGC1CwFHR+fD5Pr3GCm2yiZAe6AA==
X-Google-Smtp-Source: ALg8bN4SY3OG5n0XPv5U4cXlciUd6D37YK0GHC1GESodo0zSVfraceRlNw0Ym1gzmxND74X7px8U5g==
X-Received: by 2002:a37:dd43:: with SMTP id n64mr17926429qki.7.1547868985063;
        Fri, 18 Jan 2019 19:36:25 -0800 (PST)
Received: from localhost.localdomain ([192.230.35.134])
        by smtp.gmail.com with ESMTPSA id o34sm47855002qte.4.2019.01.18.19.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jan 2019 19:36:24 -0800 (PST)
From:   Brandon Richardson <brandon1024.br@gmail.com>
To:     git@vger.kernel.org, martin.agren@gmail.com, gitster@pobox.com
Cc:     Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH v3] commit-tree: add missing --gpg-sign flag
Date:   Fri, 18 Jan 2019 23:35:30 -0400
Message-Id: <20190119033530.4241-1-brandon1024.br@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add --gpg-sign option in commit-tree, which was documented, but not
implemented, in 55ca3f99ae. Add tests for the --gpg-sign option.

Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---

Hi all,

Third and (hopefully) final version. Thanks again Martin for the helpful
comments.

---

 builtin/commit-tree.c    |  8 +++++++-
 t/t7510-signed-commit.sh | 13 +++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 9ec36a82b..298e499ac 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -66,7 +66,13 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (skip_prefix(arg, "-S", &sign_commit))
+		if(!strcmp(arg, "--gpg-sign")) {
+		    sign_commit = "";
+		    continue;
+		}
+
+		if (skip_prefix(arg, "-S", &sign_commit) ||
+			skip_prefix(arg, "--gpg-sign=", &sign_commit))
 			continue;
 
 		if (!strcmp(arg, "--no-gpg-sign")) {
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 86d3f93fa..095d4b254 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -51,13 +51,22 @@ test_expect_success GPG 'create signed commits' '
 	# commit.gpgsign is still on but this must not be signed
 	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
 	# explicit -S of course must sign.
-	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
+	git tag tenth-signed $(echo 10 | git commit-tree -S HEAD^{tree}) &&
+
+	# --gpg-sign[=<key-id>] must sign.
+	echo 11 >file && test_tick && git commit -S -a -m "eleventh signed" &&
+	git tag eleventh-signed &&
+	git commit-tree --gpg-sign -m "twelfth signed" HEAD^{tree} &&
+	git tag twelfth-signed &&
+    git commit-tree --gpg-sign=B7227189 -m "thirteenth signed" HEAD^{tree} &&
+    git tag thirteenth-signed
 '
 
 test_expect_success GPG 'verify and show signatures' '
 	(
 		for commit in initial second merge fourth-signed \
-			fifth-signed sixth-signed seventh-signed tenth-signed
+			fifth-signed sixth-signed seventh-signed tenth-signed \
+			eleventh-signed twelfth-signed thirteenth-signed
 		do
 			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
-- 
2.20.1

