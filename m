From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/5] lost-found: use git rev-parse -q
Date: Wed,  3 Dec 2008 14:26:49 +0100
Message-ID: <73193271279140eda04ec46097936e64f3c526d6.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
 <4858dc4d5d92276fa96a8fb45b02adaae57dcf26.1228310570.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:28:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rm3-0000KC-FE
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbYLCN07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbYLCN07
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:26:59 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46169 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYLCN0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:26:54 -0500
Received: from vmobile.example.net (dsl5401C5DE.pool.t-online.hu [84.1.197.222])
	by yugo.frugalware.org (Postfix) with ESMTPA id C1CA3446CDD;
	Wed,  3 Dec 2008 14:26:52 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B487B19DC73; Wed,  3 Dec 2008 14:26:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <4858dc4d5d92276fa96a8fb45b02adaae57dcf26.1228310570.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102253>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-lost-found.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-lost-found.sh b/git-lost-found.sh
index 9cedaf8..0b3e8c7 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -20,7 +20,7 @@ while read dangling type sha1
 do
 	case "$dangling" in
 	dangling)
-		if git rev-parse --verify "$sha1^0" >/dev/null 2>/dev/null
+		if git rev-parse -q --verify "$sha1^0" >/dev/null
 		then
 			dir="$laf/commit"
 			git show-branch "$sha1"
-- 
1.6.0.4
