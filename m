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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5441F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405192AbfJWMEA (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:04:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45142 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405189AbfJWMEA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:04:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id b4so3885126pfr.12
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9IX9Tt1pf92q5Us3Mw15Vyjbkm/rfoIxyWi4z+Ci0HM=;
        b=K6r/zdXNW+Pzi7A51Q1w2qYZ3el5h5C8JmxAdSJG2gCqa1ipNkOAQ9SdBcWeklN/20
         ZIet36WExWnbYZN0wZi04MiDA9MimLrs+De8eZlIZhY99GbVqsUCaKVIrhCHpNpeRQA3
         nR8anH7qOBtugJSsrtsFO9pbN2YshSGPnC3sAjcyjiBs3LZ8aC+xgMmHWi3exGdUCj66
         7lhUERh0JaR/DH71QyzoN+bXgemz8Z3RlcGRq7Cvc7sysBm+85A/cEq5Y94BQAgVzRYs
         EKsFdytrV3YPCDzD/MXSukx4dk3I4uL96siMghJbNMwdlqsluVHfX1lzfh/Cn2EtYhld
         jdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9IX9Tt1pf92q5Us3Mw15Vyjbkm/rfoIxyWi4z+Ci0HM=;
        b=Tk7o/AZ36wqYOIPkkQKwMMdcoScMuW+j9RXKBnKUEUOCNn2vl1Jh66Qi3yhzHDx3hp
         sahXkk18Aa2j3CKegtNrRnzKE+9/IPZyYtX+94jkBBaXL+qR0K+Uxm+0gJuNmT/0vBPu
         iUOyxOS2psdjTrVJAREeleRvPU5nuz5jjEK+Z/lLzKKtfXIfxgMxb7m/Lnfc05z9oGHg
         R6QYlONgyKznkRwNxpLv3eKfk4bQHXcXUfIZp1d5wcGjxg7fuqXMveqKCC0+iEtznQiv
         ke7nfMTnO685o0mrZcjmEZgNvA1GPYvY1wNcnUdLOBZUcFc1v8Of+OUcBiMwO25TSwxn
         5VaA==
X-Gm-Message-State: APjAAAWhDEXeQ5ZTSLM8Ax/ky0Seks/V13pYTQqIehZPgemqa3gt5IEy
        D+3Te5NMPdMoyUmYwNiSYU0Hs/kp
X-Google-Smtp-Source: APXvYqzqHdVFK9yB0bBl3Qa7bWn4u5Iyuokz1KG0kV3wOCe2TshQQmiev3+0hKGMuZ1occsGjaU9Ow==
X-Received: by 2002:a17:90a:d143:: with SMTP id t3mr10896742pjw.105.1571832236167;
        Wed, 23 Oct 2019 05:03:56 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id x10sm19945594pgl.53.2019.10.23.05.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:03:55 -0700 (PDT)
Date:   Wed, 23 Oct 2019 05:03:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] t4108: use `test_config` instead of `git config`
Message-ID: <d77c5f4199562947cabc89c63b55faee345fd8fd.1571832176.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571832176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `git config` leaves the configurations set even after the test
case completes, use `test_config` instead so that the configurations are
reset once the test case finishes.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4108-apply-threeway.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 49739ce8b4..3615256492 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -70,7 +70,7 @@ test_expect_success 'apply with --3way' '
 '
 
 test_expect_success 'apply with --3way with rerere enabled' '
-	git config rerere.enabled true &&
+	test_config rerere.enabled true &&
 
 	# Merging side should be similar to applying this patch
 	git diff ...side >P.diff &&
-- 
2.24.0.rc0.197.g0926ab8072

