Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0364F203BD
	for <e@80x24.org>; Wed, 10 Aug 2016 18:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938591AbcHJSls (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:41:48 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36616 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936500AbcHJSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:41:46 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so3228000pab.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:41:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PNHwUA6mPIQ1SyLyvRMkVBoZN7gEJsFItcH/0+aYm+8=;
        b=iIueR+WJ2v9Z0zKj1kf8RZgo3FJqSpE2U2DIRjymCAQXMeELtMwofuxuMQMmO/mB3J
         HLUoAfO1mnMSe1SJDZ4f4E4GUwrcFRw6wCUPvagQSmEPo6Nrgs1tnU8sfdhkGd/7Nncz
         MjFgI4Ds3YGG8qdSBkdbetLlQn4lY+UmC6apxuMTEqXt24aVzTQ9S2AzIm9CQczJSOfP
         xfv9477AEN2xIhYOeODvJVW4AD43CKzCjqP1UfKa8CRT7sfnXdhYsiDwBvpXjsKh7tWS
         uSTdSNSw7ZTTPV9RUNce2GzbkP18IbHOiRPrUWfXBlEQGVD7r1LzCqYLHdDSMRH+syi3
         xMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PNHwUA6mPIQ1SyLyvRMkVBoZN7gEJsFItcH/0+aYm+8=;
        b=hL0DpRggxclAcEP8NRnwOsP9RbaYx2Q0Zt1IeCZoO+u7lEg8FJEwPyt/128gNUPK9n
         bNsXdNuPknbXKx8qbYBNfBH15FvjCDYqKpAwkjGhH9mVRgfXRxrUQnX37AgorGLM/OUW
         jUmhVuJKdZmbZrhE2lOQZSRcsRY70qCvDb5+g47nBq43hBdbojkQbxvlhNW53hac1pKT
         gVleuO1hGYgk+efB7q7Pl37LPUjmQItbWkM7pqSazqXk2o2kVnLxkWZFgbXVokG21pRQ
         Nfn5Utn+34CHG+cs0b6+gJu7tzyBaO9s6CqG2f7C2ijL25qEcw5HmtBf0lnGaSvNdgSj
         7gxQ==
X-Gm-Message-State: AEkoout95z3rZl15iwLYl64jFkVBgC9p8uGizZTdioWksmSviZDrpVkP79CtpeD28+8Bow==
X-Received: by 10.66.230.195 with SMTP id ta3mr9120929pac.89.1470850341044;
        Wed, 10 Aug 2016 10:32:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:8904:635e:9e0d:38e5])
        by smtp.gmail.com with ESMTPSA id t7sm65686809paz.21.2016.08.10.10.32.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 10:32:20 -0700 (PDT)
Date:	Wed, 10 Aug 2016 10:32:18 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] checkout: do not mention detach advice for explicit
 --detach option
Message-ID: <20160810173218.GB14758@google.com>
References: <20160810172800.23575-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160810172800.23575-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller wrote:

> When a user asked for a detached HEAD specifically with `--detach`,
> we do not need to give advice on what a detached HEAD state entails as
> we can assume they know what they're getting into as they asked for it.

Example? Tests?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I like the idea. Thanks for writing it.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 27c1a05..fa2dce5 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -655,7 +655,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
>  			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
>  		if (!opts->quiet) {
> -			if (old->path && advice_detached_head)
> +			if (old->path && advice_detached_head && !opts->force_detach)
>  				detach_advice(new->name);
>  			describe_detached_head(_("HEAD is now at"), new->commit);
>  		}
> -- 
