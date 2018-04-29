Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6CD1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeD2STE (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45687 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeD2STD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:03 -0400
Received: by mail-lf0-f68.google.com with SMTP id y14-v6so9005903lfy.12
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YotU4l5Y39uLh8N6I5jpQEetsBCmOwdzagA4AUsBBn4=;
        b=ZVjDyyrr6CP9IW6y1Teb3EspWpo2lorQV5yGQFNjxsxjhqzjDTz3fQr8JPzFZ1/u6W
         WYnW12voDTm5jKprecAka7/ONMjdQtmpUqg+VJlHGwkxtJwq2oiPfi3t1rDPXkgeVECa
         XBg+7DmVcwdOMeLil+apKuNYSOoPlFEH8ymeSpQkJSawRE1A8HRtTtbPJvKViB4evRkF
         SY4Naez80htGMnkJBa32zWCDXlWQqR6ZLjH3fVazYCnPdYYO2sumJIQK8Iy5eqBXQMlj
         oTAQ7V8SseXyoFyFSUG0agx8IKBkZ4lsDGLEJOKwceuiIkcvYWCHwT6K3jZro0XjXPRj
         9EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YotU4l5Y39uLh8N6I5jpQEetsBCmOwdzagA4AUsBBn4=;
        b=nUF471egvzz7RVfg+G5h5ROvmqf3a55iCWlvQJOWTyvi74sjY4EaAnVlTiEkrZFWyI
         gPj7GizeQtFfNnOAGMbxlUcAZLsz3VqlVMTag9DPJRgClLPKOeMPFWy15wHQN3zxeDw6
         d1rnNKjs1yIdu+4q+vfGEn2puks9lCmfc04livznxVhlGAkRq/ob/3PGCMSc/RETnJjN
         eDtdlohKceykmMiNputGmLhSrrpgNrz6q+lP/y/hwu4rhNQQeoxsemPp8aUzZZvGMOB4
         s9iRbq/Af8SI9VUXMJgYfvTw7IAPoBT+qLkbp4lbtMaOI2lSvF567QC7eufI45zR0BhR
         c2zg==
X-Gm-Message-State: ALQs6tBZYyPHYqlVszH+fwyORrt8V1PNeUfPawRm7HoBMOhwV8Gu1VJ7
        VjRd4Ubyah9o/id7c07s/ow=
X-Google-Smtp-Source: AB8JxZqT4Dc4utXsuu7Z7nFHTSCC8x3+WFwxUAH5xUldqj3xyQO5RiQf2BeCJ8V1tfANqyO80YGGfg==
X-Received: by 2002:a2e:330c:: with SMTP id d12-v6mr6668240ljc.8.1525025941683;
        Sun, 29 Apr 2018 11:19:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 00/10] Keep all info in command-list.txt in git binary
Date:   Sun, 29 Apr 2018 20:18:34 +0200
Message-Id: <20180429181844.21325-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.664.g8924eee37a
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think v5 is getting close to what I wanted to achieve from the RFC
version (I skip v4 since I sent out v4/wip and another v4 may confuse
people).

Interdiff is too large to be helpful, but the summary of changes
compared to v3 is:

- common-cmds.h is renamed to command-list.h
- the common group description is moved from command-list.txt to
  help.c to simplify command-list.txt format
- generate-cmds.sh supports multiple categories per command, a new one
  "complete" is added to aid git-completion.bash
- multiple --list-cmds options is replaced with
  --list-cmds=<type>[,<type>...]. This allows easier group
  customization in git-completion.bash (not happens yet)
- __git_list_all_commands() and __git_list_porcelain_commands() for
  backward compatibility
- "git help <tab>" completion also makes use of guide list in
  command-list.txt
- better tests from Ramsay

There is one sticky point yet about the guides. I'll pull Phillip in
and explain more in the relevant patch.

Nguyễn Thái Ngọc Duy (10):
  generate-cmds.sh: factor out synopsis extract code
  generate-cmds.sh: export all commands to command-list.h
  help: use command-list.h for common command list
  Remove common-cmds.h
  git.c: convert --list-*builtins to --list-cmds=*
  completion: implement and use --list-cmds=main,others
  git: support --list-cmds=list-<category>
  help: add "-a --verbose" to list all commands with synopsis
  help: use command-list.txt for the source of guides
  completion: let git provide the completable command list

 .gitignore                             |   2 +-
 Documentation/git-help.txt             |   4 +-
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitmodules.txt           |   2 +-
 Documentation/gitrevisions.txt         |   2 +-
 Makefile                               |  16 +-
 builtin/help.c                         |  39 +----
 command-list.txt                       |  67 ++++----
 contrib/completion/git-completion.bash | 134 +++++-----------
 generate-cmdlist.sh                    | 126 ++++++++++-----
 git.c                                  |  38 ++++-
 help.c                                 | 209 +++++++++++++++++++++----
 help.h                                 |   5 +
 t/t0012-help.sh                        |  26 ++-
 t/t9902-completion.sh                  |   5 +-
 15 files changed, 426 insertions(+), 251 deletions(-)

-- 
2.17.0.664.g8924eee37a

