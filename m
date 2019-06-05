Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997D11F462
	for <e@80x24.org>; Wed,  5 Jun 2019 16:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfFEQHB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 12:07:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35391 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfFEQHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 12:07:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so4242028wrv.2
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8mjiflKrPotsV7MEu5qScrNXfNySGNn0nHzrn08z0Tk=;
        b=AiVFjmP9NlajgdP4flVr6lYZx8cllEcVSgB5Hl4HyLk5Inai9MCq7W1Cvw/y8N2qFx
         6D8sNU3wKDFlZeK65x4ES7hwTXKWzVmrFkUcBd9pBFXz2W+REwT9B3a1HZiSiZgv3RuM
         IdZTU7EaY2Uj+CmQUpn+r0ZGC6XUDyLW4Y5eDelHRc2EHy9C66BXYAVx8td4ndYKK0R0
         GTIWaD0Tx7A+2ADMg/ZFU1FrPCvrlxqzo1Dwe8ZfHGGmNlVuGctVWEYQH5zXqwR1AtvK
         7naRlc5L9QSAR7l46MuZpK/e4jeDT3j+Jul0wfOs+hOCXbmPjVpNdqaFpMIElFmx6r3q
         MGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8mjiflKrPotsV7MEu5qScrNXfNySGNn0nHzrn08z0Tk=;
        b=oYlW8O0iw5PkM8Sf/VxI68QKmiuhuQLsTnzKv+vrzJ1+0FseN16DbHWCpZ3/bNQp43
         pKQjLY6nveOjoaqBogzFNjLbdx0vWSOUIftqaTHnmMDPZcG3Nl6STcmEFqK128w+uenu
         /HQTVHmB5EaFmwE7VfidNWDKNPtPGrhWHPq9ddNPuiDnjh7R9akWLHHeiuDqB7cyaD0N
         +ndWfvVnCtqbIXsMyUxqIFzjbjyutJvsG+zQ/6n+qP2zKrsR9q1b4LOaBQF/6v3mPYce
         dL0mWrW952G0LyxftohrhxG0ShUnGfDITmM2nrqXsVCrDvBpHFEwYAiX9w8Efj4P4sI3
         o/ng==
X-Gm-Message-State: APjAAAV4mfge8xVNAvA38I3sC/w8EijAomMQs3EIJ2iJjwixElY8XnX0
        xb0W0gn+i7UUqM4nOEWjxSCY1KD+
X-Google-Smtp-Source: APXvYqzl3Hq8/iIwzJxDxFPJ/zw+opA+rrbvGpALiyjp/L8bPgj44zgg96Wz2FnacrJYjir6mEvAQw==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr785209wrm.332.1559750819778;
        Wed, 05 Jun 2019 09:06:59 -0700 (PDT)
Received: from szeder.dev (x4db390d3.dyn.telefonica.de. [77.179.144.211])
        by smtp.gmail.com with ESMTPSA id a139sm32655644wmd.18.2019.06.05.09.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:06:58 -0700 (PDT)
Date:   Wed, 5 Jun 2019 18:06:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Edward D'Souza via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Edward D'Souza <edsouza@gmail.com>
Subject: Re: [PATCH 1/1] git-prompt.sh: update shell variable instructions.
Message-ID: <20190605160656.GU951@szeder.dev>
References: <pull.255.git.gitgitgadget@gmail.com>
 <0074d3da7ad402043d58ebb107435ce955a347f5.1559747165.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0074d3da7ad402043d58ebb107435ce955a347f5.1559747165.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 05, 2019 at 08:06:07AM -0700, Edward D'Souza via GitGitGadget wrote:
> From: Edward D'Souza <edsouza@gmail.com>
> 
> Clarify the need to set variables like GIT_PS1_SHOWDIRTYSTATE before
> "source ~/.git-prompt.sh" is executed in your shell init process.
> 
> If you set these preferences too late i.e. after .git-prompt.sh executes,
> they will silently fail to take effect.

I can't reproduce this.  It doesn't matter when these variables are
set, because __git_ps1() checks them each time it is invoked, it
always has.

  $ echo $GIT_PS1_SHOWSTASHSTATE $GIT_PS1_SHOWDIRTYSTATE $GIT_PS1_SHOWUNTRACKEDFILES
  
  /tmp/repo$ git init
  Initialized empty Git repository in /tmp/repo/.git/
  /tmp/repo (master)$ echo 1 >file
  /tmp/repo (master)$ git add file
  /tmp/repo (master)$ git commit -q -m initial
  /tmp/repo (master)$ echo 2 >file
  /tmp/repo (master)$ git stash 
  Saved working directory and index state WIP on master: 5ae0413 initial
  /tmp/repo (master)$ echo 3 >file
  /tmp/repo (master)$ git add file
  /tmp/repo (master)$ echo 4 >file
  /tmp/repo (master)$ >untracked
  /tmp/repo (master)$ GIT_PS1_SHOWSTASHSTATE=y
  /tmp/repo (master $)$ GIT_PS1_SHOWDIRTYSTATE=y
  /tmp/repo (master *+$)$ GIT_PS1_SHOWUNTRACKEDFILES=y
  /tmp/repo (master *+$%)$ unset GIT_PS1_SHOWSTASHSTATE GIT_PS1_SHOWDIRTYSTATE GIT_PS1_SHOWUNTRACKEDFILES
  /tmp/repo (master)$ 

Note that some of these status indicators are controlled not only by
environment variables but by corresponding 'bash.<indicator>' config
variables as well.  Even if the env var is set to enable the status
indicator globally, the config setting can still override that to
allow disabling potentially expensive indicators on a per-repo basis.
Is it possible that you had e.g. 'bash.showDirtyState = false' in your
config somewhere?

Anyway, even if the issue were real, this patch goes in the wrong
direction: instead of requiring a workaround from users, we should
rather fix the issue.

> Signed-off-by: Edward D'Souza <edsouza@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c6cbef38c2..ab5bcc0fec 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -35,6 +35,11 @@
>  #
>  # The prompt status always includes the current branch name.
>  #
> +# The prompt can be customized by setting various shell variables
> +# (GIT_PS1_SHOWDIRTYSTATE, GIT_PS1_SHOWSTASHSTATE, etc.), which are described
> +# below. Make sure that these variables get set *before* the
> +# "source ~/.git-prompt.sh" line from step 2 (above) runs.
> +#
>  # In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
>  # unstaged (*) and staged (+) changes will be shown next to the branch
>  # name.  You can configure this per-repository with the
> -- 
> gitgitgadget

