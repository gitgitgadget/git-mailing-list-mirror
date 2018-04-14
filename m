Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7641F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeDNP1a (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:27:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41223 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeDNP1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:27:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id o102-v6so16345066lfg.8
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSxnuzR9kPM7/y4cm7V0QwkA/Y995BExEeE0s33T+I0=;
        b=NgmngEq24tyNonF2pxM2iVEZRPdF44Pn7b4oAOxZRp6UMl/pPo9IoJnafHb91XLNiD
         JVRImdXRRVcyezrRpbjB1/86xVnyg/czk6DXjl4yi5wlfG/yh7yTo7+As3qgJihVs+5W
         N2QNcVrvPN4LB+j2R+sX6DpBFvs4WebnZxFW0C26tisuEDI6YvQwXqGwaali4dzje2FI
         wi7PtfFC0eLTCSkTaWiQasAAcWcDZonlDw0O3+TJDtaoGH5fL+SvtPcYAgvt/UP4uJv/
         eLJ4I9Yh/ZIpSi3uTA36YI4m5tWMCI4lHpgguovejXlp+pj73mG/ch56MmJLfZ9J6/46
         HJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSxnuzR9kPM7/y4cm7V0QwkA/Y995BExEeE0s33T+I0=;
        b=By7fKRKBZP4HFwOetScfd5UceWEz/CBVD1Lf86K4Xq9LeqQ/CNZMZdLOlNy2/IHHbG
         FHhxU4SwPjFVgQuunk9lIjVrQqDL5VBV/x2484T8iGMEOQcTSkaNT9i1X4zJ7wagXwl9
         NiWnM/gLkZDsSdTQhqnJ+ImLjouYHWUdUWN3JM1XvVW7KWJaO2xqI/n6ZHZ8UHDwneho
         nN7zPpGdeyQyw1+u9orZoqB93bQ2J/l42sEANCiGRujZl6sBnBiqMHTNtBZtUmcyfAj3
         8tAP7s/tXJniND9JlGAUSrV4t8sehmgxhtk+L5sSlBhAOtLUbNs7q9XuZFjQmSWyUd5G
         JT0w==
X-Gm-Message-State: ALQs6tCUV4WSVROYFn2hMkH94rRNW7QhMeTlPubCB1dw8WE5KGlrkGNp
        UpC5syxqR0wNlIe4C82Pk7JJkA==
X-Google-Smtp-Source: AIpwx4/wugJQpGN+RraovNS2gd/2C/C19B5pDubr68yc3yJ6bb29PJXmvAET3PSLRwZmeaDLFc+LPw==
X-Received: by 2002:a19:5386:: with SMTP id h6-v6mr11014821lfl.116.1523719618594;
        Sat, 14 Apr 2018 08:26:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1803378lfg.28.2018.04.14.08.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:26:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/7] t7700: have closing quote of a test at the beginning of line
Date:   Sat, 14 Apr 2018 17:26:36 +0200
Message-Id: <20180414152642.4666-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414152642.4666-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The closing quote of a test body by convention is always at the start
of line.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7700-repack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6061a04147..38247afbec 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -194,7 +194,7 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
 	git repack -a -d &&
 	git cat-file -t $H1
-	'
+'
 
 test_done
 
-- 
2.17.0.367.g5dd2e386c3

