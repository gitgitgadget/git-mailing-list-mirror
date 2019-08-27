Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E669B1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfH0Fhs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:37:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42053 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Fhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:37:47 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so43330063iob.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MOxQqdeQIV+s48z8ozFsthLPjIBUe8yibcFdTsOFzRA=;
        b=ELyEDWk+/506rELjSt63BJ5C/wYXmLH2JbRK579z1tTwTIMJ5vQnyv8ym4vYGGg5Go
         AjyyXKmVfaHHLk/XAMg660ZE1TnHcHQy4tpFTiRUBbRJdK75ZzwguppwNn4wrCP/K6fr
         pPl6U/dVnmMDxMrMJYbUd72DWO1gNffU+Ngr0oLy80thT6uX3rUp8135dPV2rqti+lSg
         Trr4Ewef2/O+Sh2TjCCwV14Oe/2ixhfRhpNB5j48BX6H6cHNtfwojvXWWJ9dse8RvAqZ
         1r/dl0GDpt59EyROS7juw7iaVq5u3uwpjcVM9H4sEqAPt+XZtLwhbwT+P8t0ClYUjZO/
         Bc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MOxQqdeQIV+s48z8ozFsthLPjIBUe8yibcFdTsOFzRA=;
        b=rbVKFLyP14W02+dG3yUd1ehSL376LimCW8p6HwpLmeIIwOMHyv1LSFTb7/N28mCTGZ
         XmUvN00T4ix+dyF2d2lHiDrIRUj4JgjE7dEvV7rqH7Xwzyc+J5DFdw6xuXG2fCvFnODm
         dMXBJq/CEhfmDP2ZfgzrKpKPRlMo283SozHYWeQk1aqsjG2h7ZrRmDnDoUPTph+nKLH7
         gwPRKxPoY1qHkgN4nuqvgBDf5vm34/9Bx8kVCffBkAJOnNUxBi2coS0Nev6RL3RKtJeL
         ZnKg0xdUZvVww7TNqsQNaip5TJ4NyGTc2RRh9kuvBF2zEDoYzuLsvy8KGwBFP6KHxuVy
         vDqw==
X-Gm-Message-State: APjAAAW5BxBCQ7gp81jbqcxxOkN1gwANXh/tSfGnk8ZD2bA0db3GgyHV
        oLx4oJxCqyzpTtPj8xwOeeCI4mNZ
X-Google-Smtp-Source: APXvYqwEdhMsGeqQAVxfuSGARLVl+btC4bbwUEwnWtcB++DWcsAvmi8AqhFlM2ycSWAh4gWTuaJhIw==
X-Received: by 2002:a02:3004:: with SMTP id q4mr21331912jaq.55.1566884266278;
        Mon, 26 Aug 2019 22:37:46 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id j18sm6097227ioo.14.2019.08.26.22.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:37:45 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:37:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 0/9] rebase: learn --keep-base and improvements on
 fast-forward behaviour
Message-ID: <cover.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your suggestions, Pratyush and Philip. I've incorporated both
of them into this reroll.


Changes since v1:

* Squashed old set into one patch
* Fixed indentation style and dangling else
* Added more documentation after discussion with Ævar

Changes since v2:

* Add testing for rebase --fork-point behaviour
* Add testing for rebase fast-forward behaviour
* Make rebase --onto fast-forward in more cases
* Update documentation to include use-case

Changes since v3:

* Fix tests failing on bash 4.2
* Fix typo in t3431 comment

Changes since v4:

* Make rebase --fork-point fast-forward in more cases

Changes since v5:

* Fix graph illustrations so that the "branch off" is visually in the
  correct place
* Refactor if-else in can_fast_forward into one-level-deep ifs to
  increase clarity

Changes since v6:

* Remove redundant braces around if
* Update comment around can_fast_forward call
* Add completion for rebase

Changes since v7:

* Ævar sent in his WIP patchset

Changes since v8:

* Drop patches 9-13
* Fix some minor whitespace issues from v7

Changes since v9:

* Remove unnecessary if-statement in patch 6/9
* Update commit message for patch 9/9 for clarity according to Philip's
  suggestions

[1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/


Denton Liu (6):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: refactor can_fast_forward into goto tower
  rebase: fast-forward --onto in more cases
  rebase: fast-forward --fork-point in more cases
  rebase: teach rebase --keep-base

Ævar Arnfjörð Bjarmason (3):
  t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
  t3432: test for --no-ff's interaction with fast-forward
  rebase tests: test linear branch topology

 Documentation/git-rebase.txt           |  30 +++++-
 builtin/rebase.c                       |  84 ++++++++++++-----
 contrib/completion/git-completion.bash |   2 +-
 t/t3400-rebase.sh                      |   2 +-
 t/t3404-rebase-interactive.sh          |   2 +-
 t/t3416-rebase-onto-threedots.sh       |  57 +++++++++++
 t/t3421-rebase-topology-linear.sh      |  29 ++++++
 t/t3431-rebase-fork-point.sh           |  57 +++++++++++
 t/t3432-rebase-fast-forward.sh         | 125 +++++++++++++++++++++++++
 9 files changed, 360 insertions(+), 28 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

Range-diff against v9:
 1:  03f769d410 =  1:  03f769d410 t3431: add rebase --fork-point tests
 2:  bc8998079d =  2:  bc8998079d t3432: test rebase fast-forward behavior
 3:  5c08e2b81f =  3:  5c08e2b81f t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
 4:  48b4e41a17 =  4:  48b4e41a17 t3432: test for --no-ff's interaction with fast-forward
 5:  9bd34b4a40 !  5:  9acce7c911 rebase: refactor can_fast_forward into goto tower
    @@ builtin/rebase.c: static int can_fast_forward(struct commit *onto, struct object
     -		res = 0;
     +		goto done;
      	}
    --	free_commit_list(merge_bases);
     +
     +	oidcpy(merge_base, &merge_bases->item->object.oid);
     +	if (!oideq(merge_base, &onto->object.oid))
    @@ builtin/rebase.c: static int can_fast_forward(struct commit *onto, struct object
     +	res = 1;
     +
     +done:
    -+	if (merge_bases)
    -+		free_commit_list(merge_bases);
    + 	free_commit_list(merge_bases);
      	return res && is_linear_history(onto, head);
      }
    - 
 6:  becb924232 =  6:  3f208421d6 rebase: fast-forward --onto in more cases
 7:  4dab5847cb =  7:  126c20a95d rebase: fast-forward --fork-point in more cases
 8:  4699a90993 =  8:  bf6cc6a610 rebase tests: test linear branch topology
 9:  6927aba617 !  9:  6bc7423ac1 rebase: teach rebase --keep-base
    @@ Commit message
     
         in order to preserve the merge base. This is useful when contributing a
         patch series to the Git mailing list, one often starts on top of the
    -    current 'master'. However, while developing the patches, 'master' is
    -    also developed further and it is sometimes not the best idea to keep
    -    rebasing on top of 'master', but to keep the base commit as-is.
    +    current 'master'. While developing the patches, 'master' is also
    +    developed further and it is sometimes not the best idea to keep rebasing
    +    on top of 'master', but to keep the base commit as-is.
     
    -    Alternatively, a user wishing to test individual commits in a topic
    -    branch without changing anything may run
    +    In addition to this, a user wishing to test individual commits in a
    +    topic branch without changing anything may run
     
                 git rebase -x ./test.sh master... master
     
-- 
2.23.0.248.g3a9dd8fb08

