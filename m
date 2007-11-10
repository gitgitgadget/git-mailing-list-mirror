From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 15:36:17 -0500
Message-ID: <20071110203616.GA21098@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net> <47359221.7090707@lsrfire.ath.cx> <Pine.LNX.4.64.0711101605560.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 21:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqx4O-0004HY-6d
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 21:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbXKJUgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 15:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbXKJUgV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 15:36:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3654 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100AbXKJUgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 15:36:21 -0500
Received: (qmail 27666 invoked by uid 111); 10 Nov 2007 20:36:19 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 10 Nov 2007 15:36:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Nov 2007 15:36:17 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711101605560.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64377>

On Sat, Nov 10, 2007 at 04:07:10PM +0000, Johannes Schindelin wrote:

> > [...] have cooked up a different one on top of a cleaned up version of 
> > mine.  It plays the dirty trick of reading expansions of repeated 
> > placeholders from the strbuf..
> 
> ... which would not work (likely even segfault) if you work with the same 
> private data on different strbufs.

The nice thing is that the cache validity only lasts for the call to
strbuf_expand (and its callbacks), so there is really very little chance
of somebody mis-using this.

-Peff
