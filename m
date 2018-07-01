Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804541F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeGABZ3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:29 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43842 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGABZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:21 -0400
Received: by mail-ot0-f194.google.com with SMTP id b10-v6so11897779otl.10
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fkKVSzBJj8nHPQJgCix44EB7ngnH86Vt/nCJrDav/Ws=;
        b=Prb6MTfVLd1lhdhE4TCsehJ2VSjuKdTxr+ptjrY1XeovstsVrgH+wn3vhss6FjvCjg
         T5r+GrJzmewnLqQjIMOqtNourWTAYseBy9G5+9ZJJ+c6p+j9xgxGUXRmXqQHKxjeozie
         fOT8++dvfWWOgBIWjRAtEENbg0d8A3wI9/ZHXUecOS6/dsJ9SVAsCrJETVPuNgkcAjfJ
         JF3rqeIz89H+2AwUMk1KnTA0njWkbBuAoGJKoYbmf9o7M8mj5IQkMxQi3ozqvYAmEgrV
         envqsdoiyeIuNGdhxhVyeYRGgnCAG3BiyQ/X/4CyPgyygr+8+V1oCJJhHnc9t9DSkiJm
         kyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fkKVSzBJj8nHPQJgCix44EB7ngnH86Vt/nCJrDav/Ws=;
        b=e2EP4jNw5vVQqNCr3N1y4RktiOtn8h6Oxa4SFS57UJ3QM2Nn182Pvf1jTrDgao097g
         sbkvp49xu+c50x/8rH5dVeBE9DaS1lYcj0pszBPK7EbdUqv1cWU+TRuQW2vZW8cvaL4l
         36oJX0cZ0KyOPn/wJW+JfV/bf48AtfdWFq8lX+TktyeDYmtbvGBPXKuoTpY86VwCfQGm
         5GNJmkkMOp/K8eEunV874U7NTBqJFkH4gCiaZ67gsUI8prLoTRBFCgLBULoQipEiiavd
         4scmOApVS7kk4TVVODYZjShXr+UszZdODEoDe6WVJdGIkix5jy3OqhFYDz72SAP74YlL
         WUoA==
X-Gm-Message-State: APt69E3X5Ci/ObzPVEG95C5tOb8x1oRwCxxkeLMw3OLEvfkqmHWDRELL
        hcG/RFC3Y58S5w2ugThwZEalxw==
X-Google-Smtp-Source: AAOMgpeQRUYwhqMV607MyC/fl2+BL4ZT+j/UBsGHPIHnnW0eOlQx/A/PrFMV2mlWevG29ZSNGAphmQ==
X-Received: by 2002:a9d:5e6:: with SMTP id 93-v6mr12748752otd.145.1530408320831;
        Sat, 30 Jun 2018 18:25:20 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 9/9] merge: fix misleading pre-merge check documentation
Date:   Sat, 30 Jun 2018 18:25:03 -0700
Message-Id: <20180701012503.14382-10-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/merge.c contains this important requirement for merge strategies:

    ...the index must be in sync with the head commit.  The strategies are
    responsible to ensure this.

However, Documentation/git-merge.txt says:

    ...[merge will] abort if there are any changes registered in the index
    relative to the `HEAD` commit.  (One exception is when the changed
    index entries are in the state that would result from the merge
    already.)

Interestingly, prior to commit c0be8aa06b85 ("Documentation/git-merge.txt:
Partial rewrite of How Merge Works", 2008-07-19),
Documentation/git-merge.txt said much more:

    ...the index file must match the tree of `HEAD` commit...
    [NOTE]
    This is a bit of a lie.  In certain special cases [explained
    in detail]...
    Otherwise, merge will refuse to do any harm to your repository
    (that is...your working tree...and index are left intact).

So, this suggests that the exceptions existed because there were special
cases where it would case no harm, and potentially be slightly more
convenient for the user.  While the current text in git-merge.txt does
list a condition under which it would be safe to proceed despite the index
not matching HEAD, it does not match what is actually implemented, in
three different ways:

    * The exception is written to describe what unpack-trees allows.  Not
      all merge strategies allow such an exception, though, making this
      description misleading.  'ours' and 'octopus' merges have strictly
      enforced index==HEAD for a while, and the commit previous to this
      one made 'recursive' do so as well.

    * If someone did a three-way content merge on a specific file using
      versions from the relevant commits and staged it prior to running
      merge, then that path would technically satisfy the exception listed
      in git-merge.txt.  unpack-trees.c would still error out on the path,
      though, because it defers the three-way content merge logic to other
      parts of the code (resolve, octopus, or recursive) and has no way of
      checking whether the index entry from before the merge will match
      the end result of the merge.

    * The exception as implemented in unpack-trees actually only checked
      that the index matched the MERGE_HEAD version of the file and that
      HEAD matched the merge base.  Assuming no renames, that would indeed
      provide cases where the index matches the end result we'd get from a
      merge.  But renames means unpack-trees is checking that it instead
      matches something other than what the final result will be, risking
      either erroring out when we shouldn't need to, or not erroring out
      when we should and overwriting the user's staged changes.

In addition to the wording behind this exception being misleading, it is
also somewhat surprising to see how many times the code for the special
cases were wrong or the check to make sure the index matched head was
forgotten altogether:

* Prior to commit ee6566e8d70d ("[PATCH] Rewrite read-tree", 2005-09-05),
  there were many cases where an unclean index entry was allowed (look for
  merged_entry_allow_dirty()); it appears that in those cases, the merge
  would have simply overwritten staged changes with the result of the
  merge.  Thus, the merge result would have been correct, but the user's
  uncommitted changes could be thrown away without warning.

* Prior to commit 160252f81626 ("git-merge-ours: make sure our index
  matches HEAD", 2005-11-03), the 'ours' merge strategy did not check
  whether the index matched HEAD.  If it didn't, the resulting merge
  would include all the staged changes, and thus wasn't really an 'ours'
  strategy.

* Prior to commit 3ec62ad9ffba ("merge-octopus: abort if index does not
  match HEAD", 2016-04-09), 'octopus' merges did not check whether the
  index matched HEAD, also resulting in any staged changes from before
  the commit silently being folded into the resulting merge.  commit
  a6ee883b8eb5 ("t6044: new merge testcases for when index doesn't match
  HEAD", 2016-04-09) was also added at the same time to try to test to
  make sure all strategies did the necessary checking for the requirement
  that the index match HEAD.  Sadly, it didn't catch all the cases, as
  evidenced by the remainder of this list...

* Prior to commit 65170c07d466 ("merge-recursive: avoid incorporating
  uncommitted changes in a merge", 2017-12-21), merge-recursive simply
  relied on unpack_trees() to do the necessary check, but in one special
  case it avoided calling unpack_trees() entirely and accidentally ended
  up silently including any staged changes from before the merge in the
  resulting merge commit.

* The commit immediately before this one in this series noted that the
  exceptions were written in a way that assumed no renames, making it
  unsafe for merge-recursive to use.  merge-recursive was modified to
  use its own check to enforce that index==HEAD.

This history makes it very tempting to go into builtin/merge.c and replace
the comment that strategies must enforce that index matches HEAD with code
that just enforces it.  At this point, that would only affect the
'resolve' strategy; all other strategies have each been modified to
manually enforce it.  (However, note that index==HEAD is not strictly
enforced for fast-forward merges, as those are not considered a merge
strategy and they trigger in builtin/merge.c before the section in the
code where the relevant comment is found.)

But, even if we don't take the step of just fixing these problems by
enforcing index==HEAD for all strategies, we at least need to update this
misleading documentation in git-merge.txt.  For now, just modify the claim
in Documentation/git-merge.txt to fix the error.  The precise details
around combination of merges strategies and special cases probably is not
relevant to most users, so simply state that exceptions may exist but are
narrow and vary depending upon which merge strategy is in use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 6a5c00e2c..b050c8c2e 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -122,9 +122,9 @@ merge' may need to update.
 
 To avoid recording unrelated changes in the merge commit,
 'git pull' and 'git merge' will also abort if there are any changes
-registered in the index relative to the `HEAD` commit.  (One
-exception is when the changed index entries are in the state that
-would result from the merge already.)
+registered in the index relative to the `HEAD` commit.  (Special
+narrow exceptions to this rule may exist depending on which merge
+strategy is in use, but generally, the index must match HEAD.)
 
 If all named commits are already ancestors of `HEAD`, 'git merge'
 will exit early with the message "Already up to date."
-- 
2.18.0.137.g2a11d05a6.dirty

