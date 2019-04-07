Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADED20248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDGTwq (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45805 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfDGTwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so13780504wra.12
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NW4+opDdVu/9LRVIoTSM3VkGGEWZL0ek6J24n40cdfY=;
        b=N10BnWZa1ZgGvKb8xkDxF/fxx7cqfuB4tMc8Y945CUO6DICA8RZEVoIjcHR1OxwLUC
         G2ok+jPKBsoM3frpWVheyZ24/kK6gZxUaWIkxOUXd588kT7aX24/e5ld/eEzgIjO2CeT
         wR1pSuQd2c5q5aKJ4qVywnN5Iy+X4im/i25etbIVESV8mwAB2o/2RWlqNQfc7lZ5c0R5
         N8ZD89o8lG0zDeHdEdrDJx1wBATO+80DbRoire+ZJC5NWwVWsBYBIH+ty/30nFlmdfbQ
         jBilVo+XLmI1zO+/6r9GWPQ5lqlITs8I0eFBNyyJijWz4BGbZwhdOvxqfNgsoN9xsrrL
         DalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NW4+opDdVu/9LRVIoTSM3VkGGEWZL0ek6J24n40cdfY=;
        b=nS5t5j4yw+Z+0XLp/74G1P5vYZU4ULUlZJ4A88kEMD+3LUzLnKKDXLrxRvIQQniycE
         6+kVfTcXp+WQfTBeSw8mExV5c7CcXa2gNvcih45pukrJYUeZ8shD73vroHBL29nlNPQi
         +5eRdzcnW0UwMO2lSF8OkLcCOMHrBTnPvjtkBX+19RpCLnWIth2EekBBXb2SonJI/a1C
         8+BVTOZnk8PknGNp7KJlD0KFhXbzli/vJ/oEUlg2NKYbe0ZA3B0M74DobyiYzCERWoK4
         siv5Cls/oREs8brdXnIut+IxtEY5yoKofAfUCW2uuO2qp896Hoe4yRQnufokasDwZ06T
         xJ+g==
X-Gm-Message-State: APjAAAVk+Dkx92CfGRTEof56vC/H4hWdJId82ERC/H4kz1Az0Z7cRCs3
        Q0ptnRsSFISBe12VtHRm5w08jK3XMKI=
X-Google-Smtp-Source: APXvYqzhLHX90n80vnT9078gKQu8E0oEreLB//YIGUT+LMNlmssu+rbT0ddfVP8O2bxxUyi6jkTBPQ==
X-Received: by 2002:adf:f607:: with SMTP id t7mr16927327wrp.191.1554666763971;
        Sun, 07 Apr 2019 12:52:43 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:42 -0700 (PDT)
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
Subject: [PATCH v4 06/11] gc docs: fix formatting for "gc.writeCommitGraph"
Date:   Sun,  7 Apr 2019 21:52:12 +0200
Message-Id: <20190407195217.3607-7-avarab@gmail.com>
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

Change the AsciiDoc formatting so that an example of "gc --auto" isn't
rendered as "git-gc(1) --auto", but as "git gc --auto". This is
consistent with the rest of the links and command examples in this
documentation.

The formatting I'm changing was initially introduced in
d5d5d7b641 ("gc: automatically write commit-graph files", 2018-06-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 3e7fc052d9..56918a5008 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -59,8 +59,8 @@ will also be excluded (this is the equivalent of running `git gc` with
 
 gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
-	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
-	'--auto' the commit-graph will be updated if housekeeping is
+	linkgit:git-gc[1] is run. When using `git gc --auto`
+	the commit-graph will be updated if housekeeping is
 	required. Default is false. See linkgit:git-commit-graph[1]
 	for details.
 
-- 
2.21.0.392.gf8f6787159e

