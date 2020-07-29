Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28970C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A08207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgG2VCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:02:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:41638 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2VCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:02:18 -0400
Received: (qmail 9214 invoked by uid 109); 29 Jul 2020 21:02:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 21:02:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8943 invoked by uid 111); 29 Jul 2020 21:02:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 17:02:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 17:02:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 4/7] doc/git-log: move "Diff Formatting" from
 rev-list-options
Message-ID: <20200729210217.GB2992025@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
 <20200729201116.GD2989342@coredump.intra.peff.net>
 <xmqq5za69h0k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5za69h0k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 01:56:59PM -0700, Junio C Hamano wrote:

> > So let's move these options over to git-log and put them with the other
> > diff options, giving a single "diff" section for the git-log
> > documentation. We'll call it "Diff Formatting" but use the all-caps
> > top-level header to match its sibling sections. And we'll rewrite the
> > section intro to remove the useless bits and give a more generic
> > overview of the section which can be later extended.
> 
> Makes sense.  I first was afraid of regressing "git show"
> documentation because the conditional inclusion was
> 
>     > -
>     > -ifndef::git-shortlog[]
>     > -ifndef::git-rev-list[]
>     > -Diff Formatting
>     > -~~~~~~~~~~~~~~~
>     > -
> 
> but it seems that Documentation/git-show.txt does not even include
> this section being moved in the first place.
> 
> We might move these to a new file and include it from both git-log.txt
> and git-show.txt but that can be left outside the topioc.

Yeah. As I said earlier, the maze of includes is a bit of a mess. I did
wonder whether git-show might need some mention of merge-handling, too,
but it explicitly mentions that "--cc" is the default, and it contains
the whole "combined diff" section by including diff-generate-patch.txt.

So I think it's OK as-is, though I wouldn't object if anybody wanted to
look at reorganizing all of the diff documentation. :)

-Peff
