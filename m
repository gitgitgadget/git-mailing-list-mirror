From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 3/3] cvsserver: Add asciidoc documentation for new database backend configuration
Date: Wed, 11 Apr 2007 16:34:03 +0200
Message-ID: <20070411143402.GB2309@planck.djpig.de>
References: <11759575342765-git-send-email-frank@lichtenheld.de> <11759578902278-git-send-email-frank@lichtenheld.de> <11759578901878-git-send-email-frank@lichtenheld.de> <11759578903791-git-send-email-frank@lichtenheld.de> <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbdtl-0003EN-1Q
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 16:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbXDKOeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 10:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbXDKOeI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 10:34:08 -0400
Received: from planck.djpig.de ([85.10.192.180]:1083 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbXDKOeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 10:34:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 968B088003;
	Wed, 11 Apr 2007 16:34:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnid8rxwvjvv; Wed, 11 Apr 2007 16:34:03 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 529678801B; Wed, 11 Apr 2007 16:34:03 +0200 (CEST)
Mail-Followup-To: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44239>

On Sun, Apr 08, 2007 at 01:44:50AM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > +[[dbbackend]]
> > +Database Backend
> > +----------------
> > +
> > +git-cvsserver uses one database per git head (i.e. CVS module) to
> 
> Probably "git branch" is easier to understand than "git head".

Hmm, should I replace "git head" with "git branch" everywhere
in the document or does it make sense sometimes to use "head"?
Because there are already several places in the current documentation
where head is used.

> > +store information about the repository for faster access. The
> > +database doesn't contain any persitent data and can be completly
> > +regenerated from the git repository at any time. The database
> > +needs to be updated (i.e. written to) after every commit. That
> > +means that even if you offer only read access (e.g. by using
> > +the pserver method), git-cvsserver should have write access to
> > +the database to work reliably (otherwise you need to make sure
> > +that the database if up-to-date all the time git-cvsserver is run).
> 
> This rationale for db update is a bit hard to understand.
> Immediately saying that you need a database update "after every
> commit", you say that read-only access still need it.
> 
> I think the situation where database update is needed is when a
> commit on the branch that has not been given to any cvs client
> is given out for the first time, and when somebody adds new
> commits from git side, the cvsserver session that serves the
> commit for the first time needs to record the branch
> information.

That's what I meant, yes ;)
Will try to reword it to actually say it, too.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
