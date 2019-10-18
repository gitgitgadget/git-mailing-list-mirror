Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1185F1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390779AbfJRWKw (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39129 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390733AbfJRWKv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so4082349pgn.6
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=thwPGOD7mKEo0w/iIlnc1rVQeffLBQTg9Iga9wO9L14=;
        b=Xjnr4h8yqo7+aC0N8LTooE2O7oFlt5RjuGoMxW0wajX2pbgIyKaFOvvLnAoMTeXtDy
         tIO1bSPs3PjP79KZ/JX3/CKrUADxWUeQa4lXenKvxfRS4CqW8M+NXO8cN9TgbOVCdosP
         39gKdIenP2II5+oWOy8GFqWnXL9ZGOUzmumEOLSos4i2bbEWzTsO5U8ipfvlVIsZIRGX
         vjR156bXzr4eMyLd7JNztc4r/x92og66dBBmp5nNVl5YuZ0onYVPjyEY3oxeRjleVOvf
         9wBWNc/b6wSNkFm+m+rL6H2Rpb4uu3YQzZw9lV4IplP4vjj03Kg2hQ2hj5s2fxKVd+I5
         MQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=thwPGOD7mKEo0w/iIlnc1rVQeffLBQTg9Iga9wO9L14=;
        b=VEiq1DHKfEFw9ytOOXsdoxv5R2+wJv0Ri+FtB3BA2/aBlPGG4kb4PSZ8pEtHfGI6UH
         bInHbWcWGcDJm9HjqP3NcweLr/gAaZyGzsU2BcwDcTfUPG1x42x5B7T+LWrKObWlpMly
         MBBEVBU3dxZZZvSumH14ePRUc5KWKoTBekaOYNAbiS7jzwPQbmiTarRrj3djKl5Bo6iB
         GxjFC1W/Lhyg98+T4G0SwgAElwuDmuHsrD6B2Hic9rEXvv7QPDBAu64tg3mpq8wDXHGK
         rKTKClxd+K2PyxYByoSAQdVG1e9UY2hK+c927M3N7C77SsyrPIZovpWI8RvwxyiixfbA
         VpZg==
X-Gm-Message-State: APjAAAVtY5b37Vxnjq3U75QBiE1frnyfq4EM+a8NvMivJjcO7k6zb4AK
        xDn/JL9z4PQLBpMgIOyzvdQ/jmPA
X-Google-Smtp-Source: APXvYqwlyoJBFlV3y3gwK2BsiLRZl0+HSQkdoMZfkn4JbyjeWd4imUdxL0sAcpD3gCkO5tW8ToqOjg==
X-Received: by 2002:a63:1242:: with SMTP id 2mr12258893pgs.288.1571436650212;
        Fri, 18 Oct 2019 15:10:50 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id s73sm6815612pjb.15.2019.10.18.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:49 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:47 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/15] t5520: don't put git in upstream of pipe
Message-ID: <0cfabb201c5a79f665e79252edcfc28aa3df59ff.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, if the invocation of git failed, it would be masked by the pipe
since only the return code of the last element of a pipe is used.
Rewrite the test to put the Git command on its own line so its return
code is not masked.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8b7e7ae55d..8ddf89e550 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -668,7 +668,8 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 	(
 		cd corrupt &&
 		test_commit one &&
-		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
+		git rev-parse --verify HEAD >head &&
+		obj=$(sed "s#^..#&/#" head) &&
 		rm -f .git/objects/$obj &&
 		test_must_fail git pull --rebase
 	)
-- 
2.23.0.897.g0a19638b1e

