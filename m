From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] Introduce commit notes
Date: Mon, 16 Jul 2007 00:52:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160049210.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vlkdhck8d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:52:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADt9-000619-4j
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637AbXGOXw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756835AbXGOXw2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:52:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:56319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755001AbXGOXw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:52:27 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:52:25 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp056) with SMTP; 16 Jul 2007 01:52:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XxPQYLLvXMDfKMNN0yv1/A77ZsCQ3UXsMk4qStX
	ZmIg4FUWtkPros
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlkdhck8d.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52610>

Hi,

On Sun, 15 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The notes ref is a branch which contains trees much like the
> > loose object trees in .git/objects/.  In other words, to get
> > at the commit notes for a given SHA-1, take the first two
> > hex characters as directory name, and the remaining 38 hex
> > characters as base name, and look that up in the notes ref.
> > ...
> > However, a remedy is near: in a later commit, a .git/notes-index
> > will be introduced, a cached mapping from commits to commit notes,
> > to be written when the tree name of the notes ref changes.  In
> > case that notes-index cannot be written, the current (possibly
> > slow) code will come into effect again.
> 
> I wonder if it is worth using the fan-out tree structure for the
> underlying "note" trees, as the notes-index would be the primary
> way to access them.

The fan-out tree is a nice fallback solution when you cannot write the 
notes-index.

> Not that I've looked at the code too deeply with an intention of 
> possibly including it early.  I was hoping to see fixes to d/f code in 
> merge-recursive from either you or Alex instead ;-)

Well, yeah.  I was kind of trying to cool off from my unpleasant 
unpack_trees() experience.

But I'll look into the issue again this week.  Promise.

Ciao,
Dscho
