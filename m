Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34861F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfKSQPv (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:15:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51414 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfKSQPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:15:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so3830890wme.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qP0GTIEzy73EIpr22I67TaLUa/pOuZxQxJNsK8mKKSM=;
        b=Mp9upJuGHaODPNf49h9GCtNX5lz6jTJRaQdzmlqFS2b6m/+vSlso4FIJcxP4+6+jwh
         Mj+KThbfJQeDNDCqsrMwkHLWp9w7T+I55zPmzZcHzTdja5kWG7LdL0lmiwDWdoIG5MWR
         Rl8hjTVJIsseDdYmc8Mm26j8G2ACkdr0BAuJHE/h6Ozqgs5KEHbJKoAr0hA6yQqJi1c6
         Gb2tJxbok2DsmupXwUK94iYWgdGB7Pk0Fl8DDTU1BJ903hTexdPVDCV1db0zey9ayMMK
         01p2elBzSSYz4IEMmz29V/KCIPaAXsWAY/veJxJF6q53wjdjdDaSHRhC073zdfAcligT
         vXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qP0GTIEzy73EIpr22I67TaLUa/pOuZxQxJNsK8mKKSM=;
        b=jZdt3jYm3wYaLMQlr2mr80CpT9hl4CMFf8Tm7FZ25AkrWfb0nL2Wj1As9PqZ3Cm0MQ
         EY148Swqj6XyzNI4izNSfrAxfSS6NAP1vsDw+5vDShpbpUchmFz/yQUar4Nhq/Y4vkVQ
         E5P6ZV6QIQ94cXGJZFWfNJf0Xa0RLWak3HjKoUfiX0gGwLxUSZCTj3nRKwFZc5MvCf56
         hF50EZpx9z6nWapl/SIp9Tyra5h/L9jEkq3T3NuKVQW4XLb6PlmVFmlCP5pm/xJykKIs
         qKbSKC84T8ACdS35q1xSjv/Zsy2J+XqNuxf9SHn45ccu9tCYvhb5xsKjgZN+Xwyt3Y7S
         Rztw==
X-Gm-Message-State: APjAAAWFjakBUKovj02jhB874B8ErxSY3JCXGRDMboBQa/LnZllzMaol
        KmLow1mlgpjMn5z7JqeUlSo=
X-Google-Smtp-Source: APXvYqz/kFtJ2m7t4+z3PmhBxOOcMb2Qx/wTYagZov8BWrvUjunKYAyVf1ahZAw5gUkWTmgzhvHBZg==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr6505838wmh.45.1574180148264;
        Tue, 19 Nov 2019 08:15:48 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id k14sm28802588wrw.46.2019.11.19.08.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:15:47 -0800 (PST)
Date:   Tue, 19 Nov 2019 17:15:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/17] sparse-checkout: create 'disable' subcommand
Message-ID: <20191119161545.GH23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <c48535cd5c00310403ffccac7507f399fca5a8a4.1571666187.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c48535cd5c00310403ffccac7507f399fca5a8a4.1571666187.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:15PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The instructions for disabling a sparse-checkout to a full
> working directory are complicated and non-intuitive. Add a
> subcommand, 'git sparse-checkout disable', to perform those
> steps for the user.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt | 27 ++++++++++++---------------
>  builtin/sparse-checkout.c             | 26 +++++++++++++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++++++++
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index b933043b3d..f794d4797a 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -48,6 +48,10 @@ To avoid interfering with other worktrees, it first enables the
>  	working directory to match the new patterns. Enable the
>  	core.sparseCheckout config setting if it is not already enabled.
>  
> +'disable'::
> +	Remove the sparse-checkout file, set `core.sparseCheckout` to
> +	`false`, and restore the working directory to include all files.

I think it would make sense to leave the sparse-checkout file behind
as-is, and only update the coonfiguration and the working tree.  That
way users could quickly go back to their last sparse checkout setup by
simply running 'git sparse-checkout init'.

  
> +static int sparse_checkout_disable(int argc, const char **argv)
> +{
> +	char *sparse_filename;
> +	FILE *fp;
> +
> +	if (sc_set_config(MODE_ALL_PATTERNS))
> +		die(_("failed to change config"));
> +
> +	sparse_filename = get_sparse_checkout_filename();
> +	fp = xfopen(sparse_filename, "w");
> +	fprintf(fp, "/*\n");
> +	fclose(fp);
> +
> +	if (update_working_directory())
> +		die(_("error while refreshing working directory"));
> +
> +	unlink(sparse_filename);
> +	free(sparse_filename);
> +
> +	return sc_set_config(MODE_NO_PATTERNS);

Hrm.  So disabling the sparse-checkout calls the same helper function
to write the configuration as initializing or setting, but with a
different parameter.  However, the error message in that function is:

  error(_("failed to enable core.sparseCheckout"));

So if something goes wrong while disabling the sparse-checkout, the
user might get an error saying "error: failed to enable
core.sparseCheckout".  That doesn't look quite right, does it?

> +}
