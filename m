Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABC91F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeJ0PDw (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:03:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38721 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeJ0PDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id p86so276692lfg.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo6Yfsk1hy6S88eS7F840cpC7eMWd21q+ZPbxiOYtMk=;
        b=RCNtwsD0SaWehq8c1Ipi/Qun1mvqAD6mnJo/LF1qgWs9ypNdpcbnvPeDcpM4+5sUXW
         yUYCsoFq/LBa0qI9w+dXBvnJ4RsEImAvNN+u97ksdpqHIram86goA6FjF0EU/I6n0Kjh
         /MbhtJ5FEXkroBtGr9/rSA4PifhfMyUuVWkKvRmrvT6gNKDXIJTJqQCL8lgOc57Ka1q9
         HRDl2BjgCvDZ0aWw+PDblE9MGI7RTll4bh7Z9WMT5HmC+skCOyhqC9glxFLxRF7snCoQ
         6ENa8wVwZRnfiYNoEBWmvdbYAxfOfrx07eelBB2sXae2j/fp1hXFCPtcGDzgwkLlRkVI
         hk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo6Yfsk1hy6S88eS7F840cpC7eMWd21q+ZPbxiOYtMk=;
        b=lDaqJOuSmslrSqRYeueTXtsK+DW5Z2ZmTBlIcyhMXSmn1QBzDgcjNoxNjhcoV/Vuv/
         BoCHGwbiwm2sPREPX8gmPvLDnn/Bg9k5lwQxOe1YQ8AMb3vFge7LA0vW0opbSDs2WoEN
         7xXYxC2LzEmAe/3FQlPupEMdOip/BVzgxtatafdvjTWZFbTWtajhc9HbHL7QFHviDWmo
         3eyN5DNbFSx71Nf2wWHnjKqH6CtApoir3xmoTNXDVHWiXmBXBGTaFj3LNCdAmM9OAuyf
         sDztf4z0mySNUps+qe7VUVAyjQ30iK7QZXSXNInf/O1wpbv2P7Pdk157wRv/0nBQsFDM
         r93Q==
X-Gm-Message-State: AGRZ1gK8EHfRr4Wg4sjZ/0AlSHttIjgbLuhO6fcFtDqEah3zhxC0VTGw
        jtgzoVyPLDvotj+JjJtKiZl1aPIp
X-Google-Smtp-Source: AJdET5e9TyV2KQBefmU5lL4F9b9aqgnKZcE15S5kX28xWEg+L331kqnI5AOCfX+1AMBIjBAt9d1Ymg==
X-Received: by 2002:a19:a28e:: with SMTP id l136mr4060882lfe.87.1540621435626;
        Fri, 26 Oct 2018 23:23:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:23:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/78] nd/config-split reroll
Date:   Sat, 27 Oct 2018 08:22:33 +0200
Message-Id: <20181027062351.30446-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to the version on 'pu', this one moves all the config files
to Documentation/config/ directory. imap.* is also added back in
config.txt (curently only documented in git-imap-send.txt)

This one is built on top of bp/reset-quiet and js/mingw-http-ssl to
avoid non-trivial conflicts.

I notice that there are duplicated config documentation in git-*.txt.
But given the size of this series, I think people will agree that can
be done separately later.

Nguyễn Thái Ngọc Duy (78):
  Update makefile in preparation for Documentation/config/*.txt
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
  config.txt: move diff-config.txt to config/
  config.txt: move difftool.* to a separate file
  config.txt: move fastimport.* to a separate file
  config.txt: move fetch-config.txt to config/
  config.txt: move filter.* to a separate file
  config.txt: move format-config.txt to config/
  config.txt: move fmt-merge-msg-config.txt to config/
  config.txt: move fsck.* to a separate file
  config.txt: move gc.* to a separate file
  config.txt: move gitcvs-config.txt to config/
  config.txt: move gitweb.* to a separate file
  config.txt: move grep.* to a separate file
  config.txt: move gpg.* to a separate file
  config.txt: move gui-config.txt to config/
  config.txt: move guitool.* to a separate file
  config.txt: move help.* to a separate file
  config.txt: move ssh.* to a separate file
  config.txt: move http.* to a separate file
  config.txt: move i18n.* to a separate file
  git-imap-send.txt: move imap.* to a separate file
  config.txt: move index.* to a separate file
  config.txt: move init.* to a separate file
  config.txt: move instaweb.* to a separate file
  config.txt: move interactive.* to a separate file
  config.txt: move log.* to a separate file
  config.txt: move mailinfo.* to a separate file
  config.txt: move mailmap.* to a separate file
  config.txt: move man.* to a separate file
  config.txt: move merge-config.txt to config/
  config.txt: move mergetool.* to a separate file
  config.txt: move notes.* to a separate file
  config.txt: move pack.* to a separate file
  config.txt: move pager.* to a separate file
  config.txt: move pretty.* to a separate file
  config.txt: move protocol.* to a separate file
  config.txt: move pull-config.txt to config/
  config.txt: move push-config.txt to config/
  config.txt: move rebase-config.txt to config/
  config.txt: move receive-config.txt to config/
  config.txt: move remote.* to a separate file
  config.txt: move remotes.* to a separate file
  config.txt: move repack.* to a separate file
  config.txt: move rerere.* to a separate file
  config.txt: move reset.* to a separate file
  config.txt: move sendemail-config.txt to config/
  config.txt: move sequencer.* to a separate file
  config.txt: move showBranch.* to a separate file
  config.txt: move splitIndex.* to a separate file
  config.txt: move status.* to a separate file
  config.txt: move stash.* to a separate file
  config.txt: move submodule.* to a separate file
  config.txt: move tag.* to a separate file
  config.txt: move transfer.* to a separate file
  config.txt: move uploadarchive.* to a separate file
  config.txt: move uploadpack.* to a separate file
  config.txt: move url.* to a separate file
  config.txt: move user.* to a separate file
  config.txt: move versionsort.* to a separate file
  config.txt: move web.* to a separate file
  config.txt: move worktree.* to a separate file
  config.txt: remove config/dummy.txt

 Documentation/Makefile                        |    2 +-
 Documentation/config.txt                      | 2957 +----------------
 Documentation/config/add.txt                  |    7 +
 Documentation/config/advice.txt               |   86 +
 Documentation/config/alias.txt                |   18 +
 Documentation/config/am.txt                   |   14 +
 Documentation/config/apply.txt                |   11 +
 Documentation/config/blame.txt                |   21 +
 Documentation/config/branch.txt               |  102 +
 Documentation/config/browser.txt              |    9 +
 Documentation/config/checkout.txt             |   23 +
 Documentation/config/clean.txt                |    3 +
 Documentation/config/color.txt                |  201 ++
 Documentation/config/column.txt               |   55 +
 Documentation/config/commit.txt               |   29 +
 Documentation/config/completion.txt           |    7 +
 Documentation/config/core.txt                 |  594 ++++
 Documentation/config/credential.txt           |   26 +
 .../{diff-config.txt => config/diff.txt}      |    2 +-
 Documentation/config/difftool.txt             |   14 +
 Documentation/config/fastimport.txt           |    8 +
 .../{fetch-config.txt => config/fetch.txt}    |    0
 Documentation/config/filter.txt               |    9 +
 .../fmt-merge-msg.txt}                        |    0
 .../{format-config.txt => config/format.txt}  |    0
 Documentation/config/fsck.txt                 |   67 +
 Documentation/config/gc.txt                   |  108 +
 .../{gitcvs-config.txt => config/gitcvs.txt}  |    0
 Documentation/config/gitweb.txt               |   16 +
 Documentation/config/gpg.txt                  |   20 +
 Documentation/config/grep.txt                 |   24 +
 .../{gui-config.txt => config/gui.txt}        |    0
 Documentation/config/guitool.txt              |   50 +
 Documentation/config/help.txt                 |   23 +
 Documentation/config/http.txt                 |  271 ++
 Documentation/config/i18n.txt                 |   10 +
 Documentation/config/imap.txt                 |   44 +
 Documentation/config/index.txt                |   10 +
 Documentation/config/init.txt                 |    3 +
 Documentation/config/instaweb.txt             |   20 +
 Documentation/config/interactive.txt          |   16 +
 Documentation/config/log.txt                  |   43 +
 Documentation/config/mailinfo.txt             |    6 +
 Documentation/config/mailmap.txt              |   15 +
 Documentation/config/man.txt                  |   12 +
 .../{merge-config.txt => config/merge.txt}    |    4 +-
 Documentation/config/mergetool.txt            |   53 +
 Documentation/config/notes.txt                |   59 +
 Documentation/config/pack.txt                 |  120 +
 Documentation/config/pager.txt                |    8 +
 Documentation/config/pretty.txt               |    9 +
 Documentation/config/protocol.txt             |   64 +
 .../{pull-config.txt => config/pull.txt}      |    0
 .../{push-config.txt => config/push.txt}      |    0
 .../{rebase-config.txt => config/rebase.txt}  |    0
 .../receive.txt}                              |    0
 Documentation/config/remote.txt               |   78 +
 Documentation/config/remotes.txt              |    3 +
 Documentation/config/repack.txt               |   27 +
 Documentation/config/rerere.txt               |   12 +
 Documentation/config/reset.txt                |    2 +
 .../sendemail.txt}                            |    0
 Documentation/config/sequencer.txt            |    5 +
 Documentation/config/showbranch.txt           |    3 +
 Documentation/config/splitindex.txt           |   24 +
 Documentation/config/ssh.txt                  |   35 +
 Documentation/config/stash.txt                |    9 +
 Documentation/config/status.txt               |   72 +
 .../submodule.txt}                            |    0
 Documentation/config/tag.txt                  |   16 +
 Documentation/config/transfer.txt             |   71 +
 Documentation/config/uploadarchive.txt        |    6 +
 Documentation/config/uploadpack.txt           |   65 +
 Documentation/config/url.txt                  |   30 +
 Documentation/config/user.txt                 |   26 +
 Documentation/config/versionsort.txt          |   33 +
 Documentation/config/web.txt                  |    4 +
 Documentation/config/worktree.txt             |    9 +
 Documentation/git-fmt-merge-msg.txt           |    2 +-
 Documentation/git-imap-send.txt               |   45 +-
 Documentation/git-merge.txt                   |    2 +-
 Documentation/git-rebase.txt                  |    2 +-
 Makefile                                      |    2 +-
 generate-cmdlist.sh                           |    2 +-
 84 files changed, 2959 insertions(+), 2899 deletions(-)
 create mode 100644 Documentation/config/add.txt
 create mode 100644 Documentation/config/advice.txt
 create mode 100644 Documentation/config/alias.txt
 create mode 100644 Documentation/config/am.txt
 create mode 100644 Documentation/config/apply.txt
 create mode 100644 Documentation/config/blame.txt
 create mode 100644 Documentation/config/branch.txt
 create mode 100644 Documentation/config/browser.txt
 create mode 100644 Documentation/config/checkout.txt
 create mode 100644 Documentation/config/clean.txt
 create mode 100644 Documentation/config/color.txt
 create mode 100644 Documentation/config/column.txt
 create mode 100644 Documentation/config/commit.txt
 create mode 100644 Documentation/config/completion.txt
 create mode 100644 Documentation/config/core.txt
 create mode 100644 Documentation/config/credential.txt
 rename Documentation/{diff-config.txt => config/diff.txt} (99%)
 create mode 100644 Documentation/config/difftool.txt
 create mode 100644 Documentation/config/fastimport.txt
 rename Documentation/{fetch-config.txt => config/fetch.txt} (100%)
 create mode 100644 Documentation/config/filter.txt
 rename Documentation/{fmt-merge-msg-config.txt => config/fmt-merge-msg.txt} (100%)
 rename Documentation/{format-config.txt => config/format.txt} (100%)
 create mode 100644 Documentation/config/fsck.txt
 create mode 100644 Documentation/config/gc.txt
 rename Documentation/{gitcvs-config.txt => config/gitcvs.txt} (100%)
 create mode 100644 Documentation/config/gitweb.txt
 create mode 100644 Documentation/config/gpg.txt
 create mode 100644 Documentation/config/grep.txt
 rename Documentation/{gui-config.txt => config/gui.txt} (100%)
 create mode 100644 Documentation/config/guitool.txt
 create mode 100644 Documentation/config/help.txt
 create mode 100644 Documentation/config/http.txt
 create mode 100644 Documentation/config/i18n.txt
 create mode 100644 Documentation/config/imap.txt
 create mode 100644 Documentation/config/index.txt
 create mode 100644 Documentation/config/init.txt
 create mode 100644 Documentation/config/instaweb.txt
 create mode 100644 Documentation/config/interactive.txt
 create mode 100644 Documentation/config/log.txt
 create mode 100644 Documentation/config/mailinfo.txt
 create mode 100644 Documentation/config/mailmap.txt
 create mode 100644 Documentation/config/man.txt
 rename Documentation/{merge-config.txt => config/merge.txt} (98%)
 create mode 100644 Documentation/config/mergetool.txt
 create mode 100644 Documentation/config/notes.txt
 create mode 100644 Documentation/config/pack.txt
 create mode 100644 Documentation/config/pager.txt
 create mode 100644 Documentation/config/pretty.txt
 create mode 100644 Documentation/config/protocol.txt
 rename Documentation/{pull-config.txt => config/pull.txt} (100%)
 rename Documentation/{push-config.txt => config/push.txt} (100%)
 rename Documentation/{rebase-config.txt => config/rebase.txt} (100%)
 rename Documentation/{receive-config.txt => config/receive.txt} (100%)
 create mode 100644 Documentation/config/remote.txt
 create mode 100644 Documentation/config/remotes.txt
 create mode 100644 Documentation/config/repack.txt
 create mode 100644 Documentation/config/rerere.txt
 create mode 100644 Documentation/config/reset.txt
 rename Documentation/{sendemail-config.txt => config/sendemail.txt} (100%)
 create mode 100644 Documentation/config/sequencer.txt
 create mode 100644 Documentation/config/showbranch.txt
 create mode 100644 Documentation/config/splitindex.txt
 create mode 100644 Documentation/config/ssh.txt
 create mode 100644 Documentation/config/stash.txt
 create mode 100644 Documentation/config/status.txt
 rename Documentation/{submodule-config.txt => config/submodule.txt} (100%)
 create mode 100644 Documentation/config/tag.txt
 create mode 100644 Documentation/config/transfer.txt
 create mode 100644 Documentation/config/uploadarchive.txt
 create mode 100644 Documentation/config/uploadpack.txt
 create mode 100644 Documentation/config/url.txt
 create mode 100644 Documentation/config/user.txt
 create mode 100644 Documentation/config/versionsort.txt
 create mode 100644 Documentation/config/web.txt
 create mode 100644 Documentation/config/worktree.txt

-- 
2.19.1.647.g708186aaf9

