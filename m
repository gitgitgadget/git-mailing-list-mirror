Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CB61F453
	for <e@80x24.org>; Thu,  4 Oct 2018 22:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJEFLB (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:11:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:41966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725997AbeJEFLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:11:00 -0400
Received: (qmail 5371 invoked by uid 109); 4 Oct 2018 22:15:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 22:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31169 invoked by uid 111); 4 Oct 2018 22:14:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Oct 2018 18:14:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2018 18:15:32 -0400
Date:   Thu, 4 Oct 2018 18:15:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/5] oidset: use khash
Message-ID: <20181004221531.GC28287@sigill.intra.peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 05:05:37PM +0200, René Scharfe wrote:

> Two new patches to avoid using oidset internals in fetch-pack:
> 
>   fetch-pack: factor out is_unmatched_ref()
>   fetch-pack: load tip_oids eagerly iff needed
> 
> Unchanged patch:
> 
>   khash: factor out kh_release_*
> 
> Unchanged, except it doesn't touch fetch-pack anymore:
> 
>   oidset: use khash
> 
> A new patch, to reduce object text size:
> 
>   oidset: uninline oidset_init()

I left a few responses to the fetch-pack changes. The rest of it all
looks good to me. Certainly it's satisfying for the implementation-swap
in patch 4 to be able to touch _only_ oidset.[ch].

-Peff
