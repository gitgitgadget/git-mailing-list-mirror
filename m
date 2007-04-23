From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 23 Apr 2007 21:52:58 +0200
Message-ID: <200704232152.58833.Josef.Weidendorfer@gmx.de>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org> <877is29b1l.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 21:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg4ay-00058j-Ax
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 21:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbXDWTxF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXDWTxF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 15:53:05 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:60223 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052AbXDWTxE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 15:53:04 -0400
Received: from dhcp-3s-58.lrr.in.tum.de (dhcp-3s-58.lrr.in.tum.de [131.159.35.58])
	by mail.in.tum.de (Postfix) with ESMTP id BA8F627E6;
	Mon, 23 Apr 2007 21:53:01 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <877is29b1l.wl%cworth@cworth.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45357>

On Monday 23 April 2007, Carl Worth wrote:
> On Thu, 19 Apr 2007 13:57:35 -0700 (PDT), Linus Torvalds wrote:
> >  - Case #1 would be using git basically as a "anonymous CVS" replacement
> >    to track somebody others project.
> 
> I'd extend this to also say "tracking a specific branch" in some
> project.
> 
> When I raised this recently, Junio suggested something like the
> following:
> 
> 	git config --global branch.autosetupmerge true	[*]
> 	git clone <URL>
> 	git checkout -b <branch> origin/<branch>
> 	git pull
> 
> I haven't gotten around to replying to that message yet, but the
> thrust of my reply would be that that does actually work, but it's not
> even close to the ease with which one can track the default branch as
> Linus described:

The commands above are not needed for pure tracking, but instead prepare
a local development branch for you to work on, and where you can pull
upstream changes with "git pull".
For tracking a remote $branch, it should be enough to do

 git clone
 git fetch

and you get the any (*) remote $branch as "remotes/origin/$branch".

Josef


(*) Perhaps the "any" is too much for wanting to track one branch only?

> 
> >    None of the above are ever really needed for that case, and I think all
> >    you really want to learn is:
> >
> > 	git clone
> > 	git pull
> 
> So, currently, all non-default branches have a sort of second-class
> status from the point of view of users that just want to track
> them.
> 
> Compare this to svn, for example. Now, svn has an insanely broken
> model for what a branch actually is, while git's model is sane.  But I
> think that with svn the "anonymously tracking a branch" use case isn't
> any harder for any one branch compared to any other, (it's just a
> matter of starting with the right URL). I'd love to see git achieve
> the same thing.
> 
> -Carl
> 
> [*] Is the command I have above even correct? What Junio actually
> suggested was:
> 
> 	$ cat >>$HOME/.gitconfig <<\EOF
> 	[branch]
> 		autosetupmerge
> 	EOF
> 
> But I can't find a way to use git-config create a block that looks
> like that. I'm just guessing that "autosetupmerge = true" works
> equivalently, but I could be wildly wrong.
> 
