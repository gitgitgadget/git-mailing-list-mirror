From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: remote tracking branch deletion problem
Date: Fri, 19 Dec 2008 12:57:11 +0100
Organization: Intra2net AG
Message-ID: <200812191257.18678.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 12:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDe08-00025D-LY
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 12:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYLSL5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 06:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbYLSL5W
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 06:57:22 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:47030 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYLSL5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 06:57:22 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 6D2C8880F;
	Fri, 19 Dec 2008 12:57:20 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id BF9162AC4B;
	Fri, 19 Dec 2008 12:57:19 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id DD8742AC4A;
	Fri, 19 Dec 2008 12:57:18 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.7-53.fc9.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-19_03)
X-Spam-Status: hits=-2.5 tests=[ALL_TRUSTED=-1.8,BAYES_20=-0.74]
X-Spam-Level: 975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103559>

Hello together,

while playing around with git, I stumbled upon a strange remote tracking 
branch deletion problem. It seems I'm unable to delete the remote tracking 
branch "origin/HEAD" using git 1.6.0.5. Here's what I did:

[tomj@storm repo]$ git init
Initialized empty Git repository in /tmp/repo/.git/

[tomj@storm repo]$ echo "test" >test
[tomj@storm repo]$ git add test
[tomj@storm repo]$ git commit -m "Test"

[tomj@storm tmp]$ git clone repo alice
Initialized empty Git repository in /tmp/alice/.git/

[tomj@storm alice]$ git branch -r
  origin/HEAD
  origin/master

[tomj@storm alice]$ git branch -r -d origin/HEAD
Deleted remote branch origin/HEAD.
[tomj@storm alice]$ git branch -r -d origin/master
Deleted remote branch origin/master.

[tomj@storm alice]$ ls -al .git/refs/remotes/origin/HEAD
-rw-rw---- 1 tomj intra2net 32 19. Dec 12:43 .git/refs/remotes/origin/HEAD
[tomj@storm alice]$ git branch -r
error: refs/remotes/origin/HEAD points nowhere!

Is this supposed to be? git 1.6.1.rc3.35.gc0ceb shows a similar behavior.

Cheers,
Thomas
