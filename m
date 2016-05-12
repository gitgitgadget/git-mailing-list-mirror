From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 5/7] i18n: builtin/pull.c: split strings marked for translation
Date: Thu, 12 May 2016 19:59:26 +0000
Message-ID: <1463083168-29213-6-git-send-email-vascomalmeida@sapo.pt>
References: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wmj-0006J5-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbcELUAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:00:34 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:53183 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751093AbcELUAe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:00:34 -0400
Received: (qmail 31956 invoked from network); 12 May 2016 20:00:31 -0000
Received: (qmail 32033 invoked from network); 12 May 2016 20:00:31 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 May 2016 20:00:26 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294445>

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
index 96b98ea..1d7333c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -495,10 +495,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
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
2.7.3
