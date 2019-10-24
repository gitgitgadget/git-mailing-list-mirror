Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E01D1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 12:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439656AbfJXMSN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 08:18:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39393 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfJXMSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 08:18:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id r141so2366898wme.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vZ/Ob04mefytWcttL+s4bBng7dguezuuWWNY+29p7dE=;
        b=hbMQThgwJDwpJMmhktXCTIHfhpYlVkrPdBYAxACbjLl5smjjYemsxQYmUs5KzG+A57
         yoaeftvW3MhzdzGXIEYFkUTZ8jaXj+ioFrOK73pS+Jtam1Fwihop+BmJy6ZwbXI/oGlq
         GLc7SwgsmZt73vO/Xz1WDcsLWCl+pKa+6Oz0JmdqAwfFppL39MQsnPu80Ue0junMltVC
         FD18oiLQ2+hzEMewoxiBfxTUVPogct8mI6mAIUsCPbgxVHVTR3vjtrjjv/CZhJ4yMXlX
         LDqPgFs9ZeyU7u3YuVjVD8hRx2JbqVZNkpMfpH0xn5yF5MmWEY0S6YI/Y3NHEV8XQDJe
         df1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vZ/Ob04mefytWcttL+s4bBng7dguezuuWWNY+29p7dE=;
        b=e0WL9YzyBFV6gii+k2HVx2PCXl/ANe5ubRiW96S/7pTR2aHwHK90QW6GzEjGCGfm0I
         WCcAivzJSEUyneYg3STaNiJ1Dky+OnbyczVqboAheA9G8yEnKcXatI2JMcvbh6tvZDrs
         RO34o05ExBg/VrYQTgnlAEZer2pgW/sUO29gh3BLnFpJjyp7JQVGR2zZ2Bpb8j+nmafF
         fAUOu1FBDusd5OcHNbH+5qUqMnzsQZvNgF4m1IPXxyDT0f+1HkhgEgWJicEEvQM+QU84
         7r9YrnWf3FeL8MP+3y8EzFc/ImLmwyTPyN8PewOXP3c9rStMPoaDS3Xewri2XNmOMpg+
         XqmQ==
X-Gm-Message-State: APjAAAVgfvGgcAt5P3ZSldpdplN2LKl6npx+7qLpg55qxg9Xl3MeZ+Ky
        tWrjn1vAz44P91nib6isj2QwhVeK
X-Google-Smtp-Source: APXvYqzl9DkIUYkqpN0L/lM2Djed/tOUSfy8qVSGYCimxyPqO9Ow7Li61BFvD1kxt4f508pUFKhbFA==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr4727327wmd.103.1571919489893;
        Thu, 24 Oct 2019 05:18:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm2143387wmb.8.2019.10.24.05.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 05:18:09 -0700 (PDT)
Message-Id: <pull.415.v3.git.1571919488.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
References: <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Oct 2019 12:18:06 +0000
Subject: [PATCH v3 0/2] [v2.24.0-rc0 BUG] fetch.writeCommitGraph fails on first fetch
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, peff@peff.net, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UPDATE for V2: We now know the full repro, and a test is added. Thanks
Szeder and Peff for your insights!

UPDATE in V3: Cleaned up the commit messages and some test details.

While dogfooding, Johannes found a bug in the fetch.writeCommitGraph config
behavior. While his example initially happened during a clone with
--recurse-submodules, (UPDATE) and the submodule is important, but
--recurse-submodules is not:

$ git clone <url> test
$ cd test
$ git -c fetch.writeCommitGraph=true fetch origin
Computing commit graph generation numbers: 100% (12/12), done.
BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
Aborted (core dumped)

In the repo I had cloned, there were really 60 commits to scan, but only 12
were in the list to write when calling compute_generation_numbers(). A
commit in the list expects to see a parent, but that parent is not in the
list. The simple example I used for my testing was 
https://github.com/derrickstolee/numbers. Thie repo HAS A SUBMODULE, I just
forgot. Sorry for derailing the investigation somewhat.

The details above are the start of the commit message for [PATCH 1/2],
including a test that fails when fetching after cloning a repo with a
submodule.

In [PATCH 2/2], I actually have the fix. I tried to include as much detail
as I could for how I investigated the problem and why I think this is the
right solution. I added details that have come from the on-list discussion,
including what the submodule code is doing and why REACHABLE is no longer
used in commit-reach.c.

Thanks, -Stolee

Derrick Stolee (2):
  t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
  commit-graph: fix writing first commit-graph during fetch

 commit-graph.c   | 11 +++++++----
 commit-reach.c   |  1 -
 object.h         |  3 ++-
 t/t5510-fetch.sh | 16 ++++++++++++++++
 4 files changed, 25 insertions(+), 6 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-415%2Fderrickstolee%2Ffetch-first-write-fail-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-415/derrickstolee/fetch-first-write-fail-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/415

Range-diff vs v2:

 1:  6ac0a05746 ! 1:  ce53b5a7bf t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
     @@ -22,10 +22,6 @@
          A follow-up will fix the bug, but first we create a test that
          demonstrates the problem.
      
     -    I used "test_expect_failure" for the entire test instead of
     -    "test_must_fail" only on the command that I expect to fail. This is
     -    because the BUG() returns an exit code so test_must_fail complains.
     -
          Helped-by: Jeff King <peff@peff.net>
          Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Helped-by: Szeder Gábor <szeder.dev@gmail.com>
     @@ -39,16 +35,15 @@
       '
       
      +test_expect_failure 'fetch.writeCommitGraph with submodules' '
     -+	pwd="$(pwd)" &&
      +	git clone dups super &&
      +	(
      +		cd super &&
     -+		git submodule add "file://$pwd/three" &&
     ++		git submodule add "file://$TRASH_DIRECTORY/three" &&
      +		git commit -m "add submodule"
      +	) &&
     -+	git clone "super" writeError &&
     ++	git clone "super" super-clone &&
      +	(
     -+		cd writeError &&
     ++		cd super-clone &&
      +		test_path_is_missing .git/objects/info/commit-graphs/commit-graph-chain &&
      +		git -c fetch.writeCommitGraph=true fetch origin &&
      +		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
 2:  ca59b118f1 ! 2:  edacfff490 commit-graph: fix writing first commit-graph during fetch
     @@ -6,7 +6,7 @@
          fetch.writeCommitGraph and fetching in a repo with a submodule. Here, we
          fix that bug and set the test to "test_expect_success".
      
     -    The prolem arises with this set of commands when the remote repo at
     +    The problem arises with this set of commands when the remote repo at
          <url> has a submodule. Note that --recurse-submodules is not needed to
          demonstrate the bug.
      
     @@ -44,16 +44,6 @@
          negotiation is comparing the remote refs with the local refs and marking
          some commits as UNINTERESTING.
      
     -    You may ask: did this feature ever work at all? Yes, it did, as long as
     -    you had a commit-graph covering all of your local refs. My testing was
     -    unfortunately limited to this scenario. The UNINTERESTING commits are
     -    always part of the "old" commit-graph, and when we add new commits to a
     -    top layer of the commit-graph chain those are not needed. If we happen
     -    to merge layers of the chain, then the commits are added as a list, not
     -    using a commit walk. Further, the test added for this config option in
     -    t5510-fetch.sh uses local filesystem clones, which somehow avoids this
     -    logic.
     -
          I tested running clear_commit_marks_many() to clear the UNINTERESTING
          flag inside close_reachable(), but the tips did not have the flag, so
          that did nothing.
     @@ -62,7 +52,7 @@
          fault. Thanks, Peff, for pointing out this detail! More specifically,
          for each submodule, the collect_changed_submodules() runs a revision
          walk to essentially do file-history on the list of submodules. That
     -    revision walk marks commits UNININTERESTING if they are simiplified away
     +    revision walk marks commits UNININTERESTING if they are simplified away
          by not changing the submodule.
      
          Instead, I finally arrived on the conclusion that I should use a flag
     @@ -163,6 +153,6 @@
       
      -test_expect_failure 'fetch.writeCommitGraph with submodules' '
      +test_expect_success 'fetch.writeCommitGraph with submodules' '
     - 	pwd="$(pwd)" &&
       	git clone dups super &&
       	(
     + 		cd super &&

-- 
gitgitgadget
