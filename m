Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99341F461
	for <e@80x24.org>; Sat, 18 May 2019 11:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfERLaw (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 07:30:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40165 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERLaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 07:30:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so4953465pfn.7
        for <git@vger.kernel.org>; Sat, 18 May 2019 04:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awM1FtbX4B1HTwouDdE8iy5Dl1vcMualqwlORIGybYY=;
        b=RWr2FDJTvxvE2LZOdwgzkQDgQNaXgfNKPKhl77W0q9LyEU8QV7xrF5BbNovDB9gWy8
         Drz/VAXEQs0lsH4xcYhCbhcMqzsL/nQi/mde6kYVTayuNdITw/tX8XGhO1Io5sCbKCTa
         9VJmFOYii5cMm+HAzSx9GPh9bxorlQ2+SzJ1bYSF+NWCLoSzy1tgGgEQ1A3xQzHy4x90
         ZoaEWUdKXqX+eGpcMFFKehBhIVxOwBKaURNrLxGq2bc6gfZGpSNlqMARJS/wtJUWHwTM
         BOHR1kN5H4zqWclKRQ8N29UDzE7lHk61YiHmDFDukEctKdXHvv1liEGD+mC1EKbMIrd2
         tcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awM1FtbX4B1HTwouDdE8iy5Dl1vcMualqwlORIGybYY=;
        b=ohdrUcYa7k0PybMGiMt/q0W1GacaRgoXneOd4SEE5O2rlyn7ak7PIoTsb6DgGusUCy
         7bj4u5obGBg2J3dG1C0TWcmI1Gk4v+lZYxOu663sjigYWVPzrmJzCX5bBwLf/dOldjQa
         jumziiQov8MkbGqo0j47FSwf+0RBiHEV7SvxTvjN0PjhKqkwAW3JzwxVyPjU+i7Tnx0W
         blZ6xVbwAxx6AmfitFkde1poVuvBu8rMRm41IXJ4t4X/T6tVpfqUi3XMcxJNxh6COFf3
         6y8APn1h7+NZuZU/I6/Y7klFF7FARv2w1fNZMADMIJTEyWTEnATdGwxXsxkWgEvtT2+A
         rEDA==
X-Gm-Message-State: APjAAAWVOfTXuhaKec5SzEab2g8kWANx/ZJ5HOiFtVAfdwpgebCUXCii
        YfLk/TDt+jsorL+L61RuI/Q=
X-Google-Smtp-Source: APXvYqwK1M2Ec28pEbAqZhfiRROQHauCkGewXf46/iTLzE1uvJZUlLA8UD7RjHkaf9lt1GHRBJW46A==
X-Received: by 2002:aa7:8d89:: with SMTP id i9mr67475148pfr.77.1558179051865;
        Sat, 18 May 2019 04:30:51 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id j5sm14286808pfa.15.2019.05.18.04.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 04:30:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 May 2019 18:30:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v4 0/2] nd/merge-quit updates
Date:   Sat, 18 May 2019 18:30:41 +0700
Message-Id: <20190518113043.18389-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190514091322.12427-1-pclouds@gmail.com>
References: <20190514091322.12427-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another round because apparently the test case is not perfect.

Nguyễn Thái Ngọc Duy (2):
  merge: remove drop_save() in favor of remove_merge_branch_state()
  merge: add --quit

 Documentation/git-merge.txt |  4 ++++
 branch.c                    | 11 ++++++++---
 branch.h                    |  6 ++++++
 builtin/merge.c             | 30 ++++++++++++++++++------------
 t/t7600-merge.sh            | 26 ++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 15 deletions(-)

Interdiff dựa trên v3:
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index d453710ef6..625a24a980 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -823,17 +823,29 @@ test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue'
 '
 
 test_expect_success 'merge --quit' '
-	git reset --hard c2 &&
-	test_must_fail git -c rerere.enabled=true merge master &&
-	test_path_is_file .git/MERGE_HEAD &&
-	test_path_is_file .git/MERGE_MODE &&
-	test_path_is_file .git/MERGE_MSG &&
-	test_path_is_file .git/MERGE_RR &&
-	git merge --quit &&
-	test_path_is_missing .git/MERGE_HEAD &&
-	test_path_is_missing .git/MERGE_MODE &&
-	test_path_is_missing .git/MERGE_MSG &&
-	test_path_is_missing .git/MERGE_RR
+	git init merge-quit &&
+	(
+		cd merge-quit &&
+		test_commit base &&
+		echo one >>base.t &&
+		git commit -am one &&
+		git branch one &&
+		git checkout base &&
+		echo two >>base.t &&
+		git commit -am two &&
+		test_must_fail git -c rerere.enabled=true merge one &&
+		test_path_is_file .git/MERGE_HEAD &&
+		test_path_is_file .git/MERGE_MODE &&
+		test_path_is_file .git/MERGE_MSG &&
+		git rerere status >rerere.before &&
+		git merge --quit &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_path_is_missing .git/MERGE_MODE &&
+		test_path_is_missing .git/MERGE_MSG &&
+		git rerere status >rerere.after &&
+		test_must_be_empty rerere.after &&
+		! test_cmp rerere.after rerere.before
+	)
 '
 
 test_done
-- 
2.22.0.rc0.322.g2b0371e29a

