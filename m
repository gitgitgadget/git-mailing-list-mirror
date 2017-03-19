Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B017220323
	for <e@80x24.org>; Sun, 19 Mar 2017 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbdCSVGH (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 17:06:07 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42659 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752366AbdCSVGG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 17:06:06 -0400
X-AuditID: 1207440d-029ff70000003721-1f-58cef2960d42
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id AE.11.14113.692FEC85; Sun, 19 Mar 2017 17:05:27 -0400 (EDT)
Received: from [192.168.69.190] (p5B105D72.dip0.t-ipconnect.de [91.16.93.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2JL5NcW019558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 19 Mar 2017 17:05:24 -0400
Subject: Re: [PATCH v6 17/27] refs: move submodule code out of files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-18-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3738362d-6c76-cba7-824a-d689bbe290c6@alum.mit.edu>
Date:   Sun, 19 Mar 2017 22:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-18-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1J3+6VyEwf/bXBZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgytix6xtjwUfRiml/DjM1MD4S7GLk4JAQMJHYuES/i5GL
        Q0hgB5PEieMvGSGcc0wSbxesYO5i5OQQFvCT2D+lmxXEFhFIk1g8+T0zRNFERol7t16zgDjM
        AjcYJS5N/MgEUsUmoCuxqKeZCWQFr4C9xMsV4SBhFgFVia2bToENFRUIkZiz8AEjiM0rIChx
        cuYTFhCbU8BCornvM9gYZgF1iT/zLjFD2PISzVtnM09g5J+FpGUWkrJZSMoWMDKvYpRLzCnN
        1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJdt4djP/XyRxiFOBgVOLhvXHpXIQQa2JZ
        cWXuIUZJDiYlUd5/6kAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwbHgLleFMSK6tSi/JhUtIc
        LErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvCUfgRoFi1LTUyvSMnNKENJMHJwgw3mAhr8E
        qeEtLkjMLc5Mh8ifYlSUEudVAUkIgCQySvPgemHJ6BWjONArwrzRIFU8wEQG1/0KaDAT0OBl
        N86ADC5JREhJNTBOt1q2TvXq7WMLNGzrFFe9/eqqcTizUmf/8ikOMqfn33uZIst+X1bj8vtu
        JvUPPWsbfVfeuuMe1uTNLCKwUuGPx8udPcKTd31d2c2VvTwh7KvS7LuH78SdNzTKecqbvuXO
        iQmOh+NvvVvMzzXTs0PT33Rr9cHD15u2NGeqLVqlpTRxLvuMar52JZbijERDLeai4kQA3O04
        NiEDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
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
>  refs.c               | 19 ++++++++++++++-----
>  refs/files-backend.c | 24 ++----------------------
>  refs/refs-internal.h |  9 ++++-----
>  3 files changed, 20 insertions(+), 32 deletions(-)
> 
> [...]
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 351934d36e..db335e4ca6 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> @@ -1014,8 +1000,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
>  static void files_assert_main_repository(struct files_ref_store *refs,
>  					 const char *caller)
>  {
> -	if (refs->submodule)
> -		die("BUG: %s called for a submodule", caller);
> +	/* This function is to be deleted in the next patch */

Actually, the function survives the next patch. But the incorrect
comment doesn't ;-)

Ideally, the following patch would precede this one; then this function
wouldn't have to be disabled between the two patches.

But given that it's only a consistency check, I suppose that we can live
with the disappearance of this check for one commit. The comment could
maybe be corrected, though.

> [...]
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index f732473e1d..dfa1817929 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -482,12 +482,11 @@ struct ref_store;
>  /* refs backends */
>  
>  /*
> - * Initialize the ref_store for the specified submodule, or for the
> - * main repository if submodule == NULL. These functions should call
> - * base_ref_store_init() to initialize the shared part of the
> - * ref_store and to record the ref_store for later lookup.
> + * Initialize the ref_store for the specified gitdir. These functions
> + * should call base_ref_store_init() to initialize the shared part of
> + * the ref_store and to record the ref_store for later lookup.

Maybe mention that the function will make its own copy of `gitdir`?

>   */
> -typedef struct ref_store *ref_store_init_fn(const char *submodule);
> +typedef struct ref_store *ref_store_init_fn(const char *gitdir);
>  
>  typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);

Michael

