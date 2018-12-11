Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85EF20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 21:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLKVVw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 16:21:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50442 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKVVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 16:21:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so3749293wmd.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 13:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xT00o3JXqSxbPbtNIMBUG7zizVMO7INjVY1027kYa40=;
        b=TO65SDMCrFroIfC9jJcmliS/AZvlDS5yC4/r9nli7Gmm7dzNvx3OkeisywaCPHy1yf
         kdsyblHs6byiK0iZvAzM2ZtEOasRDInDI/PE1qodhThqx4yS5dwp26YbVyIQRgXlPZFv
         78l6JIHiJ6abNSohGEiLF6VnAoM/4MsgF7hF+Wr+E53TPH/iYvC2Ymmi9AGxtYvAP7t7
         Ofgb69mX7RAgx2YeMk57rv1p2Dx9L2+DhYCBAWs/CDCfz3m1yd7lo54quUG45dZ3tRvR
         IIymQPOqr225iAQ3OQB2a6Ze8TBRf2W55G0Q7fWk7vgaaeQz0FKPf3tr8TAKXwgoFnlH
         Nflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xT00o3JXqSxbPbtNIMBUG7zizVMO7INjVY1027kYa40=;
        b=s7YUB04+z4kR7ViD+JZ0qsatWWZYXlyzf2f5XcBRnUpPqU2hZfIR5BsrIFhoTZ3ZyN
         n6xzQFDNvtf2GQHLiP7RGpGq9zT4e8WUFeJqGRKfYlzmUdj9sshm7qE14OvcFKk3VSHz
         wJj9XObWhekT+uu4Gs/qoYSqjvRCDN2+TycZAIHrRmAHQF+F2Z7SyMNk8eYQhmQY/OQO
         ACR7Sld9XigMGxhyFdvFkt49Eb6IykUUtpv2JgF7BjaDDAkZlKOa/0G9WiENfeTXLdk/
         1RX/undCI4PZnjHBi76wqWmexHmAwSZGPD31w3nBV1pMsbT2IjtKYKRsRXCIGNTCrGe8
         rGgg==
X-Gm-Message-State: AA+aEWbmm+1pYSWZ8gjrpSdvhnVImqzIHAUKQpnZzzTiCpcVXJGvAZ49
        u29Y0RMCzOcJg8aC2NzSe0rSvrxj
X-Google-Smtp-Source: AFSGD/VQuX9zBDoUFYj4SV8MntPrNFPN0mwuEs6+NC4n+W2a3IvZG7ceq9wIpATaNAcahEbu6RkOPg==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr3909299wmi.140.1544563308159;
        Tue, 11 Dec 2018 13:21:48 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g198sm1698118wmd.23.2018.12.11.13.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:21:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] tests: add a special setup where for protocol.version
Date:   Tue, 11 Dec 2018 22:21:33 +0100
Message-Id: <20181211212135.21126-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181211135501.GA13731@sigill.intra.peff.net>
References: <20181211135501.GA13731@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_TEST_PROTOCOL_VERSION=X test mode which is equivalent to
running with protocol.version=X. This is needed to spot regressions
and differences such as "ls-refs" behaving differently with
transfer.hideRefs. See
https://public-inbox.org/git/20181211104236.GA6899@sigill.intra.peff.net/
for a fix for that regression.

With this all tests pass with GIT_TEST_PROTOCOL_VERSION=0, but fail
with GIT_TEST_PROTOCOL_VERSION=[1|2]. That's OK since this is a new
test mode, subsequent patches will fix up these test failures.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 protocol.c | 13 ++++++++++++-
 t/README   |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/protocol.c b/protocol.c
index 5e636785d1..cb58cbb29a 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,7 +17,18 @@ static enum protocol_version parse_protocol_version(const char *value)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
-	if (!git_config_get_string_const("protocol.version", &value)) {
+	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
+	const char *git_test_v = getenv(git_test_k);
+
+	if (git_test_v) {
+		enum protocol_version version = parse_protocol_version(git_test_v);
+
+		if (version == protocol_unknown_version)
+			die("unknown value for %s: %s", git_test_k,
+			    git_test_v);
+
+		return version;
+	} else if (!git_config_get_string_const("protocol.version", &value)) {
 		enum protocol_version version = parse_protocol_version(value);
 
 		if (version == protocol_unknown_version)
diff --git a/t/README b/t/README
index 28711cc508..c5762a92bc 100644
--- a/t/README
+++ b/t/README
@@ -358,6 +358,10 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
+GIT_TEST_PROTOCOL_VERSION=<'protocol.version' config value>, when set,
+runs the test suite with the given protocol.version. E.g. "0", "1" or
+"2".
+
 Naming Tests
 ------------
 
-- 
2.20.0.405.gbc1bbc6f85

