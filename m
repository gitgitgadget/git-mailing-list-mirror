Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE8C20281
	for <e@80x24.org>; Sun,  5 Nov 2017 13:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbdKENmm (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 08:42:42 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51150 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750725AbdKENml (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 08:42:41 -0500
X-AuditID: 1207440c-7e5ff7000000143e-cb-59ff154d5e55
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 83.AC.05182.E451FF95; Sun,  5 Nov 2017 08:42:38 -0500 (EST)
Received: from [192.168.69.190] (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA5DgYRA027039
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 08:42:36 -0500
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
To:     =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org
Cc:     me@ikke.info, gitster@pobox.com, hjemli@gmail.com,
        pclouds@gmail.com, ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-2-rafa.almas@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4dc4eefc-56b9-1b13-ae46-83a3af9c7ee3@alum.mit.edu>
Date:   Sun, 5 Nov 2017 14:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171104004144.5975-2-rafa.almas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqOsn+j/SoOebqUXXlW4mi4beK8wW
        S2e9YbRYuWYPs8WrjnZGi+4pbxktPh28yeLA7rHybK3Hzll32T1+3X3J5nHxkrLH501yAaxR
        XDYpqTmZZalF+nYJXBk9uy+wFVzWqDg6u6KB8Y9CFyMnh4SAiUTf4o3sXYxcHEICO5gk2k/t
        ZANJCAmcY5K4v80WxBYW8JG4O6EbKM7BISIQKbFmhw5ImFkgT+LK/mVQ5ekSP1bOYgGx2QR0
        JRb1NDOB2LwC9hKLfi0Cq2ERUJGYP+MQWFxUIELiefN7VogaQYmTM5+wgIznFLCUWHZfHWK8
        usSfeZeYIWxxiVtP5jNB2PISzVtnM09gFJiFpHsWkpZZSFpmIWlZwMiyilEuMac0Vzc3MTOn
        ODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkCnh2MH5bJ3OIUYCDUYmH94THv0gh1sSy4srcQ4yS
        HExKorxXXv6JFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCG7QYqJw3JbGyKrUoHyYlzcGiJM6r
        ukTdDxhaiSWp2ampBalFMFkZDg4lCV4Fkf+RQoJFqempFWmZOSUIaSYOTpDhPEDDJUFqeIsL
        EnOLM9Mh8qcYdTmezXzdwCzEkpeflyolztsKUiQAUpRRmgc3B5a8XjGKA70lzKsGUsUDTHxw
        k14BLWECWjKb4w/IkpJEhJRUA2O9oJTeptDTOkfSbvoeeKwpmn4w/HtD/QXN+w8O2ccpmu7n
        bV2+mCHyqvBdjhcipsobZdQ3xbYXOoSwJP967Pgizvte1+TJOzmX8Vbv+ZN96fnrdXtPSvos
        qXu4sCPt0uI3yT8bLe9oafldXNS8wGito0bYxGvbF7T1Gj3cqdB9n2tF7K+FrSeUWIozEg21
        mIuKEwE/gkqwOQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2017 01:41 AM, Rafael Ascensão wrote:
> `for_each_glob_ref_in` has some code built into it that converts
> partial refs like 'heads/master' to their full qualified form
> 'refs/heads/master'. It also assume a trailing '/*' if no glob
> characters are present in the pattern.
> 
> Extract that logic to its own function which can be reused elsewhere
> where the same behaviour is needed, and add an ENSURE_GLOB flag
> to toggle if a trailing '/*' is to be appended to the result.
> 
> Signed-off-by: Kevin Daudt <me@ikke.info>
> Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
> ---
>  refs.c | 34 ++++++++++++++++++++--------------
>  refs.h | 16 ++++++++++++++++
>  2 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index c590a992f..1e74b48e6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -369,32 +369,38 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
>  	return ret;
>  }
>  
> -int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
> -	const char *prefix, void *cb_data)
> +void normalize_glob_ref(struct strbuf *normalized_pattern, const char *prefix,
> +		const char *pattern, int flags)
>  {
> -	struct strbuf real_pattern = STRBUF_INIT;
> -	struct ref_filter filter;
> -	int ret;
> -
>  	if (!prefix && !starts_with(pattern, "refs/"))
> -		strbuf_addstr(&real_pattern, "refs/");
> +		strbuf_addstr(normalized_pattern, "refs/");
>  	else if (prefix)
> -		strbuf_addstr(&real_pattern, prefix);
> -	strbuf_addstr(&real_pattern, pattern);
> +		strbuf_addstr(normalized_pattern, prefix);
> +	strbuf_addstr(normalized_pattern, pattern);

I realize that the old code did this too, but while you are in the area
it might be nice to simplify the logic from

	if (!prefix && !starts_with(pattern, "refs/"))
		strbuf_addstr(normalized_pattern, "refs/");
	else if (prefix)
		strbuf_addstr(normalized_pattern, prefix);

to

	if (prefix)
		strbuf_addstr(normalized_pattern, prefix);
	else if (!starts_with(pattern, "refs/"))
		strbuf_addstr(normalized_pattern, "refs/");

This would avoid having to check twice whether `prefix` is NULL.

> -	if (!has_glob_specials(pattern)) {
> +	if (!has_glob_specials(pattern) && (flags & ENSURE_GLOB)) {
>  		/* Append implied '/' '*' if not present. */
> -		strbuf_complete(&real_pattern, '/');
> +		strbuf_complete(normalized_pattern, '/');
>  		/* No need to check for '*', there is none. */
> -		strbuf_addch(&real_pattern, '*');
> +		strbuf_addch(normalized_pattern, '*');
>  	}
> +}
> +
> +int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
> +	const char *prefix, void *cb_data)
> +{
> +	struct strbuf normalized_pattern = STRBUF_INIT;
> +	struct ref_filter filter;
> +	int ret;
> +
> +	normalize_glob_ref(&normalized_pattern, prefix, pattern, ENSURE_GLOB);
>  
> -	filter.pattern = real_pattern.buf;
> +	filter.pattern = normalized_pattern.buf;
>  	filter.fn = fn;
>  	filter.cb_data = cb_data;
>  	ret = for_each_ref(filter_refs, &filter);
>  
> -	strbuf_release(&real_pattern);
> +	strbuf_release(&normalized_pattern);
>  	return ret;
>  }
>  
> diff --git a/refs.h b/refs.h
> index a02b628c8..9f9a8bb27 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -312,6 +312,22 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
>  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
>  int for_each_rawref(each_ref_fn fn, void *cb_data);
>  
> +/*
> + * Normalizes partial refs to their full qualified form.
> + * If prefix is NULL, will prepend 'refs/' to the pattern if it doesn't start
> + * with 'refs/'. Results in refs/<pattern>
> + *
> + * If prefix is not NULL will result in <prefix>/<pattern>
> + *
> + * If ENSURE_GLOB is set and no glob characters are found in the
> + * pattern, a trailing </><*> will be appended to the result.
> + * (<> characters to avoid breaking C comment syntax)
> + */
> +
> +#define ENSURE_GLOB 1
> +void normalize_glob_ref (struct strbuf *normalized_pattern, const char *prefix,
> +				const char *pattern, int flags);

There shouldn't be a space between the function name and the open
parenthesis.

You have complicated the interface by allowing an `ENSURE_BLOB` flag.
This would make sense if the logic for normalizing the prefix were
tangled up with the logic for adding the suffix. But in fact they are
almost entirely orthogonal [1].

So the interface might be simplified by having two functions,

    void normalize_glob_ref(normalized_pattern, prefix, pattern);
    void ensure_blob(struct strbuf *pattern);

The caller in this patch would call the functions one after the other
(or the `ensure_blob` behavior could be inlined in
`for_each_glob_ref_in()`, since it doesn't yet have any callers). And
the callers introduced in patch 2 would only need to call the first
function.

>  static inline const char *has_glob_specials(const char *pattern)
>  {
>  	return strpbrk(pattern, "?*[");
> 

Michael

[1] I say "almost entirely" because putting them in one function means
that only `pattern` needs to be scanned for glob characters. But that is
an unimportant detail.
