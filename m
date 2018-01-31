Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4643F1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeAaLII (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:08 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42696 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbeAaLIE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id b25so12235715pfd.9
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYZ7jbtaPKSK89pQgVUQ/6d8VZ6t5R3dTtRhg65Kvts=;
        b=ehJVmZ1HfVZziNBcsvAWWBLk7XLjBrbqpBzrFlWOa5bbOFJ2694wgetakiNmLOXR1W
         ciHYKJq6VBfowFzULHJFpidr0VU6iTLjuw+/Qo7D+BwWzi7AwPSU8n7LLtI+e0e+2nUi
         1wrmBPJUYGA9/H91UKTymBfFCEzk3rqwow4/TQC5k2rUVYJHDuThOPSTm2mCrEmXfYF2
         MOQBIlWHJ1cJDf35ELk4UjfPaIDNQ0+CqXMD7ww2pq7g3uV1dod6mvmD35jtRxT9J+zf
         BWlhQLkNu3LeA19DmU8DW/Nli5wM3MVFTgaYY400Jg9rlKLiUSRPYzs6wDOPYs8Oodq0
         wQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYZ7jbtaPKSK89pQgVUQ/6d8VZ6t5R3dTtRhg65Kvts=;
        b=pbBUqKjFKvz1ptArJgDjLWNsxsDzRbV0FxVNwoZfm7ZMXgB3lvJaP9eNnH9leALT93
         gMPXxedmrbeqLRXZnyySGzyQhZrn8e9wq18WX6WGtfwqKcSzINF3bwWJjFEWVUKBEUuh
         1yb4+jzLlnCmEor+BZTcrjVC5uQ02kEowahMrZCMzlRcB1u41LnZO84uDJZLa93K8c4a
         czhn573guF+u9OSheNCaRs/+Uj3N8kDNF6+bV84WCNOuacF+J8qniYWQE7SZqQ/Esbpd
         aj3ZiC4OQxgiFeydRC1tCr/EuM/1+2dVBPRIvEY9Bwvg4aJVyZaC98s7LM1CM6Z08Gw4
         8kdw==
X-Gm-Message-State: AKwxyteULsmbNiyefQ4hB/iFiuM4ZM2Isayr2sH6K+nMLejDiEiXlWmH
        CNvV0pNIy51eVkKyGsJBqCqJMg==
X-Google-Smtp-Source: AH8x224OfRPxoBbKOjEdQi+n/mae7t4PBZoMR4+dpqcUuJCDmaUy4eJ0JHX3zG+s+P6j4moQViubfQ==
X-Received: by 10.99.131.74 with SMTP id h71mr25882770pge.373.1517396884243;
        Wed, 31 Jan 2018 03:08:04 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id d8sm9699865pfh.93.2018.01.31.03.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 28/41] completion: use __gitcomp_builtin in _git_name_rev
Date:   Wed, 31 Jan 2018 18:05:34 +0700
Message-Id: <20180131110547.20577-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--always
--exclude
--name-only
--refs
--undefined

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0e36190a19..391074a772 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1811,7 +1811,7 @@ _git_mv ()
 
 _git_name_rev ()
 {
-	__gitcomp "--tags --all --stdin"
+	__gitcomp_builtin name-rev
 }
 
 _git_notes ()
-- 
2.16.1.205.g271f633410

