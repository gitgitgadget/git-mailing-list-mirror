From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 5/7] i18n: builtin/pull.c: split strings marked for translation
Date: Tue, 19 Apr 2016 13:19:22 +0000
Message-ID: <1461071964-323-5-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:20:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVaB-0003ai-7A
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbcDSNUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 09:20:34 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:42632 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932074AbcDSNUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:20:31 -0400
Received: (qmail 13119 invoked from network); 19 Apr 2016 13:20:28 -0000
Received: (qmail 14561 invoked from network); 19 Apr 2016 13:20:28 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[147.203.126.136])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 19 Apr 2016 13:20:22 -0000
X-PTMail-RemoteIP: 147.203.126.136
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291856>

Split string "If you wish to set tracking information
for this branch you can do so with:\n" to match occurring string in
git-parse-remote.sh. In this case, the translator handles it only once.

On the other hand, the translations of the string that were already made
are mark as fuzzy and the translator needs to correct it herself.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/pull.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index c199f28..2ec5a9b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -491,10 +491,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch>"));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
-				"\n"
-				"    git branch --set-upstream-to=%s/<branch> %s\n"),
-				remote_name, curr_branch->name);
+		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:"));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, "    git branch --set-upstream-to=%s/%s %s\n",
+				remote_name, _("<branch>"), curr_branch->name);
 	} else
 		fprintf_ln(stderr, _("Your configuration specifies to merge with the ref '%s'\n"
 			"from the remote, but no such ref was fetched."),
-- 
2.1.4
