From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] Documentation/config.txt: change "pull.rebase" description in
 favor of safer 'preserve' option.
Date: Tue, 5 Aug 2014 14:58:29 +0400
Message-ID: <87bnrzxhrm.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 14:06:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEdVw-000464-D9
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 14:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbaHEMGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 08:06:42 -0400
Received: from mail.javad.com ([54.86.164.124]:42580 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbaHEMGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 08:06:41 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 0AADA60BF3;
	Tue,  5 Aug 2014 12:06:39 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XEdVl-00086F-9y; Tue, 05 Aug 2014 16:06:37 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254803>

Previous description implicitly favored 'true' value for "pull.rebase"
and "pull.<branch>.rebase" options, when for some workflows 'preserve'
is the right choice, and for others it hardly makes any difference.
Therefore, 'preserve' should be preferred in general, unless the user
knows exactly what she is doing.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/config.txt | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c55c22a..30f28d9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -772,14 +772,13 @@ branch.<name>.mergeoptions::
 	supported.
 
 branch.<name>.rebase::
-	When true, rebase the branch <name> on top of the fetched branch,
-	instead of merging the default branch from the default remote when
-	"git pull" is run. See "pull.rebase" for doing this in a non
-	branch-specific manner.
+	When `preserve` or `true`, rebase the branch <name> on top of the
+	fetched branch, instead of merging the default branch from the
+	default remote when 'git pull' is run. See "pull.rebase" for
+	doing this in a non branch-specific manner.
 +
-	When preserve, also pass `--preserve-merges` along to 'git rebase'
-	so that locally committed merge commits will not be flattened
-	by running 'git pull'.
+	When `true`, do not pass `--preserve-merges` to 'git rebase', so
+	that local merge commits will be flattened by running 'git pull'.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
@@ -1948,14 +1947,13 @@ pull.ff::
 	command line).
 
 pull.rebase::
-	When true, rebase branches on top of the fetched branch, instead
-	of merging the default branch from the default remote when "git
-	pull" is run. See "branch.<name>.rebase" for setting this on a
-	per-branch basis.
+	When `preserve` or `true`, rebase branches on top of the
+	fetched branch, instead of merging the default branch from the
+	default remote when 'git pull' is run. See
+	"branch.<name>.rebase" for setting this on a per-branch basis.
 +
-	When preserve, also pass `--preserve-merges` along to 'git rebase'
-	so that locally committed merge commits will not be flattened
-	by running 'git pull'.
+	When `true`, do not pass `--preserve-merges` to 'git rebase', so
+	that local merge commits will be flattened by running 'git pull'.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
-- 
1.9.3
