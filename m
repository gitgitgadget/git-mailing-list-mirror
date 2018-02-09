Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A4EB1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 02:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeBICnG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 21:43:06 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43011 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeBICnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 21:43:06 -0500
Received: by mail-wr0-f195.google.com with SMTP id b52so6727753wrd.10
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 18:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEMC3MoVArnujRmxbZ4ZbMe0osjSG8GC8vkqxW61eF4=;
        b=shNZQ+Nbu2f4q1VSbcsVTcLFLoobmwaZXMXfq8gsyu5WHkUeL3CYTtEpE6cYpRn1D3
         EMcGAo3IvsJh57wCX4sT9O3Xjx5HvqG56qeaeYScTtkRUrwmoS7n9Pv1ArqO0u6EC74+
         ouS0uhhTJ9Yciqi08JPNWhbBb2Bi43pu6h9aFKWERafZFWI030C+6WP7x5vG2YE1d+vM
         V6AUxEVF1l/pEQfTT0p+fL65tw6DyTgSwU5YBijGlL1F6Slfh544dpeSc5mYkuRSlqUu
         f2Tpt0p9KeAzujOoylSU/piSPArXPq6Ze3pyULQ8uwhaovM6kv/F2TNqzxVQjTWF6geC
         oicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEMC3MoVArnujRmxbZ4ZbMe0osjSG8GC8vkqxW61eF4=;
        b=E7apxAvIT42HkYY8/bGPHd0ttW+LmAtGNF5/aOKMNP5TNVnBQUEJrkOtsMpLL3CZwe
         agMwrMGRyKKYU5NmJh0ZbJDbN8JXaGh7X+R2ouliRIMrjvOu/o3Sn6IObtWERkAGou+J
         IRwGAe7gun4RbmOAsgud8b4BtrDJzi0DWbl5ImzqXlu5Kw07bTMI2Vvdgv8H5zP/v01R
         Q/7N4HBJ/2zI/b9ORxz9HL330FPQlQiL5bJPhgk+rdrWBTo1hirWTGJ9c09DrLMw8G0M
         +H7gFs01oVPo3cUtS3lCj8xZ+OJ7lBiWAuiKaV72UldqCGEbgpaS2qdx02QqYWCxTlw5
         eXZA==
X-Gm-Message-State: APf1xPDQ1fZg39JkJDS1njKEiiXMm9mKRxeUGjXlxv/1L1qy7EL6FJkT
        0nEaF2Db5FZMdHdr52H8oSz2nA==
X-Google-Smtp-Source: AH8x227PWwbe3rjK34odTlvcf1E5oB0HHFKGAyy7ctD+pzBSG+YoWAzQ0rqKw0Dj+abFnNWq63csjQ==
X-Received: by 10.223.188.6 with SMTP id s6mr892090wrg.208.1518144184769;
        Thu, 08 Feb 2018 18:43:04 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id x18sm2226174wrg.82.2018.02.08.18.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 18:43:04 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] t: document 'test_must_fail ok=<signal-name>'
Date:   Fri,  9 Feb 2018 03:42:33 +0100
Message-Id: <20180209024235.3431-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.180.g07550b0b1b
In-Reply-To: <20180209024235.3431-1-szeder.dev@gmail.com>
References: <20180209024235.3431-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 'test_might_fail' is implemented as a thin wrapper around
'test_must_fail', it also accepts the same options.  Mention this in
the docs as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/README                | 14 ++++++++++++--
 t/test-lib-functions.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index b3f7b449c3..1a1361a806 100644
--- a/t/README
+++ b/t/README
@@ -655,7 +655,7 @@ library for your script to use.
 		test_expect_code 1 git merge "merge msg" B master
 	'
 
- - test_must_fail <git-command>
+ - test_must_fail [<options>] <git-command>
 
    Run a git command and ensure it fails in a controlled way.  Use
    this instead of "! <git-command>".  When git-command dies due to a
@@ -663,11 +663,21 @@ library for your script to use.
    treats it as just another expected failure, which would let such a
    bug go unnoticed.
 
- - test_might_fail <git-command>
+   Accepts the following options:
+
+     ok=<signal-name>[,<...>]:
+       Don't treat an exit caused by the given signal as error.
+       Multiple signals can be specified as a comma separated list.
+       Currently recognized signal names are: sigpipe, success.
+       (Don't use 'success', use 'test_might_fail' instead.)
+
+ - test_might_fail [<options>] <git-command>
 
    Similar to test_must_fail, but tolerate success, too.  Use this
    instead of "<git-command> || :" to catch failures due to segv.
 
+   Accepts the same options as test_must_fail.
+
  - test_cmp <expected> <actual>
 
    Check whether the content of the <actual> file matches the
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a06..26b149ac1d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -610,6 +610,14 @@ list_contains () {
 #
 # Writing this as "! git checkout ../outerspace" is wrong, because
 # the failure could be due to a segv.  We want a controlled failure.
+#
+# Accepts the following options:
+#
+#   ok=<signal-name>[,<...>]:
+#     Don't treat an exit caused by the given signal as error.
+#     Multiple signals can be specified as a comma separated list.
+#     Currently recognized signal names are: sigpipe, success.
+#     (Don't use 'success', use 'test_might_fail' instead.)
 
 test_must_fail () {
 	case "$1" in
@@ -656,6 +664,8 @@ test_must_fail () {
 #
 # Writing "git config --unset all.configuration || :" would be wrong,
 # because we want to notice if it fails due to segv.
+#
+# Accepts the same options as test_must_fail.
 
 test_might_fail () {
 	test_must_fail ok=success "$@"
-- 
2.16.1.180.g07550b0b1b

