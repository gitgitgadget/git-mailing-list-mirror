Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5AF1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbdAYXmD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:42:03 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35918 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdAYXmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:42:02 -0500
Received: by mail-pg0-f42.google.com with SMTP id 3so9572952pgj.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wC/DGfr+vEdKyxC/ThTIq1I0y8iXlXG76sa2WlqDGXw=;
        b=ST30lB9h1hC+xKSu+CHVVy89igWgGcsBhEBKUr5+n3WBBtU54oRgn7XanZd9HhZWg6
         uVC6HboLsOKq+b60jEvzPjFKkgveT9KymO+BFfcv2V8v1rdh3p1gJcRJ96sjWcMd++zF
         RzofZQ7gLR9PwCmq5lIDPbR90ZgtMsyTbRQAEEWzP85tUL9X9DGMIYMmzRh7VXp6Xe+Y
         Un7A+V7lrDgEYK/bsHjJ1uDJ+TNeTD5GVRJP2/8z3bANDoV6ABGFrhyNcU7o2hBx6Chk
         uCwBehoyb6tYFsvcXX6DkIWgSGIXI8iF0tQJoIkRSVp8S7QhfKNpwDY4vZbd6IhxbCMt
         Wrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wC/DGfr+vEdKyxC/ThTIq1I0y8iXlXG76sa2WlqDGXw=;
        b=HE0RBT4UNW0jULOROULq3cpJg0VLnobS9opnM9SFS4FycdvjZnD2HCydDbojc7SzHG
         AIZVb/KiUDqJTSjziKQ1ltjckPIgXsAIspyJ7WSJKR6ka8IX6+oqvLkw1nARj8dedSlF
         Ceuaq20Eko+3LIPXpw5Don6oyI0Rf1K+pWTeY1pL5D9poMcVxkNsOaAQg6x+4RNBbdsY
         Qk4fDZwpy1wiCvOdUamoPINt4B/1CbI2Kst7jqDEp6LGNFNgEIUJBVu5bVPFE6a+F0E/
         3ReMB6ojrgnjkcuGYd0iE47cRzQYpcHxfUorC2xRKYGISR2SrkV1yicxs9tb496U6lzz
         En6g==
X-Gm-Message-State: AIkVDXLpmbOBz8wcXfSftEx0bapil56DupYbyXO4nMnUO4BFjWA/W/8qmsrLFo1qP6+LJBTQ
X-Received: by 10.98.209.73 with SMTP id t9mr36764728pfl.9.1485387721290;
        Wed, 25 Jan 2017 15:42:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d901:f11e:e93:985])
        by smtp.gmail.com with ESMTPSA id t87sm3560513pfe.59.2017.01.25.15.41.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 15:41:59 -0800 (PST)
Date:   Wed, 25 Jan 2017 15:41:58 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, judge.packham@gmail.com,
        olsonse@umich.edu
Subject: Re: [PATCHv2] submodule update: run custom update script for initial
 populating as well
Message-ID: <20170125234158.GE83343@google.com>
References: <CAGZ79kbi-cweTe-ydcRYFFnGT4EmN+O1TZDiGYFyg8-Ex8abUw@mail.gmail.com>
 <20170125233742.30370-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170125233742.30370-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25, Stefan Beller wrote:
> In 1b4735d9f3 (submodule: no [--merge|--rebase] when newly cloned,
> 2011-02-17), all actions were defaulted to checkout for populating
> a submodule initially, because merging or rebasing makes no sense
> in that situation.
> 
> Other commands however do make sense, such as the custom command
> that was added later (6cb5728c43, submodule update: allow custom
> command to update submodule working tree, 2013-07-03).
> 
> I am unsure about the "none" command, as I can see an initial
> checkout there as a useful thing. On the other hand going strictly
> by our own documentation, we should do nothing in case of "none"
> as well, because the user asked for it.
> 
> Reported-by: Han-Wen Nienhuys <hanwen@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh            |  5 ++++-
>  t/t7406-submodule-update.sh | 15 +++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9788175979..63fc4fe9bc 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -607,7 +607,10 @@ cmd_update()
>  		if test $just_cloned -eq 1
>  		then
>  			subsha1=
> -			update_module=checkout
> +			case "$update_module" in
> +			merge | rebase | none)
> +				update_module=checkout ;;
> +			esac
>  		else
>  			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
>  				git rev-parse --verify HEAD) ||
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 725bbed1f8..2f83243c7d 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -441,6 +441,19 @@ test_expect_success 'submodule update - command in .git/config catches failure -
>  	test_i18ncmp actual expect
>  '
>  
> +test_expect_success 'submodule update - command run for initial population of submodule' '
> +	cat <<-\ EOF >expect
> +	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
> +	EOF
> +	(
> +		cd super &&
> +		rm -rf submodule
> +		test_must_fail git submodule update >../actual
> +	)
> +	test_cmp expect actual
> +	git -C super submodule update --checkout
> +'

You can probably get away without the subshell:

rm -rf super/submodule
test_must_fail git -C super submodule upsate >actual

> +
>  cat << EOF >expect
>  Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
>  Failed to recurse into submodule path '../super'
> @@ -493,6 +506,7 @@ test_expect_success 'submodule init picks up merge' '
>  '
>  
>  test_expect_success 'submodule update --merge  - ignores --merge  for new submodules' '
> +	test_config -C super submodule.submodule.update checkout &&
>  	(cd super &&
>  	 rm -rf submodule &&
>  	 git submodule update submodule &&
> @@ -505,6 +519,7 @@ test_expect_success 'submodule update --merge  - ignores --merge  for new submod
>  '
>  
>  test_expect_success 'submodule update --rebase - ignores --rebase for new submodules' '
> +	test_config -C super submodule.submodule.update checkout &&
>  	(cd super &&
>  	 rm -rf submodule &&
>  	 git submodule update submodule &&
> -- 
> 2.11.0.495.g04f60290a0.dirty
> 

-- 
Brandon Williams
