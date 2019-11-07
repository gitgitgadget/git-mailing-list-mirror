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
	by dcvr.yhbt.net (Postfix) with ESMTP id 733011F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKGSv1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:27 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38019 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfKGSv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:27 -0500
Received: by mail-pl1-f177.google.com with SMTP id w8so2142376plq.5
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSqRXsx6ge6yD5iZlHZp/xY3kn1TsjFuBzDc1t+lOtw=;
        b=oFdLrJ+qwbanW/IzzFVafFe0leTB27ZdFMdDmWGjkKvvmNiDCqRjnrjHyNAFJjHl/V
         YFnmysG1wfjcLRS7/7dCRvoSurVDc5PXpO2bRDNrpC1Dvd02ltwc7db0aRnslPRe8tM+
         YocY5+2OUJJJ58KCzkj6XbiM1FdlZSfBsn5YWaubwSdOMmXwf40924RTMiVEtdfOq5bG
         Uu2ItNCrXiCjOqvRSe4H9nRrh3tvOFc5KYZKmjahHFvH4MmAmBvsscljGEdoqH0bqQo8
         QrJ06V67JRICA1Qbb6H6YD1lEI7Hh+HkCj4n6Ez5N9T1ozilMNI9aHcuOhi1Xtr4bcOX
         oZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSqRXsx6ge6yD5iZlHZp/xY3kn1TsjFuBzDc1t+lOtw=;
        b=CHrIdddCo8Gb11U9Xy0sEditmYAjhRGcEyDc2H/xN3E9lvMfopHqYmuL3McC9800Bx
         IzFpPKSynBqOcn365wRty8CQsQZbUyJdGYboRqkvnCZB/BTiqDRY792hkT+ml7b34foY
         W6p2tckEB2HyovDMLRpsrD2xAdYySgFDAYV1dsOBBtDcg7teR/oiBtaZVjB7qByPGTQq
         IwkVJlCMxa2rJrSoQixlC6H5eERtPdtvj2dGG2gLugoc4jXy+fdp6jxWdU0sVQWh18me
         MarSS6wTLv7sF12FYbXKZRfZ5IT6RKBLrxfYwPYGuBKVrPrOPo4fDTZv4ogOofKkg9xJ
         KaaQ==
X-Gm-Message-State: APjAAAXbC+oyVSUL9gEi/5bQGDLUQ6kT+eWXIvTf2yruDWe03AHDZEJG
        zRAC2yeyxwyhUL3sMbpiNHZ8gEY2
X-Google-Smtp-Source: APXvYqxMFtkB+yTgpDccBKaRUkqadfA7ux5XiH6qU1rHDI5v9JwLI0WezTxqCW5lqEXmTIlNFqDLkw==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr5226021plt.160.1573152686101;
        Thu, 07 Nov 2019 10:51:26 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id f189sm4393018pgc.94.2019.11.07.10.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:25 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/14] t5520: use sq for test case names
Message-ID: <ea06a1db3d4674880adb76515967d7052f3941e0.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention is for test case names to be written between
single-quotes. Change all double-quoted test case names to single-quotes
except for two test case names that use variables within.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 51d6ce8aec..a3de2e19b6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -408,7 +408,7 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_success "pull --rebase warns on --verify-signatures" '
+test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
@@ -416,7 +416,7 @@ test_expect_success "pull --rebase warns on --verify-signatures" '
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
 
-test_expect_success "pull --rebase does not warn on --no-verify-signatures" '
+test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
-- 
2.24.0.rc2.262.g2d07a97ef5

