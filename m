From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/6] Javadoc update for Egit
Date: Tue,  5 Feb 2008 01:15:32 +0100
Message-ID: <1202170534-15788-5-git-send-email-robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-4-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 01:43:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBtt-0001DL-SO
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386AbYBEAmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756915AbYBEAmV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:42:21 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18395 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbYBEAmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:42:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A217E80068E;
	Tue,  5 Feb 2008 01:15:48 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2LKcab7QrJW; Tue,  5 Feb 2008 01:15:46 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3496B800691;
	Tue,  5 Feb 2008 01:15:34 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 4A085290F3; Tue,  5 Feb 2008 01:15:34 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202170534-15788-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72600>

Also includes reduced visibility for a few methods.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/core/Activator.java       |   31 +++++++
 .../src/org/spearce/egit/core/CoreText.java        |   29 +++++++
 .../spearce/egit/core/GitIndexFileRevision.java    |    8 ++
 .../src/org/spearce/egit/core/GitProvider.java     |    7 ++
 .../src/org/spearce/egit/core/GitStorage.java      |   10 ++
 .../src/org/spearce/egit/core/GitTag.java          |    7 ++
 .../egit/core/GitWorkspaceFileRevision.java        |   13 +++
 .../org/spearce/egit/core/internal/UpdateJob.java  |   10 ++
 .../internal/mapping/GitCommitFileRevision.java    |   19 ++++
 .../egit/core/internal/mapping/GitFileHistory.java |   22 +++++
 .../internal/mapping/GitFileHistoryProvider.java   |   22 +++++-
 .../core/internal/mapping/GitFileRevision.java     |   34 ++++++++
 .../org/spearce/egit/core/op/BranchOperation.java  |    9 ++
 .../org/spearce/egit/core/op/ResetOperation.java   |   22 +++++
 .../spearce/egit/core/project/CheckpointJob.java   |    9 ++
 .../spearce/egit/core/project/GitProjectData.java  |   60 +++++++++++++-
 .../egit/core/project/RepositoryMapping.java       |   87 ++++++++++++++++----
 17 files changed, 379 insertions(+), 20 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/Activator.java b/org.spearce.egit.core/src/org/spearce/egit/core/Activator.java
index e3dc3a5..214de61 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/Activator.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/Activator.java
@@ -24,22 +24,45 @@ import org.eclipse.core.runtime.Status;
 import org.osgi.framework.BundleContext;
 import org.spearce.egit.core.project.GitProjectData;
 
+/**
+ * The plugin class for the org.spearce.egit.core plugin. This
+ * is a singleton class.
+ */
 public class Activator extends Plugin {
 	private static Activator plugin;
 
+	/**
+	 * @return the singleton {@link Activator}
+	 */
 	public static Activator getDefault() {
 		return plugin;
 	}
 
+	/**
+	 * @return the name of this plugin
+	 */
 	public static String getPluginId() {
 		return getDefault().getBundle().getSymbolicName();
 	}
 
+	/**
+	 * Utility method to help throwing errors in the Egit plugin. This method
+	 * does not actually throw the exception, but just creates an instance.
+	 *
+	 * @param message User comprehensible message
+	 * @param thr cause
+	 * @return an Initialized {@link CoreException}
+	 */
 	public static CoreException error(final String message, final Throwable thr) {
 		return new CoreException(new Status(IStatus.ERROR, getPluginId(), 0,
 				message, thr));
 	}
 
+	/**
+	 * Utility method to log errors in the Egit plugin.
+	 * @param message User comprehensible message
+	 * @param thr The exception through which we noticed the error
+	 */
 	public static void logError(final String message, final Throwable thr) {
 		getDefault().getLog().log(
 				new Status(IStatus.ERROR, getPluginId(), 0, message, thr));
@@ -51,6 +74,11 @@ public class Activator extends Plugin {
 		return value != null && value.equals("true");
 	}
 
+	/**
+	 * Utility method for debug logging.
+	 *
+	 * @param what
+	 */
 	public static void trace(final String what) {
 		if (getDefault().traceVerbose) {
 			System.out.println("[" + getPluginId() + "] " + what);
@@ -59,6 +87,9 @@ public class Activator extends Plugin {
 
 	private boolean traceVerbose;
 
+	/**
+	 * Construct the {@link Activator} singleton instance
+	 */
 	public Activator() {
 		plugin = this;
 	}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
index 7281c90..e1e1cb3 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
@@ -18,57 +18,86 @@ package org.spearce.egit.core;
 
 import org.eclipse.osgi.util.NLS;
 
+/**
+ * Possibly Translated strings for the Egit plugin.
+ */
 public class CoreText extends NLS {
+	/** */
 	public static String AssumeUnchangedOperation_failed;
 
+	/** */
 	public static String AssumeUnchangedOperation_adding;
 
+	/** */
 	public static String UpdateOperation_updating;
 
+	/** */
 	public static String UpdateOperation_failed;
 
+	/** */
 	public static String ConnectProviderOperation_connecting;
 
+	/** */
 	public static String ConnectProviderOperation_creating;
 
+	/** */
 	public static String ConnectProviderOperation_recordingMapping;
 
+	/** */
 	public static String ConnectProviderOperation_updatingCache;
 
+	/** */
 	public static String DisconnectProviderOperation_disconnecting;
 
+	/** */
 	public static String AddOperation_adding;
 
+	/** */
 	public static String AddOperation_failed;
 
+	/** */
 	public static String UntrackOperation_adding;
 
+	/** */
 	public static String UntrackOperation_failed;
 
+	/** */
 	public static String GitProjectData_lazyResolveFailed;
 
+	/** */
 	public static String GitProjectData_mappedResourceGone;
 
+	/** */
 	public static String GitProjectData_cannotReadHEAD;
 
+	/** */
 	public static String GitProjectData_missing;
 
+	/** */
 	public static String GitProjectData_saveFailed;
 
+	/** */
 	public static String GitProjectData_notifyChangedFailed;
 
+	/** */
 	public static String RepositoryFinder_finding;
 
+	/** */
 	public static String MoveDeleteHook_cannotModifyFolder;
 
+	/** */
 	public static String MoveDeleteHook_operationError;
 
+	/** */
 	public static String Error_CanonicalFile;
 
+	/** */
 	public static String CheckpointJob_writing;
 
+	/** */
 	public static String CheckpointJob_name;
 
+	/** */
 	public static String CheckpointJob_failed;
 
 	static {
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitIndexFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitIndexFileRevision.java
index 9ef272c..daae33b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitIndexFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitIndexFileRevision.java
@@ -24,9 +24,17 @@ import org.eclipse.team.core.history.IFileRevision;
 import org.spearce.egit.core.internal.mapping.GitFileRevision;
 import org.spearce.jgit.lib.ObjectId;
 
+/**
+ * An {@link IFileRevision} for the version in the Git index.
+ */
 public class GitIndexFileRevision extends GitFileRevision implements
 		IFileRevision {
 
+	/**
+	 * Construct a GitIndexFileRevision matching a certain resource.
+	 * @param resource The corresponding workspace resource
+	 * @param count index into the full list of results
+	 */
 	public GitIndexFileRevision(IResource resource, int count) {
 		super(resource, count);
 	}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
index f31eec5..e42f6fa 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
@@ -23,6 +23,9 @@ import org.eclipse.team.core.history.IFileHistoryProvider;
 import org.spearce.egit.core.internal.mapping.GitFileHistoryProvider;
 import org.spearce.egit.core.project.GitProjectData;
 
+/**
+ * The Team provider class for a Git repository.
+ */
 public class GitProvider extends RepositoryProvider {
 	private GitProjectData data;
 
@@ -53,6 +56,10 @@ public class GitProvider extends RepositoryProvider {
 		return hook;
 	}
 
+	/**
+	 * @return information about the mapping of an Eclipse project
+	 * to a Git repository.
+	 */
 	public synchronized GitProjectData getData() {
 		if (data == null) {
 			data = GitProjectData.get(getProject());
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
index f791e31..86943ed 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
@@ -36,6 +36,9 @@ import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 import org.spearce.jgit.lib.GitIndex.Entry;
 
+/**
+ * Implements access to a Git managed version of a resource.
+ */
 public class GitStorage implements IStorage {
 
 	private final IResource resource;
@@ -44,6 +47,13 @@ public class GitStorage implements IStorage {
 
 	private ObjectId treeId;
 
+	/**
+	 * Construct an GitStorage instance corresponding to
+	 * a certain workspace resource.
+	 *
+	 * @param treeId
+	 * @param resource
+	 */
 	public GitStorage(ObjectId treeId, IResource resource) {
 		this.treeId = treeId;
 		this.resource = resource;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitTag.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitTag.java
index b8d7c11..86b908c 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitTag.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitTag.java
@@ -18,10 +18,17 @@ package org.spearce.egit.core;
 
 import org.eclipse.team.core.history.ITag;
 
+/**
+ * A representation of a Git tag in Eclipse.
+ */
 public class GitTag implements ITag {
 
 	private String name;
 
+	/**
+	 * Construct a GitTag object with a give name.
+	 * @param name the Git tag name
+	 */
 	public GitTag(String name) {
 		this.name = name;
 	}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
index aad79b4..7142671 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
@@ -23,9 +23,22 @@ import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.team.core.history.IFileRevision;
 import org.spearce.egit.core.internal.mapping.GitFileRevision;
 
+/**
+ * An {@link IFileRevision} for the version in workspace.
+ */
 public class GitWorkspaceFileRevision extends GitFileRevision implements
 		IFileRevision {
 
+	/**
+	 * Construct a GitWorkspaceFileRevision matching a certain resource. This is
+	 * the same as the resource, which the possible distinction that this is the
+	 * version on disk when unsaved.
+	 *
+	 * @param resource
+	 *            The corresponding workspace resource
+	 * @param count
+	 *            index into the full list of results
+	 */
 	public GitWorkspaceFileRevision(IResource resource, int count) {
 		super(resource, count);
 	}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java
index 72b4190..a1476bf 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java
@@ -40,10 +40,20 @@ import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.GitIndex.Entry;
 
+/**
+ * This job updates the index with the content of all specified
+ * and tracked resources. If a project is selected all tracked
+ * resources withing that container are updated.
+ */
 public class UpdateJob extends Job {
 
 	private final Collection rsrcList;
 
+	/**
+	 * Construct an UpdateJob for the specified resources.
+	 *
+	 * @param rsrcList
+	 */
 	public UpdateJob(Collection rsrcList) {
 		super("Update index");
 		this.rsrcList = rsrcList;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java
index 6d6f7ea..0ed5a92 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java
@@ -38,10 +38,21 @@ import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 
+/**
+ * An {@link IFileRevision} for a version of a specified resource in the
+ * specified commit (revision).
+ */
 public class GitCommitFileRevision extends GitFileRevision {
 
 	private final ObjectId commitId;
 
+	/**
+	 * Construct a {@link GitCommitFileRevision} for a resource in a specified commit.
+	 *
+	 * @param commitId
+	 * @param resource
+	 * @param count index to full list of commits.
+	 */
 	public GitCommitFileRevision(ObjectId commitId, IResource resource, int count) {
 		super(resource, count);
 		this.commitId = commitId;
@@ -109,6 +120,11 @@ public class GitCommitFileRevision extends GitFileRevision {
 		return (ITag[]) ret.toArray(new ITag[ret.size()]);
 	}
 
+	/**
+	 * Maps the commit id of this object and
+	 *
+	 * @return the {@link Commit} object this {@link IFileRevision} refers to
+	 */
 	public Commit getCommit() {
 		try {
 			return RepositoryMapping.getMapping(getResource()).getRepository().mapCommit(commitId);
@@ -121,6 +137,9 @@ public class GitCommitFileRevision extends GitFileRevision {
 		return commitId;
 	}
 
+	/**
+	 * @return the {@link TreeEntry} this {@link IFileRevision} refers to.
+	 */
 	public TreeEntry getTreeEntry() {
 		RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(getResource());
 		Tree tree;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 2d06405..d1e5733 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -48,6 +48,11 @@ import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 import org.spearce.jgit.lib.GitIndex.Entry;
 
+/**
+ * A list of revisions for a specific resource according to some
+ * filtering criterion. Though git really does not do file tracking,
+ * this corresponds to listing all files with the same path.
+ */
 public class GitFileHistory extends FileHistory implements IAdaptable {
 
 	private final IResource resource;
@@ -60,6 +65,20 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 
 	private final boolean returnAll;
 
+	/**
+	 * Construct a {@link GitFileHistory} object for a given resource (path)
+	 * with some filtering applied. The filter could reduces the number of
+	 * commitgs returned or just mark some versions as interesting.
+	 *
+	 * @param resource
+	 * @param flags
+	 *            See {@link IFileHistoryProvider}
+	 * @param monitor
+	 *            progress reporting facility
+	 * @param returnAll
+	 *            true if all versions should be collected even if the filter
+	 *            does not match.
+	 */
 	public GitFileHistory(IResource resource, int flags, IProgressMonitor monitor, boolean returnAll) {
 		this.resource = resource;
 		this.flags = flags;
@@ -160,6 +179,9 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 		return revisions.toArray(new IFileRevision[revisions.size()]);
 	}
 
+	/**
+	 * @return the list of revisions. The list may be lazy-evaluated.
+	 */
 	public List<IFileRevision> getFileRevisionsList() {
 		return revisions;
 	}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
index 298009f..eb7961b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
@@ -25,13 +25,16 @@ import org.eclipse.team.core.history.IFileRevision;
 import org.eclipse.team.core.history.provider.FileHistoryProvider;
 import org.spearce.egit.core.GitWorkspaceFileRevision;
 
+/**
+ * A {@link FileHistoryProvider} for Git. This class has methods for
+ * retrieving specific versions of a tracked resource.
+ */
 public class GitFileHistoryProvider extends FileHistoryProvider implements
 		IFileHistoryProvider {
 
 	public IFileHistory getFileHistoryFor(IResource resource, int flags,
 			IProgressMonitor monitor) {
-		// TODO: implement flags
-		return new GitFileHistory(resource, flags, monitor, false); // TODO: implement flags
+		return new GitFileHistory(resource, flags, monitor, false);
 	}
 
 	public IFileRevision getWorkspaceFileRevision(IResource resource) {
@@ -44,6 +47,21 @@ public class GitFileHistoryProvider extends FileHistoryProvider implements
 		return null;
 	}
 
+	/**
+	 * Get the history for a given resource as viewed using the specified
+	 * filtering flags.
+	 *
+	 * @param resource
+	 * @param flags
+	 *            See {@link IFileHistoryProvider}
+	 * @param monitor
+	 *            progress monitor
+	 * @param returnAll
+	 *            true if all revisions are returned and interesting revisiosn.
+	 *
+	 * @return a {@link GitFileHistory} object.
+	 *
+	 */
 	public GitFileHistory getHistoryFor(IResource resource, int flags, IProgressMonitor monitor, boolean returnAll) {
 		return new GitFileHistory(resource, flags, monitor, returnAll); // TODO: implement flags
 	}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
index e11a24c..c309b9d 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
@@ -26,6 +26,11 @@ import org.eclipse.team.core.history.provider.FileRevision;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.TopologicalSorter;
 
+/**
+ * A Git related {@link IFileRevision}. It references a version
+ * and a resource, i.e. the version we think corresponds to the
+ * resource in specific version.
+ */
 public abstract class GitFileRevision extends FileRevision {
 
 	private final IResource resource;
@@ -34,6 +39,12 @@ public abstract class GitFileRevision extends FileRevision {
 
 	private TopologicalSorter<ObjectId>.Lane lane;
 
+	/**
+	 * Construct a {@link GitFileRevision}
+	 *
+	 * @param resource
+	 * @param count index into the full list of commits
+	 */
 	public GitFileRevision(IResource resource, int count) {
 		this.count = count;
 		this.resource = resource;
@@ -56,20 +67,43 @@ public abstract class GitFileRevision extends FileRevision {
 		return resource.getLocationURI();
 	}
 
+	/**
+	 * @return the {@link IResource} the {@link IFileRevision} refers to.
+	 */
 	public IResource getResource() {
 		return resource;
 	}
 
+	/**
+	 * @deprecated
+	 * @return index into full list of versions
+	 */
 	public int getCount() {
 		return count;
 	}
 
+	/**
+	 * @return the swim lane assigned by the graph layout
+	 */
 	public TopologicalSorter<ObjectId>.Lane getLane() {
 		return lane;
 	}
 
+	/**
+	 * Set the swim where this revision is found. Invoked by the
+	 * graph layout.
+	 *
+	 * @param lane
+	 */
 	public void setLane(TopologicalSorter<ObjectId>.Lane lane) {
 		this.lane = lane;
 	}
 
+	/**
+	 * @return the ObjectId this IFileRevision refers to.
+	 */
+	public ObjectId getCommitId() {
+		return null;
+	}
+
 }
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java
index f3a0ccb..f1d6cf7 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java
@@ -34,12 +34,21 @@ import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.WorkDirCheckout;
 
+/**
+ * This class implements checkouts of a specific revision. A check
+ * is made that this can be done without data loss.
+ */
 public class BranchOperation implements IWorkspaceRunnable {
 
 	private final Repository repository;
 
 	private final String refName;
 
+	/**
+	 * Construct a {@link BranchOperation} object.
+	 * @param repository
+	 * @param refName Name of git ref to checkout
+	 */
 	public BranchOperation(Repository repository, String refName) {
 		this.repository = repository;
 		this.refName = refName;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java
index 3c5b9bb..9fd5db1 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java
@@ -36,10 +36,25 @@ import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.WorkDirCheckout;
 
+/**
+ * An class for changing a ref and possibly index and workdir too.
+ */
 public class ResetOperation implements IWorkspaceRunnable {
+	/**
+	 * Kind of reset
+	 */
 	public enum ResetType {
+		/**
+		 * Just change the ref. The index and workdir are not changed.
+		 */
 		SOFT,
+		/**
+		 * Change the ref and the index. The workdir is not changed.
+		 */
 		MIXED,
+		/**
+		 * Change the ref, the index and the workdir
+		 */
 		HARD
 	}
 	
@@ -52,6 +67,13 @@ public class ResetOperation implements IWorkspaceRunnable {
 	private Tree newTree;
 	private GitIndex index;
 
+	/**
+	 * Construct a {@link ResetOperation}
+	 *
+	 * @param repository
+	 * @param refName
+	 * @param type
+	 */
 	public ResetOperation(Repository repository, String refName, ResetType type) {
 		this.repository = repository;
 		this.refName = refName;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/CheckpointJob.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/CheckpointJob.java
index acc8f1f..bc8e8ed 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/CheckpointJob.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/CheckpointJob.java
@@ -31,10 +31,19 @@ import org.spearce.egit.core.CoreText;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.GitIndex.Entry;
 
+/**
+ * This class updates the index with the content of all resources tracked by git
+ * in the index.
+ */
 public class CheckpointJob extends Job {
 
 	private final RepositoryMapping rm;
 
+	/**
+	 * Construct a {@link CheckpointJob} for the specified resource maping
+	 *
+	 * @param m
+	 */
 	public CheckpointJob(final RepositoryMapping m) {
 		super(NLS.bind(CoreText.CheckpointJob_name, m.getContainer()
 				.getFullPath()));
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 97bb282..9e4cd87 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -48,6 +48,10 @@ import org.spearce.egit.core.CoreText;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.jgit.lib.Repository;
 
+/**
+ * This class keeps information about how a project is mapped to
+ * a Git repository.
+ */
 public class GitProjectData {
 	private static final Map projectDataCache = new HashMap();
 
@@ -78,6 +82,11 @@ public class GitProjectData {
 		}
 	}
 
+	/**
+	 * Start listening for resource changes.
+	 *
+	 * @param includeChange true to listen to content changes
+	 */
 	public static void attachToWorkspace(final boolean includeChange) {
 		trace("attachToWorkspace - addResourceChangeListener");
 		ResourcesPlugin.getWorkspace().addResourceChangeListener(
@@ -87,6 +96,9 @@ public class GitProjectData {
 						| IResourceChangeEvent.PRE_DELETE);
 	}
 
+	/**
+	 * Stop listening to resource changes
+	 */
 	public static void detachFromWorkspace() {
 		trace("detachFromWorkspace - removeResourceChangeListener");
 		ResourcesPlugin.getWorkspace().removeResourceChangeListener(rcl);
@@ -134,6 +146,10 @@ public class GitProjectData {
 		return repositoryChangeListeners;
 	}
 
+	/**
+	 * @param p
+	 * @return {@link GitProjectData} for the specified project
+	 */
 	public synchronized static GitProjectData get(final IProject p) {
 		try {
 			GitProjectData d = lookup(p);
@@ -149,6 +165,11 @@ public class GitProjectData {
 		}
 	}
 
+	/**
+	 * Drop the Eclipse project from our assocation of projects/repositories
+	 *
+	 * @param p Eclipse project
+	 */
 	public static void delete(final IProject p) {
 		trace("delete(" + p.getName() + ")");
 		GitProjectData d = lookup(p);
@@ -218,6 +239,12 @@ public class GitProjectData {
 
 	private final Set protectedResources;
 
+	/**
+	 * Construct a {@link GitProjectData} for the mapping
+	 * of a project.
+	 *
+	 * @param p Eclipse project
+	 */
 	public GitProjectData(final IProject p) {
 		project = p;
 		mappings = new ArrayList();
@@ -225,16 +252,29 @@ public class GitProjectData {
 		protectedResources = new HashSet();
 	}
 
+	/**
+	 * @return the Eclipse project mapped through this resource.
+	 */
 	public IProject getProject() {
 		return project;
 	}
 
+	/**
+	 * TODO: is this right?
+	 *
+	 * @param newMappings
+	 */
 	public void setRepositoryMappings(final Collection newMappings) {
 		mappings.clear();
 		mappings.addAll(newMappings);
 		remapAll();
 	}
 
+	/**
+	 * Hide our private parts from the navigators other browsers.
+	 *
+	 * @throws CoreException
+	 */
 	public void markTeamPrivateResources() throws CoreException {
 		final Iterator i = c2mapping.entrySet().iterator();
 		while (i.hasNext()) {
@@ -258,15 +298,26 @@ public class GitProjectData {
 		}
 	}
 
+	/**
+	 * @param f
+	 * @return true if a resource is protected in this repository
+	 */
 	public boolean isProtected(final IResource f) {
 		return protectedResources.contains(f);
 	}
 
+	/**
+	 * TODO: check usage, we should probably declare the parameter
+	 * as IProject.
+	 *
+	 * @param r Eclipse project
+	 * @return the mapping for the specified project
+	 */
 	public RepositoryMapping getRepositoryMapping(final IResource r) {
 		return (RepositoryMapping) c2mapping.get(r);
 	}
 
-	public void delete() {
+	private void delete() {
 		final File dir = propertyFile().getParentFile();
 		final File[] todel = dir.listFiles();
 		if (todel != null) {
@@ -281,6 +332,11 @@ public class GitProjectData {
 		uncache(getProject());
 	}
 
+	/**
+	 * Store information about the repository connection in the workspace
+	 *
+	 * @throws CoreException
+	 */
 	public void store() throws CoreException {
 		final File dat = propertyFile();
 		final File tmp;
@@ -385,7 +441,7 @@ public class GitProjectData {
 			// We are in deep trouble. This should NOT have happend. Detach
 			// our listeners and forget it ever did.
 			//
-			attachToWorkspace(false);
+			detachFromWorkspace();
 			Activator.logError(CoreText.GitProjectData_notifyChangedFailed, ce);
 		}
 
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index b062a29..754a172 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -37,8 +37,11 @@ import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 import org.spearce.jgit.lib.GitIndex.Entry;
 
+/**
+ * This class keeps track
+ */
 public class RepositoryMapping {
-	public static boolean isInitialKey(final String key) {
+	static boolean isInitialKey(final String key) {
 		return key.endsWith(".gitdir");
 	}
 
@@ -52,6 +55,12 @@ public class RepositoryMapping {
 
 	private IContainer container;
 
+	/**
+	 * Construct a {@link RepositoryMapping} for a previously connected project.
+	 *
+	 * @param p TODO
+	 * @param initialKey TODO
+	 */
 	public RepositoryMapping(final Properties p, final String initialKey) {
 		final int dot = initialKey.lastIndexOf('.');
 		String s;
@@ -62,6 +71,14 @@ public class RepositoryMapping {
 		subset = "".equals(s) ? null : s;
 	}
 
+	/**
+	 * Construct a {@link RepositoryMapping} for previously
+	 * unknown project.
+	 *
+	 * @param mappedContainer
+	 * @param gitDir
+	 * @param subsetRoot
+	 */
 	public RepositoryMapping(final IContainer mappedContainer,
 			final File gitDir, final String subsetRoot) {
 		final IPath cLoc = mappedContainer.getLocation()
@@ -103,55 +120,75 @@ public class RepositoryMapping {
 		}
 	}
 
-	public IPath getContainerPath() {
+	IPath getContainerPath() {
 		return Path.fromPortableString(containerPath);
 	}
 
-	public IPath getGitDirPath() {
+	IPath getGitDirPath() {
 		return Path.fromPortableString(gitdirPath);
 	}
 
+	/**
+	 * Eclipse projects typically reside one or more levels
+	 * below the repository. This method return the relative
+	 * path to the project. Null is returned instead of "".
+	 *
+	 * @return relative path from repository to project, or null
+	 */
 	public String getSubset() {
 		return subset;
 	}
 
+	/**
+	 * @return the workdir file, i.e. where the files are checked out
+	 */
 	public File getWorkDir() {
-//		assert containerPath.endsWith("/" + subset);
-//		return Path.fromPortableString(
-//				containerPath.substring(containerPath.length() - 1
-//						- subset.length())).toFile();
 		return getRepository().getDirectory().getParentFile();
 	}
 
-	public synchronized void clear() {
+	synchronized void clear() {
 		db = null;
 		container = null;
 	}
 
+	/**
+	 * @return a reference to the repository object handled by this mapping
+	 */
 	public synchronized Repository getRepository() {
 		return db;
 	}
 
-	public synchronized void setRepository(final Repository r) {
+	synchronized void setRepository(final Repository r) {
 		db = r;
 	}
 
+	/**
+	 * @return the mapped container (currently project)
+	 */
 	public synchronized IContainer getContainer() {
 		return container;
 	}
 
-	public synchronized void setContainer(final IContainer c) {
+	synchronized void setContainer(final IContainer c) {
 		container = c;
 	}
 
-	public synchronized void fullUpdate() {
-		recomputeMerge();
-	}
-
+	/**
+	 * @deprecated, leftover from the old "index"
+	 * TODO: rename or replace
+	 */
 	public synchronized void recomputeMerge() {
 		GitProjectData.fireRepositoryChanged(this);
 	}
 
+	/**
+	 * Retrieve the Git tree object matching the currently
+	 * checked out version.
+	 *
+	 * @return the Git Tree matching the container mapped
+	 * @throws IOException on general problems accessing the repository
+	 * @throws MissingObjectException something is missing
+	 */
 	public synchronized Tree mapHEADTree() throws IOException,
 			MissingObjectException {
 		Tree head = getRepository().mapTree(Constants.HEAD);
@@ -168,7 +205,7 @@ public class RepositoryMapping {
 		return head;
 	}
 
-	public synchronized void store(final Properties p) {
+	synchronized void store(final Properties p) {
 		p.setProperty(containerPath + ".gitdir", gitdirPath);
 		if (subset != null && !"".equals(subset)) {
 			p.setProperty(containerPath + ".subset", subset);
@@ -179,6 +216,19 @@ public class RepositoryMapping {
 		return "RepositoryMapping[" + containerPath + " -> " + gitdirPath + "]";
 	}
 
+	/**
+	 * Check whether a resource has been changed relative to the checked out
+	 * version. Content is assumed changed by this routine if the resource's
+	 * modification time differs from what is recorded in the index, but the
+	 * real content hasn't changed. The reason is performance.
+	 *
+	 * @param rsrc
+	 * @return true if a resource differs in the workdir or index relative to
+	 *         HEAD
+	 *
+	 * @throws IOException
+	 * @throws UnsupportedEncodingException
+	 */
 	public boolean isResourceChanged(IResource rsrc) throws IOException, UnsupportedEncodingException {
 		Repository repository = getRepository();
 		GitIndex index = repository.getIndex();
@@ -193,10 +243,13 @@ public class RepositoryMapping {
 		if (blob == null)
 			return true; // added in index
 		boolean hashesDiffer = !entry.getObjectId().equals(blob.getId());
-//		System.out.println("HashesDiffer: " + rsrc);
 		return hashesDiffer || entry.isModified(getWorkDir());
 	}
 
+	/**
+	 * @param rsrc
+	 * @return the path relative to the Git repository, including base name.
+	 */
 	public String getRepoRelativePath(IResource rsrc) {
 		String prefix = getSubset();
 		String projectRelativePath = rsrc.getProjectRelativePath().toString();
@@ -208,6 +261,8 @@ public class RepositoryMapping {
 				repoRelativePath = prefix + "/" + projectRelativePath;
 		} else
 			repoRelativePath = projectRelativePath;
+
+		assert repoRelativePath != null;
 		return repoRelativePath;
 	}
 
-- 
1.5.4.rc4.25.g81cc
