From: Adam Soltys <adam.soltys@pwgsc.gc.ca>
Subject: git-svn clone -s fails to setup branches in git if the most recent svn commit was not to trunk
Date: Wed, 14 Jan 2009 21:27:01 +0000 (UTC)
Message-ID: <loom.20090114T211218-628@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 22:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDKn-00031c-Qb
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 22:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbZANVaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 16:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755071AbZANVaJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 16:30:09 -0500
Received: from main.gmane.org ([80.91.229.2]:58989 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbZANVaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 16:30:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LNDJK-0004kI-B0
	for git@vger.kernel.org; Wed, 14 Jan 2009 21:30:03 +0000
Received: from thompson.library.ubc.ca ([137.82.96.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 21:30:02 +0000
Received: from adam.soltys by thompson.library.ubc.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 21:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.82.96.26 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105706>

I ran the following command to clone from an svn repository that followed the
standard svn folder layout and had two branches:

svn clone -s svn://path/to/my_repo

I then typed:

git branch -r

Which returned:

origin/HEAD
origin/master

I was expecting to see the branches and tags from the svn /branches and /tags
folders but they did not appear.  

I checked out origin/HEAD and origin/master to see what was there and I found
they contained code from a subversion branch that was originally in the
/branches folder.  I noticed that this particular branch was the last place
committed to in the svn repo.  So I checked something into the /trunk of the svn
repo, nuked the git repo, and ran the git svn clone command again.  This time it
worked as expected and "git branch -r" showed me all my tags and branches.
