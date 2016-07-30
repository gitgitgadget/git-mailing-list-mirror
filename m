Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F232021D
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbcG3R13 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35511 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so20042175wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQPczNV3ZORAZv7WJ6j8ddXGKRONXWwzR9L9UEQ5mYg=;
        b=j9I/Ay7qC38izUU2oqECrCwnp394T52rdFx4X73MzpZ5ljBDefk+BzBbhmTcXer7No
         x/QexUlk2mx+u+iDfnWlt9bj6cZe52FYoYlXbg4eMSPMSV9kS4/+pUMh2PWElLMByVOj
         QehO8Zznw8jv5s0qO7o89mgNQ0rW4Ttcf1C7Hu3lO6tgekXhZtjkVnKucZaafmU7RXbE
         6exnIl/2uCvWqEgULSNhbO0Mqly25FRjlzGw0ALw7UtffGz2Y86n27lfGpLAAinStnq7
         WysKqimv9k4VNrDFsWd+mr61iDVH+FxW+/r9cs/Z811QJY20z6zgn5cA/PkfW+2tDaRm
         0dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQPczNV3ZORAZv7WJ6j8ddXGKRONXWwzR9L9UEQ5mYg=;
        b=lpu3vLDXVGomU+KP7II0BMIFRHVR87It6O9Zc1zjL6EE1Mg0es69y6m01508Bz8a+H
         R4zVr4ZXsU9pLelUiDUfWu4T98Bjlnqc5AgTpd5r/2ZUCZXWxIJeALPc/EzLlczFgPbY
         6OH8XPMlH8i79h076umMAIppgoX7bsd5q2/qVYk9XpiE5gOEXIM1EvsjSiyHm8NcqvKQ
         KMua+dsba61o3PuofZM8HNGsunu/4aUIfw9YZiHkAxG2Q0I4Pc6W0kupwkIEoKMFGMFg
         w6MSXfQ2YCu4gyb4JhE+6mAbFntai+zjhD/1TZ7vkUwOfPD4PbVK3PY+lrQBHgT/+wqW
         PPpw==
X-Gm-Message-State: AEkooutcmYs1Z91TrP+jUl1GEk6Dm4wNcEhxx5yU1yOA++qXJTRhGm2jcEVAUcV0fU6izw==
X-Received: by 10.194.80.104 with SMTP id q8mr47176319wjx.151.1469899594339;
        Sat, 30 Jul 2016 10:26:34 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:33 -0700 (PDT)
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
Subject: [PATCH v9 37/41] usage: add set_warn_routine()
Date:	Sat, 30 Jul 2016 19:25:05 +0200
Message-Id: <20160730172509.22939-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 590bfdd..c7a51f8 100644
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
2.9.2.558.gf53e569

