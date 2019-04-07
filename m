Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615D220248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDGTwm (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42894 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGTwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so13801914wrx.9
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rv0YnLxyRpkCQGuIDpJ1CuA4iztjW/Axkpa/KLUPgk=;
        b=hW/mmZPd3ioubConzDD8fFyPjGOeYNKH61gobNBudhx+1UNEsV7MG5NhyedB9P5MEu
         J8VdjXM/IlS++rJgTlC20LzKPYN/sDYX2nANeeSjF8ZLBlPYM1DfAEE8/ujCXoSTN9N7
         s40PYrG5UO9WhNLVNKuXrxgtVCdCx0CMuyM0mUOUT8tIpatmexuKVFW4aaIonX+A3lNq
         Khy7Jk1JtkW8oIPlM0yBSWJQqo3mQWpoTT7vZ+w0ATrpbY3ZF47OCChDVONBFcxAFlaB
         jtDoFJI7SPD/5Jy57vGpJ4S8et9NdVv4IF6tD2NhBPNVOvDSUcP+F94F10N6qCXVAvua
         pWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rv0YnLxyRpkCQGuIDpJ1CuA4iztjW/Axkpa/KLUPgk=;
        b=ao/QTkRrUt349b1KVCmsbC6LJkladq9mjzkrIwEUgK9IRKsk8t8TX0qri1EvCcS51S
         L3Op+Hhkb4RmZ2WkwxGjTShcO2X+jmYhuDdlGTlx0UNqzv41+mUJrarMl9bduGOlx6w9
         Qf+BhywrxgD/Cq/sabX7o/L8X2quAN4sg9qTlx1mbOjgmoECBQFyEfwptV8qPNF4ImwT
         cyXuHIiszFCdXgmdjDeJtjk9RngbYsUMpWXuZF8ux1+mUrHPh+aldrzivcp21rtlqyqR
         nIVh1VoQXk5XY1HsG9TgV5FpR+ctMi1PIL0Ps5OJ6Jz0nFc2VymRkZtKDOq9gALdmLDj
         wdHQ==
X-Gm-Message-State: APjAAAVA3h17HZa7YY/J93ElWgcRzpiQK7eqmhdYqrm5L4v74aXtQ0/i
        mS67VytKOTJTMyq0goOjBWAiEN5I
X-Google-Smtp-Source: APXvYqzrhshkRtHtdb2mPxgkQ4bemzKhCZmjJ4TVXujUIPrNdw/fMmIgTGq5GnYG58OVeaxQzIRoeQ==
X-Received: by 2002:adf:f344:: with SMTP id e4mr17260865wrp.77.1554666759946;
        Sun, 07 Apr 2019 12:52:39 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:39 -0700 (PDT)
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
Subject: [PATCH v4 03/11] gc docs: clean grammar for "gc.bigPackThreshold"
Date:   Sun,  7 Apr 2019 21:52:09 +0200
Message-Id: <20190407195217.3607-4-avarab@gmail.com>
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

Clean up the grammar in the documentation for
"gc.bigPackThreshold". This documentation was added in 9806f5a7bf ("gc
--auto: exclude base pack if not enough mem to "repack -ad"",
2018-04-15).

Saying "the amount of memory estimated for" flows more smoothly than
the previous "the amount of memory is estimated not enough".

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c56f4f7cde..66386439b7 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -59,8 +59,8 @@ If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file
 or over `gc.bigPackThreshold` limit)
 are consolidated into a single pack.
-If the amount of memory is estimated not enough for `git repack` to
-run smoothly and `gc.bigPackThreshold` is not set, the largest
+If the amount of memory estimated for `git repack` to run smoothly is
+not available and `gc.bigPackThreshold` is not set, the largest
 pack will also be excluded (this is the equivalent of running `git gc`
 with `--keep-base-pack`).
 Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
-- 
2.21.0.392.gf8f6787159e

