From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] git-merge: mutually match SYNOPSIS and "usage".
Date: Tue, 7 Oct 2014 15:54:58 +0400
Message-ID: <87wq8cnla9.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 13:59:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbTQ1-0006mN-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 13:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbaJGL7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 07:59:00 -0400
Received: from mail.javad.com ([54.86.164.124]:38444 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbaJGL65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 07:58:57 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 2022B61878;
	Tue,  7 Oct 2014 11:58:56 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XbTPq-0005N1-9L; Tue, 07 Oct 2014 15:58:54 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257923>

SYNOPSIS section of the git-merge manual page had outdated explicit
list of options.

"usage" returned by 'git merge -h' didn't have "-m <msg>" that is one
of essential distinctions between obsolete invocation form and the
recent one.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-merge.txt | 6 ++----
 builtin/merge.c             | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index cf2c374..e24a1d4 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,10 +9,8 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<key-id>]]
-	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
-'git merge' <msg> HEAD <commit>...
+'git merge' [options] [-m <msg>] [<commit>...]
+'git merge' [options] <msg> HEAD <commit>...
 'git merge' --abort
 
 DESCRIPTION
diff --git a/builtin/merge.c b/builtin/merge.c
index dff043d..086502f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -40,7 +40,7 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	N_("git merge [options] [<commit>...]"),
+	N_("git merge [options] [-m <msg>] [<commit>...]"),
 	N_("git merge [options] <msg> HEAD <commit>"),
 	N_("git merge --abort"),
 	NULL
-- 
1.9.3
