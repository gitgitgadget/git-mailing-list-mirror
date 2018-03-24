Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E401F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCXHna (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:43:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46156 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeCXHn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id j68-v6so21383682lfg.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+M/0/oYiRJxNpCluntdYs0tbDIUdkXwm1P7iOXaIc28=;
        b=GkdfN6pR6dWx8wXPEHwR6mwTLCxZMTHw23f2b5DsHdvNV/wQfbDQTDbQVa4c47x/HY
         mRDVjiMRKekI1OSeZbdC4mx8XSuU2YAbARYrJht2YSHFB+KytxGTb8RcyNDlXO/R5y6m
         exDQnnxEoRDFEs6CEn0XeOtKlp5EVufCXMMh+EtiGICjReDJvoXJTK39TE/2QeO1MOHb
         +DmHIJhcrCwf9K7qNlgYkosOWVOIhb2241JU/tlGmWwhbxkfYJJXCLBFq3RCAgD1LjcF
         80da2heoXygI5B1oxa2h9VxQLs9XoSGHpk96QDaytoQVSomkZdSN4rprddXGiDqA0YNi
         UT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+M/0/oYiRJxNpCluntdYs0tbDIUdkXwm1P7iOXaIc28=;
        b=PZhAVfoSiXPzn9+u3gXikZP2f8dHJ+339H4SEEdnINaPrzrk7qIarJKI+7VFlMwpmO
         NnlHbXqIRoVy0oU4ZB+M9fsH/gGV7mErQKtPDORi05vfw0uyBE1z/HyxvvXNKL1TEy0s
         NG4IMQZEH9AM5VIFqYfX5/8fDZKrVtxrgdb5azZA2uTWnld08JVggJgjqKlBd5XKb+vZ
         hANiDv1bFah/XfFD+kGon+KpdsWbvd1oZsd0BneQvt53cwIBXq/A8yAHXz4BMLanouh9
         GR2rom9PENqyaaXhzTgJrL+kouGDQLpIcQhMWPrOT8P4VucRiSK1hXpcYn9G1XnShLfr
         rbnw==
X-Gm-Message-State: AElRT7HUa+waVIiZk7a17ktpv1bw0ff3o7Knsv3Betrus5KQukN+fS8y
        khW2SnrrZ4rscPbp7KfoD5w=
X-Google-Smtp-Source: AG47ELskzRImjaYiurEEuURsXx/T8FLA5KNIQxM/2uJX8KFgP7+krvahntMBrCWUKlj/o5ycmrVavw==
X-Received: by 2002:a19:4e82:: with SMTP id u2-v6mr22240227lfk.131.1521877407358;
        Sat, 24 Mar 2018 00:43:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o132-v6sm2642867lfe.91.2018.03.24.00.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:43:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/7] t7700: have closing quote of a test at the beginning of line
Date:   Sat, 24 Mar 2018 08:42:26 +0100
Message-Id: <20180324074308.18934-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074308.18934-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074308.18934-1-pclouds@gmail.com>
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
2.17.0.rc0.348.gd5a49e0b6f

