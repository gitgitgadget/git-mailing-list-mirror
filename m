Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4671F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeJ0PE4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45808 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so3090235ljc.12
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JV8cwwIPeDYFQDL05hJYKYjYnkn333ZnBbKkbbXtYTo=;
        b=riqmM6RCKIjM6/70wnfgF3Ig2qhKRf0b+pVBbGPsGQkmJL/7UTIzuhw7ZgkHPxlu3J
         3mPWNLiL4yb0V67Tw0kiaHRG0rzz4ZuweHMNWVjlPHDGAQ75IhhZnTsKUs8es8Ysh1R5
         01RqsIVprQoTK6yYEiuvrwL4cO4+rZhbs4fpcM0jrW8elCLaRzXMpLXUxjlX3V8Lpxxn
         wsPQfwfQRaZEOUr6GfMX2CLgb1RP1ayBE9knrpuxoNniW69tXCyy0e62pdjyxhuwlsyC
         rfYpOi6TJ7ghkXnPsj2SR7bkXI6jEHkPH9eaK4i3U/rY1bciZJDPkQzmtkoWFH2qV7SL
         9IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JV8cwwIPeDYFQDL05hJYKYjYnkn333ZnBbKkbbXtYTo=;
        b=i2ec1VoGuRaGQ8d0rVlSJFaOKPXj6FZ1e7AhlIupMCBgD4C6BojJj0A1FDfprbDcxl
         QAjgzSRXm2s1iYQHbx/ppwMDFEAXbCOxYO4iCdot6h3LG3yMV7iKIW1axCKsRzseufN7
         9/9SoOK5KrIg/pcd2E7CiQ7eir4NNkaLNzZsTHU46IvvFuxE3PzmxOXUpauXJVtdoZYp
         3lPE3+6HSRJArezdTxecK7nQX7GPs+N4G51Loe+pRr27j6k2QH/pq2llREB7I8jRnjUa
         Bt+XYMhSHHCeHMD336YCUHaP/SPBC407YfP1srq9oZuO3AHOQMdB1rvp0obbUC/LUxf/
         T5sw==
X-Gm-Message-State: AGRZ1gLOUH1m6W5328TP39mjzt8y/Ru8laEqZATG88okD1GtgjMOE5JJ
        gW+ei2h5fcpm+fwp4tcifKN2l0Uw
X-Google-Smtp-Source: AJdET5cth87P4IA12OIUXoABVpONOwnjAJZt12sMnuApvVMaCl9TxttQcB//frrHYUDUBrCs1XvmrA==
X-Received: by 2002:a2e:2b46:: with SMTP id q67-v6mr4090435lje.126.1540621500396;
        Fri, 26 Oct 2018 23:25:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 56/78] config.txt: move receive-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:29 +0200
Message-Id: <20181027062351.30446-57-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt                                 | 2 +-
 Documentation/{receive-config.txt => config/receive.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{receive-config.txt => config/receive.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0079cb31ff..465dc2abec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -391,7 +391,7 @@ include::config/push.txt[]
 
 include::config/rebase.txt[]
 
-include::receive-config.txt[]
+include::config/receive.txt[]
 
 remote.pushDefault::
 	The remote to push to by default.  Overrides
diff --git a/Documentation/receive-config.txt b/Documentation/config/receive.txt
similarity index 100%
rename from Documentation/receive-config.txt
rename to Documentation/config/receive.txt
-- 
2.19.1.647.g708186aaf9

