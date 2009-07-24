From: Theodore Tso <tytso@mit.edu>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 18:54:15 -0400
Message-ID: <20090724225415.GC6832@mit.edu>
References: <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 00:55:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTfq-0002Ns-DG
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbZGXWza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbZGXWza
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:55:30 -0400
Received: from thunk.org ([69.25.196.29]:44599 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119AbZGXWz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:55:29 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MUTfe-00058J-Lp; Fri, 24 Jul 2009 18:55:23 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MUTeZ-0004Gu-Iw; Fri, 24 Jul 2009 18:54:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123971>

On Fri, Jul 24, 2009 at 02:21:20PM -0700, Linus Torvalds wrote:
> 
> I wonder if there is some way to only load the crazy curl stuff when we 
> actually want open a http: connection.

Well, we could use dlopen(), but I'm not sure that qualifies as a
_sane_ solution --- especially given that there are approximately 15
interfaces used by git, that we'd have to resolve using dlsym().

	   	   	     	       - Ted
