Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281281F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeBILFK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35461 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeBILFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:08 -0500
Received: by mail-pg0-f67.google.com with SMTP id o13so3404066pgs.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCJQaROLOr/gGYKU6CT64zidM99KccPov8FsKshrVXs=;
        b=t/wso5mpOZY5pnO8VlTPLN4P5/Yt8mWxzaQ/FMQTXjidad5AxLaUg8WtmylxznVSwM
         STGqEIY/jrajEz7rcTYcFYb+QjcyWQ78FUaieWLjeTFs3rxJUDU3VlQp+rdUL3B9Vxcy
         8y26b/MlbLNOIfbjEyyWOp5HM57ZgU+jQZhMrUQukgfOWwt9FNL53aLfu38xM3rlCrZZ
         MP3lepYJP3IFbFFqjRr9hPDSKTZU/bGM2w9LC//jD4gCsUzv4BsEJUcImNCqfcTH2Nec
         +mM++PZ/cxT2f7hCFtEiJYza/uvWvKXRzk+/qT2go/7FRtnSapH7Tos7wKn9/NZou5xa
         893w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCJQaROLOr/gGYKU6CT64zidM99KccPov8FsKshrVXs=;
        b=GGfUm+yDV4Or78tlIcTdwNieaR7i65vFrPBirHG4EMBTFpAm1at/0cLj8JFgAEkeop
         r0C3ThBfXvqHA5yycgutJazwJqXZCqjjzDJ2jMIcS8yL1HC80ja99pc1bbCr+7dUmPts
         dnGSNRwM8/Hu9zlVL7Isc/sov3OWnZnYA3pZ/BSiMGOPQ41Y2oKVCjrUXhRvC1ZN8GlD
         wIPd9in6VW+pwdF7yQKjEwTArlq4o5fnRrKrnfz2AdoLAdK7I5RGQIKjlnFfb+ogKCXW
         k+9T/UZcIrNyHKhGDdhB4ZFeF1wxPjIwc3FhpAffhKgdq7JtMrKyi726JUmlc7aU9tBs
         bm6A==
X-Gm-Message-State: APf1xPCCb+Gk9xrgdX8o+4lFLOO7ABZP+w61KUW6Jg+18rbsNmRba7xM
        lb8mER1V9fckM+IG3WFiCxAcAg==
X-Google-Smtp-Source: AH8x2266Pb7Z0H7McMMkd37Lmcgr3HXVuSUYMK6d39kXXRn9wFXhmkhblRQni4ihF2Mktjvn2o9GuA==
X-Received: by 10.98.157.93 with SMTP id i90mr2515580pfd.58.1518174307711;
        Fri, 09 Feb 2018 03:05:07 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id a28sm4785138pfe.70.2018.02.09.03.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 28/42] completion: use __gitcomp_builtin in _git_name_rev
Date:   Fri,  9 Feb 2018 18:02:07 +0700
Message-Id: <20180209110221.27224-29-pclouds@gmail.com>
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
index bbf8623e3a..c7b8b37f19 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1825,7 +1825,7 @@ _git_mv ()
 
 _git_name_rev ()
 {
-	__gitcomp "--tags --all --stdin"
+	__gitcomp_builtin name-rev
 }
 
 _git_notes ()
-- 
2.16.1.207.gedba492059

