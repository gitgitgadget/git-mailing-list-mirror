Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F29FC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E101601FD
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhHCWix (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:38:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233570AbhHCWhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:37:54 -0400
Received: (qmail 3275 invoked by uid 109); 3 Aug 2021 22:37:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Aug 2021 22:37:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19854 invoked by uid 111); 3 Aug 2021 22:37:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Aug 2021 18:37:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Aug 2021 18:37:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to
 ort
Message-ID: <YQnFMmyd744Oolep@coredump.intra.peff.net>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net>
 <xmqqim0mtc3u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim0mtc3u.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 03:08:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It would make sense to me to do the switch in 'next' early in the
> > post-v2.33 cycle. It can cook there for a bit, but I think we have found
> > that it's much more likely to see actual use once it hits 'master'. So I
> > don't see a particular reason to have it sit in 'next' for a long time.
> > We should get as much exposure in 'master' during the v2.34 cycle as
> > possible.
> 
> I do not mind queuing what is available today to 'next' to gain 2
> more weeks of dogfood time during the pre-release freeze.  If an
> simple escape hatch that lets us say "anytime we ask ort, use
> recursive instead as an emergency measure" can be added with a
> trivially obvious small patch, that would be a plus.

Yeah, I am happy even starting the 'next' portion sooner than the
release. :) As Elijah explained, we already have that emergency measure
in place (pull.merge).

-Peff
