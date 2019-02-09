Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957501F453
	for <e@80x24.org>; Sat,  9 Feb 2019 04:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfBIEY6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 23:24:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:38382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726524AbfBIEY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 23:24:58 -0500
Received: (qmail 17442 invoked by uid 109); 9 Feb 2019 04:24:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Feb 2019 04:24:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29462 invoked by uid 111); 9 Feb 2019 04:25:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 23:25:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 23:24:56 -0500
Date:   Fri, 8 Feb 2019 23:24:56 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190209042456.GB18286@sigill.intra.peff.net>
References: <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
 <20190208180321.GB27673@sigill.intra.peff.net>
 <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
 <20190208193157.GA30952@sigill.intra.peff.net>
 <20190208220714.GG11927@genre.crustytoothpaste.net>
 <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com>
 <20190208223512.GA2135@sigill.intra.peff.net>
 <006601d4c001$2de3a160$89aae420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <006601d4c001$2de3a160$89aae420$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 05:53:53PM -0500, Randall S. Becker wrote:

> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh index
> > 92cf8f812c..4afab14431 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -1302,3 +1302,8 @@ test_set_port () {
> >  	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
> >  	eval $var=$port
> >  }
> > +
> > +# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
> > +gen_zero_bytes () {
> > +	perl -e 'print "\0" x $ARGV[0]' "$@"
> > +}
> 
> This function does work on platform, so it's good.

Great. Since it sounds like you're preparing some patches to deal with
/dev/zero elsewhere, do you want to wrap it up in a patch as part of
that?

-Peff
