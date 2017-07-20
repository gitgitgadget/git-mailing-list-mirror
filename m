Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDBD1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 18:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934535AbdGTSHc (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 14:07:32 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32768 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932477AbdGTSHb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 14:07:31 -0400
Received: by mail-pg0-f47.google.com with SMTP id k14so18104595pgr.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nq9qAMPu3yhSVXMYel+7vYU9xlXDSFdUvg2omVceHpY=;
        b=P0U7jGNW6belU9K8O2eS3AtcjbLmiLivHFfOJ1/aOTiPnz3fKQnUZMpnFsBBktGLOJ
         O16rEwDUE50yhjTI/3Wkr5vffjRCuv6XaK/hpwmcn63XkGzDL/XxwngJiUdYKpwy1vtY
         EAPm4VygiWFdOTorXUxLp7Uy08stEELNPd6gh+OEgr2r9GqZv/k3mEFNSYiGki+NBF8d
         hKRrVsIjdIVK3ZFoLkJ6c0YmKM8Z8cbVAMUg/AmKKtcpOu85SPEemvTpvmzee6X6L3HF
         1eJRccWOCYEiGl+TYIxwtrRcG30Qb3BIX1Puav+nlRWng7VwelVl+nNVpEKPP2Ktt1CH
         038w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nq9qAMPu3yhSVXMYel+7vYU9xlXDSFdUvg2omVceHpY=;
        b=ft3g04zuWtDOfJ8reyuouAPux2+ZxBj9pPBP68ZwBJE7zzy1HfkBmwRWNS6wfi85E9
         bHgOe2sUUYofRLQ18L/E5Qt3LyR2hQxDITN8PufflBUNTw1P/HSnaes7Xw65BOcYPYyb
         OgYMq6wyK6zoDA3oQk89IBno9sP1eCyeI1BfvRMpkvDqmA5ICDY0VzBXdSmQ1TYfRx8G
         FJKfd8TAGn1b+jz5c6jzLpCzi/iiccu/dlVcFgQ/Gi9x9EBhGwImd3UAynXQV5Lxn13n
         pxSsFlLb/b4DQQj6wfccjVPz8zesB/IhniDvmyzKjSjKcmFhQB77fqr9u073ivhvwUTv
         C9Qw==
X-Gm-Message-State: AIVw112dn2KiQUXBW3GOscBkudcyz1wVrjMf1BdSG5XReUdGGd4ye9uN
        GzuG9igpjY2C3WCcdReuFu4VAgZRAg5y
X-Received: by 10.99.44.138 with SMTP id s132mr4782965pgs.318.1500574050407;
 Thu, 20 Jul 2017 11:07:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 20 Jul 2017 11:07:29 -0700 (PDT)
In-Reply-To: <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <cover.1500508695.git.jonathantanmy@google.com> <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Jul 2017 11:07:29 -0700
Message-ID: <CAGZ79kZ45Z3R9FbsKQwotXh_Ek=StUdSTHj4er6HMhx79VbV4g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised objects
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2017 at 5:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Currently, Git does not support repos with very large numbers of objects
> or repos that wish to minimize manipulation of certain blobs (for
> example, because they are very large) very well, even if the user
> operates mostly on part of the repo, because Git is designed on the
> assumption that every referenced object is available somewhere in the
> repo storage.
>
> As a first step to reducing this problem, introduce the concept of
> promised objects. Each Git repo can contain a list of promised objects
> and their sizes (if blobs) at $GIT_DIR/objects/promised. This patch
> contains functions to query them; functions for creating and modifying
> that file will be introduced in later patches.
>
> A repository that is missing an object but has that object promised is not
> considered to be in error, so also teach fsck this. As part of doing
> this, object.{h,c} has been modified to generate "struct object" based
> on only the information available to promised objects, without requiring
> the object itself.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/technical/repository-version.txt |   6 ++
>  Makefile                                       |   1 +
>  builtin/fsck.c                                 |  18 +++-
>  cache.h                                        |   2 +
>  environment.c                                  |   1 +
>  fsck.c                                         |   6 +-
>  object.c                                       |  19 ++++
>  object.h                                       |  19 ++++
>  promised-object.c                              | 130 +++++++++++++++++++++++++
>  promised-object.h                              |  22 +++++
>  setup.c                                        |   7 +-
>  t/t3907-promised-object.sh                     |  41 ++++++++
>  t/test-lib-functions.sh                        |   6 ++
>  13 files changed, 273 insertions(+), 5 deletions(-)
>  create mode 100644 promised-object.c
>  create mode 100644 promised-object.h
>  create mode 100755 t/t3907-promised-object.sh
>
> diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
> index 00ad37986..f8b82c1c7 100644
> --- a/Documentation/technical/repository-version.txt
> +++ b/Documentation/technical/repository-version.txt
> @@ -86,3 +86,9 @@ for testing format-1 compatibility.
>  When the config key `extensions.preciousObjects` is set to `true`,
>  objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
>  `git repack -d`).
> +
> +`promisedObjects`
> +~~~~~~~~~~~~~~~~~
> +
> +(Explain this - basically a string containing a command to be run
> +whenever a missing object needs to be fetched.)
> diff --git a/Makefile b/Makefile
> index 9c9c42f8f..c1446d5ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -828,6 +828,7 @@ LIB_OBJS += preload-index.o
>  LIB_OBJS += pretty.o
>  LIB_OBJS += prio-queue.o
>  LIB_OBJS += progress.o
> +LIB_OBJS += promised-object.o
>  LIB_OBJS += prompt.o
>  LIB_OBJS += quote.o
>  LIB_OBJS += reachable.o
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 462b8643b..49e21f361 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -15,6 +15,7 @@
>  #include "progress.h"
>  #include "streaming.h"
>  #include "decorate.h"
> +#include "promised-object.h"
>
>  #define REACHABLE 0x0001
>  #define SEEN      0x0002
> @@ -44,6 +45,7 @@ static int name_objects;
>  #define ERROR_REACHABLE 02
>  #define ERROR_PACK 04
>  #define ERROR_REFS 010
> +#define ERROR_PROMISED_OBJECT 011
>
>  static const char *describe_object(struct object *obj)
>  {
> @@ -436,7 +438,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
>  {
>         struct object *obj;
>
> -       obj = parse_object(oid);
> +       obj = parse_or_promise_object(oid);
>         if (!obj) {
>                 error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
>                 errors_found |= ERROR_REACHABLE;
> @@ -592,7 +594,7 @@ static int fsck_cache_tree(struct cache_tree *it)
>                 fprintf(stderr, "Checking cache tree\n");
>
>         if (0 <= it->entry_count) {
> -               struct object *obj = parse_object(&it->oid);
> +               struct object *obj = parse_or_promise_object(&it->oid);
>                 if (!obj) {
>                         error("%s: invalid sha1 pointer in cache-tree",
>                               oid_to_hex(&it->oid));
> @@ -635,6 +637,12 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
>         return 0;
>  }
>
> +static int mark_have_promised_object(const struct object_id *oid, void *data)
> +{
> +       mark_object_for_connectivity(oid);
> +       return 0;
> +}
> +
>  static char const * const fsck_usage[] = {
>         N_("git fsck [<options>] [<object>...]"),
>         NULL
> @@ -690,6 +698,11 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>
>         git_config(fsck_config, NULL);
>
> +       if (fsck_promised_objects()) {
> +               error("Errors found in promised object list");
> +               errors_found |= ERROR_PROMISED_OBJECT;
> +       }

This got me thinking: It is an error if we do not have an object
and also do not promise it, but what about the other case:
having and object and promising it, too?
That is not harmful to the operation, except that the promise
machinery may be slower due to its size. (Should that be a soft
warning then? Do we have warnings in fsck?)

>   * The object type is stored in 3 bits.
>   */

We may want to remove this comment while we're here as it
sounds stale despite being technically correct.
1974632c66 (Remove TYPE_* constant macros and use
object_type enums consistently., 2006-07-11)

>  struct object {
> +       /*
> +        * Set if this object is parsed. If set, "type" is populated and this
> +        * object can be casted to "struct commit" or an equivalent.
> +        */
>         unsigned parsed : 1;
> +       /*
> +        * Set if this object is not in the repo but is promised. If set,
> +        * "type" is populated, but this object cannot be casted to "struct
> +        * commit" or an equivalent.
> +        */
> +       unsigned promised : 1;

Would it make sense to have a bit field instead:

#define STATE_BITS 2
#define STATE_PARSED (1<<0)
#define STATE_PROMISED (1<<1)

    unsigned state : STATE_BITS

This would be similar to the types and flags?


> +test_expect_success 'fsck fails on missing objects' '
> +       test_create_repo repo &&
> +
> +       test_commit -C repo 1 &&
> +       test_commit -C repo 2 &&
> +       test_commit -C repo 3 &&
> +       git -C repo tag -a annotated_tag -m "annotated tag" &&
> +       C=$(git -C repo rev-parse 1) &&
> +       T=$(git -C repo rev-parse 2^{tree}) &&
> +       B=$(git hash-object repo/3.t) &&
> +       AT=$(git -C repo rev-parse annotated_tag) &&
> +
> +       # missing commit, tree, blob, and tag
> +       rm repo/.git/objects/$(echo $C | cut -c1-2)/$(echo $C | cut -c3-40) &&
> +       rm repo/.git/objects/$(echo $T | cut -c1-2)/$(echo $T | cut -c3-40) &&
> +       rm repo/.git/objects/$(echo $B | cut -c1-2)/$(echo $B | cut -c3-40) &&
> +       rm repo/.git/objects/$(echo $AT | cut -c1-2)/$(echo $AT | cut -c3-40) &&

This is a pretty cool test as it promises all sorts of objects
from different parts of the graph.
