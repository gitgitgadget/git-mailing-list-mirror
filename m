Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E24220A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 01:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLGBDN (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 20:03:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:33616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725939AbeLGBDN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 20:03:13 -0500
Received: (qmail 11541 invoked by uid 109); 7 Dec 2018 01:03:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Dec 2018 01:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15423 invoked by uid 111); 7 Dec 2018 01:02:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Dec 2018 20:02:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2018 20:03:11 -0500
Date:   Thu, 6 Dec 2018 20:03:11 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181207010310.GA21992@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
 <20181205103454.GJ30222@szeder.dev>
 <20181205213625.GD19936@sigill.intra.peff.net>
 <20181206225601.GO30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181206225601.GO30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 11:56:01PM +0100, SZEDER Gábor wrote:

> > +test_expect_success 'roll those dice' '
> > +	case "$(openssl rand -base64 1)" in
> > +	z*)
> > +		return 1
> > +	esac
> > +'
> 
> Wasteful :)
> 
>   test $(($$ % 42)) -ne 0

Oh, indeed, that is much more clever. :)

-Peff
