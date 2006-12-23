From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 20:10:31 -0700
Message-ID: <20061223031031.GA7412@socrates.priv>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612221539100.18171@xanadu.home>
 <7vpsabv6tm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 04:10:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxxHT-00007u-6b
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 04:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWLWDKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 22:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWLWDKc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 22:10:32 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:64150 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbWLWDKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 22:10:31 -0500
Received: from pd2mr7so.prod.shaw.ca (pd2mr7so-qfe3.prod.shaw.ca [10.0.141.10])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JAP007E2I5JCZ00@l-daemon> for git@vger.kernel.org; Fri,
 22 Dec 2006 20:10:31 -0700 (MST)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
 by pd2mr7so.prod.shaw.ca (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0JAP00IXEI5J8QP1@pd2mr7so.prod.shaw.ca> for
 git@vger.kernel.org; Fri, 22 Dec 2006 20:10:31 -0700 (MST)
Received: from socrates.priv ([68.148.57.191])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JAP00F6II5HW350@l-daemon> for git@vger.kernel.org; Fri,
 22 Dec 2006 20:10:30 -0700 (MST)
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id kBN3AWvf027730; Fri,
 22 Dec 2006 20:10:32 -0700
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit)
 id kBN3AVG4027729; Fri, 22 Dec 2006 20:10:31 -0700
In-reply-to: <7vpsabv6tm.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>,
 Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35255>

On Fri, Dec 22, 2006 at 03:39:33PM -0800, Junio C Hamano wrote:
> [PATCH] Do not support "partial URL shorthand" anymore.
> 
> We used to support specifying the top part of remote URL in
> remotes and use that as a short-hand for the URL.
> 
> 	$ cat .git/remotes/jgarzik
> 	URL: git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/
> 	$ git pull jgarzik/misc-2.6
> 
> This is confusing when somebody attempts to do this:
> 
> 	$ git pull origin/foo
> 
> which is not syntactically correct (unless you have origin/foo.git
> repository) and should fail, but it resulted in a mysterious
> access to the 'foo' subdirectory of the origin repository.
> 
> Which was what it was designed to do, but because this is an
> oddball "feature" I suspect nobody uses, let's remove it.

Except with the forthcoming submodule support, this feature might become
more useful.

  Tom
