Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82037C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7080820842
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgHDUAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:00:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48078 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgHDUAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 16:00:19 -0400
Received: (qmail 5592 invoked by uid 109); 4 Aug 2020 20:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 20:00:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15078 invoked by uid 111); 4 Aug 2020 20:00:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 16:00:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 16:00:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200804200018.GB2014743@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <20200729201002.GA2989059@coredump.intra.peff.net>
 <871rku3soc.fsf@osv.gnss.ru>
 <20200731230858.GA1461090@coredump.intra.peff.net>
 <87mu3drynx.fsf@osv.gnss.ru>
 <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
 <20200803180824.GA2711830@coredump.intra.peff.net>
 <874kpi47xj.fsf@osv.gnss.ru>
 <xmqqbljqrydm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbljqrydm.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 12:42:45PM -0700, Junio C Hamano wrote:

> As a minimum patch, I think it is OK to have just 'all' and 'none'
> (not even c or cc, let alone the one with ultra-long name whose
> effect is mystery) before we let the result graduate to 'master'.
> Others can be added on top, as the primary focus of Peff's series is
> to make sure "-m" can be countermanded, for which being able to say
> "no" is sufficient, and the primary reason why we are further
> futzing with the series with this addition is to leave the door open
> for later additions of different "modes" in which how
> "--diff-merges" option can operate (iow, Peff's was merely on/off,
> but you are making sure others such as <num> can be added over
> time).

I like that suggestion very much. It solves the "optional arguments are
evil" problem without having to worry about the other bits.

-Peff
