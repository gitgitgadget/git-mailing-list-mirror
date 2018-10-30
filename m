Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930371F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJaDel (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:34:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41770 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDel (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:34:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so3259618pfn.8
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=E91ZmptrsqYkwGUGeh/SPaqrGysUpDEl3i1rHvSrVrY=;
        b=OzhlXd0faTfu5Fpw590DHpHx7DKXC2S4UJk/sujtfHTSxk1z5Hp660/0XTxzmFO8mP
         SPwksiuKsITkUhsegrP93htvVawpQsm+9plA3iNBHuWPQ7mWuZvtfJ3HXonxIRDUf9SK
         Ik0Kn5V0YmDgUdc++6gGyIvLFQlVP0N0/v7irnihs8orebgNjccVnhBfhV423oWO5kgp
         n7YPIEaWlL4pj3vc3oyIP+S19CDB8ZV7i8vJKTL98v+JZfHmt26tedO3w6FtlWjlCJi3
         +vOfMiGJnKZqse7at/OoMR0LRnSrtvb5Rn/lqpdkSgucGmMuk7lZ8KKwbSpRH6YZe6Xv
         Hntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E91ZmptrsqYkwGUGeh/SPaqrGysUpDEl3i1rHvSrVrY=;
        b=Cl0WOAx+c3sUXPqh2mKPrds+vnDU0H+CTxP9He+WFTfruwAxijngV6Ajt7Ok1wGlWE
         NF5Q0N8rSk/Nw5/M/ey54AEDJJNJhlIcQH6zADoFthTgaeU5Ol9E2FJObu1FSEgYunxr
         RK4qeGkgVYg435p5FfXp/geY4y6kbqm3ECsvznZUQjILc7Fjsj898gXMKTLs4RWtGDrT
         o+u8jUL2BIUQJr4Vc2L3ASr64opNPVCjqLIhW+PHfCC3hynOgPUeoP6bynsI3aAqWWN6
         rfcwnN3mPehGE6B1uUiygbCeWLOEprv1EAHi0KQaLMin7lGY1HxiR4MqYY6fQ18kJAaK
         eAjw==
X-Gm-Message-State: AGRZ1gIiZhUg8sKmQQEIOnytAW23L2V36Hk+rKsEkvXngxHy81O4Mboz
        AqWS6NaAxKMFbhpfZfjBxA8OPfXJ
X-Google-Smtp-Source: AJdET5ejbJD1Ond/220FIQyN6N9tsGgsx5IV/EL/wFDQX45M2dKhhF4IjhSfe0gwsocvQaUt27sXgw==
X-Received: by 2002:a63:9304:: with SMTP id b4-v6mr45577pge.36.1540924802878;
        Tue, 30 Oct 2018 11:40:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y144-v6sm34455063pfb.81.2018.10.30.11.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:40:02 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:40:02 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:39:55 GMT
Message-Id: <pull.62.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] mingw: prevent external PERL5LIB from interfering
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

In Git for Windows, we do not support running the Perl scripts with any
random Perl interpreter. Instead, we insist on using the shipped one (except
for MinGit, where we do not even ship the Perl scripts, to save on space).

However, if Git is called from, say, a Perl script running in a different
Perl interpreter with appropriately configured PERL5LIB, it messes with
Git's ability to run its Perl scripts.

For that reason, we devised the presented method of defining a list of
environment variables (via core.unsetEnvVars) that would then be unset
before spawning any process, defaulting to PERL5LIB.

An alternative approach which was rejected at the time (because it
interfered with the then-ongoing work to compile Git for Windows using MS
Visual C++) would patch the make_environment_block() function to skip the
specified environment variables before handing down the environment block to
the spawned process. Currently it would interfere with the mingw-utf-8-env
patch series I sent earlier today
[https://public-inbox.org/git/pull.57.git.gitgitgadget@gmail.com].

While at it, this patch series also cleans up house and moves the
Windows-specific core.* variable handling to compat/mingw.c rather than
cluttering environment.c and config.c with things that e.g. developers on
Linux do not want to care about.

Johannes Schindelin (4):
  config: rename `dummy` parameter to `cb` in git_default_config()
  Allow for platform-specific core.* config settings
  Move Windows-specific config settings into compat/mingw.c
  mingw: unset PERL5LIB by default

 Documentation/config.txt     |  6 ++++
 cache.h                      |  8 -----
 compat/mingw.c               | 58 +++++++++++++++++++++++++++++++++++-
 compat/mingw.h               |  3 ++
 config.c                     | 18 ++++-------
 environment.c                |  1 -
 git-compat-util.h            |  8 +++++
 t/t0029-core-unsetenvvars.sh | 30 +++++++++++++++++++
 8 files changed, 109 insertions(+), 23 deletions(-)
 create mode 100755 t/t0029-core-unsetenvvars.sh


base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-62%2Fdscho%2Fperl5lib-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-62/dscho/perl5lib-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/62
-- 
gitgitgadget
