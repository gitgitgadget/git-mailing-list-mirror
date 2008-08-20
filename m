From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 2/6] Emphasize that db is a local one in RemoteRefUpdate
Date: Wed, 20 Aug 2008 04:57:36 +0200
Message-ID: <1219201060-4307-2-git-send-email-marek.zawirski@gmail.com>
References: <48AB84A2.7010905@gmail.com>
 <1219201060-4307-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:59:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVduY-0001o0-Lj
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYHTC5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYHTC5v
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:57:51 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:32303 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbYHTC5u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:57:50 -0400
Received: by mu-out-0910.google.com with SMTP id w8so321027mue.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=blNR7hOmvhCjnQ85mIbfD0L/FDtKRy2K5+li30zm42g=;
        b=Gb/+4mDpS/xLkkaOmSmU0Wq6MjWaP+++t990SzMTRMTkh+oq/6qKo78Cl5YGQspGnZ
         eAxxmI8oPvLpS9Da/TakvjF1Rr3B72Am7DHPnJW0Z5t4gZjvaXDtF3ieh816TGBgHK7H
         tlqAQwRuRtWEnBWuqZiQIR2Gju4p/w2iJUtkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xKEw0MdvEbVqVgYFzVgXCk4z/7LhFnnt/tFvBgOZL4Q7P92QCKHKhBzh01rCCkpqEh
         QjSzA+7xryePH5/Ymbm2wqyJ6xFPnDwFe815YVJbxLBO9ycZXdTi9jtPnjafd03GpnHW
         C8r/FpAoW4xNRfTQ56mMdD/nAQ2jpSIkBx9B8=
Received: by 10.102.244.1 with SMTP id r1mr5293220muh.25.1219201069119;
        Tue, 19 Aug 2008 19:57:49 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id e10sm1371114muf.14.2008.08.19.19.57.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:57:48 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219201060-4307-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92956>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/RemoteRefUpdate.java    |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
index 42588c1..66fe6a1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -133,15 +133,15 @@
 
 	private String message;
 
-	private final Repository db;
+	private final Repository localDb;
 
 	/**
 	 * Construct remote ref update request by providing an update specification.
 	 * Object is created with default {@link Status#NOT_ATTEMPTED} status and no
 	 * message.
-	 *
-	 * @param db
-	 *            repository to push from.
+	 * 
+	 * @param localDb
+	 *            local repository to push from.
 	 * @param srcRef
 	 *            source revision - any string resolvable by
 	 *            {@link Repository#resolve(String)}. This resolves to the new
@@ -173,26 +173,26 @@
 	 * @throws IllegalArgumentException
 	 *             if some required parameter was null
 	 */
-	public RemoteRefUpdate(final Repository db, final String srcRef,
+	public RemoteRefUpdate(final Repository localDb, final String srcRef,
 			final String remoteName, final boolean forceUpdate,
 			final String localName, final ObjectId expectedOldObjectId)
 			throws IOException {
 		if (remoteName == null)
 			throw new IllegalArgumentException("Remote name can't be null.");
 		this.srcRef = srcRef;
-		this.newObjectId = (srcRef == null ? ObjectId.zeroId() : db
+		this.newObjectId = (srcRef == null ? ObjectId.zeroId() : localDb
 				.resolve(srcRef));
 		if (newObjectId == null)
 			throw new IOException("Source ref " + srcRef
 					+ " doesn't resolve to any object.");
 		this.remoteName = remoteName;
 		this.forceUpdate = forceUpdate;
-		if (localName != null && db != null)
-			trackingRefUpdate = new TrackingRefUpdate(db, localName,
+		if (localName != null && localDb != null)
+			trackingRefUpdate = new TrackingRefUpdate(localDb, localName,
 					remoteName, forceUpdate, newObjectId, "push");
 		else
 			trackingRefUpdate = null;
-		this.db = db;
+		this.localDb = localDb;
 		this.expectedOldObjectId = expectedOldObjectId;
 		this.status = Status.NOT_ATTEMPTED;
 	}
@@ -215,7 +215,7 @@ public RemoteRefUpdate(final Repository db, final String srcRef,
 	 */
 	public RemoteRefUpdate(final RemoteRefUpdate base,
 			final ObjectId newExpectedOldObjectId) throws IOException {
-		this(base.db, base.srcRef, base.remoteName, base.forceUpdate,
+		this(base.localDb, base.srcRef, base.remoteName, base.forceUpdate,
 				(base.trackingRefUpdate == null ? null : base.trackingRefUpdate
 						.getLocalName()), newExpectedOldObjectId);
 	}
-- 
1.5.6.3
