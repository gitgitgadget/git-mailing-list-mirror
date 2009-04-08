From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Externalize strings in GitPropertyPage
Date: Wed,  8 Apr 2009 17:49:41 +0200
Message-ID: <1239205781-28009-2-git-send-email-robin.rosenberg@dewire.com>
References: <1239205781-28009-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lra3l-0002tO-SV
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZDHPtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbZDHPtx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:49:53 -0400
Received: from mail.dewire.com ([83.140.172.130]:6895 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbZDHPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 11:49:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C2E6414915D6;
	Wed,  8 Apr 2009 17:49:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y-LPQ7HYLUFZ; Wed,  8 Apr 2009 17:49:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id A621D14915D7;
	Wed,  8 Apr 2009 17:49:44 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1239205781-28009-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116088>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |   21 ++++++++++++++++++++
 .../preferences/GitProjectPropertyPage.java        |   15 +++++++------
 .../src/org/spearce/egit/ui/uitext.properties      |    7 ++++++
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 5a1e328..f14eada 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -98,6 +98,27 @@
 	public static String GitCloneWizard_errorCannotCreate;
 
 	/** */
+	public static String GitProjectPropertyPage_LabelBranch;
+
+	/** */
+	public static String GitProjectPropertyPage_LabelGitDir;
+
+	/** */
+	public static String GitProjectPropertyPage_LabelId;
+
+	/** */
+	public static String GitProjectPropertyPage_LabelState;
+
+	/** */
+	public static String GitProjectPropertyPage_LabelWorkdir;
+
+	/** */
+	public static String GitProjectPropertyPage_ValueEmptyRepository;
+
+	/** */
+	public static String GitProjectPropertyPage_ValueUnbornBranch;
+
+	/** */
 	public static String RepositorySelectionPage_sourceSelectionTitle;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
index d3afd97..79cf60e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
@@ -21,6 +21,7 @@
 import org.eclipse.swt.widgets.Text;
 import org.eclipse.ui.dialogs.PropertyPage;
 import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 
@@ -53,11 +54,11 @@ protected Control createContents(Composite parent) {
 		layout.verticalSpacing = 0;
 		composite.setLayout(layout);
 
-		gitDir = createLabeledReadOnlyText(composite, "Git directory:");
-		workDir = createLabeledReadOnlyText(composite, "Working directory:");
-		branch = createLabeledReadOnlyText(composite, "Branch:");
-		id = createLabeledReadOnlyText(composite, "Id:");
-		state = createLabeledReadOnlyText(composite, "Current state:");
+		gitDir = createLabeledReadOnlyText(composite, UIText.GitProjectPropertyPage_LabelGitDir);
+		workDir = createLabeledReadOnlyText(composite, UIText.GitProjectPropertyPage_LabelWorkdir);
+		branch = createLabeledReadOnlyText(composite, UIText.GitProjectPropertyPage_LabelBranch);
+		id = createLabeledReadOnlyText(composite, UIText.GitProjectPropertyPage_LabelId);
+		state = createLabeledReadOnlyText(composite, UIText.GitProjectPropertyPage_LabelState);
 
 		// Get the project that is the source of this property page
 		IProject project = null;
@@ -96,9 +97,9 @@ private void fillValues(Repository repository) throws IOException {
 				.resolve(repository.getFullBranch());
 		if (objectId == null) {
 			if (repository.getAllRefs().size() == 0)
-				id.setText("None (empty repository)");
+				id.setText(UIText.GitProjectPropertyPage_ValueEmptyRepository);
 			else
-				id.setText("None (unborn branch)");
+				id.setText(UIText.GitProjectPropertyPage_ValueUnbornBranch);
 		} else
 			id.setText(objectId.name());
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 692df5f..1e1a29d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -46,6 +46,13 @@ GitCloneWizard_title=Import Git Repository
 GitCloneWizard_jobName=Cloning from {0}
 GitCloneWizard_failed=Git repository clone failed.
 GitCloneWizard_errorCannotCreate=Cannot create directory {0}.
+GitProjectPropertyPage_LabelBranch=Branch:
+GitProjectPropertyPage_LabelGitDir=Git directory:
+GitProjectPropertyPage_LabelId=Id:
+GitProjectPropertyPage_LabelState=Current state:
+GitProjectPropertyPage_LabelWorkdir=Working directory:
+GitProjectPropertyPage_ValueEmptyRepository=None (empty repository)
+GitProjectPropertyPage_ValueUnbornBranch=None (unborn branch)
 
 RepositorySelectionPage_sourceSelectionTitle=Source Git Repository
 RepositorySelectionPage_sourceSelectionDescription=Enter the location of the source repository.
-- 
1.6.2.2.446.gfbdc0
