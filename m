From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Update  git-unpack-objects documentation.
Date: Fri, 5 May 2006 15:05:36 -0400
Message-ID: <BAYC1-PASMTP03E37EFDF14A67A7A70279AEB50@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 05 21:11:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5hE-0001rb-6J
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWEETKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWEETKd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:10:33 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:15576 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751710AbWEETKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 15:10:32 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 May 2006 12:10:31 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0469C644C28
	for <git@vger.kernel.org>; Fri,  5 May 2006 15:10:31 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060505150536.4eaaad74.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 05 May 2006 19:10:32.0215 (UTC) FILETIME=[948A5270:01C67077]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Document that git-unpack-objects will not produce any
results when used on a pack that exists in a repository;
move it first.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/git-unpack-objects.txt |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

68facf4045556d10c541534a086b3c6486a1c5fb
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 1828062..c20b38b 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -13,9 +13,16 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads a packed archive (.pack) from the standard input, and
-expands the objects contained in the pack into "one-file
-one-object" format in $GIT_OBJECT_DIRECTORY.
+Read a packed archive (.pack) from the standard input, expanding
+the objects contained within and writing them into the repository in
+"loose" (one object per file) format.
+
+Objects that already exist in the repository will *not* be unpacked
+from the pack-file.  Therefore, nothing will be unpacked if you use
+this command on a pack-file that exists within the target repository.
+
+Please see the `git-repack` documentation for options to generate
+new packs and replace existing ones.
 
 OPTIONS
 -------
-- 
1.3.1.g9c203
