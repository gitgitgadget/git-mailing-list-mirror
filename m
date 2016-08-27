Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DAEA1F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754967AbcH0SqU (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36236 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754872AbcH0SqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:08 -0400
Received: by mail-it0-f67.google.com with SMTP id x131so2923884ite.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6yVn2PgcCLrv429uveyS+5Br1ou5WGOFZkbth6EZEKk=;
        b=TJYjV3I2dlt5VS47YowO4db98fMCofdQPc7f2hPXEpd7bDgff+vdYgf9VVhjuIRlnU
         FLyWrj3BvsbyAbiPkoIJYZvR0Qn6gAX63mTlvQTReA30zFUPJmTPl5x3ETQDrVykqnrP
         /lkw5xUUpi8C5knoKyiKkwa8R6/jZxz08Mk8dzyIGMN0FyB1cL4wj0WlAXqWdXOIrbTU
         AmcPBrK2VZFWS3nDCrHyxDw4YpbWg5e4V93MhuIvhfa47IXm1kRRDDsh2X8+nlu7zDBQ
         Bh2ljjgEQkz71oEMXHNgURhqQuspKZtZmTkJzDajUnBV6tUWzcPKy0orB0cvudnaKNps
         NZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6yVn2PgcCLrv429uveyS+5Br1ou5WGOFZkbth6EZEKk=;
        b=mWXGC1l3kt343eNfUuDlfzhqQmmHtG373ivM7jnmIQBM468gAwL8WczdS2l2cgiRN+
         DfShHTatuQuiSNGRSgECyTk0w1sTx7hWXcRs4JCP8b4mXG61qcdABcHjutfxrXoWxGq3
         RYoiEa/V0iAQNWfjcRbzwKmWV5Y7yevmgBLfvMzXSMTAMRvEhkvH1FOGX1j/PGbU7FnO
         R/C00RQlltxll4SurEnI1yd3SpRLciAo5cnV+7rr7YkVfDqMNgEenN27M7wic+myVNht
         RLbXKoZ6kT8XQQzfsNNY9XXuCoTYSyKrQg6QcBqDAW7zDcQvlBEpoBbM67MqZ0M0fF9a
         oYMw==
X-Gm-Message-State: AE9vXwPdE2Z9v5s2NBa9LlFz2x0ab8zv+/D2oeRORsIhiQs1/4/J5v5kW9GIvx3gcaAUYA==
X-Received: by 10.107.164.80 with SMTP id n77mr11576542ioe.105.1472323567675;
        Sat, 27 Aug 2016 11:46:07 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:07 -0700 (PDT)
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
Subject: [PATCH v13 08/14] usage: add set_warn_routine()
Date:   Sat, 27 Aug 2016 20:45:41 +0200
Message-Id: <20160827184547.4365-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.9.2.770.g14ff7d2

