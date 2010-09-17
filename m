From: Chris Frey <cdfrey@foursquare.net>
Subject: git-svn, git-submodule, and svn externals
Date: Fri, 17 Sep 2010 01:28:44 -0400
Message-ID: <20100917052844.GA13321@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 17 08:31:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwUTZ-0000px-QM
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 08:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab0IQGbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 02:31:05 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:48487 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab0IQGbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 02:31:04 -0400
X-Greylist: delayed 3736 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2010 02:31:04 EDT
X-Originating-Ip: 216.16.235.2
Received: from localhost (nic.NetDirect.CA [216.16.235.2])
	by rubicon.netdirect.ca (8.13.8/8.13.8) with ESMTP id o8H5SibX013604
	for <git@vger.kernel.org>; Fri, 17 Sep 2010 01:28:44 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156371>

Hi,

I'm struggling to find a clean way to manage a SVN project in git.
This SVN project consists of a library, an app, and numerous plugins.
Each of these has its own svn repo.  Each repo has an external
with common build checks.

1) I'd like to find a way to track one svn project, including its
	external, and be able to dcommit to it without worrying about
	the submodule commit.

	Right now I have a git repo that tracks the svn external
	and a repo that tracks, for example, the library.
	I combine them with git-submodule, and therefore have a
	commit in the tree for the .gitmodule file and submodule
	directory.

	Each time I want to git svn dcommit, I create a new branch,
	rebase it onto master without the .gitmodule commit, and
	dcommit.  There's gotta be a better way.

2) Ideally, I would like to combine the library and all the modules
	in a single git repo that I can type 'make' at the root and
	build everything.  It would be nice if I could do development
	in this meta tree, and commit to each various separate repo.
	The commits eventually have to make their way back to their
	separate SVN repos.

3) I'd like to share my git repo, so that people who want to use git,
	can use git, and not have to futz about with tracking SVN.


What technology springs to mind when you read these requirements? :-)

Thanks in advance,
- Chris
