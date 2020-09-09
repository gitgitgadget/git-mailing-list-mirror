Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B8C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD4121D79
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgIIJIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:08:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:51858 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIJIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:08:44 -0400
Received: (qmail 3349 invoked by uid 109); 9 Sep 2020 09:08:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2020 09:08:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32105 invoked by uid 111); 9 Sep 2020 09:08:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2020 05:08:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Sep 2020 05:08:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Beat Bolli <dev+git@drbeat.li>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] pretty: allow to override the built-in formats
Message-ID: <20200909090842.GA2496536@coredump.intra.peff.net>
References: <20200905192406.74411-1-dev+git@drbeat.li>
 <20200905195218.GA892287@generichostname>
 <xmqqeene36t7.fsf@gitster.c.googlers.com>
 <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li>
 <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
 <20200908135303.GA2448968@coredump.intra.peff.net>
 <xmqqzh60xhms.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh60xhms.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 11:12:11AM -0700, Junio C Hamano wrote:

> > Here's a slightly different proposal. I'm not sure if I like it or not,
> > but just thinking out loud for a moment. The issue is that we're worried
> > the consumer of the output may be surprised by a user-configured pretty
> > format. Can we give them a way to say "I don't care about the exact
> > output; pick what the user configured for this name, or some sane
> > default". I.e., something like:
> >
> >   git log --format=loose:reference
> 
> Yeah, that, or with s/loose/user/ or something.

Heh, I actually called it "user:" initially but wasn't sure if that was
sufficiently descriptive, so I groped around for another word. But if
both of us thought of "user", maybe it's better.

At any rate, this was mostly just thinking out loud, and isn't something
I'm planning to follow up on with a patch. But maybe it inspires
somebody to run with it.

-Peff
