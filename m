Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F411F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfKLXHy (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:07:54 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44270 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKLXHx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:07:53 -0500
Received: by mail-pg1-f179.google.com with SMTP id f19so12834675pgk.11
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oSrojMf3+BES92BaWjK0RNprJweNs10MtLPkvj6IVL8=;
        b=Jz6w1LpObzR3JAxiWR12LJqYbrqHXaTw2QemEHPDthG8v/5ZIFOh4b0DUN8MK4i+GK
         C/S56AqJSaZRukFc1fvTdQ0lB/jfMh9MH5uQb6TaTlA1onLz0Nfn/SA4m7eD0JwE4f5b
         lt8u934xhgBgUyp4l6R1iGEd5bteeXmYZ9WmRSnLV+4MrrLQD+JZRP58vfK92gH8LAcM
         7vODIkEhcZZdiZlJI2IbezraDU9sptikoYF8NaENh/lcDU8jgVmDut0F430gMxxrrB+c
         awPY7aiykqR+BNnkAPjIXqkVE/o2SbwyvfrUfprBBi3Si08eBDXajQkXRVUEGhQOJX+r
         TgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSrojMf3+BES92BaWjK0RNprJweNs10MtLPkvj6IVL8=;
        b=nBky3wuGvrygybgwRzrWtZ/brAqEqz/GxQa6fBycZ87Z/bIQW7filkEcJdjvA1FHP4
         TbE4LFSUeYlU+ofI8K3aVExO8hcKtcE4H0LKxN4s8q7jxhSnp1+mVFP1KBkSjIDUuM2y
         X2BnrMN9pVATvF1Yj+V0C8iSFqiOSH8i3skR2u5vdEYT6QMj0AViu0AfTg2TUj/zoUPy
         cM/5bvb/mf6lQ3KDWF6qWyIKLTNhBbuYa3hFSkVDsoxYmMhcEMqG7De2wrxsZtoF0u3+
         rP4U5M/H8pDqIl4D+B8fnVoZEmhhA9JOsq4ADFUyDGdm1dDSVvR1pG04Fdhp7RBTxNQJ
         FtgA==
X-Gm-Message-State: APjAAAV9tMm7meTtRz8jOMbqMrPtDPo6SgKnSLFXwxTxZOQuhA0PpZw8
        whzO1J3moZTqD35C/364q/LnO43i
X-Google-Smtp-Source: APXvYqxJwIzKVE+ahehD7xuVAMhBUKU4v1b7Ytgi7H71ug+DTzMp/gveTA3lwpEYhvFgmVl70mJOxw==
X-Received: by 2002:a62:aa0d:: with SMTP id e13mr517565pff.214.1573600072596;
        Tue, 12 Nov 2019 15:07:52 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id e17sm67585pgg.5.2019.11.12.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:07:51 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:07:50 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 03/14] t5520: use sq for test case names
Message-ID: <99b0fb0e1c729090ad1d0e8bf5e6eb1d1cf4679d.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
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
2.24.0.346.gee0de6d492

