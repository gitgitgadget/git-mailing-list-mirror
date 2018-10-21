Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98981F453
	for <e@80x24.org>; Sun, 21 Oct 2018 21:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeJVFdG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 01:33:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeJVFdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 01:33:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so42742924wrw.3
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5i5KA7eseriW1AF7XGAc2/72KMVTE9aLgUjqf/dUE2M=;
        b=f0ggNyiMZD3kMvIA/FsajQJW0MTeKbSkCEK86b9yxbroc1IXy9qAePqjYwbyLUBO+I
         9udNnCPUA+vozw5tEQaROc9BE85X1+naHz+XNpURiHHXL4E77EaH/W74wIO2LkvjSRIk
         4bN6YtAD32GglQa+/OXO2rAbDqAopAY0kshdSoSAj4L7430qhgo8Q6qDaJGuM3Do9h5W
         o2oSOmTlGXai4GpMwS5JTgpRgj+QLm6U818v4hUxZefYIaB7VYD7WWOi5EDvL04vsnNy
         YhwcGOtMV5YsN3xjM092PzC7kHqcDi4TTQdWHFTjL/OG44SynQoCwKtqp26ooAxvrQij
         FyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=5i5KA7eseriW1AF7XGAc2/72KMVTE9aLgUjqf/dUE2M=;
        b=ogJxDkjn6bUeMQTm48/6+rF77BVc9A6KZUJr4085aPw1tRenRBl69oERtKk0Lg+6Q1
         4gtBfg1Mvn8idJtTEphA4Nf9mRTut08fOkV4BBWGB98KUAUddXdNdJbAcWwRRUViEfQd
         fXYz/hpbE9GecJMAeQngfLEJ4BrzR69r/Qp2uc2ptjt5wFUqSeWMrzkdjOxNth+m3zQJ
         1gHZMZcjV5rz912z0wMCLpF8Qjxht1qa0otyXoc34WftFWX9LAZOei0VFx/JE7KoNDAt
         ee6dTdsx9aEBJcwzSeU9STCcKISwIHejhGbo9OsOw+AWpj+stRpcZrBdISZKoNwsqsbu
         AoPA==
X-Gm-Message-State: AGRZ1gLUo/z7uFg0EtL3IVEU8PJInm0JClwG0z7ZQjr1ukQfKT46qo08
        E9c2AAphliotsFTZ7EJO/Hc=
X-Google-Smtp-Source: AJdET5eduoiaryQ3C/QCP46z3gALgeX3K8gUPbMltJcU3w1KF0TPN01PLFm6Qn2DCltuhOrZ2QzUmQ==
X-Received: by 2002:adf:e74c:: with SMTP id c12-v6mr5297858wrn.182.1540156643720;
        Sun, 21 Oct 2018 14:17:23 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps207.neoplus.adsl.tpnet.pl. [83.8.60.207])
        by smtp.gmail.com with ESMTPSA id t198-v6sm14943626wmd.9.2018.10.21.14.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 14:17:22 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 5/7] commit/revisions: bookkeeping before refactoring
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <f3e291665dae94b7347621ec78721f7e0dcc86d8.1539729393.git.gitgitgadget@gmail.com>
Date:   Sun, 21 Oct 2018 23:17:21 +0200
In-Reply-To: <f3e291665dae94b7347621ec78721f7e0dcc86d8.1539729393.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 16 Oct 2018
        15:36:43 -0700 (PDT)")
Message-ID: <865zxvgftq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> There are a few things that need to move around a little before
> making a big refactoring in the topo-order logic:
>
> 1. We need access to record_author_date() and
>    compare_commits_by_author_date() in revision.c. These are used
>    currently by sort_in_topological_order() in commit.c.
>
> 2. Moving these methods to commit.h requires adding the author_slab
>    definition to commit.h.

Those two changes are connected, and must be kept together.

> 3. The add_parents_to_list() method in revision.c performs logic
>    around the UNINTERESTING flag and other special cases depending
>    on the struct rev_info. Allow this method to ignore a NULL 'list'
>    parameter, as we will not be populating the list for our walk.
>    Also rename the method to the slightly more generic name
>    process_parents() to make clear that this method does more than
>    add to a list (and no list is required anymore).

But as far as I can understand, this change is independent, and it could
be put into a separate commmit.

The change of function name to process_parents() and allowing for 'list'
parameter to be NULL are related, though.

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

No need to split, unless there would be v5 anyway, in my opinion.

> ---
>  commit.c   | 11 +++++------
>  commit.h   |  8 ++++++++
>  revision.c | 18 ++++++++++--------
>  3 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index d0f199e122..861a485e93 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -655,11 +655,10 @@ struct commit *pop_commit(struct commit_list **stac=
k)
>  /* count number of children that have not been emitted */
>  define_commit_slab(indegree_slab, int);
>=20=20
> -/* record author-date for each commit object */
> -define_commit_slab(author_date_slab, timestamp_t);
> +implement_shared_commit_slab(author_date_slab, timestamp_t);

I see that the comment got moved to the site with
define_shared_commit_slab(), i.e. to commit.h, instead of duplicting
it.  All right.

Sidenote: Ugh, small_caps preprocessor macros [trickery].

>=20=20
> -static void record_author_date(struct author_date_slab *author_date,
> -			       struct commit *commit)
> +void record_author_date(struct author_date_slab *author_date,
> +			struct commit *commit)
>  {
>  	const char *buffer =3D get_commit_buffer(commit, NULL);
>  	struct ident_split ident;
> @@ -684,8 +683,8 @@ fail_exit:
>  	unuse_commit_buffer(commit, buffer);
>  }
>=20=20
> -static int compare_commits_by_author_date(const void *a_, const void *b_,
> -					  void *cb_data)
> +int compare_commits_by_author_date(const void *a_, const void *b_,
> +				   void *cb_data)

All right, this is straighforward changing record_author_date() and
compare_commits_by_author_date() from static (file-local) functions to
exported functions.

>  {
>  	const struct commit *a =3D a_, *b =3D b_;
>  	struct author_date_slab *author_date =3D cb_data;
> diff --git a/commit.h b/commit.h
> index 2b1a734388..977d397356 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -8,6 +8,7 @@
>  #include "gpg-interface.h"
>  #include "string-list.h"
>  #include "pretty.h"
> +#include "commit-slab.h"
>=20=20
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
>  #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> @@ -328,6 +329,13 @@ extern int remove_signature(struct strbuf *buf);
>   */
>  extern int check_commit_signature(const struct commit *commit, struct si=
gnature_check *sigc);
>=20=20
> +/* record author-date for each commit object */
> +define_shared_commit_slab(author_date_slab, timestamp_t);

All right, this is needed for record_author_date() function, which is
now exported.

> +
> +void record_author_date(struct author_date_slab *author_date,
> +			struct commit *commit);
> +
> +int compare_commits_by_author_date(const void *a_, const void *b_, void =
*unused);

O.K., this is simply exporting previously static functions.

>  int compare_commits_by_commit_date(const void *a_, const void *b_, void =
*unused);
>  int compare_commits_by_gen_then_commit_date(const void *a_, const void *=
b_, void *unused);
>=20=20
> diff --git a/revision.c b/revision.c
> index 2dcde8a8ac..36458265a0 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -768,8 +768,8 @@ static void commit_list_insert_by_date_cached(struct =
commit *p, struct commit_li
>  		*cache =3D new_entry;
>  }
>=20=20
> -static int add_parents_to_list(struct rev_info *revs, struct commit *com=
mit,
> -		    struct commit_list **list, struct commit_list **cache_ptr)
> +static int process_parents(struct rev_info *revs, struct commit *commit,
> +			   struct commit_list **list, struct commit_list **cache_ptr)

All right, straighforward rename.

>  {
>  	struct commit_list *parent =3D commit->parents;
>  	unsigned left_flag;
> @@ -808,7 +808,8 @@ static int add_parents_to_list(struct rev_info *revs,=
 struct commit *commit,
>  			if (p->object.flags & SEEN)
>  				continue;
>  			p->object.flags |=3D SEEN;
> -			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
> +			if (list)
> +				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
>  		}
>  		return 0;
>  	}
> @@ -847,7 +848,8 @@ static int add_parents_to_list(struct rev_info *revs,=
 struct commit *commit,
>  		p->object.flags |=3D left_flag;
>  		if (!(p->object.flags & SEEN)) {
>  			p->object.flags |=3D SEEN;
> -			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
> +			if (list)
> +				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);

All right, both of those is about allowing 'list' parameter to be NULL,
and invoking commit_list_insert_by_date_cached() only if it's not NULL.

>  		}
>  		if (revs->first_parent_only)
>  			break;
> @@ -1091,7 +1093,7 @@ static int limit_list(struct rev_info *revs)
>=20=20
>  		if (revs->max_age !=3D -1 && (commit->date < revs->max_age))
>  			obj->flags |=3D UNINTERESTING;
> -		if (add_parents_to_list(revs, commit, &list, NULL) < 0)
> +		if (process_parents(revs, commit, &list, NULL) < 0)
>  			return -1;
>  		if (obj->flags & UNINTERESTING) {
>  			mark_parents_uninteresting(commit);
> @@ -2913,7 +2915,7 @@ static struct commit *next_topo_commit(struct rev_i=
nfo *revs)
>=20=20
>  static void expand_topo_walk(struct rev_info *revs, struct commit *commi=
t)
>  {
> -	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
> +	if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
>  		if (!revs->ignore_missing_links)
>  			die("Failed to traverse parents of commit %s",
>  			    oid_to_hex(&commit->object.oid));
> @@ -2979,7 +2981,7 @@ static enum rewrite_result rewrite_one(struct rev_i=
nfo *revs, struct commit **pp
>  	for (;;) {
>  		struct commit *p =3D *pp;
>  		if (!revs->limited)
> -			if (add_parents_to_list(revs, p, &revs->commits, &cache) < 0)
> +			if (process_parents(revs, p, &revs->commits, &cache) < 0)
>  				return rewrite_one_error;
>  		if (p->object.flags & UNINTERESTING)
>  			return rewrite_one_ok;
> @@ -3312,7 +3314,7 @@ static struct commit *get_revision_1(struct rev_inf=
o *revs)
>  				try_to_simplify_commit(revs, commit);
>  			else if (revs->topo_walk_info)
>  				expand_topo_walk(revs, commit);
> -			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0)=
 {
> +			else if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
>  				if (!revs->ignore_missing_links)
>  					die("Failed to traverse parents of commit %s",
>  						oid_to_hex(&commit->object.oid));

All those is just changing the calling convention due to function
rename.

(I wonder if such simple refactoring could have been done via Coccinelle
patch).


Anyway, looks good to me.
--
Jakub Nar=C4=99bski
