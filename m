Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347D41F463
	for <e@80x24.org>; Tue, 24 Sep 2019 15:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfIXPdS (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 11:33:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728702AbfIXPdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 11:33:18 -0400
Received: (qmail 7738 invoked by uid 109); 24 Sep 2019 15:33:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 15:33:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9873 invoked by uid 111); 24 Sep 2019 15:35:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 11:35:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 11:33:17 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190924153316.GA1801@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190923180751.GA21344@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1909241624300.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909241624300.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 04:25:45PM +0200, Johannes Schindelin wrote:

> > I think it could make sense for merge-index to be able to directly run
> > the merge-one-file code[1]. But I think we'd want to keep its ability to
> > run an arbitrary script, and for people to call merge-one-file
> > separately, since right now you can do:
> >
> >   git merge-index my-script
> >
> > and have "my-script" do some processing of its own, then hand off more
> > work to merge-one-file.
> 
> Oh, sorry, I did not mean to say that we should do away with this at
> all! Rather, I meant to say that `merge-index` could detect when it was
> asked to run `git-merge-one-file` and re-route to internal code instead
> of spawning a process. If any other script/program was specified, it
> should be spawned off, just like it is done today.

OK, great, then we are completely on the same page. :)

-Peff
