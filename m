From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 38/38] i18n: branch: mark comment when editing branch description for translation
Date: Tue,  7 Jun 2016 12:55:41 +0000
Message-ID: <1465304141-9392-9-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 14:56:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGYS-0007HI-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 14:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbcFGM4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 08:56:19 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:45691 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754954AbcFGM4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 08:56:18 -0400
Received: (qmail 17064 invoked from network); 7 Jun 2016 12:56:16 -0000
Received: (qmail 18658 invoked from network); 7 Jun 2016 12:56:15 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 12:56:13 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296674>

When one issues git branch --edit-description branch_name, a edit with
that message commented out is opened. Mark that message for translation
in to order to be localized.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ecde53..12203fd 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -614,9 +614,9 @@ static int edit_branch_description(const char *branch_name)
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
 	strbuf_commented_addf(&buf,
-		    "Please edit the description for the branch\n"
-		    "  %s\n"
-		    "Lines starting with '%c' will be stripped.\n",
+		    _("Please edit the description for the branch\n"
+		      "  %s\n"
+		      "Lines starting with '%c' will be stripped.\n"),
 		    branch_name, comment_line_char);
 	if (write_file_gently(git_path(edit_description), "%s", buf.buf)) {
 		strbuf_release(&buf);
-- 
2.7.3
