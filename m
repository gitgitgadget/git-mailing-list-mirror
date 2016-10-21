Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C05C20986
	for <e@80x24.org>; Fri, 21 Oct 2016 08:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbcJUIYP (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 04:24:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:60516 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753334AbcJUIYM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 04:24:12 -0400
Received: (qmail 10063 invoked by uid 109); 21 Oct 2016 08:24:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 08:24:11 +0000
Received: (qmail 999 invoked by uid 111); 21 Oct 2016 08:24:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 04:24:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 04:24:09 -0400
Date:   Fri, 21 Oct 2016 04:24:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161021082409.isgrvurv4ttra7ai@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610201218060.3264@virtualbox>
 <CAGZ79kZpj5xXHmnA+JfLKdGmgzp7Mut1OsKMOeowpw8m1+aKGA@mail.gmail.com>
 <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
 <4d97fcc7-d15b-e7d8-c787-483c67d4a66b@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d97fcc7-d15b-e7d8-c787-483c67d4a66b@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 07:27:40AM +0200, Johannes Sixt wrote:

> Am 20.10.2016 um 23:38 schrieb Jeff King:
> > 	test_cmp () {
> > 		# optimize for common "they are the same" case
> > 		# without any subshells or subprograms
> 
> We do this already on Windows; it's the function mingw_test_cmp in our test
> suite:
> https://github.com/git/git/blob/master/t/test-lib-functions.sh#L884-L945

Ah, thanks, I didn't even think to look for an existing solution like
this. Looks like it was done for LF/CRLF reasons, though, not
performance. I wonder if anybody has measured whether it improves things
there or not.

-Peff
