Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAAE1F428
	for <e@80x24.org>; Fri, 29 Dec 2017 09:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755322AbdL2JEv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 04:04:51 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:41421 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755163AbdL2JEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 04:04:48 -0500
Received: by mail-wm0-f49.google.com with SMTP id g75so47603592wme.0
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 01:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZiDQmAraD0b5Eruwr0hcMCfIFrlREnrGtW7emFHBSko=;
        b=QxkNuxMOufvA6SaZb61qx2YsP5cj9hjYJgt33o1O0Fk8+2+MXhUA5buqDy4ZNQkb8r
         tEnpHJr6fDUgHZShDOPVn7ceFDFRxVh549Cs4C8S/xgOvJVrlCsk3tKwwawTJZkMEEuD
         yJZeb97PP9nAowQjyLiJIxHTuu2tw5PWxAZoyracNWh008/DCvJDfrJfeIQkWz0cXP2a
         LOjoue3vJNITIxwAYnSROUCKwN4to2d8jwNyVIKROvzvJUcDZ//SPTMvEc9Owwb1Qq4O
         7pJUKESfanVPGUnBFO4YzOR/ndAfFzljDEVJsBGWI7I0UXiJ8ndGP40ideLIsSdKDMvo
         /iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZiDQmAraD0b5Eruwr0hcMCfIFrlREnrGtW7emFHBSko=;
        b=PxqSfoJsPvejbXC5FbOu5JF1vUOJR2D8TyPckg2p0gryvBXk4tMWKduizYJjzpXjGM
         t7Ksu+F7M1nI8Ycc/p7DGvYhm1kDerSU/ld6e8C20rETobmzkhsZlcpC3Wiwx/hwgAwN
         XVkAvkDO6dmERRWvdidgWUBWY4EArziPwhv3JF657MOqSDfJqVusQaEi+wzQx186aHut
         NTol6JOtiSzVITYwjF1RYGwJXdvtdrDizpMZliRbHMF2L9317yVU9bAl+LUFTiA+mJne
         waHUEpvmFLVj8um1OJmG/UyPAYBYPHpxX0MZaDunysWexIr2SgJ8+9LIVjHZcnHf+o27
         zy7Q==
X-Gm-Message-State: AKGB3mKphGIwTrC4m5sY2pWCr/LvyeoVtEz25T04ip6acmutUXsRy1Cc
        flzlu7F5RuUY/MwOU/VAp78uLq6OoXpkZpMwR+sIfw==
X-Google-Smtp-Source: ACJfBoukclEGTupp86v6hfNWR6L0MfjDP0LPMkGbFt5ufw9JP7/wmOpz7n76y0KwS3IR6hQTV3b+Ec0x91EM+powwVo=
X-Received: by 10.80.188.20 with SMTP id j20mr43285782edh.243.1514538287352;
 Fri, 29 Dec 2017 01:04:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.170 with HTTP; Fri, 29 Dec 2017 01:04:46 -0800 (PST)
From:   Andrew Tsykhonya <andrew.tsykhonya@gmail.com>
Date:   Fri, 29 Dec 2017 11:04:46 +0200
Message-ID: <CAO2669gb9+VEEkS2Pa=ZNbA9FsZT2t-7MmG9Nc=-nmB3Rcicig@mail.gmail.com>
Subject: Segfault
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash pop resulted in crash:
/usr/local/Cellar/git/2.10.2/libexec/git-core/git-stash: line 470:
14946 Segmentation fault: 11 git merge-recursive $b_tree -- $c_tree
$w_tree

although, the changes have been applied successfully.
