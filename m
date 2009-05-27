From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: git log missing last line of output
Date: Wed, 27 May 2009 12:17:09 -0500
Message-ID: <gvjsc9$f40$1@ger.gmane.org>
References: <gvhrtf$vpr$1@ger.gmane.org> <4A1D5F70.4030101@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 19:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Mhl-00015H-4Z
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 19:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbZE0ROH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbZE0ROF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 13:14:05 -0400
Received: from main.gmane.org ([80.91.229.2]:33451 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754764AbZE0ROD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 13:14:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M9MhX-0002J8-OH
	for git@vger.kernel.org; Wed, 27 May 2009 17:14:03 +0000
Received: from 216-60-24-100.rsss.biz ([216.60.24.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2009 17:14:03 +0000
Received: from neal by 216-60-24-100.rsss.biz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2009 17:14:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 216-60-24-100.rsss.biz
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120079>

Here is a 'copy and paste' of a testcase scenario that I recreated/executed 
in response to your reply (with comments added):

***CREATE NEW PROJECT SOURCE***
$ mkdir tstcase1
$ cd tstcase1
$ vi file1
$ cat file1
test1
***MAKE IT A GIT REPO***
$ git config --global user.name 'tstuser1'
$ git config --global user.name 'tstuser1@tstuser.com'
$ git config --list
user.name=tstuser1
user.email=tstuser1@tstuser.com
$ git init
Initialized empty Git repository in .git/
$ git add .
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file: file1
#
***INITIAL COMMIT***
$ git commit

initial commit
# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file: file1
#
~
~
~
~
~
~
~
~
~
~
~
".git/COMMIT_EDITMSG" 12L, 262C written
Created initial commit bee2e0f: initial commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file1
***FIRST MODIFICATION TO REPO***
$ vi file1
$ cat file1
test1 mod1
$ git add file1
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   file1
#
***FIRST COMMIT AFTER INITIAL COMMIT***
$ git commit

1st commit after initial commit
# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   file1
#
~
~
~
~
~
~
~
~
~
~
~
~
~
~
".git/COMMIT_EDITMSG" 9L, 259C written
Created commit 9f9ed56: 1st commit after initial commit
 1 files changed, 1 insertions(+), 1 deletions(-)
***MODIFY THE REPO AGAIN FOR GOOD MEASURE***
$ vi file1
$ cat file1
test1 mod2
$ git add file1
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   file1
#
***SECOND COMMIT AFTER INITIAL COMMIT***
$ git commit

2nd commit after initial commit
# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   file1
#
~
~
~
~
~
~
~
~
~
~
~
~
~
~
".git/COMMIT_EDITMSG" 9L, 259C written
Created commit 7317049: 2nd commit after initial commit
 1 files changed, 1 insertions(+), 1 deletions(-)
$ clear

***EXECUTE GIT LOG***
$ git log






















commit 73170498d68a0011b37d7ee095bf88b8dcb6fbb5
Author: tstuser1 <tstuser1@tstuser.com>
Date:   Wed May 27 11:48:30 2009 -0500

    2nd commit after initial commit

commit 9f9ed5663d180caefd0bcaff4578fdb2c542bf17
Author: tstuser1 <tstuser1@tstuser.com>
Date:   Wed May 27 11:14:38 2009 -0500

    1st commit after initial commit

commit bee2e0fa066aaa9fed99c15c2ab58744a34fda48
Author: tstuser1 <tstuser1@tstuser.com>
Date:   Wed May 27 11:13:13 2009 -0500

$
***NOTE THAT LAST LINE OF OUTPUT IS MISSING ABOVE (SHOULD BE THE TITLE LINE 
OF THE INITIAL COMMIT -- BUT ITS NOT THERE)***
$ clear
***GIT LOG LAST TWO COMMITS***
$ git log -2






















commit 73170498d68a0011b37d7ee095bf88b8dcb6fbb5
Author: tstuser1 <tstuser1@tstuser.com>
Date:   Wed May 27 11:48:30 2009 -0500

    2nd commit after initial commit

commit 9f9ed5663d180caefd0bcaff4578fdb2c542bf17
Author: tstuser1 <tstuser1@tstuser.com>
Date:   Wed May 27 11:14:38 2009 -0500

$
***NOTE THAT THE LAST LINE OF OUTPUT IS MISSING (SHOULD BE THE TITLE LINE OF 
THE 1ST COMMIT AFTER INITIAL COMMIT -- BUT ITS NOT THERE)***
$ clear
***GIT LOG LAST COMMIT***
$ git log -1






















commit 73170498d68a0011b37d7ee095bf88b8dcb6fbb5
Author: tstuser1 <tstuser1@tstuser.com>
Date:   Wed May 27 11:48:30 2009 -0500

$
***NOTE THAT LAST LINE OF OUTPUT IS MISSING (SHOULD BE THE TITLE LINE OF THE 
LAST COMMIT -- BUT ITS NOT THERE)***

Is this the kind of testcase that you are looking for?


v/r,
Neal

"Michael J Gruber" <git@drmicha.warpmail.net> wrote in message 
news:4A1D5F70.4030101@drmicha.warpmail.net...
> Neal Kreitzinger venit, vidit, dixit 27.05.2009 00:57:
>> Git log is not displaying the last line of output (for a plain "$ git 
>> log"
>> the last line of output should be the title line of the initial commit).
>
> It should be the last line of the commit message, which is the "title
> line" (subject) if and only if the message consists of the subject line
> only.
>
>> (I'm using git 1.5.5.6 on rhel 5.3.)  This missing last line also occurs
>> with "git log --since" in which the last line of output should be the 
>> title
>> line of the first commit after the specified date, but it is missing in 
>> this
>> scenario also.  I've searched the release notes for 1.5.6 thru 1.6.3.1 
>> and
>> did not find this mentioned.  Does this also happen in newer versions of 
>> git
>> after 1.5.5.6?
>
> I can't reproduce this with git 1.5.5.6 (vanilla, not rhel). Do you have
> a minimal reproducible test case?
>
> Michael 
