From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] The hash name is SHA-1, use that throughout
Date: Sun, 11 Jun 2006 22:04:19 -0400
Message-ID: <1150077861580-git-send-email-vonbrand@inf.utfsm.cl>
References: <11500778593947-git-send-email-vonbrand@inf.utfsm.cl>
Reply-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 04:04:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpbn5-00015T-DI
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 04:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFLCE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 22:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWFLCE2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 22:04:28 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:18597 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751136AbWFLCE1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 22:04:27 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k5C24MdP003947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 22:04:22 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k5C24MEJ012853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 22:04:23 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k5C24MJ6012852;
	Sun, 11 Jun 2006 22:04:22 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g1b2d
In-Reply-To: <11500778593947-git-send-email-vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 11 Jun 2006 22:04:23 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21681>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/technical/pack-format.txt     |    8 ++++----
 Documentation/technical/pack-heuristics.txt |    4 ++--
 Documentation/technical/pack-protocol.txt   |   20 ++++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 0e1ffb2..8823dce 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -32,7 +32,7 @@ GIT pack format
      Observation: length of each object is encoded in a variable
      length format and is not constrained to 32-bit or anything.
 
-  - The trailer records 20-byte SHA1 checksum of all of the above.
+  - The trailer records 20-byte SHA-1 checksum of all of the above.
 
 = pack-*.idx file has the following format:
 
@@ -61,10 +61,10 @@ GIT pack format
 
   - The file is concluded with a trailer:
 
-    A copy of the 20-byte SHA1 checksum at the end of
+    A copy of the 20-byte SHA-1 checksum at the end of
     corresponding packfile.
 
-    20-byte SHA1-checksum of all of the above.
+    20-byte SHA-1-checksum of all of the above.
 
 Pack Idx file:
 
@@ -111,6 +111,6 @@ Pack file entry: <+
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
 	If it is DELTA, then
-	  20-byte base object name SHA1 (the size above is the
+	  20-byte base object name SHA-1 (the size above is the
 	  	size of the delta data that follows).
           delta data, deflated.
diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.txt
index 9aadd5c..458677e 100644
--- a/Documentation/technical/pack-heuristics.txt
+++ b/Documentation/technical/pack-heuristics.txt
@@ -77,7 +77,7 @@ And Bable-like confusion flowed.
 
     <njs`> oh, hmm, and I'm not sure what this sliding window means either
 
-    <pasky> iirc, it appeared to me to be just the sha1 of the object
+    <pasky> iirc, it appeared to me to be just the SHA-1 of the object
         when reading the code casually ...
 
         ... which simply doesn't sound as a very good heuristics, though ;)
@@ -89,7 +89,7 @@ Ah, grasshopper!  And thus the enlighten
 
     <linus> The "magic" is actually in theory totally arbitrary.
         ANY order will give you a working pack, but no, it's not
-        ordered by SHA1.
+        ordered by SHA-1.
 
         Before talking about the ordering for the sliding delta
         window, let's talk about the recency order. That's more
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 9cd48b4..9df76e3 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -6,22 +6,22 @@ There are two Pack push-pull protocols.
 upload-pack (S) | fetch/clone-pack (C) protocol:
 
 	# Tell the puller what commits we have and what their names are
-	S: SHA1 name
+	S: SHA-1 name
 	S: ...
-	S: SHA1 name
+	S: SHA-1 name
 	S: # flush -- it's your turn
 	# Tell the pusher what commits we want, and what we have
 	C: want name
 	C: ..
 	C: want name
-	C: have SHA1
-	C: have SHA1
+	C: have SHA-1
+	C: have SHA-1
 	C: ...
 	C: # flush -- occasionally ask "had enough?"
 	S: NAK
-	C: have SHA1
+	C: have SHA-1
 	C: ...
-	C: have SHA1
+	C: have SHA-1
 	S: ACK
 	C: done
 	S: XXXXXXX -- packfile contents.
@@ -29,13 +29,13 @@ upload-pack (S) | fetch/clone-pack (C) p
 send-pack | receive-pack protocol.
 
 	# Tell the pusher what commits we have and what their names are
-	C: SHA1 name
+	C: SHA-1 name
 	C: ...
-	C: SHA1 name
+	C: SHA-1 name
 	C: # flush -- it's your turn
 	# Tell the puller what the pusher has
-	S: old-SHA1 new-SHA1 name
-	S: old-SHA1 new-SHA1 name
+	S: old-SHA-1 new-SHA-1 name
+	S: old-SHA-1 new-SHA-1 name
 	S: ...
 	S: # flush -- done with the list
 	S: XXXXXXX --- packfile contents.
-- 
1.4.0.g1b2d
