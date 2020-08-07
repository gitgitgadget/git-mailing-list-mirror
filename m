Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FA0C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CFD20866
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHGIEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:04:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45606 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGIEg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 04:04:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 83B321F990;
        Fri,  7 Aug 2020 08:04:36 +0000 (UTC)
Date:   Fri, 7 Aug 2020 08:04:36 +0000
From:   Eric Wong <e@80x24.org>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        git@vger.kernel.org
Subject: Re: avoiding fetching specific refs from a remote
Message-ID: <20200807080436.GA21342@dcvr>
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
 <20200805063704.GA2690083@coredump.intra.peff.net>
 <BE29FA64-5281-4D9E-B509-CA2C2B7BB87D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BE29FA64-5281-4D9E-B509-CA2C2B7BB87D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> wrote:
> > Le 5 août 2020 à 02:37, Jeff King <peff@peff.net> a écrit :
> > This is definitely a reasonable thing to want, and it has come up off
> > and on over the years. One search term for the list archive is "negative
> > refspecs", though it turns up a lot of useless hits when the two words
> > are not directly adjacent.
> 
> I tried searching "negative refspecs" (*with* the double quotes) and I get 20 results so it 
> seems to work. Although interestingly it doesn't find this message you wrote I'm responding to 
> because "negative" and "refspec" are on separate lines... I'm CC-ing Eric in case he knows more
> about this limitation.

Initially I thought it was phrase searching being disabled
on lore (Xapian 1.2, "chert" backend).  However, I just
tried on lore and it shows Jeff's message from
2020-08-05 6:37 UTC:

 https://lore.kernel.org/git/?q=%22negative+refspecs%22

So maybe it was a delay due to Xapian's MVCC mechanism;
but that shouldn't be HOURS off (maybe minutes at most),
assuming you tried to search shortly before you sent
the message I'm replying to at 22:12 UTC...

My v1 instance at public-inbox.org (which uses Xapian 1.4
and the "glass" backend) shows it, too:

 https://public-inbox.org/git/?q=%22negative+refspecs%22

You could also try NEAR and ADJ (I don't have much experience
with those): https://xapian.org/docs/queryparser.html
