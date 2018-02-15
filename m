Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5246F1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeBOFpp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:45:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:53386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751074AbeBOFpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:45:44 -0500
Received: (qmail 2064 invoked by uid 109); 15 Feb 2018 05:45:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:45:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7300 invoked by uid 111); 15 Feb 2018 05:46:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:46:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:45:42 -0500
Date:   Thu, 15 Feb 2018 00:45:42 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 13/23] ref-filter: get rid of
 mark_atom_in_object_info()
Message-ID: <20180215054542.GK18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4353-44cc5f60-0e42-492a-9d7f-0f6f1c7b3501-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f4353-44cc5f60-0e42-492a-9d7f-0f6f1c7b3501-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Remove mark_atom_in_object_info() and create same logic
> in terms of ref-filter style.

This one is definitely a step in the right direction. In fact, this is
what I would have expected to see in the beginning. It seems like this
first half of the series really would benefit from being squashed into a
few commits. I.e., I'd have expected to see the whole series looking
something like:

  - preparatory cleanup of ref-filter

  - teach ref-filter any new atoms (or atom options) that cat-file knows
    about but it doesn't

  - convert cat-file to use ref-filter

Most of what I've seen so far is basically that second step, but strung
out along a bunch of commits. Can we compact it into a few commits that
all make clear forward progress (by using "rebase -i" with "squash")?

-Peff
