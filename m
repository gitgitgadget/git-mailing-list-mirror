Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F711F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfIZRU1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:20:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39531 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZRU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:20:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id o10so1909753pgs.6
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tfxr1S3K/WlReLYl8eXbRSgLFNoKVrdv72SFrxg9JRU=;
        b=jIVIUygowGayrsyqIXOev5TtGtPsEOhXjNbb7HBXy9lFh9ARVZ4/7cPI6yILKZMl7C
         P6qoHVeKc9m6j+1iBJ8LKM/qKOO3x5pfCqsZI3QLh/RSH1S6vPYAo3ZkqIraExJ7FqRC
         nQFLcbolbT1/OOoctxw1g3U1M6gmPxglTvhtwfvgDhfnKwxe1d8/4Ok9U7Z8cSMnLl/U
         f9qa1JmZ4pVUxgp4K0NmYHEEmP/Qw2hZN52unerSXF7SR7Wvwkjibl2knOl7HJoGv9vA
         qjJ+TgH++CrGDVpLuCMkE9mlLXPsH0EXKBMO6/w8ekbc0VGChpdfFoNLQ92uXnHuRYi3
         JJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tfxr1S3K/WlReLYl8eXbRSgLFNoKVrdv72SFrxg9JRU=;
        b=I9xgo3ZtxkwDFqWNLky280R6Nn/ZY+O7yb09oqpitmX5SV5B4HesoXc58ti0p/YL7Q
         tS6Q60t9Ic7oeVxsxEPCexJAPw7TTsMJ15ZIRbk6RDh6oeUlaiTkdYTtonQJBFtYGaTC
         1jc6xwKiX4I3UBMjhkrscnq4uAH++yt1u3sBuFnWIjuKYEp6aFbjwnaWMyXsKmf4Affl
         egaKLuOJXLC6/P4S+u8ONpi3PgoU2T2PnlQdJ+MX3OES7W+ijkQ0MOMffx9FfKBg0APg
         XnA6iPdpebTvtCXvfIgvPIctQhI4KhCtWw6fTQOKsBEtpQiTcgQ5ANNDQM+W7Le0mgMN
         g6xA==
X-Gm-Message-State: APjAAAVIKLS2lIi49QzLnlZwrb3Nff47FM122RrdsS2B6Jhb0ah2Nhmx
        os9iB5n7Xp7+VsRZvHae+r4=
X-Google-Smtp-Source: APXvYqxuXN/8rISRItFw7fT8gca/js8R7FOEhjGa8/XnSf3aguu8R+a3n0kmrP+8Gq5qexJi5ciK6w==
X-Received: by 2002:a17:90a:c8a:: with SMTP id v10mr4722850pja.4.1569518426101;
        Thu, 26 Sep 2019 10:20:26 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id g5sm3355084pfh.133.2019.09.26.10.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:20:24 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:20:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/13] msvc: avoid using minus operator on unsigned types
Message-ID: <20190926172022.GA41037@generichostname>
References: <pull.288.git.gitgitgadget@gmail.com>
 <2abe1e1fb0bf3025489c2e543b9a9c648a164827.1569486607.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abe1e1fb0bf3025489c2e543b9a9c648a164827.1569486607.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 26, 2019 at 01:30:10AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> MSVC complains about this with `-Wall`, which can be taken as a sign
> that this is indeed a real bug. The symptom is:
> 
> 	C4146: unary minus operator applied to unsigned type, result
> 	still unsigned
> 
> Let's avoid this warning in the minimal way, e.g. writing `-1 -
> <unsigned value>` instead of `-<unsigned value> - 1`.

[...]

> ---
>  read-cache.c  | 4 ++--
>  sha1-lookup.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index c701f7f8b8..11f3357216 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1276,7 +1276,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>  	 */
>  	if (istate->cache_nr > 0 &&
>  		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
> -		pos = -istate->cache_nr - 1;
> +		pos = -1 - istate->cache_nr;

I've been thinking about this and I'm still not certain that this 100%
correct from a language-lawyer perspective.

If we do `-1 - istate->cache_nr`, then the unsignedness of
istate->cache_nr takes over and the whole expression is a very large
unsigned number.

Then, when we assign to `int pos`, we are converting an unsigned number
which is out of the range of the signed number. According to a
StackOverflow post citing the C99 standard[1]:

	Otherwise, the new type is signed and the value cannot be
	represented in it; either the result is implementation-defined
	or an implementation-defined signal is raised.

I'm sure that most platforms that we support will handle it sanely but
could we write this as

	pos = -1 - (int) istate->cache_nr;

to be doubly sure that no funny business will happen?

>  	else
>  		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
>  
> @@ -1894,7 +1894,7 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>  	/*
>  	 * Account for potential alignment differences.
>  	 */
> -	per_entry += align_padding_size(sizeof(struct cache_entry), -sizeof(struct ondisk_cache_entry));
> +	per_entry += align_padding_size(per_entry, 0);
>  	return ondisk_size + entries * per_entry;
>  }
>  
> diff --git a/sha1-lookup.c b/sha1-lookup.c
> index 796ab68da8..c819687730 100644
> --- a/sha1-lookup.c
> +++ b/sha1-lookup.c
> @@ -97,7 +97,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
>  			lo = mi + 1;
>  		mi = lo + (hi - lo) / 2;
>  	} while (lo < hi);
> -	return -lo-1;
> +	return -1 - lo;

Same thing here.

[1]: https://stackoverflow.com/questions/50605/signed-to-unsigned-conversion-in-c-is-it-always-safe

>  }
>  
>  int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
> -- 
> gitgitgadget
> 
