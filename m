X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: fix segfault on empty authorname
Date: Sun, 10 Dec 2006 23:43:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612102342490.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
 <20061209040421.GA29113@coredump.intra.peff.net>
 <Pine.LNX.4.63.0612100019270.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061210034524.GA11819@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 22:47:06 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061210034524.GA11819@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33948>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXR1-0003so-HA for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760836AbWLJWnW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761255AbWLJWnV
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:43:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:49376 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1761180AbWLJWnV
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:43:21 -0500
Received: (qmail invoked by alias); 10 Dec 2006 22:43:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 10 Dec 2006 23:43:19 +0100
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 9 Dec 2006, Jeff King wrote:

> On Sun, Dec 10, 2006 at 12:21:03AM +0100, Johannes Schindelin wrote:
> 
> > > Instead, remove at most one space between name and address.
> > 
> > Why? We can fix it properly: Instead of
> > 
> > > -				while (isspace(bob[-1]))
> > > +				if (isspace(bob[-1]))
> > 
> > do something like
> > 
> > 				while (bob - 1 != buffer + 7 && 
> > 						isspace(bob[-1]))
> 
> It doesn't look like there are ever extra spaces to get soaked up in the
> kernel or git repositories, but if there is a reason to expect
>   Full Name    <user@domain>
> then we should probably replace my fix with yours.

This is exactly the kind of assumption which led to the bug to begin with.

Ciao,
Dscho
