Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD273C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAE020578
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHQVkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:40:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:33646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHQVkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:40:42 -0400
Received: (qmail 6816 invoked by uid 109); 17 Aug 2020 21:40:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:40:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22602 invoked by uid 111); 17 Aug 2020 21:40:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:40:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:40:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200817214041.GA1854983@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
 <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
 <20200815063811.GA628010@coredump.intra.peff.net>
 <xmqqv9hh2oq9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9hh2oq9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 09:58:54AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Where do we want to go with this? After the discussion and sleeping on
> > it, I'm still of the mind that we should generally default things to
> > being builtins unless there's an immediate need not to do so (like
> > extra link dependencies). But I don't care _too_ much, so I'd rather
> > eject this patch and move forward with the rest of the series if it's a
> > sticking point. Thoughts?
> 
> I already said what needs to be said.

I guess my question was really: after the discussion do you think I'm
being an idiot, to the point that you do not want to pick up the series?

It sounds like the answer is no, and...

> I do not care too deeply what we do now today either way, as long as
> people remember that we are interested in the version string, build
> options and external library versions of the "git" binary (for
> built-ins) and non-built-in binaries (like the remote helpers), and
> not as much interested in these traits of the "git-bugreport" binary
> itself, when we need to split "bugreport" out of builtins in the
> future.

Yes, I agree that future changes to bugreport may need to keep that in
mind (but my guess is that it won't even ever come up).

-Peff
