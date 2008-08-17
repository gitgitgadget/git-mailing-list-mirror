From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 19/31] Clone wizard and related: refactor, clean-up, fixes or improvements
Date: Sun, 17 Aug 2008 22:44:00 +0200
Message-ID: <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp9C-00038o-J6
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbYHQUpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbYHQUpe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:34 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYHQUp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:29 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fT8Vfdd7ryeDHcZeMZMqTczbpJWMgFAHPtAZPWN0bHM=;
        b=p247jN4mdzwrWiva8sd6++my6LeMImGCrHyXCpZRgvimAPK/XIyqp1Uy+RBP5F9YJB
         VpBlUiPKiDsAQXIdFtii+u9YMoRiX8Ki6udTec1acRoVa8HXEES6DHGfZLOBToCoKf3e
         qq6lbvfK8I9XminuewFRnLCZSJp7mZTr2EUgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PXCxLkcJNC1w75oEE4sfut+iHaESVklM9Rempq8kuccFXpxJFXTpKLRcPxH5fjlotz
         jt07TeOFpR/WVmiqu9lcTTcFmPkviAXxvsU3UWg3e6EZIaO9InFL+eyfqI51QHDR7K6j
         I5aWpGK1ejbq/j4dEfzvNjFYJZ5+nsncpVEbQ=
Received: by 10.103.203.15 with SMTP id f15mr3470093muq.0.1219005927486;
        Sun, 17 Aug 2008 13:45:27 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id s10sm2357607muh.12.2008.08.17.13.45.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:26 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92649>

At some stage, it was hard to change or improve anything in Clone wizard
or reuse some of its components without some global refactor or clean-up.

This changeset introduces some common patterns of handling internal pages
validation and inter-pages dependencies, it tries to address existing
issues (complicated internal dependencies, redundant asymmetrical code)
with clone code that IMHO were making it hard to maintain or modify.

Some of these changes introduce new behavior (fixes or improvements),
as it was hard for me to separate this in my iterative process...

- Remove mess of using both setPageComplete() and custom isPageComplete().
  Now, checkPage() is used (calling setPageComplete()) instead - for
  internal validation, while direct setPageComplete() calls are used in
  special situations like handling inter-pages dependencies.
- RepositorySelection class introduces encapsulated result of
  RepositorySelectionPage with helper methods working on that result.
- SelectionChangeListener became new common interface for notifying other
  (dependent) pages about selection changes in current page.
  BaseWizardPage is helper abstract class handling these listeners.
- User can move backward in wizard, change something, revert this change,
  then subsequent pages doesn't set page complete to false. It's now
  supported in common way in whole wizard by *selectionEquals() methods.
- Real-time checking for some fields of destination page is introduced.
- Minor changes like renames or some simplifications, forgotten changes.

Some of this commit resulting components, may be reused in other places,
that's why they are actually in .components package.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../ui/internal/clone/CloneDestinationPage.java    |  115 ++++++-----
 .../egit/ui/internal/clone/GitCloneWizard.java     |    3 +-
 .../egit/ui/internal/clone/SourceBranchPage.java   |  212 ++++++++++----------
 .../ui/internal/components/BaseWizardPage.java     |   58 ++++++
 .../internal/components/RepositorySelection.java   |  133 ++++++++++++
 .../components/RepositorySelectionListener.java    |   32 ---
 .../components/RepositorySelectionPage.java        |   61 ++----
 .../SelectionChangeListener.java}                  |   16 +-
 8 files changed, 397 insertions(+), 233 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/BaseWizardPage.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelection.java
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java
 rename org.spearce.egit.ui/src/org/spearce/egit/ui/internal/{clone/BranchChangeListener.java => components/SelectionChangeListener.java} (50%)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index 249bfd3..01bf54a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -1,6 +1,7 @@
 /*******************************************************************************
  * Copyright (C) 2008, Roger C. Soares <rogersoares@intelinet.com.br>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -9,6 +10,7 @@
 package org.spearce.egit.ui.internal.clone;
 
 import java.io.File;
+import java.util.List;
 
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.jface.wizard.WizardPage;
@@ -16,8 +18,8 @@ import org.eclipse.osgi.util.NLS;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.ModifyEvent;
 import org.eclipse.swt.events.ModifyListener;
+import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
-import org.eclipse.swt.events.SelectionListener;
 import org.eclipse.swt.layout.GridData;
 import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.widgets.Button;
@@ -28,12 +30,11 @@ import org.eclipse.swt.widgets.Group;
 import org.eclipse.swt.widgets.Label;
 import org.eclipse.swt.widgets.Text;
 import org.spearce.egit.ui.UIText;
-import org.spearce.egit.ui.internal.components.RepositorySelectionListener;
+import org.spearce.egit.ui.internal.components.RepositorySelection;
 import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
+import org.spearce.egit.ui.internal.components.SelectionChangeListener;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
-import org.spearce.jgit.transport.RemoteConfig;
-import org.spearce.jgit.transport.URIish;
 
 /**
  * Wizard page that allows the user entering the location of a repository to be
@@ -44,7 +45,11 @@ class CloneDestinationPage extends WizardPage {
 
 	private final SourceBranchPage branchPage;
 
-	private URIish validated;
+	private RepositorySelection validatedRepoSelection;
+
+	private List<Ref> validatedSelectedBranches;
+
+	private Ref validatedHEAD;
 
 	private Combo initialBranch;
 
@@ -60,18 +65,13 @@ class CloneDestinationPage extends WizardPage {
 
 		setTitle(UIText.CloneDestinationPage_title);
 
-		sourcePage.addRepositorySelectionListener(new RepositorySelectionListener() {
-			public void selectionChanged(final URIish newURI,
-					final RemoteConfig newConfig) {
-				if (newURI == null || !newURI.equals(validated))
-					setPageComplete(false);
+		final SelectionChangeListener listener = new SelectionChangeListener() {
+			public void selectionChanged() {
+				checkPreviousPagesSelections();
 			}
-		});
-		branchPage.addBranchChangeListener(new BranchChangeListener() {
-			public void branchesChanged() {
-				setPageComplete(false);
-			}
-		});
+		};
+		sourcePage.addSelectionListener(listener);
+		branchPage.addSelectionListener(listener);
 	}
 
 	public void createControl(final Composite parent) {
@@ -84,7 +84,7 @@ class CloneDestinationPage extends WizardPage {
 		createConfigGroup(panel);
 
 		setControl(panel);
-		setPageComplete(isPageComplete());
+		checkPage();
 	}
 
 	@Override
@@ -94,6 +94,15 @@ class CloneDestinationPage extends WizardPage {
 		super.setVisible(visible);
 	}
 
+	private void checkPreviousPagesSelections() {
+		if (!sourcePage.selectionEquals(validatedRepoSelection)
+				|| !branchPage.selectionEquals(validatedSelectedBranches,
+						validatedHEAD))
+			setPageComplete(false);
+		else
+			checkPage();
+	}
+
 	private void createDestinationGroup(final Composite parent) {
 		final Group g = createGroup(parent,
 				UIText.CloneDestinationPage_groupDestination);
@@ -108,16 +117,12 @@ class CloneDestinationPage extends WizardPage {
 		directoryText.setLayoutData(createFieldGridData());
 		directoryText.addModifyListener(new ModifyListener() {
 			public void modifyText(final ModifyEvent e) {
-				setPageComplete(isPageComplete());
+				checkPage();
 			}
 		});
 		final Button b = new Button(p, SWT.PUSH);
 		b.setText(UIText.CloneDestinationPage_browseButton);
-		b.addSelectionListener(new SelectionListener() {
-			public void widgetDefaultSelected(SelectionEvent e) {
-				// Do nothing.
-			}
-
+		b.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(final SelectionEvent e) {
 				final FileDialog d;
 
@@ -136,6 +141,12 @@ class CloneDestinationPage extends WizardPage {
 		newLabel(g, UIText.CloneDestinationPage_promptInitialBranch + ":");
 		initialBranch = new Combo(g, SWT.DROP_DOWN | SWT.READ_ONLY);
 		initialBranch.setLayoutData(createFieldGridData());
+		initialBranch.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(final SelectionEvent e) {
+				checkPage();
+			}
+		});
 	}
 
 	private void createConfigGroup(final Composite parent) {
@@ -146,6 +157,11 @@ class CloneDestinationPage extends WizardPage {
 		remoteText = new Text(g, SWT.BORDER);
 		remoteText.setText("origin");
 		remoteText.setLayoutData(createFieldGridData());
+		remoteText.addModifyListener(new ModifyListener() {
+			public void modifyText(ModifyEvent e) {
+				checkPage();
+			}
+		});
 	}
 
 	private static Group createGroup(final Composite parent, final String text) {
@@ -193,50 +209,55 @@ class CloneDestinationPage extends WizardPage {
 		return remoteText.getText();
 	}
 
-	@Override
-	public boolean isPageComplete() {
+	/**
+	 * Check internal state for page completion status.
+	 */
+	private void checkPage() {
 		final String dstpath = directoryText.getText();
 		if (dstpath.length() == 0) {
 			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_fieldRequired,
 					UIText.CloneDestinationPage_promptDirectory));
-			return false;
+			setPageComplete(false);
+			return;
 		}
 		if (new File(dstpath).exists()) {
 			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_errorExists,
 					new File(dstpath).getName()));
-			return false;
+			setPageComplete(false);
+			return;
 		}
 		if (initialBranch.getSelectionIndex() < 0) {
 			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_fieldRequired,
 					UIText.CloneDestinationPage_promptInitialBranch));
-			return false;
+			setPageComplete(false);
+			return;
 		}
 		if (remoteText.getText().length() == 0) {
 			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_fieldRequired,
 					UIText.CloneDestinationPage_promptRemoteName));
-			return false;
+			setPageComplete(false);
+			return;
 		}
 
 		setErrorMessage(null);
-		return true;
+		setPageComplete(true);
 	}
 
 	private void revalidate() {
-		URIish newURI = null;
-		newURI = sourcePage.getURI();
-		validated = newURI;
-
-		if (newURI == null || !newURI.equals(validated)) {
-			final String n = getSuggestedName();
-			setDescription(NLS.bind(UIText.CloneDestinationPage_description,
-					n != null ? n : "<unknown>"));
-
-			if (n != null) {
-				directoryText.setText(new File(ResourcesPlugin.getWorkspace()
-						.getRoot().getRawLocation().toFile(), n)
-						.getAbsolutePath());
-			}
+		if (sourcePage.selectionEquals(validatedRepoSelection)
+				&& branchPage.selectionEquals(validatedSelectedBranches,
+						validatedHEAD)) {
+			checkPage();
+			return;
 		}
+		validatedRepoSelection = sourcePage.getSelection();
+		validatedSelectedBranches = branchPage.getSelectedBranches();
+		validatedHEAD = branchPage.getHEAD();
+
+		final String n = getSuggestedName();
+		setDescription(NLS.bind(UIText.CloneDestinationPage_description, n));
+		directoryText.setText(new File(ResourcesPlugin.getWorkspace().getRoot()
+				.getRawLocation().toFile(), n).getAbsolutePath());
 
 		initialBranch.removeAll();
 		final Ref head = branchPage.getHEAD();
@@ -250,13 +271,11 @@ class CloneDestinationPage extends WizardPage {
 			initialBranch.add(name);
 		}
 		initialBranch.select(newix);
+		checkPage();
 	}
 
 	private String getSuggestedName() {
-		if (validated == null)
-			return null;
-
-		String path = validated.getPath();
+		String path = validatedRepoSelection.getURI().getPath();
 		int s = path.lastIndexOf('/');
 		if (s != -1)
 			path = path.substring(s + 1);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
index 58c169a..9c1d691 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
@@ -1,6 +1,7 @@
 /*******************************************************************************
  * Copyright (C) 2008, Roger C. Soares <rogersoares@intelinet.com.br>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -71,7 +72,7 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 		final Repository db;
 		final RemoteConfig origin;
 
-		uri = cloneSource.getURI();
+		uri = cloneSource.getSelection().getURI();
 
 		final File workdir = cloneDestination.getDestinationFile();
 		final String branch = cloneDestination.getInitialBranch();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
index 1768dbd..7710612 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
@@ -1,6 +1,7 @@
 /*******************************************************************************
  * Copyright (C) 2007, Dave Watson <dwatson@mimvista.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -23,49 +24,44 @@ import org.eclipse.core.runtime.OperationCanceledException;
 import org.eclipse.core.runtime.Status;
 import org.eclipse.jface.dialogs.ErrorDialog;
 import org.eclipse.jface.operation.IRunnableWithProgress;
-import org.eclipse.jface.wizard.WizardPage;
 import org.eclipse.osgi.util.NLS;
 import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
-import org.eclipse.swt.events.SelectionListener;
 import org.eclipse.swt.layout.GridData;
 import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.layout.RowLayout;
 import org.eclipse.swt.widgets.Button;
 import org.eclipse.swt.widgets.Composite;
-import org.eclipse.swt.widgets.Event;
 import org.eclipse.swt.widgets.Label;
-import org.eclipse.swt.widgets.Listener;
 import org.eclipse.swt.widgets.Table;
 import org.eclipse.swt.widgets.TableItem;
 import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIText;
-import org.spearce.egit.ui.internal.components.RepositorySelectionListener;
+import org.spearce.egit.ui.internal.components.BaseWizardPage;
+import org.spearce.egit.ui.internal.components.RepositorySelection;
 import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
+import org.spearce.egit.ui.internal.components.SelectionChangeListener;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.transport.FetchConnection;
-import org.spearce.jgit.transport.RemoteConfig;
 import org.spearce.jgit.transport.Transport;
-import org.spearce.jgit.transport.URIish;
-
-class SourceBranchPage extends WizardPage {
-	private final List<BranchChangeListener> branchChangeListeners;
 
+class SourceBranchPage extends BaseWizardPage {
 	private final RepositorySelectionPage sourcePage;
 
-	private URIish validated;
+	private RepositorySelection validatedRepoSelection;
 
 	private Ref head;
 
-	private List<Ref> available = Collections.<Ref> emptyList();
+	private List<Ref> availableRefs = new ArrayList<Ref>();
 
-	private Label label;
+	private List<Ref> selectedRefs = new ArrayList<Ref>();
 
-	private Table availTable;
+	private Label label;
 
-	private boolean allSelected;
+	private Table refsTable;
 
 	private String transportError;
 
@@ -73,33 +69,19 @@ class SourceBranchPage extends WizardPage {
 		super(SourceBranchPage.class.getName());
 		sourcePage = sp;
 		setTitle(UIText.SourceBranchPage_title);
-		sourcePage
-				.addRepositorySelectionListener(new RepositorySelectionListener() {
-					public void selectionChanged(final URIish newURI,
-							final RemoteConfig newConfig) {
-						if (newURI == null || !newURI.equals(validated)) {
-							validated = null;
-							setPageComplete(false);
-						}
-					}
-				});
-		branchChangeListeners = new ArrayList<BranchChangeListener>(3);
-	}
 
-	void addBranchChangeListener(final BranchChangeListener l) {
-		branchChangeListeners.add(l);
+		sourcePage.addSelectionListener(new SelectionChangeListener() {
+			public void selectionChanged() {
+				if (!sourcePage.selectionEquals(validatedRepoSelection))
+					setPageComplete(false);
+				else
+					checkPage();
+			}
+		});
 	}
 
-	Collection<Ref> getSelectedBranches() {
-		allSelected = true;
-		final ArrayList<Ref> r = new ArrayList<Ref>(available.size());
-		for (int i = 0; i < available.size(); i++) {
-			if (availTable.getItem(i).getChecked())
-				r.add(available.get(i));
-			else
-				allSelected = false;
-		}
-		return r;
+	List<Ref> getSelectedBranches() {
+		return new ArrayList<Ref>(selectedRefs);
 	}
 
 	Ref getHEAD() {
@@ -107,7 +89,11 @@ class SourceBranchPage extends WizardPage {
 	}
 
 	boolean isAllSelected() {
-		return allSelected;
+		return availableRefs.size() == selectedRefs.size();
+	}
+
+	boolean selectionEquals(final List<Ref> selectedRefs, final Ref head) {
+		return this.selectedRefs.equals(selectedRefs) && this.head == head;
 	}
 
 	public void createControl(final Composite parent) {
@@ -119,14 +105,30 @@ class SourceBranchPage extends WizardPage {
 		label = new Label(panel, SWT.NONE);
 		label.setLayoutData(new GridData(SWT.FILL, SWT.TOP, true, false));
 
-		availTable = new Table(panel, SWT.CHECK | SWT.V_SCROLL | SWT.BORDER);
-		availTable.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true));
-		availTable.addListener(SWT.Selection, new Listener() {
-			public void handleEvent(final Event event) {
-				if (event.detail == SWT.CHECK) {
-					notifyChanged();
-					setPageComplete(isPageComplete());
-				}
+		refsTable = new Table(panel, SWT.CHECK | SWT.V_SCROLL | SWT.BORDER);
+		refsTable.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true));
+		refsTable.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(final SelectionEvent e) {
+				if (e.detail != SWT.CHECK)
+					return;
+
+				final TableItem tableItem = (TableItem) e.item;
+				final int i = refsTable.indexOf(tableItem);
+				final Ref ref = availableRefs.get(i);
+
+				if (tableItem.getChecked()) {
+					int insertionPos = 0;
+					for (int j = 0; j < i; j++) {
+						if (selectedRefs.contains(availableRefs.get(j)))
+							insertionPos++;
+					}
+					selectedRefs.add(insertionPos, ref);
+				} else
+					selectedRefs.remove(ref);
+
+				notifySelectionChanged();
+				checkPage();
 			}
 		});
 
@@ -135,36 +137,31 @@ class SourceBranchPage extends WizardPage {
 		Button b;
 		b = new Button(bPanel, SWT.PUSH);
 		b.setText(UIText.SourceBranchPage_selectAll);
-		b.addSelectionListener(new SelectionListener() {
-			public void widgetDefaultSelected(SelectionEvent e) {
-				// Do nothing.
-			}
-
-			public void widgetSelected(SelectionEvent e) {
-				for (int i = 0; i < availTable.getItemCount(); i++)
-					availTable.getItem(i).setChecked(true);
-				notifyChanged();
-				setPageComplete(isPageComplete());
+		b.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(final SelectionEvent e) {
+				for (int i = 0; i < refsTable.getItemCount(); i++)
+					refsTable.getItem(i).setChecked(true);
+				selectedRefs.clear();
+				selectedRefs.addAll(availableRefs);
+				notifySelectionChanged();
+				checkPage();
 			}
 		});
 		b = new Button(bPanel, SWT.PUSH);
 		b.setText(UIText.SourceBranchPage_selectNone);
-		b.addSelectionListener(new SelectionListener() {
-			public void widgetDefaultSelected(SelectionEvent e) {
-				// Do nothing.
-			}
-
-			public void widgetSelected(SelectionEvent e) {
-				for (int i = 0; i < availTable.getItemCount(); i++)
-					availTable.getItem(i).setChecked(false);
-				notifyChanged();
-				setPageComplete(isPageComplete());
+		b.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(final SelectionEvent e) {
+				for (int i = 0; i < refsTable.getItemCount(); i++)
+					refsTable.getItem(i).setChecked(false);
+				selectedRefs.clear();
+				notifySelectionChanged();
+				checkPage();
 			}
 		});
 		bPanel.setLayoutData(new GridData(SWT.FILL, SWT.TOP, true, false));
 
 		setControl(panel);
-		setPageComplete(false);
+		checkPage();
 	}
 
 	@Override
@@ -174,52 +171,57 @@ class SourceBranchPage extends WizardPage {
 		super.setVisible(visible);
 	}
 
-	@Override
-	public boolean isPageComplete() {
+	/**
+	 * Check internal state for page completion status. This method should be
+	 * called only when all necessary data from previous form is available.
+	 */
+	private void checkPage() {
 		if (transportError != null) {
 			setErrorMessage(transportError);
-			return false;
+			setPageComplete(false);
+			return;
 		}
 
 		if (getSelectedBranches().isEmpty()) {
 			setErrorMessage(UIText.SourceBranchPage_errorBranchRequired);
-			return false;
+			setPageComplete(false);
+			return;
 		}
 
 		setErrorMessage(null);
-		return true;
+		setPageComplete(true);
 	}
 
 	private void revalidate() {
-		final URIish newURI;
-		newURI = sourcePage.getURI();
-
-		label.setText(NLS.bind(UIText.SourceBranchPage_branchList, newURI
-				.toString()));
-		label.getParent().layout();
-
-		if (newURI.equals(validated)) {
-			setPageComplete(isPageComplete());
+		if (sourcePage.selectionEquals(validatedRepoSelection)) {
+			// URI hasn't changed, no need to refill the page with new data
+			checkPage();
 			return;
 		}
 
-		setErrorMessage(null);
-		setPageComplete(false);
+		final RepositorySelection newRepoSelection = sourcePage.getSelection();
+		label.setText(NLS.bind(UIText.SourceBranchPage_branchList,
+				newRepoSelection.getURI().toString()));
+		label.getParent().layout();
+
+		validatedRepoSelection = null;
 		transportError = null;
 		head = null;
-		available = new ArrayList<Ref>();
-		availTable.removeAll();
-		allSelected = false;
+		availableRefs.clear();
+		selectedRefs.clear();
+		refsTable.removeAll();
+		checkPage();
 		label.getDisplay().asyncExec(new Runnable() {
 			public void run() {
-				revalidateImpl(newURI);
+				revalidateImpl(newRepoSelection);
 			}
 		});
 	}
 
-	private void revalidateImpl(final URIish newURI) {
+	private void revalidateImpl(final RepositorySelection newRepoSelection) {
 		if (label.isDisposed() || !isCurrentPage())
 			return;
+
 		try {
 			getContainer().run(true, true, new IRunnableWithProgress() {
 				public void run(final IProgressMonitor pm)
@@ -231,7 +233,8 @@ class SourceBranchPage extends WizardPage {
 						monitor = pm;
 					try {
 						final Repository db = new Repository(new File("/tmp"));
-						final Transport tn = Transport.open(db, newURI);
+						final Transport tn = Transport.open(db,
+								newRepoSelection.getURI());
 						final Collection<Ref> adv;
 						final FetchConnection fn = tn.openFetch();
 						try {
@@ -247,20 +250,20 @@ class SourceBranchPage extends WizardPage {
 							final String n = r.getName();
 							if (!n.startsWith(Constants.HEADS_PREFIX + "/"))
 								continue;
-							available.add(r);
+							availableRefs.add(r);
 							if (idHEAD == null || head != null)
 								continue;
 							if (r.getObjectId().equals(idHEAD.getObjectId()))
 								head = r;
 						}
-						Collections.sort(available, new Comparator<Ref>() {
+						Collections.sort(availableRefs, new Comparator<Ref>() {
 							public int compare(final Ref o1, final Ref o2) {
 								return o1.getName().compareTo(o2.getName());
 							}
 						});
 						if (idHEAD != null && head == null) {
 							head = idHEAD;
-							available.add(0, idHEAD);
+							availableRefs.add(0, idHEAD);
 						}
 					} catch (Exception err) {
 						throw new InvocationTargetException(err);
@@ -287,29 +290,22 @@ class SourceBranchPage extends WizardPage {
 			return;
 		}
 
-		validated = newURI;
-		allSelected = true;
-		for (final Ref r : available) {
+		validatedRepoSelection = newRepoSelection;
+		for (final Ref r : availableRefs) {
 			String n = r.getName();
 			if (n.startsWith(Constants.HEADS_PREFIX + "/"))
 				n = n.substring((Constants.HEADS_PREFIX + "/").length());
-			final TableItem ti = new TableItem(availTable, SWT.NONE);
+			final TableItem ti = new TableItem(refsTable, SWT.NONE);
 			ti.setText(n);
 			ti.setChecked(true);
+			selectedRefs.add(r);
 		}
-		notifyChanged();
-		setErrorMessage(null);
-		setPageComplete(isPageComplete());
+		notifySelectionChanged();
+		checkPage();
 	}
 
 	private void transportError(final String msg) {
 		transportError = msg;
-		setErrorMessage(msg);
-		setPageComplete(false);
-	}
-
-	private void notifyChanged() {
-		for (final BranchChangeListener l : branchChangeListeners)
-			l.branchesChanged();
+		checkPage();
 	}
 }
\ No newline at end of file
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/BaseWizardPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/BaseWizardPage.java
new file mode 100644
index 0000000..bb5d1d4
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/BaseWizardPage.java
@@ -0,0 +1,58 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import java.util.LinkedList;
+import java.util.List;
+
+import org.eclipse.jface.wizard.WizardPage;
+
+/**
+ * Base wizard page class for pages that need support for inter-pages
+ * dependencies.
+ * <p>
+ * This abstract class maintains list of selection change listeners and provides
+ * method to notify them about selection change.
+ * 
+ * @see SelectionChangeListener
+ */
+public abstract class BaseWizardPage extends WizardPage {
+	private final List<SelectionChangeListener> selectionListeners;
+
+	/**
+	 * Create base wizard with specified name. Listeners list is empty.
+	 * 
+	 * @see WizardPage#WizardPage(String)
+	 * @param pageName
+	 *            page name.
+	 */
+	public BaseWizardPage(final String pageName) {
+		super(pageName);
+		selectionListeners = new LinkedList<SelectionChangeListener>();
+	}
+
+	/**
+	 * Add {@link SelectionChangeListener} to list of listeners notified on
+	 * selection change on this page.
+	 * 
+	 * @param l
+	 *            listener that will be notified about changes.
+	 */
+	public void addSelectionListener(final SelectionChangeListener l) {
+		selectionListeners.add(l);
+	}
+
+	/**
+	 * Notifies registered listeners about selection change.
+	 */
+	protected void notifySelectionChanged() {
+		for (final SelectionChangeListener l : selectionListeners)
+			l.selectionChanged();
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelection.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelection.java
new file mode 100644
index 0000000..d9aa6d5
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelection.java
@@ -0,0 +1,133 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+
+package org.spearce.egit.ui.internal.components;
+
+import java.util.Collections;
+import java.util.List;
+
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Data class representing selection of remote repository made by user.
+ * Selection is an URI or remote repository configuration.
+ * <p>
+ * Each immutable instance has at least one of two class fields (URI, remote
+ * config) set to null. null value indicates that it has illegal value or this
+ * form of repository selection is not selected.
+ * <p>
+ * If remote configuration is selected, it always has non-empty URIs list.
+ */
+public class RepositorySelection {
+	private URIish uri;
+
+	private RemoteConfig config;
+
+	static final RepositorySelection INVALID_SELECTION = new RepositorySelection(
+			null, null);
+
+	/**
+	 * @param uri
+	 *            the new specified URI. null if the new URI is invalid or user
+	 *            chosen to specify repository as remote config instead of URI.
+	 * @param config
+	 *            the new remote config. null if user chosen to specify
+	 *            repository as URI.
+	 */
+	RepositorySelection(final URIish uri, final RemoteConfig config) {
+		if (config != null && uri != null)
+			throw new IllegalArgumentException(
+					"URI and config cannot be set at the same time.");
+		this.config = config;
+		this.uri = uri;
+	}
+
+	/**
+	 * @return the selected URI (if specified by user as valid custom URI) or
+	 *         first URI from selected configuration (if specified by user as
+	 *         May be null if there is no valid selection.
+	 */
+	public URIish getURI() {
+		if (isConfigSelected())
+			return config.getURIs().get(0);
+		return uri;
+	}
+
+	/**
+	 * @return list of all selected URIs - either the one specified as custom
+	 *         URI or all URIs from selected configuration. May be null in case
+	 *         of no valid selection.
+	 */
+	public List<URIish> getAllURIs() {
+		if (isURISelected())
+			return Collections.singletonList(uri);
+		if (isConfigSelected())
+			return config.getURIs();
+		return null;
+	}
+
+	/**
+	 * @return the selected remote configuration. null if user chosen to select
+	 *         repository as URI.
+	 */
+	public RemoteConfig getConfig() {
+		return config;
+	}
+
+	/**
+	 * @return selected remote configuration name or null if selection is not a
+	 *         remote configuration.
+	 */
+	public String getConfigName() {
+		if (isConfigSelected())
+			return config.getName();
+		return null;
+	}
+
+	/**
+	 * @return true if selection contains valid URI or remote config, false if
+	 *         there is no valid selection.
+	 */
+	public boolean isValidSelection() {
+		return uri != null || config != null;
+	}
+
+	/**
+	 * @return true if user selected valid URI, false if user selected invalid
+	 *         URI or remote config.
+	 */
+	public boolean isURISelected() {
+		return uri != null;
+	}
+
+	/**
+	 * @return true if user selected remote configuration, false if user
+	 *         selected (invalid or valid) URI.
+	 */
+	public boolean isConfigSelected() {
+		return config != null;
+	}
+
+	@Override
+	public boolean equals(final Object obj) {
+		if (obj instanceof RepositorySelection) {
+			final RepositorySelection other = (RepositorySelection) obj;
+			if (uri == null ^ other.uri == null)
+				return false;
+			if (uri != null && !uri.equals(other.uri))
+				return false;
+
+			if (config != other.config)
+				return false;
+
+			return true;
+		} else
+			return false;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java
deleted file mode 100644
index ef5c33b..0000000
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java
+++ /dev/null
@@ -1,32 +0,0 @@
-/*******************************************************************************
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
- *
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * See LICENSE for the full license text, also available.
- *******************************************************************************/
-package org.spearce.egit.ui.internal.components;
-
-import org.spearce.jgit.transport.RemoteConfig;
-import org.spearce.jgit.transport.URIish;
-
-/**
- * Interface for listeners of repository selection events from repository
- * selection dialogs.
- */
-public interface RepositorySelectionListener {
-	/**
-	 * Notify the receiver that the repository selection has changed. Each time
-	 * at least one argument of this call is null, which indicates that it has
-	 * illegal value or this form of repository selection is not selected.
-	 * 
-	 * @param newURI
-	 *            the new specified URI. null if the new URI is invalid or user
-	 *            chosen to specify repository as remote config instead of URI.
-	 * @param newConfig
-	 *            the new remote config. null if user chosen to specify
-	 *            repository as URI.
-	 */
-	public void selectionChanged(URIish newURI, RemoteConfig newConfig);
-}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
index a487cb1..abb7ddb 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
@@ -13,11 +13,9 @@ package org.spearce.egit.ui.internal.components;
 import java.io.File;
 import java.net.URISyntaxException;
 import java.util.Iterator;
-import java.util.LinkedList;
 import java.util.List;
 import java.util.regex.Pattern;
 
-import org.eclipse.jface.wizard.WizardPage;
 import org.eclipse.osgi.util.NLS;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.ModifyEvent;
@@ -45,7 +43,7 @@ import org.spearce.jgit.util.FS;
  * Wizard page that allows the user entering the location of a remote repository
  * by specifying URL manually or selecting a preconfigured remote repository.
  */
-public class RepositorySelectionPage extends WizardPage {
+public class RepositorySelectionPage extends BaseWizardPage {
 	private static final int REMOTE_CONFIG_TEXT_MAX_LENGTH = 80;
 
 	private static final String DEFAULT_REMOTE_NAME = "origin";
@@ -75,7 +73,7 @@ public class RepositorySelectionPage extends WizardPage {
 		DEFAULT_SCHEMES[S_FTP] = "ftp";
 		DEFAULT_SCHEMES[S_FILE] = "file";
 	}
-	
+
 	private static void setEnabledRecursively(final Control control,
 			final boolean enable) {
 		control.setEnabled(enable);
@@ -84,8 +82,6 @@ public class RepositorySelectionPage extends WizardPage {
 				setEnabledRecursively(child, enable);
 	}
 
-	private final List<RepositorySelectionListener> selectionListeners;
-
 	private final List<RemoteConfig> configuredRemotes;
 
 	private Group authGroup;
@@ -110,9 +106,7 @@ public class RepositorySelectionPage extends WizardPage {
 
 	private RemoteConfig remoteConfig;
 
-	private RemoteConfig exposedRemoteConfig;
-
-	private URIish exposedURI;
+	private RepositorySelection selection;
 
 	private Composite remotePanel;
 
@@ -155,6 +149,7 @@ public class RepositorySelectionPage extends WizardPage {
 			this.configuredRemotes = configuredRemotes;
 			this.remoteConfig = selectDefaultRemoteConfig();
 		}
+		selection = RepositorySelection.INVALID_SELECTION;
 
 		if (sourceSelection) {
 			setTitle(UIText.RepositorySelectionPage_sourceSelectionTitle);
@@ -163,7 +158,6 @@ public class RepositorySelectionPage extends WizardPage {
 			setTitle(UIText.RepositorySelectionPage_destinationSelectionTitle);
 			setDescription(UIText.RepositorySelectionPage_destinationSelectionDescription);
 		}
-		selectionListeners = new LinkedList<RepositorySelectionListener>();
 	}
 
 	/**
@@ -180,15 +174,22 @@ public class RepositorySelectionPage extends WizardPage {
 	}
 
 	/**
-	 * Add {@link RepositorySelectionListener} to list of listeners notified on
-	 * repository selection change.
+	 * @return repository selection representing current page state.
+	 */
+	public RepositorySelection getSelection() {
+		return selection;
+	}
+
+	/**
+	 * Compare current repository selection set by user to provided one.
 	 * 
-	 * @param l
-	 *            listener that will be notified about changes
+	 * @param s
+	 *            repository selection to compare.
+	 * @return true if provided selection is equal to current page selection,
+	 *         false otherwise.
 	 */
-	public void addRepositorySelectionListener(
-			final RepositorySelectionListener l) {
-		selectionListeners.add(l);
+	public boolean selectionEquals(final RepositorySelection s) {
+		return selection.equals(s);
 	}
 
 	public void createControl(final Composite parent) {
@@ -423,23 +424,6 @@ public class RepositorySelectionPage extends WizardPage {
 		return new GridData(SWT.FILL, SWT.DEFAULT, true, false);
 	}
 
-	/**
-	 * @return the URI entered in the Wizard page. null if URI is invalid or
-	 *         user chosen to select remote config instead of providing direct
-	 *         URI.
-	 */
-	public URIish getURI() {
-		return exposedURI;
-	}
-
-	/**
-	 * @return the selected remote configuration in the Wizard page. null if
-	 *         user chosen to select repository as URI.
-	 */
-	public RemoteConfig getRemoteConfig() {
-		return exposedRemoteConfig;
-	}
-
 	private static boolean isGIT(final URIish uri) {
 		return "git".equals(uri.getScheme());
 	}
@@ -637,13 +621,12 @@ public class RepositorySelectionPage extends WizardPage {
 	}
 
 	private void setExposedSelection(final URIish u, final RemoteConfig rc) {
-		if (u == exposedURI && rc == exposedRemoteConfig) // nothing changed
+		final RepositorySelection newSelection = new RepositorySelection(u, rc);
+		if (newSelection.equals(selection))
 			return;
-		this.exposedURI = u;
-		this.exposedRemoteConfig = rc;
 
-		for (final RepositorySelectionListener l : selectionListeners)
-			l.selectionChanged(u, rc);
+		selection = newSelection;
+		notifySelectionChanged();
 	}
 
 	private void updateRemoteAndURIPanels() {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/BranchChangeListener.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/SelectionChangeListener.java
similarity index 50%
rename from org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/BranchChangeListener.java
rename to org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/SelectionChangeListener.java
index 3ef8e16..bde1d21 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/BranchChangeListener.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/SelectionChangeListener.java
@@ -1,13 +1,19 @@
 /*******************************************************************************
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
  * See LICENSE for the full license text, also available.
  *******************************************************************************/
-package org.spearce.egit.ui.internal.clone;
+package org.spearce.egit.ui.internal.components;
 
-interface BranchChangeListener {
-	/** Notify the receiver that the branches have changed. */
-	void branchesChanged();
+/**
+ * General interface for receivers of selection-changed notifications from
+ * various components.
+ */
+public interface SelectionChangeListener {
+	/**
+	 * Called when selection in calling component has changed.
+	 */
+	public void selectionChanged();
 }
-- 
1.5.6.3
