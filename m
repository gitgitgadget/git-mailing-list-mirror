Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFCC1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 21:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeFHVX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 17:23:56 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:43065 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeFHVXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 17:23:55 -0400
Received: by mail-pl0-f50.google.com with SMTP id c41-v6so8964487plj.10
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wgHJxngfSi7oJEi67s0sg6q9y/cB9TrL4K1IGwHjhdQ=;
        b=vBk2Xw/lc/3Jmarg+Oxnv+wMwSgz0nzE9Gfmorowq9eJl5i/cKlMLBhAfHAOPJo0Lr
         Y8g/BGE+AcdkxV6buO2bAyhLlsZFuEiWz9bW4ijOHCANuYlk5jpfMC1fatznDypQ2LYH
         M3zdQiXy0v/8c7hJ8o8vvD6qbrQs2PS2GZIh/3LNuUJBCEvU/BkhiQCN8TNEXIlH939K
         4oApOU2YnvfpPDDdrgR2aVPcI9dEIaGs8N9hTG8BTpjcWYDNTLITk8gxAgi8Tg+hOVSH
         dywyFGuImknMH18d1RSpUB0zpsgdWspDmgQu8xLV5WD6DdPMQvwiMYpglY6WJzZugjpT
         j1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wgHJxngfSi7oJEi67s0sg6q9y/cB9TrL4K1IGwHjhdQ=;
        b=e5QunO/MDdeRPpK0S8WcY6P3AKcyT4ngg3MTqotXi1ziKgw71u0ewkzOSFIK9qKssW
         69cOF+eN5uz/vO/4pk7kXGeruHsBkE15NgkeK5424EgcMJhRTtxkZzSB7OXPEg0AENw2
         KvKcZrmqgmYufkjC85fLifH8cfOvHYFlz1g/a/jNChvucI7f+keSrG4/y+nvMC+c2w1o
         krqidk2G6eXq4PIIT+F0Q7sddeaAX+ERJOVBaYsm6L8yojGt38B48zjdVTg7u663inln
         iz2Q7pnkf1kX8ysRhfSXj1dtMguBgHlOKeJSLF9/KIHySj2JBg/Vg9gboN5eAG17Drea
         FHRQ==
X-Gm-Message-State: APt69E0l7pMMatKWyd1Oq9GkrWwBbMPqZ+P5us9LOnOhcJ3G6ZvmNVFq
        Dy+vH317zVLxZirdlF7o/rI=
X-Google-Smtp-Source: ADUXVKItp29hZi+dCIwALrP1afWLJtQ0vOmkrQY6RGptkgP+l7UV9Jf7xncQZ7pqYVrVw6ypVRcRfA==
X-Received: by 2002:a17:902:680c:: with SMTP id h12-v6mr8311365plk.113.1528493034710;
        Fri, 08 Jun 2018 14:23:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h124-v6sm11772394pfc.100.2018.06.08.14.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 14:23:53 -0700 (PDT)
Date:   Fri, 8 Jun 2018 14:23:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org, Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached
 --options
Message-ID: <20180608212348.GA42503@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
 <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com>
 <20180608211639.7611-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180608211639.7611-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

SZEDER Gábor wrote:

> Being in RC phase, I'm all for aiming for a minimal solution.
> However, I don't think that the better fix would be erm.. any "less
> minimal":
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index f2aa484758..7aeb575cd1 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3244,7 +3244,10 @@ __gitk_main ()
>  	__git_complete_revlist
>  }
>  
> -if [[ -n ${ZSH_VERSION-} ]]; then
> +if [[ -n ${ZSH_VERSION-} ]] &&
> +   # Don't define these functions when sourced from 'git-completion.zsh',
> +   # it has its own implementations.
> +   [[ -z "${GIT_SOURCING_ZSH_COMPLETION}" ]] ; then

Needs a - before the } to avoid errors in a shell where the user has
chosen to use "set -u".  See v1.7.4-rc0~159 (completion: fix zsh check
under bash with 'set -u', 2010-10-27) for more details.

>  	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
>  
>  	autoload -U +X compinit && compinit
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index 53cb0f934f..049d6b80f6 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -39,7 +39,7 @@ if [ -z "$script" ]; then
>  		test -f $e && script="$e" && break
>  	done
>  fi
> -ZSH_VERSION='' . "$script"
> +GIT_SOURCING_ZSH_COMPLETION=y . "$script"
>  
>  __gitcomp ()
>  {

Except for that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.

Now it just needs a commit message. :)
