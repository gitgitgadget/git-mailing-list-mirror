From: Tim O'Callaghan <timo@dspsrv.com>
Subject: Cygwin test failure in t6021-merge-criss-cross.sh
Date: Tue, 6 Dec 2005 13:40:32 +0100
Message-ID: <20051206124032.GC2364@ELSAMSW37164>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 06 13:43:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejc7Y-00013U-WB
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 13:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVLFMkd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 07:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVLFMkd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 07:40:33 -0500
Received: from vir.dspsrv.com ([193.120.211.34]:22480 "EHLO dspsrv.com")
	by vger.kernel.org with ESMTP id S932106AbVLFMkc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 07:40:32 -0500
Received: from [145.36.48.101] (helo=localhost)
	by dspsrv.com with asmtp (Exim 3.36 #1)
	id 1Ejc7T-0003tP-00
	for git@vger.kernel.org; Tue, 06 Dec 2005 12:40:31 +0000
To: git@vger.kernel.org
Mail-Followup-To: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r655 (CYGWIN_NT-5.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13274>

I tried build-testing the latest version of git, and the tests reported
this error:
---------
*** t6021-merge-criss-cross.sh ***
* FAIL 1: prepare repository
        echo "1
        2
        3
        4
        5
        6
        7
        8
        9" > file &&
        git add file &&
        git commit -m "Initial commit" file &&
        git branch A &&
        git branch B &&
        git checkout A &&
        echo "1
        2
        3
        4
        5
        6
        7
        8 changed in B8, branch A
        9" > file &&
        git commit -m "B8" file &&
        git checkout B &&
        echo "1
        2
        3 changed in C3, branch B
        4
        5
        6
        7
        8
        9
        " > file &&
        git commit -m "C3" file &&
        git branch C3 &&
        git merge "pre E3 merge" B A &&
        echo "1
        2
        3 changed in E3, branch B. New file size
        4
        5
        6
        7
        8 changed in B8, branch A
        9
        " > file &&
        git commit -m "E3" file &&
        git checkout A &&
        git merge "pre D8 merge" A C3 &&
        echo "1
        2
        3 changed in C3, branch B
        4
        5
        6
        7
        8 changed in D8, branch A. New file size 2
        9" > file &&
        git commit -m D8 file
* FAIL 2: Criss-cross merge
        git merge "final merge" A B
* FAIL 3: Criss-cross merge result
        cmp file file-expect
* failed 3 among 3 test(s)
make[1]: *** [t6021-merge-criss-cross.sh] Error 1
make[1]: Leaving directory `/cygdrive/c/home/tim/projects/CygwinPorts/git_git/t'
make: *** [test] Error 2
----

Is there any more information i need to provide? 

Tim.
"I've worked myself up from nothing to a state of supreme poverty."
-- Groucho Marx
