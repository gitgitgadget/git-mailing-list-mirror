Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA39AC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 07:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC01214D8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 07:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfLMHrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:47:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:45682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725468AbfLMHrA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 02:47:00 -0500
Received: (qmail 28828 invoked by uid 109); 13 Dec 2019 07:46:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Dec 2019 07:46:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22083 invoked by uid 111); 13 Dec 2019 07:51:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 02:51:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 02:46:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Ruud van Asseldonk <dev@veniogames.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
Message-ID: <20191213074659.GA95694@coredump.intra.peff.net>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
 <20191127112150.GA22221@sigill.intra.peff.net>
 <20191128013111.GA76989@google.com>
 <xmqqblsrz1uk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblsrz1uk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 01, 2019 at 10:19:15PM -0800, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >   Not-Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> >
> > --- the patch shouldn't be applied as is.
> > ...
> > Agreed: if we want to follow this approach, we should install stubs in
> > place of those scripts when NO_PERL=YesPlease.  Will say more about
> > this in a separate reply.
> 
> I am just leaving a note here in the thread to make sure I notice if
> there is any progress/conclusion, until which time I'll keep the
> patch on hold.  Thanks.

Thinking on this more, it might not be a bad idea to take Ruud's initial
patch here. It certainly makes things better for his NO_PERL case now,
and then in the future we can either:

 - stop building request-pull entirely with NO_PERL, but we'd still need
   the tests to realize that we shouldn't be testing it

 - change request-pull to not require perl, at which point we'd remove
   this restriction

-Peff
