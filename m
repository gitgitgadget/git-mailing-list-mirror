From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 23:45:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
 <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcG3l-0003gj-RD
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWJXGqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWJXGqp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:46:45 -0400
Received: from mx3.cs.washington.edu ([128.208.3.132]:12173 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1752096AbWJXGqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 02:46:44 -0400
Received: from attu2.cs.washington.edu (attu2.cs.washington.edu [128.208.1.138])
	by mx3.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id k9O6jx0S015635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 23 Oct 2006 23:45:59 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu2.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id k9O6jwcK030938;
	Mon, 23 Oct 2006 23:45:58 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu2.cs.washington.edu: rientjes owned process doing -bs
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29935>

On Mon, 23 Oct 2006, Linus Torvalds wrote:

> Historically, "git" was _only_ a wrapper program. When you did
> 
> 	git log
> 
> it just executed the real program called "git-log", which was often a 
> shell-script. That was just so that things could easily be extended, and 
> you could use shell-script for simple one-liner things, and native C for 
> more "core" stuff.
> 
> For example, "git log" used to be a one-line shell-script that just did
> 
> 	git-rev-list --pretty HEAD | LESS=-S ${PAGER:-less}
> 
> but it ended up being a lot more capable, and eventually just rewritten 
> as an internal command..
> 

Some of the internal commands that have been coded in C are actually much 
better handled by the shell in the first place.  It's much simpler to 
write and extend as well as being much more traceable for runtime 
problems.  The shell commands that would be used for most of these git
routines have options for requesting it to be more verbose so the user 
actually has a lot more power over reporting and/or logging.  In addition 
it tends to be more portable and the amount of code is drastically reduced 
in a script style of programming.  The criticisms against such use of 
shell scripting tends to be a matter of personal taste.  People believe, 
for some reason or another, that it is a lower-class type of programming 
that is less robust and is harder to understand.  Seldom have there been 
cogent arguments for coding such features in C as opposed to shell 
scripting, especially in the case of git where the shell becomes a very 
powerful ally.

		David
