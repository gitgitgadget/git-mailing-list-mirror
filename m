From: Steffen Prohaska <prohaska@zib.de>
Subject: msysgit, help: teach git help to open html from /doc/git/html/
Date: Sat, 11 Aug 2007 22:44:24 +0200
Message-ID: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJxob-0002FX-8k
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXHKUnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbXHKUnu
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:43:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:53127 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbXHKUnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 16:43:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7BKhe7k004375;
	Sat, 11 Aug 2007 22:43:40 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a312.pool.einsundeins.de [77.177.163.18])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7BKhZIl014586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 11 Aug 2007 22:43:36 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55630>

I pushed the following patch to 4msysgit.git's mob branch

[ I finally found the mob branch at
ssh://mob@repo.or.cz/srv/git/git/mingw/4msysgit.git
which apparently was one git too much for my brain. ]


commit a9a42a347894edfbca33e48bed0fcd38ec334a35

     help (msysgit): teach git help to open html from /doc/git/html/

     Html pages will be opened using the default Windows application
     configured for html. This code path is taken for msysgit (mingw).

     It is assumed that html pages are installed at /doc/git/html.
     This needs to be ensured by the msysgit superproject to make this
     patch useful. html pages should be cloned from git.git's main
     repo. This is the easiest way to get up-to-date documentation,
     without requiring the complete tool chain to generate them
     locally.

     If html pages are not yet there, you can use the following
     commands to get them:

         mkdir -p /doc/git/html
         cd /doc/git/html/
         git init
         git config remote.origin.url git://git.kernel.org/pub/scm/ 
git/git.git
         git config remote.origin.fetch refs/heads/html:refs/remotes/ 
origin/html
         git fetch
         git checkout --track -b html origin/html

     and update the html documentation with

         git pull

The superproject should be setup in /share/GitMe/setup-msysgit.sh to
fetch the html pages as a submodule. But I don't understanding
submodules good enough to do so.

If you then type 'git help <command>' Firefox or Explorer or whatever
you configured as your default html viewer will show you the git help.
I think this is a good idea for Windows users.


Junio,
are you interested in such patches at this time. The patch doesn't
interfere with the existing code, but clutters it with ifdefs.

	Steffen
