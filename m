Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SUBJ_ALL_CAPS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C344020A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 23:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGXyj (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 18:54:39 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39929 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXyj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 18:54:39 -0500
Received: by mail-qt1-f201.google.com with SMTP id u20so5364539qtk.6
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 15:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3ZRYpCL96yRHe9380oBnhNEtQOPzUYCuQ0BXB2yCHns=;
        b=EgWls6xm4YB9xXOkAV62Sz//3CaOcWUq4Etxdqj6E+hGSMhm0oKfVs6TxVVsutCJvA
         qT9vKACfUiMJ3ktzZcBGQLlVQ5ARy5vjmzb45nsgfjElxFmqlmP7RkZeutnWActZTOQd
         HNE8ffi4KBYg+aSDvAPH9cpHnYeUQLHWImlJ3C0j7oFGyFACvmMwB+DYiiRwLOUCLIg3
         mW8rwUZS5H0L8QJqPwKxL6UMCLk4M8FQIokQ2RZJZRujk1ADx5HThE0Bh9XnFqcADbgl
         uiEYYluHwc+9yWRDL1dO3dpWrTk4QDcIx3BwjANnhNJTsf7j1XQkwEXdSCsiga3geLfV
         4lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3ZRYpCL96yRHe9380oBnhNEtQOPzUYCuQ0BXB2yCHns=;
        b=crHe2Qf9NqCoGImPDrRa4K5j+R3FYK9aZPYmGmTfFajYBKx4fv5IqdzeN5ISAAfyam
         mqHzomEPTO+AnaDV59WTC69qEfl1RFx8ukl0Kh8VVB1LG0ZX3y+y8969EYQYaAJE1hVa
         ZzImSE7M9zpDhbYdSeog25yf/9rTXJdZ8T+yikISRZjV12jmdE5z0bqI0OfkzORKGR08
         2Ni6mQ3yfkIlKal2dXFHICp06WX22vgciMNyoXGiMTitLvLmUoduL+j4mrM9Z8z2xyMP
         l9kOMqxzMOHxmZIcKwoebUQXMCvJh4AOEO2eFTjOtd4eNYGyfgIEyBfrdZdHnQobzOa7
         DVew==
X-Gm-Message-State: AA+aEWbuY8Rp4wEX1vyivDPZScKjX8u23MY9ImRQdeiVVa8xvbjpKVND
        FvMRhFaj4Go3eQSpb38H7R5dImx/EHrVSlOBvimrFkxmr+W36hneIcvgxwinv6C23uP9sZdP37N
        LGL+gChelzmBRQikby/TVklR2QXgVS1Rl5P5HZehGkvFlSZbc0tHn8FbT1FPH
X-Google-Smtp-Source: AFSGD/U2W89D2heZJrhBxBhzNs6cwpUerRK1Ups9XBkeGzyXWMQsbvqne/GdtsWs1HmpOYRRh/3MwFb1yO3A
X-Received: by 2002:a0c:8a7c:: with SMTP id 57mr3069604qvu.45.1544226878570;
 Fri, 07 Dec 2018 15:54:38 -0800 (PST)
Date:   Fri,  7 Dec 2018 15:54:21 -0800
Message-Id: <20181207235425.128568-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 0/4]
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple days before the 2.19 release we had a bug report about
broken submodules[1] and reverted[2] the commits leading up to them.

The behavior of said bug fixed itself by taking a different approach[3],
specifically by a weaker enforcement of having `core.worktree` set in a
submodule [4].

The revert [2] was overly broad as we neared the release, such that we wanted
to rather keep the known buggy behavior of always having `core.worktree` set,
rather than figuring out how to fix the new bug of having 'git submodule update'
not working in old style repository setups.

This series re-introduces those reverted patches, with no changes in code,
but with drastically changed commit messages, as those focus on why it is safe
to re-introduce them instead of explaining the desire for the change.

[1] https://public-inbox.org/git/2659750.rG6xLiZASK@twilight
[2] f178c13fda (Revert "Merge branch 'sb/submodule-core-worktree'", 2018-09-07)
[3] 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17)
[4] 74d4731da1 (submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13)

Stefan Beller (4):
  submodule update: add regression test with old style setups
  submodule: unset core.worktree if no working tree is present
  submodule--helper: fix BUG message in ensure_core_worktree
  submodule deinit: unset core.worktree

 builtin/submodule--helper.c        |  4 +++-
 submodule.c                        | 14 ++++++++++++++
 submodule.h                        |  2 ++
 t/lib-submodule-update.sh          |  5 +++--
 t/t7400-submodule-basic.sh         |  5 +++++
 t/t7412-submodule-absorbgitdirs.sh |  7 ++++++-
 6 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805-goog

