Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A55720953
	for <e@80x24.org>; Tue, 14 Mar 2017 23:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbdCNXuk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:50:40 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33643 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdCNXuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 19:50:39 -0400
Received: by mail-pg0-f49.google.com with SMTP id n190so791531pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fhNeiKF3Z9FgIuCqIjIt1BnTyYh73v/0ShGMsacO1Kk=;
        b=rbyNEI3Ck+Ef9RdVo52YUIxzkMH3DdTbDEBXHcCcmm3lYThc15Y707Mkfc8+XwyA9y
         WpsSTCUStX4Bja9JA/d5KAUqpYwl7zt5UL/R2VcoDq8rRfs7ET2Bqaa/73ZcNzWaJfFC
         z0yvTyG3eI5YhvHQifkF7YW4QlzbYedythoLerzZw74TqqwWleL5TxjoeoZglmpEOKS7
         0Ck/zE2yOvDbybtgaltTHCtSvGDmlERBOH+WXhwVGvoIADV0VZL4UnrqM6uv1FgZurqa
         H7pFVo4eEk0D9PuXFLX/7OrjPawUx2oFPO6hwoqJpYx+zj5d+n46ZrfZOLMjUCQ6615E
         dhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fhNeiKF3Z9FgIuCqIjIt1BnTyYh73v/0ShGMsacO1Kk=;
        b=ajmvv1cnsUuilgCwFrsU0Z+puNtn8AfG7RwmxOfK8KS0IM0xrXQ+r0VShU9/Ywdymv
         pbiI/qAFnKujZqeWcN5/x8KgKl6wbjaLQMo4H19QVfJDvgD9wfrOB+gM+WeCXSQLqmMA
         6himKf+ZbLQZfBzM2bVYcD4Er3p2rRZYhtKLAR3nNQj+GkYAOl6M8yYqVJJPOlrkUOMl
         AmdbSEefQ1NKHI1fVYUDhOxHT8HyUNKsQr/CnQLOw8TN68nvPWvHxCE5IM2XTaQl84TO
         24uQAe04AEwyP8cC6P5LHYMG0RRSYnSb+vfcuiCzxqZCutQB7zmWmZ5AoB0TrpB4/zbQ
         iAWQ==
X-Gm-Message-State: AFeK/H2OvGOmEpGNpAJ9k7gaomJVd6E6aVaMVkkA+43Fx1/eb4usKzO+Y6duhUhfi0oJiBOA
X-Received: by 10.98.8.206 with SMTP id 75mr331422pfi.198.1489535438190;
        Tue, 14 Mar 2017 16:50:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id z4sm140493pge.49.2017.03.14.16.50.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 16:50:37 -0700 (PDT)
Date:   Tue, 14 Mar 2017 16:50:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 03/10] submodule sync: use submodule--helper is-active
Message-ID: <20170314235036.GF168037@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-4-bmwill@google.com>
 <xmqq8to7kamv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8to7kamv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  git-submodule.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index ab233712d..e2d08595f 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -1111,7 +1111,7 @@ cmd_sync()
> >  			;;
> >  		esac
> >  
> > -		if git config "submodule.$name.url" >/dev/null 2>/dev/null
> > +		if git submodule--helper is-active "$sm_path"
> >  		then
> >  			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> >  			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> 
> This is not a problem this patch introduces, but the loop this hunk
> is in seems a bit inefficient.  It maps the sm_path to its name and
> then asks .gitmodules the URL the upstream suggests to clone it from,
> munges it with a large case statement and discards all of that if
> the module is not active.
> 
> Adding this patch on top would be a way to remove the inefficiency
> and one level of nesting while at it, I think, but I may have missed
> something, so please double check, and if you agree that this is a
> good way to go, please do so as a preparatory clean-up.
> 
> Thanks.

Yeah you're right, some of that work can be avoided.  I'll do the
code cleanup in a prep patch and then convert submodule sync to use the
is-active subcommand.

> 
>  git-submodule.sh | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index e2d08595f0..dcdd36fa64 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1089,6 +1089,12 @@ cmd_sync()
>  	while read mode sha1 stage sm_path
>  	do
>  		die_if_unmatched "$mode" "$sha1"
> +
> +		if ! git submodule--helper is-active "$sm_path"
> +		then
> +			continue
> +		fi
> +
>  		name=$(git submodule--helper name "$sm_path")
>  		url=$(git config -f .gitmodules --get submodule."$name".url)
>  
> @@ -1111,14 +1117,12 @@ cmd_sync()
>  			;;
>  		esac
>  
> -		if git submodule--helper is-active "$sm_path"
> -		then
> -			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> -			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> -			git config submodule."$name".url "$super_config_url"
> +		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> +		say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> +		git config submodule."$name".url "$super_config_url"
>  
> -			if test -e "$sm_path"/.git
> -			then
> +		if test -e "$sm_path"/.git
> +		then
>  			(
>  				sanitize_submodule_env
>  				cd "$sm_path"
> @@ -1131,7 +1135,6 @@ cmd_sync()
>  					eval cmd_sync
>  				fi
>  			)
> -			fi
>  		fi
>  	done
>  }

-- 
Brandon Williams
