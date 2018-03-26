Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788B61F404
	for <e@80x24.org>; Mon, 26 Mar 2018 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeCZQ4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 12:56:07 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42927 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCZQ4G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 12:56:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id a22-v6so29175858lfg.9
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCA/Fv9TWi3irb2nLrExkXgxrlc6qilN24FsmJ7EO8I=;
        b=cd1p0Vu7rfSZFKNahmyfzKY3mKPhNiZWdN244y/XcaBctl4vX5Nq7y8Cuhzx3II+Uk
         AEmOdY/XmpAlXiz9jy0T8JuOouBdALtlvfUa7Eswt0ATI9avydiE2crBxmPX1WfQdpDH
         6svq7MtU0FnZQypVWDobxIoQVUSNgnio+OwrCjwg8uWx5y1xEA4xhILJ+txDT1EDHO0A
         /1ye8fSzJWozFKvnEwS+tLaW1p3+kbE35Gyx1j7ZC2/UmIxjoQHoyxmSbgc/OXEoeaDS
         JKiqtbnAxE1P9rHr8nF36lSGAFzBvLMgFI1bKdL4oqN+3wxyLGzCwZb66+gHLuLP2eby
         l0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCA/Fv9TWi3irb2nLrExkXgxrlc6qilN24FsmJ7EO8I=;
        b=SZSLzS5dwhQ7E58ypV66oRlrIgJfZ7GnHNjuuQ5bHF0DtpLxd8Kk9Legw3VO3q+/7o
         CaogxGzgnmv5ABjTMmiK1T23+LAf4THyBHPdJTS5yfl5ihmHS3aC6XbETq4RnUkK4iql
         nGTm4jVfmufV9BSW5g4pOrgclUsXGc0GBaN1BbhKU0W0tHWUVeUphzf6cpsgALL1wWRF
         vlSDdfOMuzWjeZPQiNIqdkB7Lfjd3AL1a7lxwyQWVeuKmbZC/lOt0czm6rj+XwpMexh6
         FvrdfJ2F6UmZZWqhc05MJhuaPQMJkurBvqLcxFbcFjiRcf+m7e72wanZURXhACjemlty
         ME+Q==
X-Gm-Message-State: AElRT7GlcenmtZROT7SqzEqwPDh9rq66NKIh14ItaR7Jh2zi3xDF2pVd
        5AsHMNYeTPOmndQDvPia7MyhyA==
X-Google-Smtp-Source: AIpwx49rmT/blod9+JrMWgBJ+pupW5uTu3PZMVNKqiPTKbH1NlwHXGpRoQ38Zd23CQDaFYh4eplOSA==
X-Received: by 2002:a19:ca41:: with SMTP id h1-v6mr10272554lfj.81.1522083365061;
        Mon, 26 Mar 2018 09:56:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j8sm814451lje.83.2018.03.26.09.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 09:56:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Date:   Mon, 26 Mar 2018 18:55:15 +0200
Message-Id: <20180326165520.802-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is pretty rough but I'd like to see how people feel about this
first.

I notice we have two places for command classification. One in
command-list.txt, one in __git_list_porcelain_commands() in
git-completion.bash. People who are following nd/parseopt-completion
probably know that I'm try to reduce duplication in this script as
much as possible, this is another step towards that.

By keeping all information of command-list.txt in git binary, we could
provide the porcelain list to git-completion.bash via "git
--list-cmds=porcelain", so we don't neeed a separate command
classification in git-completion.bash anymore.

Because we have all command synopsis as a side effect, we could
now support "git help -a --verbose" which prints something like "git
help", a command name and a description, but we could do it for _all_
recognized commands. This could help people look for a command even if
we don't provide "git appropos".

PS. Elsewhere I introduced --list-builtin-cmds, which should become
--list-cmds=builtin if this series seems like a good idea to move
forward.

Nguyễn Thái Ngọc Duy (5):
  git.c: convert --list-builtins to --list-cmds=builtins
  git.c: implement --list-cmds=all and use it in git-completion.bash
  generate-cmdlist.sh: keep all information in common-cmds.h
  git.c: implement --list-cmds=porcelain
  help: add "-a --verbose" to list all commands with synopsis

 Documentation/git-help.txt             |   4 +-
 builtin/help.c                         |   6 ++
 contrib/completion/git-completion.bash |  94 +-----------------
 generate-cmdlist.sh                    |  46 ++++++---
 git.c                                  |  11 ++-
 help.c                                 | 131 +++++++++++++++++++++++--
 help.h                                 |   3 +
 t/t0012-help.sh                        |   2 +-
 t/t9902-completion.sh                  |   4 +-
 9 files changed, 187 insertions(+), 114 deletions(-)

-- 
2.17.0.rc0.348.gd5a49e0b6f

