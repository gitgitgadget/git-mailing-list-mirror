Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F491FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbdBJTPC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:15:02 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36557 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbdBJTPA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:15:00 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so3042010pfo.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sAL25em94ykjKfoWYiix0qBMEO9kj+khS1U2hw9pyuA=;
        b=R494v8w0VyQM8l1zErsIGoYxFAYx/qvTwzosyrkq2D6PFvnAaVD33u4Jc/aVE5e6nA
         KRV63qxRfFF72JZyAPM3NORwNHCVLRDwdt7eMvZO1T+Q2Wi7l29BxUx6tlq1ENesxZ5L
         DL26EdmNZybMecxST05VdN/FJlbuenUvleJ6o/pIFusglbjXyOCkppEfKuEnEuhWDCWu
         3b8QMXSDuULG0QdqRS5flX2iMxyoeRAlScScZ5LX0ATDhg9MmNFCbge8Byt26pPvbmej
         W6l1OHJbi+QaRgENeJfEPCxelJa1oBlHmiDG/erjD4dRtI/Q1s6KNShlIY/jMefeGQcV
         ndfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sAL25em94ykjKfoWYiix0qBMEO9kj+khS1U2hw9pyuA=;
        b=VcNqf+znQYnUgP3HUIYPPPXIEAotD04pL/i0MI5/wff2cHSozQ7Xit4bmQfxCItIRJ
         tXtW05fWBPixrmE2icQqaWaiQjkmyH8HetdsRSmHB/zlf72Xp99j26vroqmur+wnElFO
         lOkggMzptZw5iPWDddLPHGGiELAiXdByVZx4lpxYAhMM6Dsmzw6okSsj+j++JZJTbVml
         DSuNAG9s8qIuAwoNUtHAmcwwB6oXKanQGO6MIIOfDq24a+PZ4NkWSPw2fyYuloZG2eyq
         xuikNC9gKEWhN6aXD6iigAzokk2gnKVpgwWaSSNmaOHpOgd1z2NT6YZcaSKQy/AEoxcp
         R/qA==
X-Gm-Message-State: AMke39lq7oF1jWdVJIn6+KenVLuXj5xr0epUaFu3nzV3S4WflUTyDfdGWerqRre0QjFriA==
X-Received: by 10.98.209.16 with SMTP id z16mr12014798pfg.139.1486754095077;
        Fri, 10 Feb 2017 11:14:55 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id f3sm7144018pfd.10.2017.02.10.11.14.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 11:14:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/9] refs: reorder some function definitions
References: <cover.1486724698.git.mhagger@alum.mit.edu>
        <661ef87844918501e84b43d254305e1997af9b57.1486724698.git.mhagger@alum.mit.edu>
Date:   Fri, 10 Feb 2017 11:14:53 -0800
In-Reply-To: <661ef87844918501e84b43d254305e1997af9b57.1486724698.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Fri, 10 Feb 2017 12:16:11 +0100")
Message-ID: <xmqqfujlluxe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This avoids the need to add forward declarations in the next step.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Makes sense, but the patch itself looks like ... unreadble ;-)

>
> diff --git a/refs.c b/refs.c
> index 9bd0bc1..707092f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1358,27 +1358,19 @@ static struct ref_store *main_ref_store;
>  /* A linked list of ref_stores for submodules: */
>  static struct ref_store *submodule_ref_stores;
>  
> -void base_ref_store_init(struct ref_store *refs,
> -			 const struct ref_storage_be *be,
> -			 const char *submodule)
> +struct ref_store *lookup_ref_store(const char *submodule)
>  {
> -	refs->be = be;
> -	if (!submodule) {
> -		if (main_ref_store)
> -			die("BUG: main_ref_store initialized twice");
> +	struct ref_store *refs;
>  
> -		refs->submodule = "";
> -		refs->next = NULL;
> -		main_ref_store = refs;
> -	} else {
> -		if (lookup_ref_store(submodule))
> -			die("BUG: ref_store for submodule '%s' initialized twice",
> -			    submodule);
> +	if (!submodule || !*submodule)
> +		return main_ref_store;
>  
> -		refs->submodule = xstrdup(submodule);
> -		refs->next = submodule_ref_stores;
> -		submodule_ref_stores = refs;
> +	for (refs = submodule_ref_stores; refs; refs = refs->next) {
> +		if (!strcmp(submodule, refs->submodule))
> +			return refs;
>  	}
> +
> +	return NULL;
>  }
>  
>  struct ref_store *ref_store_init(const char *submodule)
> @@ -1395,21 +1387,6 @@ struct ref_store *ref_store_init(const char *submodule)
>  		return be->init(submodule);
>  }
>  
> -struct ref_store *lookup_ref_store(const char *submodule)
> -{
> -	struct ref_store *refs;
> -
> -	if (!submodule || !*submodule)
> -		return main_ref_store;
> -
> -	for (refs = submodule_ref_stores; refs; refs = refs->next) {
> -		if (!strcmp(submodule, refs->submodule))
> -			return refs;
> -	}
> -
> -	return NULL;
> -}
> -
>  struct ref_store *get_ref_store(const char *submodule)
>  {
>  	struct ref_store *refs;
> @@ -1435,6 +1412,29 @@ struct ref_store *get_ref_store(const char *submodule)
>  	return refs;
>  }
>  
> +void base_ref_store_init(struct ref_store *refs,
> +			 const struct ref_storage_be *be,
> +			 const char *submodule)
> +{
> +	refs->be = be;
> +	if (!submodule) {
> +		if (main_ref_store)
> +			die("BUG: main_ref_store initialized twice");
> +
> +		refs->submodule = "";
> +		refs->next = NULL;
> +		main_ref_store = refs;
> +	} else {
> +		if (lookup_ref_store(submodule))
> +			die("BUG: ref_store for submodule '%s' initialized twice",
> +			    submodule);
> +
> +		refs->submodule = xstrdup(submodule);
> +		refs->next = submodule_ref_stores;
> +		submodule_ref_stores = refs;
> +	}
> +}
> +
>  void assert_main_repository(struct ref_store *refs, const char *caller)
>  {
>  	if (*refs->submodule)
