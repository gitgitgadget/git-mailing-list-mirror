Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B843B20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932077AbdDPWVW (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34232 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756638AbdDPWVU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so18529528wrc.1
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMP/lmoG+4MX+HFHSsstFCOs5t30zgWSMF4t6FKjBpw=;
        b=A4sBbxpRG9uRkCwr+2amDh7aPq6D9jzSl5Zry3E1gr5Lv1PRTkOq6IO5W/T3MX7O9Z
         IzwZqozvSaYGjtd+TJ5HCe2IlSeeIVB4RbnVN2hY5eeVYHxdEkCSCPQMEa6Y5EVZbpqQ
         //KO05EGm9RQaDLfk7WHaZ6ea7CQYhckMCWagRv3MXGWlgQiK+IvgEsgkunCLVknafo5
         WcocP+vKpttjHMSWlbG/dmUYMF+TRCSjB3Q50fPkZc+SljHqgas9Ecs+ysH3woxqHxI2
         aouztZ7IwyiWdomSWUx7BhsYkD0pCpGFYBxA94oeIvOGWHCAydCvMmCBRLnSlSnqQpHV
         tvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMP/lmoG+4MX+HFHSsstFCOs5t30zgWSMF4t6FKjBpw=;
        b=UnRVAZMx7ZcWKItz3/D2+mXUZ0zzkO0zcUXNvYNwGljhGzIdW+GlGKNCPfJwzrCMZv
         nHevsvBVYflUUvwxDE60LEjaKTDGrhkOPaOfl9WF8/fwK81uG+GD9D5igocg44gNoZ9J
         mqEDPzD8XQZh9tcOicL3WTpL5/Ytdoqy/TsZvvtSKqlRsVKDYsRISRNOryTyCQgg63Va
         3rbV+49NRe8SfTx1Tj3aD4mbssMxnxK3FGssbmtZZ8gHPITSEoPHd7VT218Eu/huUN/y
         0OAt1++BMGfM3blYpEs64qiHlU6FDNZv7NPDv5D4Y9ONoDYql1S79KA7488C0a8qUfnX
         8xww==
X-Gm-Message-State: AN3rC/5mF+T0w9N0fLGowykZFMAFftneg2w+hmXURZ7c3GosJMFwBDH0
        x/QW9rVYU7J3ZcWj9Io=
X-Received: by 10.223.170.197 with SMTP id i5mr14756984wrc.159.1492381279143;
        Sun, 16 Apr 2017 15:21:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:18 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] grep: assert that threading is enabled when calling grep_{lock,unlock}
Date:   Sun, 16 Apr 2017 22:20:55 +0000
Message-Id: <20170416222102.2320-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
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
index 65070c52fc..3aa7836a04 100644
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
2.11.0

