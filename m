From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/5] Documentation: move description of -s, --no-patch to diff-options.txt
Date: Mon, 15 Jul 2013 15:07:18 +0200
Message-ID: <1373893639-13413-5-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
 <1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: stefanbeller@googlemail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 15:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyiZY-0006i8-Je
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 15:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab3GONL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 09:11:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40299 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670Ab3GONL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 09:11:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6FD7rst019959
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 15:07:53 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UyiVP-0000YN-8e; Mon, 15 Jul 2013 15:07:55 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UyiVO-0003XO-TQ; Mon, 15 Jul 2013 15:07:54 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 15:07:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FD7rst019959
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374498476.47146@FlgsGS+0AyMioqCMzzfFPg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230466>

Technically, "-s, --no-patch" is implemented in diff.c ("git diff
--no-patch" is essentially useless, but valid). From the user point of
view, this allows the documentation to show up in "git show --help",
which is one of the most useful use of the option.

While we're there, add a sentence explaining why the option can be
useful.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
It might make sense to surround this with ifndef::git-diff[], but
since "git diff --no-patch" actually works, I've left it
unconditional to be technically correct.

 Documentation/diff-options.txt     | 5 +++++
 Documentation/rev-list-options.txt | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 87e92d6..bbed2cd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -26,6 +26,11 @@ ifndef::git-format-patch[]
 	{git-diff? This is the default.}
 endif::git-format-patch[]
 
+-s::
+--no-patch::
+	Suppress diff output. Useful for commands like `git show` that
+	show the patch by default, or to cancel the effect of `--patch`.
+
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index c128a85..e632e85 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -849,8 +849,4 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 -t::
 
 	Show the tree objects in the diff output. This implies '-r'.
-
--s::
---no-patch::
-	Suppress diff output.
 endif::git-rev-list[]
-- 
1.8.3.1.495.g13f33cf.dirty
