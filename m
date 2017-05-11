Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36DB1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755349AbdEKJU0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:20:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36685 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755341AbdEKJUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:20:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so5455512wmu.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZVzTnYgch1JIlr8V5XWkRnpIDuApqzXlSSwfy+SgRs=;
        b=cdfZbv0aivaaJApziJw7GS3LA0KoL5IEIjhT3drnQJDeFi2RId5wEVTzBM3nYBgrVJ
         jdKf9BBhKp9pyF4v+um7todLt6s7KfNLRxIuh7TPKuPcRTJT5zO/FXGLpEkKGQ3GcqRZ
         dGVQGYdQWeijx10CenfL5fa25qoEfZaEOjcXVVjwyvRdSpdwq5DNvfHzbJC7hOs1TVty
         I2Yhvmob8ZhB5DbhgeP2PGug6bV11VUllyLZ4siECJ6STcxxPFCctwxPo+1GjMH8GKYc
         QyNgQ3GmyGNxL5C6maQ4RYaYki1dcRCgGyZLmg+vfvURmr6SbIAgRjUzHMS4AZojJhHM
         SYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZVzTnYgch1JIlr8V5XWkRnpIDuApqzXlSSwfy+SgRs=;
        b=suaj+r59HK4iSqd3noX/HUMCp/Z3bVijuq+u4oj9YB92EHnB0NQJSR6cyW+B8MkTjO
         vh/86GCqOXucChGlMmWgLQSvGoFeH+ilXgdMHiLiG89yrGQjtsrzvR83oziYbPp6uWVp
         NJ2KlERKXsp2xDAg4q4MdDPstyow2M/Gr228Hu4l/8leRPpgcuXJfuAFOdGje9gRpYOW
         Nd41+NysI0keoGSR/xBy3wB9loMT6tutRJYqYjS5YSBdYv+3cJz5E/MiFM5VJwghvpiK
         r0q2nA5CjPhuTbAaZAk+eOsqoZlDFXOGHbMpkYYTrHPylul0RC0awzsVCqu39uAqCkEI
         xong==
X-Gm-Message-State: AODbwcDpMpRQbmNcBbmJJVzpMUAovJWCjzJOeBJj2cjL8TO1QelYIwc6
        hPNclQyaHg/T7g==
X-Received: by 10.80.185.102 with SMTP id m93mr4638ede.107.1494494419284;
        Thu, 11 May 2017 02:20:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:20:18 -0700 (PDT)
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
Subject: [PATCH 29/29] grep: assert that threading is enabled when calling grep_{lock,unlock}
Date:   Thu, 11 May 2017 09:18:29 +0000
Message-Id: <20170511091829.5634-30-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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
index f4e08dd2b6..50e4bd2cd2 100644
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

