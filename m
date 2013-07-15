From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/5] diff: allow --no-patch as synonym for -s
Date: Mon, 15 Jul 2013 19:05:10 +0200
Message-ID: <1373907914-8020-2-git-send-email-Matthieu.Moy@imag.fr>
References: <7vppujbwuh.fsf@alter.siamese.dyndns.org>
 <1373907914-8020-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: stefanbeller@googlemail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 19:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UymM3-0007vs-VO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab3GORO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:14:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44617 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab3GORO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:14:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6FH5HPt032580
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 19:05:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UymD9-0003g0-DW; Mon, 15 Jul 2013 19:05:19 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UymD9-00026Y-1s; Mon, 15 Jul 2013 19:05:19 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373907914-8020-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jul 2013 19:05:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FH5HPt032580
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374512720.04767@nJYo3whswlWvVAHFAR4XUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230495>

This follows the usual convention of having a --no-foo option to negate
--foo.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/rev-list-options.txt | 1 +
 diff.c                             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index e157ec3..c128a85 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -851,5 +851,6 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	Show the tree objects in the diff output. This implies '-r'.
 
 -s::
+--no-patch::
 	Suppress diff output.
 endif::git-rev-list[]
diff --git a/diff.c b/diff.c
index 6578690..6bd821d 100644
--- a/diff.c
+++ b/diff.c
@@ -3551,7 +3551,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-s"))
+	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (!prefixcmp(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
-- 
1.8.3.1.495.g13f33cf.dirty
