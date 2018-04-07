Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AE31F404
	for <e@80x24.org>; Sat,  7 Apr 2018 23:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeDGXIu (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 19:08:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59476 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751869AbeDGXIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 19:08:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 168931F404;
        Sat,  7 Apr 2018 23:08:49 +0000 (UTC)
Date:   Sat, 7 Apr 2018 23:08:48 +0000
From:   Eric Wong <e@80x24.org>
To:     David Davis <davidjamesdavis.djd@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git send-email not sending email patches as subsequent replies
Message-ID: <20180407230848.GA5048@80x24.org>
References: <CANqAOmsZxpbkT3YFcZTOeRx2gnxnzc+_C-amVQjKSE=0m7_n7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANqAOmsZxpbkT3YFcZTOeRx2gnxnzc+_C-amVQjKSE=0m7_n7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Davis <davidjamesdavis.djd@gmail.com> wrote:
> Hello, I have the following git send-email command:
> 
> git send-email -5 --quiet --thread --no-chain-reply-to --compose
> --subject='Recent Base Prototype Changes Summary'
> --to=davisdavid@google.com --from=davisdavid@google.com
> 
> It's sending emails but as 5 individual emails and not as subsequent
> replies as suggested on https://git-scm.com/docs/git-send-email below:

So, I expect the above command should give you six emails:

  [PATCH 0/5] Recent Base Prototype Changes Summary
    [PATCH 1/5]
    [PATCH 2/5]
    [PATCH 3/5]
    [PATCH 4/5]
    [PATCH 5/5]

Is that not what you're seeing?

You're quoting the manpage for --in-reply-to option below,
but you're not using that option.

> So for example when --thread and --no-chain-reply-to are specified,
> the second and subsequent patches will be replies to the first one
> like in the illustration below where [PATCH v2 0/3] is in reply to
> [PATCH 0/2]:
> 
> [PATCH 0/2] Here is what I did...
>   [PATCH 1/2] Clean up and tests
>   [PATCH 2/2] Implementation
>   [PATCH v2 0/3] Here is a reroll
>     [PATCH v2 1/3] Clean up
>     [PATCH v2 2/3] New tests
>     [PATCH v2 3/3] Implementation
> 
> What am I missing?

I'm not sure...  I suspect you're either not using --in-reply-to=
or misreading the manpage, somehow.
