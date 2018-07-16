Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5511F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeGPWxX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:53:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:48726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728622AbeGPWxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:53:23 -0400
Received: (qmail 19466 invoked by uid 109); 16 Jul 2018 22:23:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 22:23:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16467 invoked by uid 111); 16 Jul 2018 22:24:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 18:24:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 18:23:54 -0400
Date:   Mon, 16 Jul 2018 18:23:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per
 gpg format program
Message-ID: <20180716222354.GA12482@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
 <20180710165412.GE23624@sigill.intra.peff.net>
 <20180710165638.GF23624@sigill.intra.peff.net>
 <20180714181347.GE1042117@genre.crustytoothpaste.net>
 <20180716213510.GJ25189@sigill.intra.peff.net>
 <xmqq36wisv3h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36wisv3h.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 02:56:34PM -0700, Junio C Hamano wrote:

> >> I'm okay with us forcing "openpgp".  That seems sane enough for now, and
> >> if people scream loudly, we can loosen it.
> >
> > Well, I specifically meant "are you sure subsections like this are a
> > good idea". But it seems like people think so?
> 
> I admit that I did not even consider that there may be better tool
> than using subsections to record this information.  What are the
> possibilities you have in mind (if you have one)?

I don't think there is another tool except two-level options, like
"gpg.openpgpprogram" and "gpg.x509program".

Although those are a bit ugly, I just wondered if they might make things
simpler, since AFAIK we are not planning to add more config options
here. Like gpg.x509.someotherflag, nor gpg.someothertool.program.

Of course one reason _for_ the tri-level is that we might one day add
gpg.x509.someotherflag, and this gives us room to do it with less
awkwardness (i.e., a proliferation of gpg.x509someflag options).

-Peff
