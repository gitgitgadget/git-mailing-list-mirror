Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8179F20133
	for <e@80x24.org>; Fri,  3 Mar 2017 14:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdCCOfx (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 09:35:53 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51359 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751529AbdCCOfP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 09:35:15 -0500
X-AuditID: 1207440f-141ff70000003517-fc-58b97e6b0810
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C6.C0.13591.B6E79B85; Fri,  3 Mar 2017 09:32:12 -0500 (EST)
Received: from [192.168.69.190] (p5B105007.dip0.t-ipconnect.de [91.16.80.7])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v23EW7qr030438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 3 Mar 2017 09:32:08 -0500
Subject: Re: [PATCH v5 15/24] refs: move submodule code out of files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-16-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <aef3916b-6c10-6fbd-7f5c-4693f0cbd700@alum.mit.edu>
Date:   Fri, 3 Mar 2017 15:32:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-16-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1M2p2xlh8OOGsEXXlW4mi4beK8wW
        /cu72CyWPHzNbNE95S2jxcyr1habN7ezOLB77Jx1l93jw8c4jwWbSj262o+weVy8pOyxf+k2
        No/Pm+QC2KO4bFJSczLLUov07RK4MvrbpzEV3NSo6L0e18B4SqGLkZNDQsBE4sWMayxdjFwc
        QgI7mCT2fn/FDOGcZpK4ePMmK0iVsICfxP2GI0wgtohAmsTiye+hiiYwSsxpWMAI4jAL3GCU
        uDTxI1gVm4CuxKKeZjCbV8Be4tGqDYwgNouAisTcndeYQWxRgRCJOQsfMELUCEqcnPkE6A4O
        Dk4BC4mPj7NAwswC6hJ/5l1ihrDlJZq3zmaewMg/C0nHLCRls5CULWBkXsUol5hTmqubm5iZ
        U5yarFucnJiXl1qka6KXm1mil5pSuokREuz8Oxi71sscYhTgYFTi4dWw3xEhxJpYVlyZe4hR
        koNJSZT3UMHOCCG+pPyUyozE4oz4otKc1OJDjBIczEoivK2VQDnelMTKqtSifJiUNAeLkjiv
        +hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvTi1Qo2BRanpqRVpmTglCmomDE2Q4D9BwUZAa3uKC
        xNzizHSI/ClGRSlx3iyQhABIIqM0D64XloxeMYoDvSLMawdSxQNMZHDdr4AGMwEN9pMBG1yS
        iJCSamBkWyx+zGBS8Pk21u7bT5PXnzxXVM3zdsXegrBHCR8eyrXNOnQ1ot6MwyBJ9Na3d8FW
        GgtFzCZ5MDHN5HqeXHy1bm7Q5PWqrTHuQs6rHp1INLLcGPuJ7ebNaXkMX2/mCQW/3TNH8Nu2
        5Tuf8vme+pzk/mjlBNufr24xeyZIrvVk6VWNDTXIjDiuxFKckWioxVxUnAgArVRgEiEDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> files-backend is now initialized with a $GIT_DIR. Converting a submodule
> path to where real submodule gitdir is located is done in get_ref_store().
> 
> This gives a slight performance improvement for submodules since we
> don't convert submodule path to gitdir at every backend call like
> before. We pay that once at ref-store creation.
> 
> More cleanup in files_downcast() and files_assert_main_repository()
> follows shortly. It's separate to keep noises from this patch.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c               | 20 ++++++++++++++------
>  refs/files-backend.c | 24 ++----------------------
>  refs/refs-internal.h |  9 ++++-----
>  3 files changed, 20 insertions(+), 33 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 562834fc0..67acae60c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -9,6 +9,7 @@
>  #include "refs/refs-internal.h"
>  #include "object.h"
>  #include "tag.h"
> +#include "submodule.h"
>  
>  /*
>   * List of all available backends
> @@ -1413,9 +1414,9 @@ static struct ref_store *lookup_submodule_ref_store(const char *submodule)
>  
>  /*
>   * Create, record, and return a ref_store instance for the specified
> - * submodule (or the main repository if submodule is NULL).
> + * gitdir.
>   */
> -static struct ref_store *ref_store_init(const char *submodule)
> +static struct ref_store *ref_store_init(const char *gitdir)
>  {
>  	const char *be_name = "files";
>  	struct ref_storage_be *be = find_ref_storage_backend(be_name);
> @@ -1424,7 +1425,7 @@ static struct ref_store *ref_store_init(const char *submodule)
>  	if (!be)
>  		die("BUG: reference backend %s is unknown", be_name);
>  
> -	refs = be->init(submodule);
> +	refs = be->init(gitdir);
>  	return refs;
>  }
>  
> @@ -1435,7 +1436,7 @@ struct ref_store *get_main_ref_store(void)
>  	if (main_ref_store)
>  		return main_ref_store;
>  
> -	refs = ref_store_init(NULL);
> +	refs = ref_store_init(get_git_dir());
>  	if (refs) {
>  		if (main_ref_store)
>  			die("BUG: main_ref_store initialized twice");
> @@ -1466,6 +1467,7 @@ struct ref_store *get_ref_store(const char *submodule)
>  {
>  	struct strbuf submodule_sb = STRBUF_INIT;
>  	struct ref_store *refs;
> +	int ret;
>  
>  	if (!submodule || !*submodule) {
>  		return get_main_ref_store();
> @@ -1476,8 +1478,14 @@ struct ref_store *get_ref_store(const char *submodule)
>  		return refs;
>  
>  	strbuf_addstr(&submodule_sb, submodule);
> -	if (is_nonbare_repository_dir(&submodule_sb))
> -		refs = ref_store_init(submodule);
> +	ret = is_nonbare_repository_dir(&submodule_sb);
> +	strbuf_release(&submodule_sb);
> +	if (!ret)
> +		return refs;

`refs` is always NULL here, right? Then it would be more transparent to
return NULL. Or maybe use the `goto cleanup` pattern, which makes it
clearer which are error-handling paths (and lets you get avoid the
temporary variable `ret`)).

> +
> +	ret = submodule_to_gitdir(&submodule_sb, submodule);
> +	if (!ret)
> +		refs = ref_store_init(submodule_sb.buf);
>  	strbuf_release(&submodule_sb);
>  
>  	if (refs)
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index d80c27837..37443369b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -917,12 +917,6 @@ struct packed_ref_cache {
>  struct files_ref_store {
>  	struct ref_store base;
>  
> -	/*
> -	 * The name of the submodule represented by this object, or
> -	 * NULL if it represents the main repository's reference
> -	 * store:
> -	 */
> -	const char *submodule;
>  	char *gitdir;
>  	char *gitcommondir;
>  	char *packed_refs_path;
> @@ -982,22 +976,14 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>   * Create a new submodule ref cache and add it to the internal
>   * set of caches.
>   */
> -static struct ref_store *files_ref_store_create(const char *submodule)
> +static struct ref_store *files_ref_store_create(const char *gitdir)
>  {
>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>  	struct ref_store *ref_store = (struct ref_store *)refs;
>  	struct strbuf sb = STRBUF_INIT;
> -	const char *gitdir = get_git_dir();
>  
>  	base_ref_store_init(ref_store, &refs_be_files);
>  
> -	if (submodule) {
> -		refs->submodule = xstrdup(submodule);
> -		refs->packed_refs_path = git_pathdup_submodule(
> -			refs->submodule, "packed-refs");
> -		return ref_store;
> -	}
> -
>  	refs->gitdir = xstrdup(gitdir);
>  	get_common_dir_noenv(&sb, gitdir);
>  	refs->gitcommondir = strbuf_detach(&sb, NULL);
> @@ -1014,8 +1000,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
>  static void files_assert_main_repository(struct files_ref_store *refs,
>  					 const char *caller)
>  {
> -	if (refs->submodule)
> -		die("BUG: %s called for a submodule", caller);
> +	/* This function is to be deleted in the next patch */

I don't think the above comment is correct anymore. Possibly the commit
log message is also out of date too, but I haven't read far enough ahead
to know.

> [...]

Michael

