Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29E720756
	for <e@80x24.org>; Tue, 17 Jan 2017 15:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdAQPo5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 10:44:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:40221 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdAQPo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 10:44:57 -0500
Received: (qmail 5689 invoked by uid 109); 17 Jan 2017 15:38:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:38:10 +0000
Received: (qmail 18249 invoked by uid 111); 17 Jan 2017 15:39:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 10:39:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 10:38:08 -0500
Date:   Tue, 17 Jan 2017 10:38:08 -0500
From:   Jeff King <peff@peff.net>
To:     jean-christophe manciot <actionmystique@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: fatal: bad revision 'git rm -r --ignore-unmatch -- folder'
Message-ID: <20170117153807.g4dlv5glfnvc3zc6@sigill.intra.peff.net>
References: <CAKcFC3aqjLNUNKPDZ08rO_SBkY84uvHBerCxnSchAe8rH0dnMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKcFC3aqjLNUNKPDZ08rO_SBkY84uvHBerCxnSchAe8rH0dnMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 04:30:48PM +0100, jean-christophe manciot wrote:

> I'm trying to purge a complete folder and its files from the
> repository history with:
> 
> git-Games# git filter-branch 'git rm -r --ignore-unmatch --
> Ubuntu/16.04/' --tag-name-filter cat -- --all HEAD
> fatal: bad revision 'git rm -r --ignore-unmatch -- Ubuntu/16.04/'

Did you forget "--tree-filter" or "--index-filter" before the "git rm"
parameter? Without an option it will be interpreted as a refname, which
it obviously isn't.

-Peff
