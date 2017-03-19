Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2FF20323
	for <e@80x24.org>; Sun, 19 Mar 2017 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbdCSVSd (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 17:18:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:47387 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752386AbdCSVSd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 17:18:33 -0400
X-AuditID: 12074413-f67ff700000077e1-0b-58cef5a42772
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 92.C2.30689.4A5FEC85; Sun, 19 Mar 2017 17:18:31 -0400 (EDT)
Received: from [192.168.69.190] (p5B105D72.dip0.t-ipconnect.de [91.16.93.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2JLIP3Y020171
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 19 Mar 2017 17:18:26 -0400
Subject: Re: [PATCH v6 18/27] files-backend: replace submodule_allowed check
 in files_downcast()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-19-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <004082a0-871f-cd41-edc5-522b5c2b3b58@alum.mit.edu>
Date:   Sun, 19 Mar 2017 22:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-19-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1F3+9VyEQetVbouuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZRw4e4OpYKlcxYvtb5kaGFdJdDFyckgImEg0nZvA3MXI
        xSEksINJ4sfaLYwQzjkmicmPO9i7GDk4hAWSJN41BYA0iAikSSye/B6qYSKjxPHGz6wgDrPA
        DUaJSxM/MoFUsQnoSizqaQazeQXsJabOOssKYrMIqEpMa1vFBmKLCoRIzFn4gBGiRlDi5Mwn
        LCDLOAUsJNY98wEJMwuoS/yZd4kZwpaXaN46m3kCI/8sJB2zkJTNQlK2gJF5FaNcYk5prm5u
        YmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIsAvvYNx1Uu4QowAHoxIP741L5yKEWBPLiitz
        DzFKcjApifL+UwcK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHd8BAox5uSWFmVWpQPk5LmYFES
        51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4N37BahRsCg1PbUiLTOnBCHNxMEJMpwHaDhYDW9x
        QWJucWY6RP4Uo6KUOO/Dz0AJAZBERmkeXC8sGb1iFAd6RZj3JUg7DzCRwXW/AhrMBDR42Y0z
        IINLEhFSUg2MJvyHzx006+5wvLBgumZ+X9L8BLd+U22/Dd/vvZlaps3fsTLh3XSHxwKzGO8+
        1f525E3B0s59EpFZNZEWWTu0S4Fxnn9Q0NZmoW9K15b4iuQdpqtKVpeKMrxyNOs10HeTnyko
        2vpXXl19+a2bjKzuXL7B+x49j69MEDuYZDPtovz833YaLEosxRmJhlrMRcWJAF/n1EohAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
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
>  refs.c               | 15 ++++++---
>  refs/files-backend.c | 86 +++++++++++++++++++++++++++++++++-------------------
>  refs/refs-internal.h |  9 +++++-
>  3 files changed, 73 insertions(+), 37 deletions(-)
> 
> [...]
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index db335e4ca6..7d8d4dcc16 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> @@ -1923,21 +1935,23 @@ static struct ref_iterator *files_ref_iterator_begin(
>  		struct ref_store *ref_store,
>  		const char *prefix, unsigned int flags)
>  {
> -	struct files_ref_store *refs =
> -		files_downcast(ref_store, 1, "ref_iterator_begin");
> +	struct files_ref_store *refs;
>  	struct ref_dir *loose_dir, *packed_dir;
>  	struct ref_iterator *loose_iter, *packed_iter;
>  	struct files_ref_iterator *iter;
>  	struct ref_iterator *ref_iterator;
>  
> -	if (!refs)
> -		return empty_ref_iterator_begin();
> -
>  	if (ref_paranoia < 0)
>  		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
>  	if (ref_paranoia)
>  		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
>  
> +	refs = files_downcast(ref_store,
> +			      REF_STORE_READ | (ref_paranoia ? 0 : REF_STORE_ODB),
> +			      "ref_iterator_begin");
> +	if (!refs)
> +		return empty_ref_iterator_begin();
> +

I realize that this `if (!refs)` check existed in the old code, but
isn't it pointless? If `refs` were NULL, `files_downcast()` would have
already segfaulted, I think.

> [...]
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index dfa1817929..0cca280b5c 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -481,12 +481,19 @@ struct ref_store;
>  
>  /* refs backends */
>  
> +/* ref_store_init flags */
> +#define REF_STORE_READ		(1 << 0)

I asked [1] in reply to v5 whether `REF_STORE_READ` is really necessary
but I don't think you replied. Surely a reference store that we can't
read would be useless? Can't we just assume that any `ref_store` is
readable and drop this constant?

> +#define REF_STORE_WRITE		(1 << 1) /* can perform update operations */
> +#define REF_STORE_ODB		(1 << 2) /* has access to object database */
> +#define REF_STORE_MAIN		(1 << 3)
> +
>  /*
>   * Initialize the ref_store for the specified gitdir. These functions
>   * should call base_ref_store_init() to initialize the shared part of
>   * the ref_store and to record the ref_store for later lookup.
>   */
> -typedef struct ref_store *ref_store_init_fn(const char *gitdir);
> +typedef struct ref_store *ref_store_init_fn(const char *gitdir,
> +					    unsigned int flags);
>  
>  typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);

Michael

[1]
http://public-inbox.org/git/8fafd49f-71a6-ee97-6a69-c23e23c5d515@alum.mit.edu/

