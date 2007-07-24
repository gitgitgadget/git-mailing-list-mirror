From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] Mark more strings for i18n, including the status message
	list.
Date: Tue, 24 Jul 2007 11:29:22 +0200
Message-ID: <20070724112922.6wiilqqdk4cwk4kc@webmail.tu-harburg.de>
References: <1282.25717.qm@web38901.mail.mud.yahoo.com>
	<20070724112701.ndpm5fxaocks804s@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGhv-0002kT-Uv
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764783AbXGXJ33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761713AbXGXJ33
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:29:29 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:49988 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760611AbXGXJ32 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 05:29:28 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6O9TMRc010917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Jul 2007 11:29:22 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6O9TMsG015487;
	Tue, 24 Jul 2007 11:29:22 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 77C9DE50349; Tue, 24 Jul 2007 11:29:22 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Tue, 24 Jul 2007
	11:29:22 +0200
In-Reply-To: <20070724112701.ndpm5fxaocks804s@webmail.tu-harburg.de>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53546>

Mark more strings for i18n, including the status message list.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
  git-gui.sh |   49 +++++++++++++++++++++++++------------------------
  1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index fa510b9..6f5533b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1340,31 +1340,32 @@ set all_icons(O$ui_workdir) file_plain

  set max_status_desc 0
  foreach i {
-		{__ "Unmodified"}
-
-		{_M "Modified, not staged"}
-		{M_ "Staged for commit"}
-		{MM "Portions staged for commit"}
-		{MD "Staged for commit, missing"}
-
-		{_O "Untracked, not staged"}
-		{A_ "Staged for commit"}
-		{AM "Portions staged for commit"}
-		{AD "Staged for commit, missing"}
-
-		{_D "Missing"}
-		{D_ "Staged for removal"}
-		{DO "Staged for removal, still present"}
-
-		{U_ "Requires merge resolution"}
-		{UU "Requires merge resolution"}
-		{UM "Requires merge resolution"}
-		{UD "Requires merge resolution"}
+		{__ {mc "Unmodified"}}
+
+		{_M {mc "Modified, not staged"}}
+		{M_ {mc "Staged for commit"}}
+		{MM {mc "Portions staged for commit"}}
+		{MD {mc "Staged for commit, missing"}}
+
+		{_O {mc "Untracked, not staged"}}
+		{A_ {mc "Staged for commit"}}
+		{AM {mc "Portions staged for commit"}}
+		{AD {mc "Staged for commit, missing"}}
+
+		{_D {mc "Missing"}}
+		{D_ {mc "Staged for removal"}}
+		{DO {mc "Staged for removal, still present"}}
+
+		{U_ {mc "Requires merge resolution"}}
+		{UU {mc "Requires merge resolution"}}
+		{UM {mc "Requires merge resolution"}}
+		{UD {mc "Requires merge resolution"}}
  	} {
-	if {$max_status_desc < [string length [lindex $i 1]]} {
-		set max_status_desc [string length [lindex $i 1]]
+	set text [eval [lindex $i 1]]
+	if {$max_status_desc < [string length $text]} {
+		set max_status_desc [string length $text]
  	}
-	set all_descs([lindex $i 0]) [lindex $i 1]
+	set all_descs([lindex $i 0]) $text
  }
  unset i

@@ -2299,7 +2300,7 @@ proc trace_current_diff_path {varname args} {
  	} else {
  		set p $current_diff_path
  		set s [mapdesc [lindex $file_states($p) 0] $p]
-		set f {File:}
+		set f [mc "File:"]
  		set p [escape_path $p]
  		set o normal
  	}
-- 
1.5.3.rc2.12.gbc280
