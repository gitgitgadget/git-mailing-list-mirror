Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E89203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 06:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbcGZGS5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 02:18:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57302 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbcGZGSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 02:18:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FB4203E2;
	Tue, 26 Jul 2016 06:18:54 +0000 (UTC)
Date:	Tue, 26 Jul 2016 06:18:54 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config.mak.uname: correct perl path on FreeBSD
Message-ID: <20160726061854.GA13334@starla>
References: <20160725162125.15734-1-pclouds@gmail.com>
 <CAPc5daWNAWjtfR7CYN3RTeT7VyvgiNX5HED0=f3F=GT8h4yKPA@mail.gmail.com>
 <CACsJy8Df2cBAf0bWe1FLTb9cOqTX3vgNgC=ko82rG2in81R-FQ@mail.gmail.com>
 <xmqqinvt610x.fsf@gitster.mtv.corp.google.com>
 <20160725203316.GA32053@starla>
 <xmqqoa5l4fh0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqoa5l4fh0.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> Duy Nguyen <pclouds@gmail.com> writes:
> >> > On Mon, Jul 25, 2016 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> >> On Mon, Jul 25, 2016 at 9:21 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > about the problem sooner.
> >
> >> >>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> >> >>> ---
> >> >>>  Tested with fbsd 10.3, kvm image. But I suppose it's the same as real
> >> >>>  fbsd.
> >> >>
> >> >> Thanks; and we know that older (but not too old that we no longer care about)
> >> >> FreeBSD all have /usr/local/bin/perl?
> >> >
> >> > I'm no fbsd expert but from the first sentence in [1] "Perl has been
> >> > removed from base more than ten years ago..." I would assume it meant
> >> > "... removed from base, _to_ ports system" which means /usr/local for
> >> > all package installation (for ten years for perl). So I think we are
> >> > good.
> >> 
> >> I guess we didn't follow through
> >> 
> >>     http://public-inbox.org/git/%3C20160720025630.GA71874%40plume%3E/
> >> 
> >> and allowed the thread to drift into a tangent?
> >
> > +Cc Dscho
> >
> > I've been meaning to followup on that, but had connectivity
> > problems to my VM last week.  I still prefer we use numeric
> > comparisons for version numbers since numbers are... numeric.
> > IOW, I prefer we go with my original patch.
> 
> I tend to agree with you if we have to do "systems older than this
> should use /usr/bin, others should use /usr/local/bin", but this
> different incarnation of the same topic seems to claim that older
> ones had /usr/local/bin forever anyway, and that was what made the
> patch interesting.

I dug around the freebsd history (git://github.com/freebsd/freebsd.git)
(~1.5G) and the 3.x and 4.x releases with perl in base still contained
many references to /usr/local/bin/perl

It also seems FreeBSD 2.x releases were also perl-less in base;
so yes, I'm alright with Duy's patch :)
