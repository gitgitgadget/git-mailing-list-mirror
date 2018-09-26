Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEF21F453
	for <e@80x24.org>; Wed, 26 Sep 2018 04:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeIZK0O (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 06:26:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726062AbeIZK0O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 06:26:14 -0400
Received: (qmail 17340 invoked by uid 109); 26 Sep 2018 04:15:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 04:15:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15211 invoked by uid 111); 26 Sep 2018 04:14:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 00:14:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 00:15:17 -0400
Date:   Wed, 26 Sep 2018 00:15:17 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
Message-ID: <20180926041517.GA2140@sigill.intra.peff.net>
References: <20180921223558.65055-1-sbeller@google.com>
 <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com>
 <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 12:26:44PM -0700, Stefan Beller wrote:

> On Sat, Sep 22, 2018 at 5:58 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > On Fri, Sep 21 2018, Stefan Beller wrote:
> >
> > > +/*
> > > + * Apply want to each entry in array, retaining only the entries for
> > > + * which the function returns true.  Preserve the order of the entries
> > > + * that are retained.
> > > + */
> > > +void oid_array_filter(struct oid_array *array,
> > > +                   for_each_oid_fn want,
> > > +                   void *cbdata);
> > > +
> > >  #endif /* SHA1_ARRAY_H */
> >
> > The code LGTM, but this comment should instead be an update to the API
> > docs, see my recent 5cc044e025 ("get_short_oid: sort ambiguous objects
> > by type, then SHA-1", 2018-05-10) for an addition of a new function to
> > this API where I added some new docs.
> 
> ok will fix for consistency (this whole API is there).
> 
> Longer term (I thought) we were trying to migrate API docs
> to headers instead?

Yes, please. I think it prevents exactly this sort of confusion. :)

-Peff
