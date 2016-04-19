From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 4/7] i18n: builtin/pull.c: mark placeholders for translation
Date: Tue, 19 Apr 2016 13:19:21 +0000
Message-ID: <1461071964-323-4-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVaA-0003ai-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbcDSNUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 09:20:25 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:40701 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932074AbcDSNUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:20:22 -0400
Received: (qmail 18007 invoked from network); 19 Apr 2016 13:20:20 -0000
Received: (qmail 12879 invoked from network); 19 Apr 2016 13:20:20 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[147.203.126.136])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 19 Apr 2016 13:20:17 -0000
X-PTMail-RemoteIP: 147.203.126.136
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291855>

Some translations might also translate "<remote>" and "<branch>".

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
I opted to mark also the brackets of placeholders, which I think is a good
compromise between consistency and letting the translators know what
they're translating.

 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d98f481..c199f28 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -474,13 +474,13 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch>"));
 		fprintf(stderr, "\n");
 	} else if (!curr_branch->merge_nr) {
 		const char *remote_name = NULL;
 
 		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
-			remote_name = "<remote>";
+			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
 		if (opt_rebase)
@@ -489,7 +489,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch>"));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
 				"\n"
-- 
2.1.4
