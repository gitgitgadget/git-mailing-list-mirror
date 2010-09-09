From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Coping with the pull-before-you-push model
Date: Wed, 08 Sep 2010 22:47:53 -0600
Message-ID: <4C8866F9.1040705@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 06:48:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtZ3H-0002Cv-Nd
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 06:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab0IIErz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 00:47:55 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:38802 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab0IIEry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 00:47:54 -0400
Received: (qmail 14792 invoked by uid 399); 8 Sep 2010 22:47:53 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 8 Sep 2010 22:47:53 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155838>

  After a deployment of Git on a centralized server at my place of 
business, the largest amount of grumbling has been with the 
pull-before-you-push model.  Coming from the file-centric Perforce where 
you need only have latest of just the files you are submitting, the 
pull-before-you-push model has really been a pain in the neck for a 
large team.

Even with topic branches being used, merges to master occur frequently.  
It can really be a frustrating battle to get your merged branch pushed 
to the central master branch.  In the time it took you to pull, test, 
and push, someone has probably already pushed before you.  To cope with 
this, people will pull, not bother testing, and immediately push their 
changes.  Yes, this could result in build instability, but it is 
considered better than never being able to make your change live.

(Let's ignore what we should or shouldn't be doing as far as 
'development practices'.  :)  We're solving the problems one step at a 
time...)

Gerrit provides a compelling model where branches are pushed to the code 
review server in the form refs/for/master, and the given push will 
always succeed.  Code reviews are performed, someone sets the verified 
bit, and the change is submitted and merged to master by Gerrit itself 
in a queued fashion.  Unfortunately, its general "requirement" to squash 
your branch down to a single commit is, possibly, a showstopper.  If it 
treated a branch merge as a group of commits that MUST stay together, 
that would be perfect.

What other tools are out there that would let users successfully push 
their branch to the server (without having the HEAD master commit), and 
the push would be automatically merged to the master branch?

Is there another workflow that is successful for your large(-ish) 
enterprise team?

Thanks for your insights!

Josh
