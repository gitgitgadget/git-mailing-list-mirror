Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B90A1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 09:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeCCJXV (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 04:23:21 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34462 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeCCJXU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 04:23:20 -0500
Received: by mail-pl0-f68.google.com with SMTP id u13-v6so7091608plq.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 01:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdam5EvaPYcBnF8fcBUqRDvrMZRuFXAEkwLcPj0mkNw=;
        b=nKQjt4sN9Rs/kCGbfRAACR6VSRlfSdJ3FZ3RdAB2Yk/Ig9RmV4CamuH00GIH2FFZHz
         AHx5p2EcjjL4MFMPUt74ZSR2QqUyVoQRB95kofRh2LsjgSdnA+3S1G96+reB3pnq3JsJ
         K1jYVcOQw7X225EkCu4lO2oXh6kq+JfuunGyRbnWxP2HeknzpNVO7sMv563vFCYouGm6
         PRL+xbDu8nXEhZ20Z6KAg9rhcS7XXvCgtp9IsUsi4JRyEYPe5q7KldtRye8L38V7I46J
         XpfYJI1ZCWl/KApRzCWXZZzRQ5l2wOWIBryIAD34oHQ4OAZydrA+gBXKfr6lmzA6YV7c
         5d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdam5EvaPYcBnF8fcBUqRDvrMZRuFXAEkwLcPj0mkNw=;
        b=acz1JykJ6RW24VNG6A93T0KGMPLKLZ168slhed3aapIe/4VySC7EoNb3qQ8oI8L5Y+
         wTaNu7tZr5IWH1OXl1B0yL1EfuScJvCAUy/PLCFWTD4ccgjoaZVPMYFswsZg3AJpw4li
         LhtI2YZAIbO7oyQKg50Pk7Mx+ObS88gY1GhyhJG/oGItXIm165n/N9aT/ChobcSnygY+
         Fc+okZF8aGCBsvRpWwcHDUIQkS0b+qRn6AmByKdU7ejMJsg+ZUorEFZNVFEOgI40dbA0
         3P1mcsZ+4hV3vnWDYhyBDuk93x0KXHM9IhUxZfo6DWDf5AD5rUoGcdaNNCIS+xP46YU5
         VD1g==
X-Gm-Message-State: APf1xPDIj04D2esG+xtbXaJCHH3y/qY1+V1NNeCESaXKzoJZkPQ2zXno
        tAd92Ro4JKawpeYY7hRNg0cdkA==
X-Google-Smtp-Source: AG47ELtynmKef6VLBBMmrmR2EYoZNBw5FNG1zS+GleUM4nR/o4hWNGKQeIG/gOsPcX2umF5b/paDFw==
X-Received: by 2002:a17:902:5203:: with SMTP id z3-v6mr7914559plh.392.1520069000166;
        Sat, 03 Mar 2018 01:23:20 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id z4sm12252209pgb.4.2018.03.03.01.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 01:23:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 16:23:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] nd/parseopt-completion fixups
Date:   Sat,  3 Mar 2018 16:23:05 +0700
Message-Id: <20180303092307.3796-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This addresses some comments from v3 [1]. Since the series has been
merged to 'next', we do incremental updates instead:

- --rerere-autoupdate is completable on am, revert and cherry-pick
- simplification in _git_notes which leads to completion in 'git notes
  remove'

[1] https://public-inbox.org/git/20180209110221.27224-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (2):
  completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
  completion: simplify _git_notes

 contrib/completion/git-completion.bash | 18 +++---------------
 parse-options.h                        |  4 ++--
 rerere.h                               |  3 +--
 3 files changed, 6 insertions(+), 19 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

