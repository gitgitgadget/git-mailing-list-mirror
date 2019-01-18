Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D72821F453
	for <e@80x24.org>; Fri, 18 Jan 2019 01:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfARBJ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 20:09:28 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42257 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfARBJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 20:09:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id 68so7167977qke.9
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 17:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xsb1Tf8G0hHRRszVIBABj4CK3I7tC+7x+nvY2tRRPKk=;
        b=sE3xjtlzSsdpCJzssjXtFtLncvAwb7C4CLpAwcJcBLCrL3KIyzwFgGQ40b6sWpUr5P
         rp1qJEPuuRtN0eU6QDMCRqoGSU+6n2HNMuE/7x2YbVTcK+RKrr8nfE5czv64Dr6E9rtb
         //IQSlqSLOy6h92V2liPdmlF76LGYCspngGdXUMIyb0iXs4aKMdsVshRS26NskyMjG3W
         Uqa5pSkGQvXWGNVuGQDg5Jr41k/JpC7nXAq5mv6qNnavR4nlN2MbdcROKivcphvdBEKF
         BzBKYELwhOeZBxWXerk1DUmkhZiyJolqD+isOGOMCc1T1ShvIIAErAOry9gLLt+RG8hH
         aubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xsb1Tf8G0hHRRszVIBABj4CK3I7tC+7x+nvY2tRRPKk=;
        b=Z5kErwtanY3cdlGZ1TG36N2lnISD2ZA2eOnQVsed8+2HbuiChiDcZ0gCFQSJ7A+wSH
         TIMcFjxYeTSK+1q6tDa9bj34UQhmOdtZ9dbX6hQpGHPmRS1QQJI/t8svW17/1fykamB/
         Fvw+IuixJmzhErXnOQSJVE7pDk1KfmAjc2+cR6x6FNN/0ffsa43IJZy5YxBBY2NW6ZwA
         NA7w/polSd3sWkn7Yu/dhXWmNdZjSM0OSeqZVDMzQ36rJZNliRlJaSN/CR0/0Le96/Fh
         umf0FMFP5IiSpjB3Fd2g7U1HdTgFhRBR8+tLuXovnhVP3uXCx0qyZu3pFrRkEnrHpSi3
         yhqQ==
X-Gm-Message-State: AJcUuket6TMrTNG1nltYk5ltr3QJFLv0b3ao6cMqkgD4rOPfd/Fb6dC4
        C5KKZbHSE0ZQlLOue/DSQ/n8qY/c
X-Google-Smtp-Source: ALg8bN47ODHrJ0FmVQxmm5VYh7G02YyW0kgP0rnYQbOHhTtZy2QewDurgAd/1sKGNBVIXlS0uERv0Q==
X-Received: by 2002:a37:9604:: with SMTP id y4mr13517577qkd.279.1547773767064;
        Thu, 17 Jan 2019 17:09:27 -0800 (PST)
Received: from localhost.localdomain (fctnnbsc38w-47-55-247-90.dhcp-dynamic.fibreop.nb.bellaliant.net. [47.55.247.90])
        by smtp.gmail.com with ESMTPSA id c49sm71610472qtc.94.2019.01.17.17.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 17:09:26 -0800 (PST)
From:   Brandon Richardson <brandon1024.br@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH] commit-tree: add missing --gpg-sign flag
Date:   Thu, 17 Jan 2019 21:09:18 -0400
Message-Id: <20190118010918.43705-1-brandon1024.br@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add --gpg-sign option in commit-tree, which was documented, but not
implemented, in 55ca3f99ae.

Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---

Thanks Martin for the tips and suggestions!

 builtin/commit-tree.c    | 8 +++++++-
 t/t7510-signed-commit.sh | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 9ec36a82b..a51b2c8d7 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -66,7 +66,13 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (skip_prefix(arg, "-S", &sign_commit))
+		if(!strcmp(arg, "--gpg-sign")) {
+		    skip_prefix(arg, "--gpg-sign", &sign_commit);
+		    continue;
+		}
+
+		if (skip_prefix(arg, "-S", &sign_commit) ||
+			skip_prefix(arg, "--gpg-sign=", &sign_commit))
 			continue;
 
 		if (!strcmp(arg, "--no-gpg-sign")) {
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 86d3f93fa..efc136eaf 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -51,7 +51,9 @@ test_expect_success GPG 'create signed commits' '
 	# commit.gpgsign is still on but this must not be signed
 	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
 	# explicit -S of course must sign.
-	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
+	git tag tenth-signed $(echo 10 | git commit-tree -S HEAD^{tree})
+	# --gpg-sign must sign.
+	git tag eleventh-signed $(echo 11 | git commit-tree --gpg-sign HEAD^{tree})
 '
 
 test_expect_success GPG 'verify and show signatures' '
-- 
2.20.1

