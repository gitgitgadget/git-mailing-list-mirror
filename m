Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55781F403
	for <e@80x24.org>; Mon,  4 Jun 2018 03:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeFDDkt (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 23:40:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36111 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeFDDkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 23:40:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id v131-v6so11963900wma.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 20:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=esKI3fUiCdGbg1HCmp/OoITa52aG+pQyGl56e8eYEO8=;
        b=aZRh+6rWD9f/DxtftKk9ha14WQ043z7LwmVwixpSXQX9SZzombbxtIeKaVD3FJVVG4
         U9DqjLD0QVaFEBamCoaQexVzLyaqX+rfJoTXzHLVxT7ER+UOQ1T2lOxc7zhtAzNl+m/u
         6Y7bJQRyJ6spMU7iHFIs+6kUlY6qvh57sUIOJetHMsNVmA5H4P6gbCaVKVi/dsHgWakn
         yH8+hwQsG4ifr09clHbKmuf6EmXO67VaYvFTrvwaaroTYWfBUgBDsrvhMwsv1CoGlbTW
         /e38h61iMt6hkFj7d6ME7+phOcMH7NY5Px69zCS18i1qnC5ydmdgSyRaheGgK5ZDhjdt
         SUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=esKI3fUiCdGbg1HCmp/OoITa52aG+pQyGl56e8eYEO8=;
        b=eT/YhtKaCpKQTPbbKLCgIf/hNciTOvnjLz4NB+ck00qArKYYPcflBNKoAESOrGUHz5
         KVIyj+cp6nxDg8rTevtG+jGYoB7Vl7J4l/MmU8zqdUSYig5D0bo1dE+kjcZzTYfrZozh
         6RoNmh/Sn6nKEsj8ZKUCbRI2+ycyv2KaEv7q0Y3kPuyxi0ML1lRH1rRriCsh56H4lDES
         Aamc3rS2hY7NeCj7OJyqPvK6RtfLoktcrJxOQVaE7sF20TOB6KFyPRZGOd3Dha9thbFJ
         ELivZbIwHLSkFEbULY/9KB0bqqLsZdI7qMj0IpZOaX5Dm2CKtLtC1p3F3UTiUv23E30y
         /Wsg==
X-Gm-Message-State: APt69E06lLH3pfil2gZCOE1JMtcFkvYPLYDJpOY2b6IMxpcSfpePXJ3y
        U8z7126vmWM/pI6gf5oiNQw=
X-Google-Smtp-Source: ADUXVKIy3DjgE+X8qQNCnCtgyZXgDBPenJM4a+Mc91SeIZBUZxuzl+QniQyeY76QC51hQyRPG7diWA==
X-Received: by 2002:a1c:2d15:: with SMTP id t21-v6mr484119wmt.42.1528083646467;
        Sun, 03 Jun 2018 20:40:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t13-v6sm12447839wro.62.2018.06.03.20.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 20:40:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rick van Hattem <wolph@wol.ph>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Use ZSH_NAME instead of ZSH_VERSION because it's redefined by git-completion.zsh
References: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com>
Date:   Mon, 04 Jun 2018 12:40:45 +0900
In-Reply-To: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com>
        (Rick van Hattem's message of "Sun, 3 Jun 2018 16:38:43 +0000")
Message-ID: <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rick van Hattem <wolph@wol.ph> writes:

> The `git-completion.zsh` unsets the `$ZSH_VERSION` which makes this check moot. The result (at least for me) is that zsh segfaults because of all the variables it's unsetting.
> ---

Overlong line, lack of sign-off.

>  # Clear the variables caching builtins' options when (re-)sourcing
>  # the completion script.
> -if [[ -n ${ZSH_VERSION-} ]]; then
> +if [[ -n ${ZSH_NAME-} ]]; then

I am not a zsh user, and I do not know how reliable $ZSH_NAME can be
taken as an indication that we are running zsh and have already
found a usable git-completion-.bash script.

I think what the proposed log message refers to as "unsets" is this
part of the script:

        ...
        zstyle -s ":completion:*:*:git:*" script script
        if [ -z "$script" ]; then
                local -a locations
                local e
                locations=(
                        $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
                        ...
                        )
                for e in $locations; do
                        test -f $e && script="$e" && break
                done
        fi
        ZSH_VERSION='' . "$script"
	...

If your ZSH_VERSION is empty, doesn't it indicate that the script
did not find a usable git-completion.bash script (to which it
outsources the bulk of the completion work)?  I do agree segfaulting
is not a friendly way to tell you that your setup is lacking to make
it work, but I have a feeling that what you are seeing is an
indication of a bigger problem, which will be sweeped under the rug
with this patch but without getting fixed...
