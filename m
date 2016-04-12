From: Nikola =?ISO-8859-1?Q?Forr=F3?= <nforro@redhat.com>
Subject: [PATCH v2] difftool/mergetool: make the form of yes/no questions
 consistent
Date: Tue, 12 Apr 2016 16:44:20 +0200
Organization: Red Hat
Message-ID: <1460472260.3214.23.camel@redhat.com>
Reply-To: nforro@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 16:44:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apzYK-0001Wg-FP
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 16:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933499AbcDLOoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 10:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834AbcDLOoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 10:44:23 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8CF07F6B6;
	Tue, 12 Apr 2016 14:44:22 +0000 (UTC)
Received: from unused-4-132.brq.redhat.com (unused-4-132.brq.redhat.com [10.34.4.132])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3CEiKPq003390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 12 Apr 2016 10:44:21 -0400
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291263>

Every yes/no question in difftool/mergetool scripts has slightly
different form, and none of them is consistent with the form git
itself uses.

Make the form of all the questions consistent with the form used
by git.

Reviewed-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Nikola Forr=C3=B3 <nforro@redhat.com>
---
Changes in v2: example dropped from the commit message

 git-difftool--helper.sh | 4 ++--
 git-mergetool--lib.sh   | 2 +-
 git-mergetool.sh        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 2b11b1d..84d6cc0 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -44,10 +44,10 @@ launch_merge_tool () {
 			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
 		if use_ext_cmd
 		then
-			printf "Launch '%s' [Y/n]: " \
+			printf "Launch '%s' [Y/n]? " \
 				"$GIT_DIFFTOOL_EXTCMD"
 		else
-			printf "Launch '%s' [Y/n]: " "$merge_tool"
+			printf "Launch '%s' [Y/n]? " "$merge_tool"
 		fi
 		read ans || return
 		if test "$ans" =3D n
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 54ac8e4..92adcc0 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -100,7 +100,7 @@ check_unchanged () {
 		while true
 		do
 			echo "$MERGED seems unchanged."
-			printf "Was the merge successful? [y/n] "
+			printf "Was the merge successful [y/n]? "
 			read answer || return 1
 			case "$answer" in
 			y*|Y*) return 0 ;;
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9f77e3a..2e0635a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -396,7 +396,7 @@ done
 prompt_after_failed_merge () {
 	while true
 	do
-		printf "Continue merging other unresolved paths (y/n) ? "
+		printf "Continue merging other unresolved paths [y/n]? "
 		read ans || return 1
 		case "$ans" in
 		[yY]*)
--=20
2.4.11
