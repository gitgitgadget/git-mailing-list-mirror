From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/6] diff: write prefix to the correct file
Date: Thu,  7 Feb 2013 20:15:24 +0000
Message-ID: <c7a6fca9a3199f05281d01f9fddab18a37f28932.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 21:23:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Y0L-0001Kr-1u
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759357Ab3BGUXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:23:10 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:37267 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759362Ab3BGUXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:23:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C5D33161E4BA;
	Thu,  7 Feb 2013 20:15:39 +0000 (GMT)
X-Quarantine-ID: <33erSRCv6o1g>
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
	with ESMTP id 33erSRCv6o1g; Thu,  7 Feb 2013 20:15:39 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2B054161E4CF;
	Thu,  7 Feb 2013 20:15:33 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215723>

Write the prefix for an output line to the same file as the actual
content.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 348f71b..bf95235 100644
--- a/diff.c
+++ b/diff.c
@@ -4485,7 +4485,7 @@ void diff_flush(struct diff_options *options)
 				struct strbuf *msg = NULL;
 				msg = options->output_prefix(options,
 					options->output_prefix_data);
-				fwrite(msg->buf, msg->len, 1, stdout);
+				fwrite(msg->buf, msg->len, 1, options->file);
 			}
 			putc(options->line_termination, options->file);
 			if (options->stat_sep) {
-- 
1.8.1.2
