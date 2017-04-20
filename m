Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3D6207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 09:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943919AbdDTJgo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 05:36:44 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49471 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S943758AbdDTJgj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Apr 2017 05:36:39 -0400
X-AuditID: 12074411-4bfff700000005a9-71-58f88124e533
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A9.03.01449.42188F85; Thu, 20 Apr 2017 05:36:36 -0400 (EDT)
Received: from [192.168.69.190] (p5790749A.dip0.t-ipconnect.de [87.144.116.154])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3K9aXlb022539
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 20 Apr 2017 05:36:34 -0400
Subject: Re: [PATCH v10 4/5] dir_iterator: rewrite state machine model
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
 <1492607652-36341-5-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e1ccebfd-d85b-25a6-1f36-13d1c7f566cd@alum.mit.edu>
Date:   Thu, 20 Apr 2017 11:36:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1492607652-36341-5-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqKvS+CPC4ONSDYvHn96yWXRd6Way
        aOi9wmzRPeUto8Xmze0sDqweO2fdZfdYsKnU4+IlZY/Pm+QCWKK4bFJSczLLUov07RK4Mtbf
        OsdSsH0zY0XP7gtsDYx7uxm7GDk5JARMJG6v/AFkc3EICexgkng6azcThHOBSeLvlKMsXYwc
        HMICbhJrp8aBmCIC1hLX13iB9AoJlEv0ve5lBrGZBWwkjjf1gs1kE9CVWNTTzARi8wrYSxyY
        eQIsziKgKrHj/ixWEFtUIERizsIHjBA1ghInZz5hAbE5BRwlDp6cxwQxU09ix/VfrBC2vMT2
        t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5i
        hISv4A7GGSflDjEKcDAq8fBGpn2PEGJNLCuuzD3EKMnBpCTK+9H1R4QQX1J+SmVGYnFGfFFp
        TmrxIUYJDmYlEV7FcqAcb0piZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mC
        t6ABqFGwKDU9tSItM6cEIc3EwQkynAdo+ESQGt7igsTc4sx0iPwpRkUpcd5n9UAJAZBERmke
        XC8svbxiFAd6RZh3H0gVDzA1wXW/AhrMBDT4rB/Y4JJEhJRUAyPzicx9n9599zkaX63YP+FE
        TszT1Xwyl7d+2Mw79++KiR7aPqvEX7ukWizPCOD+djXN4c78Xku2nUWVjP1vDc6emrQ10Udl
        6c7JKksbt2dmiHlkHPh++u1ujm37e6dV33mwSan9n+Tp+731nnZ7VfRPcj4xylgw8X/Meo3q
        Ou+G27pvihQj9j9SYinOSDTUYi4qTgQArRpiWQoDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 03:14 PM, Daniel Ferreira wrote:
> Perform a rewrite of dir_iterator_advance(). dir_iterator has
> ceased to rely on a combination of level.initialized and level.dir_state
> state variables and now only tracks the state with level.dir_state,
> which simplifies the iterator mechanism, makes the code easier to follow
> and eases additions of new features to the iterator.
> 
> Make dir_iterator_begin() attempt to lstat() the path it receives, and
> return NULL and an appropriate errno if it fails or if the passed path
> was not a directory.
> 
> Create an option for the dir_iterator API to iterate over subdirectories
> only after having iterated through their contents. This feature was
> predicted, although not implemented by 0fe5043 ("dir_iterator: new API
> for iterating over a directory tree", 2016-06-18). This is useful for
> recursively removing a directory and calling rmdir() on a directory only
> after all of its contents have been wiped.
> 
> Add an option for dir_iterator to also iterate over the initial
> directory (the one passed to dir_iterator_begin()).
> 
> Add the "flags" parameter to dir_iterator_create, allowing for the
> aforementioned new features to be enabled. The new default behavior
> (i.e. flags set to 0) does not iterate over directories. Flag
> DIR_ITERATOR_PRE_ORDER_TRAVERSAL iterates over a directory before doing
> so over its contents. DIR_ITERATOR_POST_ORDER_TRAVERSAL iterates over a
> directory after doing so over its contents. DIR_ITERATOR_LIST_ROOT_DIR
> iterates over the initial directory. These flags do not conflict with
> each other and may be used simultaneously.
> 
> Amend a call to dir_iterator_begin() in refs/files-backend.c to pass
> the flags parameter introduced, as well as handle the case in which it
> fails to open the directory.
> 
> Improve t/t0065-dir-iterator.sh and t/helper/test-dir-iterator.c to
> test "post-order" and "iterate-over-root" modes.
> 
> Michael Haggerty contributed with the design of the new
> dir_iterator_advance() implementation, the code for
> t/helper/test-dir-iterator's option parser and numerous reviews that
> gradually shaped this code to its current form.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  dir-iterator.c               | 220 ++++++++++++++++++++++++++++++-------------
>  dir-iterator.h               |  35 +++++--
>  refs/files-backend.c         |  51 ++++++----
>  t/helper/test-dir-iterator.c |  31 +++++-
>  t/t0065-dir-iterator.sh      |  94 ++++++++++++++----
>  5 files changed, 316 insertions(+), 115 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index d168cb2..3c20e0e 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -4,8 +4,6 @@
>  #include "dir-iterator.h"
>  
>  struct dir_iterator_level {
> -	int initialized;
> -
>  	DIR *dir;
>  
>  	/*
> @@ -20,9 +18,15 @@ struct dir_iterator_level {
>  	 * iteration and also iterated into):
>  	 */
>  	enum {
> -		DIR_STATE_ITER,
> -		DIR_STATE_RECURSE
> +		DIR_STATE_PUSHED,
> +		DIR_STATE_PRE_ITERATION,
> +		DIR_STATE_ITERATING,
> +		DIR_STATE_POST_ITERATION,
> +		DIR_STATE_EXHAUSTED
>  	} dir_state;
> +
> +	/* The stat structure for the directory this level represents. */
> +	struct stat st;
>  };
>  
>  /*
> @@ -48,15 +52,23 @@ struct dir_iterator_int {
>  	 * that will be included in this iteration.
>  	 */
>  	struct dir_iterator_level *levels;
> +
> +	/* Holds the flags passed to dir_iterator_begin(). */
> +	unsigned flags;
>  };
>  
> -static void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
> +static void push_dir_level(struct dir_iterator_int *iter, struct stat *st)
>  {
> -	level->dir_state = DIR_STATE_RECURSE;
> +	struct dir_iterator_level *level;
> +
>  	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
>  		   iter->levels_alloc);
> +
> +	/* Push a new level */
>  	level = &iter->levels[iter->levels_nr++];
> -	level->initialized = 0;
> +	level->dir = NULL;
> +	level->dir_state = DIR_STATE_PUSHED;
> +	level->st = *st;
>  }
>  
>  static int pop_dir_level(struct dir_iterator_int *iter)
> @@ -67,7 +79,11 @@ static int pop_dir_level(struct dir_iterator_int *iter)
>  static int adjust_iterator_data(struct dir_iterator_int *iter,
>  		struct dir_iterator_level *level)
>  {
> -	if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
> +	char *last_path_component;
> +
> +	if (level->dir_state != DIR_STATE_ITERATING) {
> +		iter->base.st = level->st;
> +	} else if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
>  		if (errno != ENOENT)
>  			warning("error reading path '%s': %s",
>  				iter->base.path.buf,
> @@ -76,18 +92,48 @@ static int adjust_iterator_data(struct dir_iterator_int *iter,
>  	}
>  
>  	/*
> -	 * We have to set these each time because
> -	 * the path strbuf might have been realloc()ed.
> +	 * Check if we are dealing with the root directory as an
> +	 * item that's being iterated through.
>  	 */
> -	iter->base.relative_path =
> -		iter->base.path.buf + iter->levels[0].prefix_len;
> -	iter->base.basename =
> -		iter->base.path.buf + level->prefix_len;
> -	level->dir_state = DIR_STATE_ITER;
> +	if (level->dir_state != DIR_STATE_ITERATING &&
> +		iter->levels_nr == 1) {
> +		iter->base.relative_path = ".";
> +
> +		/*
> +		 * If we have a path like './dir', we'll get everything
> +		 * after the last slash a basename. If we don't find a
> +		 * slash (e.g. 'dir'), we return the whole path.
> +		 */
> +		last_path_component = strrchr(iter->base.path.buf, '/');
> +		iter->base.basename = last_path_component ?
> +			last_path_component + 1 : iter->base.path.buf;

There's kindof a lot of awkward code here that is only needed to support
`DIR_ITERATOR_LIST_ROOT_DIR`. And the basename for the top-level
directory is often not useful. For example, if the starting path is ".."
or "foo/.." or "bar/.", then its basename is set to ".." or ".". It
would be really awkward to find the real basename of such arguments.

This might be the code trying to tell us something. Maybe
`DIR_ITERATOR_LIST_ROOT_DIR` isn't worth it as a feature. When I tried
ripping it out, I saved 40 LOC in `dir_iterator`, at a cost of only two
extra lines in `entry.c`.

Alternatively (given that the basename isn't really useful for the
top-level path), I think it would be acceptable to just set basename to
NULL for the case of the top-level directory (and document that
peculiarity).

> +	} else {
> +		iter->base.relative_path =
> +			iter->base.path.buf + iter->levels[0].prefix_len;
> +
> +		if (S_ISDIR(iter->base.st.st_mode))
> +			iter->base.basename =
> +				iter->base.path.buf + iter->levels[iter->levels_nr - 2].prefix_len;
> +		else
> +			iter->base.basename =
> +				iter->base.path.buf + level->prefix_len;
> +	}
>  
>  	return 0;
>  }
>  
> +/*
> + * This function uses a state machine with the following states:
> + * * DIR_STATE_PUSHED: the directory has been pushed to the
> + * iterator traversal tree.
> + * * DIR_STATE_PRE_ITERATION: the directory is not opened with opendir(). The
> + * dirpath has already been returned if pre-order traversal is set.
> + * * DIR_STATE_ITERATING: the directory is initialized. We are traversing
> + * through it.
> + * * DIR_STATE_POST_ITERATION: the directory has been iterated through.
> + * We are ready to close it.
> + * * DIR_STATE_EXHAUSTED: the directory is closed and ready to be popped.
> + */

A little indentation would make the bulleted list above a lot easier to
read. And it is more common to use "-" for bullets, I guess because they
don't clash so much with the "*" that are part of the comment prefix:

 +/*
 + * This function uses a state machine with the following states:
 + * - DIR_STATE_PUSHED: the directory has been pushed to the
 + *   iterator traversal tree.
 + * - DIR_STATE_PRE_ITERATION: the directory is not opened with
opendir(). The
 + *   dirpath has already been returned if pre-order traversal is set.
 + * - DIR_STATE_ITERATING: the directory is initialized. We are traversing
 + *   through it.
 + * - DIR_STATE_POST_ITERATION: the directory has been iterated through.
 + *   We are ready to close it.
 + * - DIR_STATE_EXHAUSTED: the directory is closed and ready to be popped.
 + */


>  int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  {
>  	struct dir_iterator_int *iter =
> @@ -96,9 +142,26 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  	while (1) {
>  		struct dir_iterator_level *level =
>  			&iter->levels[iter->levels_nr - 1];
> -		struct dirent *de;
>  
> -		if (!level->initialized) {
> +		if (level->dir_state == DIR_STATE_PUSHED) {
> +			level->dir_state = DIR_STATE_PRE_ITERATION;
> +
> +			/* We may not want the root directory to be iterated over */
> +			if ((iter->flags & DIR_ITERATOR_PRE_ORDER_TRAVERSAL) && (
> +				iter->levels_nr != 1 ||
> +				(iter->flags & DIR_ITERATOR_LIST_ROOT_DIR))) {
> +				/*
> +				 * This will only error if we fail to lstat() the
> +				 * root directory. In this case, we bail.
> +				 */
> +				if (adjust_iterator_data(iter, level)) {
> +					level->dir_state = DIR_STATE_EXHAUSTED;
> +					continue;
> +				}
> +
> +				return ITER_OK;
> +			}
> +		} else if (level->dir_state == DIR_STATE_PRE_ITERATION) {
>  			/*
>  			 * Note: dir_iterator_begin() ensures that
>  			 * path is not the empty string.
> @@ -108,64 +171,37 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			level->prefix_len = iter->base.path.len;
>  
>  			level->dir = opendir(iter->base.path.buf);
> -			if (!level->dir && errno != ENOENT) {
> -				warning("error opening directory %s: %s",
> -					iter->base.path.buf, strerror(errno));
> -				/* Popping the level is handled below */
> -			}
> -
> -			level->initialized = 1;
> -		} else if (S_ISDIR(iter->base.st.st_mode)) {
> -			if (level->dir_state == DIR_STATE_ITER) {
> +			if (!level->dir) {
>  				/*
> -				 * The directory was just iterated
> -				 * over; now prepare to iterate into
> -				 * it.
> +				 * This level wasn't opened sucessfully; pretend we
> +				 * iterated through it already.
>  				 */
> -				push_dir_level(iter, level);
> +				if (errno != ENOENT) {

We usually don't use braces for blocks consisting of a single statement.

> +					warning("error opening directory %s: %s",
> +						iter->base.path.buf, strerror(errno));
> +				}
> +
> +				level->dir_state = DIR_STATE_POST_ITERATION;
>  				continue;
> -			} else {
> -				/*
> -				 * The directory has already been
> -				 * iterated over and iterated into;
> -				 * we're done with it.
> -				 */
>  			}
> -		}
>  
> -		if (!level->dir) {
> -			/*
> -			 * This level is exhausted (or wasn't opened
> -			 * successfully); pop up a level.
> -			 */
> -			if (pop_dir_level(iter) == 0)
> -				return dir_iterator_abort(dir_iterator);
> +			level->dir_state = DIR_STATE_ITERATING;
> +		} else if (level->dir_state == DIR_STATE_ITERATING) {
> +			struct dirent *de;
>  
> -			continue;
> -		}
> -
> -		/*
> -		 * Loop until we find an entry that we can give back
> -		 * to the caller:
> -		 */
> -		while (1) {
>  			strbuf_setlen(&iter->base.path, level->prefix_len);
>  			errno = 0;
>  			de = readdir(level->dir);
>  
>  			if (!de) {
> -				/* This level is exhausted; pop up a level. */
> +				/* In case of readdir() error */
>  				if (errno) {
>  					warning("error reading directory %s: %s",
>  						iter->base.path.buf, strerror(errno));
> -				} else if (closedir(level->dir))
> -					warning("error closing directory %s: %s",
> -						iter->base.path.buf, strerror(errno));
> +				}
>  
> -				level->dir = NULL;
> -				if (pop_dir_level(iter) == 0)
> -					return dir_iterator_abort(dir_iterator);
> -				break;
> +				level->dir_state = DIR_STATE_POST_ITERATION;
> +				continue;
>  			}
>  
>  			if (is_dot_or_dotdot(de->d_name))
> @@ -176,7 +212,41 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			if (adjust_iterator_data(iter, level))
>  				continue;
>  
> +			if (S_ISDIR(iter->base.st.st_mode)) {
> +				push_dir_level(iter, &iter->base.st);
> +				continue;
> +			}
> +
>  			return ITER_OK;
> +		} else if (level->dir_state == DIR_STATE_POST_ITERATION) {
> +			if (level->dir != NULL && closedir(level->dir)) {
> +				warning("error closing directory %s: %s",
> +					iter->base.path.buf, strerror(errno));
> +			}

The `closedir()` will only be attempted if we arrived at
`DIR_STATE_POST_ITERATION` state from the `DIR_STATE_ITERATING` branch,
right? So why not call `closedir()` up there? Then you wouldn't need the
`level->dir != NULL` check (which, by the way, we spell `if
(level->dir)`; the `!= NULL` is redundant).

> +			level->dir_state = DIR_STATE_EXHAUSTED;
> +
> +			strbuf_setlen(&iter->base.path, level->prefix_len);
> +			/*
> +			 * Since we are iterating through the dirpath
> +			 * after we have gone through it, we still need
> +			 * to get rid of the trailing slash we appended.
> +			 */
> +			strbuf_strip_suffix(&iter->base.path, "/");
> +
> +			/* We may not want the root directory to be iterated over */
> +			if ((iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL) && (
> +				iter->levels_nr != 1 ||
> +				(iter->flags & DIR_ITERATOR_LIST_ROOT_DIR))) {
> +				/*
> +				 * In this state, adjust_iterator_data() should never return
> +				 * an error.
> +				 */
> +				adjust_iterator_data(iter, level);
> +				return ITER_OK;
> +			}
> +		} else if (level->dir_state == DIR_STATE_EXHAUSTED) {
> +			if (pop_dir_level(iter) == 0)
> +				return dir_iterator_abort(dir_iterator);
>  		}
>  	}
>  }
> @@ -202,21 +272,41 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	return ITER_DONE;
>  }
>  
> -struct dir_iterator *dir_iterator_begin(const char *path)
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
>  {
> -	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
> -	struct dir_iterator *dir_iterator = &iter->base;
> +	struct dir_iterator_int *iter;
> +	struct dir_iterator *dir_iterator;
> +	struct stat st;
>  
>  	if (!path || !*path)
>  		die("BUG: empty path passed to dir_iterator_begin()");
>  
> +	if (lstat(path, &st) < 0) {
> +		if (errno != ENOENT)
> +			warning("error reading path '%s': %s",
> +					path, strerror(errno));

In a case like this, where we are providing an `errno` to the caller, it
is probably better to leave it to the caller to emit a warning/error if
it wants. The caller will have more context and so will be able to
explain the error in a way that the user can better understand. And some
callers might not want to emit an error at all, or base their decision
on `errno`.

(The story is different *during* the iteration, because we currently
don't have a way to return an error to the caller short of aborting the
whole iteration.)

> +		return NULL;
> +	}
> +
> +	if (!S_ISDIR(st.st_mode)) {
> +		errno = ENOTDIR;
> +		return NULL;
> +	}
> +
> +	iter = xcalloc(1, sizeof(*iter));
> +	dir_iterator = &iter->base;
> +
> +	iter->flags = flags;
> +	dir_iterator->st = st;
> +
>  	strbuf_init(&iter->base.path, PATH_MAX);
>  	strbuf_addstr(&iter->base.path, path);
>  
>  	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
> +	iter->levels_nr = 0;
>  
> -	iter->levels_nr = 1;
> -	iter->levels[0].initialized = 0;
> +	push_dir_level(iter, &dir_iterator->st);
>  
>  	return dir_iterator;
>  }
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 27739e6..a21e845 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -5,19 +5,17 @@
>   * Iterate over a directory tree.
>   *
>   * Iterate over a directory tree, recursively, including paths of all
> - * types and hidden paths. Skip "." and ".." entries and don't follow
> - * symlinks except for the original path.
> + * types and hidden paths. Skip "." and ".." entries.
>   *
>   * Every time dir_iterator_advance() is called, update the members of
>   * the dir_iterator structure to reflect the next path in the
>   * iteration. The order that paths are iterated over within a
> - * directory is undefined, but directory paths are always iterated
> - * over before the subdirectory contents.
> + * directory is undefined.
>   *
>   * A typical iteration looks like this:
>   *
>   *     int ok;
> - *     struct iterator *iter = dir_iterator_begin(path);
> + *     struct iterator *iter = dir_iterator_begin(path, flags);
>   *
>   *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
>   *             if (want_to_stop_iteration()) {
> @@ -38,6 +36,26 @@
>   * dir_iterator_advance() again.
>   */
>  
> +/*
> + * Possible flags for dir_iterator_begin().
> + *
> + * * DIR_ITERATOR_PRE_ORDER_TRAVERSAL: the iterator shall return
> + * a dirpath it has found before iterating through that directory's
> + * contents.
> + * * DIR_ITERATOR_POST_ORDER_TRAVERSAL: the iterator shall return
> + * a dirpath it has found after iterating through that directory's
> + * contents.
> + * * DIR_ITERATOR_LIST_ROOT_DIR: the iterator shall return the dirpath
> + * of the root directory it is iterating through if either
> + * DIR_ITERATOR_PRE_ORDER_TRAVERSAL or DIR_ITERATOR_POST_ORDER_TRAVERSAL
> + * is set.
> + *
> + * All flags can be used in any combination.
> + */

Please indent this bulleted list, too.

> +#define DIR_ITERATOR_PRE_ORDER_TRAVERSAL (1 << 0)
> +#define DIR_ITERATOR_POST_ORDER_TRAVERSAL (1 << 1)
> +#define DIR_ITERATOR_LIST_ROOT_DIR (1 << 2)
> +
>  struct dir_iterator {
>  	/* The current path: */
>  	struct strbuf path;
> @@ -57,15 +75,16 @@ struct dir_iterator {
>  };
>  
>  /*
> - * Start a directory iteration over path. Return a dir_iterator that
> - * holds the internal state of the iteration.
> + * Start a directory iteration over path, with options specified in
> + * 'flags'. Return a dir_iterator that holds the internal state of
> + * the iteration.
>   *
>   * The iteration includes all paths under path, not including path
>   * itself and not including "." or ".." entries.
>   *
>   * path is the starting directory. An internal copy will be made.
>   */
> -struct dir_iterator *dir_iterator_begin(const char *path);
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags);
>  
>  /*
>   * Advance the iterator to the first or next item and return ITER_OK.
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 50188e9..d376e1f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3284,29 +3284,42 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
>  	struct dir_iterator *diter = iter->dir_iterator;
>  	int ok;
>  
> -	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
> -		int flags;
> -
> -		if (!S_ISREG(diter->st.st_mode))
> -			continue;
> -		if (diter->basename[0] == '.')
> -			continue;
> -		if (ends_with(diter->basename, ".lock"))
> -			continue;
> +	if (!iter->dir_iterator) {
> +		/*
> +		 * If our dir_iterator is NULL at this stage, it means we failed
> +		 * to open the given path at dir_iterator_begin(), most likely due
> +		 * to it not existing.
> +		 *
> +		 * In this case, we pretend it was an empty directory and just
> +		 * iterate through nothing.
> +		 */
> +		ok = ITER_DONE;
> +	} else {
> +		while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
> +			int flags;
> +
> +			if (!S_ISREG(diter->st.st_mode))
> +				continue;
> +			if (diter->basename[0] == '.')
> +				continue;
> +			if (ends_with(diter->basename, ".lock"))
> +				continue;
> +
> +			if (read_ref_full(diter->relative_path, 0,
> +					  iter->oid.hash, &flags)) {
> +				error("bad ref for %s", diter->path.buf);
> +				continue;
> +			}
>  
> -		if (read_ref_full(diter->relative_path, 0,
> -				  iter->oid.hash, &flags)) {
> -			error("bad ref for %s", diter->path.buf);
> -			continue;
> +			iter->base.refname = diter->relative_path;
> +			iter->base.oid = &iter->oid;
> +			iter->base.flags = flags;
> +			return ITER_OK;
>  		}
>  
> -		iter->base.refname = diter->relative_path;
> -		iter->base.oid = &iter->oid;
> -		iter->base.flags = flags;
> -		return ITER_OK;
> +		iter->dir_iterator = NULL;
>  	}
>  
> -	iter->dir_iterator = NULL;
>  	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
>  		ok = ITER_ERROR;
>  	return ok;
> @@ -3346,7 +3359,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
>  	files_downcast(ref_store, 0, "reflog_iterator_begin");
>  
>  	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
> -	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
> +	iter->dir_iterator = dir_iterator_begin(git_path("logs"), 0);

An easier way to deal with an error here would be to free `iter` (or not
allocate it in the first place) and return `empty_ref_iterator_begin()`
instead.

>  	return ref_iterator;
>  }
>  
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index a7d1470..3b4948b 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -5,15 +5,38 @@
>  
>  int cmd_main(int argc, const char **argv)
>  {
> +	const char **myargv = argv;
> +	int myargc = argc;
> +
>  	struct strbuf path = STRBUF_INIT;
>  	struct dir_iterator *diter;
>  
> -	if (argc < 2)
> -		die("BUG: test-dir-iterator needs one argument");
> +	unsigned flag = 0;
> +
> +	while (--myargc && starts_with(*++myargv, "--")) {
> +		if (!strcmp(*myargv, "--pre-order"))
> +			flag |= DIR_ITERATOR_PRE_ORDER_TRAVERSAL;
> +		else if (!strcmp(*myargv, "--post-order"))
> +			flag |= DIR_ITERATOR_POST_ORDER_TRAVERSAL;
> +		else if (!strcmp(*myargv, "--list-root-dir"))
> +			flag |= DIR_ITERATOR_LIST_ROOT_DIR;
> +		else if (!strcmp(*myargv, "--")) {
> +			myargc--;
> +			myargv++;
> +			break;
> +		} else
> +			die("Unrecognized option: %s", *myargv);
> +	}
>  
> -	strbuf_add(&path, argv[1], strlen(argv[1]));
> +	if (myargc != 1)
> +		die("expected exactly one non-option argument");
> +	strbuf_addstr(&path, *myargv);
>  
> -	diter = dir_iterator_begin(path.buf);
> +	diter = dir_iterator_begin(path.buf, flag);
> +	if (diter == NULL) {
> +		printf("begin failed: %d\n", errno);

It would be more helpful to include `strerror(errno)` rather than
`errno` itself in the error output.

> +		return 0;
> +	}
>  
>  	while (dir_iterator_advance(diter) == ITER_OK) {
>  		if (S_ISDIR(diter->st.st_mode))
> diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
> [...]


