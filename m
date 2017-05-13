Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA7D20188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758911AbdEMXRi (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:38 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34190 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758687AbdEMXRh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:37 -0400
Received: by mail-qt0-f194.google.com with SMTP id l39so11213516qtb.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTJylmZCZ9G9n/hV9AywnswTj2q3MqFCSHTwoBh1PaI=;
        b=DNVbmAQz2izFQOxLzTLNbEFFxUk/sX1o79grd9deHns4OZG8k+2ocewIzV9zM6dnVI
         OQg3UWVayKZihx6f7lanCjlPbVP3hEAOzSJJnNXiriE0W/8qxVqtw+V2p6q8UJ4yLuju
         nvMNGhdiq/M7ulaJPYjIvkq/NFdVqRR2ZK8FHWf7N7dlIbAGuYtCzyq1rry9Xqi0H+LE
         ql5sBmjuTCcVdaS3inv7jaAZJTPTqbmg7ubDcaGTSSOnapuHLqEneGFW78f36QpQHRBj
         8SQhzERfeMeH2bGePH+unZYzQ5FWF90vYBgWOgHHKCm+Qp0pMYEZFl4Enqqry5QWcBJJ
         jK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTJylmZCZ9G9n/hV9AywnswTj2q3MqFCSHTwoBh1PaI=;
        b=tynukkz+2cWuGNtnYymDdKwtUbNWFKxEVnbHbR4lmfQNg8UJkS245qVfrG3ytQwFmQ
         QwnekStLSAApoOiJYTDSJB3jZc2GG4EHf2KBE5YxHFkXaLMUur48DUj+nRDCQn8rm0tv
         iNxn+8kd7Nfutou7YyLmR+W01ATB4eRqyrKb9vAKNCDVnzJVUbb69+d/7IXttTu5+AXk
         quG8JfnVjgtSfHwrInDRHWb5wj6KYHbirm1Bx2ft9TZDLyR9ED5KIXpxUPVnfhg4+Pot
         JVewLwea9rjgbTOZuVtNMOCRYGO7PIwR85VOm3uafQvOuYs7dgMHYAIm/OkwMuAuePWQ
         irEA==
X-Gm-Message-State: AODbwcD9qCX/lNHTog3qDKKezp3WEVFYdH/0ZVqOyJsLTszRngBly2tS
        N3JNC0PhguAT5g==
X-Received: by 10.200.33.152 with SMTP id 24mr9617488qty.38.1494717457032;
        Sat, 13 May 2017 16:17:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:36 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 29/29] grep: assert that threading is enabled when calling grep_{lock,unlock}
Date:   Sat, 13 May 2017 23:15:09 +0000
Message-Id: <20170513231509.7834-30-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
2.11.0

