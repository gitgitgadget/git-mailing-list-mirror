Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3691F45F
	for <e@80x24.org>; Wed,  8 May 2019 17:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfEHRUf (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 13:20:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36159 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfEHRUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 13:20:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so28247111wra.3
        for <git@vger.kernel.org>; Wed, 08 May 2019 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oPvRPTu08BlgjUqnvbMsjcOHWCZZo07CtmKHsBqAPpM=;
        b=gFkwB+S9DFAGPG/eJyJu1OEbi8//BTkmD4qBRHPKm4A9NQJfXjjqqxDmrBbNkNSydP
         sayWo1pvDE6kEa4V03DQpleKafKCMcq32sDSPa2Br9gpf7ReIa9X8DTT0/RVdobVmYw0
         SYAB0wfdLxy0gUxi1sxAVbV+TLUGSeLivCEt6lhvnAnRq18NOhHxuz2Xtlbj0HZz4UrC
         bSoeZx7qY+HUM6BphIF+tibQH8csqhFPLgt3BaQ0fKYK3z/Reff2F/r+ShW7YkTHGynQ
         aYL9IaMCm/JKf9TQcwUw/SFSBl4ukABNCJxfG2nLnf7lvLWNX5YcZwAJKjnPYVhyUI8u
         Z7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPvRPTu08BlgjUqnvbMsjcOHWCZZo07CtmKHsBqAPpM=;
        b=iikBzofoyUnTJXaUP4Im5ilQTQV9LW+/BAPqFDt8z1KqeyqL1HJskU+QSbjfy16cSa
         iOED5DaQPKwz6Zr4+N3ciV3d6KQ9A2anznbLZoxXIsRpb6Nd0pwUI7qWJZGF9bZ4xu3f
         LCJgNulnFrTct5W3+yl4fQDB1VdxIrKQ07g2hBIdYXBTLM1q0mU5LW7xOqXvxDXzldnB
         BHuPbO5AsoH6h60Yp3FmUSPDTtr2fvu5yDnDLf3VAxtuHYPmaqyetYMvst2AECOoSJHV
         Oh7Ykzw9Ve/OFlY5vmVM1MxB49+bdeAL829qP9w41vk8E3sHNEQSvaUZM3GXrW45RDve
         RqOQ==
X-Gm-Message-State: APjAAAU+9d1rZN0G68FK2yDV2RDBJ85WpDvGXKi62x5rCOdv/fhUcWxh
        KicxgtL4kU7a2nTyN0swR+nORWzi
X-Google-Smtp-Source: APXvYqzXB5CdsX1a1Do6+iLfPCINAR4oHLV/FsjXtyIX9V/wCAVJNwuOFGISATiPMTvUaJKUw8dSGg==
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr29925911wrs.140.1557336033036;
        Wed, 08 May 2019 10:20:33 -0700 (PDT)
Received: from szeder.dev (x4dbe2f41.dyn.telefonica.de. [77.190.47.65])
        by smtp.gmail.com with ESMTPSA id s22sm4440746wmh.45.2019.05.08.10.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:20:32 -0700 (PDT)
Date:   Wed, 8 May 2019 19:20:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
Message-ID: <20190508172029.GP14763@szeder.dev>
References: <pull.184.git.gitgitgadget@gmail.com>
 <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 08:53:57AM -0700, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The design for the split commit-graphs uses file names to force
> a "stack" of commit-graph files. This allows incremental writes
> without updating the file format.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 142 +++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index fb53341d5e..ca1661d2d8 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -127,6 +127,148 @@ Design Details
>    helpful for these clones, anyway. The commit-graph will not be read or
>    written when shallow commits are present.
>  
> +Split Commit Graphs
> +-------------------
> +
> +Typically, repos grow with near-constant velocity (commits per day). Over
> +time, the number of commits added by a fetch operation is much smaller than
> +the number of commits in the full history. The split commit-graph feature
> +allows for fast writes of new commit data without rewriting the entire
> +commit history -- at least, most of the time.
> +
> +## File Layout
> +
> +A split commit-graph uses multiple files, and we use a fixed naming
> +convention to organize these files. The base commit-graph file is the
> +same: `$OBJDIR/info/commit-graph`. The rest of the commit-graph files have
> +the format `$OBJDIR/info/commit-graphs/commit-graph-<N>` where N is a
> +positive integer. The integers must start at 1 and grow sequentially
> +to form a stack of files.
> +
> +Each `commit-graph-<N>` file has the same format as the `commit-graph`
> +file, including a lexicographic list of commit ids. The only difference
> +is that this list is considered to be concatenated to the list from
> +the lower commit-graphs. As an example, consider this diagram of three
> +files:
> +
> + +-----------------------+
> + |  commit-graph-2       |
> + +-----------------------+
> +	  |
> + +-----------------------+
> + |                       |
> + |  commit-graph-1       |
> + |                       |
> + +-----------------------+
> +	  |
> + +-----------------------+
> + |                       |
> + |                       |
> + |                       |
> + |  commit-graph         |
> + |                       |
> + |                       |
> + |                       |
> + +-----------------------+
> +
> +Let X0 be the number of commits in `commit-graph`, X1 be the number
> +of commits in commit-graph-1, and X2 be the number of commits in
> +commit-graph-2. If a commit appears in position i in `commit-graph-2`,
> +then we interpret this as being the commit in position (X0 + X1 + i),
> +and that will be used as its "graph position". The commits in
> +commit-graph-2 use these positions to refer to their parents, which
> +may be in commit-graph-1 or commit-graph. We can navigate to an
> +arbitrary commit in position j by checking its containment in the
> +intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 + X2).
> +
> +When Git reads from these files, it starts by acquiring a read handle
> +on the `commit-graph` file. On success, it continues acquiring read
> +handles on the `commit-graph-<N>` files in increasing order. This
> +order is important for how we replace the files.
> +
> +## Merging commit-graph files
> +
> +If we only added a `commit-graph-<N>` file on every write, we would
> +run into a linear search problem through many commit-graph files.
> +Instead, we use a merge strategy to decide when the stack should
> +collapse some number of levels.
> +
> +The diagram below shows such a collapse. As a set of new commits
> +are added, it is determined by the merge strategy that the files
> +should collapse to `commit-graph-1`. Thus, the new commits, the
> +commits in `commit-graph-2` and the commits in `commit-graph-1`
> +should be combined into a new `commit-graph-1` file.
> +
> +			    +---------------------+
> +			    |                     |
> +			    |    (new commits)    |
> +			    |                     |
> +			    +---------------------+
> +			    |                     |
> + +-----------------------+  +---------------------+
> + |  commit-graph-2       |->|                     |
> + +-----------------------+  +---------------------+
> +	  |                 |                     |
> + +-----------------------+  +---------------------+
> + |                       |  |                     |
> + |  commit-graph-1       |->|                     |
> + |                       |  |                     |
> + +-----------------------+  +---------------------+
> +	  |                   commit-graph-1.lock
> + +-----------------------+
> + |                       |
> + |                       |
> + |                       |
> + |  commit-graph         |
> + |                       |
> + |                       |
> + |                       |
> + +-----------------------+
> +
> +During this process, the commits to write are combined, sorted
> +and we write the contents to the `commit-graph-1.lock` file.
> +When the file is flushed and ready to swap to `commit-graph-1`,
> +we first unlink the files above our target file. This unlinking
> +is done from the top of the stack, the reverse direction that
> +another process would use to read the stack.
> +
> +During this time window, another process trying to read the
> +commit-graph stack could read `commit-graph-1` before the swap
> +but try to read `commit-graph-2` after it is unlinked. That
> +process would then believe that this stack is complete, but
> +will miss out on the performance benefits of the commits in
> +`commit-graph-2`. For this reason, the stack above the
> +`commit-graph` file should be small.

Consider the following sequence of events:

  1. There are three commit-graph files in the repository.

  2. A git process opens the base commit-graph and commit-graph-1 for
     reading.  It doesn't yet open commit-graph-2, because the (for
     arguments sake not very fair) scheduler takes the CPU away.

  3. Meanwhile, a 'git fetch', well, fetches from a remote, and
     upon noticing that it got a lot of commits it decides to collapse
     commit-graph-1 and -2 and the new commits, writing a brand new
     commit-graph-1.

  4. A second fetch fetches from a second remote, and writes
     commit-graph-2 (no collapsing this time).

  5. Now the crappy scheduler finally decides that it's time to wake
     up the waiting git process from step 2, which then finds the new
     commit-graph-2 file and opens it for reading.

  6. At this point this poor git process has file handles for:
  
     - the base commit-graph file, which is unchanged.

     - the old commit-graph-1 which has since been replaced, and does
       not yet contain info about the old commit-graph-2 or the
       commits received in the first fetch.

     - the new commit-graph-2, containing info only about commits
       received in the second fetch, and whose parents' graph
       positions point either to the base commitg-graph (good, since
       unchanged) or to the new commit-graph-1 (uh-oh).

What happens next?  If this process tries to access the parent of a
commit from commit-graph-2, and the metadata about this parent is in
the new commit-graph-1, then I expect all kinds of weird bugs.

But will a git process ever try to access a commit that didn't yet
existed in the repository when it started opening the commit-graph
files?



> +## Merge Strategy
> +
> +When writing a set of commits that do not exist in the
> +commit-graph stack of height N, we default to creating
> +a new file at level N + 1. We then decide to merge
> +with the Nth level if one of two conditions hold:
> +
> +  1. The expected file size for level N + 1 is at
> +     least half the file size for level N.
> +
> +  2. Level N + 1 contains more than MAX_SPLIT_COMMITS
> +     commits (64,0000 commits).
> +
> +This decision cascades down the levels: when we
> +merge a level we create a new set of commits that
> +then compares to the next level.
> +
> +The first condition bounds the number of levels
> +to be logarithmic in the total number of commits.
> +The second condition bounds the total number of
> +commits in a `commit-graph-N` file and not in
> +the `commit-graph` file, preventing significant
> +performance issues when the stack merges and another
> +process only partially reads the previous stack.
> +
> +The merge strategy values (2 for the size multiple,
> +64,000 for the maximum number of commits) could be
> +extracted into config settings for full flexibility.
> +
>  Related Links
>  -------------
>  [0] https://bugs.chromium.org/p/git/issues/detail?id=8
> -- 
> gitgitgadget
> 
