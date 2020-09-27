Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC801C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7E623998
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 07:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgI0H73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 03:59:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:42300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgI0H73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 03:59:29 -0400
Received: (qmail 28549 invoked by uid 109); 27 Sep 2020 07:59:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 07:59:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3759 invoked by uid 111); 27 Sep 2020 07:59:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 03:59:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 03:59:27 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/8] shortlog: refactor committer/author grouping
Message-ID: <20200927075927.GA1286220@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
 <20200925070211.GB62741@coredump.intra.peff.net>
 <CAN0heSoS837ZCLt8WLRBrthXgOErwz-vXW8Af9v2ZdCcCpWRiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoS837ZCLt8WLRBrthXgOErwz-vXW8Af9v2ZdCcCpWRiw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 26, 2020 at 02:31:32PM +0200, Martin Ågren wrote:

> On Fri, 25 Sep 2020 at 09:04, Jeff King <peff@peff.net> wrote:
> >
> > In preparation for adding more grouping types, let's
> > refactor the committer/author grouping code. In particular:
> >
> >   - the master option is now "--group", to make it clear
> >     that the various group types are mutually exclusive. The
> >     "--committer" option is an alias for "--group=committer".
> 
> I think this is more than a refactoring of the code. The user interface
> is also refactored (if that's even the right word). From the subject and
> the first sentence above, I did not expect this first "-" item, nor that
> the patch would touch Documentation/.

Yeah, I agree it's a bit misleading. I've reworded it (especially the
title) to make the intent more clear.

> > +       enum {
> > +               SHORTLOG_GROUP_AUTHOR = 0,
> > +               SHORTLOG_GROUP_COMMITTER
> > +       } group;
> 
> You could reduce the patch noise by adding a trailing comma, see
> cc0c42975a ("CodingGuidelines: spell out post-C89 rules", 2019-07-16).
> (I do realize that you later redefine all values anyway.)

Thanks, that's worth doing. This part of the series was actually from
2015, so perhaps before we had that guideline. :)

-Peff
