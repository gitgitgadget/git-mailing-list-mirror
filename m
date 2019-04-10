Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233B520248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfDJRhw (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:37:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfDJRhw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id w3so2770562edu.10
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qDO8pDzdkrVzdEIBICOEJ4NPoMKLnju49GJDGKGrLjY=;
        b=NWzQf2kcFgMgshgszVRvIlvh7OFesopWHLxaru1b2IIISy7viXYbKidyYwo5XZDddb
         9p8OkqxBE/6xmhhi7UAbfxBJLxNS4Q8MAJKPwGaObi6u+0Wzlm6Yp3DTtUP9xLHfaZyW
         /DK0b56MYzaEqEjv0B3pf+exoybIJoJqGvqBbd9n/NbKKb8fe2cinQLHlCENlHJmyDxQ
         igwoJRIOeaMoVRnqT9/TB0XQAduBSNBLnvOeP4ijOW64hz53TaJLVj9BuxtAYzGwiJ3+
         I9MlV8KR7QPT1Vc81potAGq5CaY6UFndE3zemPTEcelAELqvDbJwNBDippxWSAwb+wwB
         NICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qDO8pDzdkrVzdEIBICOEJ4NPoMKLnju49GJDGKGrLjY=;
        b=bU1/hShZS24Edeghz8dPeJswiTET6UQAWv2FbZYT8ea3URaTDR4l0isF3zjb3+DcqI
         ZCjT8Ru5ugMaVvZj/itNOilrpGxHi5pCr75RGcYsVGJW7JbLP8sJEk+YleHWHsGKZ7Np
         5w7KiHpPNar7zLMKKJH8T26wed3l8UbP3W2yxRKKR0HjLQHjedFEvgK8Z5XIbabJrgii
         nsaihHReGtmf63tP1FOCr/OrRMZ5WAD8xA37TlSh3gFqfstlPOLGpx+vXBY3LqltbT/P
         vZQS5Or+4ag5JZL28DQfWIENuU+pjttX98chCH+ezYB8H18L5T8kXidIC+fx2KDpXBcd
         3/FQ==
X-Gm-Message-State: APjAAAWThfSR1dLg4Kw2jDg3dfjMgPuYqUEB1DF9cTnaYAeK00ANTSb9
        PR3vApNz3ukw1Ue9KqhJu7j6zCAo
X-Google-Smtp-Source: APXvYqwXWarSQqqObFRdfYzLBqTEaNvpp7H23w3x7EGUniP2AAE/7FcvKRgYKyYS9CBq12VIli122Q==
X-Received: by 2002:a50:b3b1:: with SMTP id s46mr28671174edd.202.1554917870191;
        Wed, 10 Apr 2019 10:37:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm4622063edt.36.2019.04.10.10.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:49 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:49 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:37 GMT
Message-Id: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/11] git add -i: add a rudimentary version in C (supporting only status and help 
 so far)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first leg on the long journey to a fully built-in git add -i 
(next up: parts 2 [https://github.com/gitgitgadget/git/pull/171], 3
[https://github.com/gitgitgadget/git/pull/172], 4
[https://github.com/gitgitgadget/git/pull/173], 5
[https://github.com/gitgitgadget/git/pull/174], and 6
[https://github.com/gitgitgadget/git/pull/175]).

It reflects the part that was submitted a couple of times (see 
https://github.com/gitgitgadget/git/pull/103) during the Outreachy project
by Slavica Ðukic that continued the journey based on an initial patch series
by Daniel Ferreira.

This part only implements the status and the help part, like Slavica's last
iteration did, in the interest of making the review remotely more
reviewable. I fear that this attempt of making it a bit more reviewable is
pretty futile, as so many things changed. So I will ask the reviewers for
forgiveness: please be kind, and give this sort of a fresh review.

I threw in a couple of major changes on top of that iteration, though:

 * The original plan was to add a helper (git add--helper) that takes over
   more and more responsibility from the Perl script over the course of the
   conversion.
   
   This plan is no longer in effect, as I encountered a serious problem with
   that: the MSYS2 runtime used by the Perl interpreter which Git for
   Windows employs to run git add -i has a curious bug (that is safely
   outside the purview of this here patch series) where it fails to read
   from standard input after it spawned a non-MSYS2 program (such as 
   add--helper) that reads from standard input. So that wouldn't work, but
   quit the interactive add as soon as even one interactive command had been
   handled by the helper. To keep my git add -i in a working state, I
   therefore adopted a different strategy:
   
   Just like git difftool was converted by starting with a built-in that did
   nothing but handing off to the scripted version, guarded by the (opt-in) 
   difftool.useBuiltin config setting, I start this patch series by a
   built-in add -i that does nothing else but state that it is not
   implemented yet, guarded by the (opt-in) add.interactive.useBuiltin 
   config setting.
   
   In contrast to the git difftool situation, it is quite a bit easier here,
   as we do not even have to rename the script to 
   git-legacy-add--interactive.perl: the add--interactive command is an
   implementation detail that users are not even supposed to know about.
   Therefore, we can implement that road fork between the built-in and the
   scripted version in builtin/add.c, i.e. in the user-facing git add 
   command.
   
   This will also naturally help with the transition to a fully built-in git
   add -i/git add -p, as we saw with the built-in git rebase how important
   it is for end users to have an escape hatch (and for that reason, tried
   our best to provide the same with the built-in git stash).
   
   
 * The help command was actually not hooked up in git add -i in Slavica's
   last iteration, but was only available as a special option of the git
   add--helper command. As that command no longer exists, I kind of had to
   implement some way to let the built-in git add -i show the help text.
   
   
 * The main loop of git add -i (i.e. the thing that lets you choose status 
   or help) is now implemented (but only lists status and help, of course),
   as it makes use of that feature that took the main chunk of the Outreachy
   project: the function to determine unique prefixes of a list of strings.
   
   
 * Speaking of the unique prefixes: the functionality to determine those is
   now encapsulated in the prefix-map.c file, and I also added a regression
   test.
   
   
 * Speaking of the tests: I also implemented support for the environment
   variable GIT_TEST_ADD_I_USE_BUILTIN: by setting it, the test suite can be
   forced to use the built-in, or the Perl script, version of git add -i.
   Needless to say: by the end of this patch series, running the test suite
   with GIT_TEST_ADD_I_USE_BUILTIN=true will still result in a ton of test
   failures due to not-yet-implemented commands, but it will also
   demonstrate what already works.
   
   
 * Since the main loop starts not only by showing the status, but refreshes
   the index before that, I added that, and I actually refactored that code
   into a new function (repo_refresh_and_write_index()), as it will be used
   a couple of times by the end of the complete conversion of git add -i 
   into a built-in command.

Daniel Ferreira (2):
  diff: export diffstat interface
  built-in add -i: implement the `status` command

Johannes Schindelin (6):
  Start to implement a built-in version of `git add --interactive`
  built-in add -i: refresh the index before running `status`
  built-in add -i: color the header in the `status` command
  built-in add -i: implement the main loop
  built-in add -i: support `?` (prompt help)
  built-in add -i: implement the `help` command

Slavica Djukic (3):
  Add a function to determine unique prefixes for a list of strings
  built-in add -i: show unique prefixes of the commands
  built-in add -i: use color in the main loop

 Documentation/config/add.txt |   5 +
 Makefile                     |   3 +
 add-interactive.c            | 560 +++++++++++++++++++++++++++++++++++
 add-interactive.h            |  10 +
 builtin/add.c                |  16 +-
 diff.c                       |  37 +--
 diff.h                       |  19 ++
 prefix-map.c                 | 111 +++++++
 prefix-map.h                 |  40 +++
 repository.c                 |  19 ++
 repository.h                 |   7 +
 t/README                     |   4 +
 t/helper/test-prefix-map.c   |  58 ++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0016-prefix-map.sh        |  10 +
 t/t3701-add-interactive.sh   |  24 ++
 17 files changed, 902 insertions(+), 23 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 prefix-map.c
 create mode 100644 prefix-map.h
 create mode 100644 t/helper/test-prefix-map.c
 create mode 100755 t/t0016-prefix-map.sh


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2Fdscho%2Fadd-i-in-c-status-and-help-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho/add-i-in-c-status-and-help-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/170
-- 
gitgitgadget
