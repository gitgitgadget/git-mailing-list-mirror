Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6D01F453
	for <e@80x24.org>; Wed, 13 Feb 2019 06:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfBMGtI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 01:49:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:42482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726411AbfBMGtI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 01:49:08 -0500
Received: (qmail 4711 invoked by uid 109); 13 Feb 2019 06:49:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Feb 2019 06:49:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31256 invoked by uid 111); 13 Feb 2019 06:49:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 01:49:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 01:49:06 -0500
Date:   Wed, 13 Feb 2019 01:49:06 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] tests: define GIT_TEST_SIDEBAND_ALL
Message-ID: <20190213064906.GA29560@sigill.intra.peff.net>
References: <cover.1547244620.git.jonathantanmy@google.com>
 <cover.1547666330.git.jonathantanmy@google.com>
 <47a98b67113869aa6a887ced52560c8306e55bc0.1547666330.git.jonathantanmy@google.com>
 <20190129232732.GB218214@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129232732.GB218214@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 03:27:32PM -0800, Jonathan Nieder wrote:

> Jonathan Tan wrote:
> 
> > --- a/t/lib-httpd/apache.conf
> > +++ b/t/lib-httpd/apache.conf
> > @@ -78,6 +78,7 @@ PassEnv GNUPGHOME
> >  PassEnv ASAN_OPTIONS
> >  PassEnv GIT_TRACE
> >  PassEnv GIT_CONFIG_NOSYSTEM
> > +PassEnv GIT_TEST_SIDEBAND_ALL
> 
> This is producing
> 
>  [env:warn] [pid 248632] AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined
> 
> when tests are run with "prove".
> 
> Should we set the envvar unconditionally in lib-httpd.sh?

Yes, that's the same solution we've had to use for GIT_VALGRIND, etc. I
don't think there's an easier way.

-Peff
