From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: tolerate clock skew in committer dates
Date: Thu, 24 May 2007 20:46:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705242042530.4648@racer.site>
References: <7vr6p6vxgs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 21:46:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrJGU-0007zT-Iz
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbXEXTqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbXEXTqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:46:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:53081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750759AbXEXTqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:46:24 -0400
Received: (qmail invoked by alias); 24 May 2007 19:46:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 24 May 2007 21:46:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Vp+JiRfsVf22ib+57TooD5wgFRE9er75sKLVjSC
	0r0RDPNyu/d3UT
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6p6vxgs.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48299>

Hi,

On Thu, 24 May 2007, Junio C Hamano wrote:

> This adds a hardcoded slop value (1 day) to the cut-off
> heuristics to work this kind of problem around.

Sounds sensible. (ACK.)

> I think the algorithm could be made a bit smarter by deepening the graph 
> on demand as a new commit is asked to be named (this would require 
> rewriting of name_rev() function not to recurse itself but use a 
> traversal list like revision.c traverser does), but that would be a 
> separate issue.

I also wanted to make the decorator (optionally) smarter, to actually do 
something like name_rev on demand, which would be much faster than (and 
coloured, in contrast to) `git log | git -p name-rev --stdin`.

Ciao,
Dscho
