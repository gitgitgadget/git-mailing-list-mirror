From: "Art Haas" <ahaas@airmail.net>
Subject: [PATCH] Conditionally define _GNU_SOURCE in mailinfo.c
Date: Sun, 30 Apr 2006 13:19:31 -0500
Message-ID: <20060430181931.GE6626@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 30 20:19:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaGWA-0001SU-Hz
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 20:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWD3STY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWD3STY
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 14:19:24 -0400
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:57092 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S1751171AbWD3STY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 14:19:24 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by covert.iadfw.net with esmtp (Exim 4.24)
	id 1FaGau-0001lp-4t
	for git@vger.kernel.org; Sun, 30 Apr 2006 13:24:32 -0500
Received: (qmail 15353 invoked by uid 1000); 30 Apr 2006 18:19:31 -0000
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19351>

Hi.

Place the '#define _GNU_SOURCE' within an #ifndef/#endif block testing
if '_GNU_SOURCE' is already defined.

Signed-off-by: Art Haas <ahaas@airmail.net>

---

 mailinfo.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

d3932a8fca2faac8ed14bfd0e65c1f0135dc1d4b
diff --git a/mailinfo.c b/mailinfo.c
index b276519..4b99ccf 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -2,7 +2,9 @@
  * Another stupid program, this one parsing the headers of an
  * email to figure out authorship and subject
  */
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
1.3.1.g66ae

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
