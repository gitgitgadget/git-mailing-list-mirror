From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Documentation/git-rev-parse.txt: fix example in SPECIFYING RANGES.
Date: Thu, 29 Mar 2007 06:42:44 +0000
Message-ID: <20070329064244.32053.qmail@f726f3c4b7218b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 08:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWoL5-0000xj-Gn
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 08:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbXC2GmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 02:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbXC2GmY
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 02:42:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:55473 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753285AbXC2GmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 02:42:24 -0400
Received: (qmail 32054 invoked by uid 1000); 29 Mar 2007 06:42:44 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43405>

Please see http://bugs.debian.org/404795:

 In git-rev-parse(1), there is an example commit tree, which is used twice.
 The explanation for this tree is very clear: B and C are commit *parents* to
 A.

 However, when the tree is reused as an example in the SPECIFYING RANGES, the
 manpage author screws up and uses A as a commit *parent* to B and C!  I.e.,
 he inverts the tree.

 And the fact that for this example you need to read the tree backwards is
 not explained anywhere (and it would be confusing even if it was).

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-rev-parse.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index ccc66aa..a8bf656 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -265,14 +265,14 @@ its all parents.
 
 Here are a handful examples:
 
-   D                A B D
-   D F              A B C D F
-   ^A G             B D
-   ^A F             B C F
-   G...I            C D F G I
-   ^B G I           C D F G I
-   F^@              A B C
-   F^! H            D F H
+   D                G H D
+   D F              G H I J D F
+   ^G D             H D
+   ^D B             E I J F B
+   B...C            G H D E B C
+   ^D B C           E I J F B C
+   C^@              I J F
+   F^! D            G H D F
 
 Author
 ------
-- 
1.5.1-rc2.GIT
