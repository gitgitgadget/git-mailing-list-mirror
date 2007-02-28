From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make sure enum object_type is signed
Date: Tue, 27 Feb 2007 20:38:31 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702272028100.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 02:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMDm7-0005EE-HH
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 02:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXB1Bid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 20:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbXB1Bid
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 20:38:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45772 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbXB1Bic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 20:38:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE5002SNGK710C3@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 20:38:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40871>

This allows for keeping the common idiom which consists of using 
negative values to signal error conditions by ensuring that the enum 
will be a signed type.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Per early discussion.

diff --git a/cache.h b/cache.h
index 0117b7e..ec72c0c 100644
--- a/cache.h
+++ b/cache.h
@@ -263,6 +263,7 @@ int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
 
 enum object_type {
+	OBJ_BAD = -1,
 	OBJ_NONE = 0,
 	OBJ_COMMIT = 1,
 	OBJ_TREE = 2,
@@ -271,7 +272,7 @@ enum object_type {
 	/* 5 for future expansion */
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
-	OBJ_BAD,
+	OBJ_MAX,
 };
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
