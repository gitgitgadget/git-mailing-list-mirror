Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E6C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533F16144A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbhDWJOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:14:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:33088 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241733AbhDWJOO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:14:14 -0400
Received: (qmail 5920 invoked by uid 109); 23 Apr 2021 09:13:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 09:13:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6340 invoked by uid 111); 23 Apr 2021 09:13:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 05:13:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 05:13:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/8] rev-list: implement object type filter
Message-ID: <YIKPwRFbgzKJ1EBg@coredump.intra.peff.net>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
 <xmqq1rb5985x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rb5985x.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 04:16:58PM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this is the fifth version of my patch series which implements a new
> > `object:type` filter for git-rev-list(1) and git-upload-pack(1) and
> > extends support for bitmap indices to work with combined filters.
> >
> > Changes compared to v4:
> >
> >     - I'm now explicitly passing `strlen(v0)` to
> >       `type_from_string_gently()` to be prepared for the future
> >       semantics change here.
> >
> >     - The error message printed in case the user passes in invalid
> >       object type to `--filter=object:type=` now prints the wrong
> >       value passed by the user.
> >
> >     - Fixed missing header in list-objects-filter-options.h.
> >
> >     - Tests now use test_create_repo and test_commit.
> >
> >     - Removed a needless subshell in the tests.
> >
> > I hope that this catches all feedback and that I didn't misunderstand or
> > miss something. If I did, please give me a shout!
> 
> Thanks.  Will queue and wait.
> 
> I am expecting to go offline for about a week starting 21st or so;
> hopefully the topyc is ready to merge it to 'next' by the time I
> come back online.

This iteration looks good to me.

-Peff
