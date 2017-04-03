Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2124720966
	for <e@80x24.org>; Mon,  3 Apr 2017 03:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdDCDg6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 23:36:58 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50961 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751480AbdDCDg5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2017 23:36:57 -0400
X-AuditID: 1207440e-cb3ff7000000340b-54-58e1c355494d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 91.1B.13323.553C1E85; Sun,  2 Apr 2017 23:36:54 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDFF7F.dip0.t-ipconnect.de [79.237.255.127])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v333aohX017361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 2 Apr 2017 23:36:51 -0400
Subject: Re: [PATCH v7 4/5] dir_iterator: refactor state machine model
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
 <1491163388-41255-5-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <76c92397-8e15-b2fb-432f-0ae3d987ffa8@alum.mit.edu>
Date:   Mon, 3 Apr 2017 05:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1491163388-41255-5-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqBt2+GGEwa3juhaPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZayf
        OJOx4NcKxorbS+6wNzB+bGHsYuTkkBAwkfg+qYepi5GLQ0hgB5PE1iXdzBDOeSaJf2+62UGq
        hAXcJHY83s7axcjBISJgLXF9jRdIWEigXGJayx6wEmYBG4njTb1gQ9kEdCUW9TQzgdi8AvYS
        F9f2sYHYLAIqEp+2vwWLiwqESMxZ+IARokZQ4uTMJywgNqeAo8TBX7uYIGbqSey4/osVwpaX
        2P52DvMERv5ZSFpmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdY73czBK91JTS
        TYyQAObbwdi+XuYQowAHoxIPr4bzwwgh1sSy4srcQ4ySHExKorzfi+9FCPEl5adUZiQWZ8QX
        leakFh9ilOBgVhLhDT0IVM6bklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQ
        kuA9BdIoWJSanlqRlplTgpBm4uAEGc4DNNzwEMjw4oLE3OLMdIj8KUZFKXHeRyDNAiCJjNI8
        uF5YgnnFKA70ijBvPEg7DzA5wXW/AhrMBDTY4utdkMEliQgpqQZG5cqsK4UR19//U3Zddqy+
        cwX3jAudTaWtB11te+98bdnYO8l5ptCNQ6sOiT4vvL+O8Zn/q0jeFY3Kq7T112mcbj/KPqNF
        ZPOX+6/2uNYF7rKYeeLCvOW/XKUcRcuuBfpf8HxvlGcl82Qp87HHLT/qLhW1vNNbKqa0vp19
        corcx7Zne/NPSUzVUWIpzkg01GIuKk4EAPNAIjALAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02/2017 10:03 PM, Daniel Ferreira wrote:
> Perform major refactor of dir_iterator_advance(). dir_iterator has
> ceased to rely on a convoluted state machine mechanism of two loops and
> two state variables (level.initialized and level.dir_state). This serves
> to ease comprehension of the iterator mechanism and ease addition of new
> features to the iterator.
> 
> Create an option for the dir_iterator API to iterate over subdirectories
> only after having iterated through their contents. This feature was
> predicted, although not implemented by 0fe5043 ("dir_iterator: new API
> for iterating over a directory tree", 2016-06-18). This is useful for
> recursively removing a directory and calling rmdir() on a directory only
> after all of its contents have been wiped.
> 
> Add an option for the dir_iterator API to iterate over the root
> directory (the one it was initialized with) as well.
> 
> Add the "flags" parameter to dir_iterator_create, allowing for the
> aforementioned new features to be enabled. The new default behavior
> (i.e. flags set to 0) does not iterate over directories. Flag
> DIR_ITERATOR_PRE_ORDER_TRAVERSAL iterates over a directory before doing
> so over its contents. DIR_ITERATOR_POST_ORDER_TRAVERSAL iterates over a
> directory after doing so over its contents. DIR_ITERATOR_LIST_ROOT_DIR
> iterates over the root directory. These flags do not conflict with each
> other and may be used simultaneously.
> 
> Amend a call to dir_iterator_begin() in refs/files-backend.c to pass
> the flags parameter introduced.
> 
> Improve t/t0065-dir-iterator.sh and t/helper/test-dir-iterator.c to
> test "post-order" and "iterate-over-root" modes.

Nice. I think this version is a lot more understandable than the old
code. I also think it's getting very close to done.

> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  dir-iterator.c               | 155 +++++++++++++++++++++++++++----------------
>  dir-iterator.h               |  28 ++++++--
>  refs/files-backend.c         |   2 +-
>  t/helper/test-dir-iterator.c |   6 +-
>  t/t0065-dir-iterator.sh      |  61 ++++++++++++++++-
>  5 files changed, 183 insertions(+), 69 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index ce8bf81..18b7e68 100644
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
> @@ -20,8 +18,11 @@ struct dir_iterator_level {
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
>  };
>  
> @@ -48,15 +49,20 @@ struct dir_iterator_int {
>  	 * that will be included in this iteration.
>  	 */
>  	struct dir_iterator_level *levels;
> +
> +	/* Holds the flags passed to dir_iterator_begin(). */
> +	unsigned flags;
>  };
>  
>  static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
>  {
> -	level->dir_state = DIR_STATE_RECURSE;
>  	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
>  		   iter->levels_alloc);
> +
> +	/* Push a new level */
>  	level = &iter->levels[iter->levels_nr++];
> -	level->initialized = 0;
> +	level->dir = NULL;
> +	level->dir_state = DIR_STATE_PUSHED;
>  }
>  
>  static inline int pop_dir_level(struct dir_iterator_int *iter)
> @@ -75,18 +81,35 @@ static inline int set_iterator_data(struct dir_iterator_int *iter, struct dir_it
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
> +	if (level->dir_state != DIR_STATE_ITERATING &&
> +		iter->levels_nr == 1) {
> +		iter->base.relative_path = ".";

Doesn't `iter->base.basename` also need special handling in this case?

> +	}
> +	else {

The Git project standard is to including the `else` on the same line as
the curly brace ending the `if` block:

	} else {

> +		iter->base.relative_path =
> +			iter->base.path.buf + iter->levels[0].prefix_len;
> +	}
>  	iter->base.basename =
>  		iter->base.path.buf + level->prefix_len;
> -	level->dir_state = DIR_STATE_ITER;
>  
>  	return 0;
>  }
>  
> +/*
> + * This function uses a state machine with the following states:
> + * -> DIR_STATE_PUSHED: the directory has been pushed to the
> + * iterator traversal tree.
> + * -> DIR_STATE_PRE_ITERATION: the directory is *NOT* initialized. The
> + * dirpath has already been returned if pre-order traversal is set.
> + * -> DIR_STATE_ITERATING: the directory is initialized. We are traversing
> + * through it.
> + * -> DIR_STATE_POST_ITERATION: the directory has been iterated through.
> + * We are ready to close it.
> + * -> DIR_STATE_EXHAUSTED: the directory is closed and ready to be popped.
> + */
>  int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  {
>  	struct dir_iterator_int *iter =
> @@ -97,7 +120,18 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			&iter->levels[iter->levels_nr - 1];
>  		struct dirent *de;
>  
> -		if (!level->initialized) {
> +		if (level->dir_state == DIR_STATE_PUSHED) {
> +			level->dir_state = DIR_STATE_PRE_ITERATION;
> +
> +			if (iter->flags & DIR_ITERATOR_PRE_ORDER_TRAVERSAL) {
> +				/* We may not want the root directory to be iterated over */
> +				if (iter->levels_nr != 1 ||
> +					(iter->flags & DIR_ITERATOR_LIST_ROOT_DIR)) {

It would be a tiny improvement in readability to change the check
`iter->levels_nr != 1` to `iters->levels_nr > 1`, to help make it
clearer that this code block is not about `iters->level_nr == 0`.

> +					set_iterator_data(iter, level);

set_iterator_data() reports errors by returning -1, but here (and in the
DIR_ITERATOR_POST_ORDER_TRAVERSAL code block below) you fail to check
the return value.

If you are thinking to yourself "that can't happen because I already
checked `lstat()` in a previous iteration of the loop", remember that
another process might be changing things on the filesystem at the same
time as the iteration is running ("TOCTOU").

But of course that would make for slightly strange behavior if, during
the PRE_ORDER_TRAVERSAL, a directory is readable, but by the time of the
POST_ORDER_TRAVERSAL, it has disappeared. The iteration might list the
contents of a directory but not the POST_ORDER_TRAVERSAL of the
directory itself. Or, if both PRE and POST are being used, there would
be an "entering directory" event but no matching "leaving directory"
event, which could be confusing to a hypothetical caller who expects the
"entering directory" and "leaving directory" events to match up in pairs.

Furthermore, you are calling `lstat()` more often than necessary. This
function is quite expensive on Windows.

You could solve all three problems by running `lstat()` on the directory
once the first time you see it, storing its value in the
`dir_iterator_level`, and copying that value to `iter->base.st` when it
is needed. (This would fix the second problem by removing the need for a
failing `set_iterator_data()` call during the POST_ORDER_TRAVERSAL phase
of processing a directory.)

This would mean that we might return stale `lstat()` data to the caller,
but note that `lstat()` data is *always* stale, because it is always
possible that another process changes it the nanosecond after our
process reads it. So it's a possibility that the caller has to deal with
in any case.

> +					return ITER_OK;
> +				}
> +			}
> +		} else if (level->dir_state == DIR_STATE_PRE_ITERATION) {
>  			/*
>  			 * Note: dir_iterator_begin() ensures that
>  			 * path is not the empty string.
> @@ -107,64 +141,35 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
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
> -
> -			continue;
> -		}
> -
> -		/*
> -		 * Loop until we find an entry that we can give back
> -		 * to the caller:
> -		 */
> -		while (1) {
> +			level->dir_state = DIR_STATE_ITERATING;
> +		} else if (level->dir_state == DIR_STATE_ITERATING) {
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
> @@ -175,7 +180,38 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			if (set_iterator_data(iter, level))
>  				continue;
>  
> +			if (S_ISDIR(iter->base.st.st_mode)) {
> +				push_dir_level(iter, level);
> +				continue;
> +			}
> +
>  			return ITER_OK;
> +		} else if (level->dir_state == DIR_STATE_POST_ITERATION) {
> +			if (level->dir != NULL && closedir(level->dir)) {
> +				warning("error closing directory %s: %s",
> +					iter->base.path.buf, strerror(errno));
> +			}
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
> +			if (iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL) {
> +				/* We may not want the root directory to be iterated over */
> +				if (iter->levels_nr != 1 ||
> +					(iter->flags & DIR_ITERATOR_LIST_ROOT_DIR)) {
> +					set_iterator_data(iter, level);
> +					return ITER_OK;
> +				}
> +			}
> +		} else if (level->dir_state == DIR_STATE_EXHAUSTED) {
> +			if (pop_dir_level(iter) == 0)
> +				return dir_iterator_abort(dir_iterator);
>  		}
>  	}
>  }

As far as I can tell, you got the logic in this complicated big loop
correct on the first try (well, if we ignore v6 :-) ), even as you added
new features. I think that's good evidence that the new structure is
more comprehensible than the old, plus the new tests probably helped.
That's a big win!

> @@ -201,7 +237,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	return ITER_DONE;
>  }
>  
> -struct dir_iterator *dir_iterator_begin(const char *path)
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
>  {
>  	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
>  	struct dir_iterator *dir_iterator = &iter->base;
> @@ -209,13 +245,16 @@ struct dir_iterator *dir_iterator_begin(const char *path)
>  	if (!path || !*path)
>  		die("BUG: empty path passed to dir_iterator_begin()");
>  
> +	iter->flags = flags;
> +
>  	strbuf_init(&iter->base.path, PATH_MAX);
>  	strbuf_addstr(&iter->base.path, path);
>  
>  	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
>  
>  	iter->levels_nr = 1;
> -	iter->levels[0].initialized = 0;
> +	iter->levels[0].dir = NULL;
> +	iter->levels[0].dir_state = DIR_STATE_PUSHED;
>  
>  	return dir_iterator;
>  }
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 27739e6..0e82f36 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -11,13 +11,12 @@
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
> @@ -38,6 +37,22 @@
>   * dir_iterator_advance() again.
>   */
>  
> +/*
> + * Possible flags for dir_iterator_begin().
> + *
> + * -> DIR_ITERATOR_PRE_ORDER_TRAVERSAL: the iterator shall return
> + * a dirpath it has found before iterating through that directory's
> + * contents.
> + * -> DIR_ITERATOR_POST_ORDER_TRAVERSAL: the iterator shall return
> + * a dirpath it has found after iterating through that directory's
> + * contents.
> + * -> DIR_ITERATOR_LIST_ROOT_DIR: the iterator shall return the dirpath
> + * of the root directory it is iterating through.

I think it would be useful to mention here that the three options can be
used in any combination.

The documentation for `DIR_ITERATOR_LIST_ROOT_DIR` isn't precisely
accurate. If neither of the `*_ORDER_TRAVERSAL` options is specified,
then the root directory is not included in the iteration even if this
option is specified. I think this is enough of a boundary case that it
doesn't really matter if you change the behavior or change the
documentation, but one way or another please make them agree.

> + */
> +#define DIR_ITERATOR_PRE_ORDER_TRAVERSAL (1 << 0)
> +#define DIR_ITERATOR_POST_ORDER_TRAVERSAL (1 << 1)
> +#define DIR_ITERATOR_LIST_ROOT_DIR (1 << 2)
> +
>  struct dir_iterator {
>  	/* The current path: */
>  	struct strbuf path;
> @@ -57,15 +72,16 @@ struct dir_iterator {
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

The sentence above should be updated now that you have implemented
`DIR_ITERATOR_LIST_ROOT_DIR`.

>   * path is the starting directory. An internal copy will be made.
>   */
> -struct dir_iterator *dir_iterator_begin(const char *path);
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags);
>  
>  /*
>   * Advance the iterator to the first or next item and return ITER_OK.
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 50188e9..c29dc68 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3346,7 +3346,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
>  	files_downcast(ref_store, 0, "reflog_iterator_begin");
>  
>  	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
> -	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
> +	iter->dir_iterator = dir_iterator_begin(git_path("logs"), DIR_ITERATOR_PRE_ORDER_TRAVERSAL);
>  	return ref_iterator;
>  }
>  
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index 06f03fc..a1b8c78 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -6,6 +6,7 @@
>  int cmd_main(int argc, const char **argv) {
>  	struct strbuf path = STRBUF_INIT;
>  	struct dir_iterator *diter;
> +	unsigned flag = DIR_ITERATOR_PRE_ORDER_TRAVERSAL;
>  
>  	if (argc < 2) {
>  		return 1;
> @@ -13,7 +14,10 @@ int cmd_main(int argc, const char **argv) {
>  
>  	strbuf_add(&path, argv[1], strlen(argv[1]));
>  
> -	diter = dir_iterator_begin(path.buf);
> +	if (argc == 3)
> +		flag = atoi(argv[2]);

It's not ideal that the test code depends on the numerical values of the
flag constants, and it makes the tests harder to understand. It would be
better if this program were to accept options like `--pre-order`,
`--post-order`, etc., as I suggested in an earlier round of review.

> +	diter = dir_iterator_begin(path.buf, flag);
>  
>  	while (dir_iterator_advance(diter) == ITER_OK) {
>  		if (S_ISDIR(diter->st.st_mode))
> diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
> index b857c07..ade3ee0 100755
> --- a/t/t0065-dir-iterator.sh
> +++ b/t/t0065-dir-iterator.sh
> @@ -28,12 +28,28 @@ test_expect_success 'dir-iterator should iterate through all files' '
>  	>dir/a/e &&
>  	>dir/d/e/d/a &&
>  
> -	test-dir-iterator ./dir | sort >./actual-pre-order-sorted-output &&
> +	test-dir-iterator ./dir 1 | sort >./actual-pre-order-sorted-output &&
>  	rm -rf dir &&
>  
>  	test_cmp expect-sorted-output actual-pre-order-sorted-output
>  '
>  
> +test_expect_success 'dir-iterator should iterate through all files on post-order mode' '
> +	mkdir -p dir &&
> +	mkdir -p dir/a/b/c/ &&
> +	>dir/b &&
> +	>dir/c &&
> +	mkdir -p dir/d/e/d/ &&
> +	>dir/a/b/c/d &&
> +	>dir/a/e &&
> +	>dir/d/e/d/a &&
> +
> +	test-dir-iterator ./dir 2 | sort >actual-post-order-sorted-output &&
> +	rm -rf dir &&
> +
> +	test_cmp expect-sorted-output actual-post-order-sorted-output
> +'

The setup done in the test above is identical to the setup for the test
before it. Similarly, the last three tests also all use the same setup.
Please put all of the setup code in an extra "pseudo-test" at the top of
the file, to avoid duplication:

test_expect_success 'setup' '
	mkdir -p dir1 &&
	mkdir -p dir1/a/b/c/ &&
	>dir1/b &&
	>dir1/c &&
	mkdir -p dir1/d/e/d/ &&
	>dir1/a/b/c/d &&
	>dir1/a/e &&
	>dir1/d/e/d/a &&

	mkdir -p dir2/a/b/c/ &&
	>dir2/a/b/c/d
'

Note that at least one of the test directories has to be renamed so that
they don't conflict with each other.

There is no need for the individual tests to delete their test
directories; the test harness will take care of that. But if you *did*
need to clean up after a test, you should do it like this:

	mkdir foo &&
	test_when_finished "rm -rf foo" &&
	...tests involving foo...

The advantage of `test_when_finished` is that it ensures that the
cleanup code is run even if some part of the test fails.

>  cat >expect-pre-order-output <<-\EOF &&
>  [d] (a) ./dir/a
>  [d] (a/b) ./dir/a/b
> @@ -41,14 +57,53 @@ cat >expect-pre-order-output <<-\EOF &&
>  [f] (a/b/c/d) ./dir/a/b/c/d
>  EOF
>  
> -test_expect_success 'dir-iterator should list files in the correct order' '
> +test_expect_success 'dir-iterator should list files properly on pre-order mode' '
>  	mkdir -p dir/a/b/c/ &&
>  	>dir/a/b/c/d &&
>  
> -	test-dir-iterator ./dir >actual-pre-order-output &&
> +	test-dir-iterator ./dir 1 >actual-pre-order-output &&
>  	rm -rf dir &&
>  
>  	test_cmp expect-pre-order-output actual-pre-order-output
>  '
>  
> +cat >expect-post-order-output <<-\EOF &&
> +[f] (a/b/c/d) ./dir/a/b/c/d
> +[d] (a/b/c) ./dir/a/b/c
> +[d] (a/b) ./dir/a/b
> +[d] (a) ./dir/a
> +EOF
> +
> +test_expect_success 'dir-iterator should list files properly on post-order mode' '
> +	mkdir -p dir/a/b/c/ &&
> +	>dir/a/b/c/d &&
> +
> +	test-dir-iterator ./dir 2 >actual-post-order-output &&
> +	rm -rf dir &&
> +
> +	test_cmp expect-post-order-output actual-post-order-output
> +'
> +
> +cat >expect-pre-order-post-order-root-dir-output <<-\EOF &&
> +[d] (.) ./dir
> +[d] (a) ./dir/a
> +[d] (a/b) ./dir/a/b
> +[d] (a/b/c) ./dir/a/b/c
> +[f] (a/b/c/d) ./dir/a/b/c/d
> +[d] (a/b/c) ./dir/a/b/c
> +[d] (a/b) ./dir/a/b
> +[d] (a) ./dir/a
> +[d] (.) ./dir
> +EOF
> +
> +test_expect_success 'dir-iterator should list files properly on pre-order + post-order + root-dir mode' '
> +	mkdir -p dir/a/b/c/ &&
> +	>dir/a/b/c/d &&
> +
> +	test-dir-iterator ./dir 7 >actual-pre-order-post-order-root-dir-output &&
> +	rm -rf dir &&
> +
> +	test_cmp expect-pre-order-post-order-root-dir-output actual-pre-order-post-order-root-dir-output
> +'
> +
>  test_done

Michael

