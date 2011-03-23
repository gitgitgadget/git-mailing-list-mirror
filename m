From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git merge strategy for cherry picks
Date: Wed, 23 Mar 2011 13:06:20 -0600
Message-ID: <4D8A44AC.20505@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 20:06:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2TO2-000429-OF
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 20:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511Ab1CWTGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 15:06:25 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:56079 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab1CWTGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 15:06:24 -0400
Received: (qmail 3951 invoked by uid 399); 23 Mar 2011 13:06:20 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@50.8.99.117)
  by hsmail.qwknetllc.com with ESMTPAM; 23 Mar 2011 13:06:20 -0600
X-Originating-IP: 50.8.99.117
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b3pre Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169869>

In this thread, the question was asked about a merge with cherry picks 
and the reapplication of lines that had been removed: 
http://kerneltrap.org/mailarchive/git/2010/2/19/23857/thread

Consider this scenario:

     line line  line re-added
      +    -    +!!
A -- B -- C -- F  master
   \  |        /
    - B' --...-    milestone


I branch the milestone branch from A.

There is a fix, B, that needs to go in the milestone.  I cleanly 
cherry-pick it as B'; there are no conflicts.

The fix is decided to be bad and is removed in C.

Later, I merge the milestone branch back to master.  The B 'fix' is 
re-added without conflict.

How can I correctly merge milestone into master without reintroducing 
the B 'fix'?

In contrast, if I run, say, 'gitk --cherry-pick master...milestone', I 
see that B' is not considered a difference between master and milestone.

Thanks.

Josh
