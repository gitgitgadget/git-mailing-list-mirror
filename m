From: pasky@suse.cz
Subject: [PATCH 1/5] git-gui: Avoid using the term URL when specifying repositories
Date: Thu, 25 Sep 2008 00:12:50 +0200
Message-ID: <20080924221731.236909653@suse.cz>
References: <20080924221249.037449176@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 00:19:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KichR-0008KG-UF
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbYIXWRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbYIXWRp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:17:45 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49859 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752583AbYIXWRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:17:43 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id B0E1C2AC8AA; Thu, 25 Sep 2008 00:17:31 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/avoid-url.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96698>

Instead, 'Location' is used to label such inputs; in the Clone dialog,
'Source' and 'Target' are also introduced to further clarify the situation.
The intent is to increase GUI consistency in the case location templates
(upcoming) are used - then, other locators than URL may be used.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/lib/choose_repository.tcl    |    4 ++--
 git-gui/lib/remote_branch_delete.tcl |    2 +-
 git-gui/lib/transport.tcl            |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 3180786..f54d88a 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -463,7 +463,7 @@ method _do_clone {} {
 	frame $w_body.args
 	pack $args -fill both
 
-	label $args.origin_l -text [mc "URL:"]
+	label $args.origin_l -text [mc "Source Location:"]
 	entry $args.origin_t \
 		-textvariable @origin_url \
 		-font font_diff \
@@ -473,7 +473,7 @@ method _do_clone {} {
 		-command [cb _open_origin]
 	grid $args.origin_l $args.origin_t $args.origin_b -sticky ew
 
-	label $args.where_l -text [mc "Directory:"]
+	label $args.where_l -text [mc "Target Directory:"]
 	entry $args.where_t \
 		-textvariable @local_path \
 		-font font_diff \
diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index c7b8148..a09b9ad 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -63,7 +63,7 @@ constructor dialog {} {
 		set urltype url
 	}
 	radiobutton $w.dest.url_r \
-		-text [mc "Arbitrary URL:"] \
+		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable @urltype
 	entry $w.dest.url_t \
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index 8e6a9d0..e419d78 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -135,7 +135,7 @@ proc do_push_anywhere {} {
 		set push_urltype url
 	}
 	radiobutton $w.dest.url_r \
-		-text [mc "Arbitrary URL:"] \
+		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable push_urltype
 	entry $w.dest.url_t \
-- 
tg: (c427559..) t/git-gui/avoid-url (depends on: vanilla/master)
