From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Sharing a massive distributed merge
Date: Wed, 16 Mar 2011 14:12:46 -0600
Message-ID: <4D8119BE.2090208@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:13:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzx5S-0003of-He
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab1CPUMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 16:12:49 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:38799 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab1CPUMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:12:48 -0400
Received: (qmail 24790 invoked by uid 399); 16 Mar 2011 14:12:46 -0600
Received: from unknown (HELO ?192.168.1.12?) (jjensen@workspacewhiz.com@50.8.99.117)
  by hsmail.qwknetllc.com with ESMTPAM; 16 Mar 2011 14:12:46 -0600
X-Originating-IP: 50.8.99.117
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b3pre Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169187>

We have two codelines that diverged quite a while back, and we are now 
bringing them back together.  More than 800 files are in conflict, but 
it is very possible that the automatic non-conflicting merge is not 
correcting.  This means thousands of files need to be examined.

Git doesn't support distribution of a merge (although that would be 
extraordinarily cool), so the next best thing seemed to be force adding 
all files with conflict markers and then committing the merge.  We then 
publish the conflicting branch and have each person fix their files.  
Given that the conflict markers are already in place, they can't use 
their favorite graphical merge tool.

What I want to be able to do is have each person perform the merge 
locally, stage only the files they care about in that session, reset all 
other files, and commit as a regular commit, not a merge commit.  The 
user can take advantage of whatever tools they want in the in progress 
merge.  When everyone has finished this process, we run git merge and 
keep our local changes.

I have had no success in doing the above.  Is there a fancy way to pull 
this off with Git?

Thanks.

Josh
