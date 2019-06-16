Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2AE1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 22:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfFPWdR (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 18:33:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55630 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfFPWdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 18:33:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D06F775D7;
        Sun, 16 Jun 2019 18:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qwdcldY+6g+VYAzb/wv5i4lrjIc=; b=ZHMf8l
        hrbdu80X7GSbYoVGn/a1p9K6boidzZ5STTDFANHwx2Qz4iA5hFRBh/F+tth8UFze
        Nnh3/oCs1ER4bKlaVzsOBiNywJzsUB0+N5tioQzLCOj3Aa7zncQ9a4eekLzJaVXU
        +XwKFea3kCPKjRkRakaDWTmwcTsb0eXwaxVgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aFSIEKIbCxwrgfYchoxaYi3h3Q0NmivV
        0BZ/PSVJgLzjZkKIsamxNUx5D/Ap1EMPNCqb5713hZ58vbyov4SRLPofEmZGClkL
        RvjHwmpDBQunCb0hPnc7O1Rm7buOH/L2lUa+8qLTg5q9SzQ/VH8P+bRNwAwfdSDe
        F3cjBq5Hsng=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74F16775D5;
        Sun, 16 Jun 2019 18:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F476775D4;
        Sun, 16 Jun 2019 18:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] show --continue/skip etc. consistently in synopsis
References: <20190616132457.19413-1-phillip.wood123@gmail.com>
Date:   Sun, 16 Jun 2019 15:33:07 -0700
In-Reply-To: <20190616132457.19413-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Sun, 16 Jun 2019 14:24:57 +0100")
Message-ID: <xmqq36k9tb30.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7B1BD86-9086-11E9-9222-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The synopsis for am shows the command mode options as
>     (--continue | --skip | --abort | --quit)
> They are on a single line and in parenthesis as they are not
> optional. Fix the merge and rebase docs to match this style.

Is it so clear-cut that it is more "correct" to have everything on a
single line, as opposed to describing each one per line?  I am not
sure.  

I would say both the above style and the style used by "git merge"
documentation are correct.  The "rebase" one is a different story
and the change in this patch deserves to be called a "fix".

As long as the more concise "am" style is already prevalent (are
there pages other than "am" you can cite?), I would agree with you
that the change to "git merge" in this patch is a good idea for
consistency's sake.

> ---
> This patch is based on top of nd/merge-quit.

Thanks for indicating where it should go.  We need your sign-off,
too.



> The docs for cherry-pick/revert are updated to this style by
> https://public-inbox.org/git/20190616082040.9440-1-rohit.ashiwal265@gmail.com/T/#u
>
> Documentation/git-merge.txt  | 3 +--
>  Documentation/git-rebase.txt | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index b7d581fc76..07ca9fb78c 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -13,8 +13,7 @@ SYNOPSIS
>  	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>  	[--[no-]allow-unrelated-histories]
>  	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
> -'git merge' --abort
> -'git merge' --continue
> +'git merge' (--continue | --skip | --abort | --quit)
>  
>  DESCRIPTION
>  -----------
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 5629ba4c5d..a67d40596a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  	[<upstream> [<branch>]]
>  'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
>  	--root [<branch>]
> -'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
> +'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
>  
>  DESCRIPTION
>  -----------
