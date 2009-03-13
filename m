From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-gui: don't hide the Browse button when resizing the repo chooser
Date: Sat, 14 Mar 2009 00:42:37 +0100
Message-ID: <200903140042.37845.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 14 00:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiH2h-0002zI-7b
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 00:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbZCMXmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbZCMXmV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 19:42:21 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33440 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZCMXmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 19:42:20 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 46F80FE94BCF;
	Sat, 14 Mar 2009 00:42:18 +0100 (CET)
Received: from [89.59.108.241] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LiH18-0000iS-00; Sat, 14 Mar 2009 00:42:18 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/dAhXyxdqLDvYNvNqSqiCkmt5D2ntpHBywhYyf
	5Iu8KCYFwQkbvzYWf+z/trauoWkQDCjNzme6NLS2bqt5Me01VL
	EjBkY/HgIXmmBz/43XAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113225>

Rather shrink the input field for "Create New Repository" and "Open
Existing Repository" as it's already done for "Clone Existing
Repository".

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-gui/lib/choose_repository.tcl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index f9ff62a..09277e9 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -398,6 +398,8 @@ method _do_new {} {
 	grid $w_body.where.l $w_body.where.t $w_body.where.b -sticky ew
 	pack $w_body.where -fill x
 
+	grid columnconfigure $w_body.where 1 -weight 1
+
 	trace add variable @local_path write [cb _write_local_path]
 	bind $w_body.h <Destroy> [list trace remove variable @local_path write [cb _write_local_path]]
 	update
@@ -998,6 +1000,8 @@ method _do_open {} {
 	grid $w_body.where.l $w_body.where.t $w_body.where.b -sticky ew
 	pack $w_body.where -fill x
 
+	grid columnconfigure $w_body.where 1 -weight 1
+
 	trace add variable @local_path write [cb _write_local_path]
 	bind $w_body.h <Destroy> [list trace remove variable @local_path write [cb _write_local_path]]
 	update
-- 
1.6.2.106.gc2bb8
