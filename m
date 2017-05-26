Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E9F209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946824AbdEZDf0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33073 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946754AbdEZDfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so43066856pfe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=DJgOmcWbDhtwvxdy11pSpsMrgd6drOQOZqaZWr84Uco=;
        b=qri0sh2PdffT0xmS1TJUYOocImJkJxADqGmo8hDgBuvOW9m88j3/8+GyBxCMcQJdaC
         AC/YSUI3MCvDeSq6X6Je+f7eQMauWJOCr8UsULkemAxL5Lycf7k5b0HJvUZtxF/ccAbT
         XUFXcJJQcsEsMVStJ+tuHFuPSvIp7a+0kIM/W5u3KT9YIxg2ULsKIT7xsjtwq5LyVXuB
         o6Il/l238Hxdt1KNxzbcAQ1DCDg5cp1ld3qJNG5xmFAIBW+adVvTTWisacH46T7+u4yE
         I7XRlTjtjSUx1BNA3/7OSEaKtnHvOpDsFwBuhHOmSLNByBRXURvJTqS5/UTO3kPnva7d
         46OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=DJgOmcWbDhtwvxdy11pSpsMrgd6drOQOZqaZWr84Uco=;
        b=XRk7P1hc7qYGoFrM30JZi7cUsjyehDe2wllnepUYJjvboAx9Rhs8we6kn+FHIeRx0Q
         4NBI4EG4oUAuAwIHaVcr0WUdipZ/HNmN2YAykSf0370dGcMOsNoXzAkPl3CuUeSgX0FQ
         zv3EVEE1um/IXdKipovGluQ54PDyplnxjv2K9ikovlEANHGS/UNcxs7hGM5ylJD+pe+4
         YiipDzBpjI15lUMXoHb7qDtCCWcSHuXcLmAzxn4b1cx++8suhnmzOKUxn6JprGg309SC
         N1VLG8SOEPQFYyu6d5JwcgUf86+Eraz6r6WYRZ32mz6cYXujhlIIg7/ctaNSPV/FK4uQ
         5uQQ==
X-Gm-Message-State: AODbwcAp4i4SuxYLInChigTWXa3VwWaIWtLxn4vMsT942sM9FxnPiDh5
        X7O2e5IdCr16AA==
X-Received: by 10.98.100.207 with SMTP id y198mr48798381pfb.139.1495769718736;
        Thu, 25 May 2017 20:35:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id a3sm16213279pfc.26.2017.05.25.20.35.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 05/13] config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
Date:   Fri, 26 May 2017 12:35:02 +0900
Message-Id: <20170526033510.1793-6-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index a25ffddb3e..1743890164 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -110,6 +110,7 @@ ifeq ($(uname_S),Darwin)
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
-- 
2.13.0-491-g71cfeddc25

