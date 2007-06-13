From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 14:13:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131412320.4059@racer.site>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
 <7v1wggir80.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 15:17:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HySin-0004cQ-HX
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 15:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbXFMNRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 09:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbXFMNRI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 09:17:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:38492 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751761AbXFMNRH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 09:17:07 -0400
Received: (qmail invoked by alias); 13 Jun 2007 13:17:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 13 Jun 2007 15:17:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4jLk+JCO4hJ2mZcs3GYKQlUPV/qgMUTBXyT05vX
	cureyv1pv2MN9v
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wggir80.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50057>

Hi,

On Tue, 12 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Earlier, Git interpreted the pattern as a strict prefix, which made
> > the operator unsuited in many cases.
> >
> > Now, the pattern is interpreted as a regular expression (which does not 
> > change the behaviour too much, since few onelines contain special regex 
> > characters), so that you can say
> >
> > 	git diff :/.*^Signed-off-by:.Zack.Brown
> >
> > to see the diff against the most recent reachable commit which was
> > signed off by Zack, whose Kernel Cousin I miss very much.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> While this perhaps is an improvement and people who are not
> interested in paying the price have a choice of not using this
> silly syntax, I am moderately annoyed that the syntax does not
> define "the most recent reachable" very well.  It is more like
> "the first one we happened to pick by diffing from reachable
> refs".  It would be more useful if it took "$commit:/$pattern"
> form to limit the search among reachable ones from named commit.

"Unfortunately", $commit:/$pattern is not a good syntax, since it suggests 
that you want to search _in_ $commit, not _from $commit.

How about ':/!commit=$commit:$pattern'?

Ciao,
Dscho
