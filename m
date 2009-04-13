From: "David E. Wheeler" <david@kineticode.com>
Subject: Again with git-svn: File was not found in commit
Date: Mon, 13 Apr 2009 11:08:05 -0700
Message-ID: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:18:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQji-0004sE-94
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbZDMSQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZDMSQx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:16:53 -0400
Received: from host-201.commandprompt.net ([207.173.203.201]:36497 "EHLO
	smtp.kineticode.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbZDMSQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:16:52 -0400
Received: from [192.168.1.120] (c-76-105-135-51.hsd1.or.comcast.net [76.105.135.51])
	by smtp.kineticode.com (Postfix) with ESMTPSA id 6D6E9508059
	for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:07:30 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116459>

Hello Gits,

I'm looking to migrate [Bricolage][] from Subversion to Git. As such,  
I'm running `git svn` to create a git repository for the Bricolage  
repository. I moved the files around in Subversion quite a while ago  
(the trunk, branches, and tags directories used to be at the root, but  
now they're under a "bricolage" subdirectory), so there's a fair  
amount of duplication, but I don't mind that, because I can prune  
those dupes.

[Bricolage]: http://bricolage.cc/

So I ran `git svn` like so:

     md brictmp
     cd brictmp
     git svn init http://svn.bricolage.cc/bricolage --no-metadata -s
     git config svn.authorsfile ~/Desktop/bricolage_committers.txt
     git svn fetch

After around 30 hours of the fan running full tilt on my MacBook Pro,  
creating 343 branches (yeah, we have a lot of tags), `git svn` exited  
with this error:

     bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm was not  
found in commit
     e5145931069a511e98a087d4cb1a8bb75f43f899 (r5256)

This seemed strange to me, so I had a look at SVN:

     svn list -r5256 http://svn.bricolage.cc/bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm
     ApacheConfig.pm

So the file *is* there in that revision. I had been running 1.6.1.2,  
so I upgraded to 1.6.2.2 and ran `git svn fetch` again to see if it  
would pick up where it left off, but it returned the same error  
(please don't tell me I have to start over!).

I see that this issue has come up [before][], earlier this year; has  
there been any progress on it? Is there perhaps something I can do to  
get this working?

[before]: http://lists-archives.org/git/677591-git-svn-file-was-not-found-in-commit.html

Many thanks,

David
