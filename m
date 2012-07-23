From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 2/5] Use variables for the lists of tools that support
 merging / diffing
Date: Mon, 23 Jul 2012 09:18:12 +0200
Message-ID: <500CFAB4.4050905@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StCwC-0007qW-Jb
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808Ab2GWHUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:20:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:43625 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312Ab2GWHUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:20:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1StCw3-0007bD-4v
	for git@vger.kernel.org; Mon, 23 Jul 2012 09:20:07 +0200
Received: from p5ddb0653.dip0.t-ipconnect.de ([93.219.6.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:20:07 +0200
Received: from sschuberth by p5ddb0653.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:20:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0653.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <500CF9D2.30102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201915>

Also, add a few comments that clarify the meaning of these variables.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f2c4894..6b9b79d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1325,17 +1325,24 @@ _git_diff ()
 	__git_complete_revlist_file
 }
 
+# Tools that support both merging and diffing.
 __git_mergetools_common="araxis bc3 diffuse ecmerge emerge gvimdiff
 			kdiff3 meld opendiff p4merge tkdiff vimdiff xxdiff
 "
 
+# Tools that support diffing.
+__git_difftools="$__git_mergetools_common kcompare"
+
+# Tools that support merging.
+__git_mergetools="$__git_mergetools_common tortoisemerge"
+
 _git_difftool ()
 {
 	__git_has_doubledash && return
 
 	case "$cur" in
 	--tool=*)
-		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
+		__gitcomp "$__git_difftools" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
@@ -1623,7 +1630,7 @@ _git_mergetool ()
 {
 	case "$cur" in
 	--tool=*)
-		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
+		__gitcomp "$__git_mergetools" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
-- 
1.7.11.msysgit.2
