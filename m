Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E861FF72
	for <e@80x24.org>; Sat, 21 Oct 2017 19:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbdJUT0F (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 15:26:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:60092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932159AbdJUT0E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 15:26:04 -0400
Received: (qmail 4514 invoked by uid 109); 21 Oct 2017 19:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 19:26:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25647 invoked by uid 111); 21 Oct 2017 19:26:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 15:26:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2017 15:26:01 -0400
Date:   Sat, 21 Oct 2017 15:26:01 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Andrey Okoshkin <a.okoshkin@samsung.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH 4/4] worktree: handle broken symrefs in
 find_shared_symref()
Message-ID: <20171021192601.2nvkmzsctujzxjbm@sigill.intra.peff.net>
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
 <20171019174936.izojvrh5w35s3adi@sigill.intra.peff.net>
 <CAPig+cT3=BNcM+WZWhpAq6Ch=5xC47oW_S-9=YfEQL7rRkyPhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT3=BNcM+WZWhpAq6Ch=5xC47oW_S-9=YfEQL7rRkyPhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 21, 2017 at 06:49:15AM -0400, Eric Sunshine wrote:

> On Thu, Oct 19, 2017 at 1:49 PM, Jeff King <peff@peff.net> wrote:
> > The refs_resolve_ref_unsafe() function may return NULL even
> > with a REF_ISSYMREF flag if a symref points to a broken ref.
> > As a result, it's possible for find_shared_symref() to
> > segfault when it passes NULL to strcmp().
> > [...]
> > We can fix this by treating NULL the same as a non-matching
> > symref. Arguably we'd prefer to tell know if a symref points
> 
> s/tell//

Right, thank you.

-Peff
