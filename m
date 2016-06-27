Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4222018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcF0SZz (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34774 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcF0SZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so26966814wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lwAYETzypETVMGiFV6A8Y83qc7kgq4atQVmZY13v6PU=;
        b=HAjKjIykHbIJV4M/T2Gs0CkfSvWsEOgiJ3xiCrl2KsT6wKg5Aec0sYt8SVRysYDaUD
         9wDyaCEVj3d90Nn/0FAQhds2ovqZaaPN141mXZXhMSfzeAEQzsYmmUDDqlsjcWdSavne
         ywupy1vnmmTL/5qNjvL4RW/h55dW2MVTtD4dEdO/MLyNZ0WynMnOskL4Z0jr0qyWdVdO
         JwajrVC3fRJwiVH+J/fjZyZ9jiHm6+CMpM8+xJGrnzarwfqHeARgoiJhazmzdh5SXqwH
         9RuR9cuIuyB62GpPo9pyFFM0jbPY4a1/DBtjILzMTtk7lv7ua/qpi2UUxDo+TSZjFcyg
         yOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lwAYETzypETVMGiFV6A8Y83qc7kgq4atQVmZY13v6PU=;
        b=dGHHkwvqoVwysslhbOckv9oDz6j0Kk2jdcMvFMVnu/absCT8Wokl9ZlsuXSJuMyg4E
         hZsrtYCTE7HcTrxb+q6edwqov6sZlXx+lIPBRk8d0DkaZvk2FE25JGMoszzfgjAy5G7T
         /Bvzz0UgVo4l/FTzyoJk3gnlSGy2Zknhv99gj8mIHFp7xxZAXyHHhPQZWIcPcGuvu0s2
         TMI5/V22rzdzVR3dEVv4/ebYvtphStQLYL7TzyYgiooWzBVT+CmpIwqqtEquPAZ+aX+i
         F8Y8Yh/zQ9FmHp7f2B0diPQVkYCBJxN54XuTIm/ChNq4WJS1yFa3s6pERb9y/XJm2s0/
         Janw==
X-Gm-Message-State: ALyK8tLeo0qDtxM6oJV6/PT6/BJKHE04TNGY9TSLJBH0Y7SuXOWTcDW9kXrQjZkwUqHPTA==
X-Received: by 10.28.166.150 with SMTP id p144mr11444575wme.57.1467051951904;
        Mon, 27 Jun 2016 11:25:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:51 -0700 (PDT)
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
Subject: [PATCH v8 38/41] usage: add get_error_routine() and get_warn_routine()
Date:	Mon, 27 Jun 2016 20:24:26 +0200
Message-Id: <20160627182429.31550-39-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index f78706a..92af27d 100644
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
2.9.0.172.gfb57a78

