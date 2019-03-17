Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38ED20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfCQMuQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:50:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42201 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:50:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id b2so9479675pgl.9
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjIObuSZOxKCUx8V5DyNqYBCV96tjOpWVPk4Q5/6254=;
        b=ZpiONCoiSLSiTIybemf8LE5B/H/X5sGLnPnS2HTwcxPm+o7R7xpKFIOraDkRhh5UFS
         U+3kkRyKBxrPyFLlJTi71cQfZhXf2Jv3enD8T0iP9xPxhRVELB+DC2Uk82cMyd4iIzuU
         aV+sMuXvHsFC0t/CFHkoOgYn0KUn1cjajwKuVwJst8hWreJmusbdyOBPgdy0aeUG5QPK
         cE75Vw7+oEs2DAumvdKUNgKcjY8wgfcIp5UsjvhNK30x+sDbSYKAr6XFLMC4i5yH/WQE
         9g7wxJvJWfInFmkx/Q3OlDA+RXgZh72X2Dw34L8O+f66AED66XQpgjPf6d0gNHw4WWc0
         9eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjIObuSZOxKCUx8V5DyNqYBCV96tjOpWVPk4Q5/6254=;
        b=Yhis5xaO/pQDWeb+dhL1Ib6hkVFxbKQA0v24rBWjH/NAnXGy5bD0Ls449HylWmXcDr
         f31YnxSydjYLO44CVvMTmawbN8HcgxnK4mI3sBWgOAYcByxdHSwMO7wfSRGom4fNZ1qP
         vcijKQ1onqhslN7FqBqefQ9FivYUhS78I0N6brY10mGlzBrJ5TPNivBIOeNUOlDxPN3K
         jycK+J7Gt6QLLGbpxY4ADhsBiX8YHu13+yvEraNkmBmyWDI3nbKZxG60JBQHKu4T5dPX
         aYHSM1RNbr4uklJ7yi6oOy3J2fqH4tzRBcc2nOqbFailmp3APMBnk6VkXAID2i+hb6aL
         P7Cg==
X-Gm-Message-State: APjAAAU8K0aA1ImsGfBU7Oe+vOy0EBP4UHfpE0250Z0YQaidoPac/BIe
        H/dWDNAfgpxmVz/VczrHPaE=
X-Google-Smtp-Source: APXvYqy0SXlcdAVr7moMkP1i32fmsAk0ZBAQHqa4fb0pbI5h28JPPB6Sfv4LGZAMXqbEU7DcjxCieQ==
X-Received: by 2002:a65:4981:: with SMTP id r1mr12940534pgs.62.1552827015890;
        Sun, 17 Mar 2019 05:50:15 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i16sm4581809pgk.51.2019.03.17.05.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:50:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 06/26] checkout: advice how to get out of detached HEAD mode
Date:   Sun, 17 Mar 2019 19:49:06 +0700
Message-Id: <20190317124926.17137-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
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
2.21.0.548.gd3c7d92dc2

