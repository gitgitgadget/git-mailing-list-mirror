From: Alfred Perlstein <alfred@freebsd.org>
Subject: [PATCH] git-svn: Support for propset
Date: Sun, 30 Nov 2014 22:23:49 -0800
Message-ID: <20141201062349.GE99906@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 07:29:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvKTh-00019D-2O
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 07:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaLAG2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 01:28:52 -0500
Received: from elvis.mu.org ([192.203.228.196]:15056 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbaLAG2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 01:28:52 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Dec 2014 01:28:52 EST
Received: by elvis.mu.org (Postfix, from userid 1192)
	id 3F39F341F84F; Sun, 30 Nov 2014 22:23:49 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260472>

Hello folks,

I have resurrected the code submitted by David Fraser to facilitate
git-svn to set properties on files.

This is my very first patch submission to git(1) so please be gentle.

I have tried my best to abide with all the instructions located
here:

https://github.com/git/git/blob/master/Documentation/SubmittingPatches

I've cc'd the top 4 people who have been active in the area:
~/git/git % git log --since '2010-01-01' git-svn.perl |grep Author | sort  | uniq -c | sort -n | tail -4
   6 Author: Eric Wong <normalperson@yhbt.net>
   9 Author: Jonathan Nieder <jrnieder@gmail.com>
  13 Author: Junio C Hamano <gitster@pobox.com>
  19 Author: Michael G. Schwern <schwern@pobox.com>
And of course: git@vger.kernel.org

We (FreeBSD) and my company that uses FreeBSD are starting to use
git-svn to collaborate with each other, however our (FreeBSD's)
central repo is subversion and requires us to set properties in
order to commit.  This change would be tremendously helpful for a
number of us in order to cut overhead of the git<->subversion bridge.
Effectively with this patch we can commit directly to FreeBSD and
FreeBSD ports using git.

The next email should have the patch in format that is consumable 
by "git am" when applied against the master branch.

I have been testing this and have done a number of commits directly
to FreeBSD kernel and FreeBSD ports (packages) system using this
patch successfully.

Alfred Perlstein (1):
  git-svn: Support for git-svn propset

 git-svn.perl           | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 perl/Git/SVN/Editor.pm | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.1.2
