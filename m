From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git am documentation
Date: Tue,  2 Jun 2015 19:34:04 +0200
Message-ID: <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 19:34:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzq59-0006eG-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759891AbbFBReZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:34:25 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:50307 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759884AbbFBReT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 13:34:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C755327BC;
	Tue,  2 Jun 2015 19:34:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QVOf3lGiXbEK; Tue,  2 Jun 2015 19:34:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B752F27A4;
	Tue,  2 Jun 2015 19:34:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B1E9B20E4;
	Tue,  2 Jun 2015 19:34:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j8Yeqg1tdTJ9; Tue,  2 Jun 2015 19:34:16 +0200 (CEST)
Received: from Groseille.grenet.fr (wificampus-030200.grenet.fr [130.190.30.200])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C61CC20DD;
	Tue,  2 Jun 2015 19:34:15 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270569>

Prepare a configuration section for the git am documentation.
Remove the part related to the am.keepcr configuration variable in the
description of the --keepcr option and place the description of the
am.keepcr configuration variable in the newly created configuration
section.

This section will be used in the next commit.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 Documentation/git-am.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0d8ba48..d412f6b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -24,6 +24,16 @@ Splits mail messages in a mailbox into commit log message,
 authorship information and patches, and applies them to the
 current branch.
 
+CONFIGURATION
+-------------
+
+am.keepcr::
+	If true, git-am will call git-mailsplit for patches in mbox format
+	with parameter '--keep-cr'. In this case git-mailsplit will
+	not remove `\r` from lines ending with `\r\n`. Can be overridden
+	by giving '--no-keep-cr' from the command line.
+	See linkgit:git-am[1], linkgit:git-mailsplit[1].
+
 OPTIONS
 -------
 (<mbox>|<Maildir>)...::
@@ -43,11 +53,11 @@ OPTIONS
 --keep-non-patch::
 	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
---[no-]keep-cr::
+--keep-cr::
+--no-keep-cr::
 	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
 	with the same option, to prevent it from stripping CR at the end of
-	lines. `am.keepcr` configuration variable can be used to specify the
-	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
+	lines.
 
 -c::
 --scissors::
-- 
1.9.1
