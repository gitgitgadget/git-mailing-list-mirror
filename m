Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4451F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJTUtT (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42790 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeJTUtT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id s10-v6so27110195lfc.9
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwcO/y1WiYjuOJ45zGqdnWHU2VE9QOUeTp2iOOlp7ro=;
        b=vDpDybVRi/auvoruZn48yT1V/kufNIbYogXhFqw828CSKrKHmSlxWRk/PQ0vKjCGCY
         W8mwVHzwGVNyrbkDWmZfSrqfqcpdyGrmfzMZHbP5CEUkGopOVfiZJBDULSnPxs2qoXX1
         s/3NdBA9Auyh0txsr/1F57bvIIMX0ojES65yBEhgY0H7rQUx1IkGrpXSJfbs5NE6niD9
         L0JFXLsXbgFAi3c9Y4L/EMX4RRun8eCpsNfiY5MFB9vH+9BxA4UbSKsHcTO2/bEpvsLS
         M0eTP8Jumo0iMw+IrOMqRHYDHi0Y93KcHEDp+QFDZl+Ezn27t7843LejXqxXOADypR5a
         duFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwcO/y1WiYjuOJ45zGqdnWHU2VE9QOUeTp2iOOlp7ro=;
        b=ek8yYstaQ/p2gY5PE74aDA2MrzwDvEMU0vMZAz+7aly7bf795v3Xm2+SW15RVQzilY
         srLja9HWJGv2kn6zcN9BaJFHXkAnAOkJwMMBXpF8KdDEoTe+pA/GwbbeX4MopK63/oNc
         hQjm8POfwjowlAgG2dey2B2FIRTOybMSbzANQB44wgT0E2blLOLPetqZ0nb1/FCmoFrF
         caS/BLzycmJl1M9+SdNJlblq7wdAw2tPOKxjNT32Larth5Fy6s1f4L/XpN5ZzqZykSH8
         9vyfktdrPGJyc+Hj5X/PPRfjCT9I1EpppdmsaaP1OA7Uz6MCikyq+BzejEKB4ghq4/S5
         V0nQ==
X-Gm-Message-State: ABuFfogqRRWxJZofr2LcTsB19m0gfVljjsPJ5H+Sl2u6nfYdzXMIo4JR
        4JLkaJP4WZjiCfCNL0SmkWZxiOlQ
X-Google-Smtp-Source: ACcGV62bcU/a9DkAy3Gvg2SNaRVapp0vllAGfzjLfnEXAYQ6Y/Ytg2BZZ7DJM1Ljgvxv5B8YnaWNZw==
X-Received: by 2002:a19:53d9:: with SMTP id h86-v6mr5498371lfl.75.1540039135996;
        Sat, 20 Oct 2018 05:38:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:38:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/59] Split config.txt
Date:   Sat, 20 Oct 2018 14:37:49 +0200
Message-Id: <20181020123848.2785-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started this a couple months back, moving a couple big config
sections out of config.txt to make it more manageable. This series
almost completes that. It moves all configs (except http.* which have
changes on 'pu') out of config.txt. config.txt is now about the
syntax, and a list of config sections. http section can be moved out
later.

I did a doc-diff on this series and the only change is ssh.variant is
moved down a bit to keep it in order, which is intended.

I thought of grouping all these config files in a separate directory
Documentation/config to avoid cluttering Documentation/ too much but
let's wait and see if people really find Documentation growing too
large first.

Nguyễn Thái Ngọc Duy (59):
  config.txt: move advice.* to a separate file
  config.txt: move core.* to a separate file
  config.txt: move add.* to a separate file
  config.txt: move alias.* to a separate file
  config.txt: move am.* to a separate file
  config.txt: move apply.* to a separate file
  config.txt: move blame.* to a separate file
  config.txt: move branch.* to a separate file
  config.txt: move browser.* to a separate file
  config.txt: move checkout.* to a separate file
  config.txt: move clean.* to a separate file
  config.txt: move color.* to a separate file
  config.txt: move column.* to a separate file
  config.txt: move commit.* to a separate file
  config.txt: move credential.* to a separate file
  config.txt: move completion.* to a separate file
  config.txt: move difftool.* to a separate file
  config.txt: move fastimport.* to a separate file
  config.txt: move filter.* to a separate file
  config.txt: move fsck.* to a separate file
  config.txt: move gc.* to a separate file
  config.txt: move gitweb.* to a separate file
  config.txt: move grep.* to a separate file
  config.txt: move gpg.* to a separate file
  config.txt: move guitool.* to a separate file
  config.txt: move help.* to a separate file
  config.txt: move ssh.* to a separate file
  config.txt: move i18n.* to a separate file
  config.txt: move i18n.* to a separate file
  config.txt: move init.* to a separate file
  config.txt: move instaweb.* to a separate file
  config.txt: move interactive.* to a separate file
  config.txt: move log.* to a separate file
  config.txt: move mailinfo.* to a separate file
  config.txt: move mailmap.* to a separate file
  config.txt: move man.* to a separate file
  config.txt: move mergetool.* to a separate file
  config.txt: move notes.* to a separate file
  config.txt: move pack.* to a separate file
  config.txt: move pager.* to a separate file
  config.txt: move pretty.* to a separate file
  config.txt: move protocol.* to a separate file
  config.txt: move remote.* to a separate file
  config.txt: move remotes.* to a separate file
  config.txt: move repack.* to a separate file
  config.txt: move rerere.* to a separate file
  config.txt: move sequencer.* to a separate file
  config.txt: move showBranch.* to a separate file
  config.txt: move splitIndex.* to a separate file
  config.txt: move status.* to a separate file
  config.txt: move tag.* to a separate file
  config.txt: move transfer.* to a separate file
  config.txt: move uploadarchive.* to a separate file
  config.txt: move uploadpack.* to a separate file
  config.txt: move url.* to a separate file
  config.txt: move user.* to a separate file
  config.txt: move versionsort.* to a separate file
  config.txt: move web.* to a separate file
  config.txt: move worktree.* to a separate file

 Documentation/add-config.txt           |    7 +
 Documentation/advice-config.txt        |   82 +
 Documentation/alias-config.txt         |   18 +
 Documentation/am-config.txt            |   14 +
 Documentation/apply-config.txt         |   11 +
 Documentation/blame-config.txt         |   21 +
 Documentation/branch-config.txt        |  102 +
 Documentation/browser-config.txt       |    9 +
 Documentation/checkout-config.txt      |   23 +
 Documentation/clean-config.txt         |    3 +
 Documentation/color-config.txt         |  201 ++
 Documentation/column-config.txt        |   55 +
 Documentation/commit-config.txt        |   29 +
 Documentation/completion-config.txt    |    7 +
 Documentation/config.txt               | 2640 +-----------------------
 Documentation/core-config.txt          |  594 ++++++
 Documentation/credential-config.txt    |   26 +
 Documentation/difftool-config.txt      |   14 +
 Documentation/fastimport-config.txt    |    8 +
 Documentation/filter-config.txt        |    9 +
 Documentation/fsck-config.txt          |   67 +
 Documentation/gc-config.txt            |  108 +
 Documentation/gitweb-config.txt        |   16 +
 Documentation/gpg-config.txt           |   20 +
 Documentation/grep-config.txt          |   24 +
 Documentation/guitool-config.txt       |   50 +
 Documentation/help-config.txt          |   23 +
 Documentation/i18n-config.txt          |   10 +
 Documentation/index-config.txt         |   10 +
 Documentation/init-config.txt          |    3 +
 Documentation/instaweb-config.txt      |   20 +
 Documentation/interactive-config.txt   |   16 +
 Documentation/log-config.txt           |   43 +
 Documentation/mailinfo-config.txt      |    6 +
 Documentation/mailmap-config.txt       |   15 +
 Documentation/man-config.txt           |   12 +
 Documentation/mergetool-config.txt     |   53 +
 Documentation/notes-config.txt         |   59 +
 Documentation/pack-config.txt          |  120 ++
 Documentation/pager-config.txt         |    8 +
 Documentation/pretty-config.txt        |    9 +
 Documentation/protocol-config.txt      |   64 +
 Documentation/remote-config.txt        |   78 +
 Documentation/remotes-config.txt       |    3 +
 Documentation/repack-config.txt        |   27 +
 Documentation/rerere-config.txt        |   12 +
 Documentation/sequencer-config.txt     |    5 +
 Documentation/showbranch-config.txt    |    3 +
 Documentation/splitindex-config.txt    |   24 +
 Documentation/ssh-config.txt           |   35 +
 Documentation/stash-config.txt         |    9 +
 Documentation/status-config.txt        |   72 +
 Documentation/tag-config.txt           |   16 +
 Documentation/transfer-config.txt      |   71 +
 Documentation/uploadarchive-config.txt |    6 +
 Documentation/uploadpack-config.txt    |   65 +
 Documentation/url-config.txt           |   30 +
 Documentation/user-config.txt          |   26 +
 Documentation/versionsort-config.txt   |   33 +
 Documentation/web-config.txt           |    4 +
 Documentation/worktree-config.txt      |    9 +
 61 files changed, 2608 insertions(+), 2549 deletions(-)
 create mode 100644 Documentation/add-config.txt
 create mode 100644 Documentation/advice-config.txt
 create mode 100644 Documentation/alias-config.txt
 create mode 100644 Documentation/am-config.txt
 create mode 100644 Documentation/apply-config.txt
 create mode 100644 Documentation/blame-config.txt
 create mode 100644 Documentation/branch-config.txt
 create mode 100644 Documentation/browser-config.txt
 create mode 100644 Documentation/checkout-config.txt
 create mode 100644 Documentation/clean-config.txt
 create mode 100644 Documentation/color-config.txt
 create mode 100644 Documentation/column-config.txt
 create mode 100644 Documentation/commit-config.txt
 create mode 100644 Documentation/completion-config.txt
 create mode 100644 Documentation/core-config.txt
 create mode 100644 Documentation/credential-config.txt
 create mode 100644 Documentation/difftool-config.txt
 create mode 100644 Documentation/fastimport-config.txt
 create mode 100644 Documentation/filter-config.txt
 create mode 100644 Documentation/fsck-config.txt
 create mode 100644 Documentation/gc-config.txt
 create mode 100644 Documentation/gitweb-config.txt
 create mode 100644 Documentation/gpg-config.txt
 create mode 100644 Documentation/grep-config.txt
 create mode 100644 Documentation/guitool-config.txt
 create mode 100644 Documentation/help-config.txt
 create mode 100644 Documentation/i18n-config.txt
 create mode 100644 Documentation/index-config.txt
 create mode 100644 Documentation/init-config.txt
 create mode 100644 Documentation/instaweb-config.txt
 create mode 100644 Documentation/interactive-config.txt
 create mode 100644 Documentation/log-config.txt
 create mode 100644 Documentation/mailinfo-config.txt
 create mode 100644 Documentation/mailmap-config.txt
 create mode 100644 Documentation/man-config.txt
 create mode 100644 Documentation/mergetool-config.txt
 create mode 100644 Documentation/notes-config.txt
 create mode 100644 Documentation/pack-config.txt
 create mode 100644 Documentation/pager-config.txt
 create mode 100644 Documentation/pretty-config.txt
 create mode 100644 Documentation/protocol-config.txt
 create mode 100644 Documentation/remote-config.txt
 create mode 100644 Documentation/remotes-config.txt
 create mode 100644 Documentation/repack-config.txt
 create mode 100644 Documentation/rerere-config.txt
 create mode 100644 Documentation/sequencer-config.txt
 create mode 100644 Documentation/showbranch-config.txt
 create mode 100644 Documentation/splitindex-config.txt
 create mode 100644 Documentation/ssh-config.txt
 create mode 100644 Documentation/stash-config.txt
 create mode 100644 Documentation/status-config.txt
 create mode 100644 Documentation/tag-config.txt
 create mode 100644 Documentation/transfer-config.txt
 create mode 100644 Documentation/uploadarchive-config.txt
 create mode 100644 Documentation/uploadpack-config.txt
 create mode 100644 Documentation/url-config.txt
 create mode 100644 Documentation/user-config.txt
 create mode 100644 Documentation/versionsort-config.txt
 create mode 100644 Documentation/web-config.txt
 create mode 100644 Documentation/worktree-config.txt

-- 
2.19.1.647.g708186aaf9

