Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769891F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeAXJyM (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:12 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39262 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeAXJyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:10 -0500
Received: by mail-pf0-f195.google.com with SMTP id e11so2638520pff.6
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kluIeNFVquo89yj0FG1d3zTztDFIbMhPhsMjy+DqjU=;
        b=CN7t6tVNpLpxXSgiHq/vJ/JUAlUa4jEYBkEA6IGQgHBFBhx2EbpC3siobZGGVH+LqX
         u2ZDb6HreC741ZfNIU1znMq43ktb0kz6iBDxAq5sxdGfkyBw3omIFDTTUjx5mPHI5GOk
         gAW1EIK/haiMgN+olF2/l+yZLdnJtpSfhxl8h6YRteQqJYWHtbeom29QoNKJEfoS0VWN
         HVNAlPAEfbBUluN9SoTu86QefCdEwsoyEzOsjrbbC5Uece0xczafDIDppD+p+bReh12E
         yIIqyFEeMBPvYuyqa4PGBmkDjzptPxf+keDG6cmzCNNAdreQ8W0CcsUx+lBQVAYBiYSZ
         BiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kluIeNFVquo89yj0FG1d3zTztDFIbMhPhsMjy+DqjU=;
        b=cQ0vb+vQyB4u+nnOcZmm6jlo2I0oIT8CnI9bnYTxw2rDTxBSBA1tcjbX2b2bqXOCts
         KaG7z0SHA98HJJTPHWb40bKFvVa3EnBZbSFUaBKlTwhRBkwo2/KUAjUBePtIEGd5vRWZ
         UljwdDIwVFjANGsU9+E0ekiMILCELJ5UqOgTuu0bjQkslw65/YcU/OovBiPG79xatEIV
         DhC7sogmrHeYiv+j1wEGHzUW1Fsu8oqKKLbJACjG6oumq9m/bgUajfgCS62rcDa+Xset
         Pfq8E4kW6UDA7hRl0zBDQWQExBM3/iAlcjDeZkaS2OVjbBCHPrMjgnriF+hzmswyV9ok
         xXOg==
X-Gm-Message-State: AKwxytdjxJqyP37s04dC7udiAsAIAJi35rN+XDnMoAZXwGQMx03ZB51T
        aHEADVMUqkNco2bx7BbwmJ0nDQ==
X-Google-Smtp-Source: AH8x2254I/drwMQoVnzBzU6sfdhYyhilpa/en/o0yc0OYMvEz/mynb4SqVA0NZlv/E1zDWKIelHS5w==
X-Received: by 10.99.116.26 with SMTP id p26mr10875394pgc.320.1516787650215;
        Wed, 24 Jan 2018 01:54:10 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id v43sm35616057pgn.30.2018.01.24.01.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/7] nd/worktree-move reboot
Date:   Wed, 24 Jan 2018 16:53:50 +0700
Message-Id: <20180124095357.19645-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds two more commands "git worktree move" and "git
worktree remove" to do those things. I think I have addressed all
comments from the mail threads referenced in "What's cooking" mails. I
also added the ability to remove a worktree if its worktree area is
already deleted.

It's a big code change (I reorganized remove_worktree() a bit for
example to keep the last/new patch clean) so I'm not going to send
interdiff.

There's only one thing left that I should do, mentioned in 6/7, to
print detached HEAD before we remove a worktree. But I think if that's
a good idea, it could be done separately on top.

Big thanks to Junio for keeping this on 'pu' all this time. Must be
hard on you to resolve conflicts over and over.

Nguyễn Thái Ngọc Duy (7):
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree move: new command
  worktree move: accept destination as directory
  worktree move: refuse to move worktrees with submodules
  worktree remove: new command
  worktree remove: allow it when $GIT_WORK_TREE is already gone

 Documentation/git-worktree.txt         |  28 +++--
 builtin/worktree.c                     | 216 +++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |   5 +-
 t/t2028-worktree-move.sh               |  65 ++++++++++
 worktree.c                             |  97 +++++++++++++++
 worktree.h                             |  18 +++
 6 files changed, 418 insertions(+), 11 deletions(-)

-- 
2.16.0.47.g3d9b0fac3a

