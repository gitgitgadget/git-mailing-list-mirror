Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7181F4CF
	for <e@80x24.org>; Mon, 21 Nov 2016 23:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932185AbcKUXih (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 18:38:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:45765 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932111AbcKUXig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 18:38:36 -0500
Received: (qmail 9427 invoked by uid 109); 21 Nov 2016 23:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Nov 2016 23:38:31 +0000
Received: (qmail 22495 invoked by uid 111); 21 Nov 2016 23:39:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Nov 2016 18:39:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Nov 2016 18:38:29 -0500
Date:   Mon, 21 Nov 2016 18:38:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: identify problems with core.commentchar
Message-ID: <20161121233828.op3skzgujzcwwllg@sigill.intra.peff.net>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
 <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de>
 <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
 <20161121184931.36nuhg2h7u6mjsld@sigill.intra.peff.net>
 <xmqqtwb0ir4o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwb0ir4o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 11:12:39AM -0800, Junio C Hamano wrote:

> > Yeah, I noticed that while reading the patch. My b9605bc4f2 did regress
> > this case, but called out the fact that "cd subdir && git stripspace"
> > would never have worked. So one step back, 2 steps forward, and Dscho's
> > patch is the right step forward.
> 
> Yes, absolutely.
> 
> I sent out a set of proposed amends, and the one for this step 1/3
> runs the command inside a subdirectory to force it not to find the
> .git/config file relative to its pwd, which can reveal the existing
> breakage without help by b9605bc4f2 ;-) hence can be forked for
> older maintenance tracks.

Makes sense, and your amended patch looks good.

-Peff
