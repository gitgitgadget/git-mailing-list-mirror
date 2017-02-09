Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4A21FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 05:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdBIF0I (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 00:26:08 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51452 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751482AbdBIF0G (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 00:26:06 -0500
X-AuditID: 1207440e-071ff70000000a39-57-589bfc3acf91
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.74.02617.A3CFB985; Thu,  9 Feb 2017 00:20:58 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v195Kuwk001308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 00:20:57 -0500
Subject: Re: [PATCH 1/2] refs.c: add resolve_ref_submodule()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170208113144.8201-2-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <19bcda56-077e-b0a8-4408-d0012754bf17@alum.mit.edu>
Date:   Thu, 9 Feb 2017 06:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170208113144.8201-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqGv1Z3aEwYIzuhZdV7qZLBp6rzBb
        dE95y+jA7LFz1l12j4uXlD0+b5ILYI7isklJzcksSy3St0vgyljx8xZzwXSJilsrbzM2MDYL
        dzFyckgImEhsnPyQrYuRi0NI4DKjxPZ3PUwQznkmiSsXdjGCVAkL2EjsOXCPGcQWEUiTWDz5
        PZgtJJAocWzHPVYQm1lATaJ90xQwm01AV2JRTzPQIA4OXgF7iQM3HUHCLAIqEtfft4G1igqE
        SMxZ+ABsPK+AoMTJmU9YQGxOATOJ6btvs0CMVJf4M+8SM4QtL9G8dTbzBEb+WUhaZiEpm4Wk
        bAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2MkADl28HYvl7mEKMAB6MS
        D+8F69kRQqyJZcWVuYcYJTmYlER586KAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4nU8D5XhT
        EiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErztv4AaBYtS01Mr0jJzShDS
        TBycIMN5gIZ7gdTwFhck5hZnpkPkTzEqSonzxoMkBEASGaV5cL2wBPKKURzoFWFewd9AVTzA
        5APX/QpoMBPQ4OunZ4EMLklESEk1MGYaVrwQ81+0IEn68fG65U1vs+XrN9sZP/116c+sfXcc
        KoKz7AWL41gevZj+1rz4AUfZJHGjT9LmJy7Iz1S/ltxhYxvLydqy58warqMf03axZXarJZyS
        9Xmv/TJq28/E+vRnE3ltX9kVSgSUe02YsM5+2eXps43nebSIRlU19ypuDFbv51q0UomlOCPR
        UIu5qDgRAPe98or7AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08/2017 12:31 PM, Nguyễn Thái Ngọc Duy wrote:
> This is basically the extended version of resolve_gitlink_ref() where we
> have access to more info from the underlying resolve_ref_recursively() call.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 20 ++++++++++++++------
>  refs.h |  3 +++
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index cd36b64ed9..02e35d83f3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1325,18 +1325,18 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>  				       resolve_flags, sha1, flags);
>  }
>  
> -int resolve_gitlink_ref(const char *submodule, const char *refname,
> -			unsigned char *sha1)
> +const char *resolve_ref_submodule(const char *submodule, const char *refname,
> +				  int resolve_flags, unsigned char *sha1,
> +				  int *flags)
>  {
>  	size_t len = strlen(submodule);
>  	struct ref_store *refs;
> -	int flags;
>  
>  	while (len && submodule[len - 1] == '/')
>  		len--;
>  
>  	if (!len)
> -		return -1;
> +		return NULL;
>  
>  	if (submodule[len]) {
>  		/* We need to strip off one or more trailing slashes */
> @@ -1349,9 +1349,17 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
>  	}
>  
>  	if (!refs)
> -		return -1;
> +		return NULL;
> +
> +	return resolve_ref_recursively(refs, refname, resolve_flags, sha1, flags);
> +}
> +
> +int resolve_gitlink_ref(const char *submodule, const char *refname,
> +			unsigned char *sha1)
> +{
> +	int flags;
>  
> -	if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
> +	if (!resolve_ref_submodule(submodule, refname, 0, sha1, &flags) ||
>  	    is_null_sha1(sha1))
>  		return -1;
>  	return 0;
> diff --git a/refs.h b/refs.h
> index 9fbff90e79..74542468d8 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -88,6 +88,9 @@ int peel_ref(const char *refname, unsigned char *sha1);
>   */
>  int resolve_gitlink_ref(const char *submodule, const char *refname,
>  			unsigned char *sha1);
> +const char *resolve_ref_submodule(const char *submodule, const char *refname,
> +				  int resolve_flags, unsigned char *sha1,
> +				  int *flags);

This function is the analog of resolve_ref_unsafe(); i.e., it returns a
pointer to either a static buffer or a pointer into the refname
argument. Therefore, I think it should have "unsafe" in its name. And/or
maybe there should be a safe version of the function analogous to
resolve_refdup().

Moreover, this function has inherited the code for stripping trailing
slashes from the submodule name. I have the feeling that this is a wart,
not a feature, and that it would be sad to see it spread. How about
moving the slash-stripping code to resolve_gitlink_ref() and making
resolve_ref_submodule() assume that its submodule name is already clean?

It would be nice to have a docstring here.

I also have some higher-level concerns about the approach of this patch
series, which I'll write about in a comment to patch 2/2.

Michael

