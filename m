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
	by dcvr.yhbt.net (Postfix) with ESMTP id 038971F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 13:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393667AbfJXNkr (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 09:40:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393662AbfJXNkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 09:40:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so14866125wrq.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lMjWEi+IglNY0vPTcqSw3ENWzBznpieRCdEGm5NeuMc=;
        b=b2DGQoPpMcvvEu7WX3sh81Qaol7oSH/Gq87I65xyASVw44cei2ClnwmTuqCjKS8OW0
         1lr/Jk8cdUgJNy5HbetyOOpW95gVBy83MHfr6UAXTHuaiZaC/F3onRAJR9mzcPYVvXfG
         fER3E5xvQ+6Vin6wa2bVaUEbn4ZXVwfoH03NKum1pRSzHWml4499etyYF25uA6zn1gbR
         8FUrNMRyHNMM/s8Xx8uGFAmedIS9b2u8yUZdb4myzi+y6PJzWAmD6gSuR1R4qh52hDda
         69PdDvGZdYMNe6qJa3Wy1E2b+9aY2JXAz8R8kZNezeHsKfKOg+d3ncuBzWF0ZCrbtFs/
         S1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lMjWEi+IglNY0vPTcqSw3ENWzBznpieRCdEGm5NeuMc=;
        b=jEH1nGLVs7qUY3fDZJZqu5LNr5ypHVkLTOzJAb6FxifyeLkeWlIpXtvTbLY8hcpZB8
         Besl47obzfID/Ju+qDbFgCwlSL3VqWrJXGFCLle6WiMev+KTMQzVOWVL2GdZwpcZ5MCg
         6nQXia49wc/H1UaBSSdypU39hAIKUIfCjue9g5dasCZcBMylJ0W/NHgWNy/D5jbgZGNO
         nNNJ6MtSSESSqfjYhMtZzHl0gNNRmBjQSMIdbaPszv58yXDSAnIP3CODkiR2aTGr+0d0
         UnUwx8DBud6WRuVLpXW/rLwiQf7aVTxfeycr6cD3tVrpl4fD6oHEsZkkU43bQtI+7xoe
         A02A==
X-Gm-Message-State: APjAAAV5MAga71XDXBvYCmOjayYBEUoscUuZyhhBYhzJYqNJI3IKblDV
        DASWaiAOWM2Beb8ni3hhdzWdX5+h
X-Google-Smtp-Source: APXvYqw4fq/aKdGubxaTHfQvisGwnHJPzAi7f5LawNLnFnYCYzs1lRPNVPIZN2Rf/AqFDQ+Y8JMm6Q==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr4196498wrw.79.1571924444138;
        Thu, 24 Oct 2019 06:40:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm27564307wrx.2.2019.10.24.06.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:40:43 -0700 (PDT)
Message-Id: <pull.415.v4.git.1571924442.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.v3.git.1571919488.gitgitgadget@gmail.com>
References: <pull.415.v3.git.1571919488.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Oct 2019 13:40:40 +0000
Subject: [PATCH v4 0/2] [v2.24.0-rc0 BUG] fetch.writeCommitGraph fails on first fetch
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

UPDATE in V4: There is an unfortunate interaction with GIT_TEST_COMMIT_GRAPH
that requires an update to the test. Sorry for not noticing this earlier.
Thanks, Johannes for pointing it out!

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-415%2Fderrickstolee%2Ffetch-first-write-fail-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-415/derrickstolee/fetch-first-write-fail-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/415

Range-diff vs v3:

 1:  ce53b5a7bf ! 1:  8150108471 t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
     @@ -20,7 +20,10 @@
          parent, but that parent is not in the list.
      
          A follow-up will fix the bug, but first we create a test that
     -    demonstrates the problem.
     +    demonstrates the problem. This test must be careful about an existing
     +    commit-graph file, since GIT_TEST_COMMIT_GRAPH=1 will cause the repo we
     +    are cloning to already have one. This then prevents the incremtnal
     +    commit-graph write during the first 'git fetch'.
      
          Helped-by: Jeff King <peff@peff.net>
          Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ -44,7 +47,7 @@
      +	git clone "super" super-clone &&
      +	(
      +		cd super-clone &&
     -+		test_path_is_missing .git/objects/info/commit-graphs/commit-graph-chain &&
     ++		rm -rf .git/objects/info &&
      +		git -c fetch.writeCommitGraph=true fetch origin &&
      +		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
      +	)
 2:  edacfff490 = 2:  6d01e90591 commit-graph: fix writing first commit-graph during fetch

-- 
gitgitgadget
