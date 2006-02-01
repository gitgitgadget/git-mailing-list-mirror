From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Question around git-shell usage in Everyday Git
Date: Wed, 1 Feb 2006 23:01:55 +0000
Message-ID: <200602012301.56141.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 02 00:04:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4QzA-0006uZ-Pp
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 00:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423006AbWBAXB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 18:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423008AbWBAXB5
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 18:01:57 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:22189
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1423006AbWBAXB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 18:01:57 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F4Qz6-0008Ep-Bh
	for git@vger.kernel.org; Wed, 01 Feb 2006 23:01:56 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15462>

In the Repository Administrator section of the Everyday Git document it shows 
how to allocate accounts to developers so that you can have fine grained 
control over access to the repository (I assume it is because of that.  
Otherwise I assume you would do what I have done, and that is create a "git" 
user, with a home directory where you want to locate your repositories and 
then tell your users to put the following sort of entry in .git/remotes/xxx

URL:git@host.com:repository.git

and in ~git/.ssh/authorized_keys putting all the developers public keys.

).  But the example shows creating independant home directories for each of 
the developers - but then limiting their access by giving them git-shell as 
their shell.

I assume they would then user a .git/remotes entry of the form
URL:host.com:/absolute/path/to/repositories

My question, in this case is there any reason (such as git creating home 
directoriy temp files or something) why each developer could not have their 
home directory as the root of all the repositories (ie where my git user in 
the above example had its home directory).

This would then mean each user (unless he had a real account on that machine) 
would then use the following in .git/remotes

URL:host.com:repository.git

Which has the advantage of not revealing exactly where on your filesystem you 
have chosen to store the repository (or more precisely allowing you to move 
it without all users having to change their.git/remotes urls)


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
