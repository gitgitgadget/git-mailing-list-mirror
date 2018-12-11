Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65E520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeLKCez (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:34:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51297 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:34:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so611864wmh.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2RIKVGEAiQT+LBxHJMKUfsxvmczD4aigVkMd00yPCaM=;
        b=tuFleV2GqiM0rrkUZRDJejjgagDFeuIQU4ezk+F85olR+9ZKucR1ope3Ec6eOCkoS9
         7MZ+K98Dw3+U+hZHIwcnY/gi5AZH0a4i1aClVbY95+3G6pLAR00GZ900AQg3NmRkMvUA
         PZzUGiJFmC5d8H0jQqkaddTkEXdbzVurPGTpzi1IhlDkIysnUxiYmRiExueTtdbeDgcI
         ljq/DgCCEl7wrlE+gJN7PSnV82tGTGT1XXjRLjfK3lRjqRkikkwhNRqasXo4gxSHut4Q
         3zq73uLG50aWzY6VQFKQ8gxyJ0xlLRjgaIBAvuFnylEmkakEIGqWfm2MMeET4MOzu/In
         MVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2RIKVGEAiQT+LBxHJMKUfsxvmczD4aigVkMd00yPCaM=;
        b=ljh6h9uFfyfjzGYb/cj4pDYPha4XZ4ZvXG4QZJmAo6ENL07VCLxrchJ9rfZkTKDNzq
         oq9GPfgcwO89P8NDPPPaPwx8nn8P3CD2WhHZt5LkN1DTg1OT0F6orDS+FUOKN1+qrdS/
         4tdmuGwbwIQD2FdWbTXMX/BMWHhRb8iqtupcogNW8RKLeAF1z7JSWKqfB8w9xo7o2fdy
         WjgDKYx4wotojxUOcSKaLGVRuKpCV1Ax4SJ5K4LX7S3S4MdU0CI8FQaM2OY8cnB5VjEM
         FQXNoJE06CH1gmMUVoexd3yFJ9nV3QCLxvWpA8RzEybppC7w6+xVlXAeTBOnFQoTVPFG
         m81Q==
X-Gm-Message-State: AA+aEWYxU2UESJb8xRl3LS0agylV9s1qK6RKSnekXqWr9l++/kIWSHL+
        8MFq2mV0YsUbD6idgzsENJF4AiYznZk=
X-Google-Smtp-Source: AFSGD/UgTrKEP/ol02O6gvHL8C/Q5CnvQ8/fX3+wjcQd/wW8ANsB0UtklfFxaA1IVRkxa6gN9l90pg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr592384wma.19.1544495693237;
        Mon, 10 Dec 2018 18:34:53 -0800 (PST)
Received: from szeder.dev (x4db2a4b1.dyn.telefonica.de. [77.178.164.177])
        by smtp.gmail.com with ESMTPSA id l202sm1663548wma.33.2018.12.10.18.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 18:34:52 -0800 (PST)
Date:   Tue, 11 Dec 2018 03:34:49 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] completion: complete <rev> in `git worktree add
 <path> <rev>`
Message-ID: <20181211023449.GS30222@szeder.dev>
References: <pull.82.git.gitgitgadget@gmail.com>
 <830191fbfbf95b9d568ba91ddcdd9860173a476a.1544454643.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <830191fbfbf95b9d568ba91ddcdd9860173a476a.1544454643.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 07:10:46AM -0800, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The second non-option argument to `git worktree`'s `add` command is an
> optional revision. Let's complete it.
> 
> Inspired by https://github.com/git-for-windows/git/pull/1681.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/completion/git-completion.bash | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9e8ec95c3c..4194b4a2e7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2773,6 +2773,11 @@ _git_worktree ()
>  		add,--*)
>  			__gitcomp_builtin worktree_add
>  			;;
> +		add,*)
> +			if [ $(__git_count_arguments "worktree") -eq 2 ]; then
> +				__git_complete_refs
> +			fi
> +			;;

Unfortunately, this seems to work only in the following case:

  git worktree add path <TAB>

i.e. when the two-be-completed word is still empty.  However,

  git worktree add path m<TAB>

doesn't work anymore, as it lists paths instead of refs.  Furthermore,

  git worktree add --detach path <TAB>
  git worktree add --detach path m<TAB>
  git worktree add -b newbranch path <TAB>

list paths as well.

However, I presume unintentionally,

  git worktree add -b <TAB>

does the right thing and lists refs, but with

  git worktree add -b m<TAB>

we are back at paths instead of refs.  OTOH,

  git worktree add --detach <TAB>
  git worktree add --lock <TAB>

will erroneously list refs.

I wrote a completion function for 'git worktree' a long while ago,
back when it had only two subcommands, which did mostly the right
thing, but I found it too convoluted for serious submission.  Here it
is for inspiration:

  https://public-inbox.org/git/1440190256-21794-1-git-send-email-szeder@ira.uka.de/

>  		list,--*)
>  			__gitcomp_builtin worktree_list
>  			;;
> -- 
> gitgitgadget
