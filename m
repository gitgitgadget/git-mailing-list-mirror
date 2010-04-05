From: Stephen Kelly <steveire@gmail.com>
Subject: How to keep different version numbers in different branches?
Date: Mon, 05 Apr 2010 16:34:07 +0200
Message-ID: <hpcscv$umg$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 05 16:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NynNg-0005Uz-4I
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 16:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab0DEOeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 10:34:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:52842 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915Ab0DEOeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 10:34:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NynNY-0004ue-MG
	for git@vger.kernel.org; Mon, 05 Apr 2010 16:34:16 +0200
Received: from dslb-188-103-017-106.pools.arcor-ip.net ([188.103.17.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 16:34:16 +0200
Received: from steveire by dslb-188-103-017-106.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 16:34:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-188-103-017-106.pools.arcor-ip.net
User-Agent: KNode/4.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143985>


Hi,

My project uses git and so far has only one branch, 'master'.

http://gitorious.org/grantlee/grantlee

I want to make a 0.1 release, so that would mean creating a 0.1 branch and 
updating files contained in the branch such as the README file and the CMake 
files and the api documentation to report version 0.1.0, and creating the 
0.1.0 tag. The next tag on that branch would be 0.1.1 etc. Simultaneously, 
the version number in those files is changes to 0.2.0 in the master branch.

However, now I have changes in my maintenance branch (0.1) which should not 
be merged into master (that is, the commits which change the version 
number). 

How are you supposed to handle that with git? Simply merge and resolve the 
conflict on master by keeping its version number? Am I missing some other 
way of doing it here?

Additionally, I have some stuff currently in master that should not be in 
the 0.1 release, but should be in the 0.2 release. If I branch and then 
remove those files from the 0.1 branch, a merge will then remove them from 
master too? How do I keep them on master but delete them on 0.1 and still be 
able to merge from 0.1 into master?

The only option I can think of are to do the merge, then revert the commit 
sha on master that does the delete.

Is that the recommended way of doing this? I have read the git workflows 
page, but it doesn't seem to cover either of these scenarios.

http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html

Thanks,

Steve.
