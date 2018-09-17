Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182FF1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeIRDx4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:53:56 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:36334 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeIRDx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:53:56 -0400
Received: by mail-vk1-f202.google.com with SMTP id m71-v6so2681023vke.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TSjCyiJVXZw29m7CS7hm2+xg87K/yfqozMkTQPUgfvE=;
        b=m4/JPYskHV4SMbV6Cwcm4qZpRmya5Q9rg+5rweEwrZVBLTSnWQLkd+wjktkfjHMaSf
         q9UGHPDWtkB1JZEf5cw2a110g7QCZtgZIbhnwXkG8BKfl5QMHd4stl6K6FKl+DUghyXE
         EMtti9WUW8A5t+qiKT/mA7HJYGlVqDvB/gYH2T+uu3kPxCcd55ot26i6vOqP/VsHL7dv
         vKIwygMWNwGGsiE7eD/NTnHA60d5yftkbtS9E9cqXPpGzKoRhgDpMCxhVmeP0ufLrkt4
         UXQWVLFTtFw2/LzNpYFovORhX8c69/lC6k7zjTs5VbCoMWqqrz0ujP9Wvk0KUmjR5mAX
         cOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TSjCyiJVXZw29m7CS7hm2+xg87K/yfqozMkTQPUgfvE=;
        b=CFbrAoPNLcbK5XFNyBPt/Y4Qo0X95XCJU/b5O996pb2C18aCeIaYRh0O+QtUNbiPIz
         9wiEv8CIPFVHCrd+UEKKPKNXXSHRUDjIwJ1pCtdROLlIG/1XYNRWJuOcfazTftwEhwr0
         o37uX+Z+W6QDl0n6S8riDCiAp1zO37KTNKuIzFUGkxokdolNwbB+iyPHXGKR/TjIaqqj
         6XAI6jetK3CEtw2M5aoogDYww7vlbLXZfPVUAeoxRBgZO/1abQE5Rusjl7GgHZpQ7FDT
         cUbkmAgpnUamxo5Kr7zBKOAxAyR5fdh5A4AOUHWWzy2TtU2Tk5O18JoTfRpl8Fu6LBVo
         f8Ow==
X-Gm-Message-State: APzg51C2Ky6OwE5xfSTbMsxA0PNIRPMBYCxdk2MN95uFz4iIXewXAVqa
        OGdI3SDpYAO72VlIIvl5gyORjBiYu/kETeMiUM/E1SXJSVTAvsXI+K0Lp9wzuoXtY8ZQmh9EQhX
        yY8ef+g7bHCMgTW7BKya8AErHTlNQ06C/XYqJjB3Z1kDF/gGLG1X1AFQGZI8=
X-Google-Smtp-Source: ANB0VdZlrTdZNDepfpchERKrDCn/gzYIkIgJY1B672b4XDRdVKM4eVgDHXrLxqdahlCMkGBUlyfeykqVH05U
X-Received: by 2002:a67:45c5:: with SMTP id z66-v6mr5461271vsf.24.1537223077217;
 Mon, 17 Sep 2018 15:24:37 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:24:16 -0700
In-Reply-To: <cover.1536969438.git.matvore@google.com>
Message-Id: <cover.1537222670.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 0/6] Clean up tests for test_cmp arg ordering and pipe placement
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies the suggestions from jrn@'s response to v1 here:
https://public-inbox.org/git/20180917163137.GB89942@aiede.svl.corp.google.com/

The major changes are:
 - Added two bullet points to Documentation/CodingGuidelines about 1) how to
   format pipe sequences and 2) using temporary files rather than pipes to
   avoid masking potiential error exit codes.
 - A new commit which introduces a linter check to enforce (1) above, which I
   am requesting feedback for. I'd be happy to drop it.
 - A new commit to fix violations of (2) above in t9101-git-svn-props.sh since
   it was not so trivial.
 - A better message to describe the pipe placement commit.

Thank you,

Matthew DeVore (6):
  CodingGuidelines: add shell piping guidelines
  tests: standardize pipe placement
  t/*: fix ordering of expected/observed arguments
  tests: Add linter check for pipe placement style
  tests: split up pipes
  t9109-git-svn-props.sh: split up several pipes

 Documentation/CodingGuidelines         |  29 ++
 t/Makefile                             |  12 +-
 t/lib-gpg.sh                           |   9 +-
 t/t0000-basic.sh                       |   2 +-
 t/t0021-conversion.sh                  |   4 +-
 t/t1006-cat-file.sh                    |   8 +-
 t/t1300-config.sh                      |   9 +-
 t/t1303-wacky-config.sh                |   4 +-
 t/t2101-update-index-reupdate.sh       |   2 +-
 t/t3200-branch.sh                      |   2 +-
 t/t3320-notes-merge-worktrees.sh       |   4 +-
 t/t3400-rebase.sh                      |   8 +-
 t/t3417-rebase-whitespace-fix.sh       |   6 +-
 t/t3702-add-edit.sh                    |   4 +-
 t/t3903-stash.sh                       |   8 +-
 t/t3905-stash-include-untracked.sh     |   2 +-
 t/t4025-hunk-header.sh                 |   2 +-
 t/t4117-apply-reject.sh                |   6 +-
 t/t4124-apply-ws-rule.sh               |  30 +--
 t/t4138-apply-ws-expansion.sh          |   2 +-
 t/t5317-pack-objects-filter-objects.sh | 360 ++++++++++++++-----------
 t/t5318-commit-graph.sh                |   2 +-
 t/t5500-fetch-pack.sh                  |   7 +-
 t/t5616-partial-clone.sh               |  30 ++-
 t/t5701-git-serve.sh                   |  14 +-
 t/t5702-protocol-v2.sh                 |  10 +-
 t/t6023-merge-file.sh                  |  12 +-
 t/t6027-merge-binary.sh                |   4 +-
 t/t6031-merge-filemode.sh              |   2 +-
 t/t6112-rev-list-filters-objects.sh    | 224 ++++++++-------
 t/t7201-co.sh                          |   4 +-
 t/t7406-submodule-update.sh            |   8 +-
 t/t7800-difftool.sh                    |   2 +-
 t/t9100-git-svn-basic.sh               |   2 +-
 t/t9101-git-svn-props.sh               |  24 +-
 t/t9133-git-svn-nested-git-repo.sh     |   6 +-
 t/t9600-cvsimport.sh                   |   2 +-
 t/t9603-cvsimport-patchsets.sh         |   4 +-
 t/t9604-cvsimport-timestamps.sh        |   4 +-
 39 files changed, 511 insertions(+), 363 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

