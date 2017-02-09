Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED541FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 06:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdBIGHw (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 01:07:52 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61059 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751601AbdBIGHu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 01:07:50 -0500
X-AuditID: 12074414-78bff70000004a85-55-589c072d550a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 78.9D.19077.D270C985; Thu,  9 Feb 2017 01:07:42 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1967dXM003748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 01:07:40 -0500
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs
 from another worktree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170208113144.8201-3-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu>
Date:   Thu, 9 Feb 2017 07:07:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170208113144.8201-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqKvHPifC4N5uVouuK91MFg29V5gt
        uqe8ZXRg9tg56y67x8VLyh6fN8kFMEdx2aSk5mSWpRbp2yVwZfw5/palYElYRcujKawNjCtc
        uhg5OSQETCTO9d5g7WLk4hASuMwo8eTWZkYI5zyTxMvdd9hAqoQFkiXerbzOCmKLCKRJLJ78
        nhnEFhJIlGjYd4YRxGYWUJNo3zQFrIZNQFdiUU8zE4jNK2Av0XvxLNgcFgEViV+/HrGD2KIC
        IRJzFj5ghKgRlDg58wkLiM0pYCYx60MbK8RMdYk/8y4xQ9jyEs1bZzNPYOSfhaRlFpKyWUjK
        FjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3StdDLzSzRS00p3cQICVGRHYxHTsodYhTgYFTi
        4a2wnB0hxJpYVlyZe4hRkoNJSZQ34j9QiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvMqY5EUK8
        KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8rGxAjYJFqempFWmZOSUI
        aSYOTpDhPEDDH7CADC8uSMwtzkyHyJ9iNOY4deP0SyaObe+vvGQSYsnLz0uVEuddywpUKgBS
        mlGaBzcNlmZeMYoDPSfMqwuylAeYouDmvQJaxQS06vrpWSCrShIRUlINjEatrmdmdkWYtPbM
        il2fN8EizfNx1s2uuezHjjPfdUhM0X24WazQ7Pv5qM033ntOrmLOnlavurfE6+Kvw7y9K6qX
        ZmWGCXSeXjlv623Zo7lvg8yu5ChMl20uW7KZ9/Prr0s3T5lpbfRg2tknwdPTWGftzHLdofJL
        1usWs3zIpCOLMtbs7Z5/KFCJpTgj0VCLuag4EQBCSFL9DgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08/2017 12:31 PM, Nguyễn Thái Ngọc Duy wrote:
> The patch itself is relatively simple: manual parsing code is replaced
> with a call to resolve_ref_submodule(). The manual parsing code must die
> because only refs/files-backend.c should do that. Why submodule here is
> a more interesting question.
> 
> From an outside look, any .git/worktrees/foo is seen as a "normal"
> repository. You can set GIT_DIR to it and have access to everything,
> even shared things that are not literally inside that directory, like
> object db or shared refs.
> 
> On top of that, linked worktrees point to those directories with ".git"
> files. These two make a linked worktree's path "X" a "submodule" (*) (**)
> because X/.git is a file that points to a repository somewhere.
> 
> As such, we can just linked worktree's path as a submodule. We just need
> to make sure they are unique because they are used to lookup submodule
> refs store.
> 
> Main worktree is a a bit trickier. If we stand at a linked worktree, we
> may still need to peek into main worktree's HEAD, for example. We can
> treat main worktree's path as submodule as well since git_path_submodule()
> can tolerate ".git" dirs, in addition to ".git" files.
> 
> The constraint is, if main worktree is X, then the git repo must be at
> X/.git. If the user separates .git repo far away and tell git to point
> to it via GIT_DIR or something else, then the "main worktree as submodule"
> trick fails. Within multiple worktree context, I think we can limit
> support to "standard" layout, at least for now.
> 
> (*) The differences in sharing object database and refs between
> submodules and linked worktrees don't really matter in this context.
> 
> (**) At this point, we may want to rename refs *_submodule API to
> something more neutral, maybe s/_submodule/_remote/

It is unquestionably a good goal to avoid parsing references outside of
`refs/files-backend.c`. But I'm not a fan of this approach.

There are two meanings of the concept of a "ref store", and I think this
change muddles them:

1. The references that happen to be *physically* stored in a particular
   location, for example the `refs/bisect/*` references in a worktree.

2. The references that *logically* should be considered part of a
   particular repository. This might require stitching together
   references from multiple sources, for example `HEAD` and
   `refs/bisect` from a worktree's own directory with other
   references from the main repository.

Either of these concepts can be implemented via the `ref_store` abstraction.

The `ref_store` for a submodule should represent the references
logically visible from the submodule. The main program shouldn't care
whether the references are stored in a single physical location or
spread across multiple locations (for example, if the submodule were
itself a linked worktree).

The `ref_store` that you want here for a worktree is not the worktree's
*logical* `ref_store`. You want the worktree's *physical* `ref_store`.
Mixing logical and physical reference stores together is a bad idea
(even if we were willing to ignore the fact that worktrees are not
submodules in the accepted sense of the word).

The point of my `submodule-hash` branch [1] was to separate these
concepts better by breaking the current 1:1 connection between
`ref_store`s and submodules. This would allow `ref_store`s to be created
for other purposes, such as to represent worktree refs. If you want the
*logical* `ref_store` for a submodule, you access it through the
`submodule_ref_stores` table. If you want the *physical* `ref_store` for
a worktree, you should access it through a different table.

I think the best solution would be to expose the concept of `ref_store`
in the public refs API. Then users of submodules would essentially do

    struct ref_store *refs = get_submodule_refs(submodule_path);
    ... resolve_ref_recursively(refs, refname, 0, sha1, &flags) ...
    ... for_each_ref(refs, fn, cb_data) ...

whereas for a worktree you'd have to look up the `ref_store` instance
somewhere else (or maybe keep it as part of some worktree structure, if
there is one) but you would use it via the same API.

Michael

[1] https://github.com/mhagger/git

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  branch.c   |  3 +-
>  worktree.c | 99 +++++++++++++++-----------------------------------------------
>  worktree.h |  2 +-
>  3 files changed, 27 insertions(+), 77 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index b955d4f316..db5843718f 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -354,7 +354,8 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref)
>  	for (i = 0; worktrees[i]; i++) {
>  		if (worktrees[i]->is_detached)
>  			continue;
> -		if (strcmp(oldref, worktrees[i]->head_ref))
> +		if (worktrees[i]->head_ref &&
> +		    strcmp(oldref, worktrees[i]->head_ref))
>  			continue;
>  
>  		if (set_worktree_head_symref(get_worktree_git_dir(worktrees[i]),
> diff --git a/worktree.c b/worktree.c
> index d633761575..25e5bc9a3e 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -19,54 +19,24 @@ void free_worktrees(struct worktree **worktrees)
>  	free (worktrees);
>  }
>  
> -/*
> - * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
> - * set is_detached to 1 (0) if the ref is detached (is not detached).
> - *
> - * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
> - * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
> - * git_path). Parse the ref ourselves.
> - *
> - * return -1 if the ref is not a proper ref, 0 otherwise (success)
> - */
> -static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
> -{
> -	if (is_detached)
> -		*is_detached = 0;
> -	if (!strbuf_readlink(ref, path_to_ref, 0)) {
> -		/* HEAD is symbolic link */
> -		if (!starts_with(ref->buf, "refs/") ||
> -				check_refname_format(ref->buf, 0))
> -			return -1;
> -	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
> -		/* textual symref or detached */
> -		if (!starts_with(ref->buf, "ref:")) {
> -			if (is_detached)
> -				*is_detached = 1;
> -		} else {
> -			strbuf_remove(ref, 0, strlen("ref:"));
> -			strbuf_trim(ref);
> -			if (check_refname_format(ref->buf, 0))
> -				return -1;
> -		}
> -	} else
> -		return -1;
> -	return 0;
> -}
> -
>  /**
> - * Add the head_sha1 and head_ref (if not detached) to the given worktree
> + * Update head_sha1, head_ref and is_detached of the given worktree
>   */
> -static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
> +static void add_head_info(struct worktree *wt)
>  {
> -	if (head_ref->len) {
> -		if (worktree->is_detached) {
> -			get_sha1_hex(head_ref->buf, worktree->head_sha1);
> -		} else {
> -			resolve_ref_unsafe(head_ref->buf, 0, worktree->head_sha1, NULL);
> -			worktree->head_ref = strbuf_detach(head_ref, NULL);
> -		}
> -	}
> +	int flags;
> +	const char *target;
> +
> +	target = resolve_ref_submodule(wt->path, "HEAD",
> +				       RESOLVE_REF_READING,
> +				       wt->head_sha1, &flags);
> +	if (!target)
> +		return;
> +
> +	if (flags & REF_ISSYMREF)
> +		wt->head_ref = xstrdup(target);
> +	else
> +		wt->is_detached = 1;
>  }
>  
>  /**
> @@ -77,9 +47,7 @@ static struct worktree *get_main_worktree(void)
>  	struct worktree *worktree = NULL;
>  	struct strbuf path = STRBUF_INIT;
>  	struct strbuf worktree_path = STRBUF_INIT;
> -	struct strbuf head_ref = STRBUF_INIT;
>  	int is_bare = 0;
> -	int is_detached = 0;
>  
>  	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
>  	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> @@ -91,13 +59,10 @@ static struct worktree *get_main_worktree(void)
>  	worktree = xcalloc(1, sizeof(*worktree));
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
>  	worktree->is_bare = is_bare;
> -	worktree->is_detached = is_detached;
> -	if (!parse_ref(path.buf, &head_ref, &is_detached))
> -		add_head_info(&head_ref, worktree);
> +	add_head_info(worktree);
>  
>  	strbuf_release(&path);
>  	strbuf_release(&worktree_path);
> -	strbuf_release(&head_ref);
>  	return worktree;
>  }
>  
> @@ -106,8 +71,6 @@ static struct worktree *get_linked_worktree(const char *id)
>  	struct worktree *worktree = NULL;
>  	struct strbuf path = STRBUF_INIT;
>  	struct strbuf worktree_path = STRBUF_INIT;
> -	struct strbuf head_ref = STRBUF_INIT;
> -	int is_detached = 0;
>  
>  	if (!id)
>  		die("Missing linked worktree name");
> @@ -127,19 +90,14 @@ static struct worktree *get_linked_worktree(const char *id)
>  	strbuf_reset(&path);
>  	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
>  
> -	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
> -		goto done;
> -
>  	worktree = xcalloc(1, sizeof(*worktree));
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
>  	worktree->id = xstrdup(id);
> -	worktree->is_detached = is_detached;
> -	add_head_info(&head_ref, worktree);
> +	add_head_info(worktree);
>  
>  done:
>  	strbuf_release(&path);
>  	strbuf_release(&worktree_path);
> -	strbuf_release(&head_ref);
>  	return worktree;
>  }
>  
> @@ -334,8 +292,6 @@ const struct worktree *find_shared_symref(const char *symref,
>  					  const char *target)
>  {
>  	const struct worktree *existing = NULL;
> -	struct strbuf path = STRBUF_INIT;
> -	struct strbuf sb = STRBUF_INIT;
>  	static struct worktree **worktrees;
>  	int i = 0;
>  
> @@ -345,6 +301,10 @@ const struct worktree *find_shared_symref(const char *symref,
>  
>  	for (i = 0; worktrees[i]; i++) {
>  		struct worktree *wt = worktrees[i];
> +		const char *symref_target;
> +		unsigned char sha1[20];
> +		int flags;
> +
>  		if (wt->is_bare)
>  			continue;
>  
> @@ -359,25 +319,14 @@ const struct worktree *find_shared_symref(const char *symref,
>  			}
>  		}
>  
> -		strbuf_reset(&path);
> -		strbuf_reset(&sb);
> -		strbuf_addf(&path, "%s/%s",
> -			    get_worktree_git_dir(wt),
> -			    symref);
> -
> -		if (parse_ref(path.buf, &sb, NULL)) {
> -			continue;
> -		}
> -
> -		if (!strcmp(sb.buf, target)) {
> +		symref_target = resolve_ref_submodule(wt->path, symref, 0,
> +						      sha1, &flags);
> +		if ((flags & REF_ISSYMREF) && !strcmp(symref_target, target)) {
>  			existing = wt;
>  			break;
>  		}
>  	}
>  
> -	strbuf_release(&path);
> -	strbuf_release(&sb);
> -
>  	return existing;
>  }
>  
> diff --git a/worktree.h b/worktree.h
> index 6bfb985203..5ea5e503fb 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -4,7 +4,7 @@
>  struct worktree {
>  	char *path;
>  	char *id;
> -	char *head_ref;
> +	char *head_ref;		/* NULL if HEAD is broken or detached */
>  	char *lock_reason;	/* internal use */
>  	unsigned char head_sha1[20];
>  	int is_detached;
> 

