From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 14:31:10 +0200
Message-ID: <20060818123110.GQ13776@pasky.or.cz>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com> <Pine.LNX.4.63.0608181209210.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rientjes <rientjes@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 14:31:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE3VM-0002V5-Gh
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 14:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWHRMbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 08:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWHRMbN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 08:31:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22712 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932445AbWHRMbM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 08:31:12 -0400
Received: (qmail 23065 invoked by uid 2001); 18 Aug 2006 14:31:10 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608181209210.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25655>

Hi,

Dear diary, on Fri, Aug 18, 2006 at 12:21:11PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> However, you should know that there is _no way_ to use both hashes on the 
> same project. Yes, you could rewrite the history, trying to convert also 
> the hashes in the commit objects, but people actually started relying on 
> naming commits with the short-SHA1.

I don't really like having IDs ambiguous in this sense - having the same
type of IDs in all git-tracked projects has some cute benefits which are
of the kind that you don't know ahead that you will need them: joining
history of two distinct projects in a merge and theoretical possibility
of having subprojects where the main project references an exact
tree/commit of the sub project.

If we are ever going to implement support for multiple hashes, the hash
type should at least be part of the object id, in textual representation
as e.g. the first letter. This can still lead to convergence issues and
duplicate objects, but it enables smooth transition without rewriting
the history and it is much less confusing than just switching to a
different function.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
