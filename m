From: dormando <dormando@rydia.net>
Subject: Resurrecting symlink problem
Date: Thu, 22 Jun 2006 16:00:53 -0700
Message-ID: <449B2125.7020402@rydia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 23 01:00:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtYAM-000513-VP
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 01:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161375AbWFVXAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 19:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWFVXAr
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 19:00:47 -0400
Received: from mail.gaiaonline.com ([72.5.72.76]:51138 "EHLO gaiaonline.com")
	by vger.kernel.org with ESMTP id S1161373AbWFVXAr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 19:00:47 -0400
Received: from [66.134.139.190] (account akasindorf HELO [10.50.1.172])
  by gaiaonline.com (CommuniGate Pro SMTP 4.3.6)
  with ESMTPA id 1529618 for git@vger.kernel.org; Thu, 22 Jun 2006 15:48:47 -0700
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22382>

Hey,

We have an issue with cogito/git and not being able to remove symlinks 
from a central remote repo.

First try: cg-rm symlinks*
Complains that I'm trying to delete directories without the -r option. 
So it's resolving the symlinks to the target directory.

git rm -f symlinks*

works. Symlinks are gone, push to repo, everything's happy.

However:

user A git rm -f's the symlinks, pushes to origin
user B cg-update's, then cg-commit's, cg-push's a one line change in an 
unrelated file.

user A cg-update's, and the symlinks come back.

This happens over and over. They appear to disappear if cg-update does a 
fast forward, but not if it does a merge. Any suggestions on how to 
resolve this issue?

I'm still looking at what exactly is going on when user B does that 
cg-update.

Thanks,
-Dormando
