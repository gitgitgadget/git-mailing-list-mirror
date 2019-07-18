Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED0D1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbfGRNTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35105 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRNTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so25676963wmg.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=IbNC2AMblro1n+S4JmJxcp7M9o2ZgFrT772OKdIML1I=;
        b=hH/BhvV29/Gkvuu3jO0LaG+SYhSa75nU1tJ/eZtZX2vqLtCdNAy7K1qVtNe5HtVony
         SORio3oNCL7IoFe8AyR651eeT/6mfk+QfZnQZShBIpXzar3cjGG5KGclBXtYKopxgYar
         BkIE5bcoqw2ch2gjPVfbQeS0WxO5hWCP2h2DweYQyxSNkLGpnkJ8+jP0R9RyT6ghvdtp
         3kSnj8i1HnMNXJX3fRL/HjndfBExNkugjib+ry0tRftRupH55gjTVlv84RlOsvhkmQxD
         WaQhH02UJVBXMMUBgPDv8KS5juZIOD5wVLjPi48HYpl9eFPRm812HpM3baTFZlrmjyEw
         wdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IbNC2AMblro1n+S4JmJxcp7M9o2ZgFrT772OKdIML1I=;
        b=aATJxiC2tJKRIevY/6Ya4aDALMmIT4MWyduAFKFRADpOxU19dfP5xE4TuWaqH37WMc
         QcdAGjYYaUq5FsN2dwYJWqOUOd5qOAlhif15BWrwOuucjtcb2NA1erguYQlNUavp1B+d
         DkflqwqArY7RUK0oUFc+rXlXujz0j01bgcX/i1vkRy0+X1HVbyj/2ef2FiwLIH0o8kWE
         oIgZ1GsEHjsOlK2YKYjDaJH1MNGJL5NhNkn8NjJJF/fAxOSylZ3KcRfGeTX/fVny6Xbl
         MVBmaBXAvnIKGMLyzlrs2N3wbMGFT9Gyj8JbwP0sCXxGq1vjWuijZqKXua8Q/Q03f1cD
         iMrg==
X-Gm-Message-State: APjAAAUekjZkfA90yvoDYLbgC4HNlni+6XBXJK2MHkmiATM6ctMlBX+a
        bDedZASwe82+GzGaBMiFyVxJ75jp
X-Google-Smtp-Source: APXvYqyYYD2zJQTx95j+2cqjcO70S1zpATeY5GwypsLmYRwEUq29lRedruu7J+rRZRx6PZGxWLrA/A==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr44678832wmk.127.1563455940718;
        Thu, 18 Jul 2019 06:19:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j33sm61722219wre.42.2019.07.18.06.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:00 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:00 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:35 GMT
Message-Id: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/24] Reinstate support for Visual Studio
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A long time ago, we added support to build .sln and .vcproj files for use
within Visual Studio, so that Git could be built in that popular IDE.

This support languished for years and was finally brought back into Git for
Windows partially through the jh/msvc branch that was just merged into 
master. With the tremendous help by Philip Oakley and Jeff Hostetler, this
re-adds support for Visual Studio, focusing on VS 2015 and later (older
versions are currently unsupported, even if we worked a bit on that front,
too; If there are volunteers to add support for older versions, I would be
delighted to review PRs to that end on 
https://github.com/git-for-windows/git).

Note: the currently preferred way to contribute using Visual Studio is by
using Git for Windows' vs/master branch (which is automatically generated
using the make vcxproj build target that this patch series adds, updated
every time Git for Windows' master advances). My plan is to provide a
similar branch in GitGitGadget, based on top of git.git's master, once this
patch series is integrated.

Johannes Schindelin (15):
  Vcproj.pm: auto-generate GUIDs
  Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
  Vcproj.pm: urlencode '<' and '>' when generating VC projects
  contrib/buildsystems: ignore irrelevant files in Generators/
  contrib/buildsystems: error out on unknown option
  contrib/buildsystems: handle libiconv, too
  contrib/buildsystems: also handle -lexpat
  contrib/buildsystems: handle options starting with a slash
  contrib/buildsystems: add a backend for modern Visual Studio versions
  msvc: add a Makefile target to pre-generate the Visual Studio solution
  vcxproj: also link-or-copy builtins
  .gitignore: ignore Visual Studio's temporary/generated files
  bin-wrappers: append `.exe` to target paths if necessary
  t5505,t5516: create .git/branches/ when needed
  git: avoid calling aliased builtins via their dashed form

Philip Oakley (9):
  Vcproj.pm: list git.exe first to be startup project
  contrib/buildsystems: ignore invalidcontinue.obj
  contrib/buildsystems: fix misleading error message
  contrib/buildsystems: handle quoted spaces in filenames
  contrib/buildsystems: ignore gettext stuff
  contrib/buildsystems: redirect errors of the dry run into a log file
  contrib/buildsystems: optionally capture the dry-run in a file
  contrib/buildsystems: handle the curl library option
  .gitignore: touch up the entries regarding Visual Studio

 .gitignore                                 |   8 +-
 Makefile                                   |   2 +-
 compat/vcbuild/README                      |  23 ++
 config.mak.uname                           |  76 ++++
 contrib/buildsystems/Generators.pm         |   2 +-
 contrib/buildsystems/Generators/Vcproj.pm  | 119 ++-----
 contrib/buildsystems/Generators/Vcxproj.pm | 387 +++++++++++++++++++++
 contrib/buildsystems/engine.pl             |  55 ++-
 git.c                                      |   3 -
 t/t5505-remote.sh                          |   2 +
 t/t5516-fetch-push.sh                      |   4 +
 11 files changed, 581 insertions(+), 100 deletions(-)
 create mode 100644 contrib/buildsystems/Generators/Vcxproj.pm


base-commit: 9d418600f4d10dcbbfb0b5fdbc71d509e03ba719
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-287%2Fdscho%2Fvisual-studio-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-287/dscho/visual-studio-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/287
-- 
gitgitgadget
