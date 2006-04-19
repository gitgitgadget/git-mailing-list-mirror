From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Wed, 19 Apr 2006 07:16:56 -0700
Message-ID: <20060419141656.GC4104@tumblerings.org>
References: <20060419053640.GA16334@tumblerings.org> <7vd5feawel.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 16:17:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWDUK-0001x8-KX
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 16:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDSOQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 10:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWDSOQ5
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 10:16:57 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:62679 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1750788AbWDSOQ5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 10:16:57 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.60)
	(envelope-from <zbrown@tumblerings.org>)
	id 1FWDUG-0002nE-9g; Wed, 19 Apr 2006 07:16:56 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5feawel.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18924>

On Tue, Apr 18, 2006 at 11:53:38PM -0700, Junio C Hamano wrote:
> Zack Brown <zbrown@tumblerings.org> writes:
> 
> > What is going on? I'm completely unable to clone a repository.
> 
> I have no idea how cg-* is broken, so I'll let Pasky answer
> that, but I suspect your git installation is broken.
> 
> > If I try
> > "git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git",
> > I get this error: "git: 'clone' is not a git-command", and it prints a usage
> > page, but "clone" is listed on that usage page.
> 
> That sounds intersting.  Although rsync is deprecated for a long
> time and git:// is the preferred transport, I do not get "is not
> a git-command" error.  Are you installing things correctly?

I think so. I was able to reproduce this behavior using the tarballs that are
used to start out a new user with git and cogito; as well as with the latest
version in the repository.

But I also thought the rsync deprecation was not really true. Wasn't that
discussed here recently? I thought the conclusion was that folks *wanted*
to deprecate it, but at the moment it was still the best way to accomplish
certain things.

> 
> For example, as the first paragraph of INSTALL says, if you
> override prefix= from the make command line, you need to do so
> consistently when you build and when you install.
> 
> What do these command say?
> 
> 	$ git --exec-path
> 	$ ls -l "`git --exec-path`/git-clone"

22:07:05 [zbrown] ~$ git --exec-path
/home/zbrown/bin
07:10:34 [zbrown] ~$ ls -l "`git --exec-path`/git-clone"
ls: /home/zbrown/bin/git-clone: No such file or directory

Does that mean it's looking in /home/zbrown/bin for the git binaries? That's
weird. I have /home/zbrown/git/git and /home/zbrown/git/cogito in my $PATH
specifically to hold those executables. There's no git stuff in
/home/zbrown/bin.

Be well,
Zack


> 

-- 
Zack Brown
