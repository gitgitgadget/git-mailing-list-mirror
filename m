Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D479A202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbdGEVVI (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 17:21:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751784AbdGEVVI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 17:21:08 -0400
Received: (qmail 22225 invoked by uid 109); 5 Jul 2017 21:21:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 21:21:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10502 invoked by uid 111); 5 Jul 2017 21:21:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 17:21:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 17:21:05 -0400
Date:   Wed, 5 Jul 2017 17:21:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 1/6] reflog-walk: skip over double-null oid due to HEAD
 rename
Message-ID: <20170705212105.3qjdzgtut23v6igw@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705075737.6qsotqkzxdxofni6@sigill.intra.peff.net>
 <xmqqo9syiy9g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9syiy9g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05, 2017 at 10:34:03AM -0700, Junio C Hamano wrote:

> > +		if (!logobj)
> > +			logobj = parse_object(&reflog->ooid);
> >  	}
> 
> For the current 'maint', this would need to be backported to the
> uchar[20] interface (which is trivial to do, and merging it upwards
> while adjusting it back to "struct object_id" is also trivial; there
> is no need to resend).
> 
> Thanks.  Will queue.

Ah, right. I should probably actually apply the patches on "maint"
before suggesting you do so. ;)

In theory it should be applied directly on 39ee4c6c2 and then merged up
(but I think the same wiggling would apply either way).

The rest of the patches would need to be adjusted on top, but it should
be easy to resolve; all of that code just goes away.

-Peff
