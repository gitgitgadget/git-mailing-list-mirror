From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH 5/7] make rebase -m equal tree marker aware
Date: Mon, 30 Nov 2009 15:45:13 +0100
Message-ID: <f2a9ac5906a9fa963f8d843230a1f419469c8b8e.1259524136.git.brlink@debian.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:45:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7VD-0007P5-7M
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbZK3OpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbZK3OpI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:45:08 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33533
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752154AbZK3OpH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:45:07 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7V4-00015W-23
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:45:14 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7V4-0000rU-0B
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:45:14 +0100
Content-Disposition: inline
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134108>

---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b121f45..391f6d6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -539,7 +539,7 @@ echo "$head_name" > "$dotest/head-name"
 echo "$GIT_QUIET" > "$dotest/quiet"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
+for cmt in `git rev-list --reverse --first-equal-tree-only --no-merges "$revisions"`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
