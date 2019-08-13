Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0082B1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfHMM1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45382 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHMM1H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so17304096wrj.12
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kI9kicHyvLzAfgSyFlOaXyAL+U2oZ/ak5cHcnwhKiRU=;
        b=ll7RwVCY3ao+bP2ISjQTK3ActTJv5+HKi0wyV0l3lPEKrYFn3UgNeehF0+N3YZpW0b
         jznXfjF/3n0VbE6F0/zjGDLjezU/hqSom/BX4nIMw1P4Qd5F4vTKm/nSbMh/TFD9xCcy
         YQKOwavoZhSkhankRN7JYYvXd1U0rtlgmLLRssT9++sjnWJzRX738uIsEb2DbP0xFBQ5
         E1n+uBui7QGWX5DVaNOBQ8WtvFXvclBZnLUcKzOh6c9vCKgveHVN3yMux5MfWZ85sAFs
         l021LgiEFE9z2+PuuQwFlrx0k7ighDLw8Izsnelkxv9QfSXj5qS59RU0wPN40q6jEOMb
         a5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kI9kicHyvLzAfgSyFlOaXyAL+U2oZ/ak5cHcnwhKiRU=;
        b=VXnac/iLBsrQRbCI4suDufcDe4Fvd8B+kKOM5bX3aCJhpMDCV8m0TEGC9nZSYtsbuv
         q8Jfqa0xPYX/hH2Xt24miULwwNOOegFUt26ZaQfk1SdQqjksBcQgXBdV3w5AZx1aPAZp
         P5g6oHp5PU8MFQsyI3WVWmJai4LlEO3HykjPWJzzGm8juXjRAmw0laCIpnmnJAZOSn1Q
         4nU5Cp7X5asDAY+fmTJJkC8/hF4Ujo7OAKCwtmot+TARHKPc3C98BlQHasLMMuwdLEME
         x79MYyH2ln8ys7yE5nA3RYu1FHoePGsvxG9Jo3+baeSIgHeAopB1a9szNvqVH8pf8Grc
         4nUg==
X-Gm-Message-State: APjAAAVLE+Y0p+KPTsqDwBOnyLetjACz9NGWDXiyJF39Uf0bhKmowXQa
        XjlgB0n0oDNG8+cc/zSjduE=
X-Google-Smtp-Source: APXvYqwLsRTBrqWzrXPnFDpHESaZ/wLubbQZpapIxRtHV8RD8QjYJR1wI1DsCnf9DdT7p7uyb0KJHA==
X-Received: by 2002:a5d:534f:: with SMTP id t15mr37683866wrv.239.1565699225215;
        Tue, 13 Aug 2019 05:27:05 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/11] completion: fix a typo in a comment
Date:   Tue, 13 Aug 2019 14:26:42 +0200
Message-Id: <20190813122652.16468-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e087c4bf00..cd9d8e1940 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -524,7 +524,7 @@ __git_index_files ()
 			# Even when a directory name itself does not contain
 			# any special characters, it will still be quoted if
 			# any of its (stripped) trailing path components do.
-			# Because of this we may have seen the same direcory
+			# Because of this we may have seen the same directory
 			# both quoted and unquoted.
 			if (p in paths)
 				# We have seen the same directory unquoted,
-- 
2.23.0.rc2.350.gf4fdc32db7

