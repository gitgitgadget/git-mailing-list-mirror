From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] checkout-index doc: use --work-dir in the export example
Date: Sat, 11 Aug 2007 20:15:19 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <1186856119985-git-send-email-ukleinek@informatik.uni-freiburg.de>
References: <7vhcn6ps4j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 20:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJvV3-0003Ae-6a
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 20:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbXHKSPl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 11 Aug 2007 14:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755720AbXHKSPl
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 14:15:41 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44005 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754348AbXHKSPk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 14:15:40 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IJvUw-0004bm-Oa; Sat, 11 Aug 2007 20:15:38 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7BIFXqj016667;
	Sat, 11 Aug 2007 20:15:33 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7BIFKnh016666;
	Sat, 11 Aug 2007 20:15:20 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc4.857.ge22ff
In-Reply-To: <7vhcn6ps4j.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55618>

The old example used --prefix=3D.../ to teach the reader that the trail=
ing
slash is important.  This lesson just moved down to the next example,
without a real example though.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.=
de>
---
Hello Junio,

even if you revert 4465f410 (and add the tests) I'd prefer using
--work-tree.

Best regards
Uwe

 Documentation/git-checkout-index.txt |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-c=
heckout-index.txt
index b1a8ce1..7c19351 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -143,21 +143,16 @@ $ git-checkout-index -n -f -a && git-update-index=
 --ignore-missing --refresh
 ----------------
=20
 Using `git-checkout-index` to "export an entire tree"::
-	The prefix ability basically makes it trivial to use
-	`git-checkout-index` as an "export as tree" function.
-	Just read the desired tree into the index, and do:
+	Just read the desired tree into the index, make sure
+	git-export-dir exists, and do:
 +
 ----------------
-$ git-checkout-index --prefix=3Dgit-export-dir/ -a
+$ git --work-dir=3Dgit-export-dir checkout-index -a
 ----------------
 +
 `git-checkout-index` will "export" the index into the specified
 directory.
 +
-The final "/" is important. The exported name is literally just
-prefixed with the specified string.  Contrast this with the
-following example.
-
 Export files with a prefix::
 +
 ----------------
@@ -165,7 +160,9 @@ $ git-checkout-index --prefix=3D.merged- Makefile
 ----------------
 +
 This will check out the currently cached copy of `Makefile`
-into the file `.merged-Makefile`.
+into the file `.merged-Makefile`.  The argument of --prefix is
+literally just prefixed with the specified string, so if you want to
+export to a directory you must end the prefix with a slash.
=20
=20
 Author
--=20
1.5.3.rc4.857.ge22ff
