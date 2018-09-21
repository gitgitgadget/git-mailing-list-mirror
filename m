Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890051F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390584AbeIUVFQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:05:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41946 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390339AbeIUVFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:05:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so6120714pfk.8
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ec27dRiL5CB+UcFgrNKhAvYdQwK80XxV7G7cwVQyl8=;
        b=MzTEVrZyBgtPn98XH+LDcZ1ad3ALwsHEfW/5OonB8Kur7mM7QKFpFyRRTZTGjHzBcV
         44XnPoImskA6sGkoniGdtD63rrujjpD19gB8HtG5rMnHeI3T4CzQNAjQrp2yIFX0wMqF
         9pxujPr5CFAFhN6F1HzeXby8SMCYj7s+bkFqvB2pdGKrYTDp74vT3PeanEvY43d8WkAF
         Buva23EwblzRQZit7SC5aEex9248yIdcdDn7vbsoxPDasVxfaIvvfMOJrrnSyyoIPxoK
         0W2HY4KvwHAxC5WiOQvK22yN09r4BaCfM3FEaMVfEReSixwPIbsJsz8dW0va3O27SK+N
         GfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ec27dRiL5CB+UcFgrNKhAvYdQwK80XxV7G7cwVQyl8=;
        b=g1EL5CQksT3SEnvlKpiHSqB7bePxelQVtuvOe0SMjEGX9hS7qRTnDA1naLTUjNNzPL
         7lkhJa+w1Cco1NqIn0DAy+X/PXOyJ4KDGyQaaQdctIG2rf6VR+7DCNA/JDeOWKshxO4T
         bs1shSAj4WKcyPiEwWcmGTadgAbx4x26HGzsaxFecC2UIyL7wUBsb78J9ypnD3UwEooz
         WaOzHBJHJLQI/i3nywM4tp5yYt1armjnXwJDEYRQPzHpuM6DzV8yvemNzBMfYm2VjuZG
         Ip+9MqKhr8nq5bTbrzTJcw9Y4l9vMlJiu87zOYWF+otQ4APkMuuFQEki7I3vpwP+By1i
         MPcg==
X-Gm-Message-State: APzg51DfjDWonKI+tfTIE12qOP4hR9xwRo6dmvXLua83f1fBxDj4Ciie
        MUZHUUC9Huj9IX+bwsYhYki4NLLi
X-Google-Smtp-Source: ANB0VdaYqM7TrMF2AWG/aeNuYLi7FB+LL5NxcKf+J4wJxciYzQEvy2I0rLPdBxCXEZlx+ijassYSeA==
X-Received: by 2002:a63:6445:: with SMTP id y66-v6mr11534674pgb.443.1537542954826;
        Fri, 21 Sep 2018 08:15:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f87-v6sm64750733pfh.168.2018.09.21.08.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:15:54 -0700 (PDT)
Date:   Fri, 21 Sep 2018 08:15:54 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 15:15:50 GMT
Message-Id: <pull.40.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.40.v2.git.gitgitgadget@gmail.com>
References: <pull.40.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] contrib: Add script to show uncovered "new" lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have coverage targets in our Makefile for using gcov to display line
coverage based on our test suite. The way I like to do it is to run:

make coverage-test
make coverage-report

This leaves the repo in a state where every X.c file that was covered has an
X.c.gcov file containing the coverage counts for every line, and "#####" at
every uncovered line.

There have been a few bugs in recent patches what would have been caught if
the test suite covered those blocks (including a few of mine). I want to
work towards a "sensible" amount of coverage on new topics. In my opinion,
this means that any logic should be covered, but the 'die()' blocks in error
cases do not need to be covered.

It is important to not measure the coverage of the codebase by what old code
is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
After creating the coverage statistics at a version (say, 'topic') you can
then run

contrib/coverage-diff.sh base topic

to see the lines added between 'base' and 'topic' that are not covered by
the test suite. For example, I ran this against the 'next' branch (22e244b)
versus 'master' (150f307) and got the following output:

fsck.c
fb8952077df     (René Scharfe   2018-09-03 14:49:26 +0000       212)            die_errno("Could not read '%s'", path);
list-objects-filter-options.c
f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       56)                     if (errbuf) {
f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       57)                             strbuf_init(errbuf, 0);
f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       58)                             strbuf_addstr(
f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       62)                     return 1;
list-objects-filter.c
77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       47)             BUG("unknown filter_situation: %d", filter_situation);
f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       100)    default:
f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       101)            BUG("unknown filter_situation: %d", filter_situation);
77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       152)            BUG("unknown filter_situation: %d", filter_situation);
77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       257)            BUG("unknown filter_situation: %d", filter_situation);
77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       438)            BUG("invalid list-objects filter choice: %d",
list-objects.c
f447a499dbb     (Matthew DeVore 2018-08-13 11:14:28 -0700       197)                    ctx->show_object(obj, base->buf, ctx->show_data);
ll-merge.c
d64324cb60e     (Torsten Bögershausen   2018-09-12 21:32:02 +0200       379)                    marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
midx.c
56ee7ff1565     (Derrick Stolee 2018-09-13 11:02:13 -0700       949)            return 0;
cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700       990)                    midx_report(_("failed to load pack-index for packfile %s"),
cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700       991)                                e.p->pack_name);
cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700       992)                    break;
remote-curl.c
c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700       181)            options.filter = xstrdup(value);
submodule.c
df255b8cac7     (Brandon Williams       2018-08-08 15:33:22 -0700       1738)           die(_("could not create directory '%s'"), new_gitdir.buf);

Using this 'git blame' output, we can quickly inspect whether the uncovered
lines are appropriate. For instance:

 1. The line in builtin/commit.c is due to writing the commit-graph file
    when GIT_TEST_COMMIT_GRAPH is enabled, which is not on by default in the
    test suite. Being uncovered is expected here.
    
    
 2. The lines in builtin/worktree.c are all related to error conditions.
    This is acceptable.
    
    
 3. The line in builtin/rev-list.c is a flag replacement in a block that is
    otherwise unchanged. It must not be covered by the test suite normally.
    This could be worth adding a test to ensure the new logic maintains old
    behavior.
    
    
 4. The lines in read-cache.c are part of a new block for the condition "if
    (expand_name_field)" as part of an optimization. These lines should
    probably be covered before that series is merged to 'next'. I understand
    that Ben and Duy are continuing work in this direction [1].
    
    

I used this approach for 'next' over 'master' and got a larger list, some of
which I have already submitted tests to increase coverage [2] or will be
covered by topics not in 'next' [3].

Thanks, -Stolee

CHANGES IN V3: I took Junio's perl script verbatim, which speeds up the
performance greatly. Some of the other sed commands needed some massaging,
but also added extra cleanup. Thanks for the help!

[1] 
https://public-inbox.org/git/20180912161832.55324-1-benpeart@microsoft.com/T/#u

[2] https://public-inbox.org/git/pull.37.git.gitgitgadget@gmail.com/

[3] https://public-inbox.org/git/pull.34.git.gitgitgadget@gmail.com/

Derrick Stolee (1):
  contrib: add coverage-diff script

 contrib/coverage-diff.sh | 79 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 contrib/coverage-diff.sh


base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-40%2Fderrickstolee%2Fcoverage-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-40/derrickstolee/coverage-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/40

Range-diff vs v2:

 1:  7714b0659e < -:  ---------- contrib: add coverage-diff script
 -:  ---------- > 1:  21214cc321 contrib: add coverage-diff script

-- 
gitgitgadget
