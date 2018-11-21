Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0EB1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeKVAzE (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:55:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:47406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729295AbeKVAzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:55:04 -0500
Received: (qmail 21230 invoked by uid 109); 21 Nov 2018 14:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Nov 2018 14:20:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9843 invoked by uid 111); 21 Nov 2018 14:19:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Nov 2018 09:19:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2018 09:20:26 -0500
Date:   Wed, 21 Nov 2018 09:20:26 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com, git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.20.0-rc0, was Re: [ANNOUNCE] Git v2.20.0-rc0
Message-ID: <20181121142026.GA10324@sigill.intra.peff.net>
References: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
 <CAGyf7-FALWBEfcu4OOsrQEKZJ=ub0=exM_f-Y7=avPqiwOeH7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-FALWBEfcu4OOsrQEKZJ=ub0=exM_f-Y7=avPqiwOeH7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 03:17:07PM -0800, Bryan Turner wrote:

> I've run 2.20.0-rc0 through the test matrix for Bitbucket Server on
> both Linux and Windows, and the only failures were related to this
> change:
> 
> * "git branch -l <foo>" used to be a way to ask a reflog to be
>    created while creating a new branch, but that is no longer the
>    case.  It is a short-hand for "git branch --list <foo>" now.
> 
> Since this is an intentional change I suspect there's nothing to do
> for it but patch Bitbucket Server and move on, but I'll confess it's a
> little frustrating that the option was deprecated in 2.19 and then
> immediately removed in the next minor release. Such a
> backwards-incompatible change seems far more apt for a major release,
> a perspective that's reinforced by having the change follow such a
> brief deprecation period--2.19.0 was only tagged September 10th (in my
> timezone), so it's been less than 3 months. (Looking at the git branch
> documentation for 2.18.0 [1] shows nothing about this deprecation; the
> messaging first appears in 2.19.0 [2]. To be honest, I didn't even
> realize it was deprecated until now, when it's gone--our test suite is
> automated, so the deprecation warning was not visible.)

We did go a bit faster than usual, under the assumption that nobody's
really using "-l". It has been the default since 2006.

Can you tell us a little more about your invocation?

We still have time to avoid the change for this release. And this early
testing of master and release candidates is wonderful exactly to get
this kind of feedback before it's too late.

-Peff
