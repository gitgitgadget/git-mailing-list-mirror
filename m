From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 17/20] Rename confusing objects field in ObjectWalk
Date: Sun, 15 Jun 2008 23:45:46 +0200
Message-ID: <1213566349-25395-18-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-15-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-16-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-17-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K805d-00020y-UA
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbYFOVrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbYFOVrv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:51 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31454 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbYFOVru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958678ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yio/F+qIUhQuQlz5l3QzAY4Opo6dyBk7WObyuE9Ki88=;
        b=JfCu0b/srvV4yYvDHgHbtsgzEqbAP6JsWw/nsiqvc+CD/m1zyaSzKwopbARKXCYzS/
         CBR8WGXAJkTnY4HhXNCTyx/viJ21g5so3vjcVNzhJGye9C4HnKpwfHoCpGe8YePxYP3x
         rMxdmZyuW0Jwrlwin7b+MLRxYxy5gg+bH30gM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ih1wS5AAO7yCYdUUYKvnnWLVfzrAWXPrIY83VCjMA/i6WW19QAJPtDuve1cDnyUTkO
         /NVdzj8w+GYbl86UHnlGk4ILgwANI+dyqrY6z0kYpcqoHIxUjJ75Us68Pw23iq+TXWtl
         U/mfiY+NgOUFpviIC7TIWasC0484qJLQKY8vE=
Received: by 10.151.85.20 with SMTP id n20mr9414634ybl.52.1213566469729;
        Sun, 15 Jun 2008 14:47:49 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 27sm2162678qbw.19.2008.06.15.14.47.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:48 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-17-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85139>

Rename ObjectWalk#objects field to pendingObjects, as private objects
field already existed in superclass - RevWalk. These 2 fields have
different meaning and just leaded to confusion.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 81cebbd..6a5b857 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -68,7 +68,7 @@ import org.spearce.jgit.treewalk.TreeWalk;
 public class ObjectWalk extends RevWalk {
 	private final TreeWalk treeWalk;
 
-	private BlockObjQueue objects;
+	private BlockObjQueue pendingObjects;
 
 	private RevTree currentTree;
 
@@ -85,7 +85,7 @@ public class ObjectWalk extends RevWalk {
 	public ObjectWalk(final Repository repo) {
 		super(repo);
 		treeWalk = new TreeWalk(repo);
-		objects = new BlockObjQueue();
+		pendingObjects = new BlockObjQueue();
 	}
 
 	/**
@@ -203,12 +203,12 @@ public class ObjectWalk extends RevWalk {
 			if ((r.flags & UNINTERESTING) != 0) {
 				markTreeUninteresting(r.getTree());
 				if (hasRevSort(RevSort.BOUNDARY)) {
-					objects.add(r.getTree());
+					pendingObjects.add(r.getTree());
 					return r;
 				}
 				continue;
 			}
-			objects.add(r.getTree());
+			pendingObjects.add(r.getTree());
 			return r;
 		}
 	}
@@ -274,7 +274,7 @@ public class ObjectWalk extends RevWalk {
 		}
 
 		for (;;) {
-			final RevObject o = objects.next();
+			final RevObject o = pendingObjects.next();
 			if (o == null)
 				return null;
 			if ((o.flags & SEEN) != 0)
@@ -348,7 +348,7 @@ public class ObjectWalk extends RevWalk {
 	@Override
 	public void dispose() {
 		super.dispose();
-		objects = new BlockObjQueue();
+		pendingObjects = new BlockObjQueue();
 		enterSubtree = false;
 		currentTree = null;
 	}
@@ -356,14 +356,14 @@ public class ObjectWalk extends RevWalk {
 	@Override
 	protected void reset(final int retainFlags) {
 		super.reset(retainFlags);
-		objects = new BlockObjQueue();
+		pendingObjects = new BlockObjQueue();
 		enterSubtree = false;
 	}
 
 	private void addObject(final RevObject o) {
 		if ((o.flags & SEEN) == 0) {
 			o.flags |= SEEN;
-			objects.add(o);
+			pendingObjects.add(o);
 		}
 	}
 
-- 
1.5.5.1
