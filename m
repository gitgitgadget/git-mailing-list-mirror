From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: setting up git-cvsserver
Date: Thu, 3 Aug 2006 10:36:40 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060803083640.GB3816@informatik.uni-freiburg.de>
References: <20060801154906.GA18772@informatik.uni-freiburg.de> <Pine.LNX.4.63.0608011822080.17230@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 10:38:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8YhG-0000JT-Ih
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 10:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWHCIgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 04:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWHCIgr
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 04:36:47 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:3284 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932400AbWHCIgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 04:36:47 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1G8YhC-0001dP-3m; Thu, 03 Aug 2006 10:36:46 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k738aeMD007324;
	Thu, 3 Aug 2006 10:36:40 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k738aeg1007323;
	Thu, 3 Aug 2006 10:36:40 +0200 (MEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608011822080.17230@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24712>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 1 Aug 2006, Uwe Zeisberger wrote:
> 
> > I cannot checkout a git repo via cvs, I think the only problem is, that
> > I don't know how to specify the CVSROOT:
> > 
> > fs-n1:~# grep git- /etc/inetd.conf 
> > 2402    stream  tcp     nowait  root    /usr/local/sbin/git-cvsserver pserver
> 
> From Documentation/git-cvsserver.txt:
> 
> -- snip --
> Note: In some cases, you need to pass the 'pserver' argument twice for
> git-cvsserver to see it. So the line would look like
> 
> ------
>    cvspserver stream tcp nowait nobody git-cvsserver pserver pserver
> -- snap --
> 
> So, maybe this solves your problem?
Yes, thanks.  Sorry.  The mail was written in a hurry because I wanted
to reach a bus.

BTW, after reading inetd.conf(5), I think the git-cvsserver should occur
twice, not pserver.  The first (actually the 6th) item specifies the
path to the binary to call and the next it the program name the program
sees (i.e. argv[0] (in C) resp. $0 (in Perl)).

You could circumvent that by testing $0 == "pserver" in git-cvsserver.

> OTOH it might be cleverer to use SSH transport to begin with.
For me not.  I have to convice some managers in my company that it is
sensible to only switch the linux department to git.  They want to
assert that every engineer can access anybodys code.  Because not every
"other" developper has an account on our cvs server anonymous pserver is
what *I* want.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=sin%28pi%2F2%29
