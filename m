Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D2D1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 23:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIFDme (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 23:42:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42452 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIFDme (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 23:42:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so4157934pgp.9
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sQEhlpo5jNCe+tkcGc7kWQYLKc+3OskDEThXz5oM8uE=;
        b=SsfYGeiftqSTlavsYhLw6cGgQHXFCbNzAobaOavgLAzxk0ycJAxnKODzZ3IiIOU4Ut
         1MpgpC8tjsXULMSCg6qsxrv88OinhMwRuBFSphB6cG8UsZBvSmsWOwJLcJ//XSMcIjlm
         ChZmBme/qbVTrNX8v376H/mjDc8wnWwjggJFoHDHykbDu4jmUfn9k1g7nW25UhBo9mk2
         JD1c8ffuWYTYhDNrpLOPjumhZjPIOZK6VHUSLStzewBpj9h44HDHl56RDyCY4aZxw9FS
         ByuiEnywKVZswtHRBrKWbMPtd7rx/UjkZ/8+zH37BlHGwP/97B5fPWGASD/H4qK48Nxi
         EcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sQEhlpo5jNCe+tkcGc7kWQYLKc+3OskDEThXz5oM8uE=;
        b=DT3ZVC/0QVQNkT9CZmHuUQvJHt1WtJ77WjzUwdcxzxJ6rgEwQX8OlfiowKtZ0SQwds
         6zUIPmK0WDYx3Yq7/e55Xok9Mf/OqEgb0qDGeqM98bkqhvzZ2XbB03BdNXTSSva000VD
         dxye0PjoWOTzsEmSt/WLBktfW2IzOwdeU5WkGXu/6bLPq+agWHVH/WJOWM0GN1Eh1enq
         73Z6+R8GmWVLI2f63Sw3XTwcP3o816DcaVbIC1AFmjAAfPHzZcRRujgJlCGVDXtZvodg
         AMw+0RuuwgA3xEpGplAUA9oCfRKPszn1oplfmw0fNrHiYGZeXJ6e6bHeHXFFxnBG67ee
         oz+w==
X-Gm-Message-State: APzg51BTP62wmryAK6COXTjh9Zd3sWZOao/PR8xMGD+S2S9a0kt2n8ru
        gHU5Zdu25bcNyhEauu11cNw7gMC/
X-Google-Smtp-Source: ANB0Vdb753w1l8+ii51gvsIDJ0Hm6fV+tcIgXqqj2jsTF53rK1RD3YERLmgve63QoH+pLetfkWi2iQ==
X-Received: by 2002:a62:398c:: with SMTP id u12-v6mr43544911pfj.9.1536189008568;
        Wed, 05 Sep 2018 16:10:08 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k4-v6sm5605809pfj.30.2018.09.05.16.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 16:10:08 -0700 (PDT)
Date:   Wed, 5 Sep 2018 16:10:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule.sh update --remote: default to oid instead of
 master
Message-ID: <20180905231006.GC120842@aiede.svl.corp.google.com>
References: <20180905224825.13564-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905224825.13564-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Subject: submodule.sh update --remote: default to oid instead of master

Yay!

Nit: it wasn't clear to me at first what default this subject line was
referring to.  Perhaps:

	submodule update --remote: skip GITLINK update when no branch is set

[...]
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -50,11 +50,12 @@ submodule.<name>.update::
>  
>  submodule.<name>.branch::
[...]
> +	If the option is not specified, do not update to any branch but
> +	the object id of the remote.

Likewise: how about something like

	If not set, the default is for `git submodule update --remote`
	to update the submodule to the superproject's recorded SHA-1.

[...]
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -568,16 +568,19 @@ cmd_update()
>  		if test -n "$remote"
>  		then
>  			branch=$(git submodule--helper remote-branch "$sm_path")
> -			if test -z "$nofetch"
> +			if test -n "$branch"
>  			then
> -				# Fetch remote before determining tracking $sha1
> -				fetch_in_submodule "$sm_path" $depth ||
> -				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
> +				if test -z "$nofetch"
> +				then
> +					# Fetch remote before determining tracking $sha1
> +					fetch_in_submodule "$sm_path" $depth ||

Makes sense.  If $sha1 isn't available in the submodule, it will fetch
again later.

[...]
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -260,6 +260,28 @@ test_expect_success 'submodule update --remote should fetch upstream changes wit
>  	)
>  '
>  
> +test_expect_success 'submodule update --remote should not fetch upstream when no branch is set' '
> +	(
> +		cd super &&
> +		test_might_fail git config --unset -f .gitmodules submodule."submodule".branch &&

Not about this patch: the quoting here is strange.

> +		git add .gitmodules &&
> +		git commit --allow-empty -m "submodules: pin in superproject branch"
> +	) &&

I wonder if we can do simpler by using -C + some helpers: something like

	git config --unset -f super/.gitmodules ... &&
	test_commit -C submodule ... &&
	git -C super submodule update ... &&
	test_cmp_rev ...

Unfortunately test_cmp_rev doesn't accept a -C argument.

Broader comment: do you think people will be surprised by this new
behavior?  Is there anything special we'd need to do to call it out
(e.g., print a warning or put something in release notes)?

Thanks,
Jonathan
