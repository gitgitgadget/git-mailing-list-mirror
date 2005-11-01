From: Petr Baudis <pasky@suse.cz>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 1 Nov 2005 10:15:33 +0100
Message-ID: <20051101091533.GB11618@pasky.or.cz>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com> <20051031213003.GN11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 10:16:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWsF1-0000I9-UP
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 10:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVKAJPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 04:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVKAJPg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 04:15:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19428 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965011AbVKAJPf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 04:15:35 -0500
Received: (qmail 19668 invoked by uid 2001); 1 Nov 2005 10:15:33 +0100
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20051031213003.GN11488@ca-server1.us.oracle.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10927>

Dear diary, on Mon, Oct 31, 2005 at 10:30:03PM CET, I got a letter
where Joel Becker <Joel.Becker@oracle.com> told me that...
> On Tue, Nov 01, 2005 at 09:28:30AM +1300, Martin Langhoff wrote:
> > You can do a diff that spans all the commits and apply it with a new
> > commit msg. With cogito:
> > 
> >    cg-diff -r from:to | patch -p1
> 
> 	I'm well aware of this, my question was rather one of
> applicability.  First, do we want it to work this way, losing the
> history.  Second, you'd like the process to be all encompasing if you go
> this route.
> 
>     ((cd old-repo && cg-diff -r from) | patch -p1) && cg-commit
> 
> or any equivalent.  Why should I have to muck with patch and diff, when
> I can have a 'pull-as-one' operation.  Sure, it's a wrapper, but if its
> the intended mode of development, let's make it a first-class citizen.

Personally, from my POV it is the intended mode of development only if
you keep strictly topical branches (a single logical change and fixes of
it on top of that). Otherwise, this is horrid because it loses the
_precious_ history and bundles us different changes to a single commit,
which is one of the thing that are wrong on CVS/SVN merging.

That said, with a big warning, I would be willing to do something like
cg-merge -s and cg-update -s (s as squash), with a big warning that this
is suitable only for topical branches. And I think it'd be still much
better to spend the work making StGIT able to track history of changes
to a particular patch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
