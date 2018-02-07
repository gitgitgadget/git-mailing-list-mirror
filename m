Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EB01F404
	for <e@80x24.org>; Wed,  7 Feb 2018 14:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754346AbeBGOiK (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 09:38:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:43676 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754335AbeBGOiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 09:38:09 -0500
Received: (qmail 11670 invoked by uid 109); 7 Feb 2018 14:38:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 14:38:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30551 invoked by uid 111); 7 Feb 2018 14:38:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 09:38:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 09:38:07 -0500
Date:   Wed, 7 Feb 2018 09:38:07 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] t5812: add 'test_i18ngrep's missing filename
 parameter
Message-ID: <20180207143807.GA27420@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-3-szeder.dev@gmail.com>
 <20180126182734.GB27618@sigill.intra.peff.net>
 <CAM0VKjkf=51i1YPqdNm=pyPHaNNguXLu0T1iHDYv28jW92QTow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkf=51i1YPqdNm=pyPHaNNguXLu0T1iHDYv28jW92QTow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 02:53:17PM +0100, SZEDER Gábor wrote:

> > The "too old" curl is older than 7.19.4, which we actually fail to build
> > with since v2.12.0. So they probably did not even get as far as the
> > tests. ;)
> 
> Oh, OK, I was not aware of that.  The oldest non-maintenance release
> with the missing filename parameter is v2.7.0, so that's still a 5
> releases time frame to notice it.

Actually, I'm wrong. It looks like we did finally fix it in f18777ba6e
(http: fix handling of missing CURLPROTO_*, 2017-08-11), which is in
v2.15. So:

> Anyway, I'm preparing v2 of this series, and I'm not sure what to do
> about this.
> 
>   - Should I simply drop the "your curl version is too old" pattern?  It
>     would make sense, but it just doesn't feel quite right to remove it
>     while the corresponding printf() is still there, even if it can't be
>     triggered anymore.  However, cleaning up the curl version checks in
>     http.c to remove this message is beyond the scope of this patch
>     series.
> 
>   - Or leave it almost-as-is, only dropping the now unnecessary curly
>     braces as Simon pointed out.  And perhaps a bit of update to the
>     commit message.
> 
> I'd prefer the second option.

Yeah, I think just leave it as-is. Thanks.

-Peff
