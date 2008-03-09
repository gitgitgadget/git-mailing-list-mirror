From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-filter-branch.txt: Add picture to explain the graft-id
Date: Sun, 09 Mar 2008 11:01:14 +0200
Organization: Private
Message-ID: <7igcz2xx.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 10:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYHQt-0006Y9-7y
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 10:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbYCIJB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 05:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbYCIJB5
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 05:01:57 -0400
Received: from main.gmane.org ([80.91.229.2]:50797 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYCIJB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 05:01:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JYHPl-0001Yz-NX
	for git@vger.kernel.org; Sun, 09 Mar 2008 09:01:53 +0000
Received: from a91-155-187-119.elisa-laajakaista.fi ([91.155.187.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 09:01:53 +0000
Received: from jari.aalto by a91-155-187-119.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 09:01:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-119.elisa-laajakaista.fi
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:tzW33RKAM/osUqItBP3X6mNuoGc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76639>

Present a picture to demonstrate the positions of graft-id and
commit-id in case of merging A with B.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-filter-branch.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

 I'd like to thank Mikael Magnusson explaining this.

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 543a1cf..73939e2 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -186,7 +186,7 @@ Now, you will get the rewritten history saved in HEAD.
 
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
-order to paste the other history behind the current history:
+order to paste the other history behind the current history.
 
 -------------------------------------------------------------------
 git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' HEAD
@@ -198,6 +198,12 @@ history with a single root (that is, no merge without common ancestors
 happened).  If this is not the case, use:
 
 --------------------------------------------------------------------------
+
+    The plan: supposing we're merging A with B
+    commit sequence A: a-b-c			graft-id  = b
+    commit sequence B: c'-d'-e'			commit-id = c'
+    Result	     : a-b-c'-d'-e'
+
 git filter-branch --parent-filter \
 	'test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>" || cat' HEAD
 --------------------------------------------------------------------------
-- 
1.5.3.8


-- 
Welcome to FOSS revolution: we fix and modify until it shines

