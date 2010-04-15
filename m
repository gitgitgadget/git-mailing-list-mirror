From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] Fix t4013 with current date in mbox 'From COMMIT DATE'
 header lines
Date: Thu, 15 Apr 2010 16:57:46 +0100
Message-ID: <d64c9b1fe1b02cdf9f67760e43141c3410388957.1271346952.git.chris@arachsys.com>
References: <20100415151619.GK12365@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 17:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2RRz-00016N-5f
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 17:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab0DOP5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 11:57:48 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:53969 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab0DOP5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 11:57:47 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2RRq-0004VN-MJ; Thu, 15 Apr 2010 16:57:47 +0100
Content-Disposition: inline
In-Reply-To: <20100415151619.GK12365@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144996>

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
