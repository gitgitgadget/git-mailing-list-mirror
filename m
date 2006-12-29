From: Brian Gernhardt <benji@silverinsanity.com>
Subject: git-add ignores .gitignore
Date: Fri, 29 Dec 2006 10:51:37 -0500
Message-ID: <033682AF-B324-4049-B331-8A8AF2335E4D@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 29 16:51:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0K1I-0002E6-D4
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 16:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbWL2Pvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 10:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbWL2Pvl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 10:51:41 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:44751 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbWL2Pvk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 10:51:40 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 36B661FFC02B
	for <git@vger.kernel.org>; Fri, 29 Dec 2006 15:51:39 +0000 (UTC)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35593>

I just ran "git add ." and got a very surprising result. Test case:

$ mkdir tmp
$ git init-db
$ mkdir a
$ touch a/b c
$ cat > .gitignore << EOF
a
EOF
$ git status
# On branch refs/heads/master
#
# Initial commit
#
# Untracked files:
#   (use "git add file1 file2" to include for commit)
#
#       .gitignore
#       c
nothing to commit (use "git add file1 file2" to include for commit)
$ git add .
$ git status
# On branch refs/heads/master
#
# Initial commit
#
# Added but not yet committed:
#   (will commit)
#
#       new file: .gitignore
#       new file: a/b
#       new file: c
#
$ git --version
git version 1.5.0.rc0.g04509

Huh?  I'm deep into my own code so can't diagnose it myself right  
now, but thought maybe someone on list could.  I really hope that's  
not the expected behavior.  Same thing happens with "git add *"

~~ Brian
