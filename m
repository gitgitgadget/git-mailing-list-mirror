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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F841F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441755AbfJQXRD (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:03 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:46201 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441747AbfJQXRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:02 -0400
Received: by mail-pg1-f177.google.com with SMTP id e15so2205619pgu.13
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e95ojsHm7vmKqMzqBTVWGVgpE6h9ehNY26fnbtBrNJU=;
        b=Lq46zCKjJVrActXn0sBQVwSqUQtGLJ7qb/Lk5BmEFX0GcMa26WWXLEIHmPtBQ2FDg8
         LRGNPrtvRfhbYwXLX+WFUeu6GdOY6hJEKd2R0LfVNP3Ei85f80WqNZ1aFVbWakF433Wq
         PVjb/LFaXEZu8vjC8+X/u6RgS861pLK+eKbnsJPOdxWct6Mdj1OdFxVWXepyRs7Y0n2j
         Hc4jm/LzHW729KDaf0qs18wNLZq1hULas1kbd1r1rpOd1GtuK0Od1KcLqhwrp1AzZy9C
         O9tpQNF46U+PwDww20GzBBgLA210LRb0WtpCRCP2aZlDnPaL0UMmw7EklPPEMoOKjUxV
         zXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e95ojsHm7vmKqMzqBTVWGVgpE6h9ehNY26fnbtBrNJU=;
        b=Og2G8ZMSnaIYBvV0YBKJ8W0ME2YqXXTIYJ9YD3NnGLCWpvFIpLArKwmYrkAijwDTGI
         fyeyKV8HpganTKF8EPtpjiUxRK293NFb2ml8YFNOH6cavOYRzmEnRfd3WwGFlBlfXiB0
         4F+dB0p8tdhQGmQnJuhI6Q+Xs5XeA0XiqhMjEANCfFMjyQmchKaWT27Z+DmRNhnpZ0vC
         OVb5hpSszWXg+ym3BvdIVNjJB4WXr9GUdM2EmEI0xJgb2v6jAw3Ocivk0Pf6OaAx+Omm
         nODV2TwXjVMNh1MSA+HXAj4wr4soVEqxk1jYj1OZVHvcsiYhxrWDCcxN/xFWrlM6/mww
         FswA==
X-Gm-Message-State: APjAAAWtrCDlvDTe804tnievNwBJ3cSAURuLWnCQxX83/QvgmxHvf+C+
        /cDW00R6hYfbqENqIohQYldE4pBV
X-Google-Smtp-Source: APXvYqymelu/gvPCuu1oq3Et19n/H7QRmG9Arp13FwbB/oiVvqk7m9YvCoCglPXt1+gFxZaULP2cLw==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr2894318pfm.222.1571354221092;
        Thu, 17 Oct 2019 16:17:01 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v12sm3305318pgc.41.2019.10.17.16.17.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:00 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:16:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 02/12] t5520: use sq for test case names
Message-ID: <42ce20d4f8daa9e166dfd681b39457222741f153.1571354136.git.liu.denton@gmail.com>
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
2.23.0.897.g0a19638b1e

