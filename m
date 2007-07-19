From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 10:24:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191016350.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190258550.14781@racer.site> <E4F64312-3F86-49F3-B6BD-D148AFBAB520@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 11:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBSFy-0000UK-UN
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbXGSJZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 05:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbXGSJZF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:25:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:39226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752396AbXGSJZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 05:25:03 -0400
Received: (qmail invoked by alias); 19 Jul 2007 09:25:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 19 Jul 2007 11:25:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CACtBcKwCaPO+fDYLklAOQwWYQh57xTrlcXkc0w
	pSFO/DuvfZi7W2
X-X-Sender: gene099@racer.site
In-Reply-To: <E4F64312-3F86-49F3-B6BD-D148AFBAB520@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52953>

Hi,

On Thu, 19 Jul 2007, Wincent Colaiuta wrote:

> El 19/7/2007, a las 4:30, Johannes Schindelin escribi?:
> 
> > Commit notes are blobs which are shown together with the commit
> > message.  These blobs are taken from the notes ref, which you can
> > configure by the config variable core.notesRef, which in turn can
> > be overridden by the environment variable GIT_NOTES_REF.
> 
> I was trying to look back and find out what the rationale/usage scenario for
> these commit notes might be but Googling for 'git "commit notes"' doesn't
> turn up much other than the original patch you sent a few days ago.
> 
> Is this an evolution of the "git-note: A mechanisim for providing free-form
> after-the-fact annotations on commits" first introduced here?:
> 
> <http://lists.zerezo.com/git/msg465441.html>

Almost.  It is an evolution of the evolution of this.

http://thread.gmane.org/gmane.comp.version-control.git/52598/focus=52603

(which started this thread you were replying to) hints at that, but you're 
right, I failed to give an explicit reference:

http://article.gmane.org/gmane.comp.version-control.git/49588

Background: It was discussed how to go about storing notes (in the mail 
you cited).  I was convinced that Johan's 15-strong patch series was not 
optimal, in that it tried to introduce a _second_ object store, 
_exclusively_ for commit notes, with all kinds of problems like "how to 
fetch it?".

After thinking about how to avoid duplicating the object store, I posted 
my proposal, in the second link I gave.

It was shot down, because of scalability problems.  They were not serious, 
but hurt enough that I stalled working on it, until Alberto reminded me.

Since I felt bad about shooting down Johan's patch series, and then not 
completing my alternative solution, I ended up working on it some more.  
The WIP patch 6/6 hints at what I will submit in the next days, to speed 
up in a transparent manner what would otherwise not scale well.

Ciao,
Dscho
