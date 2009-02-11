From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 07/12] Add binding for name of the current branch
Date: Wed, 11 Feb 2009 19:40:09 +0100
Message-ID: <1234377614-23798-8-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
 <1234377614-23798-2-git-send-email-torarnv@gmail.com>
 <1234377614-23798-3-git-send-email-torarnv@gmail.com>
 <1234377614-23798-4-git-send-email-torarnv@gmail.com>
 <1234377614-23798-5-git-send-email-torarnv@gmail.com>
 <1234377614-23798-6-git-send-email-torarnv@gmail.com>
 <1234377614-23798-7-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK24-0005RI-RR
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790AbZBKSkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756749AbZBKSkF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:40:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851AbZBKSkC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:40:02 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108720fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gLcRUBx9L8yI1eXBjbjDwRUGTZxV0Dyk38O3adH2FKw=;
        b=Lk6Wh1aGqGEJpoa2WhQu/qEXyBSN1HD3xUKMJICJzHuars4gsqehnMBd+5+oI/wd9j
         ZLpw8VWEmV6hTj7JOQswsWVpX/GzXN3nb/q+k/ZSB+xG6NKyrpiQqvnQE/qdUYoOnRnw
         66i6FShkdBmwd9Ay6RWgA6Y07AP2R+KAxn44E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DW1phmAKWwA+xs4nDcvUUBQVgzD5EtIz/XbfccTuAlEaYO3Wq3AIXxSqbTYa9dtzFJ
         ZbIDetl/9DTqn2iS2QoqncdQO1+UQ0+QFN8VV8qgxc7jPq9JsacOUJcRZa2qiA1V4QvU
         KNdYjg1Y6nRQd5j/MaTziegD1G0gayVteLyhg=
Received: by 10.86.51.10 with SMTP id y10mr797046fgy.9.1234377601551;
        Wed, 11 Feb 2009 10:40:01 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 12sm100668fgg.33.2009.02.11.10.39.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:39:39 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 5B0DA17800B; Wed, 11 Feb 2009 19:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-7-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109490>

This is an example of how to add more bindings to the
decoration preferences, and how they are implemented in
the decorator.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    3 ++
 .../decorators/GitLightweightDecorator.java        |   26 ++++++++++++=
++++---
 .../internal/decorators/IDecoratableResource.java  |    8 ++++++
 .../preferences/GitDecoratorPreferencePage.java    |   21 +++++++++++-=
---
 .../src/org/spearce/egit/ui/uitext.properties      |    3 +-
 5 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index a7ef408..345c66b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -971,6 +971,9 @@
 	public static String DecoratorPreferencesPage_nameResourceVariable;
=20
 	/** */
+	public static String DecoratorPreferencesPage_bindingBranchName;
+
+	/** */
 	public static String DecoratorPreferencesPage_selectFormats;
=20
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearc=
e/egit/ui/internal/decorators/GitLightweightDecorator.java
index 85b9173..265d5a3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
@@ -13,6 +13,7 @@
=20
 package org.spearce.egit.ui.internal.decorators;
=20
+import java.io.IOException;
 import java.util.ArrayList;
 import java.util.HashMap;
 import java.util.HashSet;
@@ -44,6 +45,7 @@
 import org.eclipse.team.ui.TeamUI;
 import org.eclipse.ui.IContributorResourceAdapter;
 import org.eclipse.ui.PlatformUI;
+import org.spearce.egit.core.GitException;
 import org.spearce.egit.core.internal.util.ExceptionCollector;
 import org.spearce.egit.core.project.GitProjectData;
 import org.spearce.egit.core.project.RepositoryChangeListener;
@@ -157,17 +159,26 @@ public void decorate(Object element, IDecoration =
decoration) {
 		if (activator =3D=3D null)
 			return;
=20
-		DecorationHelper helper =3D new DecorationHelper(activator
-				.getPreferenceStore());
-		helper.decorate(decoration, new DecoratableResourceAdapter(resource)=
);
+		try {
+			DecorationHelper helper =3D new DecorationHelper(activator
+					.getPreferenceStore());
+			helper.decorate(decoration,
+					new DecoratableResourceAdapter(resource));
+		} catch (IOException e) {
+			handleException(resource, GitException.wrapException(e));
+		}
 	}
=20
 	private class DecoratableResourceAdapter implements IDecoratableResou=
rce {
=20
 		private IResource resource;
+		private String branch;
=20
-		public DecoratableResourceAdapter(IResource resourceToWrap) {
+		public DecoratableResourceAdapter(IResource resourceToWrap) throws I=
OException {
 			resource =3D resourceToWrap;
+			RepositoryMapping mapping =3D RepositoryMapping.getMapping(resource=
);
+			Repository repository =3D mapping.getRepository();
+			branch =3D repository.getBranch();
 		}
=20
 		public String getName() {
@@ -177,6 +188,10 @@ public String getName() {
 		public int getType() {
 			return resource.getType();
 		}
+
+		public String getBranch() {
+			return branch;
+		}
 	}
=20
 	/**
@@ -192,6 +207,8 @@ public int getType() {
=20
 		/** */
 		public static final String BINDING_RESOURCE_NAME =3D "name"; //$NON-=
NLS-1$
+		/** */
+		public static final String BINDING_BRANCH_NAME =3D "branch"; //$NON-=
NLS-1$
=20
 		/**
 		 * Constructs a decorator using the rules from the given
@@ -234,6 +251,7 @@ public void decorate(IDecoration decoration,
=20
 			Map<String, String> bindings =3D new HashMap<String, String>();
 			bindings.put(BINDING_RESOURCE_NAME, resource.getName());
+			bindings.put(BINDING_BRANCH_NAME, resource.getBranch());
=20
 			decorate(decoration, format, bindings);
 		}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/IDecoratableResource.java b/org.spearce.egit.ui/src/org/spearce/e=
git/ui/internal/decorators/IDecoratableResource.java
index 8d6c741..6b36e0e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/I=
DecoratableResource.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/I=
DecoratableResource.java
@@ -28,4 +28,12 @@
 	 * @return the name of the resource
 	 */
 	String getName();
+
+	/**
+	 * Gets the current branch of the resource if applicable
+	 *=20
+	 * @return the name of the current branch, or <code>null</code> if no=
t
+	 *         applicable
+	 */
+	String getBranch();
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/prefe=
rences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/sp=
earce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
index 84203b7..b7d737c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
@@ -93,10 +93,10 @@
=20
 	static {
 		final PreviewResource project =3D new PreviewResource(
-				"Project", IResource.PROJECT); //$NON-NLS-1$1
+				"Project", IResource.PROJECT, "master"); //$NON-NLS-1$1
 		final ArrayList<PreviewResource> children =3D new ArrayList<PreviewR=
esource>();
-		children.add(new PreviewResource("folder", IResource.FOLDER)); //$NO=
N-NLS-1$
-		children.add(new PreviewResource("file.txt", IResource.FILE)); //$NO=
N-NLS-1$
+		children.add(new PreviewResource("folder", IResource.FOLDER, null));=
 //$NON-NLS-1$
+		children.add(new PreviewResource("file.txt", IResource.FILE, null));=
 //$NON-NLS-1$
 		project.children =3D children;
 		PREVIEW_FILESYSTEM_ROOT =3D Collections.singleton(project);
 	}
@@ -456,6 +456,8 @@ private Map getProjectBindingDescriptions() {
 		Map<String, String> bindings =3D new HashMap<String, String>();
 		bindings.put(DecorationHelper.BINDING_RESOURCE_NAME,
 				UIText.DecoratorPreferencesPage_nameResourceVariable);
+		bindings.put(DecorationHelper.BINDING_BRANCH_NAME,
+				UIText.DecoratorPreferencesPage_bindingBranchName);
 		return bindings;
 	}
=20
@@ -478,8 +480,8 @@ private void updatePreview() {
 		private DecorationHelper fHelper;
=20
 		public Preview(Composite composite) {
-			reloadDecorationHelper(); // Has to happen before the tree control
-										// is constructed
+			// Has to happen before the tree control is constructed
+			reloadDecorationHelper();
 			SWTUtils.createLabel(composite,
 					UIText.DecoratorPreferencesPage_preview);
 			fImageCache =3D new LocalResourceManager(JFaceResources
@@ -602,12 +604,15 @@ private PreviewDecoration getDecoration(Object el=
ement) {
 	private static class PreviewResource implements IDecoratableResource =
{
 		public final String name;
=20
+		public final String branch;
+
 		public final int type;
=20
 		public Collection children;
=20
-		public PreviewResource(String name, int type) {
+		public PreviewResource(String name, int type, String branch) {
 			this.name =3D name;
+			this.branch =3D branch;
 			this.type =3D type;
 			this.children =3D Collections.EMPTY_LIST;
 		}
@@ -619,6 +624,10 @@ public String getName() {
 		public int getType() {
 			return type;
 		}
+
+		public String getBranch() {
+			return branch;
+		}
 	}
=20
 	private class PreviewDecoration implements IDecoration {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.propert=
ies b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 4660983..d050be9 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -360,10 +360,11 @@ DecoratorPreferencesPage_folderFormatLabel=3DF&ol=
ders:
 DecoratorPreferencesPage_projectFormatLabel=3D&Projects:
 DecoratorPreferencesPage_fileFormatDefault=3D{name}
 DecoratorPreferencesPage_folderFormatDefault=3D{name}
-DecoratorPreferencesPage_projectFormatDefault=3D{name}
+DecoratorPreferencesPage_projectFormatDefault=3D{name} [{branch}]
 DecoratorPreferencesPage_labelDecorationsLink=3DSee <a>''{0}''</a> to =
enable or disable Git decorations.
 DecoratorPreferencesPage_generalTabFolder=3D&General
 DecoratorPreferencesPage_nameResourceVariable=3Dname of the resource b=
eing decorated
+DecoratorPreferencesPage_bindingBranchName=3Dcurrent branch of the pro=
ject
 DecoratorPreferencesPage_selectFormats=3DSelect the format for file, f=
olders, and project text labels:
 DecoratorPreferencesPage_selectVariablesToAdd=3DSelect the &variables =
to add to the decoration format:
 DecoratorPreferencesPage_textLabel=3DT&ext Decorations
--=20
1.6.1.2.309.g2ea3
