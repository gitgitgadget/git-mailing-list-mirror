Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A7EC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 21:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJQVkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJQVkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 17:40:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A137F268
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 14:40:34 -0700 (PDT)
Received: (qmail 28354 invoked by uid 109); 17 Oct 2022 21:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 21:40:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11626 invoked by uid 111); 17 Oct 2022 21:40:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 17:40:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 17:40:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, vdye@github.com
Subject: Re: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <Y03L0W6TadyhtDij@coredump.intra.peff.net>
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
 <Y02YzYS172skpbAb@coredump.intra.peff.net>
 <221017.868rlejn4z.gmgdl@evledraar.gmail.com>
 <Y02shQFeXkwYd2g6@coredump.intra.peff.net>
 <xmqqlepeyxf6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlepeyxf6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 02:04:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Really, both here and remove_redundant_pack() should probably be using
> > unlink_or_warn(). Though if you did want to notice the race on deleting
> > the actual .pack file, it would need to be hand-coded.
> 
> Yeah, unlink_or_warn() would probably be the right way to go.
> 
> Other than that, the patch looks good to you folks?

Yeah. I suggested a minor reordering of the one change, but the
substance of the patch looks good to me (and I am OK either way on the
little suggestions).

-Peff
