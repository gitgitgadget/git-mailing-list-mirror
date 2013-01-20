From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Sun, 20 Jan 2013 12:27:41 +0100
Message-ID: <50FBD4AD.2060208@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, davvid@gmail.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 12:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twt4A-0002I1-Fk
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 12:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab3ATL1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 06:27:37 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:59415 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751547Ab3ATL1g (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2013 06:27:36 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id A92FE42E349;
	Sun, 20 Jan 2013 12:27:33 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 7EEA9422067;
	Sun, 20 Jan 2013 12:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; s=dkim1; bh=lpmHnBWkTd6F7h/un8+0xRui
	+OY=; b=zQfLrvwW0fDT8jxAOCV3Vb6WGkNgTP24IjVgO7OQ5+ymS8lS7Y2rB0EX
	VPsAKXTjUfjiGcTxsuIHwBPXTqaNoT9Z+3UT0jt3OK8gyIVfEGTeUUc1yhTmgxbb
	4Dih2FUB0CpjcBtHtLirhOnt1jdnU5rrLGysQOXeRg//PKpcuy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=Y+eMZY1BHVaiuTggTW
	61qzsugcPTUyx334KbFY8vNPTiXmHJxjg31kC1JeJd1u4bKtS6J57G4uOT5tLIN7
	J9NN9/ZW5dZ7e22yRoWtuNYvjO1lnK3J1ex3wuQHHbSVnXf1xG1v6/ihJxVtCYHz
	ZZo5RKcIHfMfpwhRLtI9qQjKI=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 04432422053;
	Sun, 20 Jan 2013 12:27:33 +0100 (CET)
Received: from [91.3.175.233] (account sstri@tu-clausthal.de HELO [192.168.0.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43106859; Sun, 20 Jan 2013 12:27:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 __FRAUD_WEBMAIL! 0, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODY_SIZE_4000_4999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214006>

- The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
  (starting with 1.8.0) in order to make clear that this one has special
  support for git and prevent confusion with the TortoiseSVN TortoiseMerge
  version.
- The tortoisemerge mergetool does not work with filenames which have
  a space in it. Fixing this required changes in git and also in
  TortoiseGitMerge; see https://github.com/msysgit/msysgit/issues/57.

The new tortoisegitmerge helper was added so that people can still use
TortoiseMerge from TortoiseSVN (and older TortoiseGit versions).

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/diff-config.txt          |  4 ++--
 Documentation/git-mergetool.txt        |  4 ++--
 Documentation/merge-config.txt         |  6 +++---
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  |  2 +-
 mergetools/tortoisegitmerge            | 17 +++++++++++++++++
 6 files changed, 26 insertions(+), 9 deletions(-)
 create mode 100644 mergetools/tortoisegitmerge

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 4314ad0..13cbe5b 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -151,7 +151,7 @@ diff.<driver>.cachetextconv::
 diff.tool::
 	The diff tool to be used by linkgit:git-difftool[1].  This
 	option overrides `merge.tool`, and has the same valid built-in
-	values as `merge.tool` minus "tortoisemerge" and plus
-	"kompare".  Any other value is treated as a custom diff tool,
+	values as `merge.tool` minus "tortoisemerge"/"tortoisegitmerge" and
+	plus "kompare".  Any other value is treated as a custom diff tool,
 	and there must be a corresponding `difftool.<tool>.cmd`
 	option.
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 6b563c5..a80cccd 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -28,8 +28,8 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid values include emerge, gvimdiff, kdiff3,
-	meld, vimdiff, and tortoisemerge. Run `git mergetool --tool-help`
-	for the list of valid <tool> settings.
+	meld, vimdiff, tortoisegitmerge, and tortoisemerge. Run
+	`git mergetool --tool-help` for the list of valid <tool> settings.
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 9bb4956..a047646 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -55,9 +55,9 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
 	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
-	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
-	and "xxdiff".  Any other value is treated is custom merge tool
-	and there must be a corresponding mergetool.<tool>.cmd option.
+	"opendiff", "p4merge", "tkdiff", "tortoisegitmerge", "tortoisemerge",
+	"vimdiff" and "xxdiff".  Any other value is treated is custom merge
+	tool and there must be a corresponding mergetool.<tool>.cmd option.
  merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 90f5f05..5332a33 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1345,7 +1345,7 @@ _git_mergetool ()
 {
 	case "$cur" in
 	--tool=*)
-		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
+		__gitcomp "$__git_mergetools_common tortoisegitmerge tortoisemerge" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f013a03..47183ef 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -150,7 +150,7 @@ run_merge_cmd () {
 list_merge_tool_candidates () {
 	if merge_mode
 	then
-		tools="tortoisemerge"
+		tools="tortoisegitmerge tortoisemerge"
 	else
 		tools="kompare"
 	fi
diff --git a/mergetools/tortoisegitmerge b/mergetools/tortoisegitmerge
new file mode 100644
index 0000000..5b802a7
--- /dev/null
+++ b/mergetools/tortoisegitmerge
@@ -0,0 +1,17 @@
+can_diff () {
+	return 1
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		touch "$BACKUP"
+		"$merge_tool_path" \
+			-base "$BASE" -mine "$LOCAL" \
+			-theirs "$REMOTE" -merged "$MERGED"
+		check_unchanged
+	else
+		echo "TortoiseGitMerge cannot be used without a base" 1>&2
+		return 1
+	fi
+}
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
