Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62433202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 23:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbdJ3XgU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 19:36:20 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:45268 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdJ3XgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 19:36:19 -0400
Received: by mail-io0-f180.google.com with SMTP id i38so31082495iod.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADaGjYBuMnXtEuy8fJJzMXSJCvvu/QVZ5P5DKIK2Ois=;
        b=DRNNJfgcUErJ2+Tv6vkWmHFUydJzdxD+jQ0Jrfq/mOEaKnFDzpqx3o09XPBsCBaRle
         oiJLIgZrayh0rhp7oRFQYEAHw2Vk1B9+u1CijanVA2CiTiUcMuLYsjuDn3jJTsbFXFOn
         lXQEYa4JhiQoEYjy3BQoJRrnaNcHbmHBKql6qnvPQbFRVTW5euLzvMThVJuOtwyUk7/O
         mVtPopn/UpTg9NwIZMh4J1z/LARaw4dFMUeoCgbqQ0aGz8YbPH8sgEjHFT47bfYmkHh9
         bgsb2zsTEnK1BhjBYz6bsjBJBmBs1skCcIGz2gxJDjqCyWTcoJBJiCd11N0697xm3sAy
         0MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADaGjYBuMnXtEuy8fJJzMXSJCvvu/QVZ5P5DKIK2Ois=;
        b=W73jV3fcVAztXwhc2VjQ+UQ9jogRtfX+goJt8+RZ2SxW5hTg2wtoOocMu30znb7IOL
         JUfcv1wY2FefAnU8oXDGKKPP2uBJlXVZOyDVkP18dkOKqyQCahRJAxROfdnYBULCJpu3
         MaffMu4V6gpski9IZZgAnEz1LzYPqUwz0ZbHs4awAX8qZ+Xcx671715SmFIUp826MQnv
         pC3zVam8Sjxh/P7h9/l/MCp03KLdYrz7h1otfjNYmr3s7EtDhyV3ua4jStIQBi2LtqUA
         6vxv+bVfwRSha9TbBpgKxHB20hSd4yfzG5DX6bqypRhTn/A5O5/hOvDKHUt1HRSiPLmY
         x8YQ==
X-Gm-Message-State: AMCzsaUHuhBx9k/WXPYwuYhh6i0FLysNBl8W9Z2Mvowbun6A+AUCZIdd
        HYwJ4zjcHSfZDCPbNhGukH9YRg==
X-Google-Smtp-Source: ABhQp+QY5Dlj3l5UK7I+OgaICaanbcA2cTCZ1qNKXeLKTvXa0WE0rvoUHsOO0pfKMrVGwtoHkzy+Fg==
X-Received: by 10.36.131.203 with SMTP id d194mr603421ite.5.1509406578231;
        Mon, 30 Oct 2017 16:36:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9c29:988d:323f:ada0])
        by smtp.gmail.com with ESMTPSA id a139sm208257ita.24.2017.10.30.16.36.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 16:36:17 -0700 (PDT)
Date:   Mon, 30 Oct 2017 16:36:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 2/4] Add structure representing hash algorithm
Message-ID: <20171030233615.GA94048@google.com>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
 <20171028181239.59458-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171028181239.59458-3-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/28, brian m. carlson wrote:
> Since in the future we want to support an additional hash algorithm, add
> a structure that represents a hash algorithm and all the data that must
> go along with it.  Add a constant to allow easy enumeration of hash
> algorithms.  Implement function typedefs to create an abstract API that
> can be used by any hash algorithm, and wrappers for the existing SHA1
> functions that conform to this API.
> 
> Expose a value for hex size as well as binary size.  While one will
> always be twice the other, the two values are both used extremely
> commonly throughout the codebase and providing both leads to improved
> readability.
> 
> Don't include an entry in the hash algorithm structure for the null
> object ID.  As this value is all zeros, any suitably sized all-zero
> object ID can be used, and there's no need to store a given one on a
> per-hash basis.
> 
> The current hash function transition plan envisions a time when we will
> accept input from the user that might be in SHA-1 or in the NewHash
> format.  Since we cannot know which the user has provided, add a
> constant representing the unknown algorithm to allow us to indicate that
> we must look the correct value up.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I believe I did get the format_id constant for SHA-1 right, but
> sanity-checking would be appreciated.  We don't want another Referer
> mess.
> 
>  cache.h     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sha1_file.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index 6440e2bf21..9e9eb08f05 100644
> --- a/cache.h
> +++ b/cache.h

Maybe it would be good to place this interface in its own header file
that way we can avoid cluttering cache.h with more stuff?

> @@ -77,6 +77,61 @@ struct object_id {
>  	unsigned char hash[GIT_MAX_RAWSZ];
>  };
>  
> +/*
> + * Note that these constants are suitable for indexing the hash_algos array and
> + * comparing against each other, but are otherwise arbitrary, so they should not
> + * be exposed to the user or serialized to disk.  To know whether a
> + * git_hash_algo struct points to some usable hash function, test the format_id
> + * field for being non-zero.  Use the name field for user-visible situations and
> + * the format_id field for fixed-length fields on disk.
> + */
> +/* An unknown hash function. */
> +#define GIT_HASH_UNKNOWN 0
> +/* SHA-1 */
> +#define GIT_HASH_SHA1 1
> +/* Number of algorithms supported (including unknown). */
> +#define GIT_HASH_NALGOS (GIT_HASH_SHA1 + 1)
> +
> +typedef void (*git_hash_init_fn)(void *ctx);
> +typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
> +typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
> +
> +struct git_hash_algo {
> +	/*
> +	 * The name of the algorithm, as appears in the config file and in
> +	 * messages.
> +	 */
> +	const char *name;
> +
> +	/* A four-byte version identifier, used in pack indices. */
> +	uint32_t format_id;
> +
> +	/* The size of a hash context (e.g. git_SHA_CTX). */
> +	size_t ctxsz;
> +
> +	/* The length of the hash in binary. */
> +	size_t rawsz;
> +
> +	/* The length of the hash in hex characters. */
> +	size_t hexsz;
> +
> +	/* The hash initialization function. */
> +	git_hash_init_fn init_fn;
> +
> +	/* The hash update function. */
> +	git_hash_update_fn update_fn;
> +
> +	/* The hash finalization function. */
> +	git_hash_final_fn final_fn;
> +
> +	/* The OID of the empty tree. */
> +	const struct object_id *empty_tree;
> +
> +	/* The OID of the empty blob. */
> +	const struct object_id *empty_blob;
> +};
> +extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
> +
>  #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
>  #define DTYPE(de)	((de)->d_type)
>  #else
> diff --git a/sha1_file.c b/sha1_file.c
> index 10c3a0083d..77b320126a 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -39,6 +39,49 @@ const struct object_id empty_blob_oid = {
>  	EMPTY_BLOB_SHA1_BIN_LITERAL
>  };
>  
> +static inline void git_hash_sha1_init(void *ctx)
> +{
> +	git_SHA1_Init((git_SHA_CTX *)ctx);
> +}
> +
> +static inline void git_hash_sha1_update(void *ctx, const void *data, size_t len)
> +{
> +	git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
> +}
> +
> +static inline void git_hash_sha1_final(unsigned char *hash, void *ctx)
> +{
> +	git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
> +}
> +
> +const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
> +	{
> +		NULL,
> +		0x00000000,
> +		0,
> +		0,
> +		0,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +	},
> +	{
> +		"sha-1",
> +		/* "sha1", big-endian */
> +		0x73686131,
> +		sizeof(git_SHA_CTX),
> +		GIT_SHA1_RAWSZ,
> +		GIT_SHA1_HEXSZ,
> +		git_hash_sha1_init,
> +		git_hash_sha1_update,
> +		git_hash_sha1_final,
> +		&empty_tree_oid,
> +		&empty_blob_oid,
> +	},
> +};
> +
>  /*
>   * This is meant to hold a *small* number of objects that you would
>   * want read_sha1_file() to be able to return, but yet you do not want
> -- 
> 2.15.0.rc2
> 

-- 
Brandon Williams
