From: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv5 2/4] Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
Date: Sun,  3 Jun 2012 22:14:39 +0200
Message-ID: <1338754481-27012-2-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
References: <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>,
	Franck JONAS <Franck.JONAS@ensimag.imag.fr>,
	Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>,
	Lucien KONG <Lucien.KONG@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 22:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbHCS-000498-Ra
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 22:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab2FCUOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 16:14:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53425 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab2FCUOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 16:14:46 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q53K6CZJ000956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 22:06:12 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q53KEgHk014096;
	Sun, 3 Jun 2012 22:14:42 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q53KEgVH027484;
	Sun, 3 Jun 2012 22:14:42 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q53KEgvV027483;
	Sun, 3 Jun 2012 22:14:42 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 03 Jun 2012 22:06:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53K6CZJ000956
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339358774.2998@6vvKH8PAOuQQJpKsQ6GlDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199097>

From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>

If core.excludesfile is not defined, its default value will be
$XDG_CONFIG_HOME/git/ignore in order to follow XDG specification. If
$XDG_CONFIG_HOME is either not set or emty, $HOME/.config will be
used.

Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>
Signed-off-by: Franck JONAS <Franck.JONAS@ensimag.imag.fr>
Signed-off-by: Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>
Signed-off-by: Lucien KONG <Lucien.KONG@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/config.txt    |    4 +++-
 Documentation/gitignore.txt |    4 +++-
 dir.c                       |    7 ++++++-
 t/t1306-xdg-files.sh        |   23 +++++++++++++++++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..bfaef2c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -483,7 +483,9 @@ core.excludesfile::
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.  "`~/`" is expanded
 	to the value of `$HOME` and "`~user/`" to the specified user's
-	home directory.  See linkgit:gitignore[5].
+	home directory. Its default value is $XDG_CONFIG_HOME/git/ignore.
+	If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config will
+	be used. See linkgit:gitignore[5].
 
 core.askpass::
 	Some commands (e.g. svn and http interfaces) that interactively
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b..05ee33f 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -50,7 +50,9 @@ the repository but are specific to one user's workflow) should go into
 the `$GIT_DIR/info/exclude` file.  Patterns which a user wants git to
 ignore in all situations (e.g., backup or temporary files generated by
 the user's editor of choice) generally go into a file specified by
-`core.excludesfile` in the user's `~/.gitconfig`.
+`core.excludesfile` in the user's `~/.gitconfig`. Its default value is
+$XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is either not set or empty,
+$HOME/.config will be used.
 
 The underlying git plumbing tools, such as
 'git ls-files' and 'git read-tree', read
diff --git a/dir.c b/dir.c
index ed1510f..8c6f47f 100644
--- a/dir.c
+++ b/dir.c
@@ -1234,12 +1234,17 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
+	char *xdg_path;
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
+	if (!excludes_file) {
+		home_config_paths(NULL, &xdg_path, "ignore");
+		excludes_file = xdg_path;
+	}
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
-	if (excludes_file && !access(excludes_file, R_OK))
+	if (!access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
 
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 77823fc..1a1f07e 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -61,4 +61,27 @@ test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists'
 	test_cmp expected actual
 '
 
+test_expect_success 'Exclusion of a file in the XDG ignore file' '
+	git init git &&
+	cd git &&
+	echo foo >to_be_excluded &&
+	mkdir -p "$HOME"/.config/git/ &&
+	echo to_be_excluded >"$HOME"/.config/git/ignore &&
+	test_must_fail git add to_be_excluded
+'
+
+test_expect_success 'Exclusion in both XDG and local ignore files' '
+	echo to_be_excluded >.gitignore &&
+	test_must_fail git add to_be_excluded
+'
+
+test_expect_success 'Exclusion in a non-XDG global ignore file' '
+	echo >"$HOME"/.config/git/ignore &&
+	rm .gitignore &&
+	echo to_be_excluded >"$HOME"/my_gitignore &&
+	git config core.excludesfile "$HOME"/my_gitignore &&
+	test_when_finished "cd \"$HOME\" && rm -rf git && rm -r .config" &&
+	test_must_fail git add to_be_excluded
+'
+
 test_done
-- 
1.7.8
