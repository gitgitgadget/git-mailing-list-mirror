From: bob <kranki@mac.com>
Subject: fatal: serious inflate inconsistency
Date: Fri, 9 Nov 2007 09:14:24 -0500
Message-ID: <6C571F0D-442F-49B9-8CF8-D7DACB41FC1A@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 15:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUiv-0004ak-0d
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759719AbXKIOUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759248AbXKIOUW
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:20:22 -0500
Received: from smtpoutm.mac.com ([17.148.16.71]:59065 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758614AbXKIOUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:20:21 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2007 09:20:20 EST
Received: from mac.com (asmtp005-s [10.150.69.68])
	by smtpoutm.mac.com (Xserve/smtpout008/MantshX 4.0) with ESMTP id lA9EEXpn001764
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 06:14:33 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp005/MantshX 4.0) with ESMTP id lA9EEUdL001252
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 06:14:31 -0800 (PST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64188>

	From: 	  kranki@mac.com
	Subject: 	fatal: serious inflate inconsistency
	Date: 	November 8, 2007 10:56:02 PM EST
	To: 	  majordomo@vger.kernel.org

Hi, list.

Sorry, but I am not that familiar with git's internal workings,
but here is a failure that I can consistently create.  I am
running MacOSX 10.4.10 with git compiled from source.
Here is the problem output that I am receiving:

apple07:~/rmwHtmlOld bob$ git version
git version 1.5.3.5
apple07:~/rmwHtmlOld bob$ git init
Initialized empty Git repository in .git/
apple07:~/rmwHtmlOld bob$ git add .
apple07:~/rmwHtmlOld bob$ git commit --all
Created initial commit 49b4183:   Initial commit
10993 files changed, 3615639 insertions(+), 0 deletions(-)
create mode 100644 .gitignore
create mode 100755 bk.sh
.
.
.
create mode 100755 ter/webalizer/webalizer.hist
apple07:~/rmwHtmlOld bob$ cd ..
apple07:~ bob$ mkdir rmwHtml.git
apple07:~ bob$ cd rmwHtml.git/
apple07:~/rmwHtml.git bob$ git --bare init --share
usage: git-init [-q | --quiet] [--template=<template-directory>] [-- 
shared]
apple07:~/rmwHtml.git bob$ git --bare init --shared
Initialized empty shared Git repository in /Users/bob/rmwHtml.git/
apple07:~/rmwHtml.git bob$ git --bare fetch ../rmwHtmlOld master:master
warning: no common commits
remote: Generating pack...
remote: Done counting 11402 objects.
remote: Deltifying 11402 objects...
remote:  100% (11402/11402) done
Indexing 11402 objects...
100% (11402/11402) done
Resolving 3356 deltas...
fatal: serious inflate inconsistency
remote: Total 11402 (delta 3356), reused 0 (delta 0)
fatal: index-pack died with error code 128
fatal: Fetch failure: ../rmwHtmlOld
apple07:~/rmwHtml.git bob$

The ... represent about 11,000 files that I did not feel needed to be  
included.
The total directory being put in the repository is about 4gig.

There are two files that are about 1.0gig each.  I had them as one which
in MacOSX 10.4.10 showed as 1.88gig and think that this may be the
problem, but don't know why since my searches show that git should
handle files up to 2gig.  If I am wrong and there is a lesser limit,  
then
I apologize.

I have this directory, rmwHtmlOld, saved as a tarball and can recreate
the above as needed.

I apologize if I am doing something wrong that I am not aware of.
I use git for several different projects and have no problem with them.
I would appreciate any help that you can provide.  Thank you for
your time.
