Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75716201A7
	for <e@80x24.org>; Tue, 16 May 2017 00:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbdEPAh5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 20:37:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34894 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdEPAh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 20:37:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so17738890pfd.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 17:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=dCNlDJX+6Krf0WspGB+iXZxv4C9d9oPIrJXJ4WTQik0=;
        b=a6lcNro5aD3Vts1ny3k9WxmdjyEaDr3LAkPgCzV+O9cxI1uHxgNp2BFQBqEJjo/iBV
         7dzn/MpDdvniEvOvcHthNPtdBFnm1AyPrUBZKXEfuawnMgDopwz2GCt/2dWCUDLsy31e
         oxrKCUt7eCgiEmAuNU/d0vZUGYD+BzejghAf0LNiwAfdQuzxt7+eqIcHfs+QTXqGd26K
         CJR39OQ7UpJq1AOnDQ8lC0zHGFCZ7Ya4XOGEfit2dK2G75yUQlZtY74Kv37mMPtLw0c4
         HgDRm8tQ66Jb9gX11PrbOcx5CR/ytEwOYxJnoKpCUz4dpeDK29xrjoFfWpSTLF3FwZ5h
         VFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=dCNlDJX+6Krf0WspGB+iXZxv4C9d9oPIrJXJ4WTQik0=;
        b=DISobWGr73QkxFu3TrHvkJCAJHrMVHii3+lzDf4cXzGd7+4J4nYbLU7niYIkWQZxYD
         zb0HJEOPq8PqfQk2VVnpNKnv8rjeGIEjy07TIXnj5IMC0RDgXHKKh9+K/91rbNbEJIyl
         iszeF6N0lcwHrP2dmZzEB+qH6VGsd9kKr0Xepdh8QmTgup/gIs7pgfa/rZQpVxXDNuUc
         WkF0GhAbFRB7et/gKK+Q1cuEgWPuFaW3XBvIXBmnYrI0jrYkp/V4oyOvP367eU0sOPcs
         i1Y8EozQ404438MkxI7vIFygKAE/zNnpGAQ/90jYrprijpO4a5Zgx/aFQc3CWFhmzSHN
         buGg==
X-Gm-Message-State: AODbwcBq5oK0A4JxS4LO2yI9X0KLbBWKRkfZKdnt6I1MHsRNQ9A6xGXJ
        hoBW0x8AOlRvwA==
X-Received: by 10.99.125.11 with SMTP id y11mr9122659pgc.5.1494895075398;
        Mon, 15 May 2017 17:37:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id x4sm23344926pgc.65.2017.05.15.17.37.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 17:37:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
        <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121216290.146734@virtualbox>
Date:   Tue, 16 May 2017 09:37:54 +0900
Message-ID: <xmqq7f1h63h9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 12 May 2017, Junio C Hamano wrote:
>
>> Is it really hurting us having to support these old information
>> sources we treat as read-only?
>
> Well, you frequently complain about my patches, claiming that they place
> unnecessary maintenance burden on you.
>
> I would say that the .git/remotes/ and .git/branches/ code is a lot more
> maintenance burden than most of my patches.

I wasn't going to respond to this thread anymore, because I didn't
feel like the discussion was going anywhere, and you already said
you won't listen to me.

You seem to be confused between "maintenance burden" and "burden on
the maintainer". I felt that it needs to be corrected for other
people reading this exchange from the sideline.

    When we worked to add feature X in the remotes subsystem, we
    were slowed down because we had to adjust the code also for
    .git/branches.  The same story for feature Y.  The same for
    feature Z.  This is getting ridiculous/cumbersome, especially
    given that we know .git/branches is not used by anybody.

That's a maintenance burden, and the "we" refers to the Git
development community as a whole, not the maintainer.  It is not a
burden on _me_.

Also important to notice is I do not know what X, Y and Z are with
respect to .git/branches feature.  That is where "Is it really
hurting?" question comes from, but it hasn't been answered so far.

What's burden on the maintainer is having to engage in a discussion
like this one, to reject an attempt to remove something that is not
demonstratably a maintenance burden, because the maintainer has to
act as the last-resort champion for the end-users, when others on
the list do not speak up X-<.

Yes, I know that proving that something we currently support is not
used by anybody is HARD [*1*].  That is why removal is costly.  And
that in turn is why we need to be careful when adding new things and
making changes in general.


[Footnotes]

*1* Removal of "rsync" transport we did recently was a happy but
    rare case.  It has been broken for a few years without anybody
    complaining.
