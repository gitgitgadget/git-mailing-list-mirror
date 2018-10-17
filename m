Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0794B1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJQV2I (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 17:28:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35516 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeJQV2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 17:28:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id y19-v6so24875990edd.2
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j02z2zsJDVrZbhFqdQ+5Nn2zmUF92pz9zFfyL8Jdz1c=;
        b=HlbIdA1T8MrUWGndwdMHdNIaLiyAEQgsO5KWMimwFuaMddQn2/OJ1Oob58VRkmlYUV
         fDCkYzVW0hzt5dHKcHPdxQ0yvJTEh6L7MtRMGNris3Cg8gYb5m9HkPrG0MerzWd4JJ3/
         YJGrGJkoMenZlg+W9rjKq8VGyaee4woyn5TIIkCFV5MurB8KgaHrwXHZJ5fxY/f9px3L
         /X3Uhy4wqgcSavnKesErdDQpdmKIjAKHNBMaYHBOqD5lQ74NxC7dbJWvIvD1HWVY7r5G
         ujmnKs+8dEOzhqG4899Hw7orKuTfEV8i2BqzUlMIiwWsCbOQD52kQYcC8+HhLFWX83n/
         IKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j02z2zsJDVrZbhFqdQ+5Nn2zmUF92pz9zFfyL8Jdz1c=;
        b=OLr7ONvqWxe++yiRdzAgKIPdoXCF/bF7q9jF/QDciJZ6YPGUArP9AhcyO03EZZwVJv
         G4euuijnoOThYLIwKFpK17MLSLh07R1YpBTh5sxgLC3Ta0umciV3FzGO2jAmaj0AA0Cw
         GeTyjj48Ru35Bf1xr28JaMuKRbXuhiFThkqMu1wflm9ZX0oc+yZIdvwst/+R/P/ATcyo
         upsbQXiiaYDM/AJ4z13SudR4sGOzl7VVuKilK6eygp1yXx6JHRKOcFQY31SxuIAsXXMN
         45B489PEW839S+kqyib3ionzBBqPmmrZlMtFOa7ceG2Wu4MuQI7PcymvA4nKSbVgNFRw
         VXDQ==
X-Gm-Message-State: ABuFfojA2/pLwmJKhRQ5j7OY60mkBg+ErlMsPoaNbjUWELoLEYL0/G1u
        XX8eShXObY9wxaFWg077i/A=
X-Google-Smtp-Source: ACcGV62XLUfqvaZozeIrZFLymsbzbjPC260cR1wWDvJq73503oBnUaVwzCIpF1zcntjwUZfFnIxrjA==
X-Received: by 2002:a17:906:5512:: with SMTP id r18-v6mr26801856ejp.15.1539783143501;
        Wed, 17 Oct 2018 06:32:23 -0700 (PDT)
Received: from szeder.dev (x4db11ffa.dyn.telefonica.de. [77.177.31.250])
        by smtp.gmail.com with ESMTPSA id u14-v6sm3593081ejr.12.2018.10.17.06.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:32:22 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:32:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 02/13] sha1-file: provide functions to look up hash
 algorithms
Message-ID: <20181017133220.GQ19800@szeder.dev>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015021900.1030041-3-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 02:18:49AM +0000, brian m. carlson wrote:
> There are several ways we might refer to a hash algorithm: by name, such
> as in the config file; by format ID, such as in a pack; or internally,
> by a pointer to the hash_algos array.  Provide functions to look up hash
> algorithms based on these various forms and return the internal constant
> used for them.  If conversion to another form is necessary, this
> internal constant can be used to look up the proper data in the
> hash_algos array.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  hash.h      | 13 +++++++++++++
>  sha1-file.c | 21 +++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/hash.h b/hash.h
> index 7c8238bc2e..90f4344619 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -98,4 +98,17 @@ struct git_hash_algo {
>  };
>  extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
>  
> +/*
> + * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
> + * the name doesn't match a known algorithm.
> + */
> +int hash_algo_by_name(const char *name);
> +/* Identical, except based on the format ID. */
> +int hash_algo_by_id(uint32_t format_id);
> +/* Identical, except for a pointer to struct git_hash_algo. */
> +inline int hash_algo_by_ptr(const struct git_hash_algo *p)

This has to be declared as static, otherwise the linker will error out
when building without optimization:

    LINK git
libgit.a(commit-graph.o): In function `oid_version':
/home/szeder/src/git/commit-graph.c:48: undefined reference to `hash_algo_by_ptr'
libgit.a(hex.o): In function `hash_to_hex':
/home/szeder/src/git/hex.c:123: undefined reference to `hash_algo_by_ptr'
libgit.a(hex.o): In function `oid_to_hex':
/home/szeder/src/git/hex.c:128: undefined reference to `hash_algo_by_ptr'
collect2: error: ld returned 1 exit status
Makefile:2055: recipe for target 'git' failed
make: *** [git] Error 1


> +{
> +	return p - hash_algos;
> +}
> +
>  #endif
> diff --git a/sha1-file.c b/sha1-file.c
> index e29825f259..3a75d515eb 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -122,6 +122,27 @@ const char *empty_blob_oid_hex(void)
>  	return oid_to_hex_r(buf, the_hash_algo->empty_blob);
>  }
>  
> +int hash_algo_by_name(const char *name)
> +{
> +	int i;
> +	if (!name)
> +		return GIT_HASH_UNKNOWN;
> +	for (i = 1; i < GIT_HASH_NALGOS; i++)
> +		if (!strcmp(name, hash_algos[i].name))
> +			return i;
> +	return GIT_HASH_UNKNOWN;
> +}
> +
> +int hash_algo_by_id(uint32_t format_id)
> +{
> +	int i;
> +	for (i = 1; i < GIT_HASH_NALGOS; i++)
> +		if (format_id == hash_algos[i].format_id)
> +			return i;
> +	return GIT_HASH_UNKNOWN;
> +}
> +
> +
>  /*
>   * This is meant to hold a *small* number of objects that you would
>   * want read_sha1_file() to be able to return, but yet you do not want
