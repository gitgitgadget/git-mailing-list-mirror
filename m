Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7684F20179
	for <e@80x24.org>; Fri, 17 Jun 2016 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbcFQVym (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:54:42 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:38381 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755655AbcFQVyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:54:41 -0400
Received: (qmail 1393 invoked from network); 17 Jun 2016 21:54:39 -0000
Received: (qmail 30790 invoked from network); 17 Jun 2016 21:54:39 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 21:54:39 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 38/38] i18n: branch: mark comment when editing branch description for translation
Date:	Fri, 17 Jun 2016 21:54:15 +0000
Message-Id: <1466200455-16951-9-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

