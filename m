Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227C5211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 18:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfAFSJS (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 13:09:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45448 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAFSJS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 13:09:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so41020835wrr.12
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Kb3+tjoYYR7Gus1GnbXKYyUanItedjgeu5zghlzJTRk=;
        b=Vsc0NbvwNABwZeYPfXjsYN5j1ebdPKsWkQZV9skukRlof2mj1f7otmvb2RMh3XFI7O
         xGMNZ6y3NHhQzaR48Q1koZQyumu2bqNQQsCQ7RorDbWW/n9QoSntJU0wyNuc7tjv0bsq
         RuVSsprSCXdoz6N48qD3EPeQHGS9BIOTe4+thxzgvu5X2yRk92sHNMUVtvYgKZDUewEM
         VxKxbp9ySDCKv84lILVhQ8to4FcDjYd+DROJtyaBnIO/k3D1khx7qHxq83RuoL/DUl4Y
         jv4Laeov1zcU94k83zFV3qb7cjgTBURnTikS9aHEt38HQCbzioNwwBd5wAUHZPP39D6R
         tgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kb3+tjoYYR7Gus1GnbXKYyUanItedjgeu5zghlzJTRk=;
        b=e145F5feQs9vtLnzte1M/qB4Da8X+c14+xaXjIFkuddO9S+7y7tpdi/wVhlJB7qEeQ
         eHQ5LzbYfoy1BwFpqjuyDeUUTF1n5HsM5ETKo01l1vBKWTZm11eOnxIm/WpkOT17FNjR
         mE1uRWl9fXvWQDx6XPoqgHIOtLnRCZBiKr6aqBEeal1kpRlUekyo4UVOPaoXx3MW9KyH
         2CMPEBGBTZuQHllNccVk2VGV12Ay/i8fEBHrXgHYGBV9Sk4gsIn+UhPmUziyn9YNuxq2
         N4TrqglCg4NL4TIvEdo41BtJCCdGUb9UxlrjIfKZ7yqskFE6EWE93SvpQCYEK/E4zwP2
         9QtQ==
X-Gm-Message-State: AJcUukfOVFquIrNygPcOJxe/QBNNAdQTTM90zuyqSB7G80ADWmQ05+WJ
        894vchuqsvFHRg+JRqIWe8n0a+fU
X-Google-Smtp-Source: ALg8bN48h+ohxW4Ua4g5EBTkXjjY3zzWroKl7vkbmuih59d6+z8xq1daUDYqlsEk36Bs7x74NYdjhA==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr48454045wrw.132.1546798156374;
        Sun, 06 Jan 2019 10:09:16 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id o16sm60898758wrn.11.2019.01.06.10.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 10:09:15 -0800 (PST)
Date:   Sun, 6 Jan 2019 18:09:14 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9C10LMg0KHQsNC80L7QudC70L7Qsg==?= <splarv@ya.ru>
Subject: Re: [PATCH] doc/config: do a better job of introducing
 'worktree.guessRemote'
Message-ID: <20190106180914.GE25639@hank.intra.tgummerer.com>
References: <20181223192435.24803-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181223192435.24803-1-sunshine@sunshineco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/23, Eric Sunshine wrote:
> The documentation for this option jumps right in with "With `add`",
> without explaining that `add` is a sub-command of "git worktree".
> Together with rather odd grammatical structure of the remainder of the
> sentence, the description can be difficult for newcomers to understand.
> Clarify by improving the grammar and mentioning "git worktree add"
> explicitly.
> 
> Reported-by: Олег Самойлов <splarv@ya.ru>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---

Thanks, this reads much better indeed.  I was briefly wondering if a
similar change is needed in the documentation for the 'git worktree'
command itself.  It currently reads:

	With `worktree add <path>`, without `<commit-ish>`, instead
	of creating a new branch from HEAD, if there exists a tracking
	branch in exactly one remote matching the basename of `<path>`,
	base the new branch on the remote-tracking branch, and mark
	the remote-tracking branch as "upstream" from the new branch.

I do think the documentation for the config option is slightly easier
to read, especially with your improvements below.  Dunno if it's worth
adjusting the test in the 'git worktree' documentation as well?

> Reference: https://public-inbox.org/git/0E640233-B2CB-465D-9713-BBECE331CA80@ya.ru/
> 
> Documentation/config/worktree.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/worktree.txt b/Documentation/config/worktree.txt
> index b853798fc2..048e349482 100644
> --- a/Documentation/config/worktree.txt
> +++ b/Documentation/config/worktree.txt
> @@ -1,6 +1,6 @@
>  worktree.guessRemote::
> -	With `add`, if no branch argument, and neither of `-b` nor
> -	`-B` nor `--detach` are given, the command defaults to
> +	If no branch is specified and neither `-b` nor `-B` nor
> +	`--detach` is used, then `git worktree add` defaults to
>  	creating a new branch from HEAD.  If `worktree.guessRemote` is
>  	set to true, `worktree add` tries to find a remote-tracking
>  	branch whose name uniquely matches the new branch name.  If
> -- 
> 2.20.1.415.g653613c723
> 
