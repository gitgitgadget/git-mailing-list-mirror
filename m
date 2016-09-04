Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099221F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbcIDUUW (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35642 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbcIDUTu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so10467593wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJr+Gm6JmPcRJuMJnhYNXRGmfpyF9T0NnJRH0rQT19I=;
        b=rr+NLw7khjux5aNvONEa4HtwRuTHlRJBLRsBUlUOQ5eTbjZJoGLqa/2Sv6kHkfbRDs
         CPyjKwbtaIzkSEHwxhXCSvmm+Be6LZTeBuv6OemvefOTOqdYvYt8PSc0+iyVNwDkkBNz
         v4Vhppl1x8zt33ByIyQWqWgKeXTtmyUL1f+zYJzjXqgKIYQO6hOv57hUQBdeQAqnB8E1
         uRM1zZMWkXLSZuO8wht3eLFDd/D/2iygfOWqPibnUbyRBJfHCmRUZeaYXLtmQsPLqHGQ
         QHmawpyk0+/Ja8nS6erfONU2P3V/IMGXbbXzzXKZ+bslIRXsHOG62wKEXwFrVXkOyg8i
         92rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJr+Gm6JmPcRJuMJnhYNXRGmfpyF9T0NnJRH0rQT19I=;
        b=DZFfk4hXrwrk45aRPqacwYzG1lstyFxco4jFe4FeitoO3dasP+AZKp9hk4SxuYGoNz
         quAmdyGdCDMJLFm7qsXqRsYHCpLzj2SUg6CLyh5lMCJxalmPX5S9jug08VMrTwV789S2
         Ln0wzCAJusKLIHAvvzmcPjdbCBwVGrzBa1yjL9wfoirh5mt+Il9MhKJG//i45jn5RD7+
         mf71xlVkYVGKWFeGRxiTSwG/LX9e4CUeaa/ddgG18LakEGrRHDuVrI2e95dHgwNXmwcL
         YbZalLou8W7rjMuH5ihZIinNjB61a0KccTjA+uK0hZJOVoU6TYA4S6PmTZmLSMO9ZgVP
         J/GA==
X-Gm-Message-State: AE9vXwPYB6TyKT1/ybmKLSE3berKV3nJv57LY3FnuPIyqXvCAAtIArMR0PIzF8v3cKzn5g==
X-Received: by 10.28.234.16 with SMTP id i16mr11747522wmh.76.1473020389207;
        Sun, 04 Sep 2016 13:19:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 36/41] usage: add get_error_routine() and get_warn_routine()
Date:   Sun,  4 Sep 2016 22:18:28 +0200
Message-Id: <20160904201833.21676-37-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make it possible to get the current error_routine and warn_routine,
so that we can store them before using set_error_routine() or
set_warn_routine() to use new ones.

This way we will be able put back the original routines, when we are done
with using new ones.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h |  2 ++
 usage.c           | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index d189b4f..bac8613 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,7 +440,9 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void (*get_error_routine(void))(const char *err, va_list params);
 extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
+extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 67e5526..2fd3045 100644
--- a/usage.c
+++ b/usage.c
@@ -70,11 +70,21 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void (*get_error_routine(void))(const char *err, va_list params)
+{
+	return error_routine;
+}
+
 void set_warn_routine(void (*routine)(const char *warn, va_list params))
 {
 	warn_routine = routine;
 }
 
+void (*get_warn_routine(void))(const char *warn, va_list params)
+{
+	return warn_routine;
+}
+
 void set_die_is_recursing_routine(int (*routine)(void))
 {
 	die_is_recursing = routine;
-- 
2.10.0.41.g9df52c3

