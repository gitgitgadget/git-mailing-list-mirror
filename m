Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B7C1F462
	for <e@80x24.org>; Sat,  8 Jun 2019 19:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfFHTXH (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 15:23:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36875 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHTXH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 15:23:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id 20so2890080pgr.4
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOraJ7Hp3fUlS6YsCJBYK79eLWx0CuJ/fpLbyfpXF/g=;
        b=TUCjmLrkEahwgnd2SUN1iCB/MYWwUoKMsqbuDC8FioAG1d0Ot7HcHCUhIWF2Hdi05k
         7m6JyfVeBk5PUpaIrLTJiU77BbA7NBFb1nw5d2AEEJxlJ5DcDz33uiH5kHkm70fODbDy
         u79DibfXi5Ra9syKDcHQhEt9AP45UGSh3vmgjBzVNxWckQk/cXHxAmV4xqcRgbpkmzyS
         GMyQAqtzhfdnSWC+Ay9Ole960di+MhHBNhjyToRsQWdE9iXqCDBw4TOX/tyNwhKZUyho
         WkV//tO7IIN3sASdJU6JotW73bNDAFgtj1EPsGgNcfy0frPTFaR6MvYE8c8rimnxu27a
         oVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOraJ7Hp3fUlS6YsCJBYK79eLWx0CuJ/fpLbyfpXF/g=;
        b=eGcdX229WTi9erjjZXasf8juGXSv5u1UFV5ssmGtCmbSKV6kjQ8Jax8X0jqmaUYOvr
         RJ513stEDrS6oNN9ZV4j++qqFr4PiYVoK8NPhwBCHtCc6ovmAowjij9CtysEFnSoycu/
         vxRLKs3LuLbnZvKELTQ/8lzU1G/B0ElCBRko4SduAQHqCKQlSuFFBpo8DXQ0Yx/l7OIw
         boGORvZlxOpcw5CAYObmeyuNbIrUwLP9tg1+xoAOE7w9sNOdetAYvKgj/+Iku/ONiwCH
         AwtoGtnRYGT2pUdQy3P1AUMcfrgbY99u/9XXFOHnLa/rturYy5cyX7vSIJ5WtLPdvT9m
         bJMA==
X-Gm-Message-State: APjAAAUuxjfTS1QXGIuj9kduWOmtSmZ1TGzNQSB6S5K1cF+nY6fGjUbU
        J4ZwVde7jLJpMSlK3BOh5dmxuFqSkgI=
X-Google-Smtp-Source: APXvYqw5VEMfyucwf2qYzPG1T/1c89n8H48evLdyWBpQBHk89phuDfl600yejO/lE2kNv+nJVocjjw==
X-Received: by 2002:a63:6c4a:: with SMTP id h71mr6783306pgc.331.1560021786395;
        Sat, 08 Jun 2019 12:23:06 -0700 (PDT)
Received: from ar135.iitr.local ([223.188.32.84])
        by smtp.gmail.com with ESMTPSA id o126sm6186290pfb.134.2019.06.08.12.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:23:05 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, t.gummerer@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 3/3] cherry-pick/revert: update hints
Date:   Sun,  9 Jun 2019 00:49:58 +0530
Message-Id: <20190608191958.4593-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 builtin/commit.c | 13 ++++++++-----
 sequencer.c      |  4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1c9e8e2228..1f47c51bdc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -60,15 +60,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "\n");
 
 static const char empty_cherry_pick_advice_single[] =
-N_("Otherwise, please use 'git reset'\n");
+N_("Otherwise, please use 'git cherry-pick --skip'\n");
 
 static const char empty_cherry_pick_advice_multi[] =
-N_("If you wish to skip this commit, use:\n"
+N_("and then use:\n"
 "\n"
-"    git reset\n"
+"    git cherry-pick --continue\n"
 "\n"
-"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
-"the remaining commits.\n");
+"to resume cherry-picking the remaining commits.\n"
+"If you wish to skip this commit, use:\n"
+"\n"
+"    git cherry-pick --skip\n"
+"\n");
 
 static const char *color_status_slots[] = {
 	[WT_STATUS_HEADER]	  = "header",
diff --git a/sequencer.c b/sequencer.c
index f586e677d3..e889427eef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2654,8 +2654,8 @@ static int create_seq_dir(void)
 {
 	if (file_exists(git_path_seq_dir())) {
 		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
-		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
+		advise(_("try \"git cherry-pick (--continue | --skip | --quit | --abort)\""));
+		advise(_("or  \"git revert (--continue | --skip | --quit | --abort)\""));
 		return -1;
 	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
-- 
2.21.0

