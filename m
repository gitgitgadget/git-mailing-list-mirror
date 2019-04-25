Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E77B1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfDYJrR (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:47:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46137 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfDYJrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:47:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id o7so8583458pll.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTEdKMa4nDC/Wg4HlCBGA+FNkWkM2+GMT1lNFJMRLko=;
        b=q/ik1+yQ7HLAENKODc505NUQw9HRyXxUo65NFcMG7chPrA2iuyRDCOxQi105pyTUM4
         kt5RFqjjAwub+xJUnbUwc7OobrG1cZLUaJ8hWcUrFC4noVH72X6uXSHmRAQesBbAii1C
         +3jSIARRwQQ/ns+XlXrXpnHZbhsPVN3Xrg9v2ANpOrM5rrb7q63vDzmirN+diyMUkeQu
         djZAVhbAnCnmxe8tw5ToIkeI3kh23OMbNlPugzjgaLd1sxwhDRNwxYeLAKSYBacGz3lw
         8vqmo37HyN1QM7MtMusS5kkQ0MyTDWSa4Ix9EHQt5sqq/MSPOx4kLu5iPzbeZ8X+6gC9
         F2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTEdKMa4nDC/Wg4HlCBGA+FNkWkM2+GMT1lNFJMRLko=;
        b=rK5FOhBqwcODuIK7HiOBdxPN6sLh/avtuwJpOGCJlINiF/B54szXMuIsbt0BOPmtp7
         v7XsjGfe3TY6eV59W7AHwj97W4pmuIARKyaF3gjLmi2v4aAUExDuj/AvbYJkox5XLSx9
         53BVR/DqhQSoPMVDQ+Xof/ESXVYaJljexdXxw6hY10q4ly/05KPj9NPhoWnsOA3op1R9
         mhn9VZCblYHOe+IQBVEXsEiWIAwlZFcojujjE1LKX7oKMruxev3iU+a9mbOW54ZHkau6
         1ITdZ4nd3Oc8Aq6ble/nJnzwhAbXDYuXBm1eaKK6kO89Y2mQ2dWfLM5O2LblIG1pHK76
         +pDw==
X-Gm-Message-State: APjAAAUIF3prHU4vQ2Y28T3wjW2dsuw4x3h1axodZdB0OkgEMoziOfjD
        v9oHXgJEOAinn6dMHCrCqZs=
X-Google-Smtp-Source: APXvYqzeYEi55W93d6uFAPg3AAsDLFIiFeD97e7tGFtg2MXagDSnH64fvt1Fdil9uGpNuY2WU3txxQ==
X-Received: by 2002:a17:902:e48f:: with SMTP id cj15mr38344977plb.256.1556185636722;
        Thu, 25 Apr 2019 02:47:16 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id g4sm37440005pfc.75.2019.04.25.02.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:47:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:47:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 13/16] user-manual.txt: prefer 'merge --abort' over 'reset --hard'
Date:   Thu, 25 Apr 2019 16:45:57 +0700
Message-Id: <20190425094600.15673-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the operation in progress is merge, stick to the 'git merge'
variant of aborting. 'git reset --hard' does not really tell you about
aborting the merge by just looking, longer to type, and even though I
know by heart what --hard do, I still dislike it when I need to consider
whether --hard, --mixed or --soft.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/user-manual.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 94799faa2b..4e210970e1 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1408,7 +1408,7 @@ If you get stuck and decide to just give up and throw the whole mess
 away, you can always return to the pre-merge state with
 
 -------------------------------------------------
-$ git reset --hard HEAD
+$ git merge --abort
 -------------------------------------------------
 
 Or, if you've already committed the merge that you want to throw away,
-- 
2.21.0.854.ge34a79f761

