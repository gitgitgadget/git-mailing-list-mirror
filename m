From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH 4/7] support equal tree merges in interactive rebase
Date: Mon, 30 Nov 2009 15:44:53 +0100
Message-ID: <84bec3d6f3482d3cd6ef0a8734471deb69f3ff5a.1259524136.git.brlink@debian.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:44:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7Up-0007Du-9w
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZK3Oos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZK3Oor
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:44:47 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33532
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557AbZK3Oor (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:44:47 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7Uj-00013Y-KN
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:44:53 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7Uj-0000rF-Ia
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:44:53 +0100
Content-Disposition: inline
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134107>

---
 git-rebase--interactive.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0bd3bf7..3da9f3e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -703,6 +703,7 @@ first and then run 'git rebase --continue' again."
 		fi
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
+			--first-equal-tree-only \
 			$REVISIONS | \
 			sed -n "s/^>//p" | while read shortsha1 rest
 		do
