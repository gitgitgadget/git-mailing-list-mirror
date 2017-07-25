Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDCC1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbdGYOeU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 10:34:20 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36530 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdGYOeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 10:34:18 -0400
Received: by mail-io0-f175.google.com with SMTP id g35so23792971ioi.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dfN9637oV/wXftuJtJ6lH00GvR4gvydB1KyE9N8pEQY=;
        b=C+CYEivZJqUTDc1o5ly5aMPNCMSKrWSoD44ecdmEBw295baZpcVMwkG3NwCGd0FHUH
         LcpKIaQ+p0vUHBpssin2ykJDMF67KKo/NPwW+I1aXUtvfbiJsbai5bMR/a2SqbPwxQlB
         UfLFTuIPveUB1nlBbcRXBYGwlCE5rEs9DHodUC2vrdcW1FxgybIuT86DrYJVDdXPoDqG
         vvMcq9VglmU7hrNsS+F1DdCE85IqwUvA2E+NYTiEE50gTfQg7gcWkR1CVkhydGlbIrDV
         A8+IBJhBKvXaMLlC1GXUwD7CZaameT2MSOBPw1ft2PYaWjRTPUYMZrZrP/bU6r8Kuffg
         kj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dfN9637oV/wXftuJtJ6lH00GvR4gvydB1KyE9N8pEQY=;
        b=TxFWL2yE7kDfHI/jYSu8H9d1mQ89yXcRYccqp/L1MU9lJ7XijJ8o1amtnBmXGx8qOK
         5dDloFVHNKG7qb5n8sDLI7/zl1fMshskUDNR6OID6J0/XvK/qcAJBqV/XVmpjWGCNMsW
         dKrvBvDEoTBCNahdGyR5YPJcfHSR4/yHuLROIaMUk2O5dtZ4EgPYwIxnHnkwcRzW77JA
         TIsCHffgNS8uIpqS/SSZTp/jmA6TEhYibE+pQc/0d+b8q82lrVlE1tmkCkatBJ7mIF4w
         fHbJ0TTJC5J8c3vUms49l/mvd8kFW0asCYxG9Srd7fnvlX81UmVlZ6jMEqXc2OJ4hd/a
         j0DQ==
X-Gm-Message-State: AIVw111DRW8+0HK5Nu29e795mrQCXE/uT5n+VFfIh/JVwA+snprer0TY
        Q9g4cmdlDwjLIsDbacc=
X-Received: by 10.107.11.209 with SMTP id 78mr18790232iol.222.1500993257998;
        Tue, 25 Jul 2017 07:34:17 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-81-207.home.cgocable.net. [24.150.81.207])
        by smtp.googlemail.com with ESMTPSA id j138sm6889923ioe.79.2017.07.25.07.34.17
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jul 2017 07:34:17 -0700 (PDT)
From:   Raman Gupta <rocketraman@gmail.com>
Subject: [PATCH/RFC] contrib: rerere-train overwrites existing resolutions
To:     git@vger.kernel.org
Message-ID: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
Date:   Tue, 25 Jul 2017 10:34:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 41116889f7eb2ddd590d165d9ca89646f7b15aaf Mon Sep 17 00:00:00 2001
From: Raman Gupta <rocketraman@gmail.com>
Date: Tue, 25 Jul 2017 10:28:35 -0400
Subject: [PATCH] contrib: rerere-train overwrites existing resolutions

When running rerere-train, the user is explicitly asking the training to
occur based on the current merge commit. However, if the current cache
has a resolution for the same conflict (even if out of date or wrong),
rerere-train does not currently update the rr-cache. Now, forget
existing resolutions before training so that training is always
reflective of the trained data.
---
 contrib/rerere-train.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 52ad9e4..a222d38 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -34,6 +34,7 @@ do
 		# Cleanly merges
 		continue
 	fi
+	git rerere forget .
 	if test -s "$GIT_DIR/MERGE_RR"
 	then
 		git show -s --pretty=format:"Learning from %h %s" "$commit"
-- 
2.9.4

