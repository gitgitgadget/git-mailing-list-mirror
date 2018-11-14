Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FC81F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 09:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbeKNTES (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 14:04:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37613 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNTER (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 14:04:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so13899671wmc.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 01:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8NdEGM5JVMOIv0iNJtS8e3wqrjVRRCOh3nDCLbwbmI=;
        b=IwE78ljB9cwhi0fCKXjjvmAvxa8w+F+raGXuR/RqFAZUgV5fCbHABC/cWQ/xRh+x6e
         I/M3P6xe+iAfiBGRiPiFs3iO8IFzcMk40rtx3LSpWul/xttlxSF/SqT29wvj/nPyWSdB
         CCokzB+98gLDU33yRV7Djj09EfkcABfWCVY64qSdpSvdns04UBD6O522NyJo/D+CMIRa
         xGrmllWxOHPqjYRN9bSDO4QzYajJvyZpwkQeBzOY+r/XdHHdv2mWQ3D/xmmcxx4ONpdK
         0XFL6nuLFwO+p2mzvkdJ049ButCzCkH1z9r0p/1aDxzd7BqzDkwJlnyhAAG6tzY/qbfU
         K3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8NdEGM5JVMOIv0iNJtS8e3wqrjVRRCOh3nDCLbwbmI=;
        b=RnKubLJCo+NB5XYbe07aOE30Nyez6MDp+uiDo0bC4qI5Ib+wfgouZD7nHZmXdzaIxg
         gdBvWeva2bVIsCZ/ySRMXzQwmgatqlBFtHGZgNjWSAH3aKAU7nwy1PvDUr35tKyxNHhg
         QgUHEYMDdd3m3L5ha4WuFoax5nSA2uVr3+BvnuMMfUf+qYy4xj155HRC8OA8wQnp+NTm
         FFOaZdPPOyiXoIgFTdi2QaHNCWWwRrcef7FCQ/iqwskukNE2Q4n4AchSRdYpNYqoLcoI
         SHQD4g0aur1tQ+hXCz8ciLDJp+eYn4OaORGI1Mn2oHUD4c9f7Mhqyv0aPxHfSb+oNUMt
         K8hw==
X-Gm-Message-State: AGRZ1gI4KCXC8Ux67FJS54cgqhVWNscd0WRZfyeoiPxz71G15NPOTgpC
        myHFXwqZvVycZVq/oEk/MUQs53+XL/0=
X-Google-Smtp-Source: AJdET5eUko5+3/GprbwlVnVxO5Di7SZD3cbENraqW10qRUqJ984TlJ2oL5JqLbg0BZCyaAsFUsX0Eg==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203-v6mr1032552wmf.97.1542186116196;
        Wed, 14 Nov 2018 01:01:56 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e10-v6sm28782471wrp.56.2018.11.14.01.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:01:55 -0800 (PST)
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
Subject: [PATCH 1/2] rebase doc: document rebase.useBuiltin
Date:   Wed, 14 Nov 2018 09:01:43 +0000
Message-Id: <20181114090144.31412-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com>
References: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com>
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

