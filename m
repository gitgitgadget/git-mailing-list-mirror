Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B651F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 09:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeKNTRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 14:17:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34672 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeKNTRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 14:17:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so16393722wre.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 01:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8NdEGM5JVMOIv0iNJtS8e3wqrjVRRCOh3nDCLbwbmI=;
        b=QrDznH0bBKNWy4gS8nHrFc7irQBDorayAC3iGHUPHliGMtHe2pVg0+/heCwb6/yuiw
         T200EH9Frb1ceFqpb77RJPz1LpGUnF3a2taLnYlu8p89Cc1qNtp8NxNVVe0O8vwW0Xia
         Jfg1LvAiEoHjnYkyFBNLDl+JKjL6H+6A0TtWfvF2p/IUte0e9KoxiGtfi43bMN7lZCAw
         iRacKTCeDxqGRBdP6NsgOFevbmymLPY1AmaBnEkYWeCngUHKJbha1J7R8rhBTVp+qFtJ
         cvUAfGW3CjSx9Ige/MEHmnePywdDlGeog+tgE1vGTc0T722Jh+S7zyszBFJydfz1sAvv
         2zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8NdEGM5JVMOIv0iNJtS8e3wqrjVRRCOh3nDCLbwbmI=;
        b=m4ZRwn9IBrYdYCjEUyKnFY2TfP6KrK5ED6Jw07siCdoNFpXfrkgfp13wbCL1hn8vGm
         PFvTrkQvSy476SuEWMEp/bAC82Ecu3zUrtIHRuYE+Utgwy77cJpiLVV9AdDf8XKiWE9D
         cVGkSW6tKV2khQ+nrIv1S6dfJDu0QH6rMYFhvtDqHlfLQfieT8EaD4J0hSkeVvFpiD4F
         7SusYCUiHMrKuRYqSAaCs28FEKZfTGfwYHZz8WkrtZGSInd9IDEAlLS31WuaZwXWUiLI
         P0HNzCDh+ctjIrLYuEVqxC+kdnXhDjhbLvUs+3PKnomFdA8tKhW6q3+ZhpszW1q6sj6e
         ULBg==
X-Gm-Message-State: AGRZ1gJbI6WIVdkT/ftAn8m8ZO00mI89k2QN0EnTBtFGTd36BKskT/fb
        PYH3thDqnIaHHAeXLxMaS61M+hTgyuc=
X-Google-Smtp-Source: AJdET5fa4bq6brVc2VQiUtZaptBgbgc7z/uL5N2BD00hxURlX6rTUODNPBuoIYyQECQrKtcu8M1YZg==
X-Received: by 2002:adf:e983:: with SMTP id h3-v6mr1042668wrm.58.1542186920164;
        Wed, 14 Nov 2018 01:15:20 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm16385228wrt.49.2018.11.14.01.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:15:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] rebase doc: document rebase.useBuiltin
Date:   Wed, 14 Nov 2018 09:15:05 +0000
Message-Id: <20181114091506.1452-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <0181114090144.31412-1-avarab@gmail.com>
References: <0181114090144.31412-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rebase.useBuiltin variable introduced in 55071ea248 ("rebase:
start implementing it as a builtin", 2018-08-07) was turned on by
default in 5541bd5b8f ("rebase: default to using the builtin rebase",
2018-08-08), but had no documentation.

Let's document it so that users who run into any stability issues with
the C rewrite know there's an escape hatch[1], and make it clear that
needing to turn off builtin rebase means you've found a bug in git.

1. https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/rebase.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 42e1ba7575..f079bf6b7e 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -1,3 +1,17 @@
+rebase.useBuiltin::
+	Set to `false` to use the legacy shellscript implementation of
+	linkgit:git-rebase[1]. Is `true` by default, which means use
+	the built-in rewrite of it in C.
++
+The C rewrite is first included with Git version 2.20. This option
+serves an an escape hatch to re-enable the legacy version in case any
+bugs are found in the rewrite. This option and the shellscript version
+of linkgit:git-rebase[1] will be removed in some future release.
++
+If you find some reason to set this option to `false` other than
+one-off testing you should report the behavior difference as a bug in
+git.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
-- 
2.19.1.1182.g4ecb1133ce

