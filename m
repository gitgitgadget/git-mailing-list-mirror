Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0751120248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfC2KkX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33139 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfC2KkW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id bg8so864757plb.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4DWjjEYUTmxfrXi8kKJqDZtbl4jFGYkHjK7Ettpmig=;
        b=TTmbhQ9oic+lM+Z5EMvgZUZJ4GBG/+4WzfyAyWUt51yRMbFpK9ElemKsYjmjCfE4m2
         3tnyYaELCt8DXVQaAuD++7PDAJCjfzMFOUmb+fl3mT5v/QIkdlAB1yHCv7FLY6P4uYlO
         MWkZDBrUgwEE22DQmmuGWHuijKqujzcTIFF873VH2HZH6BRwTMl4w478dyemmM7S6hay
         /40ioxRMz5DxbAn4Wr+ZaNkSTqaQ0y9RFrVkiseY3Ove2iia+kydo4qkQHnNzXi/mqGP
         XVvBIvjLEU9ngjnVVf1Qbdzqy9N+gxeez41paHioHkG/vikYCpXHUrgv9lK1+F7yHtmP
         re2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4DWjjEYUTmxfrXi8kKJqDZtbl4jFGYkHjK7Ettpmig=;
        b=qfEOTWjL6JFojvX+Bxfq5CMK/SCADMtm/084Fmp0BmiWDRE5wpoDmPqYFYelIfsiJH
         YXj2ht0S/+XWfuExDWiYHC50Vp4L8euinVZ2racFCiy1J2JApL5OHUfmehdRJBGvUk8t
         ypopf7ud9EkCw/A0vEck/K2mSaadthhE2fphkV2fUSVGMK5wK6aO6unQQ+hySll9oy2b
         MqIpTTpXvQ/pVBtFKAWHuyBXF5RV5bjOI5CNzczlqUC447rrbzeoWcaFQ/qN8ly96tgO
         I5Iz8zO0eA4kNKp5z+r0rdMddATJBGcmJpSx4n2epfrC8gdYUFS7kFr+LbPOzhFsJzOF
         JkIw==
X-Gm-Message-State: APjAAAVw2rn92gYcU+dJoZONLcRChHeXfl3jPTH+bn0pAGb8OfBVoIk7
        w6tdxl5zvHbm6UU77PzOx7tiriZk
X-Google-Smtp-Source: APXvYqzyyYdzEFrmNrQCvqfpoA0eF0loEPomAJKfZn6zxiWV2pMXA39FVWdQ1aByNRysJdNJvcqkBg==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr49104498plq.331.1553856022101;
        Fri, 29 Mar 2019 03:40:22 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id a7sm2846900pfc.45.2019.03.29.03.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:40:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 06/27] checkout: advice how to get out of detached HEAD mode
Date:   Fri, 29 Mar 2019 17:38:58 +0700
Message-Id: <20190329103919.15642-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

