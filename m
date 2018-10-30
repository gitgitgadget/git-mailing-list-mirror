Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F311F453
	for <e@80x24.org>; Tue, 30 Oct 2018 09:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJ3SPH (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 14:15:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38425 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3SPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 14:15:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id p7-v6so5236875plk.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cXXGlx7Vcd7OmN2bexawLB9axWvgH+M1r3Hr1VCe5nA=;
        b=oOyodlHRd3BpyoUiYY3nw5xt1/+3fUXedn2EJth46CiI0jB0e9wnWsCKFDJtSvVWdu
         UvRf5Q65LO7WEEHMZXa71qc8QDP1u1U0tkr0PIMP6NiAtgcl3BeUUwgbBBLj8jYyjAhI
         Iwi5gltlgwh2ALagQ8rPLmlLCQYHTG7v50t2G9VHrg/e0s4Bdsd/KJ3dgGkN1KVy5TaS
         DV0MPO/5hXJri+gjzdVW8Gsfj7PWYrPouX8RIioYFgxfwqmCtt3kkxoA4S+moRok4EsP
         +uicYZXQfgiknH27i+/AB9W5Y5jMZUfGmuBXsMUp6ZkXokml/EXD1r8wG6xE5Tk1+9R1
         pufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cXXGlx7Vcd7OmN2bexawLB9axWvgH+M1r3Hr1VCe5nA=;
        b=YoYa6RA2buNKSuzHnjLy0moDwUxm6V7FliPhPywfhT9judKY+80oOZhwQGN3hAMw0l
         8GuYzzjGMK0wzz3YstGGqQvCFgs9ZX3IXsDMNQgA0dGFTSOculhnorXJJQyErgk80x9X
         KvwRmipJqiudmzU4C8JGpq6bEkMBGgWiUey6hZXPFCuhQaEXyKdg7nFWjh/bAd+VjImX
         EaHNxuuoIO3rSQFOlr8GVVA6GLowpIMi+GTlnrcRfwrggc4MykthGC1/p4byUnl+YIsq
         YiP8PbxJFNxTzOUy58F45W/GnW4fs8yorbi8r2mqS0XWfm8ujCsYJ5m9K4iMeQc1oR+D
         pHww==
X-Gm-Message-State: AGRZ1gLlazb+KXTn8INVhafqTyCwVl6T8bo3O0rLpD+dbxmmT+PJgjyQ
        vO2DbSG6qGNjz4SlRj4ZvTJBF7db
X-Google-Smtp-Source: AJdET5dlgqOpHyyZmWRETWeaTCYux41pdbikGwbzwwN6jX4qTqUufRTqYzCO3BMdk/pGqMWu729uhA==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10-v6mr18069089plb.294.1540891348640;
        Tue, 30 Oct 2018 02:22:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id n79-v6sm35858424pfk.19.2018.10.30.02.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 02:22:27 -0700 (PDT)
Date:   Tue, 30 Oct 2018 02:22:27 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 09:22:23 GMT
Message-Id: <pull.57.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] mingw: rework the environment handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Karsten Blees <karsten.blees@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, the Git for Windows project had to decide what to do about
Unicode support, including how to deal with the environment. Karsten Blees
spent a ton of work on this, culminating in the final version
[https://groups.google.com/d/msg/msysgit/wNZAyScbJG4/viWz2KXU0VYJ] which
made it into Git for Windows and at least partially into core Git, too.

The environment handling in particular is a bit tricky: Windows actually has 
two copies of the environment, one encoded in UTF-16, and the other one in
the local encoding. Since we want UTF-8 encoded values (which is not an
option for the local encoding), we had to convert from/to the UTF-16
environment.

At the time those patches were developed, there were so many getenv()/
putenv() calls in Git's code base that it seemed the best solution to
convert the entire environment into UTF-8 in one go, at startup.

There are good reasons for us to change that paradigm now (and this patch
series does that):

 * The method we use does not work with modern MSVC runtimes (__environ can
   no longer be overridden).
 * Our method of having a malloc()ed environment wreaks havoc if a library
   we use calls MSVC's version of setenv() (I am looking at you, libcurl).
 * In the meantime, core Git's usage of getenv()/putenv() was reduced
   dramatically (for unrelated reasons), so that it is actually advantageous
   nowadays to convert on the fly, i.e. with each getenv()/putenv() call,
   rather than doing one wholesale conversion at process startup. See also
   the commit message of the second patch.

Note: in contrast to other patches flowing from Git for Windows to Git these
days this patch has not been in Git for Windows for ages. Its approach has
been tested in some MS Visual C++ builds (thanks, Jeff Hostetler!), though,
so I am quite confident that it is correct, and the test suite agrees.

Johannes Schindelin (2):
  t7800: fix quoting
  mingw: reencode environment variables on the fly (UTF-16 <-> UTF-8)

 compat/mingw.c      | 280 ++++++++++++++++++++++++++------------------
 compat/mingw.h      |  32 ++++-
 t/t7800-difftool.sh |   2 +-
 3 files changed, 197 insertions(+), 117 deletions(-)


base-commit: c670b1f876521c9f7cd40184bf7ed05aad843433
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-57%2Fdscho%2Fmingw-utf-8-env-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-57/dscho/mingw-utf-8-env-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/57
-- 
gitgitgadget
