Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D496C201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbdETVoK (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:44:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33758 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbdETVoI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:44:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so5751472wrc.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKlnmWGTZLPToSEOEtcBXvqZuNIpqwoR6fjfKerRwfg=;
        b=hIaY9y1979foXJbnB20akvpCuGTTwBz+VMaTYIC7NGhvvWrTCqZKYD9nLJEL9g66x7
         DDljgw1ssbgqj6Jm+63WXOys0RtedG5pZbJp222mKC/RCdNMbIBmtZrtMlSzHv2WiL6f
         L77Y2q7Pa253dLIfIsRofG+NtcmkN+T8vDg3HsNmkY+bQw9k1ZvivY6AHSEFW4uaP6cv
         3r7ZH1Axcumb7+xrSOl93xhJBb4dP5zjQpg1YCMIcacf1ulMzSW+3S7eSGquE/8HHHc6
         yhykaixrYuAC6Xs4OYdWqwdixJWpjxnA2STGXvKMtvt6Hq7sSjDVkGSv0Qmf+wFX2E5q
         nfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKlnmWGTZLPToSEOEtcBXvqZuNIpqwoR6fjfKerRwfg=;
        b=LfjBwHmIWrCq8wcHuz6BkyC6Ojj1RFRYKoebn4jqStj0dLMbgR+YIfDbHo0c7bZCJV
         sRr3c+O9NxhZY6lcDz7GmfdZ9Bygn7ryvjjWhFKuyTpEgemQ0AF97u14GWfxwdXj1O9L
         qI9n8TdgMbO2k6yHW6iPuBCmH58CJSPJKZFWigpfmq2vG7yimena7bkmX0NZ5UKAddE0
         QAXk8R28E0e0j2c9Xe8K8kW9TBu4QCac9gHU81p0ZH4M5OKjfFycTXLynvqr6OwB7fXo
         DxIjIFPiLfRTqKw9Rt6LSVBJNcbbu0iKC3Vg/239rh/ivrGByJ4BZyQmi81s6iWhpbO0
         XSiw==
X-Gm-Message-State: AODbwcCT8+sEN+ON9tQRcZqdiCC+xLIXwrfES+WkSFSe3l/PGuOxXUAA
        R9yK+B3TGNMuSkxUEvU=
X-Received: by 10.223.172.48 with SMTP id v45mr7805402wrc.112.1495316646346;
        Sat, 20 May 2017 14:44:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:44:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 30/30] grep: assert that threading is enabled when calling grep_{lock,unlock}
Date:   Sat, 20 May 2017 21:42:33 +0000
Message-Id: <20170520214233.7183-31-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the grep_{lock,unlock} functions to assert that num_threads is
true, instead of only locking & unlocking the pthread mutex lock when
it is.

These functions are never called when num_threads isn't true, this
logic has gone through multiple iterations since the initial
introduction of grep threading in commit 5b594f457a ("Threaded grep",
2010-01-25), but ever since then they'd only be called if num_threads
was true, so this check made the code confusing to read.

Replace the check with an assertion, so that it's clear to the reader
that this code path is never taken unless we're spawning threads.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3c721b75a5..b1095362fb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -73,14 +73,14 @@ static pthread_mutex_t grep_mutex;
 
 static inline void grep_lock(void)
 {
-	if (num_threads)
-		pthread_mutex_lock(&grep_mutex);
+	assert(num_threads);
+	pthread_mutex_lock(&grep_mutex);
 }
 
 static inline void grep_unlock(void)
 {
-	if (num_threads)
-		pthread_mutex_unlock(&grep_mutex);
+	assert(num_threads);
+	pthread_mutex_unlock(&grep_mutex);
 }
 
 /* Signalled when a new work_item is added to todo. */
-- 
2.13.0.303.g4ebf302169

