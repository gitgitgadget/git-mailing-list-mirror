From: "James P. Howard, II" <jh@jameshoward.us>
Subject: [PATCH] Cast &cp to eliminate a compile-time warning on FreeBSD 8-STABLE.
Date: Fri,  4 Dec 2009 18:12:02 -0500
Message-ID: <1259968322-66072-1-git-send-email-jh@jameshoward.us>
Cc: "James P. Howard, II" <jh@jameshoward.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 00:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGhJw-00033V-13
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 00:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbZLDXME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 18:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbZLDXMD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 18:12:03 -0500
Received: from byzantine.jameshoward.us ([204.109.63.101]:60032 "EHLO
	byzantine.jameshoward.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbZLDXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 18:12:03 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2009 18:12:02 EST
Received: from byzantine.jameshoward.us (localhost [127.0.0.1])
	by byzantine.jameshoward.us (8.14.3/8.14.3) with ESMTP id nB4NC74S066106;
	Fri, 4 Dec 2009 23:12:07 GMT
	(envelope-from howardjp@byzantine.jameshoward.us)
Received: (from howardjp@localhost)
	by byzantine.jameshoward.us (8.14.3/8.14.3/Submit) id nB4NC7XO066105;
	Fri, 4 Dec 2009 18:12:07 -0500 (EST)
	(envelope-from howardjp)
X-Mailer: git-send-email 1.6.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134584>

Signed-off-by: James P. Howard, II <jh@jameshoward.us>
---
 utf8.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/utf8.c b/utf8.c
index 7ddff23..a6cc280 100644
--- a/utf8.c
+++ b/utf8.c
@@ -449,7 +449,7 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
 	cp = (iconv_ibp)in;
 
 	while (1) {
-		size_t cnt = iconv(conv, &cp, &insz, &outpos, &outsz);
+		size_t cnt = iconv(conv, (const char **)&cp, &insz, &outpos, &outsz);
 
 		if (cnt == -1) {
 			size_t sofar;
-- 
1.6.5.3
