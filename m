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
	by dcvr.yhbt.net (Postfix) with ESMTP id 240B31F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfHXI07 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:26:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38628 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfHXI07 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:26:59 -0400
Received: by mail-io1-f65.google.com with SMTP id p12so25686971iog.5
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Il9LwpJVzdzduiFquLf1KD7uEGxhXQfU8tLcnW9qImI=;
        b=a21Q9jZCXbISplxvD38lUKYJcKXrVa8LXqbTwOL2To4mYQL8jCMRqqppEFkua1Vk7/
         mGQc+yXP8c+wPRI+PNImgLIOk/WO4HXGYYUdOZLknLYxcyh7wd87zePhrNdpbwJLoUfg
         oGkQqSVG9tRknVlTQKnjY5odovJ9cFlGRQaKezuoOztnAnWzNgxQv7VwIRq4V8PmcHxq
         3QgEVWy+xQz+aj9y+FzqohKOLt7TikkN8AlC30TC1X4evAfvGVca3Qh9Ngy99CgMOcAm
         qMpcJOZNerTvN8U9dZK93fAqcYjopI8oB6ThBHivOB4N+3EG6IytvnhlbVsImbv0h4HR
         Vmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Il9LwpJVzdzduiFquLf1KD7uEGxhXQfU8tLcnW9qImI=;
        b=HQN3YSs6sj0OBL7y/3ZitNl/WCZDTQgh6CgcmSrpOROWVLMQXu0yyrPtkCzlMiDgQ7
         28flYqj15ihBYvHzbL8X+UHkaG4JprZa0hioanTDhBlZOrCuw+XwmOcLrc16xbOn8fyP
         eXSZNxRz3YweVKkzRErJ/lS7UYSk7iKhEKFCLeyJrmUtlVC2ZxS0FT/qkniHuCoWfTf8
         FJ2iGNXaaFR0JOziybqJc7V8RlaF8IW36K2MsEEK1Yk7aZRRGtEVbvXWsiCqWduuVMku
         vk0DMGCv4g5qni93/tb0y0YZEnON105zCrWfUAwAW05k+NboZpQlyLYbQ8ComXyQHYFo
         RYzw==
X-Gm-Message-State: APjAAAVr+IiDy7W0JQc4CE7Nd2ZG3MqyfjgXGeH057XMxRt3Dc9KXAyO
        fAl/HmYGYXrGaEJKYIKseyaVTQaV
X-Google-Smtp-Source: APXvYqz4EdKHEA5LwJmuo2Czoq7QULynGzQ5EmSO6mGtlwVv+gfCZhgDeXOAXfgyUplrIMj6OHlqzg==
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr7138446iog.255.1566635218358;
        Sat, 24 Aug 2019 01:26:58 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id l6sm3729078ioc.15.2019.08.24.01.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:26:57 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:26:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 04/13] t4014: use sq for test case names
Message-ID: <02a11147fd016be4f0933cc30a759cb688506f4f.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention is for test case names to be written between
single-quotes. Change all double-quoted test case names to single-quotes
except for one test case name that uses a sq for a contraction.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5e8eb6fb27..a7b440b003 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -58,20 +58,20 @@ test_expect_success setup '
 	git checkout master
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream" '
+test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout master..side >patch0 &&
 	cnt=$(grep "^From " patch0 | wc -l) &&
 	test $cnt = 3
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream" '
+test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
 	cnt=$(grep "^From " patch1 | wc -l) &&
 	test $cnt = 2
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
+test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 	git tag -a v1 -m tag side &&
 	git tag -a v2 -m tag master &&
 	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
@@ -94,14 +94,14 @@ test_expect_success "format-patch doesn't consider merge commits" '
 	test $cnt = 3
 '
 
-test_expect_success "format-patch result applies" '
+test_expect_success 'format-patch result applies' '
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
 	cnt=$(git rev-list master.. | wc -l) &&
 	test $cnt = 2
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream result applies" '
+test_expect_success 'format-patch --ignore-if-in-upstream result applies' '
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
 	cnt=$(git rev-list master.. | wc -l) &&
-- 
2.23.0.248.g3a9dd8fb08

