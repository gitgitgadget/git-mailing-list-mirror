From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 30/31] Add PushOperation to plugin
Date: Sun, 17 Aug 2008 22:44:11 +0200
Message-ID: <1219005852-21496-31-git-send-email-marek.zawirski@gmail.com>
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
 <1219005852-21496-26-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-27-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-28-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-29-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-30-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpAM-0003WL-RJ
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbYHQUqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYHQUqT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:46:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYHQUqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:46:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=a+zdpCugJFsbdIvArW+tJT0J+UonJtn8RdQe5qhklwM=;
        b=aeTbJW8W597t5yoRQhefttmfw4koEHv3y3wcY7WoAdsBjvhZJJ0v9m2ZmSGoeMiHHD
         JIGTpNos5IERmscHnfAKV1nRYol9Wecpy6RE/+R9xpOvkzi3MYKOrwYCLlruWENZ2ufe
         m5i+jwA/spX7hrKxsi/PwXzTsQSmgTM8WaDFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ivNsMZ6T9bQg3Sb4f+iQmfyv0b/yMXZssdwVwL4b9bxMOTFdTA1IZmpf4sk5qPrTN1
         pbA1yfXefDBoQbn5zbJy/PQsIjVEWO3JFo9dlnGDsv63oH9OLkijp+VkKyI+Pi5FWF0S
         VJmaFSfepaz+yKGup3tH+wilUHRYVRDxGYfI0=
Received: by 10.86.31.19 with SMTP id e19mr4004462fge.42.1219005974556;
        Sun, 17 Aug 2008 13:46:14 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 4sm12184189fge.5.2008.08.17.13.46.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:46:13 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-30-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92661>

PushOperation is designed to handle push-to-one and push-to-many URIs,
using some supporting classes. Failure of connection to any of
repositories doesn't cause to fail whole operation - they are
independent that way. It is also possible to specify different expected
old object id for each remote repository.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/core/CoreText.java        |   15 +
 .../src/org/spearce/egit/core/coretext.properties  |    6 +
 .../org/spearce/egit/core/op/PushOperation.java    |  148 +++++++++++
 .../spearce/egit/core/op/PushOperationResult.java  |  273 ++++++++++++++++++++
 .../egit/core/op/PushOperationSpecification.java   |   82 ++++++
 5 files changed, 524 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
index 5974a5f..35e17b9 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
@@ -98,6 +98,21 @@ public class CoreText extends NLS {
 	/** */
 	public static String ListRemoteOperation_title;
 
+	/** */
+	public static String PushOperation_resultCancelled;
+
+	/** */
+	public static String PushOperation_resultNotSupported;
+
+	/** */
+	public static String PushOperation_resultTransportError;
+
+	/** */
+	public static String PushOperation_taskNameDryRun;
+
+	/** */
+	public static String PushOperation_taskNameNormalRun;
+
 	static {
 		final Class c = CoreText.class;
 		initializeMessages(c.getPackage().getName() + ".coretext", c);
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
index c412161..94cf4aa 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
@@ -57,3 +57,9 @@ CheckpointJob_failed=Failed to write modified objects.
 CloneOperation_title=Cloning from {0}
 
 ListRemoteOperation_title=Getting remote branches information
+
+PushOperation_resultCancelled=Operation was cancelled.
+PushOperation_resultNotSupported=Can't push to {0}
+PushOperation_resultTransportError=Transport error occured during push operation: {0}
+PushOperation_taskNameDryRun=Trying pushing to remote repositories
+PushOperation_taskNameNormalRun=Pushing to remote repositories
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
new file mode 100644
index 0000000..853bcfc
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
@@ -0,0 +1,148 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.op;
+
+import java.lang.reflect.InvocationTargetException;
+
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.core.runtime.SubProgressMonitor;
+import org.eclipse.jface.operation.IRunnableWithProgress;
+import org.eclipse.osgi.util.NLS;
+import org.spearce.egit.core.CoreText;
+import org.spearce.egit.core.EclipseGitProgressTransformer;
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.transport.PushResult;
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Push operation: pushing from local repository to one or many remote ones.
+ */
+public class PushOperation implements IRunnableWithProgress {
+	private static final int WORK_UNITS_PER_TRANSPORT = 10;
+
+	private final Repository localDb;
+
+	private final PushOperationSpecification specification;
+
+	private final boolean dryRun;
+
+	private final RemoteConfig rc;
+
+	private final PushOperationResult operationResult = new PushOperationResult();
+
+	/**
+	 * Create push operation for provided specification.
+	 * <p>
+	 * Operation is not performed within constructor,
+	 * {@link #run(IProgressMonitor)} method must be called for that.
+	 * 
+	 * @param localDb
+	 *            local repository.
+	 * @param specification
+	 *            specification of ref updates for remote repositories.
+	 * @param rc
+	 *            optional remote config to apply on used transports. May be
+	 *            null.
+	 * @param dryRun
+	 *            true if push operation should just check for possible result
+	 *            and not really update remote refs, false otherwise - when push
+	 *            should act normally.
+	 */
+	public PushOperation(final Repository localDb,
+			final PushOperationSpecification specification,
+			final boolean dryRun, final RemoteConfig rc) {
+		this.localDb = localDb;
+		this.specification = specification;
+		this.dryRun = dryRun;
+		this.rc = rc;
+	}
+
+	/**
+	 * @return push operation result.
+	 */
+	public PushOperationResult getOperationResult() {
+		return operationResult;
+	}
+
+	/**
+	 * @return operation specification, as provided in constructor.
+	 */
+	public PushOperationSpecification getSpecification() {
+		return specification;
+	}
+
+	/**
+	 * Execute operation and store result. Operation is executed independently
+	 * on each remote repository.
+	 * <p>
+	 * 
+	 * @throws InvocationTargetException
+	 *             Cause of this exceptions may include
+	 *             {@link TransportException}, {@link NotSupportedException} or
+	 *             some unexpected {@link RuntimeException}.
+	 * @see IRunnableWithProgress#run(IProgressMonitor)
+	 */
+	public void run(IProgressMonitor monitor) throws InvocationTargetException {
+		if (monitor == null)
+			monitor = new NullProgressMonitor();
+
+		final int totalWork = specification.getURIsNumber()
+				* WORK_UNITS_PER_TRANSPORT;
+		if (dryRun)
+			monitor.beginTask(CoreText.PushOperation_taskNameDryRun, totalWork);
+		else
+			monitor.beginTask(CoreText.PushOperation_taskNameNormalRun,
+					totalWork);
+
+		for (final URIish uri : specification.getURIs()) {
+			final SubProgressMonitor subMonitor = new SubProgressMonitor(
+					monitor, WORK_UNITS_PER_TRANSPORT,
+					SubProgressMonitor.PREPEND_MAIN_LABEL_TO_SUBTASK);
+			Transport transport = null;
+			try {
+				if (monitor.isCanceled()) {
+					operationResult.addOperationResult(uri,
+							CoreText.PushOperation_resultCancelled);
+					continue;
+				}
+				transport = Transport.open(localDb, uri);
+
+				if (rc != null)
+					transport.applyConfig(rc);
+				transport.setDryRun(dryRun);
+				final EclipseGitProgressTransformer gitSubMonitor = new EclipseGitProgressTransformer(
+						subMonitor);
+				final PushResult pr = transport.push(gitSubMonitor,
+						specification.getRefUpdates(uri));
+				operationResult.addOperationResult(uri, pr);
+			} catch (final TransportException e) {
+				operationResult.addOperationResult(uri, NLS.bind(
+						CoreText.PushOperation_resultTransportError, e
+								.getMessage()));
+			} catch (final NotSupportedException e) {
+				operationResult.addOperationResult(uri, NLS.bind(
+						CoreText.PushOperation_resultNotSupported, e
+								.getMessage()));
+			} finally {
+				if (transport != null) {
+					transport.close();
+				}
+				// Dirty trick to get things always working.
+				subMonitor.beginTask("", WORK_UNITS_PER_TRANSPORT); //$NON-NLS-1$
+				subMonitor.done();
+				subMonitor.done();
+			}
+		}
+		monitor.done();
+	}
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
new file mode 100644
index 0000000..d78b79c
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
@@ -0,0 +1,273 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.op;
+
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.Collections;
+import java.util.LinkedHashMap;
+import java.util.Set;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.transport.PushResult;
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Data class for storing push operation results for each remote repository/URI
+ * being part of push operation.
+ * <p>
+ * One instance of this class is dedicated for result of one push operation:
+ * either to one URI or to many URIs.
+ * 
+ * @see PushOperation
+ */
+public class PushOperationResult {
+	private LinkedHashMap<URIish, Entry> urisEntries;
+
+	/**
+	 * Construct empty push operation result.
+	 */
+	public PushOperationResult() {
+		this.urisEntries = new LinkedHashMap<URIish, Entry>();
+	}
+
+	/**
+	 * Add push result for the repository (URI) with successful connection.
+	 * 
+	 * @param uri
+	 *            remote repository URI.
+	 * @param result
+	 *            push result.
+	 */
+	public void addOperationResult(final URIish uri, final PushResult result) {
+		urisEntries.put(uri, new Entry(result));
+	}
+
+	/**
+	 * Add error message for the repository (URI) with unsuccessful connection.
+	 * 
+	 * @param uri
+	 *            remote repository URI.
+	 * @param errorMessage
+	 *            failure error message.
+	 */
+	public void addOperationResult(final URIish uri, final String errorMessage) {
+		urisEntries.put(uri, new Entry(errorMessage));
+	}
+
+	/**
+	 * @return set of remote repositories URIis. Set is ordered in addition
+	 *         sequence, which is usually the same as that from
+	 *         {@link PushOperationSpecification}.
+	 */
+	public Set<URIish> getURIs() {
+		return Collections.unmodifiableSet(urisEntries.keySet());
+	}
+
+	/**
+	 * @param uri
+	 *            remote repository URI.
+	 * @return true if connection was successful for this repository (URI),
+	 *         false if this operation ended with unsuccessful connection.
+	 */
+	public boolean isSuccessfulConnection(final URIish uri) {
+		return urisEntries.get(uri).isSuccessfulConnection();
+	}
+
+	/**
+	 * @return true if connection was successful for any repository (URI), false
+	 *         otherwise.
+	 */
+	public boolean isSuccessfulConnectionForAnyURI() {
+		for (final URIish uri : getURIs()) {
+			if (isSuccessfulConnection(uri))
+				return true;
+		}
+		return false;
+	}
+
+	/**
+	 * @param uri
+	 *            remote repository URI.
+	 * @return push result for this repository (URI) or null if operation ended
+	 *         with unsuccessful connection for this URI.
+	 */
+	public PushResult getPushResult(final URIish uri) {
+		return urisEntries.get(uri).getResult();
+	}
+
+	/**
+	 * @param uri
+	 *            remote repository URI.
+	 * @return error message for this repository (URI) or null if operation
+	 *         ended with successful connection for this URI.
+	 */
+	public String getErrorMessage(final URIish uri) {
+		return urisEntries.get(uri).getErrorMessage();
+	}
+
+	/**
+	 * @return string being list of failed URIs with their error messages.
+	 */
+	public String getErrorStringForAllURis() {
+		final StringBuilder sb = new StringBuilder();
+		boolean first = true;
+		for (final URIish uri : getURIs()) {
+			if (first)
+				first = false;
+			else
+				sb.append(", ");
+			sb.append(uri);
+			sb.append(" (");
+			sb.append(getErrorMessage(uri));
+			sb.append(")");
+		}
+		return sb.toString();
+	}
+
+	/**
+	 * Derive push operation specification from this push operation result.
+	 * <p>
+	 * Specification is created basing on URIs of remote repositories in this
+	 * result that completed without connection errors, and remote ref updates
+	 * from push results.
+	 * <p>
+	 * This method is targeted to provide support for 2-stage push, where first
+	 * operation is dry run for user confirmation and second one is a real
+	 * operation.
+	 * 
+	 * @param requireUnchanged
+	 *            if true, newly created copies of remote ref updates have
+	 *            expected old object id set to previously advertised ref value
+	 *            (remote ref won't be updated if it change in the mean time),
+	 *            if false, newly create copies of remote ref updates have
+	 *            expected object id set up as in this result source
+	 *            specification.
+	 * @return derived specification for another push operation.
+	 * @throws IOException
+	 *             when some previously locally available source ref is not
+	 *             available anymore, or some error occurred during creation
+	 *             locally tracking ref update.
+	 * 
+	 */
+	public PushOperationSpecification deriveSpecification(
+			final boolean requireUnchanged) throws IOException {
+		final PushOperationSpecification spec = new PushOperationSpecification();
+		for (final URIish uri : getURIs()) {
+			final PushResult pr = getPushResult(uri);
+			if (pr == null)
+				continue;
+
+			final Collection<RemoteRefUpdate> oldUpdates = pr
+					.getRemoteUpdates();
+			final ArrayList<RemoteRefUpdate> newUpdates = new ArrayList<RemoteRefUpdate>(
+					oldUpdates.size());
+			for (final RemoteRefUpdate rru : oldUpdates) {
+				final ObjectId expectedOldObjectId;
+				if (requireUnchanged) {
+					final Ref advertisedRef = getPushResult(uri)
+							.getAdvertisedRef(rru.getRemoteName());
+					if (advertisedRef == null)
+						expectedOldObjectId = ObjectId.zeroId();
+					else
+						expectedOldObjectId = advertisedRef.getObjectId();
+				} else
+					expectedOldObjectId = rru.getExpectedOldObjectId();
+				final RemoteRefUpdate newRru = new RemoteRefUpdate(rru,
+						expectedOldObjectId);
+				newUpdates.add(newRru);
+			}
+			spec.addURIRefUpdates(uri, newUpdates);
+		}
+		return spec;
+	}
+
+	/**
+	 * This implementation returns true if all following conditions are met:
+	 * <ul>
+	 * <li>both objects result have the same set successfully connected
+	 * repositories (URIs) - unsuccessful connections are discarded, AND <li>
+	 * remote ref updates must match for each successful connection in sense of
+	 * equal remoteName, equal status and equal newObjectId value.</li>
+	 * </ul>
+	 * 
+	 * @see Object#equals(Object)
+	 * @param obj
+	 *            other push operation result to compare to.
+	 * @return true if object is equal to this one in terms of conditions
+	 *         described above, false otherwise.
+	 */
+	@Override
+	public boolean equals(final Object obj) {
+		if (!(obj instanceof PushOperationResult))
+			return false;
+
+		final PushOperationResult other = (PushOperationResult) obj;
+
+		// Check successful connections/URIs two-ways:
+		final Set<URIish> otherURIs = other.getURIs();
+		for (final URIish uri : getURIs()) {
+			if (isSuccessfulConnection(uri)
+					&& (!otherURIs.contains(uri) || !other
+							.isSuccessfulConnection(uri)))
+				return false;
+		}
+		for (final URIish uri : other.getURIs()) {
+			if (other.isSuccessfulConnection(uri)
+					&& (!urisEntries.containsKey(uri) || !isSuccessfulConnection(uri)))
+				return false;
+		}
+
+		for (final URIish uri : getURIs()) {
+			if (!isSuccessfulConnection(uri))
+				continue;
+
+			final PushResult otherPushResult = other.getPushResult(uri);
+			for (final RemoteRefUpdate rru : getPushResult(uri)
+					.getRemoteUpdates()) {
+				final RemoteRefUpdate otherRru = otherPushResult
+						.getRemoteUpdate(rru.getRemoteName());
+				if (otherRru == null)
+					return false;
+				if (otherRru.getStatus() != rru.getStatus()
+						|| otherRru.getNewObjectId() != rru.getNewObjectId())
+					return false;
+			}
+		}
+		return true;
+	}
+
+	private static class Entry {
+		private String errorMessage;
+
+		private PushResult result;
+
+		Entry(final PushResult result) {
+			this.result = result;
+		}
+
+		Entry(final String errorMessage) {
+			this.errorMessage = errorMessage;
+		}
+
+		boolean isSuccessfulConnection() {
+			return result != null;
+		}
+
+		String getErrorMessage() {
+			return errorMessage;
+		}
+
+		PushResult getResult() {
+			return result;
+		}
+	}
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java
new file mode 100644
index 0000000..0e3f3b4
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java
@@ -0,0 +1,82 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.op;
+
+import java.util.Collection;
+import java.util.Collections;
+import java.util.LinkedHashMap;
+import java.util.Set;
+
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Data class storing push operation update specifications for each remote
+ * repository.
+ * <p>
+ * One instance is dedicated for one push operation: either push to one URI or
+ * to many URIs.
+ * 
+ * @see PushOperation
+ */
+public class PushOperationSpecification {
+	private LinkedHashMap<URIish, Collection<RemoteRefUpdate>> urisRefUpdates;
+
+	/**
+	 * Create empty instance of specification.
+	 * <p>
+	 * URIs and ref updates should be configured
+	 * {@link #addURIRefUpdates(URIish, Collection)} method.
+	 */
+	public PushOperationSpecification() {
+		this.urisRefUpdates = new LinkedHashMap<URIish, Collection<RemoteRefUpdate>>();
+	}
+
+	/**
+	 * Add remote repository URI with ref updates specification.
+	 * <p>
+	 * Ref updates are not in constructor - pay attention to not share them
+	 * between different URIs ref updates or push operations.
+	 * <p>
+	 * Note that refUpdates can differ between URIs <b>only</b> by expected old
+	 * object id field: {@link RemoteRefUpdate#getExpectedOldObjectId()}.
+	 * 
+	 * @param uri
+	 *            remote repository URI.
+	 * @param refUpdates
+	 *            collection of remote ref updates specifications.
+	 */
+	public void addURIRefUpdates(final URIish uri,
+			Collection<RemoteRefUpdate> refUpdates) {
+		urisRefUpdates.put(uri, refUpdates);
+	}
+
+	/**
+	 * @return set of remote repositories URIis. Set is ordered in addition
+	 *         sequence.
+	 */
+	public Set<URIish> getURIs() {
+		return Collections.unmodifiableSet(urisRefUpdates.keySet());
+	}
+
+	/**
+	 * @return number of remote repositories URI for this push operation.
+	 */
+	public int getURIsNumber() {
+		return urisRefUpdates.keySet().size();
+	}
+
+	/**
+	 * @param uri
+	 *            remote repository URI.
+	 * @return remote ref updates as specified by user for this URI.
+	 */
+	public Collection<RemoteRefUpdate> getRefUpdates(final URIish uri) {
+		return Collections.unmodifiableCollection(urisRefUpdates.get(uri));
+	}
+}
-- 
1.5.6.3
