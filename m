Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB291F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 22:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390814AbfAOW0G (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:26:06 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:43207 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390802AbfAOW0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:26:05 -0500
Received: by mail-oi1-f201.google.com with SMTP id p131so1786114oig.10
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ht+oEmjGiRV6RDSOJsCNl2CyL2aJq2sNHW+/Snk8ZRI=;
        b=LOmOidOwhpe7KxuuYfFIUg0Cdr18t5TvwSFYtov16DVQ3EEIHhYxTan3IwnZZOsfEX
         Z6G6otaAIjxncQ0FrevvPFzB8Wvuv3KIDT88BhafgdgXPIFS22hLJGhIbKRcjXId9Wfw
         GLa6dA3YUHWgEC2TxYWRMb/MbCrJBUE3YeBVplQQL/GXkFWVC6CIJWVgUINcC8DLSC9F
         tlwDUp1a08XYY72EPe3tb/DVRzNqOZN8pgE36+h+vTdgp8jd707Ex2Q+QZgGuzOVL+m/
         MfS2NFh6FZvcxWWe5YyOQC3H1bbIB2I0IuOltTudK89t7PRXITlSCIvmYAshUHI3w0HN
         ho7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ht+oEmjGiRV6RDSOJsCNl2CyL2aJq2sNHW+/Snk8ZRI=;
        b=U8BNsRF6VwGNTQbuEcyz0H7GpYouqr3YcogQDasGVq9smWXlbd25UOza9PS6QQn4w1
         EMuM7BeOjyHLs0TxQwMtQgd/3Gkc3XJPNhECnEt1ik74U59762BEIvjgzTPSoOIIwwwM
         QSsKr++rLabBdf4hdwj9iG0O7NjxaKUFW+4lzip72t0rf1UbUKFgL46XteyhQ5hhN0Rk
         NufvJDk9R8rVLSIkmQgcxytewNm4rArETvuYxQRrRMF34cnE0f6HO3O5U5htWKWlahyF
         HJcLWMtil++5dVJvtnsK6ISz1a2gukkMruDBbaYgDGjQjq3N8tvMWhGxzJ9GMoShhFOf
         IcWw==
X-Gm-Message-State: AJcUukcWyruQ3FQf4dGU1upRZ8Yo5TwNkiOKRLnggaYAbrJY9rUOjF2u
        zNyzMnR/cAM7QZVfM8mhh5ZxK4NNtJE6Ut8vUJQxi8E2vCRJ7+JIRPpyuTIvA2Lc13kJ7WjkeXJ
        SMXfoBgIbVONxo75elXuw6d6VUWmcsRKUU45KJ1ycEnW3yee9Tb6VxUHzm+dwqGw=
X-Google-Smtp-Source: ALg8bN5FmhHxZbtRpJYrEmAG5x03DAiPV1XOCRFyDCHhAj0SkWlalHWqEj2gPPSU775ZYJo54vcMacXdRPnlFA==
X-Received: by 2002:a9d:7406:: with SMTP id n6mr3553205otk.65.1547591164825;
 Tue, 15 Jan 2019 14:26:04 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:25:52 -0800
In-Reply-To: <cover.1547590928.git.steadmon@google.com>
Message-Id: <c06e0667fa332edaea3ddc87af5b0481e2544c2e.1547590928.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1547590928.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v6 3/3] Makefile: correct example fuzz build
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment explaining how to build the fuzzers was broken in
927c77e7d4d ("Makefile: use FUZZ_CXXFLAGS for linking fuzzers",
2018-11-14).

When building fuzzers, all .c files must be compiled with coverage
tracing enabled. This is not possible when using only FUZZ_CXXFLAGS, as
that flag is only applied to the fuzzers themselves. Switching back to
CFLAGS fixes the issue.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b72f37c29..bbcfc2bc9f 100644
--- a/Makefile
+++ b/Makefile
@@ -3104,7 +3104,7 @@ cover_db_html: cover_db
 # An example command to build against libFuzzer from LLVM 4.0.0:
 #
 # make CC=clang CXX=clang++ \
-#      FUZZ_CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
+#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
 #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
 #      fuzz-all
 #
-- 
2.20.1.97.g81188d93c3-goog

