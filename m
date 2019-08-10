Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6ED71F731
	for <e@80x24.org>; Sat, 10 Aug 2019 20:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHJU2D (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 16:28:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46725 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJU2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 16:28:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so5646230qtl.13
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLQblxTsIs6isPvJ42iTZ/nKzLW0BcZi1MiNG6b1XWE=;
        b=R7Bqbbfs8CpQ91DAgqMKeAcrUb6d5smHz6OChrTfNsFahnSDQlK5zlEwNTr17VcLXC
         smpJ8RbmM7AjBzUJXDUF3S57l9tFwqwqSBb7qUE15k+A/CBqOdOLMcS1qUwpj+KPi76w
         lpjyzYV/3y3H8h1mE7ldMWeNmPSgUCqGQw6voJPjMugtePDd4O/wG/ZgyOi2oWb7Vutb
         t2aKhKM+ImI0YzRFvO2kWnoltAbFpWv75kqm5Ozp2tnUNw8tJhyl4TyEb7QakCGj2V7B
         EdMvFGevkkdDJjmg8irVLGmyvdTPQyJG0bWyA+i1qcCwRspV5gH3mX/L4/x+FfquffgN
         /49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLQblxTsIs6isPvJ42iTZ/nKzLW0BcZi1MiNG6b1XWE=;
        b=umS8ksQM3CO83ZWBR4GMJpF+atE6yC3oyqMGXxhzDEbdE/tF8QV4WzUpiLf6yrq2Hh
         VRqVstBmi612Qjnl/dh36HrQZr86NPFv1cs/Qb7VmufTb4qIoGeOLsE4HYYOkRpLjkwi
         BBww51SJfc6HyenZr+ymuOdcNFMtvhBfo2NJckMeGbTJ3CUUZoJm5RrHd5lkYFHj0gfC
         szmCYuJ6s2YKzHu2atIwUrqUsgRNpQ4BZKzEyUtl9BZFfT+Uz7X+UuScz+x/H7tZ4oV/
         RLFYajJtG5Y0EmhimW8YAK5yiN4DJJFI48xVeGaoGH4PqeHQqU7J7jWJXRG7chJsH/eF
         XsKA==
X-Gm-Message-State: APjAAAWJNvOs4EcU/jGxySWMoi2Efuac1BbANWfN0C1wLgXBxygAku5X
        TwAjvdyBFSdjLJigH5DLIqzH6Nkzw4k=
X-Google-Smtp-Source: APXvYqx+mafa60YuCY+TaU9bG16CIy/VgKaGzpd7ZvLxlNpV3igPP114DTSu1tHyWevvXffATwXHug==
X-Received: by 2002:a0c:ac98:: with SMTP id m24mr24489109qvc.9.1565468881643;
        Sat, 10 Aug 2019 13:28:01 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u1sm54384295qth.21.2019.08.10.13.27.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 13:28:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH 3/4] grep: disable grep_read_mutex when possible
Date:   Sat, 10 Aug 2019 17:27:29 -0300
Message-Id: <d2e3f4eac24d26210f8962ebd82fd24a99c91fdf.1565468806.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565468806.git.matheus.bernardino@usp.br>
References: <cover.1565468806.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep uses 'grep_read_mutex' to protect some object reading
operations. But these have their own internal lock now, which ensure a
better performance (with more parallel regions). So, disable the former
when it's possible to use the latter, with enable_obj_read_lock().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a871bad8ad..fa51392222 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -205,7 +205,17 @@ static void start_threads(struct grep_opt *opt)
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
-	grep_use_locks = GREP_USE_ALL_LOCKS;
+	if (recurse_submodules || opt->allow_textconv) {
+		/*
+		 * textconv and submodules' operations are not thread-safe yet
+		 * so we must use grep_read_lock when grepping multithreaded
+		 * with these options.
+		 */
+		grep_use_locks = GREP_USE_ALL_LOCKS;
+	} else {
+		grep_use_locks = GREP_USE_ATTR_LOCK;
+		enable_obj_read_lock();
+	}
 
 	for (i = 0; i < ARRAY_SIZE(todo); i++) {
 		strbuf_init(&todo[i].out, 0);
@@ -227,7 +237,7 @@ static void start_threads(struct grep_opt *opt)
 	}
 }
 
-static int wait_all(void)
+static int wait_all(struct grep_opt *opt)
 {
 	int hit = 0;
 	int i;
@@ -263,6 +273,9 @@ static int wait_all(void)
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
 	grep_use_locks = 0;
+	if (!recurse_submodules && !opt->allow_textconv) {
+		disable_obj_read_lock();
+	}
 
 	return hit;
 }
@@ -1140,7 +1153,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (num_threads > 1)
-		hit |= wait_all();
+		hit |= wait_all(&opt);
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
-- 
2.22.0

