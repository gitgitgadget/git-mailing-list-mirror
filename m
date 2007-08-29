From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 14:49:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291446011.28586@racer.site>
References: <1188319608.6106.63.camel@beauty>  <20070828172709.GB1219@pasky.or.cz>
  <200708291005.08795.andyparkins@gmail.com>  <20070829095202.GE1219@pasky.or.cz>
 <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Benjamin Collins <aggieben@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:50:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQNvi-0002Fu-GU
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758666AbXH2Ntw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 09:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758397AbXH2Ntv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:49:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:53307 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756364AbXH2Ntv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:49:51 -0400
Received: (qmail invoked by alias); 29 Aug 2007 13:49:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 29 Aug 2007 15:49:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184UqlA1l84Uq52JYW6xLOIZWmdCcN+O6N6TpadeN
	8S1qLV6XCgind4
X-X-Sender: gene099@racer.site
In-Reply-To: <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56949>

Hi,

On Wed, 29 Aug 2007, Benjamin Collins wrote:

> Of course, I understand why it's not already like that, particularly 
> given the context of Linux development practices.

It has nothing to do with Linux development practices.  There are 
fundamental reasons why we don't fetch hooks:

- they are _not_ part of the repository; just look at the 
  .gitattributes-in-the-index-but-not-worktree issue to find out why,

- it is _private_ data, just like the config.  The client has _no 
  business_ to read them, let alone fetch them,

- if you have the hooks on different machines, chances are that you need a 
  mechanism to update the hooks... This naturally suggests putting the 
  hooks into their own branch.

Probably there are way more reasons not to allow such a thing as fetching 
hooks.

Ciao,
Dscho
