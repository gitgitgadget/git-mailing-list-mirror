Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB5020248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBVOlo (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:41:44 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37649 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVOln (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:41:43 -0500
Received: by mail-wm1-f44.google.com with SMTP id x10so2177470wmg.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AP9OjMrjnu/pgnXty4OBPLkHrwIV0UcEuqp+9Rxo28=;
        b=fdfyMVaCNzS+PEBnt2EnXMXgmLBQD0xtNUlpK1uioin+NnguMvVSnPuUJ14877F9ti
         V0MoJR82KZ4ow3pYZwk4niYMlSb4zjYWoJ47zvV4jpY1DCfKXo9+N6c/NLVaH82xwqik
         Olb6sUTz95bbJ4wkJysOPNc96YY5FJuM+Mr7hngAycpjZ6ypy7OVVu5AUgz13iVH+LB+
         QcZQyEurxK4jqu5D502AK4r+0krb2i80qrHMGkm0iMgmX0aSHmc9eQW29zeONWztsqjJ
         J1xehdAI9p9JdJDV4ifVm9ZD9s5RKMdEX9mvSOLcpP5qURFxxp0Eetle+2AeNc3ZyeXV
         TOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AP9OjMrjnu/pgnXty4OBPLkHrwIV0UcEuqp+9Rxo28=;
        b=YJCY0dp3kNbuBV8hXOyGXyLzcuxYmGiAhfNF6X4c3VRhIbBgroN68EIFi+txT/Dtmn
         13d5yttzmmGEEnFurFDwmq5PWcvMIN4tbqL1Gg5qTgrdQ6D67HZ4tDyYOgLGxRL4u4Ik
         jfgH+Uu7CRi6+blcOzGf1pXCfxmbRbTFvggD9FYAXnRPJ/a0VBmU0peYPaClu6C1KFhG
         NFpI7kNd49fE3RD6Vl7QIQW+OWpDSh5/bopwJc8hau0cRzTKarqfIfN4nxn9BlHOz87K
         bNvTCkr1blRUl4hBkL4GHI91iauiqytwjLyvNrUJKA5RrgmD15a/2yWJExOq9eji/xPo
         GY2A==
X-Gm-Message-State: AHQUAubyRp7ong7aCVarpvAPm7IWONG/N55UTBaOVnokDUhRY8Y87jVV
        DpSZHsx/vkMfDVgoBrypBLd908BWLPY=
X-Google-Smtp-Source: AHgI3IZuc5BFQevketaAhyrLJIbtvH3CRAMt1MYDFmft+CLsVIDQlkzY0T+znrZK2CIlrL5SDOUGBQ==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr2777374wmd.103.1550846501380;
        Fri, 22 Feb 2019 06:41:41 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z15sm1481689wmi.46.2019.02.22.06.41.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 06:41:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] Makefile: remove an out-of-date comment
Date:   Fri, 22 Feb 2019 15:41:22 +0100
Message-Id: <20190222144127.32248-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190222105658.26831-1-avarab@gmail.com>
References: <20190222105658.26831-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a comment referring to a caveat that hasn't been applicable
since 18b0fc1ce1 ("Git.pm: Kill Git.xs for now", 2006-09-23).

At the time of 8d7f586f13 ("Git.pm: Support for perl/ being built by a
different compiler", 2006-06-25) some of the code in perl would be
built by a C compiler, but support for that went away a few months
later in 18b0fc1ce1 discussed above.

Since my 20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple
make rules", 2017-12-10) the perl/ directory doesn't even have its own
build process.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index c5240942f2..97e922cc41 100644
--- a/Makefile
+++ b/Makefile
@@ -591,9 +591,6 @@ SPATCH_FLAGS = --all-includes --patch .
 
 ### --- END CONFIGURATION SECTION ---
 
-# Those must not be GNU-specific; they are shared with perl/ which may
-# be built by a different compiler. (Note that this is an artifact now
-# but it still might be nice to keep that distinction.)
 BASIC_CFLAGS = -I.
 BASIC_LDFLAGS =
 
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

