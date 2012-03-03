From: snk <shank76@gmail.com>
Subject: Re: preserve permissions?
Date: Sat, 3 Mar 2012 11:05:30 -0800 (PST)
Message-ID: <1330801530552-7340464.post@n2.nabble.com>
References: <C1288762-C750-4919-A853-5E3229870A59@btinternet.com> <m3fx27g6i8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 20:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3uH0-0008H6-1u
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 20:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab2CCTFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 14:05:31 -0500
Received: from sam.nabble.com ([216.139.236.26]:53429 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab2CCTFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 14:05:31 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <shank76@gmail.com>)
	id 1S3uGo-0003Be-I8
	for git@vger.kernel.org; Sat, 03 Mar 2012 11:05:30 -0800
In-Reply-To: <m3fx27g6i8.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192130>

> Therefore git does not store ownership, and only basic permissions 
> (only executable bit for ordinary files, and the symlink bit). 

Fine.  "git diff" reports wrong new permissions though: 755 instead of 764. 

shanker@linux-0tix:~/test/play2> git reset --hard HEAD
HEAD is now at 85d4483 test
shanker@linux-0tix:~/test/play2> git config core.filemode
true
shanker@linux-0tix:~/test/play2> ls -l x
-rw-rw-r-- 1 shanker users 0 Mar  3 11:00 x
shanker@linux-0tix:~/test/play2> chmod u+x x
shanker@linux-0tix:~/test/play2> git diff x
diff --git a/x b/x
old mode 100644
new mode 100755
shanker@linux-0tix:~/test/play2> ls -l x
-rwxrw-r-- 1 shanker users 0 Mar  3 11:00 x
shanker@linux-0tix:~/test/play2> 


--
View this message in context: http://git.661346.n2.nabble.com/preserve-permissions-tp5003065p7340464.html
Sent from the git mailing list archive at Nabble.com.
