From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Re: git subtree merging with a SVN remote?
Date: Sun, 18 Sep 2011 11:00:26 -0700
Message-ID: <87ipop4tol.fsf@an-dro.info.enstb.org>
References: <j550cl$218$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 20:10:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Lon-0005gk-TB
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab1IRSKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 14:10:05 -0400
Received: from service.cri.ensmp.fr ([86.65.170.33]:49393 "EHLO
	arnac.cri.ensmp.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755815Ab1IRSKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 14:10:04 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Sep 2011 14:10:04 EDT
Received: from an-dro.info.enstb.org (hendaye.cri.ensmp.fr [10.2.14.177])
	by arnac.cri.ensmp.fr (Postfix) with ESMTP id 25D692003A1;
	Sun, 18 Sep 2011 20:00:26 +0200 (CEST)
In-Reply-To: <j550cl$218$1@dough.gmane.org> (Manuel Reimer's message of "Sun,
	18 Sep 2011 16:44:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181616>

>>>>> On Sun, 18 Sep 2011 16:44:33 +0200, Manuel Reimer <Manuel.Spam@nurfuerspam.de> said:

    Manuel> Hello, I want to use "subtree merging" to get stuff from an
    Manuel> external SVN repo into my project.

    Manuel> Is it possible to do this directly using the external SVN
    Manuel> server or should I set up a GIT mirror of this SVN repo?

I guess you can move *manually* the files from the SVN repository into
the git repository directly. :-)

More seriously, if you want to automate things, you have to go through a
git svn clone process.

    Manuel> Is this "subtree merging" a pure local thing or do I push
    Manuel> some information about this to the central GIT server?

Since the concept of central git server is a pure convention, you can
rely only on your local git repository only.

For a compiler project, I use these kinds of tricks to subtree 5
upstream svn projects with the ability to apply on top of them some
local commits, for example to avoid some upstream errors (it has just
happened last Friday :-( ).

Having all this operational is a little bit tedious, so I've developed
scripts to have all the infrastructure running and easy to be updated.

You may read
http://download.par4all.org/doc/organization/par4all_organization.htdoc/par4all_organization.html#x1-240007
or the PDF version and look at the p4a_git command I use to run this process:
https://git.hpc-project.com/cgit/par4all/tree/src/dev/p4a_git?h=p4a-own
https://git.hpc-project.com/cgit/par4all/tree/src/dev/p4a_git_lib.bash?h=p4a-own
and there are also some scripts around in the same directory to
bootstrap the infrastructure.

If you want to look at the resulting project history, study the p4a
branch from the Par4All project.

I've found this very powerful and efficient... once it is correctly
set up. :-)

I hope that helps,
-- 
  Ronan KERYELL                      |\/  Cell:   +33 613 143 766
  HPC Project, Inc.                  |/)  Ronan.Keryell@hpc-project.com
  5201 Great America Parkway #3241   K    skype:keryell
  Santa Clara, CA 95054              |\   http://hpc-project.com
  USA                                | \
