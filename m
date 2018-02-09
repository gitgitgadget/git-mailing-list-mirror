Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA4B1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeBILDl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33960 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBILDk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id s73so3399264pgc.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HHNh04KFho07jecX10vLVlA+mZpH6ZgMYDK2qj6GG8=;
        b=raNC3iP0ZVpvi753/CM2WjnAcmyCrUAX90bNwR3rtd8WP0M9MWVXk3eZIp9NUpDrnL
         0TGSvnPIzybGTOq/H1xSO5KnzIrMr9bXBMRhw8XrygJ7EFNKoAWG9PxZK4DyOopRbSsR
         s1r4sN7NvHxDm057w++UZS0s2MOOvWgN2Iu7ocWI5oBSxXHhiLm/TvZiWsef8AvkqCd3
         swP2IBbl9auskmGV7aAcSN1mwyXj8ZsIFcXBUdYGNhSQ3fJiMD0BT7/Rnz1TnPOegU40
         iU1gL19TM0GFNP8CCnBTIoQS5SG4//W5YC6Wp9aWMCq93sbmboHa8O3p/jfQuDOGyxJX
         0sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HHNh04KFho07jecX10vLVlA+mZpH6ZgMYDK2qj6GG8=;
        b=kdayfr2cz0bNoO/e4XSz+zUjA/Z320RYNDogi5iSf4x+7ccvz0IHghuwxQ4LdO36t5
         WrsUFUz4NXgxUo/Yx1hNRmEs7Sdr330CJe2m2rN+FI4+EiBLGI4xgmSZt4X2uaSqssmB
         CtjwuPO7/tWwGanzBCaic3PHkkaZS03g4G/R9QrCyKj5qR5xEVXCDW1ubyHiANivFBZG
         ghojWeIKGdpEWO0UUTD33WVW+6DS4Fbzmc9PHgEKo61aBC4jKpWGEHhXKWlKs6CZxCQ2
         ts0s8Lh2xd0VGpUcmH18qpZ7Vv0XNXd10HpBvcRSHyjAvh1rW0qvyBHMC4K/lu9QNdEh
         zhWQ==
X-Gm-Message-State: APf1xPDn9MffllZaW8QgNexnTNNe/UDL9pJ4upsURLyqm6gECTmMhpmP
        h4abE14ghCyKxjbg5DJP00J2Yw==
X-Google-Smtp-Source: AH8x226uyUX+KmBqXmi0oGVzgGwXmy/CzMFAZ5I6WuTCDj3jBz+w4Ko0calwjQagSYMio/NEHBTUjQ==
X-Received: by 10.98.0.17 with SMTP id 17mr2432203pfa.63.1518174219631;
        Fri, 09 Feb 2018 03:03:39 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t16sm4684890pfh.131.2018.02.09.03.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 12/42] completion: use __gitcomp_builtin in _git_clone
Date:   Fri,  9 Feb 2018 18:01:51 +0700
Message-Id: <20180209110221.27224-13-pclouds@gmail.com>
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

--config
--dissociate
--ipv4
--ipv6
--jobs=
--progress
--reference-if-able
--separate-git-dir=
--shallow-exclude
--shallow-since=
--verbose

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b7de381876..6afab02a4c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1320,26 +1320,7 @@ _git_clone ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--local
-			--no-hardlinks
-			--shared
-			--reference
-			--quiet
-			--no-checkout
-			--bare
-			--mirror
-			--origin
-			--upload-pack
-			--template=
-			--depth
-			--single-branch
-			--no-tags
-			--branch
-			--recurse-submodules
-			--no-single-branch
-			--shallow-submodules
-			"
+		__gitcomp_builtin clone "--no-single-branch"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

