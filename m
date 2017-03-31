Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811411FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbdCaXVV (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:21:21 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34264 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbdCaXVU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:21:20 -0400
Received: by mail-pg0-f44.google.com with SMTP id 21so83909366pgg.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MvJ1Zxsynm/DdH93MD+iY4qqGrkaQ3z2cszTE4+suy4=;
        b=bSrEVabyNblICnd+eWl1hWMBk0nMiZ+kx5Sz01pOkGKmcMtL9irsg5jmskQO1jPsSV
         iBVrTdznwWdsmLGzZhyDbTlbTQaZWml5KtOaQVMQ1kuL/tnlNOXMnEPB9kqjbcSk+os0
         Q20GI+fQ6sdJ08vqH0IGjWR0ZPipnMUhJmWIVBmOEDPKeqHQqTCYfuOHoAYx5YDvmReN
         F51Zq/9hQMRexyutZryFdhyM/eO2oFe+LSe782taChCHDpQ+0QZjlk6Kdl28UtmNwC31
         1/vmyblXku0AHxY9OnNU8/v2v6xOCPv8JlS3p5YbQeDdq3UiHy3c794+3NGeqGWus8ca
         bMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MvJ1Zxsynm/DdH93MD+iY4qqGrkaQ3z2cszTE4+suy4=;
        b=gOgnINmXkitBAd/Hv2zeZi+Mf92aKP0bgKbPLncS9drvM0KaNh9AyXWYVXqM3jdMh4
         KB7GKEF0fCGwgTmY2NRQWWpNau7joHMW1yKrkLS8G1yYz1BOdDNLVhhORyIgCv2BnhTR
         31Mw7YXx3b1v/V+qGkI/+0oyOIZgaXMjTsQBm7Q+5O1KBEFLYEcCgcLjG/uHaCNwWuyD
         pwmEIJYjiRcT3ZHAqRaQshGecCdJYtHJwv2ilNGlYHlnzsTsRCghXZzhgNKVlHwZTE39
         ZtBvxWdB7Bm9Q+lnnTwk3DDgExir8hC/aOPOrioJVnZELl0n3+d09vMglr0j9IqFKFpX
         a90Q==
X-Gm-Message-State: AFeK/H2L8zKcAhM1o468EmWVQcZdNXiNSH/GYwk3tHvlwTbqVnrwD/BKusFWQH6vlrVmAg==
X-Received: by 10.99.126.13 with SMTP id z13mr4049831pgc.158.1491002479902;
        Fri, 31 Mar 2017 16:21:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8962:97f5:cc56:a89d])
        by smtp.gmail.com with ESMTPSA id m69sm12431646pfc.33.2017.03.31.16.21.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:21:19 -0700 (PDT)
Date:   Fri, 31 Mar 2017 16:20:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: propagate push-options with --recurse-submodules
Message-ID: <20170331232030.GA8741@aiede.mtv.corp.google.com>
References: <20170331231135.195195-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331231135.195195-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Teach push --recurse-submodules to propagate push-options recursively to
> the pushes performed in the submodules.

Sounds like a good change.

[...]
> +++ b/submodule.c
[...]
> @@ -793,6 +794,12 @@ static int push_submodule(const char *path, int dry_run)
>  		if (dry_run)
>  			argv_array_push(&cp.args, "--dry-run");
>  
> +		if (push_options && push_options->nr) {
> +			static struct string_list_item *item;

Why static?  It would be simpler (and would use less bss) to let this
pointer be an automatic variable instead.

> +			for_each_string_list_item(item, push_options)
> +				argv_array_pushf(&cp.args, "--push-option=%s",
> +						 item->string);
> +		}
>  		prepare_submodule_repo_env(&cp.env_array);
>  		cp.git_cmd = 1;
>  		cp.no_stdin = 1;
> @@ -807,7 +814,8 @@ static int push_submodule(const char *path, int dry_run)
>  
>  int push_unpushed_submodules(struct sha1_array *commits,
>  			     const char *remotes_name,
> -			     int dry_run)
> +			     int dry_run,
> +			     const struct string_list *push_options)

nit: I wonder if dry_run should stay as the last argument.  That would
make it closer to the idiom of have a flag word as last argument.

[...]
> +++ b/t/t5545-push-options.sh
> @@ -142,6 +142,45 @@ test_expect_success 'push options work properly across http' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'push options and submodules' '

Yay!

What happens if the upstream of the parent repo supports push options
but the upstream of the child repo doesn't?  What should happen?

Thanks and hope that helps,
Jonathan
