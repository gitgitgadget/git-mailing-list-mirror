From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 2/2] Fix t4013 with commit date in mbox 'From COMMIT DATE'
 header lines
Date: Fri, 16 Apr 2010 17:42:36 +0100
Message-ID: <2b1d2ec748f3a28e7210f235df29703fd425e08a.1271436192.git.chris@arachsys.com>
References: <20100416075251.GA25147@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 18:44:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2oes-0005tj-Q5
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587Ab0DPQol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:44:41 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:44901 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab0DPQol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:44:41 -0400
Received: from [94.172.195.14] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2oek-0000wN-WD; Fri, 16 Apr 2010 17:44:39 +0100
Content-Disposition: inline
In-Reply-To: <20100416075251.GA25147@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145081>

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 t/t4013-diff-various.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index dae6358..ce42d3f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -110,7 +110,8 @@ do
 			echo "\$ git $cmd"
 			git $cmd |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
-			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
+			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/" \
+			    -e "s/^\\(From [0-9a-f][0-9a-f]*\\) .*/\\1 Mon Sep 17 00:00:00 2001/"
 			echo "\$"
 		} >"$actual" &&
 		if test -f "$expect"
-- 
1.7.0.3
