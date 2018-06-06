Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93EC31F403
	for <e@80x24.org>; Wed,  6 Jun 2018 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbeFFJmJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 05:42:09 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:40305 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeFFJmG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 05:42:06 -0400
Received: by mail-lf0-f54.google.com with SMTP id q11-v6so8079086lfc.7
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VmgIwlgqH5xYfJbt88/rz2UCnF+DVgMSBvAp/JdPt4=;
        b=Wd6pkU+jpQ5eTvv2wZQE7UeAlOEiNlFuIdNNfqKpLmGHvu/qmYjgMegrBbJKI5bUy/
         4S+UNQfo3vnwJF8d3c5vAZiLNDWXMVzDf++ogUjK8brDI7RjMlNLry1wyjqxFJFGEi4O
         rQfA7/2OwYJE4ojvIAsEkrb++6WjRV3MG37xF4McuFIazLzeeWcAAc7iuaNmV+xrEzD8
         79W8yBu6U4SD7mqws8Ca5tcpd16K6vH/1zdgrFW01Tqq0Ob/aP8uo+9pFxilEgF0Jx7Z
         5eJp1ZhdMVwM0ilzqfZ+gZP/eDTpweGGRUsm+gbvrKeGxcQXsBoKFRt54VqXnnDp/6tn
         AOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VmgIwlgqH5xYfJbt88/rz2UCnF+DVgMSBvAp/JdPt4=;
        b=Vah4UX5cQqxtRQS8tLUXRJ7r+GkqRfLGSZkJgBt1V4TIb3RX7FQpN2sHetdDaxSJHL
         JVuiH5FJ5sTBLKfJxr+DfnA+OJDZ7lkXIq1tBtcbUxUwEYGwKW4DgZ4su1l7AjPtfkub
         sXmouhi1+wvFcgAhS7ox1iPYyjd6Ecn1wIHkX1ok5deLRIGuaVdDD03PixSx5XnVtRwA
         8ZpJPTLROQlF2M1/dvA+pUrupaILafM7HNdgOXMnTox4e6y6UfRR+jImvF2p4coUIIm6
         xjGAK8Mz+yDv3NakgtV/qLy5CoPMNC8VFNiBTXNGTfo43J0BTI2FWkIDP6HJ6vCMQZps
         f/MQ==
X-Gm-Message-State: APt69E1psw/6h7Nf6yzuCvBVpzcD/AAvvxxUjSEFSveZwyzrGmd9lqp2
        hSieHkc0SVr643uoiC23hRf+gA==
X-Google-Smtp-Source: ADUXVKL4lErJkgSG+5omsRCQjdaEhZ8Sanvz5QDmKNPjWHGT+g86mXD0BIUPpbGNDQHe0p0fUgoc+g==
X-Received: by 2002:a2e:8951:: with SMTP id b17-v6mr1652658ljk.111.1528278124748;
        Wed, 06 Jun 2018 02:42:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2987062ljj.71.2018.06.06.02.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 02:42:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 2/3] completion: suppress some -no- options
Date:   Wed,  6 Jun 2018 11:41:38 +0200
Message-Id: <20180606094139.30906-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606094139.30906-1-pclouds@gmail.com>
References: <20180527083828.6919-1-pclouds@gmail.com>
 <20180606094139.30906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most --no- options do have some use, even if rarely to negate some
option that's specified in an alias.

These options --no-ours and --no-theirs however have no clear
semantics. If I specify "--ours --no-theirs", the second will reset
writeout stage and is equivalent of "--no-ours --no-theirs" which is
not that easy to see. Drop them. You can either switch from --ours to
--theirs and back but you can never negate them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c    | 10 ++++++----
 t/t9902-completion.sh |  2 --
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b3b768eff..c7670dbbfe 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1119,10 +1119,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-		OPT_SET_INT('2', "ours", &opts.writeout_stage, N_("checkout our version for unmerged files"),
-			    2),
-		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their version for unmerged files"),
-			    3),
+		OPT_SET_INT_F('2', "ours", &opts.writeout_stage,
+			      N_("checkout our version for unmerged files"),
+			      2, PARSE_OPT_NONEG),
+		OPT_SET_INT_F('3', "theirs", &opts.writeout_stage,
+			      N_("checkout their version for unmerged files"),
+			      3, PARSE_OPT_NONEG),
 		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 07c3e3b760..7e5e3ad5b1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1245,9 +1245,7 @@ test_expect_success 'double dash "git checkout"' '
 	--orphan=Z
 	--no-orphan Z
 	--ours Z
-	--no-ours Z
 	--theirs Z
-	--no-theirs Z
 	--merge Z
 	--no-merge Z
 	--conflict=Z
-- 
2.18.0.rc0.333.g22e6ee6cdf

