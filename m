Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF251F454
	for <e@80x24.org>; Mon, 11 Nov 2019 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKKIWk (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 03:22:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:44288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726785AbfKKIWk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 03:22:40 -0500
Received: (qmail 17782 invoked by uid 109); 11 Nov 2019 08:22:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 08:22:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3876 invoked by uid 111); 11 Nov 2019 08:26:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 03:26:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 03:22:39 -0500
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/8] t3900: demonstrate git-rebase problem with multi
 encoding
Message-ID: <20191111082239.GB17984@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <ca869cef57bcf620a7b5d0519d362dcd9a27eae6.1573094789.git.congdanhqx@gmail.com>
 <20191107060233.GB6431@sigill.intra.peff.net>
 <20191107064854.GB8096@danh.dev>
 <20191107080218.GA11245@sigill.intra.peff.net>
 <20191107105109.GD8096@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107105109.GD8096@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 05:51:09PM +0700, Danh Doan wrote:

> On 2019-11-07 03:02:18 -0500, Jeff King wrote:
> > >                 git config i18n.commitencoding ISO-2022-JP &&
> > >                 echo ISO-2022-JP >>F &&
> > >                 git commit -a -F "$TEST_DIRECTORY/t3900/ISO-2022-JP.txt" &&
> > 
> > ...you still can't just run this manually because of other lines like
> > this one.
> 
> Except we can with a little effort:
> 
>     export TEST_DIRECTORY=..

Sure, but if you allow setting variables, you could do the same for
"$msg", etc. :)

> > It's also weirdly unlike all of the other tests, which creates confusion
> > for people reading the code. IMHO the tradeoff isn't worth it.
> 
> Hm, I think it's the test_commit_autosquash_flag is the one that is weird
> in this file. Most of other sets of tests (line 89-176) use the same quote.

Yeah, you're right. I did look at the other tests to see if it was an
existing style, but of course that was the exact one I looked at. ;)

IMHO it's still a bad style (and is unlike most of the rest of our
tests), but as it's following the existing style in the file, I can live
with it (and we can think about changing it all as a separate step
later).

-Peff
