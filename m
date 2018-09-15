Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27BDD1F42B
	for <e@80x24.org>; Sat, 15 Sep 2018 00:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeIOFTf (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 01:19:35 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:35621 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeIOFTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 01:19:35 -0400
Received: by mail-it0-f73.google.com with SMTP id w68-v6so5006446ith.0
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ADo+vNG03XLcJwlmiyFYnTCop3MRU4e+hWJnfv6SiOA=;
        b=PDuW5WiVWZzxvf3R07t+6UbALaqzydeQ6I283URnV/iSX0G67xYpH/nobQ9+F/ASoe
         SryD40KeTYzQWnb8r6bVyFgWcF0/kVladUriheblYO+1ohq6uyJDpLBr4VSP8d6a4E98
         p71aNV2MK4d6AUz3fIHciR4ouMyLPTp1rofl91QELavsqnNFass40hxqPGEOGQczYOKU
         vKxpYwLKHX9oD8NQ/uvGFmR+hYg7qftWdaSy5hKCF5LWn3RGgpJh0tV07vzpc5hZ+Pcq
         6ihQejsY1LhgqxzDvmzWfQ9jKgNg3xF2tvPZI9GcXUNEz+Tg4HXbKzMWzOEYQpPZgWF1
         PoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ADo+vNG03XLcJwlmiyFYnTCop3MRU4e+hWJnfv6SiOA=;
        b=MS5epgtS3Q6fbTtfI/aDuSv55ih1smthPTCim1bA84S8XxXb+hsnH89jdMNK+oxnGz
         hIIQETrB7IHUiMugY2+uLhjLY4n3LiQZC9Mv+Biusjw+j+bnRqbssABOeXYhX4LPE1IQ
         W+ZiBQKIt2MUp7wAaEOAMaIgv8cy6R0YIc01jgBJq2DanIJUJZQecNEyDK6o2DXaY4Pa
         ++DxZpY+keVG0B4W9vuMLUtcIjgO3J6lqfx5Aqia1EnVb1pCwvRbTAQ3vTeES5vdt5W7
         sezibuAtB2LyTTVBL1tFEGnJeQiMTufqq59XUzu0aEy+t30TdW/tJus8be0nqL4lZzWn
         tUcA==
X-Gm-Message-State: APzg51DC2XGCxiIHg04yhhNldshwa5nkr36WrD+6IXQihBrpJMTNobF1
        Vv6dqmjY8Jx/2v4FJVHvM9JeRMD6cxMy4ImMjiPG0CS7P5g82rKoopQmNSjpVDAdXrV2Xo+0Mqg
        ZVhoUwqcmLDOUCKNjP+vizoBZNEXnj08DjrgUX+1amWtX9AQw/VGLmSpnfWE=
X-Google-Smtp-Source: ANB0VdYyZvf/oc3eDEYB7+7cL2JoEbuHFk2uVAaRWUg52Ap2XN8Ylo2qW4Gv7CBMNmBkiVt08fBf4JdYvL+K
X-Received: by 2002:a6b:20ca:: with SMTP id g193-v6mr10345364iog.116.1536969771742;
 Fri, 14 Sep 2018 17:02:51 -0700 (PDT)
Date:   Fri, 14 Sep 2018 17:02:34 -0700
Message-Id: <cover.1536969438.git.matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH v1 0/2] Cleanup tests for test_cmp argument ordering and "|" placement
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As requested in:
 https://public-inbox.org/git/xmqqmuskas3a.fsf@gitster-ct.c.googlers.com/
this patchset corrects ordering of test_cmp arguments and | placement.

The request didn't explicitly state whether all the tests should be cleaned up,
but I did clean up as much as I reasonably could.

The linked mail above also requested cleaning up flag/positional arg ordering so
that flags appear first. The amount of wrong ordering I could find was small, so
I put that cleanup in the other patchset.

Matthew DeVore (2):
  t/*: fix pipe placement and remove \'s
  t/*: fix ordering of expected/observed arguments

 t/lib-gpg.sh                           |   4 +-
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
 t/t4124-apply-ws-rule.sh               |  30 +-
 t/t4138-apply-ws-expansion.sh          |   2 +-
 t/t5317-pack-objects-filter-objects.sh | 364 ++++++++++++++-----------
 t/t5318-commit-graph.sh                |   2 +-
 t/t5500-fetch-pack.sh                  |   5 +-
 t/t5616-partial-clone.sh               |  30 +-
 t/t5701-git-serve.sh                   |  14 +-
 t/t5702-protocol-v2.sh                 |  10 +-
 t/t6023-merge-file.sh                  |  12 +-
 t/t6027-merge-binary.sh                |   4 +-
 t/t6031-merge-filemode.sh              |   2 +-
 t/t6112-rev-list-filters-objects.sh    | 227 ++++++++-------
 t/t7201-co.sh                          |   4 +-
 t/t7406-submodule-update.sh            |   8 +-
 t/t7508-status.sh                      |   2 +-
 t/t7800-difftool.sh                    |   2 +-
 t/t9100-git-svn-basic.sh               |   2 +-
 t/t9101-git-svn-props.sh               |   4 +-
 t/t9133-git-svn-nested-git-repo.sh     |   6 +-
 t/t9600-cvsimport.sh                   |   2 +-
 t/t9603-cvsimport-patchsets.sh         |   4 +-
 t/t9604-cvsimport-timestamps.sh        |   4 +-
 38 files changed, 452 insertions(+), 363 deletions(-)

-- 
2.19.0.397.gdd90340f6a-goog

