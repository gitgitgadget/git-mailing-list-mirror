From: Bosko Ivanisevic <ivanisev@sezampro.com>
Subject: Git and git-svn question.
Date: Fri, 28 Mar 2008 08:53:00 +0100
Message-ID: <47ECA3DC.8010901@sezampro.com>
Reply-To: ivanisev@sezampro.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 12:16:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfCZI-0004ep-JS
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 12:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbYC1LPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 07:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbYC1LPh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 07:15:37 -0400
Received: from mail1.sezampro.yu ([77.105.0.23]:1289 "HELO intel.sezampro.yu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752109AbYC1LPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 07:15:36 -0400
X-Greylist: delayed 12141 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 07:15:36 EDT
Received: from ivanisev@[89.216.110.224] [89.216.110.224] (authenticated as ivanisev) by SezamPro with SMTP; Fri, 28 Mar 2008 08:53:06 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78394>

My company uses SVN and I have to work on the code from two offices. 
Since SVN is far away from git in branching I've decided to set up git 
repository as a mirror of company's SVN repo, which I would use as 
intermediate repository for my code:

git svn clone -t tags -b branches -T trunk 
svn+ssh://company_server/path_to_svn_repo --prefix=company/

Since I just started to use git I wonder if anyone can give me any hint
what is the best way to accomplish following tasks with git:

- In office 1 and office 2 I clone git repository that is a mirror of SVN:
   git clone ssh://company_server/path_to_git_repo

- I start new feature in office 1 based on the trunk version of SVN:
   git checkout -b new-feature company/trunk
	
- Work on this feature is not finished and, after few commits to the 
local 'new-feature' branch, I have to move to office 2.

- From office 1 I push local branch 'new-feature' to the git repository 
on company server.

- In office 2 pull changes and continue to work on 'new-feature' branch 
created from office 1.
	
- Commit everything in the git repository on company's server.

- Finally commit everything to the SVN repository.
