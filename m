Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1DF20248
	for <e@80x24.org>; Thu, 28 Mar 2019 03:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfC1Ddr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 23:33:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:38554 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727146AbfC1Ddr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 23:33:47 -0400
Received: (qmail 14108 invoked by uid 109); 28 Mar 2019 03:33:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Mar 2019 03:33:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2541 invoked by uid 111); 28 Mar 2019 03:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Mar 2019 23:34:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2019 23:33:45 -0400
Date:   Wed, 27 Mar 2019 23:33:45 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190328033345.GA18544@sigill.intra.peff.net>
References: <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
 <20190328025434.GA10032@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328025434.GA10032@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 10:54:34PM -0400, Jeff King wrote:

> @@ -112,6 +118,13 @@ construct_makemanflags () {
>  	elif test "$1" = "-asciidoctor"
>  	then
>  		echo USE_ASCIIDOCTOR=YesPlease
> +	elif test "$1" = "-asciidoctor2"
> +	then
> +		echo USE_ASCIIDOCTOR=YesPlease
> +		echo ASCIIDOC_DOCBOOK=docbook5
> +		echo XMLTO_EXTRA=--skip-validation
> +		# not really portable :)
> +		echo ASCIIDOCTOR=/tmp/run-asciidoctor-2
>  	fi

Oops, this last line should be ASCIIDOC=..., of course. Which meant that
I was actually just testing the docbook5 output from v1.5.8. The results
with v2.0.2 seem similar, though.

-Peff
