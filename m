Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A931F461
	for <e@80x24.org>; Tue, 14 May 2019 09:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENJTQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:19:16 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40769 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfENJTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:19:16 -0400
Received: by mail-ed1-f43.google.com with SMTP id j12so21100515eds.7
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2mWMu7J6QlZOC9GxToDSDos9Vy98+n/MbZCt0Jizwlg=;
        b=QxTFKtSGhH24MzvVfhYnhP97NCgOESmF4Juiw7c9flZSrDiQ6GFBAaP43QPsJ26/zL
         JFqhSpAkD0oIyaWXoApp6eZtd+disJjuxxDI8pvAA0lMY/8xgB/WSCTc+2Mp3ESg3WXV
         YuRiOrspMtoVsUBMVJWr5PgRn+utMLBUyHbAp6gEWW+4pg02/4nFe4AXFjw4YJMv6AbS
         guOVpFdysiDB3jG9vDAcWoZVsCQsAkOrTY49ZUuczyADJUl6To4bm8guofZigTUk/arS
         FDTa7NTXKzi3TVWgj4dbhR2XToLpq538cf2nVSvtNMexb/vUrRsg5DjUD1uGGtEWO/lI
         t6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2mWMu7J6QlZOC9GxToDSDos9Vy98+n/MbZCt0Jizwlg=;
        b=hH49mPKm7KyPaZXXRYrN+I5CURZNaYlOd7xCqho73b5Z9nUWEus+Wig6ZeMHTMAj6B
         knoKupxP0KAL/fvDnUqFzYfmkzcX14ssNwQn5q1xRJ2WCB/eBpoFX8mMeHYU48GXIKig
         DRCKXnxoG4YTMv1UXZlVbsNi11X3R6Z06ImYjt9cC7cuSaimbJ/gZszfGQD6JaybkkFl
         xiJ2NhoFm2rMXjy1iy5Tu+htKp5ZNeHBteEKowyJMYFJYE3X9rX593WRZBDXYJY+5B5x
         01max/hEKvy3Fy5wavP2qF7FyiJml0BDfyUL8eniO3QCA9yUB0sTqDU5oIoPTmKwnrIi
         uDkg==
X-Gm-Message-State: APjAAAXQHzhE6f7AN+r2wAMAcpXIdTe4v0eaOdOcExR4czYHZ+T9sXTn
        0ICLtxn0XMOMv5lnZFEmCZFjrXL6
X-Google-Smtp-Source: APXvYqzIVKbXo2tOTMRPU6e1C1A4hQzJNWjFdsIDzXXzXDByRBsZJT1znX0RZl04Ex/T28b/YbSqTA==
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr26242357ejd.249.1557825554849;
        Tue, 14 May 2019 02:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm4390693eda.42.2019.05.14.02.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 02:19:14 -0700 (PDT)
Date:   Tue, 14 May 2019 02:19:14 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 09:19:12 GMT
Message-Id: <pull.193.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Document the stash.useBuiltin escape hatch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shamelessly copy-edited from Ævar's d8d0a546f0 (rebase doc: document
rebase.useBuiltin, 2018-11-14)

:-D

Johannes Schindelin (1):
  stash: document stash.useBuiltin

 Documentation/config/stash.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)


base-commit: ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-193%2Fdscho%2Fbuiltin-stash-knob-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-193/dscho/builtin-stash-knob-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/193
-- 
gitgitgadget
