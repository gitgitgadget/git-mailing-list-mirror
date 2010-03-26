From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: Migrating from SVN
Date: Fri, 26 Mar 2010 12:15:58 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <fkhu77-7hm.ln1@burns.bruehl.pontohonk.de>
References: <aosj77-m7e.ln1@burns.bruehl.pontohonk.de> <20100325062214.GA1829@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 12:16:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv7Wp-0007hH-7G
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 12:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab0CZLQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 07:16:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:38607 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352Ab0CZLQb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 07:16:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nv7Wf-0007bO-Hb
	for git@vger.kernel.org; Fri, 26 Mar 2010 12:16:29 +0100
Received: from bg-1.or.uni-bonn.de ([131.220.141.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 12:16:29 +0100
Received: from bartoschek by bg-1.or.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 12:16:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: bg-1.or.uni-bonn.de
User-Agent: KNode/4.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143223>

Heiko Voigt wrote:

> Import them all seperately into git (e.g. using git svn) and then have a
> look at subtree merge
> 
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-
subtree.html
> 
> to merge them all together. That way you will have seperate lines of
> history for each project and one (or five) big merges on top.
> 
> AFAIK the revision number from svn is stored in the commit message if
> you use git svn so to add the project name you might want to use git
> filter-branch to add that name to each commit before merging the history
> lines.
> 
> That way you will have all the history of the now seperate projects in
> one git repository. Keep in mind that after doing that its not that easy
> to make them seperate projects again.

Thanks for your suggestion. Unfortunately I do not want to have separate 
lines of history. 

For example if the subversion revisions are like this:

rev 0: Initial import
rev 1: Change in project_A
rev 2: Change in project_B
rev 3: Change in project_A
rev 4: Change in project_C

Then I would like to have in git for the product_1 line:

First commit: The commit consists of the initial import.

Second commit: The commit consists of rev 1 of project_A and rev 0 of 
project_B and rev 0 of project_C.

Third commit: The commit consists of rev 1 of project_A and rev 2 of 
project_B and rev 0 of project_C

Fourth commit: The commit consists of rev 3 of project_A and rev 2 of 
project_B and rev 0 of project_C.

Fifth commit: The commit consists of rev 3 of project_A and rev 2 of 
project_B and rev 4 of project_C.

This does not yet include branches. But how can I get a history like that in 
git?

A similar line of history would appear for product_2 and when they are 
merged, I can use a subtree merge as sugested to combine them. 

Christoph
