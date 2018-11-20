Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A641F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 23:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKUKK3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 05:10:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40474 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKUKK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 05:10:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so3933801wmf.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 15:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M18sWAkbc64K1wd4JWV8tNSkoPpFsHhcQ0yHDWojXJ4=;
        b=X8glB+uY5q9HEIn62yAy475/p31WnLDU6ccPeLD1yCbpDtrV4HsjLFbi3ckInNWPMl
         x3stjobFdN1yMoXO5zdSxaTLGHK3PRoFYV05NdgqBcedFHDTyXwZxc+jE6PmFQcSRX2o
         2SUo7wTcweuwtX0QF0qAhjR0QVfVK/SaZ5godexI9iiNNzlwnoly0toUOB1tY7hleQN+
         CF+Y+lRTwbvvbhr+kxWMM80EiJo/61Ik6KFaDNLfIdfJkrUtQnYNMizR2qllBIXInow1
         Qvr9+It6v95q2txDvwtSRYOtWheYGvpgV5YHBK3mWvCiPETD+j8iAw8XowVujCIZRpe+
         TUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M18sWAkbc64K1wd4JWV8tNSkoPpFsHhcQ0yHDWojXJ4=;
        b=uKKbJr5kLz0T6zOUOSGSc1a1m9x7itA466mb/DA9j2KlJOk3xMJ+EkBnyw+4mN/DNa
         QUYKnsA04OkUmkAJUjXyqyuDIeTSwGdb88buNhCSWoQ3LcUdbllnfT44fBqyOr3waN8D
         /tLPBnBlH8RxsQzhnLjpuWQoJuW8E5r9TN+YL0e9+7SjnAn3iEif/dOJGrmv4WM1X94u
         LXL5wadV1V7LXU1n8e5b523aRS29zlZdWwUbLTdbAJrNCHpIjnmd4fDdSrPhta+yxG6P
         5DDPm5g9fQ5nbcsoqc4ADcBt089At/Le46mr4uRXu0UFcMjej/+PNlj5/qBiFev2G9ZI
         2ZIg==
X-Gm-Message-State: AA+aEWaotLUo+yJljt7nqJXN+3ovyFbxrd7O21RzdgmgyEgjfljZfT3l
        GG7cYlbiqC2Ltlj6FPPwC6A=
X-Google-Smtp-Source: AFSGD/WHfcaglgjyZMbBBxMYh2Xn/Kilg4C0fEK6DiDEEEjKbncFh28j9DOaWiMa4perO5u8vl2Qqg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr3659218wmc.5.1542757122448;
        Tue, 20 Nov 2018 15:38:42 -0800 (PST)
Received: from szeder.dev (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id j199sm39666014wmf.13.2018.11.20.15.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 15:38:41 -0800 (PST)
Date:   Wed, 21 Nov 2018 00:38:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/6] commit-graph write: add more progress output
Message-ID: <20181120233840.GC30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
 <20181120195027.3260-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120195027.3260-3-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 07:50:23PM +0000, Ævar Arnfjörð Bjarmason wrote:
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
>     Finding commits for commit graph: 6365492, done.
>     Computing commit graph generation numbers: 100% (797222/797222), done.
>     Writing out commit graph: 2399912, done.
> 
> This "writing out" number is not meant to be meaningful to the user,
> but just to show that we're doing work and the command isn't
> hanging.
> 
> In the current implementation it's approximately 4x the number of
> commits.

"approximately" only, because the current implementation is buggy :)
If done right it's exactly 4x the number of commits.

> As noted in on-list discussion[1] we could add the loops up
> and show percentage progress here, but I don't think it's worth it. It
> would make the implementation more complex and harder to maintain for
> very little gain.

I think that if we can cheaply and accurately figure out the total,
then we should display it, so onlooking users can guesstimate how much
work is still left to be done.

> On a much larger in-house repository I have we'll show (note how we
> also say "Annotating[...]"):
> 
>     $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
>     Finding commits for commit graph: 50026015, done.
>     Annotating commit graph: 21567407, done.
>     Computing commit graph generation numbers: 100% (7144680/7144680), done.
>     Writing out commit graph: 21434417, done.
> 
> 1. https://public-inbox.org/git/20181120165800.GB30222@szeder.dev/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  commit-graph.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index e6d0d7722b..6f6409b292 100644
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
> @@ -445,6 +447,7 @@ static void write_graph_chunk_fanout(struct hashfile *f,
>  	 */
>  	for (i = 0; i < 256; i++) {
>  		while (count < nr_commits) {
> +			display_progress(progress, ++*progress_cnt);

I think this display_progress() should be places after the condition,
so no one has to waste brain cycles on figuring out, why it always
counts 255 more than the number of commits.

>  			if ((*list)->object.oid.hash[0] != i)
>  				break;
>  			count++;
> @@ -456,12 +459,16 @@ static void write_graph_chunk_fanout(struct hashfile *f,
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
> +		display_progress(progress, ++*progress_cnt);
>  		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
> +	}
>  }
>  
>  static const unsigned char *commit_to_sha1(size_t index, void *table)
> @@ -471,7 +478,9 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
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
> @@ -481,6 +490,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  		struct commit_list *parent;
>  		int edge_value;
>  		uint32_t packedDate[2];
> +		display_progress(progress, ++*progress_cnt);
>  
>  		parse_commit(*list);
>  		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
> @@ -542,7 +552,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
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

> @@ -565,6 +577,7 @@ static void write_graph_chunk_large_edges(struct hashfile *f,

[Adding more before-context to this hunk here...]

>	while (list < last) {

This loop iterates over all commits ...

>		int num_parents = 0;
>		for (parent = (*list)->parents; num_parents < 3 && parent;
>		     parent = parent->next)
>			num_parents++;

... counts the parents of the current commit ...

>
>		if (num_parents <= 2) {
>			list++;
>			continue;

... and continues iterating unless it's an octopus merge.

>		}
>
>		/* Since num_parents > 2, this initializer is safe. */
>		for (parent = (*list)->parents->next; parent; parent = parent->next) {
>			int edge_value = sha1_pos(parent->item->object.oid.hash,
>  						  commits,
>  						  nr_commits,
>  						  commit_to_sha1);
> +			display_progress(progress, ++*progress_cnt);

So this display_progress() call is in the wrong place, because it will
only be invoked on octopus merges, which only rarely occur in
practice, thus it's entirely possible that it won't show any progress
at all while the outer while loop iterates over the whole history.

This display_progress() should be places somewhere before that 'if
(num_parents <= 2)' condition.  And then this one, too, will count the
number of commits.

>  
>  			if (edge_value < 0)
>  				edge_value = GRAPH_PARENT_MISSING;
> @@ -764,6 +777,7 @@ void write_commit_graph(const char *obj_dir,
>  	int num_extra_edges;
>  	struct commit_list *parent;
>  	struct progress *progress = NULL;
> +	uint64_t progress_cnt = 0;
>  
>  	if (!commit_graph_compatible(the_repository))
>  		return;
> @@ -937,10 +951,19 @@ void write_commit_graph(const char *obj_dir,
>  		hashwrite(f, chunk_write, 12);
>  	}
>  
> -	write_graph_chunk_fanout(f, commits.list, commits.nr);
> -	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
> -	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
> -	write_graph_chunk_large_edges(f, commits.list, commits.nr);
> +	if (report_progress)
> +		progress = start_delayed_progress(
> +			_("Writing out commit graph"),
> +			0);
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
> -- 
> 2.20.0.rc0.387.gc7a69e6b6c
> 
