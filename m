Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC70F1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeJWTOn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 15:14:43 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:42160 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeJWTOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 15:14:43 -0400
Received: by mail-pl1-f181.google.com with SMTP id t6-v6so401577plo.9
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+Dn+BeVGNEulY+3roseGA4PkigzR/jWgFkAq9iVBL0U=;
        b=aDFaPUXV6CEfU2daFf54XOoy+BtIhyjtccOMvPHrAHxbOiJIGoA6BvMXplaZsSjaf7
         Ze+whFzBeFmccA+4qNQYf9jLGH9qlhckbyfYnF59cgq25WYbcghzIRFsBEfi8+jWflhG
         stGd6n+Co4zWMHC8M6yc4LVtG7kOFurw34Go6BIN+I6guR5S1haKjGHx3sblQDKGIQiq
         LBCBEHZ3XQ10jJuUDHSTgpg6/AnEZDX6BvoTliCfXmWacFBoHzSsSTlK1r8nUpHJQkMD
         nP7ALf+cefC08HV/rv5ZCA2oQcNFWkSMhafcZtB+LPvT/VYuZZ8F6yb/tu4Cu8MTd07p
         TQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Dn+BeVGNEulY+3roseGA4PkigzR/jWgFkAq9iVBL0U=;
        b=mhdcJvpJKzGr6olDw1bvlT4MU0Ja226+VQ/GHydxyEUnoTmMrSxbWowQH5Jke0Hp1C
         gp8Rk7by5Khh55nR0TLdExIw6xHj1qlJz8WNJ+M4p/eBq27Lss0RlaBbDouZyTQzms6u
         FQMWHe6l5sfqPzpLISN/LZQ27a+IVTkzfMC6imFWTefw7P5kSk8TFNGyLrX8jNDV4Hmr
         UaR8PAOzwBbsbp9p6UjfInILzSeVJpiRA0OwilNonjhzW/bkY+HmN1UbemDeQQ73GPku
         2kRp+NUfEpVsycDc+JnHvFvZEczPo8ItmTXzzQDGHoZi+h9+CBh0zHIbRJTZ2Extp422
         T0Cw==
X-Gm-Message-State: ABuFfoixEo/sWg9Q3dMV3m+2NzxihneGb4BJnrjDm82PyOR2gPPnqtqF
        apNbxdqL4dxnLSH5TrZsVJLpfUMq
X-Google-Smtp-Source: ACcGV600aqgx+k1JJYBUy8IJeTPF05QfWMirYd0NXIdZ2Lh/avBZJh9dJgN8y31vzSExoTGtggVuOQ==
X-Received: by 2002:a17:902:2907:: with SMTP id g7-v6mr48106309plb.201.1540291908502;
        Tue, 23 Oct 2018 03:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id e81-v6sm5219468pfb.153.2018.10.23.03.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:51:47 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:51:47 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:51:45 GMT
Message-Id: <pull.55.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Load system libraries the recommended way on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The search order for DLLs on Windows is a bit funny, and for system
libraries, it is recommended to use a strict search path.

In practice, this should not make a difference, as the library has been
loaded into memory already, and therefore the LoadLibrary() call would just
return the handle instead of loading the library again.

Johannes Schindelin (1):
  mingw: load system libraries the recommended way

 compat/mingw.c                                      | 3 ++-
 contrib/credential/wincred/git-credential-wincred.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)


base-commit: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-55%2Fdscho%2Fmingw-load-sys-dll-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-55/dscho/mingw-load-sys-dll-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/55
-- 
gitgitgadget
