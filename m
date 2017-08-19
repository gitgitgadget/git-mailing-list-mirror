Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4745B1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 20:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbdHSUNk (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 16:13:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34961 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdHSUNj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 16:13:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id j68so3416179pfc.2
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=I51EJi9d5nHym2pf+yQhriI/ssWGTKlubGlYoK3Jdek=;
        b=McStmhMfxuQUB3HnqUJ7C2UBIFVkSuFO3qrYELhkSYHxqBzZhwZZkvT4RhQ9pdcn/k
         QWz1s9t0GGuG/iGiWCEZejD6DXt3PnJhBpAl8dNfuwaYUMik4bL9BPxRtnMow2+tqL8w
         rbtLT1gtObMQUL1sDG50FpPlaDIESvVIyDNODqwa43BbW1zK3ylu1/vWsUZ75BJaZfIg
         Y8ReQp9v5c+tGJ9tcVNi7fqYajRa0PkIsg+pOwa/9UnLsSBxfvaeianflhpbr2BiA8pA
         c+UHhpSmpj14t1EX/VZdou09Iz4c+0g0WS45XLm3bMwUGkDWqourmwTEQ5QlVUsK98w+
         Rd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I51EJi9d5nHym2pf+yQhriI/ssWGTKlubGlYoK3Jdek=;
        b=tkkAOHhlWgB5Zt+v8aBLKk4bLUzf1n9qZWn9WA/Rm20hZFxuBh8yQI17bDYcFgMl2x
         +PhR+MODndk3Y9IIfUMn/C9qpXdXmQPWeNDrXOHF/zDS+PdxAqpOvUDY75b2cGazu4Gj
         FJt/XtMUVL7kBRG/BHL40v3ZgCWgas+qflnW2Xecta+0WP+HDthCAZybLgeZ82xSNlTl
         TzjYXmMWHq3+BRMqaOf4oGij6NhNz91I53RwLHy3wQnjHZ+kHmpeZlOUFAqeUpV3Z8rF
         x1WT9g0oL+kee4LeuB0+Tt0MFGxXqBMBuvLItBGCB2/AHjCSr/saAB6C3N2hh2R5p3b/
         9c/g==
X-Gm-Message-State: AHYfb5hBdIEDuuKVhfWDdEqmvA5jW7VZ3MT0PJmVFiRszElXm1Wej8us
        UBNtdPCNM7ytwX1hC10=
X-Received: by 10.84.141.129 with SMTP id 1mr8552330plv.375.1503173618919;
        Sat, 19 Aug 2017 13:13:38 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id l15sm14172681pgs.58.2017.08.19.13.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Aug 2017 13:13:38 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 1/3] stash: add test for stash create with no files
Date:   Sat, 19 Aug 2017 13:13:24 -0700
Message-Id: <20170819201326.6872-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure the command suceeds and outputs nothing

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4046817d70..f0708ced27 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,14 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'stash create - no changes' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	git stash create >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.14.1

