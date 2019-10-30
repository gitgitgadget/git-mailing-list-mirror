Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50581F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJ3Uif (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:38:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:34280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726527AbfJ3Uie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:38:34 -0400
Received: (qmail 29018 invoked by uid 109); 30 Oct 2019 20:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Oct 2019 20:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23711 invoked by uid 111); 30 Oct 2019 20:41:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Oct 2019 16:41:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Oct 2019 16:38:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
Cc:     Simon Holmberg <simon.holmberg@avalanchestudios.se>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Partial Clone garbage collection?
Message-ID: <20191030203833.GD29013@sigill.intra.peff.net>
References: <CA+M_GG35V3yNCfQ247PSrpP-R_f8bWNcBcmrnTWbrn1Nap_A4A@mail.gmail.com>
 <CA+M_GG1SfxGW=p_=418hdR1ypB3v-4GrooK6_75UUNJDb+kk2Q@mail.gmail.com>
 <43646191572459422@myt3-4825096bdc88.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43646191572459422@myt3-4825096bdc88.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 09:17:02PM +0300, без имени wrote:

> > Are there any plans to add a --filter parameter to git gc as well,
> > that would be able to prune past history of objects and convert them
> > back into pack promises?
> 
> This operation will change the hash, and hence the history. I tried to
> draw attention to a specific trick:

I don't think this is quite the same thing. Simon is just talking about
the partial-clone system.  The files are still mentioned in history, but
the client does not store the matching blobs themselves. Instead, it can
fetch them on-demand from a remote repository.

-Peff
