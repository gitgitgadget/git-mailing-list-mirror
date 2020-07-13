Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB6C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01452067D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgGMUuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:50:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:56536 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgGMUuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:50:40 -0400
Received: (qmail 1220 invoked by uid 109); 13 Jul 2020 20:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jul 2020 20:50:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26934 invoked by uid 111); 13 Jul 2020 20:50:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jul 2020 16:50:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Jul 2020 16:50:39 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200713205039.GA2356680@coredump.intra.peff.net>
References: <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
 <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
 <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
 <20200713200049.6a22nek4xckwtpt6@chatter.i7.local>
 <xmqqtuybmba1.fsf@gitster.c.googlers.com>
 <20200713202211.GA2355588@coredump.intra.peff.net>
 <20200713203427.apajagayqx4gpadf@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713203427.apajagayqx4gpadf@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 04:34:27PM -0400, Konstantin Ryabitsev wrote:

> I think adding all this logic is not worth the effort. For vast numbers 
> of people who aren't running Android mirrors, FETCH_HEAD is only going 
> to be a few KB in size, so they won't benefit from this change at all.
> 
> I'm happy with just an option that I have to enable to turn off writing 
> FETCH_HEAD.

Yeah, I'm totally fine with that, too. And because it's an incremental
set of steps (add the option, then possibly flip the default), we can
easily stop at step 1 and see if anybody cares enough about step 2 to
continue.

-Peff
