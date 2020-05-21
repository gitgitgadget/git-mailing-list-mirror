Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D71C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB7820748
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgEUA3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 20:29:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:52900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgEUA3H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 20:29:07 -0400
Received: (qmail 10162 invoked by uid 109); 21 May 2020 00:29:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 00:29:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23166 invoked by uid 111); 21 May 2020 00:29:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 May 2020 20:29:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 May 2020 20:29:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
Message-ID: <20200521002906.GA1273723@coredump.intra.peff.net>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
 <20200520220023.GB3648@google.com>
 <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 04:59:29PM -0700, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Speaking of which, should we enable protocol v2 by default for people
> > with feature.experimental enabled, like this?
> 
> It is an excellent idea, but is something that had to have been
> proposed before -rc0 to be in the upcoming release, no?

Yeah, my original email was almost "hey, did we make a conscious
decision to keep v2 reverted after we found the root cause?". But I
think it is too late in the -rc cycle to switch now (which is kind of a
shame, because we won't really get good data on whether the in_vain fix
helped the Linux folks, since it seems clear that most of them are not
switching protocol.version themselves).

The feature.experimental one we could be a bit more cavalier with,
though. I dunno.

(I guess you could argue that since v2.26.2 shipped with protocol v2, we
could already be pretty cavalier with _leaving_ it on in the new
release, but I think as a general principle -rc2 is not the right time
to go flipping defaults).

-Peff
