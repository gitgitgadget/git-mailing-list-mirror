From: Francis Galiegue <fg@one2team.net>
Subject: git-cvsimport BUG: some commits are completely out of phase (but cvsps sees them all right)
Date: Sun, 2 Nov 2008 22:03:40 +0100
Organization: One2team
Message-ID: <200811022203.41092.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 22:06:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwk9Y-0005kJ-4T
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 22:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbYKBVEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbYKBVEr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 16:04:47 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:38604 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbYKBVEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 16:04:46 -0500
Received: from erwin.kitchen.eel (unknown [90.63.13.131])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 3A03092C011
	for <git@vger.kernel.org>; Sun,  2 Nov 2008 22:04:34 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99874>

Maybe it's due to the other bug that I reported with git-cvsimport a few days 
ago: namely, it does NOT see branches created by CVS with no commits in them 
(ie, create the branch and that's it, don't touch anything).

The problem is very serious, since it seems to trigger another bug which 
prevents git-cvsimport from working at all. cvsps DOES see the commit 
correctly (branc exists for this file at 1.47.6):

---
Members:
        
src/java/com/one2team/database/bean/impl/relation/reporting/Register.java:1.47->1.47.6.1
---

But on the imported git repository, the diff is rather 1.60 -> 1.47.6.1! As a 
result, the repository is plain unusable.

As to the first problem, git finds 6 branches, cvs log finds 8 for the same 
module. git finds 22 tags, cvs log finds 29!

-- 
fge
