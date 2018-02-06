Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C06B1F576
	for <e@80x24.org>; Tue,  6 Feb 2018 07:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBFHiP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 02:38:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752125AbeBFHiO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 02:38:14 -0500
Received: (qmail 20170 invoked by uid 109); 6 Feb 2018 07:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Feb 2018 07:38:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15656 invoked by uid 111); 6 Feb 2018 07:38:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Feb 2018 02:38:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2018 02:38:12 -0500
Date:   Tue, 6 Feb 2018 02:38:12 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] Mark messages for translations
Message-ID: <20180206073812.GA14133@sigill.intra.peff.net>
References: <20180115054419.4112-1-ash@kambanaria.org>
 <20180206061537.2573-1-ash@kambanaria.org>
 <20180206061537.2573-2-ash@kambanaria.org>
 <CAPig+cSOgNfz+cYdcvsbbaf74RB0QNnmqLs9Ld9xdmarMaqzEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSOgNfz+cYdcvsbbaf74RB0QNnmqLs9Ld9xdmarMaqzEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 06, 2018 at 02:32:42AM -0500, Eric Sunshine wrote:

> > diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> > @@ -31,7 +31,7 @@ test_expect_success 'bad setup: invalid .git file format' '
> >                 echo "git rev-parse accepted an invalid .git file"
> >                 false
> >         fi &&
> > -       if ! grep "Invalid gitfile format" .err
> > +       if ! grep "invalid gitfile format" .err
> 
> Since these strings can now be translated, you'll probably need to use
> 'test_i18ngrep' rather than 'grep'. (See test_i18ngrep in
> t/test-lib.sh.)

Good catch. Looks like there's another in t1506, which you can see with
"make GETTEXT_POISON=1 test".

-Peff
