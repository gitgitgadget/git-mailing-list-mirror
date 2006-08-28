From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Use xcalloc instead of calloc
Date: Mon, 28 Aug 2006 02:26:07 +0200
Message-ID: <20060828002607.GD20904@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 28 02:26:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHUxH-0008Kw-3K
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 02:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWH1A0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 20:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWH1A0N
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 20:26:13 -0400
Received: from [130.225.96.91] ([130.225.96.91]:25019 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751251AbWH1A0M (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 20:26:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 9C8FC77000B
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:26:09 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32116-19 for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:26:08 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 286AE770004
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:26:08 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 342666DF823
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:24:46 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id EF29662A02; Mon, 28 Aug 2006 02:26:07 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26131>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 object-refs.c |    2 +-
 object.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-refs.c b/object-refs.c
index b1b8065..b0034e4 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -30,7 +30,7 @@ static void grow_refs_hash(void)
 	int new_hash_size = (refs_hash_size + 1000) * 3 / 2;
 	struct object_refs **new_hash;
 
-	new_hash = calloc(new_hash_size, sizeof(struct object_refs *));
+	new_hash = xcalloc(new_hash_size, sizeof(struct object_refs *));
 	for (i = 0; i < refs_hash_size; i++) {
 		struct object_refs *ref = refs_hash[i];
 		if (!ref)
diff --git a/object.c b/object.c
index 60bf16b..9281300 100644
--- a/object.c
+++ b/object.c
@@ -73,7 +73,7 @@ static void grow_object_hash(void)
 	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
 	struct object **new_hash;
 
-	new_hash = calloc(new_hash_size, sizeof(struct object *));
+	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
 	for (i = 0; i < obj_hash_size; i++) {
 		struct object *obj = obj_hash[i];
 		if (!obj)
-- 
1.4.2.g2f76-dirty

-- 
Jonas Fonseca
