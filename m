Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06371F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH1ADM (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:03:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35871 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeH1ADM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:03:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so197292wmj.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fQ+eKtPgBgmT761+icp7LP1hG30dknNiNNhaiQR74Y0=;
        b=kctjT0IqOpgKUkyjYeHqM00PpIAjnZwwCr4SfBP7oHqiTis99BvlOdyo35tizYVMta
         dSjm1aroaIPT1b4Fs+IFqndrEiVRd4nH0cHWB5Bh5pHQ45rPPf2td/gZy7Fi0bpAqGyO
         AqpcRQvI+p5fWo4wXrjTXRerfxqbQz8N8TrHd7Vzz7k3PnC66mcmy64rCKbaq29V/iTK
         6eYM0J8otcPy8bjgzfQ2IUBwQYJa7HFOvHFqn6ZoQUHfF3LpxU6yuoc7XXOHzLa81NpS
         7tDM1q2UlK2I6m8htQ9fiNb7K/bhIunUqzScwrQWXxQ+bZzQcfHcx38g/MhmsdTDJNiW
         v9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=fQ+eKtPgBgmT761+icp7LP1hG30dknNiNNhaiQR74Y0=;
        b=qbMDBX2Kly2vXHY9EhQftv2D9oQF25U+gKxIJg7MebTMxfLUq32mnAspZSEQDNkQFM
         P7hGmvETnP2T7N5LQ7lVLWHxtHCy1YjlN4t/0f+uI1MTNhiGH4YlUQB2cdGurKFvZ4Kd
         N+jWrruO+P1D3Z/sVoGzWYHwXAStapdB7XXLG1iQee+J5etDWirfk1JqlBrtvDJK8LWD
         7G20G50UdLV2CXxXmdluDcY/2u3Gq7dR8AYcqVEmWPO+ZzYUU6rilJiiHF3y60gwGLZn
         874dC7fB6y7DaZdf0X0cH9EPVgVOIpusiDNEdhSy0agkf2wX5JwxxmE8TE/4bkj1eNGz
         KjDQ==
X-Gm-Message-State: APzg51CmsiR0knpCV838CEV+2d4zk0UMStLM/swpAIDz1rZAcgCIDJk7
        oMUN+5wrUt9hqiIHN5mWbh9KzXXSyaY=
X-Google-Smtp-Source: ANB0VdacZzPEwfJ6dR/dmW7Rs7yh0pGk4zoFmfl3OfG6Y5KTfgP7QIvrjPJzIjS9KFUbNDASgegCYg==
X-Received: by 2002:a1c:a745:: with SMTP id q66-v6mr3879451wme.49.1535400902259;
        Mon, 27 Aug 2018 13:15:02 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b22-v6sm54916wme.48.2018.08.27.13.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 13:15:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 6/7] fsck: use oidset for skiplist
References: <20180827194323.17055-1-avarab@gmail.com> <20180827194323.17055-7-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180827194323.17055-7-avarab@gmail.com>
Date:   Mon, 27 Aug 2018 22:15:00 +0200
Message-ID: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 27 2018, Ævar Arnfjörð Bjarmason wrote:

> From: René Scharfe <l.s.r@web.de>
>
> Object IDs to skip are stored in a shared static oid_array.  Lookups do
> a binary search on the sorted array.  The code checks if the object IDs
> are already in the correct order while loading and skips sorting in that
> case.  Lookups are done before reporting a (non-fatal) corruption and
> before checking .gitmodules files.
>
> Simplify the code by using an oidset instead.  Memory usage is a bit
> higher, but we don't need to worry about any sort order anymore.  Embed
> the oidset into struct fsck_options to make its ownership clear (no
> hidden sharing) and avoid unnecessary pointer indirection.
>
> Performance on repositories with a low number of reported issues and
> .gitmodules files (i.e. the usual case) won't be affected much.  The
> oidset should be a bit quicker with higher numbers of bad objects in
> the skipList.

I didn't change this commit message at all, but FWIW this still has me
somewhat confused. What is the interaction with .gitmodules being
described here? You also mentioned it in
https://public-inbox.org/git/113aa2d7-6f66-8d03-dda4-7337cda9b2df@web.de/
(but I don't get that either)

Does that just mean that when cloning with --recursive with
transfer.fsckObjects=true we'll re-read the file for each "clone"
invocation, both for the main project and everything listed in
.gitmodules?

If so, I think something like this commit message would be clearer:

    fsck: use oidset instead of oid_array for skipList

    Change the implementation of the skipList feature to use oidset
    instead of oid_array to store SHA-1s for later lookup.

    This list is parsed once on startup by fsck, fetch-pack or
    receive-pack depending on the *.skipList config in use, so for fetch
    it's currently re-parsed for each submodule fetch.

    Memory usage is a bit higher, but we don't need to keep track of the
    sort order anymore. Embed the oidset into struct fsck_options to
    make its ownership clear (no hidden sharing) and avoid unnecessary
    pointer indirection.

Then let's just attach the test program you wrote in
https://public-inbox.org/git/113aa2d7-6f66-8d03-dda4-7337cda9b2df@web.de/
and note the results and let them speak for themselves.

I can do all that if that seems fine to you. I also notice that the test
case only sets up a case where all the items on the skip list are bad
commits in the repo, it would be interesting to test with a few needles
in a large haystack (I can modify it to do that...).

> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config.txt | 11 ++++++-----
>  fsck.c                   | 23 ++---------------------
>  fsck.h                   |  8 +++++---
>  3 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a8dfafa61d..3d0556e85d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1729,11 +1729,12 @@ all three of them they must all set to the same values.
>  +
>  Older versions of Git (before 2.20) documented that the object names
>  list should be sorted. This was never a requirement, the object names
> -can appear in any order, but when reading the list we track whether
> -the list is sorted for the purposes of an internal binary search
> -implementation, which can save itself some work with an already sorted
> -list.  Unless you have a humongous list there's no reason to go out of
> -your way to pre-sort the list.
> +could appear in any order, but when reading the list we tracked whether
> +the list was sorted for the purposes of an internal binary search
> +implementation, which could save itself some work with an already sorted
> +list. Unless you had a humongous list there was no reason to go out of
> +your way to pre-sort the list. After Git version 2.20 a hash implementation
> +is used instead, so there's now no reason to pre-sort the list.
>
>  gc.aggressiveDepth::
>  	The depth parameter used in the delta compression
> diff --git a/fsck.c b/fsck.c
> index 972a26b9ba..4c643f1d40 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -10,7 +10,6 @@
>  #include "fsck.h"
>  #include "refs.h"
>  #include "utf8.h"
> -#include "sha1-array.h"
>  #include "decorate.h"
>  #include "oidset.h"
>  #include "packfile.h"
> @@ -182,19 +181,10 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
>
>  static void init_skiplist(struct fsck_options *options, const char *path)
>  {
> -	static struct oid_array skiplist = OID_ARRAY_INIT;
> -	int sorted;
>  	FILE *fp;
>  	struct strbuf sb = STRBUF_INIT;
>  	struct object_id oid;
>
> -	if (options->skiplist)
> -		sorted = options->skiplist->sorted;
> -	else {
> -		sorted = 1;
> -		options->skiplist = &skiplist;
> -	}
> -
>  	fp = fopen(path, "r");
>  	if (!fp)
>  		die("Could not open skip list: %s", path);
> @@ -202,19 +192,12 @@ static void init_skiplist(struct fsck_options *options, const char *path)
>  		const char *p;
>  		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>  			die("Invalid SHA-1: %s", sb.buf);
> -		oid_array_append(&skiplist, &oid);
> -		if (sorted && skiplist.nr > 1 &&
> -				oidcmp(&skiplist.oid[skiplist.nr - 2],
> -				       &oid) > 0)
> -			sorted = 0;
> +		oidset_insert(&options->skiplist, &oid);
>  	}
>  	if (ferror(fp))
>  		die_errno("Could not read '%s'", path);
>  	fclose(fp);
>  	strbuf_release(&sb);
> -
> -	if (sorted)
> -		skiplist.sorted = 1;
>  }
>
>  static int parse_msg_type(const char *str)
> @@ -319,9 +302,7 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
>
>  static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
>  {
> -	if (opts && opts->skiplist && obj)
> -		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
> -	return 0;
> +	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
>  }
>
>  __attribute__((format (printf, 4, 5)))
> diff --git a/fsck.h b/fsck.h
> index 0c7e8c9428..b95595ae5f 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -1,6 +1,8 @@
>  #ifndef GIT_FSCK_H
>  #define GIT_FSCK_H
>
> +#include "oidset.h"
> +
>  #define FSCK_ERROR 1
>  #define FSCK_WARN 2
>  #define FSCK_IGNORE 3
> @@ -35,12 +37,12 @@ struct fsck_options {
>  	fsck_error error_func;
>  	unsigned strict:1;
>  	int *msg_type;
> -	struct oid_array *skiplist;
> +	struct oidset skiplist;
>  	struct decoration *object_names;
>  };
>
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
>
>  /* descend in all linked child objects
>   * the return value is:
