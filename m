From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5.1 1/3] http-backend: Remove pointless objects/info/* service entry
Date: Wed,  4 Nov 2009 17:16:36 -0800
Message-ID: <1257383798-29826-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 02:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5qyE-0002AX-3B
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 02:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513AbZKEBQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 20:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbZKEBQi
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 20:16:38 -0500
Received: from george.spearce.org ([209.20.77.23]:37443 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147AbZKEBQg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 20:16:36 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D5EC1E0005; Thu,  5 Nov 2009 01:16:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6E4B7381FE
	for <git@vger.kernel.org>; Thu,  5 Nov 2009 01:16:38 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132184>

In earlier versions of this patch series this rule was used to
match and serve objects/info/alternates and http-alternates.
Later versions of the patch series explicitly called out match
rules for those files, making this wildcard rule unnecessary.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This probably should be squashed into the commit that introduces
 this CGI script ("Git-aware CGI to provide dumb HTTP transport").

 http-backend.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8e5c0a2..7900cda 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -558,7 +558,6 @@ static struct service_cmd {
 	{"GET", "/objects/info/alternates$", get_text_file},
 	{"GET", "/objects/info/http-alternates$", get_text_file},
 	{"GET", "/objects/info/packs$", get_info_packs},
-	{"GET", "/objects/info/[^/]*$", get_text_file},
 	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
-- 
1.6.5.2.295.g0d105
