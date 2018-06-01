Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD721F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeFAVKq (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:10:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35146 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeFAVKn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:10:43 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so2654196wrn.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bzFNuGMt8urtyjrCh2SToKlXKZnF5YcilkIqNpeteGA=;
        b=giPkeO2Z58YBhPxi6uOEWAHBZr8ek7CpE45002hYlTeLfc1gZPWyg1vW4uV5MyFAzG
         tzKaHVzoSNUCIXm9NVmFaSyQJYbi4/5SAKlcvU2ZuXhFd3AVYx6toK8GG4oUz18R9CmS
         4QCuawQ11ZUfq/40RzyKpvYyGYRr0aZ57nmi0pGklB4ri9MdGDwwoYG1WxYoyBh2MnFp
         8brYbjyOqeCwVdYGk27UdbdH+kccTwmHLxoVhmgAePIx0KFXLTpCZHKtLDDi/2v0ZCPz
         agOoEgwXLkZlVP3PN4IJgOHJnng4X8tJssuSpdPNAr9SW7m9zhH3ZmGzNAr8W757KipH
         7dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bzFNuGMt8urtyjrCh2SToKlXKZnF5YcilkIqNpeteGA=;
        b=IBfmEVwsNnS9VeuMjyCm1hhgGXoXdO6zcoZbFbQnOMyRBWr7OJDGK57ysMAEVNFfyO
         mzSDcTEUIw9L4jGU6QyEwkOHoK8Fi/n6i2CgFkK/94hP6hJnrzLKiMIVG3WADbBFGhMy
         mCCPT3bed4am4ih9kSmd1jybR8HomOwZG/41u9skJOAGrLuzaAnKOlu19YgxamtP5V+z
         f+WBFBmUmVSog8kjIZAS399R+3nixvZJCNLoHohs5+Tha53wRPEVTFIDdVPZCupCJZ2q
         1WZGXG3zcClj8iwGnQVu88SwpILhHiflX1kk+WwiCqrwPCcQONnqvBRSq2+rpewP35zY
         7jNQ==
X-Gm-Message-State: ALKqPwc4RIRCmgxa0KFoKiTcms3EzLsjDa8GJB0SNNfMgroplK+YzQFK
        wgereuMOw/DidFuJK+9PndaaP+pc
X-Google-Smtp-Source: ADUXVKLoMlLpx0hQYFIMfioGPVJlbr/sCxS3Biyydqc7LdBRnvSVvt5FNLuTdboOefMH7l0CR7L56g==
X-Received: by 2002:adf:c08a:: with SMTP id d10-v6mr9237367wrf.268.1527887442160;
        Fri, 01 Jun 2018 14:10:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k126-v6sm3516235wmd.45.2018.06.01.14.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 14:10:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/8] builtin/checkout.c: use "ret" variable for return
Date:   Fri,  1 Jun 2018 21:10:13 +0000
Message-Id: <20180601211015.11919-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no point in doing this right now, but in later change the
"ret" variable will be inspected. This change makes that meaningful
change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 72457fb7d5..8c93c55cbc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1265,8 +1265,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(opts);
-	if (opts.patch_mode || opts.pathspec.nr)
-		return checkout_paths(&opts, new_branch_info.name);
-	else
+	if (opts.patch_mode || opts.pathspec.nr) {
+		int ret = checkout_paths(&opts, new_branch_info.name);
+		return ret;
+	} else {
 		return checkout_branch(&opts, &new_branch_info);
+	}
 }
-- 
2.17.0.290.gded63e768a

