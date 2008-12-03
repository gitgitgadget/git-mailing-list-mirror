From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/5] rebase: use git rev-parse -q
Date: Wed,  3 Dec 2008 14:26:51 +0100
Message-ID: <b67238b67501272485cc659c11a836f4f96e0d81.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
 <4858dc4d5d92276fa96a8fb45b02adaae57dcf26.1228310570.git.vmiklos@frugalware.org>
 <73193271279140eda04ec46097936e64f3c526d6.1228310570.git.vmiklos@frugalware.org>
 <8c4e8eda234e8e37d4a7a3ac43ffc7738e6fac4b.1228310570.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rmR-0000Wy-RV
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbYLCN1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbYLCN1B
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:27:01 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46170 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYLCN0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:26:55 -0500
Received: from vmobile.example.net (dsl5401C5DE.pool.t-online.hu [84.1.197.222])
	by yugo.frugalware.org (Postfix) with ESMTPA id D1DD1446CDE;
	Wed,  3 Dec 2008 14:26:52 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D424819DC72; Wed,  3 Dec 2008 14:26:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <8c4e8eda234e8e37d4a7a3ac43ffc7738e6fac4b.1228310570.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102256>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-rebase.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 023a6dc..ea7720d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -365,10 +365,10 @@ case "$#" in
 	switch_to="$2"
 
 	if git show-ref --verify --quiet -- "refs/heads/$2" &&
-	   branch=$(git rev-parse --verify "refs/heads/$2" 2>/dev/null)
+	   branch=$(git rev-parse -q --verify "refs/heads/$2")
 	then
 		head_name="refs/heads/$2"
-	elif branch=$(git rev-parse --verify "$2" 2>/dev/null)
+	elif branch=$(git rev-parse -q --verify "$2")
 	then
 		head_name="detached HEAD"
 	else
-- 
1.6.0.4
