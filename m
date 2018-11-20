Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFBE1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 16:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeKUD2N (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 22:28:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52817 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeKUD2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 22:28:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so2807319wmb.2
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eRHxthFUZVJLm8ABilSsnnDz0rFhTiFu3o19qsehYds=;
        b=A4cdzgYTzOPrFybaf9nf0K9oZ4rYL+du/KcKXvfQlD6G8jVOY6OMd/gMP3sCz4SHVw
         2qNuCHL3AORfytwuqVIfEZeH2wQMuBl27oQgQPaKg4NYzbo8F5ZXMLbJgXqCx8zBmxdr
         e8JTPXsKUv4voMGeR2UdchvQK3BjWibDev/i9gxttqRgVNXsB5lbi0Hx3nfjBfEkhqlN
         0/MOTUcjXb02HS+xILTbFjdd6LBbRhXwPOGhRnrk/f/g7Ccp/dSyW6CgbNtW2ZyRBplQ
         r5vnIKb0pjeyRRrYc00wa+Ji2ylkYWkM+rjAW3TwHhywpBEWNM5ZzuSkFctaBTMJggV2
         Mlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eRHxthFUZVJLm8ABilSsnnDz0rFhTiFu3o19qsehYds=;
        b=ZwedvJPSLbdwooZmmpe6FCErlTV/6TlshO84nhlDKaAwvULji/k0A8JuIQntVejomG
         C2+Rg5mc4gWhii1bV9B6OuDrG4vkqTmHqFmVqRe3Ifr1AlPkMlMhNuU/UY3m5v17mFEb
         QFmQHQJjWxDZDhhxRyEOrvFIj3HiHtHOLiLoYCKTt91Sve48RWgwln47Ec6uo3RWrQDv
         oFcaS7lwuoTCCRRxnWzeOlY2uW52OHznvpqj1Zv6uN76hIZANvlc83J5WT/cIJmMXEVl
         pc0yeEzW2jd647XSOQsduWTzixgBCQELNdUMgUUbFJyYEadoUB+XwVgWQwuKi5mqpxwp
         Pv0w==
X-Gm-Message-State: AGRZ1gJlTPWhDy/8OlWouYe2PjoWS6/KcqsZddDDKJKOymqSI5tAJZtg
        sdeoIfzxLVOJFOSc77eAmeQ=
X-Google-Smtp-Source: AJdET5ecKSex4IV63SxMSVRP1uc97CCTJK+pysCKex3VA5fnlk7cmZZWvEvPvl619M3n/LlUNbX+9Q==
X-Received: by 2002:a1c:580a:: with SMTP id m10mr1925460wmb.1.1542733083734;
        Tue, 20 Nov 2018 08:58:03 -0800 (PST)
Received: from szeder.dev (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id b16sm52640610wrm.41.2018.11.20.08.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:58:02 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:58:00 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/6] commit-graph write: add more progress output
Message-ID: <20181120165800.GB30222@szeder.dev>
References: <20181119225720.GV30222@szeder.dev>
 <20181120150443.12997-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120150443.12997-3-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 03:04:39PM +0000, Ævar Arnfjörð Bjarmason wrote:
> Add more progress output to the output already added in
> 7b0f229222 ("commit-graph write: add progress output", 2018-09-17).
> 
> As noted in that commit most of the progress output isn't displayed on
> small repositories, but before this change we'd noticeably hang for
> 2-3 seconds at the end on medium sized repositories such as linux.git.
> 
> Now we'll instead show output like this, and have no human-observable
> point at which we're not producing progress output:
> 
>     $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
>     Finding commits for commit graph: 6418991, done.
>     Computing commit graph generation numbers: 100% (797205/797205), done.
>     Writing out commit graph chunks: 2399861, done.
> 
> This "graph chunks" number is not meant to be meaningful to the user,
> but just to show that we're doing work and the command isn't
> hanging.
> 
> On a much larger in-house repository I have we'll show (note how we
> also say "Annotating[...]"):
> 
>     $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
>     Finding commits for commit graph: 48271163, done.
>     Annotating commit graph: 21424536, done.
>     Computing commit graph generation numbers: 100% (7141512/7141512), done.
>     Writing out commit graph chunks: 21424913, done.

That's a lot of chunks, but according to the specs, there are only 3
or 4 chunks in a commit-graph file.  More on this below.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  commit-graph.c | 47 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index e6d0d7722b..afce20dd4d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -433,7 +433,9 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
>  
>  static void write_graph_chunk_fanout(struct hashfile *f,
>  				     struct commit **commits,
> -				     int nr_commits)
> +				     int nr_commits,
> +				     struct progress *progress,
> +				     uint64_t *progress_cnt)
>  {
>  	int i, count = 0;
>  	struct commit **list = commits;
> @@ -445,6 +447,8 @@ static void write_graph_chunk_fanout(struct hashfile *f,
>  	 */
>  	for (i = 0; i < 256; i++) {
>  		while (count < nr_commits) {
> +			if (progress)
> +				display_progress(progress, ++*progress_cnt);

The condition is unnecessary, display_progress() is prepared to deal
with a NULL progress pointer.  The same applies to all such calls in
this patch.

>  			if ((*list)->object.oid.hash[0] != i)
>  				break;
>  			count++;
> @@ -456,12 +460,17 @@ static void write_graph_chunk_fanout(struct hashfile *f,
>  }
>  
>  static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
> -				   struct commit **commits, int nr_commits)
> +				   struct commit **commits, int nr_commits,
> +				   struct progress *progress,
> +				   uint64_t *progress_cnt)
>  {
>  	struct commit **list = commits;
>  	int count;
> -	for (count = 0; count < nr_commits; count++, list++)
> +	for (count = 0; count < nr_commits; count++, list++) {
> +		if (progress)
> +			display_progress(progress, ++*progress_cnt);
>  		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
> +	}
>  }
>  
>  static const unsigned char *commit_to_sha1(size_t index, void *table)
> @@ -471,7 +480,9 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
>  }
>  
>  static void write_graph_chunk_data(struct hashfile *f, int hash_len,
> -				   struct commit **commits, int nr_commits)
> +				   struct commit **commits, int nr_commits,
> +				   struct progress *progress,
> +				   uint64_t *progress_cnt)
>  {
>  	struct commit **list = commits;
>  	struct commit **last = commits + nr_commits;
> @@ -482,6 +493,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  		int edge_value;
>  		uint32_t packedDate[2];
>  
> +		if (progress)
> +			display_progress(progress, ++*progress_cnt);
> +
>  		parse_commit(*list);
>  		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
>  
> @@ -542,7 +556,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  
>  static void write_graph_chunk_large_edges(struct hashfile *f,
>  					  struct commit **commits,
> -					  int nr_commits)
> +					  int nr_commits,
> +					  struct progress *progress,
> +					  uint64_t *progress_cnt)
>  {
>  	struct commit **list = commits;
>  	struct commit **last = commits + nr_commits;
> @@ -566,6 +582,9 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
>  						  nr_commits,
>  						  commit_to_sha1);
>  
> +			if (progress)
> +				display_progress(progress, ++*progress_cnt);
> +
>  			if (edge_value < 0)
>  				edge_value = GRAPH_PARENT_MISSING;
>  			else if (!parent->next)
> @@ -764,6 +783,7 @@ void write_commit_graph(const char *obj_dir,
>  	int num_extra_edges;
>  	struct commit_list *parent;
>  	struct progress *progress = NULL;
> +	uint64_t progress_cnt;
>  
>  	if (!commit_graph_compatible(the_repository))
>  		return;
> @@ -937,10 +957,19 @@ void write_commit_graph(const char *obj_dir,
>  		hashwrite(f, chunk_write, 12);
>  	}
>  
> -	write_graph_chunk_fanout(f, commits.list, commits.nr);
> -	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
> -	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
> -	write_graph_chunk_large_edges(f, commits.list, commits.nr);
> +	if (report_progress)
> +		progress = start_delayed_progress(
> +			_("Writing out commit graph chunks"),
> +			progress_cnt = 0);

First, this is an unusual place to set a variable.

Second, as mentioned above, there are only 3 or 4 chunks, therefore I
think this should only say "Writing out commit graph".

Finally, each of the write_graph_chunk_*() functions called below
iterate over all commits, so we know and thus can show the total in
advance.

So how about something like the patch below on top?  Note that I had
to shift two display_progress() calls a couple of lines, because
otherwise the numbers didn't add up.

Just to get you thinking and to have something to try out, but I saw a
bit of weirdness while at it, and want to look into it, but now I've
got to go...


> +	write_graph_chunk_fanout(f, commits.list, commits.nr, progress,
> +				 &progress_cnt);
> +	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr,
> +			       progress, &progress_cnt);
> +	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr,
> +			       progress, &progress_cnt);
> +	write_graph_chunk_large_edges(f, commits.list, commits.nr, progress,
> +				      &progress_cnt);
> +	stop_progress(&progress);
>  
>  	close_commit_graph(the_repository);
>  	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);



diff --git a/commit-graph.c b/commit-graph.c
index 2e2eaa24ca..2f3417db32 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -447,10 +447,9 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 	 */
 	for (i = 0; i < 256; i++) {
 		while (count < nr_commits) {
-			if (progress)
-				display_progress(progress, ++*progress_cnt);
 			if ((*list)->object.oid.hash[0] != i)
 				break;
+			display_progress(progress, ++*progress_cnt);
 			count++;
 			list++;
 		}
@@ -467,8 +466,7 @@ static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
 	struct commit **list = commits;
 	int count;
 	for (count = 0; count < nr_commits; count++, list++) {
-		if (progress)
-			display_progress(progress, ++*progress_cnt);
+		display_progress(progress, ++*progress_cnt);
 		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
 	}
 }
@@ -493,8 +491,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		int edge_value;
 		uint32_t packedDate[2];
 
-		if (progress)
-			display_progress(progress, ++*progress_cnt);
+		display_progress(progress, ++*progress_cnt);
 
 		parse_commit(*list);
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
@@ -570,6 +567,8 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 		     parent = parent->next)
 			num_parents++;
 
+		display_progress(progress, ++*progress_cnt);
+
 		if (num_parents <= 2) {
 			list++;
 			continue;
@@ -582,9 +581,6 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 						  nr_commits,
 						  commit_to_sha1);
 
-			if (progress)
-				display_progress(progress, ++*progress_cnt);
-
 			if (edge_value < 0)
 				edge_value = GRAPH_PARENT_MISSING;
 			else if (!parent->next)
@@ -986,10 +982,11 @@ void write_commit_graph(const char *obj_dir,
 		hashwrite(f, chunk_write, 12);
 	}
 
-	if (report_progress)
+	if (report_progress) {
 		progress = start_delayed_progress(
-			_("Writing out commit graph chunks"),
-			progress_cnt = 0);
+			_("Writing out commit graph"), 4 * commits.nr);
+		progress_cnt = 0;
+	}
 	write_graph_chunk_fanout(f, commits.list, commits.nr, progress,
 				 &progress_cnt);
 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr,
