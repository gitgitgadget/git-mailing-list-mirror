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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F50C1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfH0EFB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42005 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:01 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so42905623iob.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Il9LwpJVzdzduiFquLf1KD7uEGxhXQfU8tLcnW9qImI=;
        b=bibesXJJBpowUKBZ89urZ/qJm62aS/12IHyGCqDmcCMGME2pfxiAHNoHx9kIxnp2vs
         aPiT5OLGfPEGm7lZQ9U1FIWVDai/Yfw8bHuSU/r6FaAAWRSnlmDlvLFS3IKkj3Li0bZR
         ZyuETVd5aglJ72If3ITQTIOimJ0eVRjRJ9EasuGv+vhfc9rcCEvbp8WK32PIH2COj3Iy
         9LWkP0dKikAS8eLsYvfjDxn9E5itsWIVdig5MKZNcoY5po/KU4P52+1jH7Rem8HD2kiD
         W3fVV6NoB4uA8A2snD+Jtr1+mqM55Kd5jBtZUrwoVMEZu4gqDRlqb8gss5COv1fzvkcB
         d1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Il9LwpJVzdzduiFquLf1KD7uEGxhXQfU8tLcnW9qImI=;
        b=grvHMhj6lcti4V+Iyvj7or4hQk1aO30DxreLhTCMHdq3QxSj+i+5SqtsSWNvP0+GPc
         hkz0ftBphjf3WJdMM0+B2dAk4hmH722/11vWszgiaPt1q7BFCorsINBDT6+0TaTOj69z
         Sk6IG4c+IXr20ZrDG7o0MvRHWxlDIwEF5MAAXC7GskR7rFMzmEp3P6X4W5myEwgZLD8Q
         l9lRIuBrkT7j6eDSta1yr02fhZNfOJUyzBdvqgydvhzNK657nRA6PkLo7ob5/52/RPYj
         t7B6VCDq/Xb1PcmwekhLpIKyd/yNEL2ujrIHF/Tubw5hTXalspVNsmU8fSdc02O6rH3x
         HBFw==
X-Gm-Message-State: APjAAAUQJL9oxDGwluIcAXoxoKETWbsOLlv/GZA0HVHxWSGaM8B6b+0i
        7IGt2bp3yXY1k0sXaK97WLN4xm7f
X-Google-Smtp-Source: APXvYqx8MUsLvMoX0HFvDN62+VkMZHrRt5N8A43F+5nR6dFVoNDqT/2OyTXtbm7oXt63Iin8Vu6xEg==
X-Received: by 2002:a6b:730f:: with SMTP id e15mr422395ioh.74.1566878700602;
        Mon, 26 Aug 2019 21:05:00 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id p3sm11095240iom.7.2019.08.26.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:00 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:04:58 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 04/13] t4014: use sq for test case names
Message-ID: <02a11147fd016be4f0933cc30a759cb688506f4f.1566878373.git.liu.denton@gmail.com>
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

