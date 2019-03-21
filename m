Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110F920248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfCUNRx (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:17:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46104 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNRw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:17:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so4025246pfj.13
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sxj0eS8lOQQ4KO8G0oi29Abh87gOScHkffrtbe8gw3Y=;
        b=GxihvYaI1+7jcwGTWAP+q7iXRhy38RyOPsX3t7vVgr90nhYX/FWfkMiSDY+wtndZOQ
         Owi/5NI9YkG01lyKn3bkTVKYlso2ot2xhTuaBYNe86YJzuuuTTnpxrTfuh/V9TOTA1XC
         bSR9UUMyTm22ECHu6pjtPugYS1RL58Kar9SRIRwb+zrroC908PEh4yXotGS27yArcFlN
         0YebDy18tQ3Vr8hEu5UFnqawdZp9YYRURotICfh/eoxBrBUbmIaV1KF9WuDg0d6AygdJ
         TDMhoJxLPs6haaqOPFU1ZQmfYZt/qf784OxOqvZIi0TcOR4WSbakPrxR8ZrHOhhyxp0F
         EsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sxj0eS8lOQQ4KO8G0oi29Abh87gOScHkffrtbe8gw3Y=;
        b=Wi+RaJgN6a5lo1OaX7JQyN8Cz5Wro5EdJfMVN+D+I4sqO3SA38b74I+9RRw9yCScdf
         buW0iUKyPTHLlXBlN3FFlyXC73etX8nZZH4HYuq+9ZPoSmo1JRZJVhmXzLa5+VGwGKfx
         TE+zcFOo6acvgm2z3VCN7Cvz+VcreOAPAKS54NfQ69QrMDvtGAp7CqC69JCQOWZNi82a
         TgmU0PDuGAzninOu9yHCQ8+CRbrtnpSNH4/hIODMs9K82hcqxS8iIUqAQahRXrlEA0R2
         9/abq1P7/9Up2wMDfZH0/+/ABGxccglBfyUmnn4LDlo8fMaS970jp4hjCn9WP/ZSfbOI
         kBAA==
X-Gm-Message-State: APjAAAXy8o4D1wr5tUSXlT92apkpmV98PRmvPnl6rQNfF1hBLjD2Awk6
        gsCSzFMDoU0dbRmG30Zu3NM=
X-Google-Smtp-Source: APXvYqxn9sUEO/c4tofZ3pKSUToKFP1TLbCI4NGQzjWO5lrHCMySk3rWbseZYe772Xe7+l3KtVTiQA==
X-Received: by 2002:a17:902:586:: with SMTP id f6mr3463476plf.68.1553174272219;
        Thu, 21 Mar 2019 06:17:52 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id e63sm6376090pfe.120.2019.03.21.06.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:17:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:17:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 06/26] checkout: advice how to get out of detached HEAD mode
Date:   Thu, 21 Mar 2019 20:16:35 +0700
Message-Id: <20190321131655.15249-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Detached HEAD mode is considered dangerous and confusing for newcomers
and we print a big block of warning how to move forward. But we should
also suggest the user the way to get out of it if they get into detached
HEAD by mistake.

While at there, I also suggest how to turn the advice off. This is
another thing I find annoying with advices and should be dealt with in a
more generic way. But that may require some refactoring in advice.c
first.
---
 advice.c                   | 17 +++++++++++++----
 t/t2020-checkout-detach.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 567209aa79..b224825637 100644
--- a/advice.c
+++ b/advice.c
@@ -191,13 +191,22 @@ void NORETURN die_conclude_merge(void)
 void detach_advice(const char *new_name)
 {
 	const char *fmt =
-	_("Note: checking out '%s'.\n\n"
+	_("Note: checking out '%s'.\n"
+	"\n"
 	"You are in 'detached HEAD' state. You can look around, make experimental\n"
 	"changes and commit them, and you can discard any commits you make in this\n"
-	"state without impacting any branches by performing another checkout.\n\n"
+	"state without impacting any branches by performing another checkout.\n"
+	"\n"
 	"If you want to create a new branch to retain commits you create, you may\n"
-	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
-	"  git checkout -b <new-branch-name>\n\n");
+	"do so (now or later) by using -b with the checkout command again. Example:\n"
+	"\n"
+	"  git checkout -b <new-branch-name>\n"
+	"\n"
+	"Or undo this checkout with:\n"
+	"\n"
+	"  git checkout -\n"
+	"\n"
+	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
 
 	fprintf(stderr, fmt, new_name);
 }
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 1fa670625c..743c7248a2 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -206,6 +206,12 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 
 	  git checkout -b <new-branch-name>
 
+	Or undo this checkout with:
+
+	  git checkout -
+
+	Turn off this advice by setting config variable advice.detachedHead to false
+
 	HEAD is now at \$commit three
 	EOF
 
@@ -282,6 +288,12 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 
 	  git checkout -b <new-branch-name>
 
+	Or undo this checkout with:
+
+	  git checkout -
+
+	Turn off this advice by setting config variable advice.detachedHead to false
+
 	HEAD is now at \$commit... three
 	EOF
 
-- 
2.21.0.548.gd3c7d92dc2

