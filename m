From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: setting up git-cvsserver
Date: Tue, 1 Aug 2006 17:49:06 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060801154906.GA18772@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 01 17:50:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7wUl-0006s5-Co
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 17:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWHAPtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWHAPtL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 11:49:11 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:22187 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751602AbWHAPtK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 11:49:10 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1G7wUX-0003VR-8X
	for git@vger.kernel.org; Tue, 01 Aug 2006 17:49:09 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k71Fn7Bs019083
	for <git@vger.kernel.org>; Tue, 1 Aug 2006 17:49:07 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k71Fn6qo019082
	for git@vger.kernel.org; Tue, 1 Aug 2006 17:49:06 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24603>

Hello,

I cannot checkout a git repo via cvs, I think the only problem is, that
I don't know how to specify the CVSROOT:

fs-n1:~# grep git- /etc/inetd.conf 
2402    stream  tcp     nowait  root    /usr/local/sbin/git-cvsserver pserver

fs-n1:~# GIT_DIR=/data/vcs/git/LxNETES-2.4/bl.git git var -l
core.repositoryformatversion=0
core.filemode=true
gitcvs.enabled=1
GIT_COMMITTER_IDENT=root <root@fs-n1.fsforth.de> 1154447177 +0200
GIT_AUTHOR_IDENT=root <root@fs-n1.fsforth.de> 1154447177 +0200

uzeisberger@io:~$ cvs -d :pserver:fs-c:2402/data/vcs/git/LxNETES-2.4/bl.git login
Logging in to :pserver:uzeisberger@fs-c:2402/data/vcs/git/LxNETES-2.4/bl.git
CVS password: 
cvs [login aborted]: unrecognized auth response from fs-c: Unknown command BEGIN VERIFICATION REQUEST at /usr/local/sbin/git-cvsserver line 132, <STDIN> line 1.
uzeisberger@io:~$ cvs -d :pserver:fs-c:2402/data/vcs/git/LxNETES-2.4/bl.git co master
cvs [checkout aborted]: unrecognized auth response from fs-c: Unknown command BEGIN AUTH REQUEST at /usr/local/sbin/git-cvsserver line 132, <STDIN> line 1.

cvs version is 1.12.13 (Debian)
git-cvsserver is from v1.4.2-rc2-gbc9e1b8
rest of git is 1.4.0

probably I'm just too stupid to read and understand the docs...

Best regards
Uwe

-- 
Uwe Zeisberger

cat /*dev/null; echo 'Hello World!';
cat > /dev/null <<*/ 
() { } int main() { printf("Hello World!\n");}
/* */
