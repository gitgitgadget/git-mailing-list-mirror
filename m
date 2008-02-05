From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rebase.sh: Read $git_am_opt user setting inside --continue option
Date: Tue, 05 Feb 2008 15:56:01 +0200
Organization: Private
Message-ID: <d4rbzevi.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 14:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOIj-0001Xo-04
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 14:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYBEN4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 08:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbYBEN4z
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 08:56:55 -0500
Received: from main.gmane.org ([80.91.229.2]:53613 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYBEN4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 08:56:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMOI3-0007gQ-Sp
	for git@vger.kernel.org; Tue, 05 Feb 2008 13:56:47 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 13:56:47 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 13:56:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:pD/r1EkILjeMGRkID61kO3SbawI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72654>

Honor user settable --whitespace=<control>

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 git-rebase.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bdcea0e..ec052c4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -174,7 +174,8 @@ do
 		head_name=$(cat .dotest/head-name) &&
 		onto=$(cat .dotest/onto) &&
 		orig_head=$(cat .dotest/orig-head) &&
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+		git am $git_am_opt --resolved --3way \
+		    --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
-- 
1.5.4-rc5.GIT-dirty


-- 
Welcome to FOSS revolution: we fix and modify until it shines
