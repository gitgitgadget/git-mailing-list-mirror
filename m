Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391E5C6FA82
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 18:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiIBSfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIBSe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E211C30
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 11:34:53 -0700 (PDT)
Received: (qmail 1394 invoked by uid 109); 2 Sep 2022 18:34:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Sep 2022 18:34:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31480 invoked by uid 111); 2 Sep 2022 18:34:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Sep 2022 14:34:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Sep 2022 14:34:52 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: several messages
Message-ID: <YxJMzMyjGCyp/b4w@coredump.intra.peff.net>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <f5dbcbf78db127d738c11a1aca416201298426cf.1661992197.git.gitgitgadget@gmail.com>
 <9on60586-rr40-onn0-907s-53816r61qn07@tzk.qr>
 <CAPig+cRCME=SYyV2bDNoAJjdnHUAWUqSP00aO_v-KWdNvasKpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRCME=SYyV2bDNoAJjdnHUAWUqSP00aO_v-KWdNvasKpA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2022 at 02:16:21PM -0400, Eric Sunshine wrote:

> > It would be one thing if we could use a well-maintained third-party tool
> > to do this job. But adding this to our plate? I hope we can avoid that.
> 
> I understand your concerns about review and maintenance burden, and
> you're not the first to make such observations; when chainlint.sed was
> submitted, it was greeted with similar concerns[1,2], all very
> understandable. The key takeaway[3] from that conversation, though,
> was that, unlike user-facing features which must be reviewed in detail
> and maintained in perpetuity, this is a mere developer aid which can
> be easily ejected from the project if it ever becomes a maintenance
> burden or shows itself to be unreliable. Potential maintenance burden
> aside, a very real benefit of such a tool is that it should help
> prevent bugs from slipping into the project going forward[4], which is
> indeed the aim of all our developer-focused aids.

Thanks for this response and especially the links. My initial gut
response was similar to Dscho's. Which is not surprising, because it
apparently was also my initial response to chainlint.sed back then. ;)

But I do think that chainlint.sed has proven itself to be both useful
and not much of a maintenance burden. My only real complaint was the
additional runtime in a few corner cases, and that is exactly what
you're addressing here.

I'm not excited about carefully reviewing it. At the same time, given
the low stakes, I'm kind of willing to accept that between the tests and
the results of running it on the current code base, the proof is in the
pudding.

-Peff
