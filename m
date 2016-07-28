Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27B41F859
	for <e@80x24.org>; Thu, 28 Jul 2016 11:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106AbcG1L1E (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 07:27:04 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:33407 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757055AbcG1L1C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 07:27:02 -0400
Received: (qmail 16115 invoked from network); 28 Jul 2016 11:26:59 -0000
Received: (qmail 18644 invoked from network); 28 Jul 2016 11:26:59 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 28 Jul 2016 11:26:54 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] i18n: notes: mark comment for translation
Date:	Thu, 28 Jul 2016 11:26:15 +0000
Message-Id: <1469705175-7503-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
In-Reply-To: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark comment displayed when editing a note for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---

This patch follows the original output and Ævar Arnfjörð Bjarmason
sugestion to remove \n from the source string in order to assure that the
ouput layout is not change by one translator forgetting to add \n, for
instance.

 builtin/notes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 0572051..f848b89 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -91,7 +91,7 @@ static const char * const git_notes_get_ref_usage[] = {
 };
 
 static const char note_template[] =
-	"\nWrite/edit the notes for the following object:\n";
+	N_("Write/edit the notes for the following object:");
 
 struct note_data {
 	int given;
@@ -179,7 +179,8 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
 			copy_obj_to_fd(fd, old_note);
 
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
+		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
 		strbuf_addch(&buf, '\n');
 		write_or_die(fd, buf.buf, buf.len);
 
-- 
2.7.4

