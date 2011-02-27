From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2 v2] mergetool--lib: Add Beyond Compare 3 as a tool
Date: Sun, 27 Feb 2011 12:32:46 +0100
Message-ID: <4D6A365E.4030904@gmail.com>
References: <4D6A355C.3000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>, charles@hashpling.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Feb 27 12:33:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptes3-0008K3-1G
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 12:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1B0Lc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 06:32:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62567 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab1B0Lc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 06:32:58 -0500
Received: by fxm17 with SMTP id 17so2956948fxm.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 03:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BPf5Fu/bDe6ZpOQbC1UaXi55ayINBqnVvxheiRTkdVA=;
        b=TyaakV6eGwukPnzmA1TNboUT2biZmJrSmHKGycz82U1Vm1NjqMeMoigRhvHl54n8jS
         ioamQB0XjIjXvIvceMKSm71hcN/A8avZTaUJjK0u23E1pfQwbgX9Vjqdbmd6UrbzHFnI
         gB9E4mmfMMPN4Z6gg6nOYLWRqOuQgJZ1PCCjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aX2Azjs+6e2O3g6ofVRwShZZEtPJGhCrCTmpyOmDp+frrV0MQpZoP8GT3X8z3mH9ZX
         0hlCgGxTC8Q1u0COCYOXMhBzcN3geNmrl47yenyLfqi898S/KXoQtKKBdnm5P0B/SJZA
         O+KZnHnSncLrYuV5pKxzYlbnBp7E7YTAVtl6s=
Received: by 10.223.81.76 with SMTP id w12mr5126971fak.26.1298806376893;
        Sun, 27 Feb 2011 03:32:56 -0800 (PST)
Received: from [192.168.178.23] (p5DDB0164.dip0.t-ipconnect.de [93.219.1.100])
        by mx.google.com with ESMTPS id n1sm1058334fam.16.2011.02.27.03.32.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 03:32:56 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D6A355C.3000805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168028>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-difftool.txt         |    2 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 git-gui/lib/mergetool.tcl              |    7 +++++++
 git-mergetool--lib.sh                  |   22 ++++++++++++++++++++--
 6 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 4c8825d..f087eff 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
-	araxis, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
+	araxis, bc3, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
 	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
 +
 If a diff tool is not specified, 'git difftool'
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 4987245..740b3f1 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,7 +26,7 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	araxis, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
+	araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
 	meld, opendiff, p4merge, tkdiff, tortoisemerge, vimdiff and xxdiff.
 +
 If a merge resolution program is not specified, 'git mergetool'
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 90587db..33bf74c 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -34,7 +34,7 @@ merge.stat::
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
-	"diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
+	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
 	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
 	and "xxdiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 893b771..058c2a9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1358,7 +1358,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3
 "
 
 _git_difftool ()
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index 249e0cf..3c8e73b 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -187,6 +187,13 @@ proc merge_resolve_tool2 {} {
 				 "$LOCAL" "$REMOTE" "$MERGED"]
 		}
 	}
+	bc3 {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -mergeoutput="$MERGED"]
+		} else {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -mergeoutput="$MERGED"]
+		}
+	}
 	ecmerge {
 		if {$base_stage ne {}} {
 			set cmdline [list "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"]
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9fb82e5..bfb3913 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -13,6 +13,9 @@ translate_merge_tool_path () {
 	araxis)
 		echo compare
 		;;
+	bc3)
+		echo bcompare
+		;;
 	emerge)
 		echo emacs
 		;;
@@ -46,7 +49,7 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	araxis | diffuse | ecmerge | emerge | gvimdiff | gvimdiff2 | \
+	araxis | bc3 | diffuse | ecmerge | emerge | gvimdiff | gvimdiff2 | \
 	kdiff3 | meld | opendiff | p4merge | tkdiff | vimdiff | vimdiff2 | xxdiff)
 		;; # happy
 	kompare)
@@ -106,6 +109,21 @@ run_merge_tool () {
 				>/dev/null 2>&1
 		fi
 		;;
+	bc3)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
+					-mergeoutput="$MERGED"
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					-mergeoutput="$MERGED"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
+		fi
+		;;
 	diffuse)
 		if merge_mode; then
 			touch "$BACKUP"
@@ -342,7 +360,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
-- 
1.7.3.2.msysgit.6.dirty
