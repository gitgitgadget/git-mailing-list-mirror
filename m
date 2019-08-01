Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9008D1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfHAWUu (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:20:50 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49353 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfHAWUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:20:50 -0400
Received: by mail-qt1-f201.google.com with SMTP id l16so59343467qtq.16
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pr1bo7iVEjuIEGdtc+BvBLknl5Y0j9pwrWPw7McExPQ=;
        b=lfga4pVZbQh46HEHO2idsVW6Bo1VFbMNzuA2lOWvkMJkMxJQ6T1pJp0mRnaa2L2vDn
         3Y5bHtWoCeEutjKALFSpyV9RuBtMY7EmmVPyl0H/4EcO0QiqiCpr5+7tzyIFukMUevYW
         lTBW7zFzCii6r1zpUOl738JHstTSFcIuglUeWPbQKOjCwNp85cInaF/YCC0xyv2wTmvU
         CArDcqRE31vw0Or5MowwqTWQ3BkYEc8nZ6ncD4k192Vm3PUPIFfiZdFcseVjOQGBAi4B
         u9IJa9OpCQIEDi2jYj6kBP3Dy9DSf5kAYb+eRKWRT/pIbWJptg2vsnyp8FQKBc0Z1hc/
         Sa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pr1bo7iVEjuIEGdtc+BvBLknl5Y0j9pwrWPw7McExPQ=;
        b=gbhZbg8Vqn53n4dDOKovQnGzeVoSlSwSp4oNJKW66dd8/gl4LRc6E649HJvIlAKL+x
         1xlIb/XvnYDTNJSSZQKnjsSPLeSsfQFYaaAmaufFMEa8kWybZYimn+JUAc4/0MXbIBAT
         W5nan6X8vs12qMsYCf2U3YNHzu8IpFvBSZ/u5IwqS9rLo4zFPzs7j+n2kZJK2J7oTqnL
         1RirihFfJoc0OodwKDtSqt83PLmo/Ce99eFhdotVqSQdG4zuE7lgNGD16IPZ4GZYGDO7
         7kNDKSq5YU9ufGBXdv2Rc4BUPtex/v7YWjg1BTtI90JizwP7vTHjIBzg61QSslRQF3Bz
         Nf/A==
X-Gm-Message-State: APjAAAU4wxPZRcBNtsKrwTntaZRMI/8Uga4/Yv2nIG1U5sHa2r2nnEEM
        gxqNCD2mzwiedkAuFx9ZYOaUNTa21qqCgOx523rFQqZONMqBukPaFAfaKBdr62dZ+XjsmwMCI3I
        lgr8pDnTznjmh6O3gLg3LVkoCwn/MJ4GS4PbAINVKG6RrfwuKYnRKNy/fRYs2sME=
X-Google-Smtp-Source: APXvYqy0lLnr2uIENlUKfzeIjw4YeuHGgM36CoFiVmtV6bewHh5rEyPzGNB1TzM5CK8tivdixjmJahHTDTinTA==
X-Received: by 2002:a0c:8791:: with SMTP id 17mr95676683qvj.215.1564698049194;
 Thu, 01 Aug 2019 15:20:49 -0700 (PDT)
Date:   Thu,  1 Aug 2019 15:20:42 -0700
In-Reply-To: <cover.1563490164.git.steadmon@google.com>
Message-Id: <cover.1564695892.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1563490164.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 0/4] pre-merge-commit hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a new pre-merge-commit hook, similar in usage to
pre-commit. It also improves hook testing in t7503, by verifying that
the correct hooks are run or bypassed as expected.

The original series was done by Michael J Gruber <git@grubix.eu>. I have
addressed the outstanding review comments, and noted my changes in the
commit messages in "[js: ...]" blocks.

Changes since V2:
* Renamed the hook from "pre-merge" to "pre-merge-commit".
* Added a new patch (1/4) to improve t7503 by verifying that the
  expected hooks are (or are not) run.
* Squashed test changes (from V2's patch 4/4) into patch 3/4.
  Modified the tests to follow the example set in patch 1/4.
* Reworded commit messages to match with the current state of certain
  flags, which changed in between V1 and V2 of this series.

Josh Steadmon (1):
  t7503: verify proper hook execution

Michael J Gruber (3):
  merge: do no-verify like commit
  git-merge: honor pre-merge-commit hook
  merge: --no-verify to bypass pre-merge-commit hook

 Documentation/git-merge.txt                   |   2 +-
 Documentation/githooks.txt                    |   7 +
 Documentation/merge-options.txt               |   4 +
 builtin/merge.c                               |  18 +-
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 237 ++++++++++++++++++
 t/t7503-pre-commit-hook.sh                    | 139 ----------
 templates/hooks--pre-merge-commit.sample      |  13 +
 7 files changed, 277 insertions(+), 143 deletions(-)
 create mode 100755 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
 delete mode 100755 t/t7503-pre-commit-hook.sh
 create mode 100755 templates/hooks--pre-merge-commit.sample

Range-diff against v2:
1:  e8b3fd8a5b < -:  ---------- git-merge: Honor pre-merge hook
-:  ---------- > 1:  f0476b2b1e t7503: verify proper hook execution
2:  36406a85be ! 2:  89ddbf410f merge: do no-verify like commit
    @@ Commit message
         "git merge --help" to be more clear that the hook return code is
         respected by default.
     
    -    [js: reworded commit message, and moved documentation changes from patch
    -     3/4 to this commit.]
    +    [js: * reworded commit message
    +         * squashed documentation changes from original series' patch 3/4
    +    ]
     
         Signed-off-by: Michael J Gruber <git@grubix.eu>
    @@ Documentation/git-merge.txt: SYNOPSIS
     +  [--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
        [--[no-]allow-unrelated-histories]
        [--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
    - 'git merge' --abort
    + 'git merge' (--continue | --abort | --quit)
     
      ## Documentation/merge-options.txt ##
     @@ Documentation/merge-options.txt: option can be used to override --squash.
3:  2440ad35e4 < -:  ---------- merge: --no-verify to bypass pre-merge hook
4:  69dc3696e7 < -:  ---------- t7503: add tests for pre-merge-hook
-:  ---------- > 3:  61b989ff16 git-merge: honor pre-merge-commit hook
-:  ---------- > 4:  45828c56fc merge: --no-verify to bypass pre-merge-commit hook

-- 
2.22.0.770.g0f2c4a37fd-goog

