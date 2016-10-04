Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B13420986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbcJDQLo (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:11:44 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55440 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbcJDQLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:11:43 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1brSJW-0002Gy-00; Tue, 04 Oct 2016 16:11:30 +0000
Date:   Tue, 4 Oct 2016 12:11:30 -0400
From:   Rich Felker <dalias@libc.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
Message-ID: <20161004161130.GX19318@brightrain.aerifal.cx>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610041802310.35196@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 06:08:33PM +0200, Johannes Schindelin wrote:
> Hi Rich,
> 
> On Tue, 4 Oct 2016, Rich Felker wrote:
> 
> > On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
> > > On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> > > 
> > > > 1. is nonzero mod page size, it just works; the remainder of the last
> > > >    page reads as zero bytes when mmapped.
> > > 
> > > Is that a portable assumption?
> > 
> > Yes.
> 
> No, it is not. You quote POSIX, but the matter of the fact is that we use
> a subset of POSIX in order to be able to keep things running on Windows.
> 
> And quite honestly, there are lots of reasons to keep things running on
> Windows, and even to favor Windows support over musl support. Over four
> million reasons: the Git for Windows users.

I would hope that in the future, git-for-windows users will be using
musl, via midipix, rather than the painfully slow and awful version
they're stuck with now...

Rich
