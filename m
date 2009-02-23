From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Mon, 23 Feb 2009 20:03:44 +0100
Message-ID: <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 20:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbg7p-0003YQ-6c
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 20:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZBWTD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 14:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbZBWTD6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 14:03:58 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:34493 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751374AbZBWTDz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 14:03:55 -0500
Received: from localhost.localdomain (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 5867B58BDBB;
	Mon, 23 Feb 2009 20:03:52 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <cover.1235415747.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1235415747.git.ferry.huberts@pelagic.nl>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111169>

Add an ignored icon to the label decorations page and make
sure that it is actually decorated: from now on do not ignore
ignored resources during decoration.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 org.spearce.egit.ui/icons/ovr/ignored.gif          |  Bin 0 -> 102 bytes
 .../egit/ui/PluginPreferenceInitializer.java       |    1 +
 .../src/org/spearce/egit/ui/UIIcons.java           |    4 ++++
 .../src/org/spearce/egit/ui/UIPreferences.java     |    2 ++
 .../src/org/spearce/egit/ui/UIText.java            |    3 +++
 .../decorators/GitLightweightDecorator.java        |   11 ++++++++---
 .../preferences/GitDecoratorPreferencePage.java    |   12 ++++++++++++
 .../src/org/spearce/egit/ui/uitext.properties      |    1 +
 8 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/ovr/ignored.gif

diff --git a/org.spearce.egit.ui/icons/ovr/ignored.gif b/org.spearce.egit.ui/icons/ovr/ignored.gif
new file mode 100644
index 0000000000000000000000000000000000000000..509e706b3c847697c8fab379bc8bacdc66d21f3c
GIT binary patch
literal 102
zcmZ?wbhEHb<Y3@nc+AJ}>(@D15q3p!E=^fpC2=k-SzZ$rK|38WV-+D!6DfNgu|P{%
zPh+VN3xoe)p!k!8k%57qL5BedKxQzo2!Gh?Hha$0M=_26udo+g4fC2Q!pL9^04%B;
A)&Kwi

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
index 8d617e9..f76b6e1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
@@ -46,6 +46,7 @@ public void initializeDefaultPreferences() {
 				UIText.DecoratorPreferencesPage_projectFormatDefault);
 		prefs.setDefault(UIPreferences.DECORATOR_SHOW_TRACKED_ICON, true);
 		prefs.setDefault(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON, true);
+		prefs.setDefault(UIPreferences.DECORATOR_SHOW_IGNORED_ICON, true);
 		prefs.setDefault(UIPreferences.DECORATOR_SHOW_STAGED_ICON, true);
 		prefs.setDefault(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON, true);
 		prefs.setDefault(UIPreferences.DECORATOR_SHOW_ASSUME_VALID_ICON, true);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 952816c..5bc1eaf 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -31,6 +31,9 @@
 	/** Decoration for resource not being tracked by Git */
 	public static final ImageDescriptor OVR_UNTRACKED;
 
+	/** Decoration for resource ignored by Git */
+	public static final ImageDescriptor OVR_IGNORED;
+
 	/** Decoration for tracked resource with a merge conflict.  */
 	public static final ImageDescriptor OVR_CONFLICT;
 
@@ -92,6 +95,7 @@
 		OVR_STAGED_ADD = map("ovr/staged_added.gif");
 		OVR_STAGED_REMOVE = map("ovr/staged_removed.gif");
 		OVR_UNTRACKED = map("ovr/untracked.gif");
+		OVR_IGNORED = map("ovr/ignored.gif");
 		OVR_CONFLICT = map("ovr/conflict.gif");
 		OVR_ASSUMEVALID = map("ovr/assume_valid.gif");
 		ELCL16_FIND = map("elcl16/find.gif");
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index bbc36be..cdf9ab4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -67,6 +67,8 @@
 	/** */
 	public final static String DECORATOR_SHOW_UNTRACKED_ICON = "decorator_show_untracked_icon";
 	/** */
+	public final static String DECORATOR_SHOW_IGNORED_ICON = "decorator_show_ignored_icon";
+	/** */
 	public final static String DECORATOR_SHOW_STAGED_ICON = "decorator_show_staged_icon";
 	/** */
 	public final static String DECORATOR_SHOW_CONFLICTS_ICON = "decorator_show_conflicts_icon";
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 0740f09..85bb50b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -1013,6 +1013,9 @@
 	public static String DecoratorPreferencesPage_iconsShowUntracked;
 
 	/** */
+	public static String DecoratorPreferencesPage_iconsShowIgnored;
+
+	/** */
 	public static String DecoratorPreferencesPage_iconsShowStaged;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitLightweightDecorator.java
index 6f69c80..06c10e1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitLightweightDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitLightweightDecorator.java
@@ -224,6 +224,8 @@ public ImageData getImageData() {
 
 		private static ImageDescriptor untrackedImage;
 
+		private static ImageDescriptor ignoredImage;
+
 		private static ImageDescriptor stagedImage;
 
 		private static ImageDescriptor stagedAddedImage;
@@ -238,6 +240,7 @@ public ImageData getImageData() {
 			trackedImage = new CachedImageDescriptor(TeamImages
 					.getImageDescriptor(ISharedImages.IMG_CHECKEDIN_OVR));
 			untrackedImage = new CachedImageDescriptor(UIIcons.OVR_UNTRACKED);
+			ignoredImage = new CachedImageDescriptor(UIIcons.OVR_IGNORED);
 			stagedImage = new CachedImageDescriptor(UIIcons.OVR_STAGED);
 			stagedAddedImage = new CachedImageDescriptor(UIIcons.OVR_STAGED_ADD);
 			stagedRemovedImage = new CachedImageDescriptor(
@@ -269,9 +272,6 @@ public DecorationHelper(IPreferenceStore preferencesStore) {
 		 */
 		public void decorate(IDecoration decoration,
 				IDecoratableResource resource) {
-			if (resource.isIgnored())
-				return;
-
 			decorateText(decoration, resource);
 			decorateIcons(decoration, resource);
 		}
@@ -335,6 +335,11 @@ else if (staged == Staged.REMOVED)
 						&& resource.hasConflicts())
 					overlay = conflictImage;
 
+			} else if (resource.isIgnored()) {
+				if (store
+						.getBoolean(UIPreferences.DECORATOR_SHOW_IGNORED_ICON)) {
+					overlay = ignoredImage;
+				}
 			} else if (store
 					.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON)) {
 				overlay = untrackedImage;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
index eca2277..8c950cf 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
@@ -99,6 +99,8 @@
 
 	private Button showUntracked;
 
+	private Button showIgnored;
+
 	private Preview preview;
 
 	private Button showStaged;
@@ -308,6 +310,8 @@ private Control createIconDecoratorPage(Composite parent) {
 				UIText.DecoratorPreferencesPage_iconsShowTracked);
 		showUntracked = SWTUtils.createCheckBox(imageGroup,
 				UIText.DecoratorPreferencesPage_iconsShowUntracked);
+		showIgnored = SWTUtils.createCheckBox(imageGroup,
+				UIText.DecoratorPreferencesPage_iconsShowIgnored);
 		showStaged = SWTUtils.createCheckBox(imageGroup,
 				UIText.DecoratorPreferencesPage_iconsShowStaged);
 		showConflicts = SWTUtils.createCheckBox(imageGroup,
@@ -376,6 +380,8 @@ private void initializeValues() {
 				.getBoolean(UIPreferences.DECORATOR_SHOW_TRACKED_ICON));
 		showUntracked.setSelection(store
 				.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON));
+		showIgnored.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_SHOW_IGNORED_ICON));
 		showStaged.setSelection(store
 				.getBoolean(UIPreferences.DECORATOR_SHOW_STAGED_ICON));
 		showConflicts.setSelection(store
@@ -391,6 +397,7 @@ public void widgetSelected(SelectionEvent e) {
 
 		showTracked.addSelectionListener(selectionListener);
 		showUntracked.addSelectionListener(selectionListener);
+		showIgnored.addSelectionListener(selectionListener);
 		showStaged.addSelectionListener(selectionListener);
 		showConflicts.addSelectionListener(selectionListener);
 		showAssumeValid.addSelectionListener(selectionListener);
@@ -447,6 +454,8 @@ private boolean performOk(IPreferenceStore store) {
 				.getSelection());
 		store.setValue(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON,
 				showUntracked.getSelection());
+		store.setValue(UIPreferences.DECORATOR_SHOW_IGNORED_ICON,
+				showIgnored.getSelection());
 		store.setValue(UIPreferences.DECORATOR_SHOW_STAGED_ICON, showStaged
 				.getSelection());
 		store.setValue(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON,
@@ -485,6 +494,9 @@ protected void performDefaults() {
 		showUntracked
 				.setSelection(store
 						.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON));
+		showIgnored
+				.setSelection(store
+						.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_IGNORED_ICON));
 		showStaged.setSelection(store
 				.getDefaultBoolean(UIPreferences.DECORATOR_SHOW_STAGED_ICON));
 		showConflicts
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 847cb2c..932c75c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -376,6 +376,7 @@ DecoratorPreferencesPage_textLabel=T&ext Decorations
 DecoratorPreferencesPage_iconLabel=&Icon Decorations
 DecoratorPreferencesPage_iconsShowTracked=Tracked resources
 DecoratorPreferencesPage_iconsShowUntracked=Untracked resources
+DecoratorPreferencesPage_iconsShowIgnored=Ignored resources
 DecoratorPreferencesPage_iconsShowStaged=Staged resources
 DecoratorPreferencesPage_iconsShowConflicts=Conflicting resources
 DecoratorPreferencesPage_iconsShowAssumeValid=Assumed unchanged resources
-- 
1.6.0.6
