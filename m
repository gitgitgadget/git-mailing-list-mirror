Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3E21F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbeDYQb3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:29 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:43630 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754849AbeDYQb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:28 -0400
Received: by mail-lf0-f44.google.com with SMTP id g12-v6so10284982lfb.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMucIY917xE7o8Yyt6KDym/INeV3PamyaU2ar1nikGk=;
        b=MVbkc9B6RcEyaDy9BDZ6ptoj95NiVmOm9iiqBBOqP2GcKxSPvB9cStMgic/So75D8k
         6I3bBFq5Tfu/+25ZRVzZnNa4kedKeVBuAy9ZYOdSQBrSMUbsd+qRzULkQ8RBy3fFYqrl
         xXqkR5RixMUDkCqcVbUuYv8B6zAliRpJ8vY+0hfnGVrskB1TJmRrOiGETtCet8g6k82L
         Pj01KBr6BQNhlruU7ZQWuCg2U/1M5Yn/7oXsg7nEIee7iQdcS/njIsd1Gq9hS6aamjEp
         YSlEQy8IK11cW3lu8M7n79T84y9lxfzcpVkRfo8YkE2mC0KJ4uzoBtJ5aJzhtgIMwO7n
         yhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMucIY917xE7o8Yyt6KDym/INeV3PamyaU2ar1nikGk=;
        b=kI6PIoukTuGKWYt/th6QcZwNkv0v4FMgHNXHPjfUA9OIUFmpFwIu8Ids2DZBAFZAx/
         0i5iASTkhPULrlPF7ceVTte1mc0pCf2uuaJ+vkV/XoNOnCl0HOrTRn/HlEhwBqCpGISY
         VaXp7/5jCxEUW7w8bKCrG3vPZgUFUtvITDs7XO9+sMYlkV15fH1CJB6oncKyg7INdP8n
         qBNk/YDFyuxRY5B5jnJpiZmPV6Ole2nIECCTr0ARz0iiCLOJj8a+oUSf9XlkWBSiy1o1
         bj6oALis/0GkSDMB/cy2M0nCLuDgt8C8zcvgs5s+mgKpGBlvbISjWKXxSxoIpUx9+yST
         cvhA==
X-Gm-Message-State: ALQs6tDw9nt6EADgr40uzFWnfeZgIEXFNurjg4sPq7qnxOtasrZwUmoG
        sEgLXqSL7jdZo2lVRxSZVIM=
X-Google-Smtp-Source: AIpwx4/ketoqWo/4xN8zX4fdVbRJx/AKsfug/5IqlFJvoaXxTnjb+G1TYfokbK2ZGyuTEZO2CfACeQ==
X-Received: by 10.46.146.131 with SMTP id d3mr19436618ljh.18.1524673886942;
        Wed, 25 Apr 2018 09:31:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 00/12] Keep all info in command-list.txt in git binary
Date:   Wed, 25 Apr 2018 18:30:55 +0200
Message-Id: <20180425163107.10399-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not exactly v4 and likely broken. But I've made several
debatable changes and would like your opinions before making even more
changes in this direction.

In 03/12 I made a format change in command-list.txt. The group
description is no longer in this file but in help.c instead. This
simplifies the format. However it may be harder for people to know
what category means what (but then it's already so for a lot more
categories).

In 11/12 I added the new "complete" category to command-list.txt so
that we could replace the giant list in git-completion.bash. This is
really questionable because several commands will NOT be completable
anymore. These are listed there so we can discuss.

Another thing I wonder is, whether I should tag "nocomplete" instead
of "complete" in command-list.txt, similar to parseopt's nocomplete
strategy: commands are completable by default then we just exclude
some of them. The "complete" tag goes the opposite direction, we only
show ones that are either external, "complete" or mainporcelain.

I think we would go with whitelist than blacklist though to avoid
helper commands showing up by default...

Also in 02/12 I moved to fixed column format. Strictly speaking I
do not need that (but it makes the code slightly more complex). If you
are really against fixed column format, speak up now.

Nguyễn Thái Ngọc Duy (12):
  generate-cmds.sh: factor out synopsis extract code
  generate-cmds.sh: export all commands to command-list.h
  help: use command-list.h for common command list
  Remove common-cmds.h
  git.c: convert --list-*builtins to --list-cmds=*
  git: accept multiple --list-cmds options
  completion: implement and use --list-cmds=all
  git: support --list-cmds=<category>
  help: add "-a --verbose" to list all commands with synopsis
  help: use command-list.txt for the source of guides
  command-list.txt: add new category "complete"
  completion: let git provide the completable command list

 .gitignore                             |   2 +-
 Documentation/git-help.txt             |   4 +-
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitmodules.txt           |   2 +-
 Documentation/gitrevisions.txt         |   2 +-
 Makefile                               |  16 +--
 builtin/help.c                         |  39 +-----
 command-list.txt                       |  55 ++++----
 contrib/completion/git-completion.bash | 121 +++-------------
 generate-cmdlist.sh                    | 128 +++++++++++------
 git.c                                  |  19 ++-
 help.c                                 | 186 +++++++++++++++++++++----
 help.h                                 |   4 +
 t/t0012-help.sh                        |  11 +-
 t/t9902-completion.sh                  |   5 +-
 15 files changed, 344 insertions(+), 252 deletions(-)

-- 
2.17.0.519.gb89679a4aa

