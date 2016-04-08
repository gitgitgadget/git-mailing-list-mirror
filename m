From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 1/7] l10n: index-pack: use plural string instead of normal one
Date: Fri,  8 Apr 2016 20:02:39 +0000
Message-ID: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 22:09:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aociz-0002g5-1W
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466AbcDHUJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:09:43 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:43908 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753090AbcDHUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:09:42 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Apr 2016 16:09:42 EDT
Received: (qmail 3330 invoked from network); 8 Apr 2016 20:03:00 -0000
Received: (qmail 15300 invoked from network); 8 Apr 2016 20:03:00 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Apr 2016 20:02:55 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291059>

Git could output "completed with 1 local objects", but in this case
using "object" instead of "objects" is the correct form.
Use Q_() instead of _().

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/index-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2d1eb8b..e8c71fc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1250,7 +1250,9 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		       nr_unresolved * sizeof(*objects));
 		f = sha1fd(output_fd, curr_pack);
 		fix_unresolved_deltas(f);
-		strbuf_addf(&msg, _("completed with %d local objects"),
+		strbuf_addf(&msg, Q_("completed with %d local object",
+				     "completed with %d local objects",
+				     nr_objects - nr_objects_initial),
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-- 
2.1.4
