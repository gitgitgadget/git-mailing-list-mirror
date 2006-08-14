From: David Rientjes <rientjes@google.com>
Subject: [PATCH 27/28] makes track_tree_refs void
Date: Mon, 14 Aug 2006 13:40:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141339280.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:40:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjEU-0001zp-Da
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWHNUkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWHNUkT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:40:19 -0400
Received: from smtp-out.google.com ([216.239.45.12]:666 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964867AbWHNUkR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:40:17 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id k7EKeCjJ011921
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:40:12 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=hJ3RhvERxbmIVWPRMVSI7RsqbhC9ndw08UiJEypUyQB67tv3nC0z4ffysT+n2BWJQ
	Uoj2pNZewnOQ32XucXT/A==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps36.corp.google.com with ESMTP id k7EKe6Wj024525
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:40:06 -0700
Received: by localhost (Postfix, from userid 24081)
	id 34C6087D71; Mon, 14 Aug 2006 13:40:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 31D0287D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:40:06 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25408>

Makes track_tree_refs void.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 tree.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/tree.c b/tree.c
index a6032e3..ef456be 100644
--- a/tree.c
+++ b/tree.c
@@ -144,7 +144,7 @@ struct tree *lookup_tree(const unsigned 
 	return (struct tree *) obj;
 }
 
-static int track_tree_refs(struct tree *item)
+static void track_tree_refs(struct tree *item)
 {
 	int n_refs = 0, i;
 	struct object_refs *refs;
@@ -174,7 +174,6 @@ static int track_tree_refs(struct tree *
 		refs->ref[i++] = obj;
 	}
 	set_object_refs(&item->object, refs);
-	return 0;
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
-- 
1.4.2.g89bb-dirty
