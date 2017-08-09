Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241F51F991
	for <e@80x24.org>; Wed,  9 Aug 2017 13:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbdHINir (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 09:38:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:33274 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752409AbdHINir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 09:38:47 -0400
Received: (qmail 6807 invoked by uid 109); 9 Aug 2017 13:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 13:38:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27239 invoked by uid 111); 9 Aug 2017 13:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 09:39:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 09:38:44 -0400
Date:   Wed, 9 Aug 2017 09:38:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] http: drop support for curl < 7.19.4
Message-ID: <20170809133844.3h7plxm6nzoheckv@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
 <871sokhoi9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sokhoi9.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 03:14:22PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This whole series looks good to me. As I commented on in the thread you
> referenced in 0/4 I think this is the right trade-off, and people like
> me who occasionally compile git on older systems can just easily package
> a newer curl as well if we need it.
> 
> My reading of the curl history/docs is that you should squash this into
> this last patch. It's code that's now dead since we require
> 7.19.4.
> 
> CURLAUTH_DIGEST_IE was added in 7.19.3, and as a comment this squash
> removes indicates CURLOPT_USE_SSL hasn't been needed since 7.16.4:
> https://curl.haxx.se/libcurl/c/CURLOPT_USE_SSL.html

Thanks. Do you mind formatting this as a patch on top instead of a
squash? I think it's sufficiently subtle that it should be separate from
the main cleanup, which is just dropping our own internal #ifdefs.

I guess that would make reverting harder, though.

-Peff
