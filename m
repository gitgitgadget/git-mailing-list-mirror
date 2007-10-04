From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: git-cvsserver commit trouble BUG+Work-around
Date: Thu, 4 Oct 2007 15:06:12 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710041506.13154.wielemak@science.uva.nl>
References: <200710031348.50800.wielemak@science.uva.nl> <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl> <Pine.LNX.4.64.0710041352480.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 15:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQUp-0000Mx-Ps
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 15:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbXJDNL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 09:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755306AbXJDNL7
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 09:11:59 -0400
Received: from imap.science.uva.nl ([146.50.4.51]:34616 "EHLO
	imap.science.uva.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbXJDNL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 09:11:59 -0400
Received: from gollem.science.uva.nl [146.50.26.20]
          by imap.science.uva.nl with ESMTP (sendmail 8.13.8/config 11.38).
          id l94DBtD8022988; Thu, 4 Oct 2007 15:11:56 +0200
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710041352480.4174@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59949>

Hi Dscho,

On Thursday 04 October 2007 14:56, Johannes Schindelin wrote:
> On Thu, 4 Oct 2007, Jan Wielemaker wrote:
> > Indeed, the trouble is here: git-cvsserver, near line 1203:
> >
> >     my $parenthash = `git show-ref -s refs/heads/$state->{module}`;
> >
> > $state->{module} is -of course- HEAD. git show-ref -s refs/heads/HEAD
> > indeed gives no output. git show-ref -s refs/heads/master works just
> > fine.
>
> Ah!  Did you do "CVSROOT=:ext:blablub cvs co HEAD"?

Yip ...

> You should "co master".  The branches in git are the modules in cvs.
>
> HEAD is too volatile, you cannot make a proper module from it (imagine for
> example "git checkout next" where "next" is a branch, followed by "git
> checkout html", where "html" is another branch).

Ok.  Pretty sure I got literal HEAD from one of the examples somewhere ...
Or, I've been blind all along.  Anyway, the maintainer may consider giving
an error when trying to access HEAD as a module.  Would have saved about
2 days work and its unlikely I'm the last victim :-(

Part of the two days is that during all the things I tried somehow
messed up with master too, so the one time I tried that it failed as
well :-(

Anyway, case closed.  On with the testing ...

	Thanks --- Jan
