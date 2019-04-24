Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF771F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfDXPWc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:22:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfDXPWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:22:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so16860722wrs.11
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31c7rAJt6cJ+W+3maSeLevzAhwl8l0y967yCbhvjXr4=;
        b=S9Tn+weWyLs3fLiuLqDMha2MegxnFVrxxwwTnHd8ZR0zEr2TYX8VknuxcZyS2n5hvv
         pf04DxXwxtr/E/ugxqnrFq7jKygqCzaiQDpBpCWVvVOt09AIbG6hyH32Qn02HG/c9fj9
         SWl6wcCOPkCNS4mIJDJV1VPQ1hhsD4oSQGyLGdNJoWZ4NCUVFIyzr8yOO7BQ/TfTuPm8
         0d9ZCNhTn0YSYg/3PM6R7E7aw8gRbqkmkMZj0605ScPn8Nwwr/LrYXcopssxMsTJhAHl
         aZ8ThUOTJ06FwclmhYOQdMgepgMV6jKJN8MJ7S2D1MmN3R11YNwarfz8uPWvmE9BOhvu
         10aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31c7rAJt6cJ+W+3maSeLevzAhwl8l0y967yCbhvjXr4=;
        b=EfoZOiwVmAvadGszPhtEHICybyb5AqmZfP4s0H8ech2b2HAsqbsptfuYg6FYWkL8BR
         hGQ/m/WPRJ0N5SpiDGCkEat1z5aZB3GN9Rx4zU4U3Z0lG0RiRZB8aD1m6wEAyQC64NFb
         /g9eX9CaIvNZ9aamjeG3NyaPGJhYSN3k5caFVITiEoEBVVVzV0qHhhf8gjMvLpk+5x66
         mBcFeODHBXRxtlOK5KHl22xRGUIivk8GJkjwtkxwSqwmKfvEVIwbuthaZAj8cTPiF0QI
         TO607v3SFemC+qP7gWXMMcoL/Usrqf3kcsEkAlF6qrafvozimjDbNVRZOE+8nig08QyG
         d/0g==
X-Gm-Message-State: APjAAAVyrZju2Lr1cFq554HD/xym34fchkuPEViGjray4TXzlwgq+IQ3
        wjJ7YMG7P41yCyRxuiUVKCtwYF27
X-Google-Smtp-Source: APXvYqxEOvhSuTXDkOFEErfZJkTujDsQH2rKQp5YYdCOv+7fs12jWumiJfRKVi3hQspW4H4PQtGFJA==
X-Received: by 2002:adf:e908:: with SMTP id f8mr17552wrm.267.1556119349098;
        Wed, 24 Apr 2019 08:22:29 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d187sm3289802wmd.42.2019.04.24.08.22.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 08:22:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] diffcore-pickaxe: refactor !one or !two case in diff_grep
Date:   Wed, 24 Apr 2019 17:22:14 +0200
Message-Id: <20190424152215.16251-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190424102609.GA19697@vmlxhi-102.adit-jv.com>
References: <20190424102609.GA19697@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the code around processing an added (!one) or deleted (!two)
file in diff_grep, which is used by the -G option.

This makes a subsequent change where we'd like to munge the "one" or
"two" "ptr" smaller. While we're at it let's add an assert that "one"
and "two" can't both be false at the same time, which is always the
case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a9c6d60df2..3c6416bfe2 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -45,12 +45,16 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 
-	if (!one)
-		return !regexec_buf(regexp, two->ptr, two->size,
-				    1, &regmatch, 0);
-	if (!two)
-		return !regexec_buf(regexp, one->ptr, one->size,
-				    1, &regmatch, 0);
+	if (!one || !two) {
+		mmfile_t *which = one ? one : two;
+		int ret;
+		char *string = which->ptr;
+		size_t size = which->size;
+		assert(!(!one && !two));
+		ret = !regexec_buf(regexp, string, size,
+				   1, &regmatch, 0);
+		return ret;
+	}
 
 	/*
 	 * We have both sides; need to run textual diff and see if
-- 
2.21.0.593.g511ec345e18

