Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3A820D0C
	for <e@80x24.org>; Mon, 19 Jun 2017 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdFSR4k (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:56:40 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37312 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFSR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:56:39 -0400
Received: by mail-wm0-f44.google.com with SMTP id d73so379479wma.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2xRMQisRbXus8eB3+VDfhqVr06Yj4iEMtoz+mw7RqDo=;
        b=Zr8Vq/zeDIWeIr1+5YVeSFo/C3mIArfkcLXFd1WQONVdawrXwywzHrrWRDuoOBnzVi
         idz5UB8TunRV0z9GJ5qh+TNCtJnaS+XP3oGCn4KzEd1b0YtWhw2g89sRSVQooYCQLQCc
         yMqSc8kJEN5ZMklkt5m9ye8Q/B8UygUbCp7fN4SCRxzPbyoAckpJknv4wg5Z6UvXr2ma
         KhH98HZTwuVQh/ybk9f9Aks4GnMlDzPN0JXqhYiCvzvP/7HRw918gv5C3zY/Y6t0RBrr
         cuR7C5CQ05VGgI8tLBaWqGmEIzH6e/bO4mlk3pTjozqSwgPU3Ym+z66RJ/ix7bsnLj4H
         Opyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2xRMQisRbXus8eB3+VDfhqVr06Yj4iEMtoz+mw7RqDo=;
        b=YLgiSQHbqjnuOnM8PryosVvgZnQ80xNbvtRJfnqv/vOooLpyEN90YdfgVXBoBL0jQO
         qCS0r+qSmZJAtxYdLLkJ4hevlrc3LpHB0WXSprmgf+J7LwHyh/bLEQ7DAjdSYzOnd3YR
         OOhyhwVMst6m5Uo2sRWnHax4S6ufUunss1hR5hv/J5nT8x6C87qjiUYkXhTWthnw5wX6
         x+LOy1CxT6JJArhcJ5U72AOpjUTcNiWTZDvYs6QD9z2ZqzjcXNYPoc3DVjdMst+R1PNg
         t+QVDvf3imwO5nnDk960RPCYVCl64oz4nbgQgzOM98/HT2px4Yoacv2dyFsSJfCc8ggU
         sI5Q==
X-Gm-Message-State: AKS2vOz16/iHynfLtfyDhT9AFXPzcBn3+filyRh4xXvVwrn+VcxsbyCu
        gApizSCY4SsqI7umib4=
X-Received: by 10.80.139.65 with SMTP id l59mr18211677edl.52.1497894998091;
        Mon, 19 Jun 2017 10:56:38 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id j29sm6739793eda.26.2017.06.19.10.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 10:56:36 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dN0ui-0002Uz-9Q; Mon, 19 Jun 2017 19:56:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Lehmann <Patrick.Lehmann@plc2.de>
Cc:     Git Mailinglist <git@vger.kernel.org>
Subject: Re: Restoring detached HEADs after Git operations
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
Date:   Mon, 19 Jun 2017 19:56:36 +0200
Message-ID: <87r2yf97zf.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 19 2017, Patrick Lehmann jotted:

> Hello,
>
> I wrote a Bash script to recover branch names after Git operations have create detached HEADs in a Git repository containing lots of Git submodules. The script works recursively.
>
> I would like to see:
> a) that script or algorithm being integrated into Git by default
> b) that as a default behavior for all Git operations creating detached HEADs
>
> That's the command:
> --------------------------------
> git submodule foreach --recursive  'HEAD=$(git branch --list | head -n 1); if [[ "$HEAD" == *HEAD* ]]; then REF=$(git rev-parse HEAD); FOUND=0; for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" ); do if [[ "$(git rev-parse "$Branch")" == $REF ]]; then echo -e "  \e[36mCheckout $Branch...\e[0m"; git checkout $Branch; FOUND=1; break; fi done; if [[ $FOUND -eq 0 ]]; then echo -e "  \e[31mNo matching branch found.\e[0m"; fi else echo -e "  \e[36mNothing to do.\e[0m"; fi'
> --------------------------------
>
> How does it work:
> 1. It uses git submodule foreach to dive into each Git submodule and execute a series of Bash commands.
> 2. It's reading the list of branches and checks if the submodule is in detached mode. The first line contains the string HEAD.
> 3. Retrieve the hash of the detached HEAD
> 4. Iterate all local branches and get their hashes
> 5. Compare the branch hashes with the detached HEAD's hash. If it matches do a checkout.
> 6. Report if no branch name was found or if a HEAD was not in detached mode.
>
> The Bash code with line breaks and indentation:
> --------------------------------
> HEAD=$(git branch --list | head -n 1)
> if [[ "$HEAD" == *HEAD* ]]; then
>   REF=$(git rev-parse HEAD)
>   FOUND=0
>   for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" ); do
>     if [[ "$(git rev-parse "$Branch")" == $REF ]]; then
>       echo -e "  \e[36mCheckout $Branch...\e[0m"
>       git checkout $Branch
>       FOUND=1
>       break
>     fi
>   done
>   if [[ $FOUND -eq 0 ]]; then
>     echo -e "  \e[31mNo matching branch found.\e[0m"
>   fi
> else
>   echo -e "  \e[36mNothing to do.\e[0m"
> fi
> --------------------------------
>
> Are their any chances to get it integrated into Git?
>
> I tried to register that code as a Git alias, but git config complains about quote problem not showing where. It neither specifies if it's a single or double quote problem. Any advice on how to register that piece of code as an alias?
>
> If wished, I think I could expand the script to also recover hash values to Git tags if no branch was found.

I have something similar to this, this written before git-submodule
learned --branch (or at least before I knew about it):

    $ git config alias.sm-pull-all
    !git submodule foreach 'git checkout $(NAME=$name git sm-mainbranch) && git pull'
    $ git config alias.sm-mainbranch
    !git config --file ../.gitmodules submodule.$NAME.branch || git describe --all --always | sed 's!^heads/!!'

So with this I can run `git sm-pull-all` to update all the submodules in
a superproject to update them all. This relies on the branch name being
in the .gitmodules config.a

Now if you add a module with e.g. 'git submodule add -b master ...'
you'll have it checked out at the master branch, but I'm not familiar
enough with all the workflows around them to say if there are any holes
in that implementation.

But that seems like a fundimentally better approach to me than what
you're suggesting. Why would we try to work our way back from the SHA-1
and guess what branch it lives on when we can just encode the branch
name we'd like to be on in the superproject?
