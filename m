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
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7E81F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbfJRWLB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:11:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34118 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390953AbfJRWK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so4696135pfa.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vbU+tuIsOpgYa0UzYuQaWY9s/mlIJVUzw9cPvnNUHZc=;
        b=AAUjCyvwpwju6qSSkLLZj3FGlBl2xB6oStUPXNjALZGyQHxs2gQuJXTPW6vtGH6Sbi
         fWIE79XuYHtoJjd2qV0gmfknSFKWptpDGfbEZ4vOHYkiTyqvAsu1Lp6Kx4hnGj/C5+S6
         X1ebSWWqxk86TXe01agZvsacY732kig2GXWGCnB6W7SBuFgV5C+zt1exIhHV49MQpRet
         viYfs9t7NTsAqal9N2SVAt90TgmRMgh1+Ti7HZBy9F4QY7femZcx5yGTwbpi6f8TUoSG
         oG38NY+76hQBFxgxMYEUcDd0DRHrUhc68TxxCIkqHLnNxnddfQiT1XhFqlsEHppKPIMx
         2sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vbU+tuIsOpgYa0UzYuQaWY9s/mlIJVUzw9cPvnNUHZc=;
        b=oKhtIRh99stgHo5JfFaYImdFXvb4ciWMWmFyJaw7QJdoWxktBqGf7HH6SJpexu1Ig2
         5nEpmYW94UFbBSoOTxYGgl1VLD1vkd0De62dafb6fM9PAyzl1mRVUc9xsaQRL3tcWcCo
         BtUeKHaV2fhfDEAkDlYzShHwTjv9Mi3UV0YwLjh1AGO4E2Zx0XWJogRK/qCpCbL2kf8+
         Wgo5RhVxrHdmEPpcpCiecZsaPh/ENJm79TKIyI4DNr+CznV7AmmfjgG03WgUliJ0xl+n
         sm6mZuAMqbTJud8UmtCKHykCFU8P6NZVQcHyJvRyK8J5HSTijTkKfB4sE/VvA/UyvHJb
         jpbA==
X-Gm-Message-State: APjAAAWwpac2mRAM0831+SBqVGnqXQ67i0Yz2d2hmouQDzH7pNg7a4fY
        hiFD88cNxvgu9PJP+1GhmZnbxmf5
X-Google-Smtp-Source: APXvYqyiPlfG7gpnsw/U7lh43Z3blk6Xy/Ed32suNFnizT+gXB4jGjxva8j/u4WOcaxC1PBA2Ypvtg==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr12534758pgi.221.1571436658303;
        Fri, 18 Oct 2019 15:10:58 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id e192sm7438548pfh.83.2019.10.18.15.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:57 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/15] t5520: replace `! git` with `test_must_fail git`
Message-ID: <2c0d3ac416ff1373ea74514e36a1a8f9afa2ff2b.1571435195.git.liu.denton@gmail.com>
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

Currently, if a Git command fails in an unexpected way, such as a
segfault, it will be masked and ignored. Replace the ! with
test_must_fail so that only expected failures pass.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ef3dbc201a..602d996a33 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -537,7 +537,7 @@ test_expect_success 'pull --rebase=i' '
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-	! git pull . copy
+	test_must_fail git pull . copy
 '
 
 test_expect_success '--rebase=false create a new merge commit' '
@@ -572,7 +572,7 @@ test_expect_success REBASE_P \
 
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
-	! git pull --rebase=invalid . copy
+	test_must_fail git pull --rebase=invalid . copy
 '
 
 test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
-- 
2.23.0.897.g0a19638b1e

