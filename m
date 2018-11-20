Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481501F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeKUGV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:21:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47025 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKUGV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so3234767wrt.13
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9Lh82hqPH1K2PLLpkFGTLnS0Oj2mGDqRphkOAaUoOI=;
        b=Ml7nks1rKutDy/E6KsIxgmOCY4Rd5Cc2MXK3M9HEHR749sK/jbZUT/5VTMTm2EeW7B
         Q7zFvz3ngqv5AOWXeNDGGQjrw7+SmCcXmHDczEweZE9Lc+PSan8aAdJSnqHazgLYxGJb
         Bvxj6NFlqITmkVQMsl86AVN3h9GtXNoogRr8EO0UsvsDtjQJobX1OSNFxfk//r2m+8+7
         EzXPK8VuCnTwckWx509FXjn5a1/9srUa2dJmyl7FUupna6wlZwNkikMJ52hyQz5AJUxY
         8rrX2W4hCjJFnkbOPBpWUXnGTE4x/zF1GbSEwkTlGI53qNL4tTfbt/loaDGeh6WCE1ue
         UtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9Lh82hqPH1K2PLLpkFGTLnS0Oj2mGDqRphkOAaUoOI=;
        b=Y7NLg6E93uBrfDliqaSNnZQ8XlH0ZqrkfgYwJi2lktPZQgNeQPlY2Kae1R9dh3qx6K
         q/4znv5bLyjNM6sU/Sm4+Byg6ckT1KDg8TN8c3r6TbJy+p8/HN5On75QistWkmQVucNn
         ATRuCfdPX/d2yhN1pnX1nI7inw+pFNdxFmgmtle/GWw83d22tweMTGPmtSKGOccJSXJU
         +tIO3VH3nWUuXG9e2wpjN72Bek1Ki+k7LoR4UgV5+6nqJqUAV//kGR9VMZAJEl7EY5XQ
         sNoHEXWFrjwBQtwfHBH8xYSEUxrHtWjKmxB/OWKHvlWeiVWt57YGNnk7V1RmdRvNy1z1
         rZ9A==
X-Gm-Message-State: AA+aEWYqlyJicijdk8H4vzO2ecFJDdqCmFsm+o8UTdapvEaqP+9L/u38
        /IRnB2Nfe+GnNLEHNtaugO+SheA+hFA=
X-Google-Smtp-Source: AFSGD/Vx4EOVpsLIoaBZ+a3F+BZClDiC6uQbHFgEvutYmHRBdKbdp6ayJfxWRy9RBl555LcUWHNdBg==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr3163783wrc.62.1542743437064;
        Tue, 20 Nov 2018 11:50:37 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p14sm12589415wrt.37.2018.11.20.11.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:50:35 -0800 (PST)
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
Subject: [PATCH v2 0/6] commit-graph write: progress output improvements
Date:   Tue, 20 Nov 2018 19:50:21 +0000
Message-Id: <20181120195027.3260-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181120165800.GB30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes issues SZEDER raised with v1, except displaying an accurate ETA
in write_graph_*(). As noted in 2/6 I don't think it's worth it, I
just adjusted the message instead.

Ævar Arnfjörð Bjarmason (6):
  commit-graph write: rephrase confusing progress output
  commit-graph write: add more progress output
  commit-graph write: show progress for object search
  commit-graph write: add more describing progress output
  commit-graph write: remove empty line for readability
  commit-graph write: add even more progress output

 commit-graph.c | 92 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 19 deletions(-)

Range-diff:
1:  751d3a7561 ! 1:  093c63e99f commit-graph write: add more progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -13,22 +13,30 @@
         point at which we're not producing progress output:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 6418991, done.
    -        Computing commit graph generation numbers: 100% (797205/797205), done.
    -        Writing out commit graph chunks: 2399861, done.
    +        Finding commits for commit graph: 6365492, done.
    +        Computing commit graph generation numbers: 100% (797222/797222), done.
    +        Writing out commit graph: 2399912, done.
     
    -    This "graph chunks" number is not meant to be meaningful to the user,
    +    This "writing out" number is not meant to be meaningful to the user,
         but just to show that we're doing work and the command isn't
         hanging.
     
    +    In the current implementation it's approximately 4x the number of
    +    commits. As noted in on-list discussion[1] we could add the loops up
    +    and show percentage progress here, but I don't think it's worth it. It
    +    would make the implementation more complex and harder to maintain for
    +    very little gain.
    +
         On a much larger in-house repository I have we'll show (note how we
         also say "Annotating[...]"):
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 48271163, done.
    -        Annotating commit graph: 21424536, done.
    -        Computing commit graph generation numbers: 100% (7141512/7141512), done.
    -        Writing out commit graph chunks: 21424913, done.
    +        Finding commits for commit graph: 50026015, done.
    +        Annotating commit graph: 21567407, done.
    +        Computing commit graph generation numbers: 100% (7144680/7144680), done.
    +        Writing out commit graph: 21434417, done.
    +
    +    1. https://public-inbox.org/git/20181120165800.GB30222@szeder.dev/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -50,8 +58,7 @@
      	 */
      	for (i = 0; i < 256; i++) {
      		while (count < nr_commits) {
    -+			if (progress)
    -+				display_progress(progress, ++*progress_cnt);
    ++			display_progress(progress, ++*progress_cnt);
      			if ((*list)->object.oid.hash[0] != i)
      				break;
      			count++;
    @@ -68,8 +75,7 @@
      	int count;
     -	for (count = 0; count < nr_commits; count++, list++)
     +	for (count = 0; count < nr_commits; count++, list++) {
    -+		if (progress)
    -+			display_progress(progress, ++*progress_cnt);
    ++		display_progress(progress, ++*progress_cnt);
      		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
     +	}
      }
    @@ -87,15 +93,13 @@
      	struct commit **list = commits;
      	struct commit **last = commits + nr_commits;
     @@
    + 		struct commit_list *parent;
      		int edge_value;
      		uint32_t packedDate[2];
    ++		display_progress(progress, ++*progress_cnt);
      
    -+		if (progress)
    -+			display_progress(progress, ++*progress_cnt);
    -+
      		parse_commit(*list);
      		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
    - 
     @@
      
      static void write_graph_chunk_large_edges(struct hashfile *f,
    @@ -108,20 +112,18 @@
      	struct commit **list = commits;
      	struct commit **last = commits + nr_commits;
     @@
    + 						  commits,
      						  nr_commits,
      						  commit_to_sha1);
    ++			display_progress(progress, ++*progress_cnt);
      
    -+			if (progress)
    -+				display_progress(progress, ++*progress_cnt);
    -+
      			if (edge_value < 0)
      				edge_value = GRAPH_PARENT_MISSING;
    - 			else if (!parent->next)
     @@
      	int num_extra_edges;
      	struct commit_list *parent;
      	struct progress *progress = NULL;
    -+	uint64_t progress_cnt;
    ++	uint64_t progress_cnt = 0;
      
      	if (!commit_graph_compatible(the_repository))
      		return;
    @@ -135,8 +137,8 @@
     -	write_graph_chunk_large_edges(f, commits.list, commits.nr);
     +	if (report_progress)
     +		progress = start_delayed_progress(
    -+			_("Writing out commit graph chunks"),
    -+			progress_cnt = 0);
    ++			_("Writing out commit graph"),
    ++			0);
     +	write_graph_chunk_fanout(f, commits.list, commits.nr, progress,
     +				 &progress_cnt);
     +	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr,
2:  d750f0dd16 ! 2:  6c71de9460 commit-graph write: show progress for object search
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -8,18 +8,17 @@
     
         Before we'd emit on e.g. linux.git with "commit-graph write":
     
    -        Finding commits for commit graph: 6418991, done.
    +        Finding commits for commit graph: 6365492, done.
             [...]
     
         And now:
     
    -        Finding commits for commit graph: 100% (6418991/6418991), done.
    +        Finding commits for commit graph: 100% (6365492/6365492), done.
             [...]
     
    -    Since the commit graph only includes those commits that are
    -    packed (via for_each_packed_object(...)) the
    -    approximate_object_count() returns the actual number of objects we're
    -    going to process.
    +    Since the commit graph only includes those commits that are packed
    +    (via for_each_packed_object(...)) the approximate_object_count()
    +    returns the actual number of objects we're going to process.
     
         Still, it is possible due to a race with "gc" or another process
         maintaining packs that the number of objects we're going to process is
    @@ -40,7 +39,7 @@
     @@
      	struct commit_list *parent;
      	struct progress *progress = NULL;
    - 	uint64_t progress_cnt;
    + 	uint64_t progress_cnt = 0;
     +	unsigned long approx_nr_objects;
      
      	if (!commit_graph_compatible(the_repository))
3:  a175ab49ff ! 3:  c665dbdacb commit-graph write: add more describing progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -10,18 +10,26 @@
         we support:
     
             $ git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6418991/6418991), done.
    +        Finding commits for commit graph among packed objects: 100% (6365492/6365492), done.
             [...]
    +
    +        # Actually we don't emit this since this takes almost no time at
    +        # all. But if we did (s/_delayed//) we'd show:
             $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    -        Finding commits for commit graph from 584 ref tips: 100% (584/584), done.
    +        Finding commits for commit graph from 584 refs: 100% (584/584), done.
             [...]
    +
             $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    -        Finding commits for commit graph in 4 packs: 6418991, done.
    +        Finding commits for commit graph in 3 packs: 6365492, done.
             [...]
     
    -    The middle on of those is going to be the output users will most
    -    commonly see, since it'll be emitted when they get the commit graph
    -    via gc.writeCommitGraph=true.
    +    The middle on of those is going to be the output users might see in
    +    practice, since it'll be emitted when they get the commit graph via
    +    gc.writeCommitGraph=true. But as noted above you need a really large
    +    number of refs for this message to show. It'll show up on a test
    +    repository I have with ~165k refs:
    +
    +        Finding commits for commit graph from 165203 refs: 100% (165203/165203), done.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -30,7 +38,7 @@
      +++ b/commit-graph.c
     @@
      	struct progress *progress = NULL;
    - 	uint64_t progress_cnt;
    + 	uint64_t progress_cnt = 0;
      	unsigned long approx_nr_objects;
     +	struct strbuf progress_title = STRBUF_INIT;
      
    @@ -66,8 +74,8 @@
     -				commit_hex->nr);
     +		if (report_progress) {
     +			strbuf_addf(&progress_title,
    -+				    Q_("Finding commits for commit graph from %d ref tip",
    -+				       "Finding commits for commit graph from %d ref tips",
    ++				    Q_("Finding commits for commit graph from %d ref",
    ++				       "Finding commits for commit graph from %d refs",
     +				       commit_hex->nr),
     +				    commit_hex->nr);
     +			progress = start_delayed_progress(progress_title.buf,
4:  4e11c8b2fd = 4:  f70fc5045d commit-graph write: remove empty line for readability
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
5:  6fbba22fac ! 5:  2e943fa925 commit-graph write: add even more progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -4,24 +4,26 @@
     
         Add more progress output to sections of code that can collectively
         take 5-10 seconds on a large enough repository. On a test repository
    -    with 7141512 commits (see earlier patches for details) we'll now emit:
    +    with I have with ~7 million commits and ~50 million objects we'll now
    +    emit:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (50009986/50009986), done.
    -        Annotating commit graph: 21564240, done.
    -        Counting distinct commits in commit graph: 100% (7188080/7188080), done.
    -        Finding extra edges in commit graph: 100% (7188080/7188080), done.
    -        Computing commit graph generation numbers: 100% (7143635/7143635), done.
    -        Writing out commit graph chunks: 21431282, done.
    +        Finding commits for commit graph among packed objects: 100% (50026015/50026015), done.
    +        Annotating commit graph: 21567407, done.
    +        Counting distinct commits in commit graph: 100% (7189147/7189147), done.
    +        Finding extra edges in commit graph: 100% (7189147/7189147), done.
    +        Computing commit graph generation numbers: 100% (7144680/7144680), done.
    +        Writing out commit graph: 21434417, done.
     
    -    Whereas on a medium-sized repository such as linux.git we'll still
    +    Whereas on a medium-sized repository such as linux.git these new
    +    progress bars won't have time to kick in and as before and we'll still
         emit output like:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6365328/6365328), done.
    -        Annotating commit graph: 2391621, done.
    -        Computing commit graph generation numbers: 100% (797207/797207), done.
    -        Writing out commit graph chunks: 2399867, done.
    +        Finding commits for commit graph among packed objects: 100% (6365492/6365492), done.
    +        Annotating commit graph: 2391666, done.
    +        Computing commit graph generation numbers: 100% (797222/797222), done.
    +        Writing out commit graph: 2399912, done.
     
         The "Counting distinct commits in commit graph" phase will spend most
         of its time paused at "0/*" as we QSORT(...) the list. That's not
-- 
2.20.0.rc0.387.gc7a69e6b6c

