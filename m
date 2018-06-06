Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8B91F517
	for <e@80x24.org>; Wed,  6 Jun 2018 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeFFU6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:58:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:36826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752030AbeFFU6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:58:48 -0400
Received: (qmail 32130 invoked by uid 109); 6 Jun 2018 20:58:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Jun 2018 20:58:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9399 invoked by uid 111); 6 Jun 2018 20:59:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Jun 2018 16:59:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2018 16:58:46 -0400
Date:   Wed, 6 Jun 2018 16:58:46 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
Message-ID: <20180606205845.GB1381@sigill.intra.peff.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net>
 <20180606061927.GA7098@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606061927.GA7098@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 06, 2018 at 08:19:27AM +0200, Torsten Bögershausen wrote:

> > +test_translate_f_ () {
> > +	local file="$TEST_DIRECTORY/translate/$2" &&
> 
> Unless I'm wrong, we don't use the "local" keyword ?

We've got a test balloon out; see 01d3a526ad (t0000: check whether the
shell supports the "local" keyword, 2017-10-26). I think it's reasonable
to consider starting its use.

> > +	perl -e '
> 
> The bare "perl" is better spelled as "$PERL_PATH"

This use is OK. Since a0e0ec9f7d (t: provide a perl() function which
uses $PERL_PATH, 2013-10-28), most common uses handle this automatically
(there are some exceptions, covered in t/README).

> > +	if [ "$1" = "-f" ]
> 
> Style nit, please avoid [] and use test:
> 	if test "$1" = "-f"

This I agree with. :)

-Peff
