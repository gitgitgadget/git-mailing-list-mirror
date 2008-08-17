From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 25/31] Create ListRemoteOperation for listing remote repo branches
Date: Sun, 17 Aug 2008 22:44:06 +0200
Message-ID: <1219005852-21496-26-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-21-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-22-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-23-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-24-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-25-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpAI-0003WL-I2
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYHQUpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYHQUpw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbYHQUpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fP6A//7eWat2twfu8ONIrnly/U1In9RinWao5sVmIr0=;
        b=UIaooj4Dii945jGte/I614/fyuNNxf9CGRjgd4Lkb9VLU2e3gy0eSuyPdJ9K73cVI2
         e818E1WlFN0SJdW+xCnycOUhaNOJSBLyPwGvn4iBjI1UfypIw9LEQBW3cdfC1X0v1UfJ
         gGEYuySnKUfKE32XSZPs8ptCYGUV2+8fNkRHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IDjgPVMmqT8rcd6V98+7iW8JFmIaUL9yA3I5wQiarMO6WhN8RobgdSNgboPTb9M7Uv
         D/MxTPdpmR1GCJyEgIVEJ91AA6s5rJ4mnEbqWJy/3dpHm7G09WRDcfqi2C5zQh/MIjCi
         8kGZBmKEBOdGJJhzjBumoiHo0ni+XCowaXmYE=
Received: by 10.86.92.7 with SMTP id p7mr3961563fgb.72.1219005947936;
        Sun, 17 Aug 2008 13:45:47 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d4sm11317203fga.8.2008.08.17.13.45.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:47 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-25-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92657>

This code is a common task, so it's now bundled in this operation
with simple progress monitor information.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/core/CoreText.java        |    3 +
 .../src/org/spearce/egit/core/coretext.properties  |    2 +
 .../spearce/egit/core/op/ListRemoteOperation.java  |  104 ++++++++++++++++++++
 3 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/ListRemoteOperation.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
index 8fbda4a..5974a5f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
@@ -95,6 +95,9 @@ public class CoreText extends NLS {
 	/** */
 	public static String CloneOperation_title;
 
+	/** */
+	public static String ListRemoteOperation_title;
+
 	static {
 		final Class c = CoreText.class;
 		initializeMessages(c.getPackage().getName() + ".coretext", c);
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
index 3b3c229..c412161 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
@@ -55,3 +55,5 @@ CheckpointJob_writingTrees=modified trees
 CheckpointJob_failed=Failed to write modified objects.
 
 CloneOperation_title=Cloning from {0}
+
+ListRemoteOperation_title=Getting remote branches information
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/ListRemoteOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/ListRemoteOperation.java
new file mode 100644
index 0000000..d3f777a
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/ListRemoteOperation.java
@@ -0,0 +1,104 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.op;
+
+import java.lang.reflect.InvocationTargetException;
+import java.util.Collection;
+import java.util.Map;
+
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.jface.operation.IRunnableWithProgress;
+import org.spearce.egit.core.CoreText;
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.transport.Connection;
+import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Operation of listing remote repository advertised refs.
+ */
+public class ListRemoteOperation implements IRunnableWithProgress {
+	private final Repository localDb;
+
+	private final URIish uri;
+
+	private Map<String, Ref> remoteRefsMap;
+
+	/**
+	 * Create listing operation for specified local repository (needed by
+	 * transport) and remote repository URI.
+	 * 
+	 * @param localDb
+	 *            local repository (needed for transport) where fetch would
+	 *            occur.
+	 * @param uri
+	 *            URI of remote repository to list.
+	 */
+	public ListRemoteOperation(final Repository localDb, final URIish uri) {
+		this.localDb = localDb;
+		this.uri = uri;
+	}
+
+	/**
+	 * @return collection of refs advertised by remote side.
+	 * @throws IllegalStateException
+	 *             if error occurred during earlier remote refs listing.
+	 */
+	public Collection<Ref> getRemoteRefs() {
+		checkState();
+		return remoteRefsMap.values();
+	}
+
+	/**
+	 * @param refName
+	 *            remote ref name to search for.
+	 * @return ref with specified refName or null if not found.
+	 * @throws IllegalStateException
+	 *             if error occurred during earlier remote refs listing.
+	 */
+	public Ref getRemoteRef(final String refName) {
+		checkState();
+		return remoteRefsMap.get(refName);
+	}
+
+	public void run(IProgressMonitor pm) throws InvocationTargetException,
+			InterruptedException {
+		Transport transport = null;
+		Connection connection = null;
+		try {
+			transport = Transport.open(localDb, uri);
+
+			if (pm != null)
+				pm.beginTask(CoreText.ListRemoteOperation_title,
+						IProgressMonitor.UNKNOWN);
+			connection = transport.openFetch();
+			remoteRefsMap = connection.getRefsMap();
+		} catch (NotSupportedException e) {
+			throw new InvocationTargetException(e);
+		} catch (TransportException e) {
+			throw new InvocationTargetException(e);
+		} finally {
+			if (connection != null)
+				connection.close();
+			if (transport != null)
+				transport.close();
+			if (pm != null)
+				pm.done();
+		}
+	}
+
+	private void checkState() {
+		if (remoteRefsMap == null)
+			throw new IllegalStateException(
+					"Error occurred during remote repo listing, no refs available");
+	}
+}
\ No newline at end of file
-- 
1.5.6.3
