Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27F12035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbdGKWin (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:38:43 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33298 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933058AbdGKWim (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:38:42 -0400
Received: by mail-pg0-f41.google.com with SMTP id k14so2959117pgr.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sICfKd+I35RIJwHcACMZLUWJYT73dFdvCIQ/Z9sUDgk=;
        b=Qw8efbWX0iypVmRM01cb6prVAY2BpQ0Ba9gX1ld8Evhyou2thpSr+5LX6qBjZQLO5W
         qK2d+Fkfg7LClgNkLbP+8BzaWMO1S/20yiM44EElsrP2UHRb434RidLDzTRSHhHfs3xS
         MJECbBSCllEwCen1kXhTP0Hf9kL5lyg1euz0jBc6GfmK+Y4zewGl/QJhhUQssb8fJ9O9
         vtMHnfEQ3d+QHbgMvD6OUI9+npq69zjUPC7U/AIhju+MOQxfoI+GsYTzJ6jKlwt6Vewt
         DjZXSS8yCdmLhVTGKam6u76vTfB7EM37xFlaCdGcygc2G7Q1ONdRgEwqYMG5Hygj3ZDv
         V3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sICfKd+I35RIJwHcACMZLUWJYT73dFdvCIQ/Z9sUDgk=;
        b=oJKifxnYKhlLW5WQQ0i/OOg4kzwCZgx8Ys8U/So7UxVaCFaphtX5AxVLDX0mqzuzHY
         FrvgSgh0OyIJUbrJqP4J6OptyZUBx34IXAMZqaBZvhU7pTvk8mbGoAr9iqLzkS0Dy2RX
         EkZGl+vsQDFL29Geo86IcXocwp30DJxyanJ39FzTgKDVY+JqcrhU5WO8B5oUD+1IZdH0
         xlOb9SJpNshLqFzRUUSd4MF8jYh9MeP6bHB09T3KJ+oagDm2X4GOje9dXx+O8LRqJSm4
         zXTQ7JHxcM/x6dfJ8MuiLgnLMjHyOF4isfWT8oMuzIUVoHvTOPYN9py8z/SJx2+JLm6v
         KPsQ==
X-Gm-Message-State: AIVw112ti/T8ZWWkk+heMFUzGY3Zotl4Xhbn59z0yWtXQcw86YShddzW
        riuarBI4R3nOh4SmtEOP1tfRDVIJ3rZN
X-Received: by 10.99.149.83 with SMTP id t19mr678461pgn.247.1499812721536;
 Tue, 11 Jul 2017 15:38:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 11 Jul 2017 15:38:40 -0700 (PDT)
In-Reply-To: <34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com> <34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 15:38:40 -0700
Message-ID: <CAGZ79kbdyOyu8ni6tLzb+eMcOuT0ahzVWZxgnSfO+8XYn48=Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sha1_file: add promised blob hook support
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 12:48 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Teach sha1_file to invoke a hook whenever a blob is requested and
> unavailable but is promised. The hook is a shell command that can be
> configured through "git config"; this hook takes in a list of hashes and
> writes (if successful) the corresponding objects to the repo's local
> storage.
>
> This is meant as a temporary measure to ensure that all Git commands
> work in such a situation. Future patches will update some commands to
> either tolerate promised blobs (without invoking the hook) or be more
> efficient in invoking the promised blob hook.
>
> In order to determine the code changes in sha1_file.c necessary, I
> investigated the following:
>  (1) functions in sha1_file that take in a hash, without the user
>      regarding how the object is stored (loose or packed)
>  (2) functions in sha1_file that operate on packed objects (because I
>      need to check callers that know about the loose/packed distinction
>      and operate on both differently, and ensure that they can handle
>      the concept of objects that are neither loose nor packed)
>
> (1) is handled by the modification to sha1_object_info_extended().
>
> For (2), I looked at for_each_packed_object and at the packed-related
> functions that take in a hash. For for_each_packed_object, the callers
> either already work or are fixed in this patch:
>  - reachable - only to find recent objects
>  - builtin/fsck - already knows about promised blobs
>  - builtin/cat-file - fixed in this commit
>
> Callers of the other functions do not need to be changed:
>  - parse_pack_index
>    - http - indirectly from http_get_info_packs
>  - find_pack_entry_one
>    - this searches a single pack that is provided as an argument; the
>      caller already knows (through other means) that the sought object
>      is in a specific pack
>  - find_sha1_pack
>    - fast-import - appears to be an optimization to not store a
>      file if it is already in a pack
>    - http-walker - to search through a struct alt_base
>    - http-push - to search through remote packs
>  - has_sha1_pack
>    - builtin/fsck - already knows about promised blobs
>    - builtin/count-objects - informational purposes only (check if loose
>      object is also packed)
>    - builtin/prune-packed - check if object to be pruned is packed (if
>      not, don't prune it)
>    - revision - used to exclude packed objects if requested by user
>    - diff - just for optimization
>
> An alternative design that I considered but rejected:
>
>  - Adding a hook whenever a packed blob is requested, not on any blob.
>    That is, whenever we attempt to search the packfiles for a blob, if
>    it is missing (from the packfiles and from the loose object storage),
>    to invoke the hook (which must then store it as a packfile), open the
>    packfile the hook generated, and report that the blob is found in
>    that new packfile. This reduces the amount of analysis needed (in
>    that we only need to look at how packed blobs are handled), but
>    requires that the hook generate packfiles (or for sha1_file to pack
>    whatever loose objects are generated), creating one packfile for each
>    missing blob and potentially very many packfiles that must be
>    linearly searched. This may be tolerable now for repos that only have
>    a few missing blobs (for example, repos that only want to exclude
>    large blobs), and might be tolerable in the future if we have
>    batching support for the most commonly used commands, but is not
>    tolerable now for repos that exclude a large amount of blobs.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

>
> +core.promisedBlobCommand::
> +       If set, whenever a blob in the local repo is attempted to be read, but
> +       is both missing and a promised blob, invoke this shell command to
> +       generate or obtain that blob before reporting an error. This shell
> +       command should take one or more hashes, each terminated by a newline,
> +       as standard input, and (if successful) should write the corresponding
> +       objects to the local repo (packed or loose).

Any git command invoked here behaves differently as
GIT_IGNORE_PROMISED_BLOBS is set.
GIT_IGNORE_PROMISED_BLOBS needs documentation.


> +int request_promised_blobs(const struct oid_array *blobs)

> +       if (i == blobs->nr)
> +               /* Nothing to fetch */

s/to fetch/to get/ ? Might be to nitpicky.

So this function takes an array of blobs and obtains any that
are promised.

> +
> +       argv[0] = promised_blob_command;
> +       cp.argv = argv;
> +       cp.env = env;

I had the impression that we'd favor .args and .env_array
nowdays, such that we'd not need to construct the NULL
terminated array ourselves. (e.g. whenever we'd change argv,
we'd need to make sure it contains enough NULL at the end)

    argv_array_push(&cp.args, promised_blob_command);
    argv_array_push(&cp.env_array, \
        "GIT_IGNORE_PROMISED_BLOBS=1");

would have the same effect.


> +/*
> + * If any of the given blobs are promised blobs, invokes
> + * core.promisedblobcommand with those blobs and returns the number of blobs
> + * requested. No check is made as to whether the invocation actually populated
> + * the repository with the promised blobs.
> + *
> + * If none of the given blobs are promised blobs, this function does not invoke
> + * anything and returns 0.

Thanks for the docs here.
  offtopic: As a general thing for our patches, can we configure
  (or even convince Git in general), that headers ought to be sent *before*
  its accompanying source? I think that would help reviewers like me, who
  tend to start reading linearly and then giving random thoughts, because the
  header prepares the reviewer for the source code with expectations. Also
  by having it the other way around, the review first focuses on design (Is this
  function signature sane; the docs said it would do X while not doing
Y, is that
  sane?) instead of code.

  IIRC Gerrit has an option (or default) that the header is before the source,
  despite the order violating the git sorting of files.



> + */
> +int request_promised_blobs(const struct oid_array *blobs);
> +
>  #endif
> diff --git a/sha1_file.c b/sha1_file.c
> index 5862386cd..5778a6dbd 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -28,6 +28,11 @@
>  #include "list.h"
>  #include "mergesort.h"
>  #include "quote.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
> +#include "sha1-lookup.h"
> +#include "promised-blob.h"
> +#include "sha1-array.h"
>
>  #define SZ_FMT PRIuMAX
>  static inline uintmax_t sz_fmt(size_t s) { return s; }
> @@ -2983,6 +2988,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>         const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
>                                     lookup_replace_object(sha1) :
>                                     sha1;
> +       int already_retried = 0;
>
>         if (!oi)
>                 oi = &blank_oi;
> @@ -3007,30 +3013,40 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>                 }
>         }
>
> -       if (!find_pack_entry(real, &e)) {
> -               /* Most likely it's a loose object. */
> -               if (!sha1_loose_object_info(real, oi, flags)) {
> -                       oi->whence = OI_LOOSE;
> -                       return 0;
> -               }
> +retry:
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
>
> -               /* Not a loose object; someone else may have just packed it. */
> -               if (flags & OBJECT_INFO_QUICK) {
> -                       return -1;
> -               } else {
> -                       reprepare_packed_git();
> -                       if (!find_pack_entry(real, &e))
> -                               return -1;
> +       /* Most likely it's a loose object. */
> +       if (!sha1_loose_object_info(real, oi, flags)) {
> +               oi->whence = OI_LOOSE;
> +               return 0;
> +       }
> +
> +       /* Not a loose object; someone else may have just packed it. */
> +       reprepare_packed_git();
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
> +
> +       /* Check if it is a promised blob */
> +       if (!already_retried) {
> +               struct oid_array promised = OID_ARRAY_INIT;
> +               oid_array_append_sha1(&promised, real);
> +               if (request_promised_blobs(&promised)) {
> +                       already_retried = 1;
> +                       goto retry;

Once we have the promised blob, do we want to
remove it from the list of promised blobs?
(Maybe check first if we have it actually?)

Or is the opposite true:
We rather want to keep the promised blobs list,
such that we can easily get rid of good candidates
to make space on the local fs?


> @@ -26,4 +26,40 @@ test_expect_success '...but fails again with GIT_IGNORE_PROMISED_BLOBS' '
>         unset GIT_IGNORE_PROMISED_BLOBS
>  '
>
> +test_expect_success 'sha1_object_info_extended (through git cat-file)' '
> +       rm -rf server client &&

Did you take these rm -rf as the first line of a test from any other tests?
(If so I'd call them out as bad examples)

I think it is better if we'd do

    test_when_finished "rm -rf ..." &&

in a test, as then each test is self contained and cleans up
after itself as opposed to cleaning up for the guy in front of you.

> +       git init server &&

test_create_repo maybe?

> +       test_commit -C server 1 1.t abcdefgh &&
> +       HASH=$(git hash-object server/1.t) &&
> +
> +       git init client &&
> +       git -C client config core.promisedblobcommand \
> +               "git -C \"$(pwd)/server\" pack-objects --stdout |
> +                git unpack-objects" &&

Nothing is wrong with absolute path, except relative paths
may be easier to read here. Is the core.promisedblobcommand
promised to run in a particular directory? Do we want to make that
promise (if so, we'd want the test with relative path IMHO).

I like the series! A pleasant read, though I am tossing back
a lot of questions.

Thanks,
Stefan
