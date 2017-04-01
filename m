Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8731FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 04:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750736AbdDAECp (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 00:02:45 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47567 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750703AbdDAECo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 00:02:44 -0400
X-AuditID: 12074412-4bbff70000000b04-68-58df266173c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 96.B6.02820.1662FD85; Sat,  1 Apr 2017 00:02:42 -0400 (EDT)
Received: from [192.168.69.190] (p57906954.dip0.t-ipconnect.de [87.144.105.84])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3142cF9021557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 1 Apr 2017 00:02:39 -0400
Subject: Re: [PATCH v7 19/28] files-backend: replace submodule_allowed check
 in files_downcast()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
 <20170326024241.31984-20-pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4e4fd98d-055d-6e2b-845d-51d3f1c2856f@alum.mit.edu>
Date:   Sat, 1 Apr 2017 06:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170326024241.31984-20-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqJusdj/C4Ow9JouuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGix8tPcwWM69aW2ze3M7iwOGxc9Zddo8PH+M8Fmwq9ehqP8Lm8ax3
        D6PHxUvKHvuXbmPz+LxJLoAjissmJTUnsyy1SN8ugSvj9rGvjAVtihXnjzxkbGDskepi5OSQ
        EDCRWHPxMksXIxeHkMAOJokVVz6yQzjnmCQeTX7NAlIlLJAkseb0F2YQW0QgTWLx5PdgtpDA
        REaJ5esjQBqYBT4zSky5e54RJMEmoCuxqKeZCcTmFbCXuPXpK1gDi4CKRMPtFawgtqhAiMSc
        hQ8YIWoEJU7OfAK0jIODU8BC4lyzMUiYWUBd4s+8S8wQtrxE89bZzBMY+Wch6ZiFpGwWkrIF
        jMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MUIiQGgH4/qTcocYBTgYlXh4
        FfzuRQixJpYVV+YeYpTkYFIS5f1eDBTiS8pPqcxILM6ILyrNSS0+xCjBwawkwpv4BSjHm5JY
        WZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTBK6V6P0JIsCg1PbUiLTOnBCHN
        xMEJMpwHaPgxkBre4oLE3OLMdIj8KUZFKXGIZgGQREZpHlwvLEG9YhQHekWY96sKUBUPMLnB
        db8CGswENNji612QwSWJCCmpBsb0K67C2bNarr8rLLR/PT3xTpTV4r7rRUvNxErjDDK2V/Uf
        y3jxqL3AXtVNba6r4ozPXmyrFqSwzvtT5x8drLp6Tf75w5Ye6iUeG+zFYhWc/5j+DQ47ULKn
        12Be+x33Bn+NQ5oan+IvcXerOJe73ompXeffar59opFoWz7ro44nRreYbqo7KLEUZyQaajEX
        FScCAHncpCsrAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/26/2017 04:42 AM, Nguyễn Thái Ngọc Duy wrote:
> files-backend.c is unlearning submodules. Instead of having a specific
> check for submodules to see what operation is allowed, files backend
> now takes a set of flags at init. Each operation will check if the
> required flags is present before performing.
> 
> For now we have four flags: read, write and odb access. Main ref store
> has all flags, obviously, while submodule stores are read-only and have
> access to odb (*).
> 
> The "main" flag stays because many functions in the backend calls
> frontend ones without a ref store, so these functions always target the
> main ref store. Ideally the flag should be gone after ref-store-aware
> api is in place and used by backends.
> 
> (*) Submodule code needs for_each_ref. Try take REF_STORE_ODB flag
> out. At least t3404 would fail. The "have access to odb" in submodule is
> a bit hacky since we don't know from he whether add_submodule_odb() has
> been called.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c               | 15 +++++++---
>  refs/files-backend.c | 81 +++++++++++++++++++++++++++++++++-------------------
>  refs/refs-internal.h |  9 +++++-
>  3 files changed, 71 insertions(+), 34 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index d72b48a430..241b4227b2 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -1481,7 +1486,9 @@ struct ref_store *get_ref_store(const char *submodule)
>  		return NULL;
>  	}
>  
> -	refs = ref_store_init(submodule_sb.buf);
> +	/* pretend that add_submodule_odb() has been called */

The word "pretend" implies that the thing that follows is not true,
whereas we hope that it *is* true. It would be better to say "assume".

> +	refs = ref_store_init(submodule_sb.buf,
> +			      REF_STORE_READ | REF_STORE_ODB);
>  	register_submodule_ref_store(refs, submodule);
>  
>  	strbuf_release(&submodule_sb);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 490f05a6f4..d97a924860 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> @@ -994,13 +997,17 @@ static struct ref_store *files_ref_store_create(const char *gitdir)
>  }
>  
>  /*
> - * Die if refs is for a submodule (i.e., not for the main repository).
> - * caller is used in any necessary error messages.
> + * Die if refs is not the main ref store. caller is used in any
> + * necessary error messages.
>   */
>  static void files_assert_main_repository(struct files_ref_store *refs,
>  					 const char *caller)
>  {
> -	/* This function is to be fixed up in the next patch */
> +	if (refs->store_flags & REF_STORE_MAIN)
> +		return;
> +
> +	die("BUG: unallowed operation (%s), only works "
> +	    "on main ref store\n", caller);

"Unallowed" isn't really a word; one would say "disallowed". But it
might sound better to say

    BUG: operation %s only allowed for main ref store

>  }
>  
>  /*
> @@ -1009,9 +1016,9 @@ static void files_assert_main_repository(struct files_ref_store *refs,
>   * files_ref_store is for a submodule (i.e., not for the main
>   * repository). caller is used in any necessary error messages.
>   */
> -static struct files_ref_store *files_downcast(
> -		struct ref_store *ref_store, int submodule_allowed,
> -		const char *caller)
> +static struct files_ref_store *files_downcast(struct ref_store *ref_store,
> +					      unsigned int required_flags,
> +					      const char *caller)

The docstring for this function needs to be updated; it still talks
about the old `submodule_allowed` parameter.

>  {
>  	struct files_ref_store *refs;
>  
> @@ -1021,8 +1028,9 @@ static struct files_ref_store *files_downcast(
>  
>  	refs = (struct files_ref_store *)ref_store;
>  
> -	if (!submodule_allowed)
> -		files_assert_main_repository(refs, caller);
> +	if ((refs->store_flags & required_flags) != required_flags)
> +		die("BUG: unallowed operation (%s), requires %x, has %x\n",
> +		    caller, required_flags, refs->store_flags);

Same comment about "unallowed". Maybe

    BUG: operation %s requires abilities 0x%x but only have 0x%x

>  
>  	return refs;
>  }
> [...]

Michael

