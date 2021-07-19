Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42600C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E826100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhGSIVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:21:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:53410 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234973AbhGSIVF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 04:21:05 -0400
Received: (qmail 30636 invoked by uid 109); 19 Jul 2021 08:35:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jul 2021 08:35:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10978 invoked by uid 111); 19 Jul 2021 08:35:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jul 2021 04:35:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 19 Jul 2021 04:35:03 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YPU5NyoDrQquWOYo@coredump.intra.peff.net>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <60f52f7a52671_1e0a42083b@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60f52f7a52671_1e0a42083b@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 02:53:30AM -0500, Felipe Contreras wrote:

> Patrick Steinhardt wrote:
> > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> > [snip]
> > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > > 
> > >  Test update.
> > > 
> > >  What's the status of this one?
> > 
> > From my point of view this is ready, but it's still missing reviews so
> > far. The lack of interest seems to indicate that nobody has hit the
> > issue so far, and I wonder why that is. Am I the only one who sets
> > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> > tests?
> 
> No, I do the same, and this other fix for TEST_OUTPUT_DIRECTORY is being
> ignored even harder:
> 
> https://lore.kernel.org/git/20210707030709.3134859-1-felipe.contreras@gmail.com/

Note that the linked patch will break Patrick's, because we would no
longer set TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS.

-Peff
