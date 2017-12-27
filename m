Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960A21F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbdL0XBA (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:01:00 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35386 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbdL0XAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:00:51 -0500
Received: by mail-wr0-f193.google.com with SMTP id l19so25505041wrc.2
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hz+FoN5HPhGaZVa90yEkmR1hyAbi/OUuU4I1JjQnnnM=;
        b=NxxfYWBCI6RqacoSZ3trfvFvRnINgDLUZJWk/RriN/xnKjHn4yrIpRICBzN+kCkpOS
         jqmmbqNmANcDk7+6g4jA+Q/fS3JoA78Tjg3ymSc+bMhXis9lzrz9TfdfhSQ1XmgNkU3X
         6x3FYHeII10y7fIDf1uYM/ZhtXXkdj6SIiCMPRHx9LRTttJdalvtqO6uJLZXXXGv6Gci
         mtP8XvAAoIkCfAnHr7LjEi4NrlFZb/oh/NdxnViiPoek6VqX+XCArbx3N9SgKIoUn73e
         l4TOsdyh32hct+6JMIYtRQkC2O5iw2uP0QyhX8gp7yYz9ff0T428PoU+gDU0O6WaV084
         XnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hz+FoN5HPhGaZVa90yEkmR1hyAbi/OUuU4I1JjQnnnM=;
        b=WzPPIrHQIRdhYvlHwrQyhPCNOZ6UMg9RpanoA3zB0YcwSfLLd3Og5AiJxcmzRb+i+H
         oKdDb28TJG6sHo8tD9nZfqBHP2ziGUlpSxkwUbib6WXA7ymRQsSP9yUFYD1rzlvvirma
         +mlRI38H9CUjmpYhi1rG/bhBNVhngN68wIKSMClQHMdBfncNtc8oRA0TK/Kzr9bJAVAE
         CYpc6nh673YM5MIrMCWu3zwEph8l5NmNa69ByGD8rRImAL2eKtJyVSWZcFfVXv1dWBdd
         IKp/CJeYRt56OZN48gftwiZXagiwG2FyAsv9CtnMWqT8mLHHEWSf30ZbcjFcYqmqZ+KD
         y2UQ==
X-Gm-Message-State: AKGB3mLdKv7EcmB8Ay0FommHuRzby7q5WI7xepBT45Vu3p4ZWfkywMk3
        y6q8nPBe27toNsrIwgUqGtU0DIfR
X-Google-Smtp-Source: ACJfBouYD0GAeIvijihIqrUUR8q56PAVCfpSGCE67WUt21k4v8vt6filz9gxcRaMBxWpkCb123cSPw==
X-Received: by 10.223.153.151 with SMTP id y23mr30748741wrb.130.1514415650404;
        Wed, 27 Dec 2017 15:00:50 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k61sm21467411wrc.84.2017.12.27.15.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 15:00:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] Makefile: NO_OPENSSL=1 should no longer imply BLK_SHA1=1
Date:   Wed, 27 Dec 2017 23:00:37 +0000
Message-Id: <20171227230038.14386-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171227230038.14386-1-avarab@gmail.com>
References: <20171227230038.14386-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop supplying BLK_SHA1=YesPlease when NO_OPENSSL=UnfortunatelyYes is
supplied. This has been done ever since [1], when switching to DC_SHA1
by default in [2] this should have been changed as well.

1. dd53c7ab29 ("[PATCH] Support for NO_OPENSSL", 2005-07-29)

2. e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     | 2 --
 configure.ac | 1 -
 2 files changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index 32c170687c..7e1da28b6f 100644
--- a/Makefile
+++ b/Makefile
@@ -23,7 +23,6 @@ all::
 # it at all).
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
 #
 # Define USE_LIBPCRE if you have and want to use libpcre. Various
 # commands such as log and grep offer runtime options to use
@@ -1260,7 +1259,6 @@ ifndef NO_OPENSSL
 	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
-	BLK_SHA1 = 1
 	OPENSSL_LIBSSL =
 endif
 ifdef NO_OPENSSL
diff --git a/configure.ac b/configure.ac
index 2f55237e65..7f8415140f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -241,7 +241,6 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # a bundled SHA1 routine optimized for PowerPC.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
 #
 # Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
-- 
2.15.1.424.g9478a66081

