From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] Documentation/Makefile: clean up MAN*_TXT lists
Date: Fri, 1 Feb 2013 03:26:51 -0500
Message-ID: <20130201082650.GA25783@sigill.intra.peff.net>
References: <20130201082538.GA25674@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 09:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Bxt-00009w-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 09:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab3BAI04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 03:26:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55285 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab3BAI0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 03:26:55 -0500
Received: (qmail 19280 invoked by uid 107); 1 Feb 2013 08:28:18 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 03:28:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 03:26:51 -0500
Content-Disposition: inline
In-Reply-To: <20130201082538.GA25674@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215216>

We keep a list of the various files that end up as man1,
man5, etc. Let's break these single-line lists into sorted
multi-line lists, which makes diffs that touch them much
easier to read.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 971977b..8e7939f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,13 +1,28 @@ MAN7_TXT += gitcredentials.txt
-MAN1_TXT= \
-	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
-		$(wildcard git-*.txt)) \
-	gitk.txt gitweb.txt git.txt
-MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
-	gitrepository-layout.txt gitweb.conf.txt
-MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
-	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
-	gitdiffcore.txt gitnamespaces.txt gitrevisions.txt gitworkflows.txt
+MAN1_TXT += $(filter-out \
+		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
+		$(wildcard git-*.txt))
+MAN1_TXT += git.txt
+MAN1_TXT += gitk.txt
+MAN1_TXT += gitweb.txt
+
+MAN5_TXT += gitattributes.txt
+MAN5_TXT += githooks.txt
+MAN5_TXT += gitignore.txt
+MAN5_TXT += gitmodules.txt
+MAN5_TXT += gitrepository-layout.txt
+MAN5_TXT += gitweb.conf.txt
+
+MAN7_TXT += gitcli.txt
+MAN7_TXT += gitcore-tutorial.txt
 MAN7_TXT += gitcredentials.txt
+MAN7_TXT += gitcvs-migration.txt
+MAN7_TXT += gitdiffcore.txt
+MAN7_TXT += gitglossary.txt
+MAN7_TXT += gitnamespaces.txt
+MAN7_TXT += gitrevisions.txt
+MAN7_TXT += gittutorial-2.txt
+MAN7_TXT += gittutorial.txt
+MAN7_TXT += gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
-- 
1.8.1.2.11.g1a2f572
