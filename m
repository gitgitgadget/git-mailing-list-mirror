From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 09/14] difftool: move 'git-difftool' out of contrib
Date: Mon,  6 Apr 2009 01:31:24 -0700
Message-ID: <1239006689-14695-10-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
 <1239006689-14695-6-git-send-email-davvid@gmail.com>
 <1239006689-14695-7-git-send-email-davvid@gmail.com>
 <1239006689-14695-8-git-send-email-davvid@gmail.com>
 <1239006689-14695-9-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkII-0002l9-Fy
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbZDFIcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZDFIcH
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:32:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:11551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbZDFIcD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:32:03 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2100137rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XZNlxAKpnNqkw07ua/aqB/f6aMkDM/koKkDHLIhHu6Q=;
        b=H7MwAbBxInwx0JqLWCNWNx/dDxs87FCmR2tj3oA6YQF9b0GibWBsBp3TXIFwokHYYu
         pmS2zuz2G93tbFnqgU4ZfMu5IWan1vKdKPfh5KvpSzh2Og1i1J9tmtp51loiaJNdldaD
         joKgmwZOSe/CVSXilGp6LMqKna/kZuvoabs0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TIVeoQrv1mRfFbvKrWOn8PmZOkN2cD+hGW5fzyiUWCxSzG9oC+S7Cz3tYNflFpcAqw
         oV3U/cQ2aB+6AkAOcCs3mIRP6ynokCVG7vdSGecUYoL+l/QgY0zeOnSdXDbe5/Gy6yYf
         3ETLa1flc50AKYMGmOgm6JS4CNwKhy1quM1f0=
Received: by 10.115.58.18 with SMTP id l18mr2160137wak.31.1239006721131;
        Mon, 06 Apr 2009 01:32:01 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v32sm5211503wah.17.2009.04.06.01.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:32:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-9-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115790>

This prepares 'git-difftool' and its documentation for
mainstream use.

'git-difftool-helper' became 'git-difftool--helper'
since users should not use it directly.

'git-difftool' was added to the list of commands as
an ancillaryinterrogator.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 .gitignore                                         |    2 ++
 Documentation/config.txt                           |   17 +++++++++++++++++
 .../difftool => Documentation}/git-difftool.txt    |    0
 Makefile                                           |    2 ++
 command-list.txt                                   |    1 +
 .../git-difftool-helper => git-difftool--helper.sh |    2 +-
 contrib/difftool/git-difftool => git-difftool.perl |    6 +++---
 7 files changed, 26 insertions(+), 4 deletions(-)
 rename {contrib/difftool => Documentation}/git-difftool.txt (100%)
 rename contrib/difftool/git-difftool-helper => git-difftool--helper.sh (98%)
 rename contrib/difftool/git-difftool => git-difftool.perl (92%)

diff --git a/.gitignore b/.gitignore
index 1c57d4c..a36da9d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,6 +35,8 @@ git-diff
 git-diff-files
 git-diff-index
 git-diff-tree
+git-difftool
+git-difftool--helper
 git-describe
 git-fast-export
 git-fast-import
diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad22cb8..185a9ef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -667,6 +667,23 @@ diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
+diff.tool::
+	Controls which diff tool is used.  `diff.tool` overrides
+	`merge.tool` when used by linkgit:git-difftool[1] and has
+	the same valid values as `merge.tool`.
+
+difftool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+difftool.<tool>.cmd::
+	Specify the command to invoke the specified diff tool.
+	The specified command is evaluated in shell with the following
+	variables available:  'LOCAL' is set to the name of the temporary
+	file containing the contents of the diff pre-image and 'REMOTE'
+	is set to the name of the temporary file containing the contents
+	of the diff post-image.
+
 diff.wordRegex::
 	A POSIX Extended Regular Expression used to determine what is a "word"
 	when performing word-by-word difference calculations.  Character
diff --git a/contrib/difftool/git-difftool.txt b/Documentation/git-difftool.txt
similarity index 100%
rename from contrib/difftool/git-difftool.txt
rename to Documentation/git-difftool.txt
diff --git a/Makefile b/Makefile
index 7867eac..a80055f 100644
--- a/Makefile
+++ b/Makefile
@@ -277,6 +277,7 @@ TEST_PROGRAMS =
 
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
+SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -296,6 +297,7 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_PERL += git-add--interactive.perl
+SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
diff --git a/command-list.txt b/command-list.txt
index 3583a33..fb03a2e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -33,6 +33,7 @@ git-diff                                mainporcelain common
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
+git-difftool                            ancillaryinterrogators
 git-fast-export				ancillarymanipulators
 git-fast-import				ancillarymanipulators
 git-fetch                               mainporcelain common
diff --git a/contrib/difftool/git-difftool-helper b/git-difftool--helper.sh
similarity index 98%
rename from contrib/difftool/git-difftool-helper
rename to git-difftool--helper.sh
index 4b0daec..fc61416 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/git-difftool--helper.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
+# git-difftool--helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
 # This script is typically launched by using the 'git difftool'
 # convenience command.
 #
diff --git a/contrib/difftool/git-difftool b/git-difftool.perl
similarity index 92%
rename from contrib/difftool/git-difftool
rename to git-difftool.perl
index 8c160e5..8857ac8 100755
--- a/contrib/difftool/git-difftool
+++ b/git-difftool.perl
@@ -2,9 +2,9 @@
 # Copyright (c) 2009 David Aguilar
 #
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
-# git-difftool-helper script.  This script exports
+# git-difftool--helper script.  This script exports
 # GIT_EXTERNAL_DIFF and GIT_PAGER for use by git, and
-# GIT_DIFFTOOL_NO_PROMPT and GIT_DIFF_TOOL for use by git-difftool-helper.
+# GIT_DIFFTOOL_NO_PROMPT and GIT_DIFF_TOOL for use by git-difftool--helper.
 # Any arguments that are unknown to this script are forwarded to 'git diff'.
 
 use strict;
@@ -27,7 +27,7 @@ sub setup_environment
 {
 	$ENV{PATH} = "$DIR:$ENV{PATH}";
 	$ENV{GIT_PAGER} = '';
-	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool-helper';
+	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
 }
 
 sub exe
-- 
1.6.2.2.414.g81aa9
