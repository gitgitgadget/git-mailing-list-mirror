Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2191F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 03:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeKUNpt (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 08:45:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36639 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeKUNpt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 08:45:49 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so6914788itj.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 19:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R/l9Ek09d8csr/QeoHxAOYGq+Sr7RpHF3S4l/w6itxE=;
        b=kh6rh6FDE6DrnO741Tc/tRKLmYtLVswbqo1kaGTUQ2yWEL5ojjLbIhsmoj/yGq/A8t
         vItO9jUkDoiH2p343soVXUMKqkLSRz/x0J+PsbH4/ei2NbbngLGZCcBdbAllmcgtDh0j
         owZuWW63YIi0cOY8yElsteFo06kvAxPNJo3j2YH/xFIYLv4f1CVcd8z0wRbdvIsswrzU
         v2sBfsWCyUWFWTT7lwHzBGyOKfprHw3sA6sOjJ5sFA19TXEk69dSUjkoaEJN+XZhscA6
         YC1UgtMiSh6QSyYRK50stlrT6mWv2wsrZvdvcpA8wdh+nIoRF+WFEo6Wy6Zd+yuoWMpo
         2WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R/l9Ek09d8csr/QeoHxAOYGq+Sr7RpHF3S4l/w6itxE=;
        b=ogULx+RdvN5sSCtLOsSGOkNMz8uQZdb21FK3a1+JYBSpgXU6UQasp+oKGw+UGILbV1
         PX9W5/NOAKt3Wf5b0SjXNNsDuzEsRO3YJvSRWeIfh8nCPng6g7QjicyoDKtkPAaCEkyQ
         n8mPOvLpN7mWMx3qeKPytrIsFZ/PtL9yM+T9ix5BqCBXPkpfgafRF+N47gV4jaSrUbpl
         4GczjINy+ZhShplNzHqPLgOX5f5Di5/HMHOgsaVjC4p9sbD/O79kVqNFN+ByvmlBOkFG
         /HNcN3tCA26ANz/RuXAfPChbwxCMAiPlMfMZT3Vs0CBFboTUk3vqf+mNgy5vl1dscJHk
         J9Sw==
X-Gm-Message-State: AGRZ1gKNhrHdATFrHSrX08DI3mhCPJHZwsN8hE0dnhGMk4WBkieccSFX
        mheKN2yVl+Nsc9a2dqTL3/p3orZL
X-Google-Smtp-Source: AJdET5fcMdRu9kumGHw7crEoNdd+nUOMonLtVJ0kvykcUM3xwkJvzzjtelfAqKqujlH7aRoLVE9Pig==
X-Received: by 2002:a24:d203:: with SMTP id z3mr3948335itf.156.1542770000569;
        Tue, 20 Nov 2018 19:13:20 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id d12sm8492986ioh.44.2018.11.20.19.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 19:13:20 -0800 (PST)
Date:   Tue, 20 Nov 2018 22:13:18 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 1/2] t7600: clean up 'merge --squash c3 with c7' test
Message-ID: <efa96543f6bad23830fba1e3c82b070769a946a3.1542768902.git.liu.denton@gmail.com>
References: <cover.1542496915.git.liu.denton@gmail.com>
 <cover.1542768902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1542768902.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cleans up the original test by removing some unnecessary braces and
removing a pipe.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..d879efd330 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -233,8 +233,7 @@ test_expect_success 'merge --squash c3 with c7' '
 	cat result.9z >file &&
 	git commit --no-edit -a &&
 
-	{
-		cat <<-EOF
+	cat >expect <<-EOF &&
 		Squashed commit of the following:
 
 		$(git show -s c7)
@@ -242,8 +241,8 @@ test_expect_success 'merge --squash c3 with c7' '
 		# Conflicts:
 		#	file
 		EOF
-	} >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
 	test_cmp expect actual
 '
 
-- 
2.19.1

