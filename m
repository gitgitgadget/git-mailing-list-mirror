From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/6] diff.c: make constant string arguments const
Date: Thu,  7 Feb 2013 20:15:25 +0000
Message-ID: <41ec7ef2fdc2a56c43abd00ef9a48fc41b765c9b.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 21:23:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Y0K-0001Kr-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759379Ab3BGUXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:23:08 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:37243 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759337Ab3BGUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:23:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id DC349161E4E1;
	Thu,  7 Feb 2013 20:15:46 +0000 (GMT)
X-Quarantine-ID: <vnOY55Zriapn>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnOY55Zriapn; Thu,  7 Feb 2013 20:15:46 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id BA6FC161E4D8;
	Thu,  7 Feb 2013 20:15:40 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215722>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index bf95235..73ae02d 100644
--- a/diff.c
+++ b/diff.c
@@ -2123,7 +2123,8 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two, char *prefix)
+static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
+				  const char *prefix)
 {
 	void *cp;
 	void *delta;
@@ -2184,7 +2185,8 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two, char
 	free(data);
 }
 
-static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two, char *prefix)
+static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two,
+			     const char *prefix)
 {
 	fprintf(file, "%sGIT binary patch\n", prefix);
 	emit_binary_diff_body(file, one, two, prefix);
-- 
1.8.1.2
