Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A801F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeIDBca (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33819 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so617699pgv.1
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YAMPl9pTKsVw+FecRsPGBcYISfM6xLnNCwjV7pgBhLY=;
        b=kEZqkPDqd4m0r1MJ85DtZgvKHKFNqVjJr7imQRBcfNy7ZOiw+odCsXE0Q++SbKHz23
         wRb+FwAQuIyQimKqXCFlcRy6fFuemCS5X7b2sjs0YpFaJgRy/9C2bZbXT8qOSAvUovCe
         Q5g9A9G324mgQqokHXTkOKqjdS10G62pGb7o5Rz9yn2dxZfRLMTsrmu2deTBFKaSitW8
         qSrzEeEfzhQECcbXAhg0T92uMLlK9LKaWm98dWSsXyoMffSSBLbJfzoY3r0gjs/n/D0d
         SzqGgiZXcCCTFfCXbcc7yWmNDfa3JmKBgJQSOb7KAGhJnBgWrk7OsTQGNbnzY94XJfnc
         gMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YAMPl9pTKsVw+FecRsPGBcYISfM6xLnNCwjV7pgBhLY=;
        b=j1Xo88AOMWBnE38PTxhq4nA1C1YXKUy7B3BwcFAvTp8Leh9jotGLfz45UF4xX3Ki6z
         svn4iNMOYgziB4oYiDNQ3GsFdELBicSVgJ4xGyVdGpNs+qInHq3wJy03QmMfUGt0Ue4i
         XklFmCyacpn8Ywsrlg3SgO7QNJv5OBKQDTbCLKpaNn/K0RSzxj8RruOwtN+cfIIjSKUg
         JJQ4lb3zOXqJYVXbYWiUPfT6wTNTZ9rwoUWfLYmqMJoWedRgPyCffRafxeSj68310llb
         UHpnQWr2tuF2W0k5B9aH1sC2vElTtsLt9z389UxPpY/Zd2KPpa1a889Fsx5vv0wVlDPp
         Nm1A==
X-Gm-Message-State: APzg51BAmLduPojuHwR9PWDbhFRQ1X8y9wVk7bcDL1rj7+cZoTpOaeWo
        QzemuGypJefgvXmB0+faBerC/TRz
X-Google-Smtp-Source: ANB0Vdb9hVY7i6els6ksvO8zgx7lMQoyfa/OsLNx1PTcHSfICtF/enBjadzfAdGr5BxRViUmOnL0KQ==
X-Received: by 2002:a62:34c4:: with SMTP id b187-v6mr30991414pfa.15.1536009029659;
        Mon, 03 Sep 2018 14:10:29 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y3-v6sm38833352pfi.24.2018.09.03.14.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:28 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:28 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:17 GMT
Message-Id: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
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

For a long time already, we have Git's source code continuously tested via
Travis CI, see e.g. https://travis-ci.org/git/git/builds/421738884. It has
served us well, and more and more developers actually pay attention and
benefit from the testing this gives us.

It is also an invaluable tool for contributors who can validate their code
contributions via PRs on GitHub, e.g. to verify that their tests do actually
run on macOS (i.e. with the BSD family of Unix tools instead of the GNU
one).

The one sad part about this is the Windows support. Travis lacks it, and we
work around that by using Visual Studio Team Services (VSTS) indirectly: one
phase in Travis would trigger a build, wait for its log, and then paste that
log.

As Git's Windows builds (and tests!) take quite a bit of time, Travis often
timed out, or somehow the trigger did not work, and for security reasons
(the Windows builds are performed in a private pool of containers), the
Windows builds are completely disabled for Pull Requests on GitHub.

One might ask why we did not use Visual Studio Team Services directly. There
were a couple of reasons for that:

 * most notably, VSTS's build logs could not be viewed anonymously,
 * while VSTS had Linux and Windows agents, it lacked macOS agents,
 * etc

The main two reasons no longer apply: macOS agents are available now
[https://docs.microsoft.com/en-us/vsts/release-notes/2018/jul-10-vsts], and
there is a limited preview of "public projects"
[https://blogs.msdn.microsoft.com/devops/2018/04/27/vsts-public-projects-limited-preview/]
, i.e. it is possible to configure a VSTS project so that anybody can view
the logs.

I had secured such a public project for Git for Windows already, and I
recently also got one for Git. For now, the latter is hooked up with my
personal git.git fork on GitHub, but it is my hope that I convince y'all
that these VSTS builds are a good idea, and then hook it up with 
https://github.com/git/git.

As a special treat, this patch series adds the ability to present the
outcome of Git's test suite as JUnit-style .xml files. This allows the VSTS
build to present fun diagrams, trends, and makes it a lot easier to drill
down to test failures than before. See for example 
https://git.visualstudio.com/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
[https://git.visualstudio.com/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details] 
(you can click on the label of the failed test, and then see the detailed
output in the right pane).

This patch series took way more time than I had originally planned, but I
think that in particular the advanced display of the test results was worth
it. Please let me know what you think about this.

Johannes Schindelin (9):
  ci: rename the library of common functions
  ci/lib.sh: encapsulate Travis-specific things
  test-date: add a subcommand to measure times in shell scripts
  tests: optionally write results as JUnit-style .xml
  ci/lib.sh: add support for VSTS CI
  Add a build definition for VSTS
  tests: include detailed trace logs with --write-junit-xml upon failure
  tests: record more stderr with --write-junit-xml in case of failure
  README: add a build badge (status of the VSTS build)

 .vsts-ci.yml                   | 296 +++++++++++++++++++++++++++++++++
 README.md                      |   2 +
 ci/install-dependencies.sh     |   5 +-
 ci/{lib-travisci.sh => lib.sh} |  67 ++++++--
 ci/mount-fileshare.sh          |  26 +++
 ci/print-test-failures.sh      |   4 +-
 ci/run-build-and-tests.sh      |   2 +-
 ci/run-linux32-docker.sh       |   2 +-
 ci/run-static-analysis.sh      |   2 +-
 ci/run-windows-build.sh        |   2 +-
 ci/test-documentation.sh       |   3 +-
 t/.gitignore                   |   1 +
 t/helper/test-date.c           |  12 ++
 t/test-lib.sh                  | 142 ++++++++++++++++
 14 files changed, 544 insertions(+), 22 deletions(-)
 create mode 100644 .vsts-ci.yml
 rename ci/{lib-travisci.sh => lib.sh} (61%)
 create mode 100755 ci/mount-fileshare.sh


base-commit: 2f743933341f276111103550fbf383a34dfcfd38
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-31%2Fdscho%2Fvsts-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-31/dscho/vsts-ci-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/31
-- 
gitgitgadget
