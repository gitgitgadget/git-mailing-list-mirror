Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7591D1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbfAPNaH (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33595 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732867AbfAPNaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so6981812wrr.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2XW2KhjVmeM1FSDSQ4XS5G65DvBjZfawsVEV789Zao=;
        b=m7sHTyKeLtLiXOce7Xist7PabxCwd/fj5DLdmrW4CJTxvX+ZRxl3e0mdRdljoH5eLj
         sH/G+6c/0HA637YFPgqOFf8Z0gmcNwbwujjsvbJfNPWwjgCQZzoHjdP/TBAAyKoPYNAI
         YgzXJBRBUZj+F7HCEIXI0fUlTIx1AjU4YaabpjFPP8pL8rK/HJ34KI+5jzjB1L5pkE4N
         mcGoWDbh0uGssLtEECu7aQGWHn/2T5ue07rU5RtZvaQhDwhQaUeiuLmaFMYH9sUjTm1q
         NKQ9jpH0of8rc9vRMGcSNbTUXp2xsPs/bFV4dvhRfIKGTKIWIFoJ4/o2tLMR6Rkebv2j
         0p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2XW2KhjVmeM1FSDSQ4XS5G65DvBjZfawsVEV789Zao=;
        b=h2HlNqUAgshoPvNW+ER99bJjnI55pz3Y7C+EXmlNB1ITzJ349KhLyZU8Vrspoicqon
         VWxdigVAyPU7VltbagFn+xdEyv3M8Wkc6ldKY0OkZnBm+1P9f/1oPgQrCbmD7neR7+lP
         Cl+ZglfJAYoOhfaO9KetBuvvoNeIpaVjlOkwwZqWyytjThXEIhpJFcQ1n/mVWNjPUFYL
         j5UchteE2dXeWneX1EUALuTZXUUfjfreqKgysfVutF0hTjxKSq34iXLCwA8tHFZzM2Q9
         pCzt+GbWy1F+gwVvoA6HAGLLAX6CoPWTt7Hu89KzJSvPXIP6DBO3MAImAJqwPgZS74P+
         aaMQ==
X-Gm-Message-State: AJcUukdO6SIB859BZHmj1RAKB++Vc6yRsG3O2bHJ/D9vdl/R1SOFYFtj
        8Ej9tfBf/hxuijAegK9f7GSLCde9
X-Google-Smtp-Source: ALg8bN7ePoYB1qzL/dtzSjYA2IqSJ4LUgyUxVziH4vvAhk1i5d1Jjy7xtOd0oT7FK7RttZjY99v3mg==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr7509517wrp.111.1547645403630;
        Wed, 16 Jan 2019 05:30:03 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/9] commit-graph write: progress output improvements
Date:   Wed, 16 Jan 2019 14:29:38 +0100
Message-Id: <20190116132947.26025-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181122153922.16912-2-avarab@gmail.com>
References: <20181122153922.16912-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was reviewed & discussed shortly before 2.20 went out the door,
but the changes deemed too significant during the RC period, and
instead we had my much smaller 01ca387774 ("commit-graph: split up
close_reachable() progress output", 2018-11-19) as a fix.

That's now landed in master, and this version is rebased on top of
that.

The changes aren't significant, one patch was dropped because
01ca387774 did another version of it already, and 09/09 is rewritten
v.s. what 10/10 was before due to being on top of 01ca387774.

SZEDER Gábor (2):
  commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
  commit-graph: don't call write_graph_chunk_large_edges() unnecessarily

Ævar Arnfjörð Bjarmason (7):
  commit-graph write: add "Writing out" progress output
  commit-graph write: more descriptive "writing out" output
  commit-graph write: show progress for object search
  commit-graph write: add more descriptive progress output
  commit-graph write: remove empty line for readability
  commit-graph write: add itermediate progress
  commit-graph write: emit a percentage for all progress

 commit-graph.c | 134 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 34 deletions(-)

Range-diff:
 1:  07d06c50c0 =  1:  8d56b1c5c1 commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
 2:  904dda1e7a =  2:  8e33e12c7d commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
 3:  1126c7e29d <  -:  ---------- commit-graph write: rephrase confusing progress output
 4:  9c17f56ed3 !  3:  fa48b4b4cd commit-graph write: add "Writing out" progress output
    @@ -10,14 +10,14 @@
         small repositories, but before this change we'd noticeably hang for
         2-3 seconds at the end on medium sized repositories such as linux.git.
     
    -    Now we'll instead show output like this, and have no human-observable
    -    point at which we're not producing progress output:
    +    Now we'll instead show output like this, and reduce the
    +    human-observable times at which we're not producing progress output:
     
    -        $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 6365442, done.
    -        Annotating commit graph: 2391666, done.
    -        Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph: 100% (3188888/3188888), done.
    +        $ ~/g/git/git --exec-path=$HOME/g/git -C ~/g/2015-04-03-1M-git commit-graph write
    +        Finding commits for commit graph: 13064614, done.
    +        Expanding reachable commits in commit graph: 1000447, done.
    +        Computing commit graph generation numbers: 100% (1000447/1000447), done.
    +        Writing out commit graph: 100% (3001341/3001341), done.
     
         This "Writing out" number is 3x or 4x the number of commits, depending
         on the graph we're processing. A later change will make this explicit
 5:  79b0a467d9 !  4:  738074e802 commit-graph write: more descriptive "writing out" output
    @@ -11,11 +11,11 @@
         has to do with writing out the commit graph. Now e.g. on linux.git we
         emit:
     
    -        $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 6365442, done.
    -        Annotating commit graph: 2391666, done.
    -        Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph in 4 passes: 100% (3188888/3188888), done.
    +        $ ~/g/git/git --exec-path=$HOME/g/git -C ~/g/linux commit-graph write
    +        Finding commits for commit graph: 6529159, done.
    +        Expanding reachable commits in commit graph: 815990, done.
    +        Computing commit graph generation numbers: 100% (815983/815983), done.
    +        Writing out commit graph in 4 passes: 100% (3263932/3263932), done.
     
         A note on i18n: Why are we using the Q_() function and passing a
         number & English text for a singular which'll never be used? Because
    @@ -51,11 +51,10 @@
      	}
      	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
     @@
    + 	if (num_large_edges)
      		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
      	stop_progress(&progress);
    - 
     +	strbuf_release(&progress_title);
    -+
    + 
      	close_commit_graph(the_repository);
      	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
    - 	commit_lock_file(&lk);
 6:  b32be83b38 !  5:  b8b6f3ca84 commit-graph write: show progress for object search
    @@ -8,12 +8,12 @@
     
         Before we'd emit on e.g. linux.git with "commit-graph write":
     
    -        Finding commits for commit graph: 6365442, done.
    +        Finding commits for commit graph: 6529159, done.
             [...]
     
         And now:
     
    -        Finding commits for commit graph: 100% (6365442/6365442), done.
    +        Finding commits for commit graph: 100% (6529159/6529159), done.
             [...]
     
         Since the commit graph only includes those commits that are packed
 7:  54276723c0 !  6:  1fab1b3c8f commit-graph write: add more descriptive progress output
    @@ -10,17 +10,17 @@
         we support:
     
             $ git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    +        Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
             [...]
     
             # Actually we don't emit this since this takes almost no time at
             # all. But if we did (s/_delayed//) we'd show:
             $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    -        Finding commits for commit graph from 584 refs: 100% (584/584), done.
    +        Finding commits for commit graph from 630 refs: 100% (630/630), done.
             [...]
     
             $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    -        Finding commits for commit graph in 2 packs: 6365442, done.
    +        Finding commits for commit graph in 3 packs: 6529159, done.
             [...]
     
         The middle on of those is going to be the output users might see in
 8:  0e847366e1 =  7:  e952c4b728 commit-graph write: remove empty line for readability
 9:  c388aff73e !  8:  99ac6725cb commit-graph write: add itermediate progress
    @@ -10,26 +10,29 @@
         million objects we'll now emit:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (48333911/48333911), done.
    -        Annotating commit graph: 21435984, done.
    -        Counting distinct commits in commit graph: 100% (7145328/7145328), done.
    -        Finding extra edges in commit graph: 100% (7145328/7145328), done.
    -        Computing commit graph generation numbers: 100% (7145328/7145328), done.
    -        Writing out commit graph in 4 passes: 100% (28581312/28581312), done.
    +        Finding commits for commit graph among packed objects: 100% (124763727/124763727), done.
    +        Loading known commits in commit graph: 100% (18989461/18989461), done.
    +        Expanding reachable commits in commit graph: 100% (18989507/18989461), done.
    +        Clearing commit marks in commit graph: 100% (18989507/18989507), done.
    +        Counting distinct commits in commit graph: 100% (18989507/18989507), done.
    +        Finding extra edges in commit graph: 100% (18989507/18989507), done.
    +        Computing commit graph generation numbers: 100% (7250302/7250302), done.
    +        Writing out commit graph in 4 passes: 100% (29001208/29001208), done.
     
         Whereas on a medium-sized repository such as linux.git these new
         progress bars won't have time to kick in and as before and we'll still
         emit output like:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    -        Annotating commit graph: 2391666, done.
    -        Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph in 4 passes: 100% (3188888/3188888), done.
    +        Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
    +        Expanding reachable commits in commit graph: 815990, done.
    +        Computing commit graph generation numbers: 100% (815983/815983), done.
    +        Writing out commit graph in 4 passes: 100% (3263932/3263932), done.
     
         The "Counting distinct commits in commit graph" phase will spend most
         of its time paused at "0/*" as we QSORT(...) the list. That's not
    -    optimal, but at least we don't seem to be stalling anymore.
    +    optimal, but at least we don't seem to be stalling anymore most of the
    +    time.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
10:  fd692499e0 <  -:  ---------- commit-graph write: emit a percentage for all progress
 -:  ---------- >  9:  d69dbf81de commit-graph write: emit a percentage for all progress
-- 
2.20.1.153.gd81d796ee0

