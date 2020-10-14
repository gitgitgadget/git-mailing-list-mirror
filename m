Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6C5C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866CD2222C
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJNRzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:55:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:59984 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgJNRzN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:55:13 -0400
Received: (qmail 18154 invoked by uid 109); 14 Oct 2020 17:55:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 17:55:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19137 invoked by uid 111); 14 Oct 2020 17:55:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 13:55:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 13:55:12 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/3] test-lib: reduce verbosity of skipped tests
Message-ID: <20201014175512.GA24279@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <85a4ca164a9f665016d4aad0f29cbef6f62f36b0.1602616786.git.gitgitgadget@gmail.com>
 <20201014165329.GA21687@coredump.intra.peff.net>
 <CABPp-BERKaLTLFjXYSo2mbT+3RSMR+5M7pzPmHH-0hNP2KFMOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BERKaLTLFjXYSo2mbT+3RSMR+5M7pzPmHH-0hNP2KFMOA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 10:39:01AM -0700, Elijah Newren wrote:

> On Wed, Oct 14, 2020 at 9:53 AM Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Oct 13, 2020 at 07:19:46PM +0000, Elijah Newren via GitGitGadget wrote:
> >
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > When using the --run flag to run just two or three tests from a test
> > > file which contains several dozen tests, having every skipped test print
> > > out dozens of lines of output for the test code for that skipped test
> > > adds up to hundreds or thousands of lines of irrelevant output that make
> > > it very hard to fish out the relevant results you were looking for.
> > > Simplify the output for skipped tests down to just showing the one-line
> > > descriptions.
> >
> > This last sentence is inaccurate in this version, isn't it?
> 
> Maybe I could make it clearer, but I think that it is accurate[1].  If
> this wording seems confusing, though, I could simplify the commit
> message by reducing the sentence to "Simplify the output for skipped
> tests."

Yeah, I wondered if you might have been thinking that. It makes sense in
the context of the other discussion, but the single-line TAP output is
not even mentioned here. And it might be worth doing so, because the
real reason it is OK to delete this line entirely is that it is
redundant with that line.

-Peff
