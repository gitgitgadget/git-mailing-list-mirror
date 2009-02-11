From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 08/12 v3] Add icon decoration for tracked and untracked resources
Date: Wed, 11 Feb 2009 23:46:24 +0100
Message-ID: <1234392384-31725-1-git-send-email-torarnv@gmail.com>
References: <200902112316.28646.robin.rosenberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 23:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXNqf-00025m-0V
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 23:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbZBKWou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbZBKWot
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:44:49 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:35240 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbZBKWos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:44:48 -0500
Received: by fxm13 with SMTP id 13so1323814fxm.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wci7+cOtG/hc+O2GMA1OlQ+WkcEm1eOomQcgHYpPKB8=;
        b=HEBkuluGxIII/KYuOxrNlqPp0YvRvMiEFfbMKq9fHFYKdTYDNa9lo1xadHBbtsVZt9
         3VdHpl5QMF3234bwX/t6gstvZtvkrIkjt8ST0hjaRH+yzQi2AsYpxb6MATdvlX3BmbuB
         vcDZwFbUH6SPUW6Ma300w3rROHwmNJ1k+s2Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=db1dF1yDg5xeI+OW03PN2JBI55tBGJuwU8YodnlEKHWOLwYxlCz/d7IVtrjuYZm9pR
         FrVK/xwQWwpi3Lc298MkyFyMVL6vanqobax0itvci0WuptDtDaPfC+tlnitKTegFjWUN
         l2EJzm06CNN8e/TxdQUUyeW6XwgV8UZJ8CQ9I=
Received: by 10.86.59.18 with SMTP id h18mr997361fga.45.1234392284187;
        Wed, 11 Feb 2009 14:44:44 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id e20sm45094fga.36.2009.02.11.14.44.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 14:44:43 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 633BC468001; Wed, 11 Feb 2009 23:46:23 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <200902112316.28646.robin.rosenberg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109540>

Can be enabled/disabled in the preferences

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---

Sorry, got a little trigger happy with the rebasing and messed up a mer=
ge :/=20

org.spearce.egit.ui/icons/ovr/shared.gif           |  Bin 106 -> 0 byte=
s
 org.spearce.egit.ui/icons/ovr/untracked.gif        |  Bin 0 -> 79 byte=
s
 .../egit/ui/PluginPreferenceInitializer.java       |    4 +-
 .../src/org/spearce/egit/ui/UIIcons.java           |    6 +-
 .../src/org/spearce/egit/ui/UIPreferences.java     |    4 +
 .../src/org/spearce/egit/ui/UIText.java            |    6 +
 .../decorators/GitLightweightDecorator.java        |  162 ++++++++++++=
++++++--
 .../internal/decorators/IDecoratableResource.java  |   15 ++
 .../preferences/GitDecoratorPreferencePage.java    |   89 +++++++++--
 .../src/org/spearce/egit/ui/uitext.properties      |    2 +
 10 files changed, 259 insertions(+), 29 deletions(-)
 delete mode 100644 org.spearce.egit.ui/icons/ovr/shared.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/untracked.gif

diff --git a/org.spearce.egit.ui/icons/ovr/shared.gif b/org.spearce.egi=
t.ui/icons/ovr/shared.gif
deleted file mode 100644
index eb71a3c742e133c2ed61c958e237c71e0f7cb6aa..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 106
zcmZ?wbhEHbWM|-D*v!E2|KHF5k5c|0Q~7_){{ITmE8U{M-dx?8EBgQce+Fzo@h1x-
p15m3DND^cQ1B<x8$xa82iYrMhmeJo^<v0pdEtw8K%o1d<1^~aoAP)cl

diff --git a/org.spearce.egit.ui/icons/ovr/untracked.gif b/org.spearce.=
egit.ui/icons/ovr/untracked.gif
new file mode 100644
index 0000000000000000000000000000000000000000..45ca32060700d71abcb88bb=
cdb1000d503fe11cf
GIT binary patch
literal 79
zcmZ?wbhEHbWM|-DSj51<z}U+mGMhnsAy57};pVIV!2l?%_>+Z^fq{)d2gqgssbydm
biP#m!(lAAgdxkboj%vJ&f(EaJDuXouU6m8v

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferen=
ceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Plugin=
PreferenceInitializer.java
index 79c2665..7465444 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
@@ -35,13 +35,15 @@ public void initializeDefaultPreferences() {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, tru=
e);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false)=
;
=20
+		prefs.setDefault(UIPreferences.DECORATOR_CALCULATE_DIRTY, true);
 		prefs.setDefault(UIPreferences.DECORATOR_FILETEXT_DECORATION,
 				UIText.DecoratorPreferencesPage_fileFormatDefault);
 		prefs.setDefault(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION,
 				UIText.DecoratorPreferencesPage_folderFormatDefault);
 		prefs.setDefault(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION,
 				UIText.DecoratorPreferencesPage_projectFormatDefault);
-		prefs.setDefault(UIPreferences.DECORATOR_CALCULATE_DIRTY, true);
+		prefs.setDefault(UIPreferences.DECORATOR_SHOW_TRACKED_ICON, true);
+		prefs.setDefault(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON, true);
=20
 		w =3D new int[] { 500, 500 };
 		UIPreferences.setDefault(prefs,
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b=
/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index ced186e..4c0d189 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -24,8 +24,8 @@
 	/** Decoration for resource removed from the index but not commit. */
 	public static final ImageDescriptor OVR_PENDING_REMOVE;
=20
-	/** Decoration for resource tracked and committed in git. */
-	public static final ImageDescriptor OVR_SHARED;
+	/** Decoration for resource not being tracked by Git */
+	public static final ImageDescriptor OVR_UNTRACKED;
=20
 	/** Decoration for tracked resource with a merge conflict.  */
 	public static final ImageDescriptor OVR_CONFLICT;
@@ -86,7 +86,7 @@
 		base =3D init();
 		OVR_PENDING_ADD =3D map("ovr/pending_add.gif");
 		OVR_PENDING_REMOVE =3D map("ovr/pending_remove.gif");
-		OVR_SHARED =3D map("ovr/shared.gif");
+		OVR_UNTRACKED =3D map("ovr/untracked.gif");
 		OVR_CONFLICT =3D map("ovr/conflict.gif");
 		OVR_ASSUMEVALID =3D map("ovr/assumevalid.gif");
 		ELCL16_FIND =3D map("elcl16/find.gif");
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.=
java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index a6168a0..7916cea 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -60,6 +60,10 @@
 	public final static String DECORATOR_FOLDERTEXT_DECORATION =3D "decor=
ator_foldertext_decoration";
 	/** */
 	public final static String DECORATOR_PROJECTTEXT_DECORATION =3D "deco=
rator_projecttext_decoration";
+	/** */
+	public final static String DECORATOR_SHOW_TRACKED_ICON =3D "decorator=
_show_tracked_icon";
+	/** */
+	public final static String DECORATOR_SHOW_UNTRACKED_ICON =3D "decorat=
or_show_untracked_icon";
=20
 	/**
 	 * Get the preference values associated with a fixed integer array.
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 345c66b..60e4eaa 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -988,6 +988,12 @@
 	/** */
 	public static String DecoratorPreferencesPage_labelDecorationsLink;
=20
+	/** */
+	public static String DecoratorPreferencesPage_iconsShowTracked;
+
+	/** */
+	public static String DecoratorPreferencesPage_iconsShowUntracked;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearc=
e/egit/ui/internal/decorators/GitLightweightDecorator.java
index 265d5a3..b20070a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
@@ -15,6 +15,7 @@
=20
 import java.io.IOException;
 import java.util.ArrayList;
+import java.util.Collections;
 import java.util.HashMap;
 import java.util.HashSet;
 import java.util.List;
@@ -34,6 +35,7 @@
 import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IStatus;
 import org.eclipse.jface.preference.IPreferenceStore;
+import org.eclipse.jface.resource.ImageDescriptor;
 import org.eclipse.jface.util.IPropertyChangeListener;
 import org.eclipse.jface.util.PropertyChangeEvent;
 import org.eclipse.jface.viewers.IDecoration;
@@ -41,7 +43,11 @@
 import org.eclipse.jface.viewers.LabelProvider;
 import org.eclipse.jface.viewers.LabelProviderChangedEvent;
 import org.eclipse.osgi.util.TextProcessor;
+import org.eclipse.swt.graphics.ImageData;
 import org.eclipse.swt.widgets.Display;
+import org.eclipse.team.core.Team;
+import org.eclipse.team.ui.ISharedImages;
+import org.eclipse.team.ui.TeamImages;
 import org.eclipse.team.ui.TeamUI;
 import org.eclipse.ui.IContributorResourceAdapter;
 import org.eclipse.ui.PlatformUI;
@@ -51,13 +57,22 @@
 import org.spearce.egit.core.project.RepositoryChangeListener;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheIterator;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.RepositoryChangedEvent;
 import org.spearce.jgit.lib.RepositoryListener;
+import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.treewalk.EmptyTreeIterator;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
=20
 /**
  * Supplies annotations for displayed resources
@@ -144,7 +159,7 @@ public void decorate(Object element, IDecoration de=
coration) {
 		if (!resource.exists() && !resource.isPhantom())
 			return;
=20
-		// Make sure we're dealing with a Git project
+		// Make sure we're dealing with a project under Git revision control
 		final RepositoryMapping mapping =3D RepositoryMapping
 				.getMapping(resource);
 		if (mapping =3D=3D null)
@@ -171,14 +186,80 @@ public void decorate(Object element, IDecoration =
decoration) {
=20
 	private class DecoratableResourceAdapter implements IDecoratableResou=
rce {
=20
-		private IResource resource;
-		private String branch;
+		private final IResource resource;
=20
-		public DecoratableResourceAdapter(IResource resourceToWrap) throws I=
OException {
+		private final RepositoryMapping mapping;
+
+		private final Repository repository;
+
+		private final ObjectId headId;
+
+		private String branch =3D "";
+
+		private boolean tracked =3D false;
+
+		private boolean ignored =3D false;
+
+		public DecoratableResourceAdapter(IResource resourceToWrap)
+				throws IOException {
 			resource =3D resourceToWrap;
-			RepositoryMapping mapping =3D RepositoryMapping.getMapping(resource=
);
-			Repository repository =3D mapping.getRepository();
+			mapping =3D RepositoryMapping.getMapping(resource);
+			repository =3D mapping.getRepository();
+			headId =3D repository.resolve(Constants.HEAD);
+
+			initializeValues();
+		}
+
+		/**
+		 * Initialize the various values that are used for making decoration
+		 * decisions later on.
+		 *=20
+		 * We might as well pre-load these now, instead of using lazy
+		 * initialization, because they are all read by the decorator when
+		 * building variable bindings and computing the preferred overlay.
+		 *=20
+		 * @throws IOException
+		 */
+		private void initializeValues() throws IOException {
+
+			// Resolve current branch
 			branch =3D repository.getBranch();
+
+			// Resolve tracked state
+			if (getType() =3D=3D IResource.PROJECT) {
+				tracked =3D true;
+			} else {
+				final TreeWalk treeWalk =3D new TreeWalk(repository);
+
+				Set<String> repositoryPaths =3D Collections.singleton(mapping
+						.getRepoRelativePath(resource));
+				if (!(repositoryPaths.isEmpty() || repositoryPaths.contains(""))) =
{
+					treeWalk.setFilter(PathFilterGroup
+							.createFromStrings(repositoryPaths));
+					treeWalk.setRecursive(treeWalk.getFilter()
+							.shouldBeRecursive());
+					treeWalk.reset();
+
+					if (headId !=3D null)
+						treeWalk.addTree(new RevWalk(repository)
+								.parseTree(headId));
+					else
+						treeWalk.addTree(new EmptyTreeIterator());
+
+					treeWalk.addTree(new DirCacheIterator(DirCache
+							.read(repository)));
+					if (treeWalk.next()) {
+						tracked =3D true;
+					}
+				}
+			}
+
+			// Resolve ignored state (currently only reads the global Eclipse
+			// ignores)
+			// TODO: Also read ignores from .git/info/excludes et al.
+			if (Team.isIgnoredHint(resource)) {
+				ignored =3D true;
+			}
 		}
=20
 		public String getName() {
@@ -192,6 +273,14 @@ public int getType() {
 		public String getBranch() {
 			return branch;
 		}
+
+		public boolean isTracked() {
+			return tracked;
+		}
+
+		public boolean isIgnored() {
+			return ignored;
+		}
 	}
=20
 	/**
@@ -203,13 +292,45 @@ public String getBranch() {
 	 */
 	public static class DecorationHelper {
=20
-		private IPreferenceStore store;
-
 		/** */
 		public static final String BINDING_RESOURCE_NAME =3D "name"; //$NON-=
NLS-1$
+
 		/** */
 		public static final String BINDING_BRANCH_NAME =3D "branch"; //$NON-=
NLS-1$
=20
+		private IPreferenceStore store;
+
+		/**
+		 * Define a cached image descriptor which only creates the image dat=
a
+		 * once
+		 */
+		private static class CachedImageDescriptor extends ImageDescriptor {
+			ImageDescriptor descriptor;
+
+			ImageData data;
+
+			public CachedImageDescriptor(ImageDescriptor descriptor) {
+				this.descriptor =3D descriptor;
+			}
+
+			public ImageData getImageData() {
+				if (data =3D=3D null) {
+					data =3D descriptor.getImageData();
+				}
+				return data;
+			}
+		}
+
+		private static ImageDescriptor trackedImage;
+
+		private static ImageDescriptor untrackedImage;
+
+		static {
+			trackedImage =3D new CachedImageDescriptor(TeamImages
+					.getImageDescriptor(ISharedImages.IMG_CHECKEDIN_OVR));
+			untrackedImage =3D new CachedImageDescriptor(UIIcons.OVR_UNTRACKED)=
;
+		}
+
 		/**
 		 * Constructs a decorator using the rules from the given
 		 * <code>preferencesStore</code>
@@ -233,6 +354,12 @@ public DecorationHelper(IPreferenceStore preferenc=
esStore) {
 		 */
 		public void decorate(IDecoration decoration,
 				IDecoratableResource resource) {
+			decorateText(decoration, resource);
+			decorateIcons(decoration, resource);
+		}
+
+		private void decorateText(IDecoration decoration,
+				IDecoratableResource resource) {
 			String format =3D "";
 			switch (resource.getType()) {
 			case IResource.FILE:
@@ -256,9 +383,24 @@ public void decorate(IDecoration decoration,
 			decorate(decoration, format, bindings);
 		}
=20
+		private void decorateIcons(IDecoration decoration,
+				IDecoratableResource resource) {
+			if (resource.isIgnored())
+				return;
+
+			if (resource.isTracked()) {
+				if (store.getBoolean(UIPreferences.DECORATOR_SHOW_TRACKED_ICON))
+					decoration.addOverlay(trackedImage);
+			} else if (store
+					.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON)) {
+				decoration.addOverlay(untrackedImage);
+			}
+		}
+
 		/**
-		 * Decorates the given <code>decoration</code>, using the given
-		 * <code>format</code>, and mapped using <code>bindings</code>
+		 * Decorates the given <code>decoration</code>, using the specified =
text
+		 * <code>format</code>, and mapped using the variable bindings from
+		 * <code>bindings</code>
 		 *=20
 		 * @param decoration
 		 *            the decoration to decorate
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/IDecoratableResource.java b/org.spearce.egit.ui/src/org/spearce/e=
git/ui/internal/decorators/IDecoratableResource.java
index 6b36e0e..f144214 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/I=
DecoratableResource.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/I=
DecoratableResource.java
@@ -36,4 +36,19 @@
 	 *         applicable
 	 */
 	String getBranch();
+
+	/**
+	 * Returns whether or not the resource is tracked by Git
+	 *=20
+	 * @return whether or not the resource is tracked by Git
+	 */
+	boolean isTracked();
+
+	/**
+	 * Returns whether or not the resource is ignored, either by a global=
 team
+	 * ignore in Eclipse, or by .git/info/exclude et al.
+	 *=20
+	 * @return whether or not the resource is ignored
+	 */
+	boolean isIgnored();
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/prefe=
rences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/sp=
earce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
index b7d737c..06ddf50 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
@@ -44,6 +44,9 @@
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.ModifyEvent;
 import org.eclipse.swt.events.ModifyListener;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.events.SelectionListener;
 import org.eclipse.swt.graphics.Color;
 import org.eclipse.swt.graphics.Font;
 import org.eclipse.swt.graphics.Image;
@@ -83,7 +86,11 @@
=20
 	private Text projectTextFormat;
=20
-	private Button showDirty;
+	private Button computeDeepDirtyState;
+
+	private Button showTracked;
+
+	private Button showUntracked;
=20
 	private Preview preview;
=20
@@ -93,10 +100,16 @@
=20
 	static {
 		final PreviewResource project =3D new PreviewResource(
-				"Project", IResource.PROJECT, "master"); //$NON-NLS-1$1
+				"Project", IResource.PROJECT, "master", true, false); //$NON-NLS-1=
$1
 		final ArrayList<PreviewResource> children =3D new ArrayList<PreviewR=
esource>();
-		children.add(new PreviewResource("folder", IResource.FOLDER, null));=
 //$NON-NLS-1$
-		children.add(new PreviewResource("file.txt", IResource.FILE, null));=
 //$NON-NLS-1$
+		children.add(new PreviewResource(
+				"folder", IResource.FOLDER, null, true, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+				"file.txt", IResource.FILE, null, true, false)); //$NON-NLS-1$
+		children.add(new PreviewResource(
+				"untracked.txt", IResource.FILE, null, false, false)); //$NON-NLS-=
1$
+		children.add(new PreviewResource(
+				"ignored.txt", IResource.FILE, null, false, true)); //$NON-NLS-1$
 		project.children =3D children;
 		PREVIEW_FILESYSTEM_ROOT =3D Collections.singleton(project);
 	}
@@ -160,7 +173,7 @@ private Control createGeneralDecoratorPage(Composit=
e parent) {
 		Composite composite =3D SWTUtils.createHVFillComposite(parent,
 				SWTUtils.MARGINS_DEFAULT);
=20
-		showDirty =3D SWTUtils.createCheckBox(composite,
+		computeDeepDirtyState =3D SWTUtils.createCheckBox(composite,
 				UIText.DecoratorPreferencesPage_computeDeep);
=20
 		return composite;
@@ -202,6 +215,11 @@ private Control createIconDecoratorPage(Composite =
parent) {
 		Composite imageGroup =3D SWTUtils.createHVFillComposite(parent,
 				SWTUtils.MARGINS_DEFAULT, 2);
=20
+		showTracked =3D SWTUtils.createCheckBox(imageGroup,
+				UIText.DecoratorPreferencesPage_iconsShowTracked);
+		showUntracked =3D SWTUtils.createCheckBox(imageGroup,
+				UIText.DecoratorPreferencesPage_iconsShowUntracked);
+
 		return imageGroup;
 	}
=20
@@ -241,6 +259,9 @@ public void handleEvent(Event event) {
 	private void initializeValues() {
 		final IPreferenceStore store =3D getPreferenceStore();
=20
+		computeDeepDirtyState.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+
 		fileTextFormat.setText(store
 				.getString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
 		folderTextFormat.setText(store
@@ -248,8 +269,20 @@ private void initializeValues() {
 		projectTextFormat.setText(store
 				.getString(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION));
=20
-		showDirty.setSelection(store
-				.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+		showTracked.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_SHOW_TRACKED_ICON));
+		showUntracked.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON));
+
+		SelectionListener selectionListener =3D new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				preview.refresh();
+			}
+		};
+
+		computeDeepDirtyState.addSelectionListener(selectionListener);
+		showTracked.addSelectionListener(selectionListener);
+		showUntracked.addSelectionListener(selectionListener);
=20
 		setValid(true);
 	}
@@ -287,6 +320,9 @@ public boolean performOk() {
 	 */
 	private boolean performOk(IPreferenceStore store) {
=20
+		store.setValue(UIPreferences.DECORATOR_CALCULATE_DIRTY,
+				computeDeepDirtyState.getSelection());
+
 		store.setValue(UIPreferences.DECORATOR_FILETEXT_DECORATION,
 				fileTextFormat.getText());
 		store.setValue(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION,
@@ -294,8 +330,10 @@ private boolean performOk(IPreferenceStore store) =
{
 		store.setValue(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION,
 				projectTextFormat.getText());
=20
-		store.setValue(UIPreferences.DECORATOR_CALCULATE_DIRTY, showDirty
+		store.setValue(UIPreferences.DECORATOR_SHOW_TRACKED_ICON, showTracke=
d
 				.getSelection());
+		store.setValue(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON,
+				showUntracked.getSelection());
=20
 		return true;
 	}
@@ -308,6 +346,9 @@ protected void performDefaults() {
 		super.performDefaults();
 		IPreferenceStore store =3D getPreferenceStore();
=20
+		computeDeepDirtyState.setSelection(store
+				.getDefaultBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+
 		fileTextFormat.setText(store
 				.getDefaultString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
 		folderTextFormat
@@ -317,8 +358,11 @@ protected void performDefaults() {
 				.setText(store
 						.getDefaultString(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION=
));
=20
-		showDirty.setSelection(store
-				.getDefaultBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+		showTracked.setSelection(store
+				.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_TRACKED_ICON));
+		showUntracked
+				.setSelection(store
+						.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON))=
;
 	}
=20
 	/**
@@ -602,19 +646,26 @@ private PreviewDecoration getDecoration(Object el=
ement) {
 	}
=20
 	private static class PreviewResource implements IDecoratableResource =
{
-		public final String name;
+		private final String name;
+
+		private final String branch;
=20
-		public final String branch;
+		private final int type;
=20
-		public final int type;
+		private Collection children;
=20
-		public Collection children;
+		private boolean tracked;
=20
-		public PreviewResource(String name, int type, String branch) {
+		private boolean ignored;
+
+		public PreviewResource(String name, int type, String branch,
+				boolean tracked, boolean ignored) {
 			this.name =3D name;
 			this.branch =3D branch;
 			this.type =3D type;
 			this.children =3D Collections.EMPTY_LIST;
+			this.tracked =3D tracked;
+			this.ignored =3D ignored;
 		}
=20
 		public String getName() {
@@ -628,6 +679,14 @@ public int getType() {
 		public String getBranch() {
 			return branch;
 		}
+
+		public boolean isTracked() {
+			return tracked;
+		}
+
+		public boolean isIgnored() {
+			return ignored;
+		}
 	}
=20
 	private class PreviewDecoration implements IDecoration {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.propert=
ies b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index d050be9..9940177 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -369,4 +369,6 @@ DecoratorPreferencesPage_selectFormats=3DSelect the=
 format for file, folders, and
 DecoratorPreferencesPage_selectVariablesToAdd=3DSelect the &variables =
to add to the decoration format:
 DecoratorPreferencesPage_textLabel=3DT&ext Decorations
 DecoratorPreferencesPage_iconLabel=3D&Icon Decorations
+DecoratorPreferencesPage_iconsShowTracked=3DTracked resources
+DecoratorPreferencesPage_iconsShowUntracked=3DUntracked resources
=20
--=20
1.6.1.2.309.g2ea3
