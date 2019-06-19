Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1FB1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfFSVaf (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:30:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:44782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726230AbfFSVaf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:30:35 -0400
Received: (qmail 12894 invoked by uid 109); 19 Jun 2019 21:27:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 21:27:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10077 invoked by uid 111); 19 Jun 2019 21:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 17:31:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 17:30:33 -0400
Date:   Wed, 19 Jun 2019 17:30:33 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] rev-list: teach --no-object-names to enable piping
Message-ID: <20190619213033.GC6571@sigill.intra.peff.net>
References: <20190618222917.261701-1-emilyshaffer@google.com>
 <xmqq1rzpsm5t.fsf@gitster-ct.c.googlers.com>
 <20190619193134.GF100487@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619193134.GF100487@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 12:31:34PM -0700, Emily Shaffer wrote:

> > I noticed in range-diff, too.  So now --object-names can be used
> > with --pretty (not that "rev-list --pretty --objects" makes much
> > sense in the first place, so no point in testing that it works).
> 
> Yeah, it works. It looks weird, but it works pretty much as you'd
> expect:

I think that something like:

  git rev-list --in-commit-order --oneline --objects HEAD

could make sense to get a rough idea of which commits are mentioning
which objects (though in most cases I'd probably use "log --find-object"
these days, since it's more precise; rev-list is looking in a funny
reverse order).

-Peff
