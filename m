From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 01:19:03 +0200
Organization: At home
Message-ID: <f8j795$qfi$1@sea.gmane.org>
References: <630183.45851.qm@web51001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 01:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFI2t-0001Fx-D9
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934431AbXG2XTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934906AbXG2XTM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:19:12 -0400
Received: from main.gmane.org ([80.91.229.2]:45826 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934431AbXG2XTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:19:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFI2X-00027O-Do
	for git@vger.kernel.org; Mon, 30 Jul 2007 01:19:09 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 01:19:09 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 01:19:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54148>

[Cc: Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org]

Please, word wrap lines around 70 - 76 column.

Matthew L Foster wrote:

> Sorry to bring up the time issue again [that I am perhaps still confused
> about] but I have been playing around with git more and I think I can
> phrase my question/observation better. 
> 
> From viewing gitweb.cgi I have observed a situation where Linus creates
> a tag, say rc1, and then he later merges changes but some subset of those
> changes/commits show up in the list in time order as taking place _before_
> the rc1 tag was made even though they were merged after.

Of course. The time ordering is by the time commits were _created_,
not when they were merged.

In git, you can try tu use --topo-order parameter to git-log. In gitweb,
not yet.

> Do I describe a real or possible phenomenon?

Real phenomenon.

> And does this happen because the developer that made the subset of changes
> in question commit them to his/her local repository in time order before
> the rc1 tag was made? So an external repository had the change before the
> rc1 tag was made but Linus' repository didn't?

That's correct. Well, Linus' repository might have had change, but just
not merged in, but that is just small detail.

> But internally git on Linus' machine knows that the 
> gitweb.cgi displayed time order is wrong as far as the state is concerned
> because each repository's index file keeps local track of the true local
> state [just time isn't reconcilable], or am I missing something(s)? 

Git does not know, and git proper has no utility to show for each commit
when it was merged to given branch. And that is even more complicated by
the fast-forward merges. Reflog (local matter, not displayed in gitweb,
available as "git reflog show <branch>" or "git log --show-reflog
[<branch>]" in git) keeps track of the branch tip history; it doesn't offer
information [you think] you want.

> Is it possible for gitweb.cgi to have a new view mode that sorts/displays
> the list based on merge time for commits (the time merged into Linus' or
> whatever repository) so the above situation doesn't happen?  The actual
> time of a local commit should be the time it was merged locally not the  
> time it was created externally/originally, right?

I don't think that it is possible, but you are welcome to try...

> Where can I find the gitweb.cgi source/package?
> I could maybe hack gitweb.cgi myself.

Gitweb is now in the git.git repository, in gitweb/gitweb.perl
(see also gitweb/README and gitweb/INSTALL).
 
> Please CC me on any replies since I am not subscribed to the list.

Please Cc: list.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
