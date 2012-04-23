From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 6/7] push: document the future default change for push.default (matching -> simple)
Date: Mon, 23 Apr 2012 10:38:03 +0200
Message-ID: <1335170284-30768-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 23 10:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEnF-00034n-NI
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab2DWIih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:38:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55571 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329Ab2DWIif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:38:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3N8VnCi029944
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 10:31:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-0004mx-ST; Mon, 23 Apr 2012 10:38:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-00081e-Qc; Mon, 23 Apr 2012 10:38:07 +0200
X-Mailer: git-send-email 1.7.10.234.ge65dd.dirty
In-Reply-To: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Apr 2012 10:31:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3N8VnCi029944
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335774714.30247@ACPK+0/7UbeufmEAWfM2IQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196102>

It is too early to start warning loudly about the future default change
in favor of 'simple', since many users use different versions of Git, and
would be harmed if we advised them to explicitely set
'push.default=simple' when using old versions of Git.

Still, we want to document the upcomming change so that:

* Users who may be affected by the change get one more chance to know it
  in advance.

* We actually commit to changing the default, and avoid repeating past
  errors.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 88d739a..696544e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1687,10 +1687,12 @@ push.default::
   repository, but may give surprising results when used on a
   repository shared by multiple users, since locally stalled
   branches will attempt a non-fast forward push if other users
-  updated the branch remotely. This is the default.
+  updated the branch remotely. This is currently the default, but Git
+  2.0 will change the default to `simple`.
 * `simple` - like `upstream`, but refuses to push if the upstream
   branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners.
+  option and is well-suited for beginners. It will become the default
+  in Git 2.0.
 * `upstream` - push the current branch to its upstream branch. See
   "branch.<name>.merge" for how to configure the upstream branch. This
   makes `git push` and `git pull` symmetrical in the sense that `push`
-- 
1.7.10.234.ge65dd.dirty
