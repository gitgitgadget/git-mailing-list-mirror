From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/5] filter-branch: use git rev-parse -q
Date: Wed,  3 Dec 2008 14:26:48 +0100
Message-ID: <4858dc4d5d92276fa96a8fb45b02adaae57dcf26.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:28:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rmS-0000Wy-H8
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYLCN1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbYLCN1D
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:27:03 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46167 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbYLCN0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:26:55 -0500
Received: from vmobile.example.net (dsl5401C5DE.pool.t-online.hu [84.1.197.222])
	by yugo.frugalware.org (Postfix) with ESMTPA id A22E9446CDB;
	Wed,  3 Dec 2008 14:26:52 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3E5B819D929; Wed,  3 Dec 2008 14:26:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <cover.1228310570.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102257>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 81392ad..c106f45 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -256,7 +256,7 @@ while read commit parents; do
 	*)
 		# The commit may not have the subdirectory at all
 		err=$(git read-tree -i -m $commit:"$filter_subdir" 2>&1) || {
-			if ! git rev-parse --verify $commit:"$filter_subdir" 2>/dev/null
+			if ! git rev-parse -q --verify $commit:"$filter_subdir"
 			then
 				rm -f "$GIT_INDEX_FILE"
 			else
-- 
1.6.0.4
