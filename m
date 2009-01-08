From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/7] Add shortcuts to the Git cloning wizard
Date: Thu,  8 Jan 2009 17:56:27 +0100
Message-ID: <1231433791-9267-4-git-send-email-robin.rosenberg@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyDM-0001ZY-5m
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbZAHQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbZAHQ4k
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:40 -0500
Received: from mail.dewire.com ([83.140.172.130]:25779 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbZAHQ4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5333F1484F6F;
	Thu,  8 Jan 2009 17:56:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PjrKvZ7k6D8t; Thu,  8 Jan 2009 17:56:34 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E82A01484F71;
	Thu,  8 Jan 2009 17:56:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231433791-9267-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104936>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../components/RepositorySelectionPage.java        |   12 +++++--
 .../src/org/spearce/egit/ui/uitext.properties      |   30 ++++++++++----------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
index 4f02c95..95df71e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
@@ -536,7 +536,7 @@ private void checkPage() {
 				if (uri.getPath() == null) {
 					selectionIncomplete(NLS.bind(
 							UIText.RepositorySelectionPage_fieldRequired,
-							UIText.RepositorySelectionPage_promptPath, proto));
+							unamp(UIText.RepositorySelectionPage_promptPath), proto));
 					return;
 				}
 
@@ -552,7 +552,7 @@ else if (uri.getPass() != null)
 						selectionIncomplete(NLS
 								.bind(
 										UIText.RepositorySelectionPage_fieldNotSupported,
-										badField, proto));
+										unamp(badField), proto));
 						return;
 					}
 
@@ -571,7 +571,7 @@ selectionIncomplete(NLS.bind(
 				if (uri.getHost() == null) {
 					selectionIncomplete(NLS.bind(
 							UIText.RepositorySelectionPage_fieldRequired,
-							UIText.RepositorySelectionPage_promptHost, proto));
+							unamp(UIText.RepositorySelectionPage_promptHost), proto));
 					return;
 				}
 
@@ -585,7 +585,7 @@ else if (uri.getPass() != null)
 						selectionIncomplete(NLS
 								.bind(
 										UIText.RepositorySelectionPage_fieldNotSupported,
-										badField, proto));
+										unamp(badField), proto));
 						return;
 					}
 				}
@@ -608,6 +608,10 @@ selectionIncomplete(NLS
 		}
 	}
 
+	private String unamp(String s) {
+		return s.replace("&","");
+	}
+
 	private void selectionIncomplete(final String errorMessage) {
 		setExposedSelection(null, null);
 		setErrorMessage(errorMessage);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 7f2e4b0..3819047 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -28,7 +28,7 @@ WizardProjectsImportPage_CheckingMessage = Checking: {0}
 WizardProjectsImportPage_SelectDialogTitle = Select root directory of the projects to import
 WizardProjectImportPage_errorMessage = Creation Problems
 WizardProjectsImportPage_CreateProjectsTask = Creating Projects
-WizardProjectsImportPage_enableGit = Enable Git Team operations on imported projects
+WizardProjectsImportPage_enableGit = Enable &Git Team operations on imported projects
 
 SharingWizard_windowTitle=Configure Git Repository
 SharingWizard_failed=Failed to initialize Git team provider.
@@ -56,13 +56,13 @@ RepositorySelectionPage_uriChoice=Custom URI
 RepositorySelectionPage_groupLocation=Location
 RepositorySelectionPage_groupAuthentication=Authentication
 RepositorySelectionPage_groupConnection=Connection
-RepositorySelectionPage_promptURI=URI
-RepositorySelectionPage_promptHost=Host
-RepositorySelectionPage_promptPath=Repository path
-RepositorySelectionPage_promptUser=User
-RepositorySelectionPage_promptPassword=Password
-RepositorySelectionPage_promptScheme=Protocol
-RepositorySelectionPage_promptPort=Port
+RepositorySelectionPage_promptURI=UR&I
+RepositorySelectionPage_promptHost=&Host
+RepositorySelectionPage_promptPath=&Repository path
+RepositorySelectionPage_promptUser=&User
+RepositorySelectionPage_promptPassword=&Password
+RepositorySelectionPage_promptScheme=Protoco&l
+RepositorySelectionPage_promptPort=Por&t
 RepositorySelectionPage_fieldRequired={0} required for {1} protocol.
 RepositorySelectionPage_fieldNotSupported={0} not supported on {1} protocol.
 RepositorySelectionPage_fileNotFound={0} does not exist.
@@ -70,9 +70,9 @@ RepositorySelectionPage_internalError=Internal error; consult Eclipse error log.
 
 SourceBranchPage_title=Source Git Repository
 SourceBranchPage_description=Select branches to clone from remote repository.
-SourceBranchPage_branchList=Branches of {0}:
-SourceBranchPage_selectAll=Select All
-SourceBranchPage_selectNone=Deselect All
+SourceBranchPage_branchList=Branches &of {0}:
+SourceBranchPage_selectAll=&Select All
+SourceBranchPage_selectNone=&Deselect All
 SourceBranchPage_errorBranchRequired=At least one branch must be selected.
 SourceBranchPage_transportError=Transport Error
 SourceBranchPage_cannotListBranches=Cannot list the available branches.
@@ -84,11 +84,11 @@ CloneDestinationPage_title=Local Destination
 CloneDestinationPage_description=Configure the local storage location for {0}.
 CloneDestinationPage_groupDestination=Destination
 CloneDestinationPage_groupConfiguration=Configuration
-CloneDestinationPage_promptDirectory=Directory
-CloneDestinationPage_promptInitialBranch=Initial branch
-CloneDestinationPage_promptRemoteName=Remote name
+CloneDestinationPage_promptDirectory=&Directory
+CloneDestinationPage_promptInitialBranch=Initial &branch
+CloneDestinationPage_promptRemoteName=Remote na&me
 CloneDestinationPage_fieldRequired={0} is required.
-CloneDestinationPage_browseButton=Browse
+CloneDestinationPage_browseButton=Bro&wse
 CloneDestinationPage_errorNotEmptyDir={0} is not an empty directory.
 CloneDestinationPage_importProjectsAfterClone=&Import projects after clone
 CloneDestinationPage_workspaceImport=Workspace import
-- 
1.6.1.rc3.56.gd0306
