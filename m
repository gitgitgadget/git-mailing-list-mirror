From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Tue, 12 Jun 2007 18:28:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706121825460.4059@racer.site>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
 <7v4plf7948.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706102333050.4059@racer.site>
 <7v4plf5qxp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyADW-0000GT-WA
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 19:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbXFLRbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbXFLRbl
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:31:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:33079 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752538AbXFLRbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 13:31:40 -0400
Received: (qmail invoked by alias); 12 Jun 2007 17:31:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 12 Jun 2007 19:31:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uATs4Ic7ujU1j3yzt+vO2HLB792+YF/b0Gt1f6r
	cK0b4POE0Lnl+E
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4plf5qxp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49974>

Hi,

On Sun, 10 Jun 2007, Junio C Hamano wrote:

> With the normal tree parser, the lookup for 
> "refs/annotations/commit:??/?{38}" you have in your code would open one 
> tree (the commit's tree), find the one with leading 2 hexdigits you 
> would want among up to 256 entries with linear search (see 
> tree-walk.c::find_tree_entry()), open that entry which is another tree, 
> and do the same linear search to find the entry with the remaining 38 
> hexdigits.  Finding annotation for commit 0000abcd... is much less 
> expensive than ffff4567...

Okay, I did not find a proper solution. commit->file name via "s/../&\//g" 
is too ugly. But then, I really hope that packv4 becomes unvapourware at 
some stage (for other reasons), and that _should_ help these issues.

Hmm.

Ciao,
Dscho
