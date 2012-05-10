From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] document submdule.$name.update=none option for gitmodules
Date: Thu, 10 May 2012 20:59:04 +0200
Message-ID: <20120510185903.GF76400@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 20:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYa0-0006al-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab2EJS7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 14:59:08 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40152 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754355Ab2EJS7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 14:59:06 -0400
Received: (qmail 23349 invoked from network); 10 May 2012 18:59:04 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 10 May 2012 18:59:04 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197615>

This option was not yet described in the gitmodules documentation. We
only described it in the 'git submodule' command documentation but
gitmodules is the more natural place to look.

A short reference in the 'git submodule' documentation should be
sufficient since the details can now be found in the documentation to
gitmodules.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-submodule.txt |    7 ++-----
 Documentation/gitmodules.txt    |    5 ++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index c243ee5..c83a856 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -140,7 +140,8 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`.
+	`rebase`, `merge` or `none`. `none` can be overriden by specifying
+	`--checkout`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -148,10 +149,6 @@ submodule with the `--init` option.
 +
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
-+
-If the configuration key `submodule.$name.update` is set to `none` the
-submodule with name `$name` will not be updated by default. This can be
-overriden by adding `--checkout` to the command.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 4e1fd52..4effd78 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -41,8 +41,11 @@ submodule.<name>.update::
 	the commit specified in the superproject. If 'merge', the commit
 	specified in the superproject will be merged into the current branch
 	in the submodule.
+	If 'none', the submodule with name `$name` will not be updated
+	by default.
+
 	This config option is overridden if 'git submodule update' is given
-	the '--merge' or '--rebase' options.
+	the '--merge', '--rebase' or '--checkout' options.
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
-- 
1.7.10.rc2.31.gd8c60
