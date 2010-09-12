From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH 1/2] Command names should not be translated.
Date: Sun, 12 Sep 2010 21:09:55 +0100
Message-ID: <20100912202105.DA51D2FC00@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, avarab@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 12 22:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Out3J-0000tk-Vr
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0ILUVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 16:21:15 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43681 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab0ILUVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 16:21:08 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8N005RDHV6Q740@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 12 Sep 2010 22:21:06 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3EADA179910D_C8D3632B	for <git@vger.kernel.org>; Sun,
 12 Sep 2010 20:21:06 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1E49317968D8_C8D3632F	for <git@vger.kernel.org>; Sun,
 12 Sep 2010 20:21:06 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8N00JFWHV68U30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 12 Sep 2010 22:21:06 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id DA51D2FC00; Sun,
 12 Sep 2010 22:21:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156052>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
 builtin/notes.c |   12 ++++++------
 wt-status.c     |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index e33e39a..6679322 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -502,7 +502,7 @@ static int list(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_list_usage, options);
 	}
 
-	t = init_notes_check(N_("list"));
+	t = init_notes_check("list");
 	if (argc) {
 		if (get_sha1(argv[0], object))
 			die(_("Failed to resolve '%s' as a valid ref."), argv[0]);
@@ -559,7 +559,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check(N_("add"));
+	t = init_notes_check("add");
 	note = get_note(t, object);
 
 	if (note) {
@@ -635,7 +635,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check(N_("copy"));
+	t = init_notes_check("copy");
 	note = get_note(t, object);
 
 	if (note) {
@@ -751,7 +751,7 @@ static int show(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check(N_("show"));
+	t = init_notes_check("show");
 	note = get_note(t, object);
 
 	if (!note)
@@ -788,7 +788,7 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check(N_("remove"));
+	t = init_notes_check("remove");
 
 	retval = remove_note(t, object);
 	if (retval)
@@ -822,7 +822,7 @@ static int prune(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_prune_usage, options);
 	}
 
-	t = init_notes_check(N_("prune"));
+	t = init_notes_check("prune");
 
 	prune_notes(t, (verbose ? NOTES_PRUNE_VERBOSE : 0) |
 		(show_only ? NOTES_PRUNE_VERBOSE|NOTES_PRUNE_DRYRUN : 0) );
diff --git a/wt-status.c b/wt-status.c
index f6946e1..7d4719f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -663,9 +663,9 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, _("Untracked"), _("add"));
+		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, _("Ignored"), _("add -f"));
+			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
 	} else if (s->commitable)
 		fprintf(s->fp, _("# Untracked files not listed%s\n"),
 			advice_status_hints
-- 
1.7.1
