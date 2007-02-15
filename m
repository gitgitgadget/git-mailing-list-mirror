From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: MinGW port updated to GIT 1.5.0
Date: Thu, 15 Feb 2007 13:19:33 +0100
Organization: eudaptics software gmbh
Message-ID: <45D44FD5.72299A3A@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 13:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHfZQ-00053j-Um
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 13:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965912AbXBOMSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 07:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965916AbXBOMSF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 07:18:05 -0500
Received: from main.gmane.org ([80.91.229.2]:40078 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965915AbXBOMSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 07:18:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHfYd-0002tq-Eu
	for git@vger.kernel.org; Thu, 15 Feb 2007 13:17:51 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 13:17:51 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 13:17:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39825>

I've merged GIT 1.5.0 into the MinGW port. It is available at the usual
location:

pull/clone: git://repo.or.cz/git/mingw.git
gitweb:     http://repo.or.cz/w/git/mingw.git

It contains an important fix (MinGW specific): Earlier versions could
sometimes create temporary files read-only instead of read-writable.


WARNING!

The MinGW port does not support symbolic links, but the git.git itself
now contains a symbolic link (RelNotes). For this reason, you cannot
successfully pull this version's "master" branch to your Windows box and
expect it to work. The "devel" branch has the symbolic link removed, so
it can at least be checked out. For other operations you may enounter an
error like this:

bad tree object: 4571d0d1cfb5a4170dfc80e9654228acae295129

I'm working on a solution. The general idea is to extend the meaning of
`core.filemode = false` to check out symbolic links as plain files. Any
hints about where the source code needs changes are welcome.

-- Hannes
