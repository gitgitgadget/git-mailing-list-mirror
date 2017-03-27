Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C49520966
	for <e@80x24.org>; Mon, 27 Mar 2017 07:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdC0HS7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 03:18:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:52259 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbdC0HS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 03:18:57 -0400
Received: (qmail 19504 invoked by uid 109); 27 Mar 2017 07:12:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 07:12:00 +0000
Received: (qmail 9910 invoked by uid 111); 27 Mar 2017 07:12:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 03:12:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Mar 2017 03:11:58 -0400
Date:   Mon, 27 Mar 2017 03:11:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] rev-parse: match ^{<type>} case-insensitively
Message-ID: <20170327071158.4s3h7qwlyqogioli@sigill.intra.peff.net>
References: <20170326121654.22035-1-avarab@gmail.com>
 <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
 <20170326121654.22035-4-avarab@gmail.com>
 <xmqq60iv4ku2.fsf@gitster.mtv.corp.google.com>
 <20170327025818.pbm4nwqrfolyto7g@sigill.intra.peff.net>
 <xmqqk27b2s8p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk27b2s8p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 10:39:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > FWIW, I cannot see us ever adding TREE (or Tree) as a separate type.
> > It's too confusing for no gain. We'd call it "tree2" or something more
> > obvious.
> 
> In case it was not clear, I didn't mean to say I _want_ to leave
> that door open.  Well, I cannot imagine it was unclear, as I said I
> do not at all mind declaring that all object names will be lowercase
> to allow us freely downcase what we got at the UI level.

No, I understood that. You just mentioned "list consensus" so I was
trying to give my two cents. ;)

> > I dunno. I guess I have never wanted to type "^{Tree}" in the first
> > place, so I do not personally see the _benefit_. Which makes it easy to
> > see even small negatives as a net loss.
> 
> As to the potential _benefit_, I do not see much either myself, but
> we already are seeing somebody cared enough to throw us a patch, so
> to some people there are clearly perceived benefit.  I do not think
> closing the door for typenames that are not lowercase is a negative
> change at all.

By negative, I just meant potential confusion when we are half-way there
(e.g., "foo^{TREE}" works but "git cat-file TREE foo" does not).

> I just wanted the patch to make it clear that it is making such a
> system-wide design decision and casting it in stone.  Which includes
> that "cat-file <type>" and "hash-object -t <type>" get the same
> case-insensitivity update and probably writing that design decision
> down somewhere in the documentation, perhaps in the glossary where
> we talk about the "object type".

Yes, I agree that that is the right path forward.

-Peff
