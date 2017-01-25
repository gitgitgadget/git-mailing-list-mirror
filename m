Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BA71F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbdAYSk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:40:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:44618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbdAYSk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:40:28 -0500
Received: (qmail 25152 invoked by uid 109); 25 Jan 2017 18:40:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 18:40:28 +0000
Received: (qmail 14186 invoked by uid 111); 25 Jan 2017 18:40:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 13:40:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 13:40:26 -0500
Date:   Wed, 25 Jan 2017 13:40:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/12] for_each_alternate_ref: use strbuf for path
 allocation
Message-ID: <20170125184026.cm324yefycsrhhin@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004038.njjevfku4v7kmnh4@sigill.intra.peff.net>
 <xmqqvat3at8u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvat3at8u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 10:29:05AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We have a string with ".../objects" pointing to the
> > alternate object store, and overwrite bits of it to look at
> > other paths in the (potential) git repository holding it.
> > This works because the only path we care about is "refs",
> > which is shorter than "objects".
> 
> Yup, this was probably copied from a lazy original I wrote ;-)
> Thanks for cleaning up.

To be fair, the original predates all of the helper functions I used
here. :)

-Peff
