Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34351F935
	for <e@80x24.org>; Sun, 25 Sep 2016 03:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030388AbcIYDQg (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 23:16:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34965 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030206AbcIYDQe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 23:16:34 -0400
Received: by mail-pf0-f194.google.com with SMTP id 6so7207258pfl.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KJ5PRSIg/ESVkYRfn0+FLzDs697w2M/CG2o30XbjEQ=;
        b=aFTl0Ijxc914QtU5RM4XhcvMrT83jTey5CQjs8d114YfFHc97tqsqem+gLtnTsn5+Q
         WTYTVVIk3i79AMWjoBtnUzuEClZI3zsJPYpMiVhUPy5jBHzG1qaBBcrtJIxUpGAQ8Uoq
         u82o9hvOvSSlA7DCJ+Jmu8W2+X3h7TLWTkxmkqG1kOuOGbJgGXB2Oz35cF72YsSEGsMn
         SrEzagwiy40uXCWA9kimQadItwuqDw3igeV4+fFMamNEVuDbzYnzQY50xE3ZEP5aYJe4
         ZvGSA9nJZdG1b3DDz507ywYP7TgsC+JdL52e7nj0cHR/AdZQFlRzpfi2SONmVoQ2EBWI
         NBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KJ5PRSIg/ESVkYRfn0+FLzDs697w2M/CG2o30XbjEQ=;
        b=j0Zy6W1h2zAJMD+oYuLzvNA0hm2BwV5GXEO7XrvbHupwQwWt6Ffk5ywsfgp+8fn66P
         vb2GsyYMsXkHVxo9W1DbD7Yo7RKu5VHcVqNuPYDTZ7KevORM79OoTqijARIA23sEIC19
         zCl1LVt3d1I27xPdLG8v0MxNa+EymA2kgsMO23/t7cbJE68RXhrbyT/3Z9CQ5Ojzt1OZ
         dGkkF5nuGJN2GB/AzUznZKfucS24j6vqGCslYS2/sXR9/K7dQNGmjiKO3xgtlaEl6Eqv
         EjJKGMinuTjg7rujNO4N78AHEe5ijxaFMBZ4M22dbQCuUMl/mNz7EPL/OkLC11FmcKJo
         dy7w==
X-Gm-Message-State: AE9vXwOTqkggFmgTRyoB5GIhx6dJ1KEd0mtWGA4vSwTYCl8egRkkfRKxG6DIZzI5r+XLfA==
X-Received: by 10.98.193.193 with SMTP id i184mr26191708pfg.69.1474773393491;
        Sat, 24 Sep 2016 20:16:33 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id k80sm21217035pfk.27.2016.09.24.20.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 20:16:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Sep 2016 10:16:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 5/5] init: kill git_link variable
Date:   Sun, 25 Sep 2016 10:14:40 +0700
Message-Id: <20160925031440.10435-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160925031440.10435-1-pclouds@gmail.com>
References: <20160925031329.GA9124@ash>
 <20160925031440.10435-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 8069cd2..37e318b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -22,7 +22,6 @@
 static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 static const char *init_db_template_dir;
-static const char *git_link;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
@@ -312,7 +311,7 @@ static void create_object_directory(void)
 	strbuf_release(&path);
 }
 
-static void separate_git_dir(const char *git_dir)
+static void separate_git_dir(const char *git_dir, const char *git_link)
 {
 	struct stat st;
 
@@ -349,22 +348,15 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		if (!exist_ok && !stat(real_git_dir, &st))
 			die(_("%s already exists"), real_git_dir);
 
-		/*
-		 * make sure symlinks are resolved because we'll be
-		 * moving the target repo later on in separate_git_dir()
-		 */
-		git_link = xstrdup(real_path(git_dir));
 		set_git_dir(real_path(real_git_dir));
+		git_dir = get_git_dir();
+		separate_git_dir(git_dir, original_git_dir);
 	}
 	else {
 		set_git_dir(real_path(git_dir));
-		git_link = NULL;
+		git_dir = get_git_dir();
 	}
 	startup_info->have_repository = 1;
-	git_dir = get_git_dir();
-
-	if (git_link)
-		separate_git_dir(git_dir);
 
 	safe_create_dir(git_dir, 0);
 
-- 
2.8.2.524.g6ff3d78

