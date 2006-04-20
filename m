From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 13:08:49 -0700
Message-ID: <20060420200849.GA3653@tumblerings.org>
References: <20060419053640.GA16334@tumblerings.org> <20060419094916.GD27689@pasky.or.cz> <20060419142131.GD4104@tumblerings.org> <20060419144827.GX27631@pasky.or.cz> <20060420164908.GA540@tumblerings.org> <7vejzsywrq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 22:09:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWfSb-0007LG-To
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 22:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWDTUIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDTUIy
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 16:08:54 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:15299 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1751183AbWDTUIx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 16:08:53 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.61)
	(envelope-from <zbrown@tumblerings.org>)
	id 1FWfSL-00066K-R3; Thu, 20 Apr 2006 13:08:49 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejzsywrq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18991>

On Thu, Apr 20, 2006 at 10:36:25AM -0700, Junio C Hamano wrote:
> Zack Brown <zbrown@tumblerings.org> writes:
> 
> > I just downloaded the latest versions of git and cogito from kernel.org:
> > cogito-0.17.2 and git-1.3.0; put their directories in my path, and ran "make" on
> > both of them. There's no other version in my path.
> 
> Earlier, you were having this symptom:
> 
> >> What do these command say?
> >> 
> >> 	$ git --exec-path
> >> 	$ ls -l "`git --exec-path`/git-clone"
> >
> > 22:07:05 [zbrown] ~$ git --exec-path
> > /home/zbrown/bin
> > 07:10:34 [zbrown] ~$ ls -l "`git --exec-path`/git-clone"
> > ls: /home/zbrown/bin/git-clone: No such file or directory
> >
> > Does that mean it's looking in /home/zbrown/bin for the git binaries?
> 
> If that is the case, you did not just (quote) "and ran "make"".
> 
> You must have run "make frotz=xyzzy target", but you did not mention
> what frotz, xyzzy and target were.

Not true. I went into the git source directory, and ran "make". Nothing more.

I've been doing that for a long time, whenever I sync with the repository. I
didn't know the installation instructions had changed.

> It probably would help if you did this:
> 
> 	make clean
> 	make bindir=$HOME/git/git gitexecdir=$HOME/git/git/
> 	make bindir=$HOME/git/git gitexecdir=$HOME/git/git/ install

OK, I did this. The first 2 commands worked fine. The third complained of
duplicate files, and exited with an error. Maybe because the source tree is also
$HOME/git/git

I then did a 'cd ..; mkdir tmp; cd tmp; git-init-db' as before, but there
is still no ".git/info" entry created.

Be well,
Zack

> 
> As I said in a previous message, the first paragraph in INSTALL
> file explains this.
> 

-- 
Zack Brown
