From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: switching branches when they use different submodule remotes
Date: Fri, 8 Apr 2011 13:52:16 -0400
Message-ID: <p0624080dc9c4f8ff178c@[192.168.1.122]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 20:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8G0Q-0001DD-CZ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011Ab1DHSB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 14:01:57 -0400
Received: from deanbrook.org ([72.52.70.192]:47224 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756674Ab1DHSB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 14:01:56 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Apr 2011 14:01:56 EDT
Received: from ::ffff:108.8.209.231 ([108.8.209.231]) by deanbrook.org for <git@vger.kernel.org>; Fri, 8 Apr 2011 10:52:22 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171139>

I was confused earlier today when I switched branches in a repo with libgit2 in a submodule.

I knew that the different branches used different remotes for the submodule -- one remote is older, the other remote has newer 
development.

   git://github.com/pieter/libgit2.git
   git://repo.or.cz/libgit2.git

so when I switched I deleted the whole libgit2 dir and ran:

   git submodule init
   git submodule update

I was switching to the branch that referenced git://github.com/pieter/libgit2.git and
I was surprised the newer branch was cloned instead.

Looking at the doc for git submodule:

   http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html

it made it clear that executing init does not alter existing information in .git/config so I deleted the reference in 
./git/config manually and started over.

Is there a better way to handle this?
