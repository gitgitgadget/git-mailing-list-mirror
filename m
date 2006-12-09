X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] shortlog: fix segfault on empty authorname
Date: Sat, 09 Dec 2006 16:56:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612091653070.2630@xanadu.home>
References: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
 <20061209040421.GA29113@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 9 Dec 2006 21:56:18 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061209040421.GA29113@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33839>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtAB4-0007RG-PQ for gcvg-git@gmane.org; Sat, 09 Dec
 2006 22:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758492AbWLIV4L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbWLIV4L
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 16:56:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55572 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758474AbWLIV4J (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 16:56:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA100FYJ0XKNHB0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Sat,
 09 Dec 2006 16:56:08 -0500 (EST)
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

On Fri, 8 Dec 2006, Jeff King wrote:

> The old code looked backwards from the email address to parse the name,
> allowing an arbitrary number of spaces between the two. However, in the case
> of no name, we looked back too far to the 'author' (or 'Author:') header.
> Instead, remove at most one space between name and address.
> 
> The bug was triggered by commit febf7ea4bed from linux-2.6.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Yep, that fixes the problem.


