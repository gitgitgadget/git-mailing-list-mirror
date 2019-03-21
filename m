Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5984D20248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCUUvT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53168 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCUUvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so151538wma.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ+Tll2o8YpI1TmzYeKqWi+bKk2sRZoEFWzP+4GO/8Y=;
        b=PrMxpjhnl1tbsxxaTWEa/EvBL9PLJXM5Kqa6rBa98bBIZcHYiRXnovHj7sB5rl0/Ph
         Ey2OnIU+lLkHHdM2bPPvVpOoHUr2v0ozh1i3uJdTerzQU01YNBMYeUspXRbzkd+oIKsm
         IJjL4nHsRCubUDqCPpd0bi0P3MTbuNEki08s0a+FYgurEenTnIjhsYXQlkhVd0Ioi/XS
         u7Uncp/EUBZM4uIzheF70eiv8A40YKYr6afH83SIK1Iu/ScNf0qlhoO7IrvKK7sTSEGK
         cgH/4c1v1VJYoZDAun2iLzmlZD2noCCF8K4NzbHqm183BDdON78QDXB/+uc6v4qhU4Np
         LGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ+Tll2o8YpI1TmzYeKqWi+bKk2sRZoEFWzP+4GO/8Y=;
        b=twuY1k+qfBVHjcskPIg9Yb69n8j5ZVztsl2Gf5tR7JVaFMRaURqQdLrPzHnzvLNoXN
         +oeYY0FJtQRjze/nF50XdB1bSPxOTHudTISZTqCLZQAaqrZ2yJ3IUm6xTD8q10Axao0g
         KP3aF5y5+MWMbbfbs4iCxEZCqO6bbMsg9ZPRHPkEcg7XKkgMeOJ8r1G0hilYFMFvXhxO
         Ub/xMFloGXaAltNhYVd9TJn3TKz3HtLG7tNUE9DsUrbyUdGay1dp+pYfUC8ThOrveS6T
         k+iFUdcvCmVAkBZ9AWtNoxoNnUN80/0osDUivL2egWuIxv0irKzU4rYRRnJRuxLtjCES
         yauA==
X-Gm-Message-State: APjAAAUZIWKuE/kjxGjp1t3pPFaFZHI9zKA0uuaib5/9OQTcoLXdNlVY
        rDQjO8CFiZ0lNPnui/AHwjBIjQGZ
X-Google-Smtp-Source: APXvYqx0hT5CmxP/laQOEbrIG92Me/r5YHW20kR2siWrc2xCvkd3ealhG8RoARoVo8CRALxkbIDlEw==
X-Received: by 2002:a1c:3845:: with SMTP id f66mr760484wma.41.1553201475525;
        Thu, 21 Mar 2019 13:51:15 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] gc docs: note "gc --aggressive" in "fast-import"
Date:   Thu, 21 Mar 2019 21:50:52 +0100
Message-Id: <20190321205054.17109-9-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "PACKFILE OPTIMIZATION" section in "fast-import" to explain
that simply running "git gc --aggressive" after a "fast-import" should
properly optimize the repository. This is simpler and more effective
than the existing "repack" advice (which I'm keeping as it helps
explain things) because it e.g. also packs the newly imported refs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-import.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 43ab3b1637..2248755cb7 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1396,6 +1396,13 @@ deltas are suboptimal (see above) then also adding the `-f` option
 to force recomputation of all deltas can significantly reduce the
 final packfile size (30-50% smaller can be quite typical).
 
+Instead of running `git repack` you can also run `git gc
+--aggressive`, which will also optimize other things after an import
+(e.g. pack loose refs). As noted in the "AGGRESSIVE" section in
+linkgit:git-gc[1] the `--aggressive` option will find new deltas with
+the `-f` option to linkgit:git-repack[1]. For the reasons elaborated
+on above using `--aggressive` after a fast-import is one of the few
+cases where it's known to be worthwhile.
 
 MEMORY UTILIZATION
 ------------------
-- 
2.21.0.360.g471c308f928

