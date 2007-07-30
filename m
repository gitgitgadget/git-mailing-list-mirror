From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: local git clone problem
Date: Mon, 30 Jul 2007 12:42:54 +0400
Message-ID: <200707301242.54669@sercond.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 11:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFRHb-0007I1-Hc
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 11:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXG3JLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764737AbXG3JLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 05:11:16 -0400
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:38362 "EHLO
	zigzag.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763134AbXG3JLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 05:11:16 -0400
X-Greylist: delayed 1692 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2007 05:11:15 EDT
Received: from Debian-exim by zigzag.lvk.cs.msu.su with spam-scanned (Exim 4.50)
	id 1IFQq7-0001DC-Va
	for git@vger.kernel.org; Mon, 30 Jul 2007 12:43:01 +0400
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	zigzag.lvk.cs.msu.su
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.5 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from ppp85-140-109-148.pppoe.mtu-net.ru ([85.140.109.148] helo=blacky)
	by zigzag.lvk.cs.msu.su with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IFQq7-0001D8-Qs
	for git@vger.kernel.org; Mon, 30 Jul 2007 12:42:55 +0400
Received: from nikita by blacky with local (Exim 4.63)
	(envelope-from <yoush@cs.msu.su>)
	id 1IFQq6-00015R-MF
	for git@vger.kernel.org; Mon, 30 Jul 2007 12:42:54 +0400
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54212>

Hello.

I'm trying to clone a local git repository and it fails:

nikita@blacky:~/linux-2.6> git clone -l -s -n . ../new
Initialized empty Git repository in /home/nikita/new/.git/
/usr/bin/git-clone: line 381: cd: /home/nikita/new/.git/refs/remotes/origin: No such file or directory

The command is [almost] from git-clone(1) examples.

Examining .git in the new directory after the error:

nikita@blacky:~/new> ls -aR
.:
./  ../  .git/

./.git:
./  ../  branches/  config  description  HEAD  hooks/  info/  objects/  refs/

./.git/branches:
./  ../

./.git/hooks:
./   applypatch-msg  post-commit   post-update     pre-commit  update
../  commit-msg      post-receive  pre-applypatch  pre-rebase

./.git/info:
./  ../  exclude

./.git/objects:
./  ../  info/  pack/

./.git/objects/info:
./  ../  alternates

./.git/objects/pack:
./  ../

./.git/refs:
./  ../  heads/  tags/

./.git/refs/heads:
./  ../

./.git/refs/tags:
... (same as in .git/refs/tags/ of the original directory)

Looks like for some reason, .git/refs/remotes in the new directory is
not created, but referenced.

Original repository was created by 'git init' and then populated with several
'git remote add' and 'git remote update' commands.

This is with debian package git-core 1:1.5.2.1-1~bpo.1 (current debian
etch-backports version)

Is this a bug?
If not, what I'm doing wrong?
Is it possible to manually 'fix' the original directory such that local
clones from it will become possible?

Nikita
