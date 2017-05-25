Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D71209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036752AbdEYTrv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32980 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036736AbdEYTrj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id b84so39677588wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKlnmWGTZLPToSEOEtcBXvqZuNIpqwoR6fjfKerRwfg=;
        b=GwcCw6w/tbi7SrJj3vy4ilFB0ViyVTcBMklMFe1Zs/7JxJKW7V+X74H1MMAAEPBvwX
         nLiPqp37bNxNEz1eaj78D4b0RsgjGZidKm81jnawWNbtplobRSOzCts96Xe9HX6VyxWR
         pd2qii8gCOIOHGFRPKD8ZLaGz0mZhaVxt+/7kCSlz6XwMnjfoMwms/1PNrO+KdbGI4Sx
         0i1XtwXwFqn+5vOzK/CtQJxHMjk79ecPYHbzV8t0IznWhezqDGSOM6WEh6KxbgGRHw1z
         bnsQtaT/LAFfaA6teBbo/R8Jy2V0CCWik778MzuP/vx54v8h6BzZpcSIWPlUmdOL6xjN
         lVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKlnmWGTZLPToSEOEtcBXvqZuNIpqwoR6fjfKerRwfg=;
        b=b0G2ZJUm+ZSGbnM8y9daFPBFlnEIHR+79J8nbryYjivF0Fb6wI3d+d/tFu11rHPYZC
         GIBVwmiuMkkbjEwWsDS+sqywVSQyOznwo9Nn4RmxbSkpJFIW/NJdYbnmMqrRKdocJg50
         hC5B85cuZlzvuKElIHN+pHPpx6XNBwzTIB3kcfn4olDWZEiMYRd4qZXb3KGi8IxYz8Q/
         yPOPBblllYGFS4U7BNK3OBCL789/pIzyNaB+PrAqby9Y6KlgBE6HewSNql8Kn6NDXeAP
         YOucNdlEUiR8EmGPjBH8WYUnCegHl5IPYpkTxM4Tk5va7mBQ25tAe2nqHMgxCUA/ScAg
         0Ibw==
X-Gm-Message-State: AODbwcA9A2GxTttw9EbLYg38ayeBGLRnex/Xi6ejnnATIv6IS7AlSR2Q
        i566TslNZZVDWq/hhpg=
X-Received: by 10.223.163.80 with SMTP id d16mr29891189wrb.164.1495741656866;
        Thu, 25 May 2017 12:47:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:35 -0700 (PDT)
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
Subject: [PATCH v4 31/31] grep: assert that threading is enabled when calling grep_{lock,unlock}
Date:   Thu, 25 May 2017 19:45:35 +0000
Message-Id: <20170525194535.9324-32-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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

