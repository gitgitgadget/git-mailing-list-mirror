From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-repack(1): document --window and --depth
Date: Sun, 17 Sep 2006 13:02:59 +0200
Message-ID: <20060917110259.GB1497@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 17 13:03:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOuQm-0006tQ-Q5
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 13:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWIQLDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 07:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWIQLDK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 07:03:10 -0400
Received: from [130.225.96.91] ([130.225.96.91]:907 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S964927AbWIQLDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 07:03:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 96A2A770068
	for <git@vger.kernel.org>; Sun, 17 Sep 2006 13:03:01 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13452-13 for <git@vger.kernel.org>; Sun, 17 Sep 2006 13:03:00 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 23989770065
	for <git@vger.kernel.org>; Sun, 17 Sep 2006 13:03:00 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id CDF346DF89F
	for <git@vger.kernel.org>; Sun, 17 Sep 2006 13:01:12 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0A1DD62A3C; Sun, 17 Sep 2006 13:02:59 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27185>

Copy and pasted from git-pack-objects(1).

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-repack.txt |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 9516227..49f7e0a 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ objects into pack files.
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q]
+'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
 
 DESCRIPTION
 -----------
@@ -56,6 +56,16 @@ OPTIONS
         Do not update the server information with
         `git update-server-info`.
 
+--window=[N], --depth=[N]::
+	These two options affects how the objects contained in the pack are
+	stored using delta compression. The objects are first internally
+	sorted by type, size and optionally names and compared against the
+	other objects within `--window` to see if using delta compression saves
+	space. `--depth` limits the maximum delta depth; making it too deep
+	affects the performance on the unpacker side, because delta data needs
+	to be applied that many times to get to the necessary object.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.4.2.g39f1

-- 
Jonas Fonseca
