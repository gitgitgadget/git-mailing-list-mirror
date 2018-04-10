Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FFA1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 14:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDJODB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 10:03:01 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:60986 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753135AbeDJODA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Apr 2018 10:03:00 -0400
X-AuditID: 12074413-b6bff70000006608-85-5accc41335da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C0.44.26120.314CCCA5; Tue, 10 Apr 2018 10:02:59 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC7F4.dip0.t-ipconnect.de [87.188.199.244])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w3AE2uQR025573
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 10 Apr 2018 10:02:57 -0400
Subject: Re: [PATCH 12/16] refs: store the main ref store inside the
 repository struct
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.us, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-13-sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2c6214de-36b0-c67b-9a40-d43d28e780c4@alum.mit.edu>
Date:   Tue, 10 Apr 2018 16:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409224533.17764-13-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqCt85EyUQdNCSYuuK91MFtvOOVmc
        2drPbNE95S2jRdvMH0wWmze3s1jM33uO0YHdY/nNv0weO2fdZfdYsKnU48q9p6wenzfJedx+
        to0lgC2KyyYlNSezLLVI3y6BK2PLkR6mgl8yFZ9edjI2MG4R72Lk5JAQMJH4+n0WcxcjF4eQ
        wA4miX2fehhBEkICF5gkJr5jBrGFBSIk/p5bBhYXEVCTmLlqNhtIA7PAREaJ3Wu3skB0T2WU
        2LJ3KxtIFZuArsSinmYmEJtXwF7i6JprYDaLgKrE2tYjLCC2KNDUe+c/sUHUCEqcnPkELM4p
        YClxdPpisDizgLrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCgwC0n7LCQts5C0zELSsoCRZRWj
        XGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZGSGQI72DcdVLuEKMAB6MSD++Eg6ej
        hFgTy4orcw8xSnIwKYny7u4/EyXEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDdnLVCONyWxsiq1
        KB8mJc3BoiTOy2yyN0pIID2xJDU7NbUgtQgmK8PBoSTBO+EwUKNgUWp6akVaZk4JQpqJgxNk
        OA/QcAaQGt7igsTc4sx0iPwpRl2OO209PcxCLHn5ealS4rycIEUCIEUZpXlwc2AJ7RWjONBb
        wrwpIFU8wGQIN+kV0BImoCXHfMCWlCQipKQaGOWmh0QbvP7K673CuvZLzmwvrkk1Pe+rZjw9
        LLrG7drSV6erPhVmJiWz/5jVpBuXuTmu7ebZe4t1Z8em+ki3Btftso3kz1/jppX7ol1szj3G
        yFPfn8hO4ruqrifENznsSPoVdnbtCwuL/LyrBBc8Vqjlnf80JvGFztod/Ubq/u0b5vavWDEt
        W4mlOCPRUIu5qDgRAH7bcQ5DAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/2018 12:45 AM, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c       | 13 +++++--------
>  refs.h       |  4 +---
>  repository.h |  3 +++
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index f58b9fb7df..b5be754a97 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1608,9 +1608,6 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
>  	return entry;
>  }
>  
> -/* A pointer to the ref_store for the main repository: */
> -static struct ref_store *main_ref_store;
> -
>  /* A hashmap of ref_stores, stored by submodule name: */
>  static struct hashmap submodule_ref_stores;
>  
> @@ -1652,13 +1649,13 @@ static struct ref_store *ref_store_init(const char *gitdir,
>  	return refs;
>  }
>  
> -struct ref_store *get_main_ref_store_the_repository(void)
> +struct ref_store *get_main_ref_store(struct repository *r)
>  {
> -	if (main_ref_store)
> -		return main_ref_store;
> +	if (r->main_ref_store)
> +		return r->main_ref_store;
>  
> -	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
> -	return main_ref_store;
> +	r->main_ref_store = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
> +	return r->main_ref_store;
>  }
>  
>  /*
> diff --git a/refs.h b/refs.h
> index ab3d2bec2f..f5ab68c0ed 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -760,9 +760,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
>  
>  int ref_storage_backend_exists(const char *name);
>  
> -#define get_main_ref_store(r) \
> -	get_main_ref_store_##r()
> -struct ref_store *get_main_ref_store_the_repository(void);
> +struct ref_store *get_main_ref_store(struct repository *r);
>  /*
>   * Return the ref_store instance for the specified submodule. For the
>   * main repository, use submodule==NULL; such a call cannot fail. For
> diff --git a/repository.h b/repository.h
> index 09df94a472..7d0710b273 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -26,6 +26,9 @@ struct repository {
>  	 */
>  	struct raw_object_store *objects;
>  
> +	/* The store in which the refs are held. */
> +	struct ref_store *main_ref_store;
> +
>  	/*
>  	 * Path to the repository's graft file.
>  	 * Cannot be NULL after initialization.
> 

This also makes sense to me, as far as it goes. I have a few comments
and questions:

Why do you call the new member `main_ref_store`? Is there expected to be
some other `ref_store` associated with a repository?

I think the origin of the name `main_ref_store` was to distinguish it
from submodule ref stores. But presumably those will soon become the
"main" ref stores for their respective submodule repository objects,
right? So maybe calling things `repository.ref_store` and
`get_ref_store(repository)` would be appropriate.

There are some places in the reference code that only work with the main
repository. The ones that I can think of are:

* `ref_resolves_to_object()` depends on an object store.

* `peel_object()` and `ref_iterator_peel()` also have to look up objects
(in this case, tag objects).

* Anything that calls `files_assert_main_repository()` or depends on
`REF_STORE_MAIN` isn't implemented for other reference stores (usually,
I think, these are functions that depend on the object store).

Some of these things might be easy to generalize to non-main
repositories, but I didn't bother because AFAIK currently only the main
repository store is ever mutated.

You can move a now-obsolete comment above the definition of `struct
files_ref_store` if you haven't in some other patch (search for
"libification").

Hope that helps,
Michael
