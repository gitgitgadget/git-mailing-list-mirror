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
	by dcvr.yhbt.net (Postfix) with ESMTP id D67941F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441785AbfJQXR1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34334 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441771AbfJQXRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so1892840pll.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LLSfm2iw8r4CHMZLat9inGUJHn1GnNtHa7JD/dweGWc=;
        b=ueu1546bw+bZOkgnJ8uX1Y/DgXQqdWB/RXeQfIWi/VIlkzbmXqvmsqYaQ0FdvZoaiX
         /z46uhBigGsKatZ990xDV4CRpYqClJvHRsD03riULN9Rvai6EAg/8DMedn0uoi8bCPCy
         Z9ckWUN2snFr/TBsiNl8k0wa3MpJEzCWjIuwoz0wTJ/leO6vLiEVCUEp2P7sJvQCq+cU
         psTVcKV+lGAA8wie/e47j7xmaAk+FKrvkqmIzTudeCcbOwTDFa5X1mGojuQqOTtcpuQa
         7oKgTk9zDrTjTyMvxHxVV1yv2goehshE221V9vFsCxxPfVKZER9ErxRIjxbhs8QNKHgx
         jGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LLSfm2iw8r4CHMZLat9inGUJHn1GnNtHa7JD/dweGWc=;
        b=moNSoGlE95/Fhd9+RCAkkaj9nYqXXma8ZttncoVAPykGFtezKo7Puwn5+ITl2lZFjM
         Rn8KIUNpAZMfruH3a8zg8sijDdVKuoqrZkrmenfFrV5MWA9t88S5vmxqjh9oh3PC5naa
         6JStPf90/fIy8hAHyiWUMFK2jCgpEzGm+R88q6xiYXu5oiTBOWUczHMjSbuxZN1SXnQO
         Bwmg+Nx4stWi0nM308FttFia/EYi6UZGfiOtP1PmjI1cGlCIxavjhaZTNefb97gGuBF/
         FV7c66nWpug0G0tuDBprdU0D7y1mYrdi+5sdH74ynhEM1Aa+rtmqtsKuQqPlz8hljaIt
         Z/Ew==
X-Gm-Message-State: APjAAAV0SxpNEm9xU93Q1j5vWbzEfgAV9d4YKwO/2G1SlmNX2h9/Fgww
        XfPpx9bS95duvKVscCpuq8YqSMJm
X-Google-Smtp-Source: APXvYqwSu3B4ncVJVbBJGxdotBrygt08T3WytpZJnw3KQeM8TQ2CU9QFhsskf+RYZOPyruTFRnzcgw==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr6316399pll.317.1571354242557;
        Thu, 17 Oct 2019 16:17:22 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id l22sm3219413pgj.4.2019.10.17.16.17.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:22 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 12/12] t5520: replace `! git` with `test_must_fail git`
Message-ID: <4d2bf64cf8b2e51c36808e0784b96575ce89b656.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if a Git command fails in an unexpected way, such as a
segfault, it will be masked and ignored. Replace the ! with
test_must_fail so that only expected failures pass.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c6425d20ab..0c187b025b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -543,7 +543,7 @@ test_expect_success 'pull --rebase=i' '
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-	! git pull . copy
+	test_must_fail git pull . copy
 '
 
 test_expect_success '--rebase=false create a new merge commit' '
@@ -578,7 +578,7 @@ test_expect_success REBASE_P \
 
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
-	! git pull --rebase=invalid . copy
+	test_must_fail git pull --rebase=invalid . copy
 '
 
 test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
-- 
2.23.0.897.g0a19638b1e

