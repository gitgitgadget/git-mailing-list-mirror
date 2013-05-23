From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2] Document push --no-verify
Date: Thu, 23 May 2013 15:34:11 +0200
Message-ID: <ba24ea6f9fedc05690ee93a805d4f468650a942c.1369315855.git.trast@inf.ethz.ch>
References: <87vc6arcf4.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Aaron Schrab <aaron@schrab.com>, <git@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 15:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfVex-0004sy-LS
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 15:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759084Ab3EWNeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 09:34:17 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:36904 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759076Ab3EWNeO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 09:34:14 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 23 May
 2013 15:34:09 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 23 May
 2013 15:34:12 +0200
X-Mailer: git-send-email 1.8.3.rc3.486.gfe16094
In-Reply-To: <87vc6arcf4.fsf@linux-k42r.v.cablecom.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225245>

ec55559 (push: Add support for pre-push hooks, 2013-01-13) forgot to
add a note to git-push(1) about the new --no-verify option.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Junio replied privately that it should also mention the --verify
possibility.

So why not.  But this needs to be fixed across the board eventually;
0f1930c (parse-options: allow positivation of options starting, with
no-, 2012-02-25) did not update any docs, so none of the other --no-
options mention their positive forms.


 Documentation/git-push.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index d514813..df5be26 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
-	   [<repository> [<refspec>...]]
+	   [--no-verify] [<repository> [<refspec>...]]
 
 DESCRIPTION
 -----------
@@ -195,6 +195,11 @@ useful if you write an alias or script around 'git push'.
 	be pushed. If on-demand was not able to push all necessary
 	revisions it will also be aborted and exit with non-zero status.
 
+--[no-]verify::
+	Toggle the pre-push hook (see linkgit:githooks[5]).  The
+	default is \--verify, giving the hook a chance to prevent the
+	push.  With \--no-verify, the hook is bypassed completely.
+
 
 include::urls-remotes.txt[]
 
-- 
1.8.3.rc3.486.gfe16094
