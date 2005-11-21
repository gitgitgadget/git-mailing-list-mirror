From: Alexander Litvinov <lan@ac-sw.com>
Subject: cvsexportcommit/cvsimport workflow
Date: Mon, 21 Nov 2005 20:43:57 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511212043.57434.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 15:44:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeCrf-0000sQ-E0
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 15:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVKUOlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 09:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVKUOlg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 09:41:36 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:32184 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932314AbVKUOlg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 09:41:36 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id 2CFC3BD37
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 20:41:27 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id A873B159123; Mon, 21 Nov 2005 20:44:03 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id E0AD0154417
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 20:43:57 +0600 (NOVT)
To: Git Mailing List <git@vger.kernel.org>
User-Agent: KMail/1.8
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12446>

Hello,

Can ypu please explain how to use cvsimport with cvsexportcommit scripts ? 

I have tried these steps:
1. Make git repo from cvs repo using cvsimport command - everything works 
great.
2. Start traking cvs changes by incremental running cvsimport - It works.
3. Change files in git repo (master branch) - works :-)
4. Export git commits to cvs: 
      first question: What should be exported and in what order ? Lets skip 
this part - it is the smallest problem.
      Two test commits were exported to cvs without any problmes.
5. Importing cvs again - I have found my exported commits became separate 
commits in git repo in origin branch (solved by git-pull . origin). But thay 
were merged idealy.
6. Changing files again in git.
7. Export git commits to cvs: What should be exported question become harder 
and harder. Possible I should use some tag and run:
git-rev-list MY-TAG..master | xargs -n 1 git-cvsexportcommit -vX -cX (by the 
way, why just -v -c does not work ? I must add something to make options 
work)

This cycle is a bit of mess. I can write some scripts but I have no idea how 
this is supposed to work !

The biggest problem - conflict. I should resove them twice, during merging 
origin branch to master and when exporting these changes to cvs. By the way, 
I still can't export merge commit :-)

Thanks for help.
Alexander Litvinov.
