Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726971F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeFBLvA (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:51:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43723 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeFBLu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:50:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so23183507wrm.10
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=LPxev3/UrZ7ZVCDCbICCcPL2gSvqNtooZ1G994R/y4cbg6oWvsZN0KpDEG6CamIJrV
         A8d6oiPnHbDQmIAukvfrJa/rDASnnOEY8fMoWogNAruwC+szrjXUEmNE6sPn9f45TVBB
         6SkLlhKADXbOl7lWnYOD5kldXngSsi2OMAOPtFKxyVd6N/N8vFDQg90KPCB0Yp5BhiQp
         JdX4iCXJqoMUj7h/lY3iONjCZtIFhshB2vhd/UUt97j6+CM2HaL/hbLZTcyr85TmCV6h
         /alcKqbD3YxN0dM/kYguw0UfprlPhKk8KuZJi5xFdVcAojHlAGSCyG0U2RQ8sal+auYd
         p2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=WLZaUZOQAbQfBXQctsjeixIeW/Clhso5zCXZMTEwKdL+nuC3mx/9vQRgrIEo7jwABK
         xBCrV2P+oc1wSoQJF2lzr9wgC8CTxF4u0w9XCuWy4DC4jOFXu2KlexPHh30tysZtQNgx
         lUZgC/yZuSj+CbkL/aMMj8k99ut9Ks6+VC8JrGvFz0XRh3/7epdUrGaYHvXsy8YuqmzQ
         6xdtgffszn5muzeXteQf5N7BiqkmpOKA5D2ov3Q5lUkQkj5Q4s703iVttC+EY/eKZk0r
         PV/Z2t2y4cKggyke4RrPW9FQ/+9ubhv3xR/hSwNrNpH4AB5fZd74u8vsJhqKG9nHIluE
         HLvg==
X-Gm-Message-State: ALKqPwdvPL5//Gj6IuxU/M6mN0z/NyS1r7Tp95kxSUYcfCr00LStq4Xd
        5EhbuLsLyFrMwJJ7pzSIT0djapJH
X-Google-Smtp-Source: ADUXVKJQtQ+XCY4HvtjbXtILIUaTfoO++a3q111P2/golbriu8BUG3TtF86ZopFCIqsD8ymgB7kZHQ==
X-Received: by 2002:adf:f112:: with SMTP id r18-v6mr10708530wro.134.1527940255080;
        Sat, 02 Jun 2018 04:50:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:50:54 -0700 (PDT)
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
Subject: [PATCH v6 2/8] checkout.h: wrap the arguments to unique_tracking_name()
Date:   Sat,  2 Jun 2018 11:50:36 +0000
Message-Id: <20180602115042.18167-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The line was too long already, and will be longer still when a later
change adds another argument.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checkout.h b/checkout.h
index 9980711179..4cd4cd1c23 100644
--- a/checkout.h
+++ b/checkout.h
@@ -8,6 +8,7 @@
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-extern const char *unique_tracking_name(const char *name, struct object_id *oid);
+extern const char *unique_tracking_name(const char *name,
+					struct object_id *oid);
 
 #endif /* CHECKOUT_H */
-- 
2.17.0.290.gded63e768a

