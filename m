Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9FF71F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966791AbeF1WUY (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:20:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33429 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964781AbeF1WUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:20:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so3238980pfi.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mijrkkUIEwCEiecfoaeqPeZcSoQwKoWJc6T1S4oQe94=;
        b=veblgz8GScxacIhBMUmthPMae5DXNHcgWYaGslWtzmf/sHXQ9Q+bAjWcdHWPmE/++Q
         OSu9LQSoFgu0fJxIIMt3ZY3G7gcsoumilmrrrG5oWK6hm6GcF7QjP3X0t+Xs6IITR1qj
         RseS13CixC3lJ06vqN83ahlRBbVT8iNi+7SLiw1ZGezcDhe9N+UHmM5MVQ6qdLd1VGev
         8ksqmnTUKq/N38Ugf0lgF5H8K/EvGjtwQY74F1rgMfNaIBJQT7u8RmksrmVQtskRYUv5
         Dsp/BulUmAD2ZHsvyTJ+rrsI5rAGUJAUhemYtvRZ51n0wgMicjJKIc+5hiPCdQh0Km9s
         9iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mijrkkUIEwCEiecfoaeqPeZcSoQwKoWJc6T1S4oQe94=;
        b=LfmN6z2zOo0J0wPeeO4LwYSZo7skE51lVW7J5bmmT/IPFnl6xR6mK1ITxxwSXqq0KS
         jG4gTBm4FQAIj5BWFaojm8OO4GOAt9NjZQ8S1NCoK7MK08Ll8DZj1fqVgkFjyNXsi057
         l3vOnwPhpQVN7YWPfTXioYrYyA+KnXixQGl2PdcnVv3mPrLRp1tLGDNVqMflt5bE9FTL
         cZ/Xzesm0u8581UJiVWQ3Uafo8hObVV3agV4nVWHUi1sNkzwz7ZebuiJ/ZT1mCnMhIEC
         gLK4V6VU0OGXCZSbzWHt0V63jCYglhrZByg2wAPtqsMtSW5xyMpOfSo/7lWL7ZYR+AFo
         YfiA==
X-Gm-Message-State: APt69E37gOvcpc79V0ec2ekavt74ljQlKdAAObaHqcmtDuiX+sLAKIAQ
        O0aYgV99drTjxMdMU/D86bFx6w==
X-Google-Smtp-Source: ADUXVKIXjSn32/y01c5aFuoLj4M6vgZYOEjNYot1nvzBMs7Lp8R/UImFoOSdbXqFldTVcaeiQeL2cg==
X-Received: by 2002:a63:647:: with SMTP id 68-v6mr10391073pgg.205.1530224422169;
        Thu, 28 Jun 2018 15:20:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z123-v6sm4470653pgb.31.2018.06.28.15.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 15:20:20 -0700 (PDT)
Date:   Thu, 28 Jun 2018 15:20:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] fetch-pack: support negotiation tip whitelist
Message-ID: <20180628222019.GA250118@google.com>
References: <20180625193752.255319-1-jonathantanmy@google.com>
 <20180628221551.30406-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628221551.30406-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/28, Jonathan Tan wrote:
> During negotiation, fetch-pack eventually reports as "have" lines all
> commits reachable from all refs. Allow the user to restrict the commits
> sent in this way by providing a whitelist of tips; only the tips
> themselves and their ancestors will be sent.
> 
> Both globs and single objects are supported.
> 
> This feature is only supported for protocols that support connect or
> stateless-connect (such as HTTP with protocol v2).
> 
> This will speed up negotiation when the repository has multiple
> relatively independent branches (for example, when a repository
> interacts with multiple repositories, such as with linux-next [1] and
> torvalds/linux [2]), and the user knows which local branch is likely to
> have commits in common with the upstream branch they are fetching.
> 
> [1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/
> [2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is on jt/fetch-pack-negotiator.
> 
> > I don't think that would be strange at all, and no where in git do we
> > handle heads/* but we do already handle refs/heads/* as well as DWIM
> > master.
> >
> > > and (2) I can't think of anywhere in Git
> > > where you can provide either one - it's either SHA-1 and DWIM name, or
> > > SHA-1 and refspec, but not all three.
> >
> > fetch is a perfect example of supporting all three.  I can do
> >
> >   git fetch origin SHA1
> >   git fetch origin master
> >   git fetch origin refs/heads/*:refs/heads/*
> 
> OK, Brandon managed to convince me that this is fine. I've included glob
> support, supporting the same globs that git notes supports.
> ---
>  Documentation/fetch-options.txt | 16 +++++++
>  builtin/fetch.c                 | 41 +++++++++++++++++
>  fetch-pack.c                    | 19 +++++++-
>  fetch-pack.h                    |  7 +++
>  t/t5510-fetch.sh                | 78 +++++++++++++++++++++++++++++++++
>  transport-helper.c              |  3 ++
>  transport.c                     |  1 +
>  transport.h                     | 10 +++++
>  8 files changed, 173 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 97d3217df..6e4db1738 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -42,6 +42,22 @@ the current repository has the same history as the source repository.
>  	.git/shallow. This option updates .git/shallow and accept such
>  	refs.
>  
> +--negotiation-tip=<commit|glob>::
> +	By default, Git will report, to the server, commits reachable
> +	from all local refs to find common commits in an attempt to
> +	reduce the size of the to-be-received packfile. If specified,
> +	Git will only report commits reachable from the given tips.
> +	This is useful to speed up fetches when the user knows which
> +	local ref is likely to have commits in common with the
> +	upstream ref being fetched.
> ++
> +This option may be specified more than once; if so, Git will report
> +commits reachable from any of the given commits.
> ++
> +The argument to this option may be a glob on ref names, a ref, or the (possibly
> +abbreviated SHA-1 of a commit. Specifying a glob is equivalent to specifying
> +this option multiple times, one for each matching ref name.

I think you're missing a closing ')'

Aside from that nit this patch looks good, thanks!


-- 
Brandon Williams
