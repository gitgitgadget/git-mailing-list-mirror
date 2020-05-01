Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2FAC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A42F20787
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgEAGZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 02:25:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:33330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728126AbgEAGZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 02:25:53 -0400
Received: (qmail 1888 invoked by uid 109); 1 May 2020 06:25:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 06:25:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15584 invoked by uid 111); 1 May 2020 06:25:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 02:25:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 02:25:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: fix quoting bug in credential cache example
Message-ID: <20200501062552.GC25603@coredump.intra.peff.net>
References: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
 <xmqqr1w4sv5t.fsf@gitster.c.googlers.com>
 <20200501055738.GB23665@coredump.intra.peff.net>
 <xmqq368kp457.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq368kp457.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 11:20:52PM -0700, Junio C Hamano wrote:

> >  # or you can specify your own shell snippet
> > -!f() { echo "password=`cat $HOME/.secret`"; }; f
> > +[credential]
> > +helper = "!f() { echo \"password=`cat $HOME/.secret`\"; }; f"
> 
> But I do not think the "tentative shell function" trick is
> necessary.  I personally think it is oversold ;-)  For this
> particular one,
> 
>     [credential]
>         helper = !echo \"password=`cat $HOME/.secret`\"
> 
> should be sufficient, perhaps?  You do not even need to understand
> how shell functions work to understand it.

That will print:

  password=your-password get

See the patches I just sent for a better example. :)

> Also, "git config" indents the "var = value" lines, so it would look
> more natural if we indented our examples in a similar way.

We do earlier, too.

I can re-indent the patches I just set, but I'll hold off on sending in
case you have any other comment.

-Peff
