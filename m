Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1451F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBILEi (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:38 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:50928 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBILEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:37 -0500
Received: by mail-it0-f67.google.com with SMTP id x128so10471199ite.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHH3ly+Y1qEkyXsTE6R9R6dAOTu1Ud5yMsWWx83u1b0=;
        b=ZNZ9cUT+dynIXmfu7ZDa4WM6UFaNLV+KT/+VCretnVig3KitPxVMBiDFkVaJuYC+3y
         o4i9CeIDk4jxUS5tqAEYJCMt2J4+0KDW/hK4kXt8du3EorzfQwv0d1L2Wkf15qm14Xq8
         0rtIfxYvY+F8cYEJ32SAFQJTZo6FIv61o8VaupoNz4i/3fjPNhY0hM/p3RlKOhQTa82e
         l9wLrvjFDpX0muA/Sp5Y5mwLYMDa1QlwaoNhMrOwWb+tEdcGRU6/x7X67XBc39vTdjEm
         WDJApuzOx9ChrSYVB5HeQHvRYoUIqrFWGFoSFqZ0hLys0f3lZaENDAnquHUjXnb92Nww
         wLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHH3ly+Y1qEkyXsTE6R9R6dAOTu1Ud5yMsWWx83u1b0=;
        b=OrLqfey1mhKoJPV+rvL2co/SW/ZGjvUmhTCM+cW1H0jeLwSPPw2jVCLwuwrjUXMem+
         daKOmpJ9oNPM2eDz63B33kfvBJ1zdnsi8Et8p2dT0YwCj+f7TBt13ErAuUCO96ONPIcO
         q5adpv5rzVeI2Nq0AZ8WkAdYyA9GDAqZKByRWzWEe8jMIcAEV54MhyOIkrmUwYlwhqW4
         B5pizTvZ14z9V0Dm4FRBp/ts2qmvaP8cva9KqA4L2I3R71ApKPxjjis7F3RrO39yMdem
         F0y6WLtlilP5aB+WVmfPejtWmEPxjqDm2CE84y2twYocArkYS5Mh41Epf5fxBMOC1rPY
         NpgA==
X-Gm-Message-State: APf1xPCCZIt+rzJu7ls7rxD9E/3QrwDB4VHIHPI/MpMcdsG+ecxmXJnc
        pz/immjOJjQrpYWCp6iZfzjQkw==
X-Google-Smtp-Source: AH8x224v93kBEvwWNTvG38gqu8dgg7lrYWYb9AgdRO0kedP13Q3gukKtLAnvEUCgdO3noi4ZZ+eMUA==
X-Received: by 10.36.53.210 with SMTP id k201mr1604244ita.59.1518174276979;
        Fri, 09 Feb 2018 03:04:36 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id v2sm2405175iob.72.2018.02.09.03.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 22/42] completion: use __gitcomp_builtin in _git_init
Date:   Fri,  9 Feb 2018 18:02:01 +0700
Message-Id: <20180209110221.27224-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable option is --separate-git-dir=.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 08f024a0ba..36ed502ed0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1606,7 +1606,7 @@ _git_init ()
 		return
 		;;
 	--*)
-		__gitcomp "--quiet --bare --template= --shared --shared="
+		__gitcomp_builtin init
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

