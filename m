Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887571F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbeHNUAp (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:00:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38683 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732767AbeHNUAp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:00:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so9532013pfh.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ELzWiBuYEQi6lWYthYR1pHxo2OhqB5kpUXioXtZ/bww=;
        b=uQKAVu3GHt+qRSWHFfNEqpcRphnmJAAFTkU1Z2WLxxEqF/RUQczp8ggtvItI5bO3AF
         XMVRGcGHEyMfNXpUrG8z2EaTdfaxT0w2Y9WtGquwJi4Ja/Lm3BicHR0OsR8FpedWpawm
         FPDwNSS4vfaQ9+btNjhzNBe0CEdHbtMEUSUYnbEcRVGFpd0/4QBM79mcuL3zZwnPrOs3
         b7ENte22rlIN8PtEkY8Bd3I6RpGhfUkIcmfndWPP3xMBmzWvun6k5KRnZPD4hsZQpwxj
         4SiA4QxQkmexdJrMshg/0fkydD78uYljtM7qX60+hrDaV2t+BBkNpAvFa93jkHPUWsie
         wqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ELzWiBuYEQi6lWYthYR1pHxo2OhqB5kpUXioXtZ/bww=;
        b=Orb5EZIM6k6D7MFHG9j7hz/1OisLrkMB/fnldWpZOeO5BumgdiorJDxJVRZbBLChoA
         w+y99Z6FJR1EK9VKON59IP76X++DZc8kRY9nX3k6PZGEhnE7K3eRXdhLUCLf1UtAwzj8
         lAY5RRuF/+V+QsQyVrjM0iPFx4s40Fm8SzH5FudyQsF7jVXILAzvbBldaUBEB9erJ/pk
         90IKngkhyCNTUulwzYrQgmT3IiQuwhDKk+Ou8wxigx6Otye+hq7acscews3DsQWSAC98
         OjWDmrWmT3EFK9sgoz4AwOg9rzDLbUlPcxSh96hdip63FBoxI6pQvC0Bb85aZAsr4aue
         J5Nw==
X-Gm-Message-State: AOUpUlGeSEzPaVJBDXJ5EkMiOn24Uinbwv6zzBFGRwG/aSDXMDsfbZ8q
        nliwBcgI9+tpKxX7B5jxZGJhjw==
X-Google-Smtp-Source: AA+uWPxj4y0QZWyR/1NB9WyI3bDTWylLtESMp7nS+lfZ7VymVbd5Q6jQ9kVnk3T6jFzREU+Izi74DQ==
X-Received: by 2002:a63:4a61:: with SMTP id j33-v6mr21960412pgl.436.1534266763355;
        Tue, 14 Aug 2018 10:12:43 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r1-v6sm51953742pfi.17.2018.08.14.10.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 10:12:42 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:12:41 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org,
        Daniel =?iso-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 5/7] submodule: use the 'submodule--helper config'
 command
Message-ID: <20180814171241.GA233973@google.com>
References: <20180814110525.17801-1-ao2@ao2.it>
 <20180814110525.17801-6-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814110525.17801-6-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Antonio Ospite wrote:
> Use the 'submodule--helper config' command in git-submodules.sh to avoid
> referring explicitly to .gitmodules by the hardcoded file path.
> 
> This makes it possible to access the submodules configuration in a more
> controlled way.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>

Looks great.  I also like you're approach of introducing the new API and
testing it in one commit, and then using it in the next.  Makes the
patch set very easy to follow.

> ---
>  git-submodule.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8b5ad59bde..ff258e2e8c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -72,7 +72,7 @@ get_submodule_config () {
>  	value=$(git config submodule."$name"."$option")
>  	if test -z "$value"
>  	then
> -		value=$(git config -f .gitmodules submodule."$name"."$option")
> +		value=$(git submodule--helper config submodule."$name"."$option")
>  	fi
>  	printf '%s' "${value:-$default}"
>  }
> @@ -283,11 +283,11 @@ or you are unsure what this means choose another name with the '--name' option."
>  	git add --no-warn-embedded-repo $force "$sm_path" ||
>  	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
>  
> -	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
> -	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
> +	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
> +	git submodule--helper config submodule."$sm_name".url "$repo" &&
>  	if test -n "$branch"
>  	then
> -		git config -f .gitmodules submodule."$sm_name".branch "$branch"
> +		git submodule--helper config submodule."$sm_name".branch "$branch"
>  	fi &&
>  	git add --force .gitmodules ||
>  	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
> -- 
> 2.18.0
> 

-- 
Brandon Williams
