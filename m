From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] Documentation: clarify the invalidated tree entry format
Date: Tue, 26 Jul 2011 14:27:57 +0200
Message-ID: <1311683277-17910-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 14:28:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlgk0-0004TD-5t
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 14:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab1GZM2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 08:28:00 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43677 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab1GZM16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 08:27:58 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4E1BA46204;
	Tue, 26 Jul 2011 14:27:54 +0200 (CEST)
Received: (nullmailer pid 17955 invoked by uid 1000);
	Tue, 26 Jul 2011 12:27:57 -0000
X-Mailer: git-send-email 1.7.5.2.585.gfbd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177863>

When the entry_count is -1, the tree is invalidated and therefore has
not associated hash (or object name). Explicitly state that the next
entry starts after the newline.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

This might be considered obvious, but IMO the hash (ojbect name) could
just as well be zeroed out and ignored by the parser. At any rate,
it's good to be explicit.

 Documentation/technical/index-format.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 7b233ca..8930b3f 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -147,8 +147,9 @@ GIT index format
   - 160-bit object name for the object that would result from writing
     this span of index as a tree.
=20
-  An entry can be in an invalidated state and is represented by having=
 -1
-  in the entry_count field.
+  An entry can be in an invalidated state and is represented by having
+  -1 in the entry_count field. In this case, there is no object name
+  and the next entry starts immediately after the newline.
=20
   The entries are written out in the top-down, depth-first order.  The
   first entry represents the root level of the repository, followed by=
 the
--=20
1.7.5.2.585.gfbd48
