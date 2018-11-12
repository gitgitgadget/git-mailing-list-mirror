Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748031F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeKLXl4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:41:56 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41456 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbeKLXlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:41:55 -0500
Received: by mail-pf1-f182.google.com with SMTP id e22-v6so4357841pfn.8
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X3VZ2prIFW3RKJU3/gaqkbuQJ1Wekj+1eq8/GZQxnb8=;
        b=MEiomhggYiMQUY1O6eYVdk2uhK7yhMFTtTwVdtL5hoXHKnkrV3HoagGPB6IO+ilgRq
         n33/QYVImJOxVfH8YQO/B4EYg5TKpk5owKPwatR1Q+8QbYYwjFlbRc05MYPRJbgLwY+T
         0H7XXvH5Kfrfie3QdC3lsu97Vu2CoXVDYKJ70v8C8s3tvbnfbQdSluCVzlPjQDQKSG2u
         9SHxqrrhWBWq0ycV5+4fCHwKWg9gBvBaaO3TABjUebvAoydDGtDIF2/Y3qRDAMeglmRe
         hEeItYYQtfIFuHOEgtYgBraRZcuYXp4wqjBl3az9bmmbRSfPAHBXeu7YSWOgeTpCTJVW
         vA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X3VZ2prIFW3RKJU3/gaqkbuQJ1Wekj+1eq8/GZQxnb8=;
        b=qy43RpPHOqrWc4GeEWmG2zQpVIa7bD9GZ6kB5OKQOzvBHnyiv9T/EBwPaGfOI8FeYA
         JB2/0kmqge3qtcRPPGQ0AgUJcbemDVwKbjRssbsRatlI4RVpCriKoS9wdliaS04EEGbz
         ZcJlmcudZowpshsCiRYFUaglodgZH0lrC8qCrK++bVn0FODYmQ70iPruclbzCr/LUlay
         UYRm3GntAko8eKVaKtwC1H8X+n5ZM6CDwk6PI/tWvzB47PtEsGB+OlzFZt2sULhDFoD8
         /tyy0S7JEjaxj155k8HebdLpSqt7+56qXO+7NSxatiZS/egtLaktbzlgL+oh4oRJ38SE
         dGqQ==
X-Gm-Message-State: AGRZ1gIoNgZ/NUYLd/DvAXKnEBSV+KBAdnsCHHwMQXvPEVIEvKpXoOkX
        RBC11eUcOQUfnsAGTOfdgfSYLWS1
X-Google-Smtp-Source: AJdET5edjx4yi1YSI8gE0lHf/Jji/8bFC67H7DAyd7glmaOnNVc0rXfRsqSnXosxwZ7FoU7SB4U1Gg==
X-Received: by 2002:a63:235f:: with SMTP id u31mr908105pgm.122.1542030513932;
        Mon, 12 Nov 2018 05:48:33 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id r83sm3151184pfc.115.2018.11.12.05.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:48:33 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:48:33 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 13:48:25 GMT
Message-Id: <2b04f9f086e0361345fb38effd61a4b1ef4ac22d.1542030510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/5] tests: fix GIT_TEST_INSTALLED's PATH to include t/helper/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We really need to be able to find the test helpers... Really. This
change was forgotten when we moved the test helpers into t/helper/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 47a99aa0ed..832ede5099 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -957,7 +957,7 @@ elif test -n "$GIT_TEST_INSTALLED"
 then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
-	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
+	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
 	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
 	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
-- 
gitgitgadget

