Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ECF11F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeCFKmZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:42:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46339 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:42:24 -0500
Received: by mail-pl0-f65.google.com with SMTP id y8-v6so11608614pll.13
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wb78yqu07/vNswxGN2YfunmZ5zCh9kkW0A42UAhqmJs=;
        b=rOQ/M0PYp3Zkdodk2ZfdSBg7en8/xLXsRwzQaBVQunUKfBDheAJomfSqdWgsvnZTli
         0MihGgiejiSxNO3UXfQS5u4YYC9Z/P+xyhT12NqX1VVTammhFVAPdBiMo4G72+FNy7Sm
         bgX+qwSCCYpSrQyj9IqYVzKlQmnHJBIKeW534dlqtgcpRRy77eD8yPLc5P2S0C0A15KF
         tnNBciVMgMGSuy+VMp5RckBsvxk+sh5x6OGxW0O3H+NXqDW7wZjarBBAilLsmIKEl1K/
         jFCJ+o+RoEO+L0pNEz6alUa6Gwtqi3qg6mg8pvDxg7e8DuTjcGekUWZo92/6o/SQ0FS4
         jTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wb78yqu07/vNswxGN2YfunmZ5zCh9kkW0A42UAhqmJs=;
        b=HRE1SbTL6iE9WCRw62upZEdiuwicAXqJnrf6Hd80+Msx+gTVeAPcgk3U/SysE5r2qy
         vWiDdS7/lFeIM8CAd/7p1cVhNJzQxXEGDwRmm9OHyiBg7xWrI475NaM05pvEwVY4NW8v
         5eJHcZ/+jZ/v+/4fMeA7MY3sfAbHxMl2a1lMxP7N447thDOCDyincgahQxWJKcesZHrP
         uOpZM+4r0dcaNqSxclWZGQTNdlWzIA25HYdVTdqZpIYwtrvbqyBQxQon6paRjUvcrpj+
         zLwLS2pfhooyQ2w8hvR4P66r928sB0d7AKEWsQLyqyEI78i3Le4MmBFZIreJy1HkWsCj
         cbsQ==
X-Gm-Message-State: APf1xPABwjuww2xN4wFYyW8D/nV+Uz5Y/eNegiND6Nfi5K+nNX30CC45
        fT27Pz58GDil23oegsTcVAvJRQ==
X-Google-Smtp-Source: AG47ELuBipqeDIA1gXcJBvYrtn16suHrRrTlu7Psn11nEDfnnz3YbbtMcp3U+HM4+Msdi8mAzT/Z+w==
X-Received: by 2002:a17:902:710f:: with SMTP id a15-v6mr16001221pll.87.1520332944102;
        Tue, 06 Mar 2018 02:42:24 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id z79sm30145368pfa.139.2018.03.06.02.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:42:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:42:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] fixup! Add a test showing that 'git repack' throws away grafted-away parents
Date:   Tue,  6 Mar 2018 17:41:54 +0700
Message-Id: <20180306104158.6541-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
In-Reply-To: <20180306104158.6541-1-pclouds@gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com>
 <20180306104158.6541-1-pclouds@gmail.com>
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
2.16.2.784.gb291bd247e

