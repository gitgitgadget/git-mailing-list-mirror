Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A45C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18B860EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhHKTHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:07:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:44528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhHKTHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:07:12 -0400
Received: (qmail 22434 invoked by uid 109); 11 Aug 2021 19:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 19:06:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13617 invoked by uid 111); 11 Aug 2021 19:06:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 15:06:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 15:06:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Message-ID: <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgto9dkd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 09:00:18AM -0700, Junio C Hamano wrote:

> A more notable aspect of the above list is not the similarity but
> difference from the rest of Git.  The above organizes various
> operations on the staging area in a single command as its operating
> modes, so you'd use "git stage --diff" for comparing with the
> staging area but use something else ("git commit --diff HEAD"???).
> 
> It is a good example that illustrates that the proposed organization
> may not help learning or using the system for operations that also
> apply to other things like commit and working tree (in other words,
> "git stage --grep" may not be such a good idea for the same reason
> as "git stage --diff").  But if it were limited to operations that
> apply only to the index (e.g. "git add" and "git rm"), it may be an
> improvement (I think we added "git stage" synonym exactly for that
> reason, already).

One thing I find off-putting about "git stage --diff" is that to me,
"stage" reads as a verb. So it is like "git add --diff", which seems
out-of-place; there are two verbs in a row.

I do not mind the term "staging area", but using "the stage" as a noun
is simply confusing to me in this context.

-Peff
