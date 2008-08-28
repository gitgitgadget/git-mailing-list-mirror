From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 3/3] Show ErrorDialog fot fatal connection errors in ConfirmationPage
Date: Thu, 28 Aug 2008 03:36:10 +0200
Message-ID: <1219887370-17265-3-git-send-email-marek.zawirski@gmail.com>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com>
 <1219887370-17265-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWS4-0003SQ-9I
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbYH1BgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYH1BgY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:36:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:20135 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbYH1BgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:36:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so35073nfc.21
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3tZaZSDoKYrXPl3DsNe3+sh+BK8LbC2xeH5/d0pP3gg=;
        b=oUXgwZ2jDPzduRTLU4rLIzgBoLt/X7YjmczOEkA1Vwp8oFbPrCwzwSCyqyXfEUAfEh
         7iAtcyPQDBNTNLNWvoUhojosMtmPEPTyDXmOkivgj1mayeI8xCe3tCV1rzFG//pFgh5T
         YhgYLMWYSBE5K5/0d+kaIiTdAtpSg3K1SuG80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lGayRTCW6pO8cCONjADiKfXfunv2r8r9p897L8rk4aoINCWCLJoidjYUP746Mv+9UP
         BPBtwXAnMevAME0YTcz/upPPPy6JVlPoXhFsNtfLi36Sl95c0Kf5zq4upjHnR00bGe6T
         /dsWwYbmCtCY9F6b2PXeXtTRLXwRhPUL602fw=
Received: by 10.103.173.5 with SMTP id a5mr416157mup.117.1219887382093;
        Wed, 27 Aug 2008 18:36:22 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id y37sm432553mug.18.2008.08.27.18.36.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 18:36:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219887370-17265-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94011>

We already do the same in analogous RefSpecPage and PushWizard etc., so
let's do the same here.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    3 +++
 .../egit/ui/internal/push/ConfirmationPage.java    |   16 ++++++++++++++--
 .../src/org/spearce/egit/ui/uitext.properties      |    1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index b2cb340..b09cc10 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -518,6 +518,9 @@
 	public static String PushWizard_windowTitleWithDestination;
 
 	/** */
+	public static String ConfirmationPage_cantConnectToAnyTitle;
+
+	/** */
 	public static String ConfirmationPage_cantConnectToAny;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
index 08d21b3..6e925a7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
@@ -13,6 +13,9 @@
 import java.util.Collection;
 import java.util.List;
 
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.jface.dialogs.ErrorDialog;
 import org.eclipse.jface.wizard.WizardPage;
 import org.eclipse.osgi.util.NLS;
 import org.eclipse.swt.SWT;
@@ -24,6 +27,7 @@
 import org.spearce.egit.core.op.PushOperation;
 import org.spearce.egit.core.op.PushOperationResult;
 import org.spearce.egit.core.op.PushOperationSpecification;
+import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIText;
 import org.spearce.egit.ui.internal.components.RefSpecPage;
 import org.spearce.egit.ui.internal.components.RepositorySelection;
@@ -204,8 +208,16 @@ setErrorMessage(NLS.bind(UIText.ConfirmationPage_errorUnexpected, e
 			setPageComplete(true);
 			confirmedResult = result;
 		} else {
-			setErrorMessage(NLS.bind(UIText.ConfirmationPage_cantConnectToAny,
-					result.getErrorStringForAllURis()));
+			final String message = NLS.bind(
+					UIText.ConfirmationPage_cantConnectToAny, result
+							.getErrorStringForAllURis());
+			setErrorMessage(message);
+			ErrorDialog
+					.openError(getShell(),
+							UIText.ConfirmationPage_cantConnectToAnyTitle,
+							null,
+							new Status(IStatus.ERROR, Activator.getPluginId(),
+									message));
 		}
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 0590e30..22e29c2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -199,6 +199,7 @@ PushWizard_unexpectedError=Unexpected error occurred.
 PushWizard_windowTitleDefault=Push To Another Repositories
 PushWizard_windowTitleWithDestination=Push To: {0}
 
+ConfirmationPage_cantConnectToAnyTitle=Can't Connect
 ConfirmationPage_cantConnectToAny=Can't connect to any URI: {0}
 ConfirmationPage_description=Confirm following expected push result.
 ConfirmationPage_errorCantResolveSpecs=Can't resolve ref specifications locally or create tracking ref update: {0}
-- 
1.5.6.3
