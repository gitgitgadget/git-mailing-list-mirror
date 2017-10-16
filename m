Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A75202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbdJPViX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 17:38:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:54506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755069AbdJPViW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 17:38:22 -0400
Received: (qmail 9014 invoked by uid 109); 16 Oct 2017 21:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 21:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16888 invoked by uid 111); 16 Oct 2017 21:38:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 17:38:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 17:38:20 -0400
Date:   Mon, 16 Oct 2017 17:38:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] branch: forbid refs/heads/HEAD
Message-ID: <20171016213819.jgx5tihszqngvti2@sigill.intra.peff.net>
References: <20171013051132.3973-1-gitster@pobox.com>
 <20171013051132.3973-4-gitster@pobox.com>
 <20171013131501.3qarwhanktfvgjqd@sigill.intra.peff.net>
 <xmqqefq6v5qj.fsf@gitster.mtv.corp.google.com>
 <xmqqa80uv5b8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa80uv5b8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 14, 2017 at 11:20:11AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Should we test that:
> >>
> >>   git update-ref refs/heads/HEAD HEAD^
> >>
> >> continues to work?
> >
> > Perhaps.  Also we may want to make sure that "git branch -D HEAD"
> > still works as a way to recover from historical mistakes.
> 
> The only difference is improved tests where we use show-ref to make
> sure refs/heads/HEAD does not exist when it shouldn't, exercise
> update-ref to create and delete refs/heads/HEAD, and also make sure
> it can be deleted with "git branch -d".

Thanks, this looks good to me.

-Peff
