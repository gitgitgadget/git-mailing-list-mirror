Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EE920D12
	for <e@80x24.org>; Mon, 30 Jan 2017 21:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbdA3VOC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:14:02 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36182 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbdA3VOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:14:01 -0500
Received: by mail-yb0-f194.google.com with SMTP id o65so2161162ybo.3
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=iilvM65Yhix79BwWr/6u9LqmQ1v3q6PxnSkzxu7TtG4=;
        b=Qt06N3S/wmsXsrPb12490uWBOGUTU9mtSVNdbqrNgnmuviC9gx52pyaVlMspgxldyD
         E3KTOmFpjvcrQHn/u5kpWFUo/NxuvGu3Y3fhihrFJx2zH26gLihhZl/f8Z5qw3t/rnSY
         iVKxo1QINaXDZzFOgOiaaxeHgZeFZ3uy/7sJTrLglOo/GUmyL2VyHruIylUiDaChe9EE
         W6CclmU1rCsTfZritrjYsjtMzHwoSwzQDoPrCOy/qgGWH2g8GvBADruLaaAwgoajxY+2
         dOkQthiLsBcu9mdgKmZe+XiyqPb7YC863RYWrCXvrYbVo4EK6rlDc6Jmq3eKrxa0LVLm
         0o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=iilvM65Yhix79BwWr/6u9LqmQ1v3q6PxnSkzxu7TtG4=;
        b=R/IVXW/AMWAR31K87+SE8Oq1Tk4UXV6MvJVrt1HJwxEI44PsNJypdNr+C4oRenb/ir
         A5b5EU995cIMGItbLpWMXtWkMZ7OVHE7SUH1q8O6G4HxGv5HBMyl7dUYPf0SST6H+zRA
         lpD31pwpUY0n3MI6ilMdWb4m5FuT6375eTc8pmueyaPbG9B4QfOj+d2A0F3IDg7FFcuS
         AYUTYuNdNQWhslz1C00wksZ9zYeFjWwZjgcwWplhb+zamBYHpKLNbwEG6skklKcgkXHU
         yjTAzsdp/vU/B5HRSFb7Mwsti5nybKrU60z54zxaChoF6xSkbQq1moyKbNYIuJAwBfot
         V8eg==
X-Gm-Message-State: AIkVDXLmXyuFB7T1a2UPmrTixy5/fO4KsWXbN+f8rwjIfoCLts/xnNK/clkSWWyzW6dkvg==
X-Received: by 10.13.218.195 with SMTP id c186mr16415691ywe.15.1485810795951;
        Mon, 30 Jan 2017 13:13:15 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id d11sm7877211ywc.22.2017.01.30.13.13.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 13:13:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/4] Documentation/stash: remove mention of git reset --hard
In-Reply-To: <20170129201604.30445-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 29 Jan 2017 20:16:01 +0000")
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170129201604.30445-1-t.gummerer@gmail.com>
        <20170129201604.30445-2-t.gummerer@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
Date:   Mon, 30 Jan 2017 13:13:14 -0800
Message-ID: <xmqq7f5cuu8l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Don't mention git reset --hard in the documentation for git stash save.
> It's an implementation detail that doesn't matter to the end user and
> thus shouldn't be exposed to them.

Everybody understands what "reset --hard" does; it can be an
easier-to-read "short-hand" description to say "reset --hard"
instead of giving a lengthy description of what happens.

Because of that, I do not necessarily agree with the above
justification.  I'll read the remainder of the series before
commenting further on the above.

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 2e9cef06e6..0fc23c25ee 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -47,8 +47,9 @@ OPTIONS
>  
>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  
> -	Save your local modifications to a new 'stash', and run `git reset
> -	--hard` to revert them.  The <message> part is optional and gives
> +	Save your local modifications to a new 'stash' and roll them
> +	back both in the working tree and in the index.

"... roll them back both ..." is unclear where they are rolled back
to.  

Perhaps "roll them back ... to HEAD" or something?
