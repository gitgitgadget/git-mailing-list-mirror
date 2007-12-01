From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which commit
 was created
Date: Sat, 1 Dec 2007 22:41:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712012238510.27959@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
 <Pine.LNX.4.64.0711111736440.4362@racer.site> <20071201222106.GA27102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 23:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyb2j-0002GO-LA
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 23:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbXLAWmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 17:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXLAWmS
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 17:42:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:53985 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752022AbXLAWmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 17:42:17 -0500
Received: (qmail invoked by alias); 01 Dec 2007 22:42:15 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp008) with SMTP; 01 Dec 2007 23:42:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198ZHAQEv18sHc/GrKDqH4HT+y65mYoEgJClmBiUf
	tT6jv/NxWVlfay
X-X-Sender: gene099@racer.site
In-Reply-To: <20071201222106.GA27102@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66742>

Hi,

On Sat, 1 Dec 2007, Jeff King wrote:

> On Sun, Nov 11, 2007 at 05:36:52PM +0000, Johannes Schindelin wrote:
> 
> > The function log_tree_commit() does not break the line, so we have to
> > do it ourselves.
> 
> Johannes,
> 
> Can you explain the rationale for this change in more detail?

Basically, I ran a test case in which the shell script was different from 
the builtin version, and this was the patch that fixed it for me.

Maybe it should have been

	if (log_tree_commit(&rev, commit))
		printf("\n");

at the end of print_summary() instead.  Can you try if that fixes it for 
you?

Ciao,
Dscho
