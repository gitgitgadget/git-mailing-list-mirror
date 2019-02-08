Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3611F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfBHLV3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:21:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36774 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHLV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:21:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so1561694plo.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 03:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WsoiGcl1VbdP+A/YkdhIYyUXfJVJM4yQx5xoC/6tHns=;
        b=qNLg1lO2xnCaI0e+R82lri1ZyrogQWSOIXo/9k5GQrBy95u/CxuGeTeFRGGeBXaDkl
         pigNeQGmpervdMt4J6HOWi7ES2b+KD0twHhULJSlLobA0nkLcXw+ESWbBBdppbiRRFM1
         0kHEkRfqZQ5caIH7VhMHS3nsieDNbvwaX2BNCQGk381bZFZwKZGM9F0dNcUHeObzcshV
         xb3Z/o4GCazi/ott4nvAlygfseWjLfk5ZhfzbwsZUuPi12kL32uxUhL5ET9fcPuyTJbs
         4oUp3EZV3fO9cYMkmodXdoCsDSKlns5nSEVcPO8VM0o8klhG0VOym80aIh53dXP8YBr8
         X47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WsoiGcl1VbdP+A/YkdhIYyUXfJVJM4yQx5xoC/6tHns=;
        b=g+FoeoBoTnwEuZM6aUTDS7Ygs64+6pZcfX/vSjzHzExTMXqeWo25PhuDgHScJP3FZK
         jbmygJM8l2a5tezZQv+7aBFnZy2ScuiH0XH5p/lTaMn3nILytdR4SPmvKxaaKKhoqLwI
         WFNK1LShyqpPP3aSCRn+IcK5eDTtc0bTF/3UKRUwBc0p81tVyn+EkWD4Cw4a6phFslvA
         DapzFWTllhnQgTWtQenMh6ZjI0HD6Rkj4Ko4Yk7Q0XD5vebuRneRBjyOUIRgVSAaqKu+
         Jc8MMBeZWONG8IHxQC575cbnY6VBWikT967Y1A+YgG8XTiAGTAFmHYwXNhf51OCvncew
         0QnQ==
X-Gm-Message-State: AHQUAuZQqOJ8xTq/UmnyE+PvkDqja5Te8SDqXBADHj9QVhHsANK1puyP
        1VpT/WHaI+a9pSXztbdmqOWTsnic
X-Google-Smtp-Source: AHgI3IY/fl8lKbPEfdqjsX1B8KxOPfMmwWZ73qA7/Oa+A7ipgJQNlhWnqFWuyQwjkcmC0yyQxipHIQ==
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr21687256plc.326.1549624888379;
        Fri, 08 Feb 2019 03:21:28 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id s2sm4556546pfa.167.2019.02.08.03.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 03:21:27 -0800 (PST)
Date:   Fri, 8 Feb 2019 03:21:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v4 0/3] Teach submodule set-branch subcommand
Message-ID: <cover.1549624679.git.liu.denton@gmail.com>
References: <cover.1549534460.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549534460.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks so much for the feedback, Junio. I've updated the patchset based
on your comments.

Currently, there is no way to set the branch of a submodule without
manually manipulating the .gitmodules file. This patchset introduces a
porcelain command that enables this.

Changes since v1:
	* Fixed incorrect usage of OPT_CMDMODE

Changes since v2:
	* Corrected missing argument for -b/--branch in git-submodule.txt
	* Rebased onto latest next

Changes since v3:
	* Rebased back onto master
	* Address Junio's comments and improve clarity of submodule--helper patch
	* Fix incorrect documentation formatting in git-submodule.txt


Denton Liu (3):
  git-submodule.txt: "--branch <branch>" option defaults to 'master'
  submodule--helper: teach config subcommand --unset
  submodule: teach set-branch subcommand

 Documentation/git-submodule.txt        | 14 +++-
 builtin/submodule--helper.c            | 17 +++--
 contrib/completion/git-completion.bash |  5 +-
 git-submodule.sh                       | 75 +++++++++++++++++++--
 t/t7411-submodule-config.sh            |  9 +++
 t/t7419-submodule-set-branch.sh        | 93 ++++++++++++++++++++++++++
 6 files changed, 200 insertions(+), 13 deletions(-)
 create mode 100755 t/t7419-submodule-set-branch.sh

-- 
2.20.1.522.g5f42c252e9

