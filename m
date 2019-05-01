Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA011F453
	for <e@80x24.org>; Wed,  1 May 2019 18:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEASrA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:47:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:46140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726004AbfEASrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:47:00 -0400
Received: (qmail 23703 invoked by uid 109); 1 May 2019 18:47:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:47:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21158 invoked by uid 111); 1 May 2019 18:47:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:47:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:46:58 -0400
Date:   Wed, 1 May 2019 14:46:58 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 19/20] diff --no-index: use parse_options() instead of
 diff_opt_parse()
Message-ID: <20190501184658.GH4109@sigill.intra.peff.net>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
 <20190324082014.2041-20-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1904292055300.45@tvgsbejvaqbjf.bet>
 <CACsJy8CUNVWqWff05Lg2xjnOj3L2T7RvVbZh+RZPjvFokvT_-A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904301811110.45@tvgsbejvaqbjf.bet>
 <CACsJy8AGf81=_BTd6+idnBcHPB2AAj=dciJn6r_rCB8TJ1hvug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AGf81=_BTd6+idnBcHPB2AAj=dciJn6r_rCB8TJ1hvug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 04:53:44PM +0700, Duy Nguyen wrote:

> > > > I just noticed that this commit message is missing more than just a
> > > > trailing period. It does not explain the change of behavior: previously,
> > > > `GIT_EXTERNAL_DIFF=heya git diff --no-index a b` would silently ignore the
> > > > external diff, it would have required an explicit `--ext-diff` to pick it
> > > > up.
> [...]
> Bisecting points to 287ab28bfa (diff: reuse diff setup for --no-index
> case, 2019-02-16). From the description (i.e. "miss out some settings
> like --ext-diff...") the behavior change seems delibrate. Adding Jeff
> for clarification/

Yeah, that was the purpose of that change: whether in no-index mode or
not, git-diff should behave consistently.

-Peff
