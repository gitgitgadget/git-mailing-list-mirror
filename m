From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] Documentation: Add diff.<driver>.* to config
Date: Wed,  6 Apr 2011 15:27:32 +0530
Message-ID: <1302083854-2448-3-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 11:59:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7PVt-0005tN-9M
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 11:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab1DFJ67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 05:58:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44390 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1DFJ6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 05:58:51 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so1266731iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=t37hLLEUMo7Tm3Osi5SzEXAMFpW0UpKrCKOWHxsA00U=;
        b=nluBMl0oifApoFuFXHw7YXAivypxLTdiqLqgw2K+aUGE4AhEqyb8vpkt5N2nS3P9Ez
         d9+hDG6OHgBWuMXa4jpudPgz1rAsbxm3a8NYtGDe0Z0DEguwB8h8UJgGzGdf4Z6oOYtl
         FMA+qNszi3JKnsArSq7Z2ARZS5+oEnTgn1lTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J9iq4PvY6gPrQB9knWZH5jAOEnyyPbQzQODESSv4N0H4y1IpTU24Pbtja/S4LaSjDI
         xuh+XliuxO+qqVIIKnO1V3g3888un0wWa/Ulk7xpH+xEgmT4F4RKaXkoAGr7LM9P4u7Y
         2GqgSmgzy/Z3LILE4p7RhxK2xJVbh7YIu88pI=
Received: by 10.42.137.5 with SMTP id w5mr1192797ict.210.1302083931562;
        Wed, 06 Apr 2011 02:58:51 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c1sm318477ibe.51.2011.04.06.02.58.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 02:58:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170959>

Although the gitattributes page contains comprehensive information
about these configuration options, they should be included in the
config documentation for completeness.

Helped-by: Jakub Narebski <jnareb@gmail.com>
Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt      |   63 +----------------------------
 Documentation/diff-config.txt |   90 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/diff-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 654a3b8..4e13735 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -812,68 +812,7 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
-diff.autorefreshindex::
-	When using 'git diff' to compare with work tree
-	files, do not consider stat-only change as changed.
-	Instead, silently run `git update-index --refresh` to
-	update the cached stat information for paths whose
-	contents in the work tree match the contents in the
-	index.  This option defaults to true.  Note that this
-	affects only 'git diff' Porcelain, and not lower level
-	'diff' commands such as 'git diff-files'.
-
-diff.external::
-	If this config variable is set, diff generation is not
-	performed using the internal diff machinery, but using the
-	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
-	environment variable.  The command is called with parameters
-	as described under "git Diffs" in linkgit:git[1].  Note: if
-	you want to use an external diff program only on a subset of
-	your files, you	might want to use linkgit:gitattributes[5] instead.
-
-diff.mnemonicprefix::
-	If set, 'git diff' uses a prefix pair that is different from the
-	standard "a/" and "b/" depending on what is being compared.  When
-	this configuration is in effect, reverse diff output also swaps
-	the order of the prefixes:
-`git diff`;;
-	compares the (i)ndex and the (w)ork tree;
-`git diff HEAD`;;
-	 compares a (c)ommit and the (w)ork tree;
-`git diff --cached`;;
-	compares a (c)ommit and the (i)ndex;
-`git diff HEAD:file1 file2`;;
-	compares an (o)bject and a (w)ork tree entity;
-`git diff --no-index a b`;;
-	compares two non-git things (1) and (2).
-
-diff.noprefix::
-	If set, 'git diff' does not show any source or destination prefix.
-
-diff.renameLimit::
-	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git diff' option '-l'.
-
-diff.renames::
-	Tells git to detect renames.  If set to any boolean value, it
-	will enable basic rename detection.  If set to "copies" or
-	"copy", it will detect copies, as well.
-
-diff.ignoreSubmodules::
-	Sets the default value of --ignore-submodules. Note that this
-	affects only 'git diff' Porcelain, and not lower level 'diff'
-	commands such as 'git diff-files'. 'git checkout' also honors
-	this setting when reporting uncommitted changes.
-
-diff.suppressBlankEmpty::
-	A boolean to inhibit the standard behavior of printing a space
-	before each empty output line. Defaults to false.
-
-diff.tool::
-	Controls which diff tool is used.  `diff.tool` overrides
-	`merge.tool` when used by linkgit:git-difftool[1] and has
-	the same valid values as `merge.tool` minus "tortoisemerge"
-	and plus "kompare".
+include::diff-config.txt[]
 
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
new file mode 100644
index 0000000..0796d5e
--- /dev/null
+++ b/Documentation/diff-config.txt
@@ -0,0 +1,90 @@
+diff.autorefreshindex::
+	When using 'git diff' to compare with work tree
+	files, do not consider stat-only change as changed.
+	Instead, silently run `git update-index --refresh` to
+	update the cached stat information for paths whose
+	contents in the work tree match the contents in the
+	index.  This option defaults to true.  Note that this
+	affects only 'git diff' Porcelain, and not lower level
+	'diff' commands such as 'git diff-files'.
+
+diff.external::
+	If this config variable is set, diff generation is not
+	performed using the internal diff machinery, but using the
+	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
+	environment variable.  The command is called with parameters
+	as described under "git Diffs" in linkgit:git[1].  Note: if
+	you want to use an external diff program only on a subset of
+	your files, you	might want to use linkgit:gitattributes[5] instead.
+
+diff.ignoreSubmodules::
+	Sets the default value of --ignore-submodules. Note that this
+	affects only 'git diff' Porcelain, and not lower level 'diff'
+	commands such as 'git diff-files'. 'git checkout' also honors
+	this setting when reporting uncommitted changes.
+
+diff.mnemonicprefix::
+	If set, 'git diff' uses a prefix pair that is different from the
+	standard "a/" and "b/" depending on what is being compared.  When
+	this configuration is in effect, reverse diff output also swaps
+	the order of the prefixes:
+`git diff`;;
+	compares the (i)ndex and the (w)ork tree;
+`git diff HEAD`;;
+	 compares a (c)ommit and the (w)ork tree;
+`git diff --cached`;;
+	compares a (c)ommit and the (i)ndex;
+`git diff HEAD:file1 file2`;;
+	compares an (o)bject and a (w)ork tree entity;
+`git diff --no-index a b`;;
+	compares two non-git things (1) and (2).
+
+diff.noprefix::
+	If set, 'git diff' does not show any source or destination prefix.
+
+diff.renameLimit::
+	The number of files to consider when performing the copy/rename
+	detection; equivalent to the 'git diff' option '-l'.
+
+diff.renames::
+	Tells git to detect renames.  If set to any boolean value, it
+	will enable basic rename detection.  If set to "copies" or
+	"copy", it will detect copies, as well.
+
+diff.suppressBlankEmpty::
+	A boolean to inhibit the standard behavior of printing a space
+	before each empty output line. Defaults to false.
+
+diff.tool::
+	Controls which diff tool is used.  `diff.tool` overrides
+	`merge.tool` when used by linkgit:git-difftool[1] and has
+	the same valid values as `merge.tool` minus "tortoisemerge"
+	and plus "kompare".
+
+diff.<driver>.command::
+	The custom diff driver command.  See linkgit:gitattributes[5]
+	for details.
+
+diff.<driver>.xfuncname::
+	The regular expression that the custom diff driver should use
+	to recognize the hunk header.  A built-in pattern may also be
+	used.  See linkgit:gitattributes[5] for details.
+
+diff.<driver>.binary::
+	Set this option to true to make the custom diff driver treat
+	files as binary.  See linkgit:gitattributes[5] for details.
+
+diff.<driver>.textconv::
+	The command that the diff driver should call to generate the
+	text-converted version of a file.  The result of the
+	conversion is used to generate a human-readable diff.  See
+	linkgit:gitattributes[5] for details.
+
+diff.<driver>.wordregex::
+	The regular expression that the diff driver should use to
+	split words in a line.  See linkgit:gitattributes[5] for
+	details.
+
+diff.<driver>.cachetextconv::
+	Set this option to true to make the diff driver cache the text
+	conversion outputs.  See linkgit:gitattributes[5] for details.
-- 
1.7.4.rc1.7.g2cf08.dirty
