From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 1/17] Document the --non-empty command-line option to git-pack-objects.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844853669-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844841342-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVBN-0004R3-GV
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbVLHX2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVLHX2I
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:08 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:9124 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932724AbVLHX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:06 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051208232804.VENJ676.mxfep01.bredband.com@puritan.petwork>;
          Fri, 9 Dec 2005 00:28:04 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 1E268ADFE8;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844841342-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13387>

This provides (minimal) documentation for the --non-empty command-line
option to the pack-objects command.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-pack-objects.txt |    6 +++++-
 pack-objects.c                     |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

50543554f2945443c10434fcfe6689bc7cc5c3e8
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d1e93db..009ec5a 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -8,7 +8,7 @@ git-pack-objects - Create a packed archi
 
 SYNOPSIS
 --------
-'git-pack-objects' [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list
+'git-pack-objects' [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list
 
 
 DESCRIPTION
@@ -70,6 +70,10 @@ base-name::
 	that are packed and not in the local object store
 	(i.e. borrowed from an alternate).
 
+--non-empty::
+        Only create a packed archive if it would contain at
+        least one object.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/pack-objects.c b/pack-objects.c
index a62c9f8..caf3b6b 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -4,7 +4,7 @@
 #include "pack.h"
 #include "csum-file.h"
 
-static const char pack_usage[] = "git-pack-objects [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
+static const char pack_usage[] = "git-pack-objects [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
 
 struct object_entry {
 	unsigned char sha1[20];
-- 
0.99.9l
