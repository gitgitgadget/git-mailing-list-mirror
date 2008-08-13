From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: [PATCH] Fix invalid menubar and toolbar entries in plugin.xml
Date: Wed, 13 Aug 2008 21:07:54 +0200
Message-ID: <48A3310A.8080306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 21:09:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTLii-0002ZL-Or
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 21:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYHMTIF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 15:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYHMTIE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 15:08:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:59069 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYHMTIC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 15:08:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so63873nfc.21
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Kv4yMMnjWCz/FgssMZDai8PpWwHy1CG4b0aX60orkKU=;
        b=Kf656/muTmOkBag4ybFGaUJ4vyA92NJm4zeo9eUgRATS6sdlbTyp0rgqzcotn+VMLM
         bLcwrxBbZL1DuU4EwJxpoMQpxKbI7kmcARb3cU6WohWqhfbNk4sSjCjvVlyxAQJ8JIM8
         1GJDHF22p1SXNG+ZBstuaOWZBcRETOD9Nlbws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Im76BgnmXDvpBZQX7dV0kA1hl3fe0SS9P5Fl89h3dUxlVJmRrEyKgX6LmfgQ53NsWt
         2Km0ydE7EgbkCZhC6ozpIxx/n0voCSx2lWxM+sSNZklDJhjp0LD9R+AF/i8BlHh7Dkt3
         p6AygQ3JUACegyD2sdyNsI9zfQZERBqJOJ5U0=
Received: by 10.210.120.17 with SMTP id s17mr197539ebc.181.1218654480605;
        Wed, 13 Aug 2008 12:08:00 -0700 (PDT)
Received: from ?192.168.1.20? ( [84.202.12.123])
        by mx.google.com with ESMTPS id z37sm801834ikz.6.2008.08.13.12.07.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 12:07:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92254>

The default toolbar is identified by the path 'Normal',
and we use the default group, named by 'additions'.

The menu entry was not used, and was causing an extra
empty space in the menu bar.

Also, renamed the action set label to be consistent with
what the other platform plugins do (no 'actions' postfix).

Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>
---
 org.spearce.egit.ui/plugin.properties |    2 +-
 org.spearce.egit.ui/plugin.xml        |   18 ++++--------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.u=
i/plugin.properties
index 3240ec0..ce3b058 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -41,7 +41,7 @@ ResetAction_tooltip=3DReset the current branch to the=
 same or another commit
 BranchAction_label=3D&Branch...
 BranchAction_tooltip=3DSwitch to another branch
=20
-GitActions_label=3DGit actions
+GitActions_label=3DGit
 GitMenu_label=3D&Git
=20
=20
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugi=
n.xml
index 393121f..97eb2a6 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -243,12 +243,6 @@
 	    label=3D"%GitActions_label"
 	    visible=3D"true"
 	    >
-	    <menu
-           id=3D"org.spearce.egit.ui.gitmenu"
-           label=3D"%GitMenu_label"
-           path=3D"org.spearce.egit.ui.gitmenu"
-           >
-	    </menu>
 		<action
 		       class=3D"org.spearce.egit.ui.internal.actions.BranchAction"
 		       disabledIcon=3D"icons/toolbar/checkoutd.png"
@@ -256,8 +250,7 @@
 		       id=3D"org.spearce.egit.ui.actionbranch"
 		       label=3D"%BranchAction_label"
 		       style=3D"push"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"%BranchAction_tooltip">
 		</action>
 		<action
@@ -267,8 +260,7 @@
 		       id=3D"org.spearce.egit.ui.actioncommit"
 		       label=3D"%CommitAction_label"
 		       style=3D"push"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"%CommitAction_tooltip">
 		</action>
 		<action
@@ -278,8 +270,7 @@
 		       id=3D"org.spearce.egit.ui.actionreset"
 		       label=3D"%ResetAction_label"
 		       style=3D"push"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"%ResetAction_tooltip">
 		</action>
 		<action
@@ -288,9 +279,8 @@
 		       icon=3D"icons/toolbar/tracke.png"
 		       id=3D"org.spearce.egit.ui.trackaction"
 		       label=3D"%TrackAction_label"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
 		       style=3D"push"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"Start tracking the selected resources">
 		</action>
       </actionSet>
--=20
1.5.6.5
