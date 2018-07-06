Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA901F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 22:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeGFWqW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 18:46:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35891 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbeGFWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 18:46:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so5495382wro.3
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z3TbI6elKNHh3skGPE/nHlqU6k78XVrd+49mCQYGVWU=;
        b=l3AHPW9uQHAzr/GEut96jq4sumZq7d/mxVs4y4+ekr/ePHtdEOWQAR83HuiZHqUI5W
         xxSPZRjrLLZGOXOMzdE0EE9eFoie0sPPqFxZ2MuoEp9Q5FG+c6Yo8maqlrr5sm8Wv5ff
         K5lFfAsEsu0TAr7gkxO7IRNz4/0wXUPFi+Cuk+CZq6KkQwkuROBOCeHQ8FpfQcgeiNAq
         aJZzwhgpm1bthQ/MGztxpTVNrsiAxBOlkHWCj4vpOaHzt+rm1EVi51CyoaQypL1mgDuH
         UZBMMTXMAj50eQndD6/CimYcGeK213AzeO5ZfC+0l8qQrKKgEHXHj/rHl0WKNtUrdrDA
         SUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z3TbI6elKNHh3skGPE/nHlqU6k78XVrd+49mCQYGVWU=;
        b=tS3vmHAVynnHlUXTvwVl03yXLSn99A+k/g7Kw+4afBBmVI6ah1dfQmlszq1bkZPhI/
         QMctM7heRPL/ErZlY4i05EHZQLb2HeUO/fyO98gOdFaPAaG7KCmffhFky68t6K6MGLNn
         WyCIjxmIOroU8XyrBvd9ULhLKQdK3bOxRUf6Bf8BJMpBVAbF9h3kFwqKrSsu9lER8q6M
         BpchcUNAO65EON+2LsZoDLfbd/u/j76GDSmVfoRQ1Sx09/20HZdhBHhhzCuEqOYIuYvO
         XMnXFQHnLtr1EM536941F5UkCCcXkRTHG+gwFRN+WVsCTLnRYkMd0NiWlRCJrtG+dbhZ
         rhkA==
X-Gm-Message-State: APt69E1tK32uI8yJLvwmSMdT13SVRuxwxsOmPcPtAd1DyCdF4A8NIkt1
        +3WuJ36nxEk+HzQQw+kDBb0106ux
X-Google-Smtp-Source: AAOMgpdYmUPH4SFuWTZeGq7Vy2l7EnKJHE1ucHNOo5XkPagXmF1RQlcbSekdHOSZQhYwGUci4uCc5A==
X-Received: by 2002:adf:ae51:: with SMTP id u17-v6mr8250054wrd.201.1530917180224;
        Fri, 06 Jul 2018 15:46:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v67-v6sm10847775wme.8.2018.07.06.15.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 15:46:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 18/20] completion: support `git range-diff`
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <d05b54c603dc68acf198bb8826e3af4f2f11021f.1530617166.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Jul 2018 15:46:19 -0700
In-Reply-To: <d05b54c603dc68acf198bb8826e3af4f2f11021f.1530617166.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 3 May 2018
        16:44:25 +0200")
Message-ID: <xmqqpo00geys.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Tab completion of `git range-diff` is very convenient, especially
> given that the revision arguments to specify the commit ranges to
> compare are typically more complex than, say, your grandfather's `git
> log` arguments.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Have three-dash lines here, or perhaps have some validation hook in
the garden-shears tool to notice these leftoer bits we see below?

>
> squash! WIP completion: support `git range-diff`
>
> Revert "WIP completion: support `git range-diff`"
>
> This reverts commit 2e7af652af9e53a19fd947f8ebe37a78043afa49.
> ---
>  contrib/completion/git-completion.bash | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 94c95516e..402490673 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1976,6 +1976,20 @@ _git_push ()
>  	__git_complete_remote_or_refspec
>  }
>  
> +_git_range_diff ()
> +{
> +  case "$cur" in
> +  --*)
> +          __gitcomp "
> +	  	--creation-factor= --dual-color
> +                  $__git_diff_common_options
> +                  "
> +          return
> +          ;;
> +  esac
> +  __git_complete_revlist
> +}
> +
>  _git_rebase ()
>  {
>  	__git_find_repo_path
