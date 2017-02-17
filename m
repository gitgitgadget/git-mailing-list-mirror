Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3182201B0
	for <e@80x24.org>; Fri, 17 Feb 2017 23:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964918AbdBQXqu (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:46:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:57669 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964862AbdBQXqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:46:50 -0500
Received: (qmail 32257 invoked by uid 109); 17 Feb 2017 23:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 23:46:49 +0000
Received: (qmail 8938 invoked by uid 111); 17 Feb 2017 23:46:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 18:46:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 18:46:47 -0500
Date:   Fri, 17 Feb 2017 18:46:47 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 6/6] stash: allow pathspecs in the no verb form
Message-ID: <20170217234647.bqhzzm533oruhr5e@sigill.intra.peff.net>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170217224141.19183-7-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217224141.19183-7-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 10:41:41PM +0000, Thomas Gummerer wrote:

> Now that stash_push is used in the no verb form of stash, allow
> specifying the command line for this form as well.  Always use -- to
> disambiguate pathspecs from other non-option arguments.

I think that makes sense.

> Also make git stash -p an alias for git stash push -p.  This allows
> users to use git stash -p <pathspec>.

And I think of all the options we discussed for handling "-p", I think
this one makes the most sense.

It may be worth calling out in the documentation that this is how it
works though, so people do not think that:

  git stash -k -p <path>

would work ("git stash -k -p" _does_ happen to work due to the old
options-only rule, but I think we should advertise the general form as
"-p is an alias for "push -p").

-Peff
