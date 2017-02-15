Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C022D2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdBOREp (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 12:04:45 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34085 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdBOREo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 12:04:44 -0500
Received: by mail-pf0-f170.google.com with SMTP id e4so32784410pfg.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 09:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cdOnk/68nZibEhrN6icYXqvLQVesHK+HXPRv6oUub5Y=;
        b=VEMl0XrcxZJi3aaWpX05D9KLgVFeNEVbUzW1LhOehgnkgkNuefXWFfEXMBcSPree0a
         rozZtx1fwwAZWU1tJJTb/Vr190E7TTXNX6AHh9+8c6wAIeQX8XNSxyWIO9CchEKzD+J8
         7gM6Zlsby197GRrPDxNQKHNwS8vq1pCdDtoT1q/e9ZWxr5xhzDVRxXdIp1cS5nL1ubs6
         4ur+3JWWHtbbT7aQjDLmgHdWqmSNwQpRdajfWh/yFbnKw3fizanQxV+xONKU1opLfbpf
         G8HyRsEXU39NPoyPPgPP+54kmjefqA/U8ksgNPAM1FnCEZA3SBNm/Lc6KV6K2FzlH0Ed
         1Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cdOnk/68nZibEhrN6icYXqvLQVesHK+HXPRv6oUub5Y=;
        b=nVuY+K4BVZIktrFbKt49KPxfvagZj50s5LCvTaSdt4+4CDl/KG8Oa0gYrbyzgPCHnO
         b8U92aaP1osMHmU7ZeKPZGSIVGYxA2eIRWDdD+i3NYsUsoiGbrnwWDVQ+SewOtW8cBRn
         iCI2Hi9UTzL8jlgHWcUWk2/x7UCFMuqK+O/SEDEL1qxw3W9wQ18zVD0rEYOQVqdOEV+W
         uAu6zVKFQP9GUVt+qcXiPuKqf9yiFqwSriACHMYpoAtBi3on07CmcU56Ry0H+WJjnanv
         aPK3GIPdoGI5N1MZfBOx+Wv1FBInB/vP7VSFqp3IY+Bxu8bdtLFpETHNxugdCXcDp+F4
         0e7g==
X-Gm-Message-State: AMke39mQc26cqzrD4lTbnIx5y05wZoNyHxM6XYhy+aXODrs3WObiUzvZMJaIENpbbiXuxfLk
X-Received: by 10.99.163.81 with SMTP id v17mr1444757pgn.39.1487178283841;
        Wed, 15 Feb 2017 09:04:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:78f6:794e:151:8624])
        by smtp.gmail.com with ESMTPSA id r8sm8598365pfi.82.2017.02.15.09.04.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 09:04:42 -0800 (PST)
Date:   Wed, 15 Feb 2017 09:04:41 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com
Subject: Re: [PATCH 07/14] update submodules: introduce
 is_interesting_submodule
Message-ID: <20170215170441.GB29448@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
 <20170215003423.20245-8-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170215003423.20245-8-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Stefan Beller wrote:
> In later patches we introduce the --recurse-submodule flag for commands
> that modify the working directory, e.g. git-checkout.
> 
> It is potentially expensive to check if a submodule needs an update,
> because a common theme to interact with submodules is to spawn a child
> process for each interaction.
> 
> So let's introduce a function that pre checks if a submodule needs
> to be checked for an update.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 26 ++++++++++++++++++++++++++
>  submodule.h |  8 ++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index c0060c29f2..4c33374ae8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -551,6 +551,32 @@ void set_config_update_recurse_submodules(int value)
>  	config_update_recurse_submodules = value;
>  }
>  
> +int submodules_interesting_for_update(void)
> +{
> +	/*
> +	 * Update can't be "none", "merge" or "rebase",
> +	 * treat any value as OFF, except an explicit ON.
> +	 */
> +	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
> +}
> +
> +int is_interesting_submodule(const struct cache_entry *ce)

Is there perhaps a more descriptive function name we could use instead
of "is_interesting"?  The problem is that its difficult to know why its
interesting or for what purpose it is interesting.

> +{
> +	const struct submodule *sub;
> +
> +	if (!S_ISGITLINK(ce->ce_mode))
> +		return 0;
> +
> +	if (!submodules_interesting_for_update())
> +		return 0;
> +
> +	sub = submodule_from_path(null_sha1, ce->name);
> +	if (!sub)
> +		return 0;
> +
> +	return sub->update_strategy.type != SM_UPDATE_NONE;
> +}
> +
>  static int has_remote(const char *refname, const struct object_id *oid,
>  		      int flags, void *cb_data)
>  {
> diff --git a/submodule.h b/submodule.h
> index c4e1ac828e..84b67a7c4a 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -59,6 +59,14 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
>  		const struct diff_options *opt);
>  extern void set_config_fetch_recurse_submodules(int value);
>  extern void set_config_update_recurse_submodules(int value);
> +
> +/*
> + * Traditionally Git ignored changes made for submodules.
> + * This function checks if we are interested in the given submodule
> + * for any kind of operation.
> + */
> +extern int submodules_interesting_for_update(void);
> +extern int is_interesting_submodule(const struct cache_entry *ce);
>  extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
>  extern int fetch_populated_submodules(const struct argv_array *options,
>  			       const char *prefix, int command_line_option,
> -- 
> 2.12.0.rc0.16.gd1691994b4.dirty
> 

-- 
Brandon Williams
