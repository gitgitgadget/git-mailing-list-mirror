From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [RFC/PATCH] Fix git-diff --cached to not error out if HEAD points to a nonexistant branch
Date: Sun, 25 Feb 2007 11:28:49 +0100
Message-ID: <20070225102849.GD3897@xp.machine.xx>
References: <20070224172037.GA31963@xp.machine.xx> <7vvehrw9mz.fsf@assigned-by-dhcp.cox.net> <20070224221622.GA3897@xp.machine.xx> <7vvehqtzns.fsf@assigned-by-dhcp.cox.net> <20070225091302.GB3897@xp.machine.xx> <7vlkimtvsn.fsf@assigned-by-dhcp.cox.net> <20070225102431.GC3897@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 11:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLGZh-00057p-In
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 11:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933689AbXBYKZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 05:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933691AbXBYKZl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 05:25:41 -0500
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:47276 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S933689AbXBYKZk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Feb 2007 05:25:40 -0500
Received: (qmail 28008 invoked by uid 0); 25 Feb 2007 10:25:38 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 25 Feb 2007 10:25:38 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070225102431.GC3897@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40550>

On Sun, Feb 25, 2007 at 11:24:31AM +0100, Peter Baumann wrote:
> On Sun, Feb 25, 2007 at 01:45:44AM -0800, Junio C Hamano wrote:
> > Peter Baumann <waste.manager@gmx.de> writes:
> > 
> > > ..., but in the same sentence you have to say
> > > "Oh, did I mention that it doesn't work until you have made a first commit?"
> > 
> > Well, you do not even have to mention that if you are explaining
> > things correctly.  If something does its thing relative to the
> > latest commit, then it obviously would not work until you have
> > that "latest commit".  There is _no_ initial "empty" commit in
> > git.
> > 
> 
> Yes. I know that there is no empty commit. But at least it's me thinking
> that I start with "nothing" from the beginning.
> 
> But thats how people learn git! I _know_ of three people who just want
> to play with it by creating a new repo with git-init-db (yes, that was
> v1.4.4.4), doing git-add etc and start wondering why git diff didn't
> show what the expected. After mentioning the index they realised that
> they have to specify --cached to diff to get what they want (they have
> used svn). Starting from a freshly initalized repo they played some more
> and actually got _bitten_ by the confussing error message. At least put
> your patch with the sane error message into git, so they would have
> gotten a clou what went wrong if I couldn't convince you otherwise.
> 
> But I _really_ think that making it the same behaviour as in
> "log.showroot = true" to show a diff against an empty tree.
                                                            ^
                                                            |
should be the default  --------------------------------------

> 
> > I think getting people used to that concept early on would
> > actually avoid such confusion.  In that sense,...
> > 
> 
> But people will start using git in newly created repos! You don't want
> to clone the kernel to just see if that new SCM system fits your needs.
> You start by creating some test repos to fool around and later throw
> them away. They did it that way and so was I.
> 
> Not to mention that I think the majority of the users don't even have a
> _need_ to go down to the plumbing commands! At least I am totally happy
> with what the porcelain offers me and I could get all my work done with
> it (commit, diff, rebase, merge, log ...)
> 
> Side note: Not that it matters, but they gave up on git because they found
> it to confusing (remember, it was v1.4.4.4). All those "strange" concepts
> like the index, diff not working as expected and those strange errors ...
> and they actually had some work to do and didn't have the time to fully
> master git, so they staid with svn.
> 
> I'll try to convince them again that git is much
> superiour to svn, after git-core 1.5.0 is available in debian because I
> _know_ the won't bother to compile it themself. For them, a SCM is just
> a tool to get the work done. But with the new git-gui I have convincing
> argument to try git again and it gives them time to acomodate to the
> "new" behaviour of their SCM.
> And obviously the learning curve is now much flatter than in v1.4.x.
> 
> -Peter
> 
> > > The plumbing commands are a diffrent story.
> > 
> > ... I do not think the plumbing should be a different story.
> > Otherwise you would confuse people when they start learning the
> > plumbing.
> > 
> 
> see above
