Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F45820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 01:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLJBeZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 20:34:25 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33554 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLJBeY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 20:34:24 -0500
Received: by mail-wr1-f53.google.com with SMTP id c14so8870907wrr.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 17:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3yYwVwLgr0jdA+Piso2n0FTXSIpLPvm3e0dEOChv5E=;
        b=RHuFfhhRpBLY914iZlSHzMwzP1AdVVdyuoHtxWlLnvNO6mRcBOaBNSTv/z1eL/2oIA
         CN1ZsofJVWHgOL5CNzuhe4ZqClpIM5Wr2nvcdVbl9+FcHkdC9bw8g48vbv/ALdyi0R7g
         g5BU1Gty3aHeOhni5eOjrgytkg1+lYajOXGsADBYkUWmJrVVZ8ZC1Rxqvum60L6l9JhO
         IJz86MbjOUlbg9n0TzwGgCZFXPMag0ooOjVmP579Fkl9VwED8PsS6ZgQ/Yy46l/qUrE+
         7vXj9eQr2Z/yecP3+V1GeTRp1buStsBg99mrJXSoLkf1o5APpU2fcrc3tDK9dHDQ7Fab
         nA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3yYwVwLgr0jdA+Piso2n0FTXSIpLPvm3e0dEOChv5E=;
        b=I18nxdUtADQG/vO/NDdP0sNTcH4TJoMx3YFeYBZYMe2agn2m5/iYXntEO2TIMirhil
         tapmtJjvuReYj0cwUdBSrp+3kyLnS+EfLFyVz29v4GdC9p4AVOuzx0R0KGUiQE5h1iye
         M61ILLtPaW0pcatfsQm5hVNWxbUP2+yV6xXVLLMX+OuuSnjxKryxEGnWhUQocF8MrcM4
         0ecy3Ph1iOPPYrBNvu9cDc55MnXt8P8OwlDpXN64zI5XPh7vHgc79tvUOkQL39dkLM4n
         A1JB94mWnNoBVbw3PcaK9d+8LLIQTDRdG1T7iUiIgjA5UpBwkHocDbRQ3XaKxnJuaU+X
         OTtQ==
X-Gm-Message-State: AA+aEWbm6i9cuseIv+lfzkiL2LQ/Bl+7qaWTcVO5auALDhDbk8ZV5OlD
        UUovF2maoFplgxdFybEQUPWOsyh0
X-Google-Smtp-Source: AFSGD/XeIT0ztoFL7V7llXS7pDZOd7ZDtU8ZFE3vsKVOi6i4nSXLBrO1L01bZeiJNEgoV9vJGNATEA==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr8718973wrn.142.1544405662881;
        Sun, 09 Dec 2018 17:34:22 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id h127sm10772199wmd.31.2018.12.09.17.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 17:34:22 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] fixup! test-lib: add the '--stress' option to run a test repeatedly under load
Date:   Mon, 10 Dec 2018 02:34:08 +0100
Message-Id: <20181210013408.25577-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-8-szeder.dev@gmail.com>
References: <20181209225628.22216-8-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---

Erm.  'trace=t' must be set before checking whether the shell
supports BASH_XTRACEFD.

 t/test-lib.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e405191164..3e9916b39b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -446,6 +446,13 @@ then
 	test -z "$verbose_log" && verbose=t
 fi
 
+if test -n "$stress"
+then
+	verbose=t
+	trace=t
+	immediate=t
+fi
+
 if test -n "$trace" && test -n "$test_untraceable"
 then
 	# '-x' tracing requested, but this test script can't be reliably
@@ -469,13 +476,6 @@ then
 	verbose=t
 fi
 
-if test -n "$stress"
-then
-	verbose=t
-	trace=t
-	immediate=t
-fi
-
 if test -n "$color"
 then
 	# Save the color control sequences now rather than run tput
-- 
2.20.0.rc2.156.g5a9fd2ce9c

