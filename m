From: =?utf-8?b?SnVsacOhbg==?= Landerreche <maniqui@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Sat, 8 Oct 2011 22:55:22 +0000 (UTC)
Message-ID: <loom.20111009T000812-294@post.gmane.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 01:00:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCfsT-0005nt-UY
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 01:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab1JHXAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 19:00:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:40330 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025Ab1JHXAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 19:00:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RCfsD-0005g9-NC
	for git@vger.kernel.org; Sun, 09 Oct 2011 01:00:06 +0200
Received: from 190-172-2-200.speedy.com.ar ([190-172-2-200.speedy.com.ar])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 01:00:05 +0200
Received: from maniqui by 190-172-2-200.speedy.com.ar with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 01:00:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 190.172.2.200 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Chrome/9.0.597.45 Safari/534.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183178>

Jay wrote:

> I guess it depends what you mostly use your workdirs for. For me, it's 
> to have different branches checked out, not to have the same branch
> checked out in multiple locations. 

I find those both use cases for workdirs to fit perfectly in my usual workflow 
(web development).

- Different branches checked out
I've a cloned repo of a CMS and I use git-new-workdir to checkout different 
branches and tags, so to have available a few workdirs of recent versions, which 
I "attach" by symlinks to my web development projects.

- Same branch checked out in multiple locations
This use case just came up recently, when I find out that I prefer to have two 
websites "attached" (via symlink) to two different workdirs of the same branch.
I could have "attached" both websites to the same workdir, but my idea of having 
the websites "attached" to different workdirs was to be able to do some 
development (i.e: to commit stuff) on one workdir, while keeping the other one 
"fixed" at some particular commit. 

Juno wrote:

> Careful. Git has survived without your patch series till now, as people
> learned to be careful when they use separate workdirs and avoid certain
> things, to the point that they are not necessarily aware that they are
> avoiding them (one good practice is to keep the HEADs of non-primary
> workdirs detached).

Jay wrote:

> Also, while I might recommend new-workdir to my coworkers with the
> advice "don't checkout the same branch in multiple workdirs", never in
> a million years would I say "use new-workdir, but make sure to only
> use a detached HEAD in the workdirs." The latter would make their
> actual HEADs explode. 

After reading this, I noticed that using git-new-workdir with detached HEAD in 
each workdir could fit my workflow very well. In some cases (the ones mentioned 
above), I find that I may not need to have a workdir for a branch (where I won't 
do work, so won't be committing there), but rather to have that workdir "fixed" 
at a particular commit. 
That being said, I also see that I would find useful to be able to 
update/advance this workdir (in a detached HEAD state, that is, "fixed" at an 
specific commit) to a newer commit or to a particular branch.

Bottom line: making git-new-workdir a more reliable & friendly tool that could 
fit in the workflows of both advanced and non-advanced users.

-----
Quick note about me: I am an "advanced n00b" on git usage (using it since one 
year ago), and a general non-advanced user (of git and git-new-workdir). In 
other words, a git user that could easily shoot itself in the foot.

Arrived here while looking for some info about git-new-workdir, and if it was a 
Bad Idea to have different workdirs of the same branch (ie. checkout the same 
branch on different folders), as the idea of recklessly committing on different 
workdirs for the same branch sounded like a recipe for disasters to me.

I find it git-new-workdir a really useful tool in my workflow, and prefer it 
over having many clones of the same repo, which will imply having to do 
configuration for remotes and push/pull operations, which are also mind-boggling 
tasks for non-advanced users.
-----

Thanks for reading.
