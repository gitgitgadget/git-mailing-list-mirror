From: Bernd Lommerzheim <bernd@lommerzheim.com>
Subject: "git gc" removes ".git/refs/heads/master".
Date: Thu, 29 Jan 2009 20:31:17 +0100
Message-ID: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 20:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSclu-0007FE-UN
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 20:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbZA2Tk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 14:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbZA2Tk2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 14:40:28 -0500
Received: from lunox.net ([217.79.181.54]:41774 "EHLO lunox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbZA2Tk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 14:40:27 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jan 2009 14:40:27 EST
Received: from localhost (lunox.net [127.0.0.1])
	by lunox.net (Postfix) with ESMTP id 949F840415D
	for <git@vger.kernel.org>; Thu, 29 Jan 2009 20:31:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at lunox.net
Received: from lunox.net ([127.0.0.1])
	by localhost (lunox.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1LyrNKsZMayd for <git@vger.kernel.org>;
	Thu, 29 Jan 2009 20:31:17 +0100 (CET)
Received: from webmail.lunox.net (lunox.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by lunox.net (Postfix) with ESMTP id E54C540415C
	for <git@vger.kernel.org>; Thu, 29 Jan 2009 20:31:17 +0100 (CET)
X-Sender: bernd@lommerzheim.com
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107720>

Hi,

maybe I found a bug in git. When I execute "git gc" in my local repository,
git removes the file ".git/refs/heads/master". Is this an intended behavior
(but why?) or is that a bug?

Some commands to reproduce:
~ $ mkdir tmp; cd tmp
~/tmp $ git init
Initialized empty Git repository in /home/myuser/tmp/.git/
~/tmp $ echo "content" > a
~/tmp $ git add .
~/tmp $ git commit -a -m "first commit"
Created initial commit 0b67f33: first commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
~/tmp $ cat .git/refs/heads/master
0b67f33fff4152a912fdbe8819480b8fc1f2e990
~/tmp $ git gc
Counting objects: 3, done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
~/tmp $ cat .git/refs/heads/master
cat: .git/refs/heads/master: No such file or directory
~/tmp $ cat .git/HEAD
ref: refs/heads/master
~/tmp $ 

I tested this with git v1.6.0.6, v1.6.1.1 and the current master
(a34a9dbb..).


Best regards,

Bernd Lommerzheim
