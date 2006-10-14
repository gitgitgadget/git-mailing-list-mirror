From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 14 Oct 2006 22:20:38 +0200
Organization: At home
Message-ID: <egrgqe$1i9$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 14 22:20:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYq07-0006EB-Mc
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 22:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWJNUUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 16:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWJNUUw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 16:20:52 -0400
Received: from main.gmane.org ([80.91.229.2]:42679 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030390AbWJNUUv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 16:20:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYq00-0006DG-GM
	for git@vger.kernel.org; Sat, 14 Oct 2006 22:20:48 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 22:20:48 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 22:20:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28889>

Jon Smirl wrote:

> I was reading Brendan's blog post about Mozilla 2
> http://weblogs.mozillazine.org/roadmap/archives/2006/10/mozilla_2.html

You mean:
 "Oh, and isn't it time that we get off of CVS? The best way to do that
  without throwing 1.9 into an uproar is to develop Mozilla 2 using a new
  Version Control System (VCS) that can merge with CVS (since we will want
  to track changes to files not being revamped at first, or at all; and
  we'll probably find bugs whose fixes should flow back into 1.9). The
  problem with VCSes is that there are too many to choose from now.
  Nevertheless, looking for mostly green columns in that chart should help
  us make a quick decision. We don't need "the best" or the "newest", but we
  do need better merging, branching, and renaming support."

There is work by Jon Smirl and Shawn Pearce on CVS to Git importer which can
manage large and complicated (read: f*cked-up) Mozilla CVS repository.
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#cvs2git

By the way, I'd rather use SCM comparison table on neutral site, not on SCM
site.


I think that Mozilla project should come with it's own set of requirements
and weights for best SCM _for Mozilla project_.

1. Converting existing CVS repository. This should be without data loss...
well, beside data loss that stems from using CVS in first place. "Best" SCM
would have:
  * Tool to convert CVS repository, which can then incrementally import
    changes.
  * It would be nice to have tool to exchange commits between SCM and CVS,
    be it like Tailor/git-svn, or via incremental import and exporting
    commits to CVS like git-cvsexportcommit. This would ease changing SCM,
    as both new SCM and CVS could be deployed in parallel, for a short time
    of course.
  * It would be nice to have CVS emulation like git-cvsserver, so users
    accustomed to CVS could still use it.

2. Good support for system which most important developers use, and good
support for system which most contributors use. If MS Windows is included
in those, then Git perhaps wouldn't be the best choice.

3. Good support for the workflow used in the project. Is it exchanging
patches via email (hello, Git!), having ssh access to some central
repository with central repository to push changes to or net/mesh of
repositories exchanging information, posting patches on some bug tracking
software integrated with SCM. Is it using many branches (topic branches),
or is it using few branches and merging.

But it is equally important to realize what would be the best workflow to
use, not constraining itself to the workflow imposed by limitations of CVS.

4. Good support for _large_ project, with large history. Namely, that
developer wouldn't need to download many megabytes and/or wouldn't need
megabytes of working area. How that is solved, be it partial checkouts,
lazy/shallow/sparse clone, subprojects, splitting into
projects/repositories and having some superproject or build-time
superproject, splitting repository into current and historical... that of
course depends on SCM.

5. ....

and probably few more
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
