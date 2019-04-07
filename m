Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4269B20248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfDGTwl (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34360 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGTwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so13867378wrq.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZS9CqQWCd0ef1TG4R/YHUa/z7JHJOFvfGolVnJBi6uI=;
        b=cpsJ+hVo5NQkTK8oEgj76FBhwhMr1LWXsav9bjZ3ZD3/jczJcrmTRwWgJ0e5yyKzJa
         co4oz5z7M+pXnenJgbnj47aAxR6x1FmwMR0cVyzceb9OA1y3D2TQfgwiSHkVU1h3FdI/
         oMacc0836GzIfzu6Ldmv5V3k6IAWccVNUcR38nqy9ENVB/IHkZbEj3Y/UrJwcY0ckXFY
         0ZM7Ff7ZhYiJCkEqzgsnbLlIV4rZy/1hx3x+7+uyM5cGl8AKKyUFozpUuqVvQBLZFVyh
         Dej5nI64shOIndCCSx64e1T2Q2n5Qrr9gy3Do+fSS+b33fZzIJ4Cn5MPXwHC3iNn2fBK
         zhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS9CqQWCd0ef1TG4R/YHUa/z7JHJOFvfGolVnJBi6uI=;
        b=XrTFSHwvi1dY7jXGMoIy2P3Ekb6XLpzbSyWdmMrteZj/iG3b+Hiz/g0EzLfsIgYydY
         dRMJGAsCMEfvdj8Us/tkQEUJZLn4DnPm72ZGfedd1kkuRoNSycV3M0jZdRRsX8h3pnzV
         YqdgqKd6h7FcK4PkCaoUrzbj6HEihCVQQTwaTJdkjOwxvkKJC15TSlcelQpZVzq8gC+G
         JVtnNeGQPcAMACHQKHe+ciWW4yY6BLDM32VK2FIHB1P9EtCIrJco/Oasj055QMxszDM5
         vtmA0ThVHBDl5Qmxa9P+pxrTgFAA4jwstBbFvdf09hXMtVymyFAk7PxbrGeq7rXRQ6+r
         gURw==
X-Gm-Message-State: APjAAAVL29POWcVa2lBM65vNpFhsrIAk8k0hXvwdJtfpPmMwDTBRJ4Fm
        AUIkynYOgEQOQxWq1Sog9Nx2FxcH
X-Google-Smtp-Source: APXvYqzaoehavik2pbDfYvkHeSpGFgSRohEJzk498UC8KIUuuSQydW9AzYNo/QTAl310HHGmck25lw==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr6970100wru.58.1554666758980;
        Sun, 07 Apr 2019 12:52:38 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:38 -0700 (PDT)
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
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/11] gc docs: stop noting "repack" flags
Date:   Sun,  7 Apr 2019 21:52:08 +0200
Message-Id: <20190407195217.3607-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the mention of specific flags from the "gc" documentation, and
leave it at describing what we'll do instead. As seen in builtin/gc.c
we'll use various repack flags depending on what we detect we need to
do, so this isn't always accurate.

More importantly, a subsequent change is about to remove all this
documentation and replace it with an include of the gc.* docs in
git-config(1). By first changing this it's easier to reason about that
subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index dd22eecc79..c56f4f7cde 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -52,14 +52,13 @@ OPTIONS
 +
 If the number of loose objects exceeds the value of the `gc.auto`
 configuration variable, then all loose objects are combined into a
-single pack using `git repack -d -l`.  Setting the value of `gc.auto`
+single pack.  Setting the value of `gc.auto`
 to 0 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file
 or over `gc.bigPackThreshold` limit)
-are consolidated into a single pack by using the `-A` option of
-'git repack'.
+are consolidated into a single pack.
 If the amount of memory is estimated not enough for `git repack` to
 run smoothly and `gc.bigPackThreshold` is not set, the largest
 pack will also be excluded (this is the equivalent of running `git gc`
-- 
2.21.0.392.gf8f6787159e

