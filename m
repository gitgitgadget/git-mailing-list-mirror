Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BB4208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 17:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbdHURoM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:44:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37025 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbdHURoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:44:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id z91so19038386wrc.4
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wte96Em+LgCDcuaDtCwj3k8Mcaec1GlxI6Ay8w25L3M=;
        b=j08y68U+L7emvnbFLKMVX+UMH3TCXh0nuh90G8BDfvMmyTehsU8RKQsRywFOSTCy5M
         74LSRxcLUzGy3/oSQJFlXb55Jum9NeCSruuXMLXJWMUZRIBXgdPn10m6QNmgNAI8/sSq
         LcU46iHtxIkUCEghs0MFMfQUyC4baqH2OV9GnukXBmzlQcmvEfBsFeDYN0vMueV3vRXM
         4I4HA8pz9q5rT1c2QOmAxsJJr0eX6SKQMTQVuDWmlOE+YQ9vr5PEPib5Sh09gcTa6/+3
         a/F9CgC5FYG/pxzLquPXLpjGtTQD0N1Enzx+ZUluTuGkH9iSAoe/Ljq1dsKfS3sQ/EQ5
         RuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wte96Em+LgCDcuaDtCwj3k8Mcaec1GlxI6Ay8w25L3M=;
        b=FsT4bFWk9/OnqZk99d8pQLE0KbhgxMFa6aW2do0i0gfQDzoZFYA0lgEQ0yNGU5JPt3
         cBrpSopQFE5gspRTgz4TGMqIFUQGA4NgePZWBswspDua7qse9ZjoY7K2p4uLhHhkIRR3
         SoIp6I1S2m9b+pC1mRGq/ydvVedYOgpE/+12ypw1tS4cBrdgoIsU93TTRWOuOGg5E/DN
         vbj+LdLvS9UXrrah3DhdkASb1Hlo32OpeqUNO0mF70utodknR9jU0AEv+hJvPo7aCtQj
         rERawndlToOOUTJSCXTi2A3pgcb192ivb5qNUgnqGryxABOQP0j0MUo3MpFrbxLLu489
         1sKA==
X-Gm-Message-State: AHYfb5hF1b/KVpq+/ev01mC0UJ3vBfpGQ61C/L9Ob4hTAnPkpW0JjqVn
        SOOdTFTLIZszoVS3
X-Received: by 10.28.40.69 with SMTP id o66mr6201025wmo.164.1503337449519;
        Mon, 21 Aug 2017 10:44:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id y8sm5942458wmg.12.2017.08.21.10.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 10:44:08 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] ThreadSanitizer: add suppressions
Date:   Mon, 21 Aug 2017 19:43:48 +0200
Message-Id: <09bbbcd1429a28774ea2d8c67ef6106ab558c296.1503323391.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1503323390.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a file .tsan-suppressions and list two functions in it: want_color()
and transfer_debug(). Both of these use the pattern

	static int foo = -1;
	if (foo < 0)
		foo = bar();

where bar always returns the same non-negative value. This can cause
ThreadSanitizer to diagnose a race when foo is written from two threads.
That is indeed a race, although it arguably doesn't matter in practice
since it's always the same value that is written.

Add NEEDSWORK-comments to the functions so that this problem is not
forever swept way under the carpet.

The suppressions-file is used by setting the environment variable
TSAN_OPTIONS to, e.g., "suppressions=$(pwd)/.tsan-suppressions". Observe
that relative paths such as ".tsan-suppressions" might not work.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: added NEEDSWORK; reworded the comments in the new file
 color.c            |  7 +++++++
 transport-helper.c |  7 +++++++
 .tsan-suppressions | 10 ++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 .tsan-suppressions

diff --git a/color.c b/color.c
index 7aa8b076f..9ccd954d6 100644
--- a/color.c
+++ b/color.c
@@ -338,6 +338,13 @@ static int check_auto_color(void)
 
 int want_color(int var)
 {
+	/*
+	 * NEEDSWORK: This function is sometimes used from multiple threads, and
+	 * we end up using want_auto racily. That "should not matter" since
+	 * we always write the same value, but it's still wrong. This function
+	 * is listed in .tsan-suppressions for the time being.
+	 */
+
 	static int want_auto = -1;
 
 	if (var < 0)
diff --git a/transport-helper.c b/transport-helper.c
index 8f68d69a8..f50b34df2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1117,6 +1117,13 @@ int transport_helper_init(struct transport *transport, const char *name)
 __attribute__((format (printf, 1, 2)))
 static void transfer_debug(const char *fmt, ...)
 {
+	/*
+	 * NEEDSWORK: This function is sometimes used from multiple threads, and
+	 * we end up using debug_enabled racily. That "should not matter" since
+	 * we always write the same value, but it's still wrong. This function
+	 * is listed in .tsan-suppressions for the time being.
+	 */
+
 	va_list args;
 	char msgbuf[PBUFFERSIZE];
 	static int debug_enabled = -1;
diff --git a/.tsan-suppressions b/.tsan-suppressions
new file mode 100644
index 000000000..8c85014a0
--- /dev/null
+++ b/.tsan-suppressions
@@ -0,0 +1,10 @@
+# Suppressions for ThreadSanitizer (tsan).
+#
+# This file is used by setting the environment variable TSAN_OPTIONS to, e.g.,
+# "suppressions=$(pwd)/.tsan-suppressions". Observe that relative paths such as
+# ".tsan-suppressions" might not work.
+
+# A static variable is written to racily, but we always write the same value, so
+# in practice it (hopefully!) doesn't matter.
+race:^want_color$
+race:^transfer_debug$
-- 
2.14.1.151.gdfeca7a7e

