Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1466B211B5
	for <e@80x24.org>; Thu,  7 Feb 2019 06:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBGGdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 01:33:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46621 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfBGGc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 01:32:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so4324334pls.13
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 22:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mBzWtj3T7gqnPP1dl4tRZxw54lnP6Ry+JvkzP7ry6gg=;
        b=ZoZMe7UpDTFlWTm6rEfbTnibsi97k+qZ4O4AS5+0CjGJ4pcytZiv4q7f0qHKMnjjpd
         fhAw1f8kGQ0sqqsNmUK4FziDPuOSFpoOmlj0zri78XoKa0kMy7wd5bMX934DzurxVbot
         JcINUdoNqoq8UMNFETHWG5cwIcd/29M1NR7o4wswlPVE4EWPNvuCQzD5lXKkpgfUWGjn
         dG3u0xqxgsZ0ubMZV1V2GrC6QIbQ2fSbIjEX7EEQxUFDVMPZIHBI7Q/f0EPXk6jAlbtw
         SRsjNxRhCOpNrBT1rtecwtl6Z4Maw6nOFW6YQt9dHuIFDphg9lKDasvK9lezs67IkBsy
         +mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBzWtj3T7gqnPP1dl4tRZxw54lnP6Ry+JvkzP7ry6gg=;
        b=AT4UurnONzf9ZRqb1+imZNJBoaWuX3r0ZHDe1pEVXeaOqFjOm13UvQQLpuwU70a8ie
         6372IgKzFIyQQZHQuwXIv5KhLuBKKL7Oh1s/HhRgJi7IHgCYlX+eyzViwirEjmiQEnYS
         SLCHfiVjb5roYMvvXS+wh8Nn6s3EdKaEnZ7V5QcrWYIrgTSmcqJxyt8wv9XxsCTWDOeh
         zqWnCOL1xsvEajc4eXU0+QvDrSXJtFtUTmbJwc0JNyWmMYS+7tbIY21fK9Fe//bQQO/r
         WOtIyOuq/V/hPSytIlQUHcNJ8jyTeEd2/8wwYObuvguojbcStDQQ5SPWamPyCh9xdkfH
         o16g==
X-Gm-Message-State: AHQUAubY/cKf/RCpwr0Sa6Tv2RtpvJtEFDozHE5tGsiKpUqZTdlxhfNQ
        DX6nYp0brVLl9HOY4uHjV3LFa5li
X-Google-Smtp-Source: AHgI3IZ5HiCJ97gWvF8z4jkAPm9Pr1cB8TaqlKuiwSJF6Na2a4Gpf8Ug83JEVKU04CjQg4/64auobQ==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr15065636plb.182.1549521176432;
        Wed, 06 Feb 2019 22:32:56 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id m67sm11148320pfm.73.2019.02.06.22.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 22:32:55 -0800 (PST)
Date:   Wed, 6 Feb 2019 22:32:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 0/3] Teach submodule set-branch subcommand
Message-ID: <cover.1549521103.git.liu.denton@gmail.com>
References: <cover.1549450636.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549450636.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there is no way to set the branch of a submodule without
manually manipulating the .gitmodules file. This patchset introduces a
porcelain command that enables this.

Changes since v1:
	* Fixed incorrect usage of OPT_CMDMODE


Denton Liu (3):
  git-submodule.txt: document default behavior without --branch
  submodule--helper: teach config subcommand --unset
  submodule: teach set-branch subcommand

 Documentation/git-submodule.txt        | 10 ++-
 builtin/submodule--helper.c            | 18 +++--
 contrib/completion/git-completion.bash |  5 +-
 git-submodule.sh                       | 75 +++++++++++++++++++--
 t/t7411-submodule-config.sh            |  9 +++
 t/t7419-submodule-set-branch.sh        | 93 ++++++++++++++++++++++++++
 6 files changed, 198 insertions(+), 12 deletions(-)
 create mode 100755 t/t7419-submodule-set-branch.sh

-- 
2.20.1.522.g5f42c252e9

