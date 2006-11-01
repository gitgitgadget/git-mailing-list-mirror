X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects doesn't create random pack names
Date: Wed, 01 Nov 2006 17:34:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611011728240.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Nov 2006 22:34:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30671>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOff-00037P-UR for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752268AbWKAWeu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbWKAWeu
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:34:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32055 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752268AbWKAWet
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:34:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J82003EFPDZOMD0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 01 Nov 2006 17:34:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Documentation for pack-objects seems to be out of date in this regard.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a1e5505..9bd1e39 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -47,9 +47,8 @@ base-name::
 	<base-name> to determine the name of the created file.
 	When this option is used, the two files are written in
 	<base-name>-<SHA1>.{pack,idx} files.  <SHA1> is a hash
-	of object names (currently in random order so it does
-	not have any useful meaning) to make the resulting
-	filename reasonably unique, and written to the standard
+	of the sorted object names to make the resulting filename
+	based on the pack content, and written to the standard
 	output of the command.
 
