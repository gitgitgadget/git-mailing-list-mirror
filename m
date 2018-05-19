Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC6F1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbeESE2A (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38810 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeESE17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:27:59 -0400
Received: by mail-lf0-f66.google.com with SMTP id z142-v6so16759911lff.5
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5VLGINQP8dzx77sLV0Gse3PeA6DVFJGwwt6D6Ki0i4=;
        b=ZKALCKw5m/etACZXxd6CZHj/hmiXcEbyyUauQRLZNfW8oKkVPyFE04Mc/H4WkLWkMO
         i/2rHf7r29dKJ+gs07sZTAEuni+GD6a2f7vHRZjXqUvzgfx4/W3dEBi6ygI+mt57+bzk
         fDdbAokPJ3it4+QeFxgNMuEgWsHMCCwZWPAqd+3EAuJWS5vQpgYPU01vbngpGRb7ED8y
         y5UJf4EGlLWdwyfOvAPDu//+4UyJ8Y8ldfVJo8sTNFwvl9/uk0PuwcsoNq7535lJGlcM
         Eqw23Je1hF6RsZydx7RPOICAMM1HuGIxUBYxIJtRCwxoslEXeX8PBWXfO6jtdT+yQhKX
         2YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5VLGINQP8dzx77sLV0Gse3PeA6DVFJGwwt6D6Ki0i4=;
        b=Iw/hyAEcawTdP3aiacV/cV4laDkvw3QCjxbeMgRdr5ONWVYhMBpggdkaz0U8eCvVKP
         LVvMwgJ/7fu5o9VtGInVZiRt59kB2dcpAj7oFKTwWWpk+EPVazi3Jzgh+j2cFR9qeQ7e
         kngtIeTuW/qsgQJrp5Qc+KBv/0UFidScDfrpACUb7ZPpO/YFzht+2Zz+T1Zk8rpaUZuD
         rF4xtuLQb+TzV0/4ucjdoOUrTLcSofCxwOGkvu4szNjHwYYVX0dldKOHipSq474MJizG
         FLUbjFXJ8HVEX7TOIngwyulTjn+eHiF/E6/u4uaAmH9LhWjWlxle7rURW95E4FMW5mqc
         cgbg==
X-Gm-Message-State: ALKqPwfL6t+QfQSOAii92yQEAzzbQQj9NDSsj6H2FYWHBXxgNJm6cUOM
        jH7yT9oGMhBnLyE/4HAvR7jAag==
X-Google-Smtp-Source: AB8JxZrxeO/T3rQzkh/rFs5kWTLqMB7Z4mKwA8YODCBPFKj2JOb/6SVHdkevuIDvMSRL14kJoAOVHQ==
X-Received: by 2002:a2e:4d5d:: with SMTP id a90-v6mr7446870ljb.86.1526704077059;
        Fri, 18 May 2018 21:27:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:27:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/14] nd/command-list updates
Date:   Sat, 19 May 2018 06:27:38 +0200
Message-Id: <20180519042752.8666-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should be the final update before nd/command-list hits 'next',
hopefully.

Besides the interdiff below, the old 12/13 is split into two: 12/14
keeps the complete output as close as possible to the base version and
13/14 removes some commands from the completion list.

interdiff

diff --git a/command-list.txt b/command-list.txt
index 3e21ddfcfb..8462ea475f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -39,8 +39,9 @@
 # mainporcelain commands are completable so you don't need this
 # attribute.
 #
-# While not true commands, guides are also specified here, which can
-# only have "guide" attribute and nothing else.
+# As part of the Git man page list, the man(5/7) guides are also
+# specified here, which can only have "guide" attribute and nothing
+# else.
 #
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f7ca9a4d4f..f237eb0ff4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -857,6 +857,8 @@ __git_complete_strategy ()
 	return 1
 }
 
+# __git_commands requires 1 argument:
+# 1: the command group, either "all" or "porcelain"
 __git_commands () {
 	case "$1" in
 	porcelain)


Nguyễn Thái Ngọc Duy (14):
  generate-cmds.sh: factor out synopsis extract code
  generate-cmds.sh: export all commands to command-list.h
  help: use command-list.h for common command list
  Remove common-cmds.h
  git.c: convert --list-* to --list-cmds=*
  git --list-cmds: collect command list in a string_list
  completion: implement and use --list-cmds=main,others
  git: support --list-cmds=list-<category>
  help: add "-a --verbose" to list all commands with synopsis
  help: use command-list.txt for the source of guides
  command-list.txt: documentation and guide line
  completion: let git provide the completable command list
  completion: reduce completable command list
  completion: allow to customize the completable command list

 .gitignore                             |   2 +-
 Documentation/config.txt               |  10 +
 Documentation/git-help.txt             |   4 +-
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitmodules.txt           |   2 +-
 Documentation/gitrevisions.txt         |   2 +-
 Makefile                               |  16 +-
 builtin/help.c                         |  39 +---
 command-list.txt                       | 112 +++++++++---
 contrib/completion/git-completion.bash | 162 +++++++---------
 generate-cmdlist.sh                    | 126 ++++++++-----
 git.c                                  |  68 ++++++-
 help.c                                 | 244 ++++++++++++++++++++++---
 help.h                                 |  10 +
 t/t0012-help.sh                        |  26 ++-
 t/t9902-completion.sh                  |   5 +-
 16 files changed, 576 insertions(+), 254 deletions(-)

-- 
2.17.0.705.g3525833791

