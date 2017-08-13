Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB38208B8
	for <e@80x24.org>; Sun, 13 Aug 2017 04:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbdHMEls (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 00:41:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:37290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750768AbdHMElr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 00:41:47 -0400
Received: (qmail 11371 invoked by uid 109); 13 Aug 2017 04:41:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 04:41:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28404 invoked by uid 111); 13 Aug 2017 04:42:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 00:42:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Aug 2017 00:41:45 -0400
Date:   Sun, 13 Aug 2017 00:41:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170813044145.xz4o47oog3z5eycg@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
 <87y3qsg7ni.fsf@gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
 <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
 <20170811175237.GC59325@google.com>
 <20170811211845.tpgmafenhahus77o@sigill.intra.peff.net>
 <xmqq378xxuvk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq378xxuvk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 09:39:11PM -0700, Junio C Hamano wrote:

> > Yeah, I just dug in the archive. The script I ran way back when was
> > actually clang-format-diff.
> 
> I am confident with the competence of people around here that we can
> come up with a reasonable checker for obvious style violations. In
> the worst case, we could customize and/or tweak checkpatch.pl and
> start from there.

I am confident we _can_, too. My question is whether we will. :)

> Assuming that we can have such a checker, I am more interested in
> the way how people envision such a checker fits in our workflow to
> help people.  Earlier Dscho floated an idea to integrate with the
> GitHub pull requests in a way similar to how Travis and SubmitGit
> are triggered, and I can sort of see how it may help, but I haven't
> seen ideas from others.

Yeah, I agree. I assume most people already run "make test" locally. I'd
be happy enough if we started with a "make style" that offers style
suggestions for you to accept. From there we can grow into
"automatically apply suggestions" and integrating with things like
submitGit.

-Peff
