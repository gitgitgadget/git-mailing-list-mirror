From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] git-svn: add some in-code documentation (options-related).
Date: Mon, 22 Jun 2009 00:48:40 +0200
Message-ID: <1245624521-30769-2-git-send-email-ydirson@altern.org>
References: <1245624521-30769-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 00:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIVqU-0005jy-Jj
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 00:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbZFUWsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbZFUWsv
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 18:48:51 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58808 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbZFUWsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 18:48:50 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C6CCB9400E1;
	Mon, 22 Jun 2009 00:48:47 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E16F99400E9;
	Mon, 22 Jun 2009 00:48:44 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 99DCE1F0D4; Mon, 22 Jun 2009 00:49:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1245624521-30769-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121998>


Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 git-svn.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3301797..e2d5eff 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -71,6 +71,13 @@ my ($_stdin, $_help, $_edit,
 	$_git_format, $_commit_url, $_tag);
 $Git::SVN::_follow_parent = 1;
 $_q ||= 0;
+
+# Option structures here are used to define both command-line options
+# and git-config keys.  They are handled by read-repo-config().
+# Options in mixed case and with only a long form are only for the
+# config file.  All options available from command-line are available
+# as config-file options too, but without any dash in their names.
+
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
@@ -184,6 +191,7 @@ my %cmd = (
 			  'show-commit' => \$Git::SVN::Log::show_commit,
 			  'non-recursive' => \$Git::SVN::Log::non_recursive,
 			  'authors-file|A=s' => \$_authors,
+			  # FIXME: lacks authors-prog ?
 			  'color' => \$Git::SVN::Log::color,
 			  'pager=s' => \$Git::SVN::Log::pager
 			} ],
-- 
1.6.3.1
