Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFEA2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbcF0S0W (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32886 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcF0SZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id r201so26999539wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wOKxrvglJxy/MwJWHsT74wgP0d9q2IlCtWti3WIiLmU=;
        b=viixun99Y68sCq8VIS0q3kv7nWPVgXwhANwNZW52mejWhX1o/NLGKZttco7eNJxhJi
         fpwPV4BuTyYyGcYsa5M+xt4yO8JxelWmn5cnn6lZgBjQbtup27Dg53zNxkcUjzeHXKnQ
         /KbqNluzuaCf/UNlZiq5zwtbJhpEvcoR6ShCNZm9jgoHurV3V/O0c1Xir0CXY0y2Ag7V
         pVLs8ZHs6BGNyMOOdhvl8+7wBi7V7RBbp5CwA9v36tAf1mO4RMhjEMNPtgSYOcVzhbOn
         c8dq/8/TUXiqWj8/L86oHZI6+WtdyTuL3wDpZbpnPG289lvrV9K3XhvVhRM7NuEZcIwu
         uvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wOKxrvglJxy/MwJWHsT74wgP0d9q2IlCtWti3WIiLmU=;
        b=AlPQbZlpXk/PGdhoAx9giDhDyIM3Y3TKVbIvDf6wmC2wAuKGNPgtWrxV7+LiUlTsTx
         zQeoVEnJWYNDhBZBJuzr+86Y0ErmCEokmNvbYcBYQvHWVibUAig6a4GpvHkfz54xqToT
         k92n1puI5i6rr44wPLz7dcd9fuIK1gQ4QjfDGU3JcAmA/4tRzE1Z+eBxY3WBcGBGIncv
         ntnxAfxINRT7AwmqGIBtiHbKrRLVw9AKHQaGs7CleLMtJMjcEFwxXIn4xrQs2p/bMF+r
         Vzwp813ngfdb0S+z4JAuimNkVoYPzAm9w5+LIAmVOQ+jhheVrFENP77kUQQVblatf3Ub
         DcLw==
X-Gm-Message-State: ALyK8tI4bkeK179yERYVHLUxSwfyWGcyVB3L+yzyG8t9iTOeO2hyMRb3wfRNd1rhXZVlhw==
X-Received: by 10.194.88.65 with SMTP id be1mr2222884wjb.46.1467051950225;
        Mon, 27 Jun 2016 11:25:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:49 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 37/41] usage: add set_warn_routine()
Date:	Mon, 27 Jun 2016 20:24:25 +0200
Message-Id: <20160627182429.31550-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are already set_die_routine() and set_error_routine(),
so let's add set_warn_routine() as this will be needed in a
following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 +
 usage.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 49d4029..f78706a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,6 +440,7 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 1dad03f..67e5526 100644
--- a/usage.c
+++ b/usage.c
@@ -70,6 +70,11 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void set_warn_routine(void (*routine)(const char *warn, va_list params))
+{
+	warn_routine = routine;
+}
+
 void set_die_is_recursing_routine(int (*routine)(void))
 {
 	die_is_recursing = routine;
-- 
2.9.0.172.gfb57a78

