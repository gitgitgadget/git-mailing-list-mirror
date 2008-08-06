From: Steven Grimm <koreth@midwinter.com>
Subject: git blame and cherry-picking
Date: Wed, 6 Aug 2008 15:18:33 -0700
Message-ID: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Users List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 00:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQrM1-00027w-Pe
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 00:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYHFWSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 18:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYHFWSf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 18:18:35 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58489 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753366AbYHFWSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 18:18:34 -0400
Received: (qmail 16576 invoked from network); 6 Aug 2008 22:18:34 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=JVsTPuxhh84JFX47cmUerSx5b1pCIwXOgWA79Aqf5GA8KYnf9yRz+iWAdohyzxL/  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 6 Aug 2008 22:18:34 -0000
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91546>

What, if any, is the approved way to get git blame to follow cherry- 
picked changes? Right now blame is good about showing you the actual  
responsible revision and author in the case of merges, but if you  
cherry-pick a change with "-n" (to test before committing), the  
modifications are attributed to the person who did the cherry-pick  
instead of the cherry-picked revision's author. Even without the "-n"  
option, the changes are attributed to the cherry-pick *revision*  
instead of the original one.

My horrible hack workaround for now is to temporarily put a grafts  
entry in place to make git think the cherry-pick revisions I'm  
interested in are actually merges. That requires me to know that a  
given revision is a cherry-pick and I have to be careful to remove my  
fake graft afterwards. What's more, it can result in some strange and  
seemingly nonsensical "merge" topologies if, e.g., a newer change is  
cherry-picked before an older one.

Surely there must be a better way...?

-Steve
