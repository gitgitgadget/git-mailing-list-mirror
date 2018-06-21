Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA961F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933804AbeFUV3b (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:29:31 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:34551 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbeFUV33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:29 -0400
Received: by mail-qk0-f201.google.com with SMTP id q23-v6so3795467qkl.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=yf+XMM8tDKnomsk+FCJmkOtQ9XJMuR5Aq62LFVagwOU=;
        b=aaWR2z6xIKfW4UCrWdEM02GZ9EPeCRTQLw0f+x37fHmezBXNa0CaNbrqZguovyRkIv
         OVlI4dYv0lkqplc7XS72mFVUThP8EOXJzzVKe8XVCcspqjdqOHrFIZvaEGzc/zKlMbHb
         UEy8ead0hdj2jQAWnVPsOfji0nJk3me0kGMJ8G7C4vMvWB/KvduMYmBTsDf728QSe4j4
         LYMdIOzYh8YhM0H2E42LE7OS9T9olEfPkDWLnUBW7Rg+M1ENW4caY/prcXpsZwgKrKbY
         3QYcdly7CzlI+6Qj3pBrEXpKqc/DkQq36sJWZ0eXNAuHCK69sefqpZ5e25YhCYfMp66O
         ZHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=yf+XMM8tDKnomsk+FCJmkOtQ9XJMuR5Aq62LFVagwOU=;
        b=eRm23FufcnsCZ8CqNYWhfFxp8Pj8t15Sqs4LP+RTLkb5akjI2eOA4dE2pXcIoVWkiP
         Bjcz6kjJIg2EltIVSbjaiUsjJ7/SOesz8By3J+gj1xFnWnydZ8992NbNO+cgMx7uxKWQ
         0TTIyi8/sBaLT50gLCMqSk4rhKSeAAza1VzM3b4MdP44nossCx4IIyk4TYgtUogSggil
         uqq96mHu6eOhZxs7bwCj/RgBnD8txl37fWBr8LVvpRQGrwjC0AFTv8b980h5Q0aoV9Sw
         3MXIjD356VwhG/t/h2n8O1dH7Wo/70YogbZcYu6GymM3DbcwTkEeWfltODRlDgf6buix
         0wuA==
X-Gm-Message-State: APt69E04CVFzq0bdyKWopqIVJRObF8TAjUyNg3zs0Z4vc0BgdaTIedUa
        RqO+gytIRUfB/nT3Efx8XMAztdOFKPH2Oqke/smheBX3y/LuMJeF2iBENGfwrryYtRZwSwRhHjE
        JQDjr021yM8VlxViaJOO0Tt1tgFpVZrz83roYLqarYIQUuZ0R/3LN9lg4dONVFbYoST4gK3dtlo
        Sv
X-Google-Smtp-Source: AAOMgpc3dNGhM9Dam54GrzPD1MYWCAdh1SWgeN5BQGlz/GG9XcnRQ6bnRnQthaicMj6RZ526OOIZZiBGZ8z/l92QQ0V1
MIME-Version: 1.0
X-Received: by 2002:a0c:f751:: with SMTP id e17-v6mr721772qvo.29.1529616568806;
 Thu, 21 Jun 2018 14:29:28 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:29:20 -0700
Message-Id: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: [PATCH 0/5] Object store refactoring: commit graph
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues the object store refactoring effort by making commit
graphs of any repository be readable, not just the commit graph of
the_repository.

This enables the conversion of other functions in the future, functions
like parse_commit (which first tries to parse from the commit graph).

I didn't modify the function that writes commit graphs - perhaps that
can be done in a subsequent series.

Jonathan Tan (5):
  object-store: add missing include
  commit-graph: add missing forward declaration
  commit-graph: add free_commit_graph
  commit-graph: store graph in struct object_store
  commit-graph: add repo arg to graph readers

 Makefile                   |  1 +
 builtin/commit-graph.c     |  2 +
 cache.h                    |  1 -
 commit-graph.c             | 90 ++++++++++++++++++++++----------------
 commit-graph.h             |  9 +++-
 commit.c                   |  4 +-
 config.c                   |  5 ---
 environment.c              |  1 -
 object-store.h             |  6 +++
 object.c                   |  5 +++
 t/helper/test-repository.c | 88 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/t5318-commit-graph.sh    | 35 +++++++++++++++
 14 files changed, 201 insertions(+), 48 deletions(-)
 create mode 100644 t/helper/test-repository.c

-- 
2.18.0.rc2.347.g0da03f3a46.dirty

