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
	by dcvr.yhbt.net (Postfix) with ESMTP id 060771F461
	for <e@80x24.org>; Thu, 18 Jul 2019 22:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbfGRW5o (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 18:57:44 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56010 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfGRW5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 18:57:43 -0400
Received: by mail-pf1-f202.google.com with SMTP id i26so17431832pfo.22
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4OtgiW7XXHLOsP4rdjDHahdQCP2xFay6SLdE1u4GGcM=;
        b=T+xEBHWryvQQ2JN0q23uKvtn0rT7tLxYXDgLo1m3Vrz2i1mRPpa/RpgqcypvP2BgO9
         srUP9M88os0Z6TYs5LXzGb5VqBidjRaOWuC9fzsYhtrj7R6EvaoAbaOckgZVTROIza3O
         K56cRTJoyTxKyrOKLXtCdKzWoDfTzoEQuRUgV9qeReyk1TRtM10MFWsdERMBtFqdgHNv
         uJ99mcBs62AkZS0QKmw5FW+XdtE//jUIjfdsE9DaFSiSX2Jpybvr0QfvFtIdSYZJ89bV
         vZVBA1m8QtnVcApqrxJ7Eu9tR7rofXY/zlxSrgNK3hH9Ya0bQ3Cf3TjcsAc281OH4jIT
         MLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4OtgiW7XXHLOsP4rdjDHahdQCP2xFay6SLdE1u4GGcM=;
        b=TH1QmfdapWa3m4fkWf6grDBQSUPeLFiwb7HaUL4HwJb5/Uut9DwTWl5A004AyA1T0v
         bi33VyQJvc13APWxhv4OT2htyp/RFcy/mDhWnoytt3kPy6Enen12WL2u0FYCG8UCUSQG
         hEMxR6QtTfjOWltQbK1j9AUx+JK5RtJMnb5b9DWXmamn5UkwfreD7jITprgQpxlJwQup
         rxkDV4477BoJPwARakrlmPzxLgEKsPXFigfdhyrWiV5Z+STE2vVI2jX7C8e3rZ/Ge/bX
         L9+JA8FsCrYqHokBZQOoERDZZMJd8wX7H6jFyZbke/c9K6s4gpHM7hZ8Y2n27/o54d4j
         7AcA==
X-Gm-Message-State: APjAAAV4YBqyVJBN/WTb6PDxEHwY3GlkD8M8MANtoxZsLomDN3vI9n+w
        9+5/6z09hIHoA4rFmaeeNYsdXOjBBtPwV3y3YIQvFeG1h3gUoCIfo7M3VAaSVzCGgWleIKbOVfw
        m5J12sAKVkISqlEpNcD3ImWMqxpVvRS7nvsPZM3CejWMRHiZQV0eX6Lgll0W16Pg=
X-Google-Smtp-Source: APXvYqwT97NV36dNVuWlwjch7NcYR5MkpXXZvdnsfCSCZ0hfhut1+0uvoTDr+bNNT2Kdf190am03oKx/A81Rvw==
X-Received: by 2002:a63:1950:: with SMTP id 16mr50214510pgz.312.1563490662839;
 Thu, 18 Jul 2019 15:57:42 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:57:36 -0700
In-Reply-To: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
Message-Id: <cover.1563489311.git.steadmon@google.com>
Mime-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 0/4] pre-merge hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, stefanbeller@gmail.com,
        martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like to revive discussion on this series; I have addressed most
of the review comments on the original series sent by Michael, with the
following exceptions:

* Martin's objection on 1/4 that the sample hook would always exit
  successfully is (I believe) incorrect. To test this, I ran
  "/bin/true && exec test 0 == 1" in a /bin/sh subshell, and it
  correctly had a non-zero exit status.

* I'm not sure that I understand Stefan's objections on 4/4 regarding
  the hook's exit status. I am also not familiar with "the same
  (unsolved) issues [as] commit-msg".

I have noted my changes in each commit message in "[js: ...]" sections.

Michael's original series description is below:

Now that f8b863598c ("builtin/merge: honor commit-msg hook for merges",
2017-09-07) has landed, merge is getting closer to behaving like commit,
which is important because both are used to complete merges (automatic
vs. non-automatic).

This series revives an old suggestion of mine to make merge honor
pre-commit hook or a separate pre-merge hook. Since pre-commit does not
receive any arguments (which the hook could use tell between commit and
merge) and in order to keep existing behaviour (as opposed to the other
patch) this series introduces a pre-merge hook, with a sample hook that
simply calls the pre-commit hook.

commit and merge have very similar code paths. f8b863598c implemented
"--no-verify" for merge differently from the existing implementation in
commit. 2/4 changes that and could be first in this series, with the
remaining 3 squashed into 2 commits or 1. I've been rebasing and using
this series for years now, 2/4 is the new-comer which fixed the breakage
from f8b863598c that I encountered because of the no-verify
implementation.

Michael J Gruber (4):
  git-merge: Honor pre-merge hook
  merge: do no-verify like commit
  merge: --no-verify to bypass pre-merge hook
  t7503: add tests for pre-merge-hook

 Documentation/git-merge.txt                   |  2 +-
 Documentation/githooks.txt                    |  7 ++
 Documentation/merge-options.txt               |  4 ++
 builtin/merge.c                               | 18 ++++-
 ...> t7503-pre-commit-and-pre-merge-hooks.sh} | 66 ++++++++++++++++++-
 templates/hooks--pre-merge.sample             | 13 ++++
 6 files changed, 105 insertions(+), 5 deletions(-)
 rename t/{t7503-pre-commit-hook.sh => t7503-pre-commit-and-pre-merge-hooks.sh} (67%)
 create mode 100755 templates/hooks--pre-merge.sample

-- 
2.22.0.657.g960e92d24f-goog

