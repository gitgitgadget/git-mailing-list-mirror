From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 5/5] Add a few more code comments and blank lines in guess_merge_tool
Date: Mon, 23 Jul 2012 09:20:52 +0200
Message-ID: <500CFB54.2030109@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StDAo-00065P-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab2GWHfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:35:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:52980 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab2GWHfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:35:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1StDAZ-0005td-EJ
	for git@vger.kernel.org; Mon, 23 Jul 2012 09:35:07 +0200
Received: from p5ddb0653.dip0.t-ipconnect.de ([93.219.6.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:35:07 +0200
Received: from sschuberth by p5ddb0653.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:35:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0653.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <500CF9D2.30102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201920>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-mergetool--lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index ed630b2..ac9a8f0 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -112,14 +112,17 @@ run_merge_tool () {
 }
 
 guess_merge_tool () {
+	# Add tools that can either do merging or diffing, but not both.
 	if merge_mode
 	then
 		tools="tortoisemerge"
 	else
 		tools="kompare"
 	fi
+
 	if test -n "$DISPLAY"
 	then
+		# Prefer GTK-based tools under Gnome.
 		if test -n "$GNOME_DESKTOP_SESSION_ID"
 		then
 			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
@@ -128,6 +131,8 @@ guess_merge_tool () {
 		fi
 		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
 	fi
+
+	# Prefer vimdiff if vim is the default editor.
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
 		tools="$tools vimdiff emerge"
@@ -136,6 +141,7 @@ guess_merge_tool () {
 		tools="$tools emerge vimdiff"
 		;;
 	esac
+
 	echo >&2 "merge tool candidates: $tools"
 
 	# Loop over each candidate and stop when a valid merge tool is found.
-- 
1.7.11.msysgit.2
