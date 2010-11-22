From: denny@dennymagicsite.com
Subject: Git branch workflow
Date: Mon, 22 Nov 2010 17:08:05 +0000
Message-ID: <20101122170805.8jtzkqwxpcog0kgk@dennymagicsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 01:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKgkI-0007QT-Gz
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 01:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583Ab0KWA2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 19:28:14 -0500
Received: from server02.webhostingbuzz.com ([74.81.65.178]:43157 "EHLO
	server02.webhostingbuzz.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932574Ab0KWA2L convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 19:28:11 -0500
X-Greylist: delayed 26434 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2010 19:28:11 EST
Received: from localhost ([127.0.0.1])
	by server02.webhostingbuzz.com with esmtpa (Exim 4.69)
	(envelope-from <denny@dennymagicsite.com>)
	id 1PKZs5-0005hj-St
	for git@vger.kernel.org; Mon, 22 Nov 2010 17:08:06 +0000
Received: from 65.203.93.8 ([65.203.93.8]) by dennymagicsite.com (Horde
	MIME library) with HTTP; Mon, 22 Nov 2010 17:08:05 +0000
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server02.webhostingbuzz.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dennymagicsite.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161921>

my website was small enough where I usually fixed everything live on  
production server, including adding new features, doing bug fixes and  
so on.

Now, with git I can create branches in whatever order I want, and then  
merge them whenever I want and push things to production whenever I  
want.
With this, comes confusion of what a good branch workflow is.  And  
this will be my question -- in what order and from which branches to I  
create new branches and how do I merge them back.

Consider a specific scenario:
I am on dev server on master branch and I want to develop a specific  
feature F.
I cut a Feature branch F from master and start working on the feature.  
  Once I am done with most of the work on F and it works reasonably  
well, I want to push it to production, but .. before I do I realize  
that I want to make some CSS fixes to the site, unrelated to other  
branches, and I can wait with pushing Feature branch to Production  
until I fix up CSS reasonably well.
Here is the question:  do I cut the CSS branch from Master or do I cut  
it from the Feature branch?

If I want to keep close to my original before-git workflow, I say, either
*  merge Feature with Master
*  cut CSS branch from Master
*  do CSS fixes
*  merge CSS with Master
*  push Dev Master to Prod Master

or
*  cut CSS branch from Feature, as Feature already has latest code
*  when I am done with CSS, merge CSS into Feature
*  merge Feature into Master (and remove Feature)
*  push Dev Master to Prod Master

There are tons of other variations that are possible.  Which workflow  
is preferred for this scenario?

Supplementary questions that may help define a good workflow for my case:
*  What if later a bug is discovered in the Feature.  If I already  
merged Feature branch into Master and deleted Feature branch, do I  
create a FeatureBugFix branch?  Or do I keep the original Feature  
branch without removing it for a while?  If so, for how long do I keep  
it?  Do I perhaps keep a general BugFix branch instead that I don't  
remove?
*  currently I am the only developer working on the code.  This will  
not change in the forseeable future.

Dennis
