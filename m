Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB91211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeLCR1y (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 12:27:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45837 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbeLCR1x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 12:27:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so11428338edb.12
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S0Y9AUmlKU3TwQG+IhzllrNfOZF81StXeAcvPYMU0Z0=;
        b=nOrbh2yJKwWnGGX1c3nU1HmKllWkiE+YKnR21klf/9rSLF8ljDcK+TDDe4uxAyA4zz
         V7td4FoK45S9wkU/gpbpioIbGH9cTUePHu5V9d8rJ3IKfXU2AhYd5OBqmKHqwNPeDezA
         d1vRusQxBazTWWqQ5jMxIx6kTdZR6SaDCCe3QyX5aeR58DVvalHH+bObWZGEqTUYtS05
         kGJPGZdIryWjZ6/VxVw9/at5DazUZ/r2uF1DvR7AqgJkSPaQWhM5Ymtjxi9wj2x1VvWG
         2G6Bhir3x74nrzeQnF3xcjnZ/+gonMprlKZtc8ZumJZN8MW9ycBYpmZDXSk3bKAsukDd
         jUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S0Y9AUmlKU3TwQG+IhzllrNfOZF81StXeAcvPYMU0Z0=;
        b=MVfUQq9FkM5B7KExvFOyyTU65VOAYTBV/E6BbNr53lUTlwy25CWtvOoHFQoluL1qhv
         PJofERIVRWQ4wqCvQMnFS10OoFYFNfxcb5av25tN0m9nqaxNPrpeqNOa8gn/P7QVeRSi
         DyOqamX0dBY5uH0lSIrjN8eNnqQEO8QQ338GO1qS7II+JMjmEEyL0IqMpc9aYMDyAen8
         3rrBc3ChbQka1oWly5zVQBrS11Cw3I6cfzG9vGOuyVT1sMKYHRGl3Ior0rt+HM14Q+xs
         WJxcwYZGmusSsRpaYQWQbyq/UCWYFyPLpjjz2iJ3tRy1ac6tjwM4bkS9aUNhd0H+7iKs
         o40g==
X-Gm-Message-State: AA+aEWZv/F5IZeQ4CB0mq/26YYMqZMyVufcvF3O5zbA3nvad/c0lFp+s
        4wNIGr2WXG9P2Vcyq55QUl8=
X-Google-Smtp-Source: AFSGD/V/ggsvTKD8RzwNEhcJinQrs+4hUMVOLKuTcQB5aqboZrYqJ2q7I3V/TTbVEOlFiYfsk4BCbQ==
X-Received: by 2002:a50:a55c:: with SMTP id z28mr15347396edb.124.1543858066522;
        Mon, 03 Dec 2018 09:27:46 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:80a7:d0cb:1a72:c5ab])
        by smtp.gmail.com with ESMTPSA id b6sm4346849edd.94.2018.12.03.09.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 09:27:45 -0800 (PST)
Date:   Mon, 3 Dec 2018 18:27:44 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181203172743.kq5zfbfnvjadeikj@ltop.local>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201200209.GC29120@sigill.intra.peff.net>
User-Agent: NeoMutt/20180622
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 01, 2018 at 03:02:09PM -0500, Jeff King wrote:
> On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:
> 
> > > > Would it not make more sense to add a command-line option (and a config
> > > > setting) to re-schedule failed `exec` commands? Like so:
> > > 
> > > Your proposition would do in most cases, however it is not possible to
> > > make a distinction between reschedulable and non-reschedulable commands.
> > 
> > True. But I don't think that's so terrible.
> > 
> > What I think is something to avoid is two commands that do something very,
> > very similar, but with two very, very different names.
> > 
> > In reality, I think that it would even make sense to change the default to
> > reschedule failed `exec` commands. Which is why I suggested to also add a
> > config option.
> 
> I sometimes add "x false" to the top of the todo list to stop and create
> new commits before the first one. That would be awkward if I could never
> get past that line. However, I think elsewhere a "pause" line has been
> discussed, which would serve the same purpose.
> 
> I wonder how often this kind of "yes, I know it fails, but keep going
> anyway" situation would come up. And what the interface is like for
> getting past it. E.g., what if you fixed a bunch of stuff but your tests
> still fail? You may not want to abandon the changes you've made, but you
> need to "rebase --continue" to move forward. I encounter this often when
> the correct fix is actually in an earlier commit than the one that
> yields the test failure. You can't rewind an interactive rebase, so I
> complete and restart it, adding an "e"dit at the earlier commit.

In this sort of situation, I often whish to be able to do nested rebases.
Even more because it happen relatively often that I forget that I'm
working in a rebase and not on the head, and then it's quite natural
to me to type things like 'git rebase -i @^^^' while already rebasing.
But I suppose this has already been discussed.

-- Luc
