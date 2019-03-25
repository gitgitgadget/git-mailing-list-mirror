Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59C320248
	for <e@80x24.org>; Mon, 25 Mar 2019 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfCYXh0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 19:37:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:35936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726061AbfCYXh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 19:37:26 -0400
Received: (qmail 5597 invoked by uid 109); 25 Mar 2019 23:37:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Mar 2019 23:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13476 invoked by uid 111); 25 Mar 2019 23:37:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Mar 2019 19:37:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2019 19:37:24 -0400
Date:   Mon, 25 Mar 2019 19:37:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Strange annotated tag issue
Message-ID: <20190325233723.GD23728@sigill.intra.peff.net>
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
 <20190321192928.GA19427@sigill.intra.peff.net>
 <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com>
 <20190325144930.GA19929@sigill.intra.peff.net>
 <87tvfqbw3m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvfqbw3m.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 08:19:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >   $ git tag -a mytag
> >   error: refusing to make a recursive tag
> >   hint: The object 'mytag' referred to by your new tag is already a tag.
> >   hint:
> >   hint: If you meant to create a tag of a tag, use:
> >   hint:
> >   hint:  git tag -a -f mytag
> >   hint:
> >   hint: If you meant to tag the object that it points to, use:
> >   hint:
> >   hint:  git tag -a mytag^{}
> >
> > It would be a minor annoyance to somebody who frequently makes
> > tags-of-tags, but it leaves them with an escape hatch.
> 
> Let's call that something like --allow-recursive-tag (inspired by
> 'merge' --allow-unrelated-histories) so we don't confuse the desire to
> create such a tag with clobbering an existing tag (which -f is
> documented to do).

Yeah, that's probably a good idea. Now we just need somebody to write
the patch...

-Peff
