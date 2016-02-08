From: Markus Kuhn <Markus.Kuhn@cl.cam.ac.uk>
Subject: man git-config inconsistency (*.fsckObjects)
Date: Mon, 8 Feb 2016 14:41:44 +0000
Message-ID: <56B8A928.4000802@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 15:51:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSn9u-0004xo-Sj
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 15:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbcBHOvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 09:51:19 -0500
Received: from mta0.cl.cam.ac.uk ([128.232.25.20]:47728 "EHLO
	mta0.cl.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbcBHOvS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 09:51:18 -0500
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2016 09:51:18 EST
Received: from dirac.cl.cam.ac.uk ([128.232.65.23])
	by mta0.cl.cam.ac.uk with esmtp (Exim 4.63)
	(envelope-from <Markus.Kuhn@cl.cam.ac.uk>)
	id 1aSn0a-0006BB-76
	for git@vger.kernel.org; Mon, 08 Feb 2016 14:41:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285771>

https://www.kernel.org/pub/software/scm/git/docs/git-config.html

The git-config(1) man page entries for "fetch.fsckObjects" and
"receive.fsckObjects" both end with the lines

            Defaults to false. If not set, the value of transfer.fsckObjects is
            used instead.

These two sentences contradict each other: if the variable is not set,
the first sentence says it is interpreted as false, the second sentence
says the value of transfer.fsckObjects is used instead.

Both sentences can't be true at the same time when transfer.fsckObjects = true.

Suggested rephrasing:

            If not set, the value of transfer.fsckObjects is used
            instead, which defaults to false.

Markus

-- 
Markus Kuhn, Computer Laboratory, University of Cambridge
http://www.cl.cam.ac.uk/~mgk25/ || CB3 0FD, Great Britain


 From f6253cce1a0f9df53b020c5821e9fc9fa27cd23f Mon Sep 17 00:00:00 2001
From: Markus Kuhn <Markus.Kuhn@cl.cam.ac.uk>
Date: Mon, 8 Feb 2016 14:36:22 +0000
Subject: [PATCH] avoid self-contradiction on fsckObjects default

---
  Documentation/config.txt | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 02bcde6..85832ba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1157,8 +1157,8 @@ fetch.fsckObjects::
  	If it is set to true, git-fetch-pack will check all fetched
  	objects. It will abort in the case of a malformed object or a
  	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	If not set, the value of `transfer.fsckObjects` is used
+	instead, which defaults to false.
  
  fetch.unpackLimit::
  	If the number of objects fetched over the Git native
@@ -2348,8 +2348,8 @@ receive.fsckObjects::
  	If it is set to true, git-receive-pack will check all received
  	objects. It will abort in the case of a malformed object or a
  	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	If not set, the value of `transfer.fsckObjects` is used
+	instead, which defaults to false.
  
  receive.fsck.<msg-id>::
  	When `receive.fsckObjects` is set to true, errors can be switched
-- 
1.9.1
