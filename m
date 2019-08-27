Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC51A1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfH0EE7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:04:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34189 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:04:59 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so43089929ioa.1
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IUxUkhQu8IKRPJnJfvXqpZRjIm/zAINbPLEtvMCz0aY=;
        b=D8B6rM7JeD6uBzEZt4cFSdJ20K+noeloMoq+yDUIYgYbov5YgNp/hxOBcoRQrpGTQX
         hAGBQCOTQPGLFmMnyXwKTfHyQt85/LF7v7LL2GNd8FH6bHGrylVMvTebKEZw/psQg/oQ
         ug1dk53h/QftfYL7wdhVYUrBokb6XIJC6L3+sT/9Bc55XfWfoRo0tFr+s/x8vzlZbK/K
         ObLLhOr1zAviPcf7/LyIOywaZ6vgbUbUs+iM2lozmBW14oOJnuCIbv5aXSdsFjMUJPsc
         eRAiGMCFaxu8nw40h4xpm4nuyl6xTpFoGhA8ioLKb+d3+2LqdVvCgVPrkSMmdBNddtq5
         34qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IUxUkhQu8IKRPJnJfvXqpZRjIm/zAINbPLEtvMCz0aY=;
        b=hF9/wR/dEVk15duSAwltu2eVJygl0mKzKHdxNfy2VAAY8bv725uhFwJZwidvZL8xal
         D/UVhWzNyxzCHphTI738w496XRuW+tPbJnbwa1PX3pavKIYHlW1p/r+Pg1orEm5nLk+v
         eQHOVPsF082sREbRqiXY91WKaCsTM5AOkBphaa1FGjVGOAMjaladl//zCzK8nqG2fjA/
         exz+lj1IYm+CY97HLdwVE/KP13maJi634Wd1x+kONOBXoweciWp+/JwTNv+ZmGCr6PiA
         c+KSyW843vidol8AlW066LF+sT9nMRWwsD1U7b+RDh2e5Kh+QTJiKWUD09D6Blebpe4l
         bXxQ==
X-Gm-Message-State: APjAAAUtARB3Byye0hCvVOK7oIeLKlL0Nt+G5vPjwcD6EEooqOFllr/d
        RG/GtUjWzf+FDdRAf1Qj5kbk546e
X-Google-Smtp-Source: APXvYqynhM0rjy8heFiavTnlO/SB2SSNtJluS5a6qJJHM54hd4Hq6GZhO4zEQ90Y62uWqw5qVgko6Q==
X-Received: by 2002:a02:cc8f:: with SMTP id s15mr21339898jap.53.1566878698152;
        Mon, 26 Aug 2019 21:04:58 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id s4sm17307384iop.25.2019.08.26.21.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:04:57 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:04:55 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 03/13] t4014: move closing sq onto its own line
Message-ID: <5c49703aa4fd3741d1685d25b647d775003f9962.1566878373.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention for test cases is for the closing sq to be on its
own line. Move the sq onto its own line for cases that do not conform to
this style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 62f5680f05..5e8eb6fb27 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -790,11 +790,13 @@ test_expect_success 'options no longer allowed for format-patch' '
 	test_must_fail git format-patch --name-status 2> output &&
 	test_i18ncmp expect.name-status output &&
 	test_must_fail git format-patch --check 2> output &&
-	test_i18ncmp expect.check output'
+	test_i18ncmp expect.check output
+'
 
 test_expect_success 'format-patch --numstat should produce a patch' '
 	git format-patch --numstat --stdout master..side > output &&
-	test 5 = $(grep "^diff --git a/" output | wc -l)'
+	test 5 = $(grep "^diff --git a/" output | wc -l)
+'
 
 test_expect_success 'format-patch -- <path>' '
 	git format-patch master..side -- file 2>error &&
-- 
2.23.0.248.g3a9dd8fb08

