Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF3720248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCHJ61 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43910 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJ61 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id l11so13757338pgq.10
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWu+Iz5SGpjiljuzSykciGRgZrqsaNG4CqhJWGhw76Q=;
        b=TnfQ8eWckHY6UpvdV2Dc9exjHB+T3RqglEhkuUxes5lGCTEP6KVh/JTKBWNph3XvKC
         Lp27rTf8n00WQHf7qsMVaKkaIpGQCp23hEKOg2RNye3FisTgdpdr8Lm/z5ty0f+xczhL
         JJf697eKi11bMblZKz++s7xvtP4o6l26x5iwFAX5Z+YZb8J1rN8U9EQwrFGfzxLUkgZ4
         dIgkzlgksTYv8QRRal+QHJvOh/g1xTwqpLF0BxinnB3CMsGmeC/PrLI7QTg8nP9IDNHe
         JAunWQzkCkkbW1Xg/pOouw/A2/17QzXzZt7sPVsejrwBx7sRXYTfKQqS3B7ymWAipMIN
         NE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWu+Iz5SGpjiljuzSykciGRgZrqsaNG4CqhJWGhw76Q=;
        b=dTxlUSxPpSHFAsIMfZrLgV1+8WfKUrXAJEMs1Uyp4JMdZfMRqMag1gAt+d1Smewrg5
         rI835l7uKtN7W9mCl17bCGGgR3b6eMXI736peYU8pNpSixaz0r/3FLSy/2Cz6Wr4TmiG
         kEv6gC7WtsqJSPsMR9kdhwbLuHivGu2v2L9NWX8Gcf9eT7GdzVW8lLaO6wmDqupRsFBu
         8GoOAONtrKE9v9F1OJvVaZF+h7lX9UlUgZXo8zjLxGsSNR8uvW9objYBb6biqrT/E61b
         FOZpVqESCGA6hZpQwcv2qb0xcBToEjX6U2cjhFxf1GGnwiHEsdGAI1HbdmlJ0FvEoKio
         bxqQ==
X-Gm-Message-State: APjAAAXlNHCcTXnRyMB4uNIHxe+X39SOy1hmKXMIjb/oY6MZwcZRIYeP
        P8sE53EYC0yVrNgMK/FN13A=
X-Google-Smtp-Source: APXvYqxIgKPd32T3BbBLTbvpaBSjt6BZPXBpWPajEpGTp9r/yMGPbgivpdDsWiGXL0d99UspOw15hg==
X-Received: by 2002:a62:4299:: with SMTP id h25mr17495243pfd.165.1552039107055;
        Fri, 08 Mar 2019 01:58:27 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 70sm19775933pfr.43.2019.03.08.01.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 05/21] t: rename t2014-switch.sh to t2014-checkout-switch.sh
Date:   Fri,  8 Mar 2019 16:57:36 +0700
Message-Id: <20190308095752.8574-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old name does not really say that this is about 'checkout -b'. See
49d833dc07 (Revert "checkout branch: prime cache-tree fully" -
2009-05-12) for more information
---
 t/{t2014-switch.sh => t2014-checkout-switch.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)

diff --git a/t/t2014-switch.sh b/t/t2014-checkout-switch.sh
similarity index 100%
rename from t/t2014-switch.sh
rename to t/t2014-checkout-switch.sh
-- 
2.21.0.rc1.337.gdf7f8d0522

