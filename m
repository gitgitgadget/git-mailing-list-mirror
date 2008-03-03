From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: Fix typo 'url' which should be '$url'
Date: Mon,  3 Mar 2008 10:03:18 +0800
Message-ID: <1204509798-671-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 03 03:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW02V-00040C-Bl
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYCCCD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbYCCCD0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:03:26 -0500
Received: from mail.qikoo.org ([60.28.205.235]:54831 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750995AbYCCCDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:03:25 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 17433470AE; Mon,  3 Mar 2008 10:03:18 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75865>

Fix typo in 'test -z "url"' when checking whether a submodule url is
empty. "url" should be "$url".

More thinking, why does empty url mean uninitialized? How about the
case that the submodule url is deleted from .git/config?

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..67d3224 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -362,7 +362,7 @@ cmd_status()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		if test -z "url" || ! test -d "$path"/.git
+		if test -z "$url" || ! test -d "$path"/.git
 		then
 			say "-$sha1 $path"
 			continue;
-- 
1.5.4.3.347.g5314c

