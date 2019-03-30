Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F96B20248
	for <e@80x24.org>; Sat, 30 Mar 2019 14:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfC3O2N (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 10:28:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38965 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfC3O2N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 10:28:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so2355384plb.6
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NivD/tZZ5tt6KvOTJM1WjCiXRgiIyw9yS3YXw6UaOeo=;
        b=ouTgQeyNu0nHpysnkM9j8J8ipRCC8P9/+MDdisvNQqTzd6HZmi/TKCzFfBUUB8hfYn
         vW2XEG34IV9HzWX2YNF/zpXx5muOIE+kcSZzLL2B5kLCmV303VglJvBz/S3SNeF0J5vD
         UPNDPGFyo5lJcpc26J7l8AGeQsW9HHjg2q3naP4xDDCxMAkNsQZjArNFojEI4l1ZSllW
         6/bPYH7IVpkLRyREjwWLdZdBie6U501xIpsIDx8+Iee+DPEbBr8KUOx/TAWEv/QAEXid
         BJYsZzg79jWyWR3nHS8QOvKV4BciF67bMCcExHq7LRrZRhksM4dfKn7XlzZctxPC68rz
         3LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NivD/tZZ5tt6KvOTJM1WjCiXRgiIyw9yS3YXw6UaOeo=;
        b=bqgVg24jndG70+eDoFPHNulrWilXD0K+2/VG8O9A/MRphSAbtTsbIxg7z6b8+IkpBL
         5raAhD96vVPCBLYGAPsfD0HXaTnlmRy1MR5C0VEi3BtPNKW9s+8fkcdk5FdqHTpmC6LT
         hIcjCXCF1zx44buwYC+SRqWOxHdW4iP2/WoLVGqdZ742+MuNv1s7qUVsO+ey62lD2/M9
         YHXO55zNqTMGRWFVsRmYSalAS7Q1LXwgqQzFDSKhHTh8+4/F/PcERhnR2PT2dR3hR9ar
         2rjeD59dMNdhm4za9Rr3n4TdxsyEFQdHoNaojGswrUYp92Eedp9KY4x3nJbkY8H5RPX8
         gIsw==
X-Gm-Message-State: APjAAAVh04on+LFy28Ra80YKXU7PVRkMyg80OHx/vU9Q8LtYXWhqKpV7
        Ey7uNwo6respyHmCmWoLMqvTYuMG5U8=
X-Google-Smtp-Source: APXvYqxiXJgpgljokk3ShU2VAQkPUrX5//ZGzXtcj3I16wPvkGCXvoo3Iiw3WZD8z71HBm4BLYCgRw==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr2909167plq.97.1553956092563;
        Sat, 30 Mar 2019 07:28:12 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id v12sm6621737pfe.148.2019.03.30.07.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:28:12 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [GSoC][PATCH v4 1/5] t0000: fix indentation
Date:   Sat, 30 Mar 2019 22:27:54 +0800
Message-Id: <86146182b7b1d4194168f509d0ee421713723700.1553954776.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553954776.git.ttjtftx@gmail.com>
References: <cover.1553954776.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix indentation of a line containing a pipeline to reduce the
noise when refactoring the pipeline in a subsequent commit.
This has been wrong since the refactoring done in 1b5b2b641a
("t0000: modernise style", 2012-03-02), but carries no meaning.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b6566003dd..53821f5817 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1132,7 +1132,7 @@ test_expect_success 'git commit-tree records the correct parent in a commit' '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
-	     parent=$(git show --pretty=raw $commit2 |
+	parent=$(git show --pretty=raw $commit2 |
 		sed -n -e "s/^parent //p" -e "/^author /q" |
 		sort -u) &&
 	test "z$commit0" = "z$parent" &&
-- 
2.21.0

