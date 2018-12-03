Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17AB0211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 19:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeLCTe7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 14:34:59 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:34432 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCTe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 14:34:59 -0500
Received: by mail-ed1-f45.google.com with SMTP id b3so11836188ede.1
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 11:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7hnrMt/GMVrpZMufeRJLU80aOoGD0UuNAyb4RTnT0Tk=;
        b=UIz2UlTzAerknWv/9QrKq3W5nAm8s1IKoAh6OTFaeoMUx0SQfa2oRsIao8LjrsXPEb
         4ClMo3N6rkGa/xn2v4I+10p+1Z0rLqy70CJW08z77LtUTV2lVzlV3LHRl2zYAOLAZ52W
         FSSe8zSfzNQ8wYGl09BAjJ2wAw6+WaY71tgzYlp9yfiHpPSgG4tH/Z3k9ME0CKYXqe+8
         wxqQryj308+4pHGkUAonQWbNxWlgy4wyhMqbjzKZ+zYbjAjO/O28pao48OzAVPzAR8P8
         RnPjLse4DDYruptKQhcJZQ+bZtnG1epR5xJNiLyprA/cCjvcXRTW5G4feg6bk4KDptm1
         rDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7hnrMt/GMVrpZMufeRJLU80aOoGD0UuNAyb4RTnT0Tk=;
        b=cdJJE+EAbpM2rRc00syjqTdX5SZPmt+BJv+QA5+zonVk6CwHwjq9jE49IrOd6XCqrx
         7GtozwIDfUGAMPu3EVlO/ORs2m/HAvnkhnRcA7VDE1W4EdRERTKCSiYumSa/cmuIkHL9
         Tpmcf9yDcweeL2QqoapElPlysBqGSudkDSq/01GrIlwJ1BbmO85kcUiBeAYGuUB8IppH
         QMKFNeU9xugrQxZ+aF6zLbw6u59IL8ONmycAgt2oJw8E9hXNIqWGoW7KjUeH0iBFotmj
         54l2Rn2P4v3vCxM3pUF+bTw59MPprDK/Au+aijtURYZNgWKXU59KOv/Sh78kGlaV5X6C
         sCjg==
X-Gm-Message-State: AA+aEWbLJ0WM+kKr8spAEUueB3TR108RzgqbklS1kX+qkSRZgKhEtY+d
        UXkL0zc4NhHTdsEAkpMEfII=
X-Google-Smtp-Source: AFSGD/UDujEzkotSy+nNHhSFwGhOhLVJWRDKwlhh/d3YoBj1TzdYRkYnJhjrXPcOAatiNXZ0EQoNaA==
X-Received: by 2002:a05:6402:8d2:: with SMTP id d18mr15852508edz.119.1543865697137;
        Mon, 03 Dec 2018 11:34:57 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:6932:2c57:7da2:797e])
        by smtp.gmail.com with ESMTPSA id c12sm3898591edi.52.2018.12.03.11.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 11:34:55 -0800 (PST)
Date:   Mon, 3 Dec 2018 20:34:54 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181203193453.xmyu63wydym3koog@ltop.local>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
 <20181203172743.kq5zfbfnvjadeikj@ltop.local>
 <nycvar.QRO.7.76.6.1812031957060.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1812031957060.41@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180622
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 08:01:44PM +0100, Johannes Schindelin wrote:
> Hi Luc,
> 
> On Mon, 3 Dec 2018, Luc Van Oostenryck wrote:
> 
> > On Sat, Dec 01, 2018 at 03:02:09PM -0500, Jeff King wrote:
> > > I sometimes add "x false" to the top of the todo list to stop and create
> > > new commits before the first one. That would be awkward if I could never
> > > get past that line. However, I think elsewhere a "pause" line has been
> > > discussed, which would serve the same purpose.
> > > 
> > > I wonder how often this kind of "yes, I know it fails, but keep going
> > > anyway" situation would come up. And what the interface is like for
> > > getting past it. E.g., what if you fixed a bunch of stuff but your tests
> > > still fail? You may not want to abandon the changes you've made, but you
> > > need to "rebase --continue" to move forward. I encounter this often when
> > > the correct fix is actually in an earlier commit than the one that
> > > yields the test failure. You can't rewind an interactive rebase, so I
> > > complete and restart it, adding an "e"dit at the earlier commit.
> > 
> > In this sort of situation, I often whish to be able to do nested rebases.
> > Even more because it happen relatively often that I forget that I'm
> > working in a rebase and not on the head, and then it's quite natural
> > to me to type things like 'git rebase -i @^^^' while already rebasing.
> > But I suppose this has already been discussed.
> 
> Varieties of this have been discussed, but no, not nested rebases.

Interesting :)

> The closest we thought about was re-scheduling the latest <n> commits,
> which is now harder because of the `--rebase-merges` mode.
> 
> But I think it would be doable. Your idea of a "nested" rebase actually
> opens that door quite nicely. It would not *really* be a nested rebase,
> and it would still only be possible in interactive mode, but I could
> totally see
> 
> 	git rebase --nested -i HEAD~3

I don't mind much if it would be "really nested" or "as-if nested" but
with this flag --nested I wonder what would happen if I would use it
in a 'top-level' rebase (or, said in another way, would I be able
to alias 'rebase' to 'rebase --nested')?

> to generate and prepend the following lines to the `git-rebase-todo` file:
> 
> 	reset abcdef01 # This is HEAD~3
> 	pick abcdef02 # This is HEAD~2
> 	pick abcdef03 # This is HEAD~
> 	pick abcdef04 # This is HEAD
> 
 
OK, I see.
This would not be nestable/stackable but would solve the problem nicely.

Best regards,
-- Luc
