Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1122B202BB
	for <e@80x24.org>; Sun,  7 Apr 2019 10:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfDGKAT (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 06:00:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41043 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfDGKAS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 06:00:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so5854496pfd.8
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fAemOZ/MYiJz8NXRsZenQb82miMLyt8VJHFm0SgxNY0=;
        b=rn7OWactBEIXGcGH+TewsqX09GBeuiJ7UldXBC1d+9YjkDqH5wfPF/eaZFcADdKyaF
         2Wae2xl2byQCU70YJjQSf/cx0wgrLF7/XYVp+iSNBWnAWpu1A87ZM2/fSye1ob5AylQW
         jhJvC3q6uUxREdT4OIp7w5BOktGnjktCkBKB6GFadUx52DpudNzyobw7qwV24D508k0Q
         4LBmeQLOC4fqW04nWkJUdaf+nvptUz/KJvlAO5YJO+oDnynCchZ6bdbuOsi7schcBiPD
         LuByGZMXo5J+f0aJq9GCsxoVftxE6W8dT6+aGhKxTN29kEUiwP5QqPC7k1b8L/DQDSnh
         cjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fAemOZ/MYiJz8NXRsZenQb82miMLyt8VJHFm0SgxNY0=;
        b=QWLU++piJ8OBYKbQ6q1+kiJeOBvxx7jhoTNDRZMXjF9Vur/Ov0RCvnZtG5x7IGMwaR
         Tfd7PcPXOsfS6ReBng2ppIUOh67PeNwwwqHFZ7VYJLT6dPwWimX9JGkqpfqr3lMMf4PR
         sMSriS99fvARVVl8PlICP+EBlA3Be+5UuDFiS+6BxRUtskT7tBbZaR/+NOp6yJRwm3bM
         wE754OJLRvhGJH7IIKu2DG5Ds6+SjP04ykm80gpB/VJzrO2xzpGn9qprB/rTN0jLzvhn
         xGyAesYaArZlmult/gBwOUFgImzWoDeNbHSfM4bz4XGA8SFaYMPymkFF3iNu9+lsgEiq
         dzmQ==
X-Gm-Message-State: APjAAAWGok/7ymLdiDNC7wDejr9mc7Dy5wmoGRJQtdpVr/eSO6UrpPKI
        b8s4GEZDzyD6rZNqfx/xWBM=
X-Google-Smtp-Source: APXvYqzrNktXpk8EBwBM3ZwMUSUDyjHvPrvqLdqBRsN9+wvlFnzjRy6r8U5dNqg9Yn0qc+ImRziaGg==
X-Received: by 2002:a62:ed16:: with SMTP id u22mr23379498pfh.47.1554631217566;
        Sun, 07 Apr 2019 03:00:17 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id c5sm3790355pgh.5.2019.04.07.03.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 03:00:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 07 Apr 2019 17:00:11 +0700
Date:   Sun, 7 Apr 2019 17:00:11 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        t.gummerer@gmail.com
Subject: Re: [PATCH][RFC] read-cache: read_index_from() accepts repo as arg
Message-ID: <20190407100010.GA23427@ash>
References: <20190407073712.1642-1-jkapil.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407073712.1642-1-jkapil.cs@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 07, 2019 at 01:07:12PM +0530, Kapil Jain wrote:
> Signed-off-by: Kapil Jain <jkapil.cs@gmail.com>
> ---
> 
> In read-cache, the read_index_from() function had a TODO task, this
> patch completes that.

This line at least should be above the "---" line (i.e. part of the
commit message).

> diff --git a/read-cache.c b/read-cache.c
> index 4dc6de1b55..0444703284 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2256,7 +2256,7 @@ static void freshen_shared_index(const char *shared_index, int warn)
>  }
>  
>  int read_index_from(struct index_state *istate, const char *path,
> -		    const char *gitdir)
> +		    const char *gitdir, const struct repository *repo)

"struct repository *" by convention is always the first argument. See

https://public-inbox.org/git/xmqqsh2p6l43.fsf@gitster-ct.c.googlers.com/

You also do not need "gitdir" as a separate argument because gitdir is
an attribute of a repository. Passing it separately is just a trap to
give inconsistent information (e.g. one repo and one gitdir from
another one).

I see you already use repo->gitdir below. Which means this argument
"gitdir" is no longer used anyway. Please remove.

>  {
>  	struct split_index *split_index;
>  	int ret;
> @@ -2292,7 +2292,7 @@ int read_index_from(struct index_state *istate, const char *path,
>  		split_index->base = xcalloc(1, sizeof(*split_index->base));
>  
>  	base_oid_hex = oid_to_hex(&split_index->base_oid);
> -	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
> +	base_path = xstrfmt("%s/sharedindex.%s", repo->gitdir, base_oid_hex);
>  	trace2_region_enter_printf("index", "shared/do_read_index",
>  				   the_repository, "%s", base_path);

"the_repository" here (and all others in this function) should be
replaced with "repo". The TODO comment in this function should be
removed as well.

>  	ret = do_read_index(split_index->base, base_path, 1);
> diff --git a/revision.c b/revision.c
> index eb8e51bc63..247a4d5704 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1556,7 +1556,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
>  
>  		if (read_index_from(&istate,
>  				    worktree_git_path(wt, "index"),
> -				    get_worktree_git_dir(wt)) > 0)
> +				    get_worktree_git_dir(wt), the_repository) > 0)

We have revs->repo to refer to the main repo being examined here. But
if the "gitdir" argument is deleted, then revs->repo->gitdir gives a
_wrong_ gitdir, it's not the same as get_worktree_git_dir(wt).

So before you can continue here, you'll need to add a function,
e.g. repo_worktree_init() (similar to repo_init() and
repo_submodule_init()). This one should take "struct worktree *" as
the argument and return "struct repository *"

So, with something like a patch below (not tested), you should be able
to write

	worktrees = repo_get_worktrees(revs->repo, 0);
	...
		struct repository *r = repo_worktree_init(wt);
		if (read_index_from(&istate, r->index_file, r) > 0)
			do_add_index_objects_to_pending(revs, &istate, flags);
		repo_clear(r);

-- 8< --
diff --git a/repository.c b/repository.c
index 682c239fe3..5a0c7972db 100644
--- a/repository.c
+++ b/repository.c
@@ -10,6 +10,7 @@
 #include "object.h"
 #include "lockfile.h"
 #include "submodule-config.h"
+#include "worktree.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -227,6 +228,28 @@ int repo_submodule_init(struct repository *subrepo,
 	return ret;
 }
 
+int repo_worktree_init(struct repository *repo,
+		       struct repository *source_repo,
+		       const struct worktree *wt)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+	int ret;
+
+	if (!wt)
+		return -1;
+
+	if (!wt->id)
+		strbuf_addstr(&gitdir, source_repo->commondir);
+	else
+		strbuf_addf(&gitdir, "%s/worktrees/%s",
+			    source_repo->commondir,
+			    wt->id);
+
+	ret = repo_init(source_repo, gitdir.buf, wt->path);
+	strbuf_release(&gitdir);
+	return ret ? -1 : 0;
+}
+
 void repo_clear(struct repository *repo)
 {
 	FREE_AND_NULL(repo->gitdir);
diff --git a/repository.h b/repository.h
index 4fb6a5885f..d3c21c7ab5 100644
--- a/repository.h
+++ b/repository.h
@@ -122,6 +122,10 @@ void repo_set_hash_algo(struct repository *repo, int algo);
 void initialize_the_repository(void);
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
 
+struct worktree;
+int repo_worktree_init(struct repository *r, struct repository *source,
+		       const struct worktree *wt);
+
 /*
  * Initialize the repository 'subrepo' as the submodule given by the
  * struct submodule 'sub' in parent repository 'superproject'.
diff --git a/worktree.c b/worktree.c
index b45bfeb9d3..188ea04c61 100644
--- a/worktree.c
+++ b/worktree.c
@@ -44,19 +44,19 @@ static void add_head_info(struct worktree *wt)
 /**
  * get the main worktree
  */
-static struct worktree *get_main_worktree(void)
+static struct worktree *get_main_worktree(struct repository *r)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
 	int is_bare = 0;
 
-	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
+	strbuf_add_absolute_path(&worktree_path, r->commondir);
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+	strbuf_addf(&path, "%s/HEAD", r->commondir);
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
@@ -68,7 +68,7 @@ static struct worktree *get_main_worktree(void)
 	return worktree;
 }
 
-static struct worktree *get_linked_worktree(const char *id)
+static struct worktree *get_linked_worktree(struct repository *r, const char *id)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -77,7 +77,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_git_common_path(&path, the_repository, "worktrees/%s/gitdir", id);
+	strbuf_git_common_path(&path, r, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
@@ -90,7 +90,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	}
 
 	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+	strbuf_addf(&path, "%s/worktrees/%s/HEAD", r->commondir, id);
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
@@ -127,7 +127,7 @@ static int compare_worktree(const void *a_, const void *b_)
 	return fspathcmp((*a)->path, (*b)->path);
 }
 
-struct worktree **get_worktrees(unsigned flags)
+struct worktree **repo_get_worktrees(struct repository *r, unsigned flags)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -137,9 +137,9 @@ struct worktree **get_worktrees(unsigned flags)
 
 	ALLOC_ARRAY(list, alloc);
 
-	list[counter++] = get_main_worktree();
+	list[counter++] = get_main_worktree(r);
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", r->commondir);
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -148,7 +148,7 @@ struct worktree **get_worktrees(unsigned flags)
 			if (is_dot_or_dotdot(d->d_name))
 				continue;
 
-			if ((linked = get_linked_worktree(d->d_name))) {
+			if ((linked = get_linked_worktree(r, d->d_name))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] = linked;
 			}
diff --git a/worktree.h b/worktree.h
index 9e3b0b7b6f..cb4307db16 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,7 +30,8 @@ struct worktree {
  * The caller is responsible for freeing the memory from the returned
  * worktree(s).
  */
-extern struct worktree **get_worktrees(unsigned flags);
+struct worktree **repo_get_worktrees(struct repository *r, unsigned flags);
+#define get_worktrees(flags) repo_get_worktrees(the_repository, flags)
 
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
-- 8< --



>  			do_add_index_objects_to_pending(revs, &istate, flags);
>  		discard_index(&istate);
>  	}
> -- 
> 2.20.1
> 
