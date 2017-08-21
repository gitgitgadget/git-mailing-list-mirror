Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3741C208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 21:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbdHUVIo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 17:08:44 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35258 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753850AbdHUVIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 17:08:41 -0400
Received: by mail-yw0-f176.google.com with SMTP id s187so12845216ywf.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0pM8yXbJqOP+i/S5LaJ9dSXjs/gzlzccfs1aqRhlnZQ=;
        b=dhv+J/+jHnxWTlBOMpFpqOwb2xixJPzeHE4XzKQJHWBpvR+IWM4t28pV1woFOrxgoN
         O8Zs0J3gXaxj1KXpl2HZ3+yEAWtz3oF/LQFtDmTk26KUFOQiG5UO9kiz07D/DLs91WWU
         hSSjrHyEMbQvq32z+R4tW9ejoLI0mjYSBVSm0oe65SObLc5fM/Xuyupt9BERvQMDaV0h
         mPBOCCCWMeOlrN4ypQBGOYQQ3PeTeMcKjyRB75EolN3dHMPNjQr3k6zbzh5exUTymLNK
         gb/p8udgqiYnMvqcALttKK0WaTN6EU7ze6JqBujJoV55frgMMh7aLKltBjeDNzEj7JD9
         qsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0pM8yXbJqOP+i/S5LaJ9dSXjs/gzlzccfs1aqRhlnZQ=;
        b=LyxgiRhXoK2IuDSI2IsTZJZ54vtE7pAOS5vG68TI9zWC6TgHsArLaNd4WSakd0lxKW
         MI21HdX0/SeShjG0Qw2VgUX6/bH2FJ6r9lrXmMARuWEndJMiJyqw7l+vysd7VHSKLb4y
         PYAYMYHIt6p6+boQukTW3JRqPhRlXIStbm0x+Usm1RQ9Nzh+hOAECq4n0JkEZXaxucya
         e/9FTakmqLJIAbkiVt52PeGx67g6iEt8cQJf72NWXIgbU58ZrodqaN/rj87lrkXIgGJB
         0PdUwY/8rqxZQ5TUgEP0IBJL3qRxaGkTviUOvQxeWzOhOmSRZuSq8TuHaOXw2KOW8WLt
         ia1Q==
X-Gm-Message-State: AHYfb5hgpqWATQMnucniSir50jXIua2lOlNR3xA9/scQ4qlR681pVlM6
        cVBV6PICACWpYn+1Mf83S+UR69EJUyho
X-Received: by 10.13.218.129 with SMTP id c123mr14646651ywe.175.1503349720622;
 Mon, 21 Aug 2017 14:08:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 14:08:40 -0700 (PDT)
In-Reply-To: <20170821000022.26729-5-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net> <20170821000022.26729-5-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 14:08:40 -0700
Message-ID: <CAGZ79ka1X5zJwEzH8Pe2vNX8FaKSP_3m6D0Fva4cpO=QUEaeRw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] Add structure representing hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2017 at 5:00 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Since in the future we want to support an additional hash algorithm, add
> a structure that represents a hash algorithm and all the data that must
> go along with it.  Add a constant to allow easy enumeration of hash
> algorithms.  Implement function typedefs to create an abstract API that
> can be used by any hash algorithm, and wrappers for the existing SHA1
> functions that conform to this API.
>
> Don't include an entry in the hash algorithm structure for the null
> object ID.  As this value is all zeros, any suitably sized all-zero
> object ID can be used, and there's no need to store a given one on a
> per-hash basis.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  cache.h     | 36 ++++++++++++++++++++++++++++++++++++
>  sha1_file.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 1c69d2a05a..375a7fb15e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -76,6 +76,42 @@ struct object_id {
>         unsigned char hash[GIT_MAX_RAWSZ];
>  };
>
> +#define GIT_HASH_SHA1 0
> +
> +typedef void (*git_hash_init_fn)(void *ctx);
> +typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
> +typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
> +
> +struct git_hash_algo {
> +       /* The name of the algorithm, as appears in the config file. */
> +       const char *name;

and potentially in error messages?

> +
> +       /* The size of a hash context (e.g. git_SHA_CTX). */
> +       size_t ctxsz;
> +
> +       /* The length of the hash in bytes. */
> +       size_t rawsz;

[in binary, as opposed to the next entry]

> +
> +       /* The length of the hash in hex characters. */
> +       size_t hexsz;

By having two entries for binary and hex size, we current
choice of needing twice as much choice for the human
representation (as is inherent from the binary <-> hex
conversion, one char stores 8 or 4 bit); so this is good to
have. But is it misnamed? (This abstraction only makes
sense if we ever plan to have human readable representation
not factor 2, e.g. base64 for the non-binary representation.
But then the comment is wrong!)

Maybe s/hex characters/string representation suited for humans/ ?
(Bad naming proposal, but still)

> +       /* The hash initialization function. */
> +       git_hash_init_fn init_fn;
> +
> +       /* The hash update function. */
> +       git_hash_update_fn update_fn;
> +
> +       /* The hash finalization function. */
> +       git_hash_final_fn final_fn;

I shortly wondered if we want to have just one
pointer to a struct that contains these 3 functions,
but that seems overly complex.

> +       /* The OID of the empty tree. */
> +       const struct object_id *empty_tree;
> +
> +       /* The OID of the empty blob. */
> +       const struct object_id *empty_blob;

In a more object oriented world, this would
not be as micro-optimized(?), but rather be:

    object o = new object()
    o.getHash()

or such, but we tend to access empty_{blob,tree}
quite often in the code base. So it seems like a good
idea to keep this shortcut around.


> +};
> +extern const struct git_hash_algo hash_algos[1];
> +
>  #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
>  #define DTYPE(de)      ((de)->d_type)
>  #else
> diff --git a/sha1_file.c b/sha1_file.c
> index b60ae15f70..bd9ff02802 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -41,6 +41,35 @@ const struct object_id empty_blob_oid = {
>         EMPTY_BLOB_SHA1_BIN_LITERAL
>  };
>
> +static inline void git_hash_sha1_init(void *ctx)
> +{
> +       git_SHA1_Init((git_SHA_CTX *)ctx);
> +}
> +
> +static inline void git_hash_sha1_update(void *ctx, const void *data, size_t len)
> +{
> +       git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
> +}
> +
> +static inline void git_hash_sha1_final(unsigned char *hash, void *ctx)
> +{
> +       git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
> +}
> +
> +const struct git_hash_algo hash_algos[1] = {
> +       [GIT_HASH_SHA1] = {
> +               .name = "sha-1",
> +               .ctxsz = sizeof(git_SHA_CTX),
> +               .rawsz = GIT_SHA1_RAWSZ,
> +               .hexsz = GIT_SHA1_HEXSZ,
> +               .init_fn = git_hash_sha1_init,
> +               .update_fn = git_hash_sha1_update,
> +               .final_fn = git_hash_sha1_final,
> +               .empty_tree = &empty_tree_oid,
> +               .empty_blob = &empty_blob_oid,
> +       },
> +};

This is the same new pattern as in 512f41cfac (clean.c: use
designated initializer, 2017-07-14)

Maybe we want to keep just one test balloon and not mix
this one in there, too?

> +
>  /*
>   * This is meant to hold a *small* number of objects that you would
>   * want read_sha1_file() to be able to return, but yet you do not want
