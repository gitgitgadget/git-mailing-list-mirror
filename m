From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 4/4] Added extra javadoc for delete to significant RefUpdate results
Date: Sat, 23 Aug 2008 08:45:47 +1000
Message-ID: <1219445147-6801-5-git-send-email-charleso@charleso.org>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org>
 <1219445147-6801-2-git-send-email-charleso@charleso.org>
 <1219445147-6801-3-git-send-email-charleso@charleso.org>
 <1219445147-6801-4-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 00:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfPr-0000Sb-ET
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbYHVWqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbYHVWqO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:46:14 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:5340 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbYHVWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:46:11 -0400
Received: by py-out-1112.google.com with SMTP id p76so472265pyb.10
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=j73WpDYuat0FLTuU/mI4AiOrV/5usF3WL+CDntmb/wg=;
        b=LuBGqVmfgzZk34MOUcZ8nEvrv5V4amimzlTUzRRnIqNNmRLIvZavLrDmCr+cBRWj8v
         U6H4gZwbPJhFZTKVNqPn7xhAXSSBCX33of1rpMzwKdk2XhoZ85ExIsKgNnrnE1d9YYsp
         5s+Jd5OyeEn+0i4NYDxhzYa7qku1BWqOngD4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=wxIogwsjmx+7Tgq9b9Mmd3LRLMAzn5rDlwvbeNRUBXN0TA4aKB0P8zjnOpEcpEBRzc
         mmVmz8vjnmVYhdDL1kmkl7M3l022s0LHoBI3UyCokQGfFkH0ito9wmvZkMnDRh3B7DCQ
         VUp5oglUPEd7F9mA/8HPjE8m3apmS0ULl94WI=
Received: by 10.114.12.9 with SMTP id 9mr1614760wal.121.1219445170550;
        Fri, 22 Aug 2008 15:46:10 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id q18sm3549776pog.13.2008.08.22.15.46.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 15:46:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.49.gea35
In-Reply-To: <1219445147-6801-4-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93389>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 34a784b..525bb62 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -52,11 +52,11 @@
 public class RefUpdate {
 	/** Status of an update request. */
 	public static enum Result {
-		/** The ref update has not been attempted by the caller. */
+		/** The ref update/delete has not been attempted by the caller. */
 		NOT_ATTEMPTED,
 
 		/**
-		 * The ref could not be locked for update.
+		 * The ref could not be locked for update/delete.
 		 * <p>
 		 * This is generally a transient failure and is usually caused by
 		 * another process trying to access the ref at the same time as this
@@ -69,12 +69,12 @@
 		 * Same value already stored.
 		 * <p>
 		 * Both the old value and the new value are identical. No change was
-		 * necessary.
+		 * necessary for an update. For delete the branch is removed.
 		 */
 		NO_CHANGE,
 
 		/**
-		 * The ref was created locally.
+		 * The ref was created locally for an update, but ignored for delete.
 		 * <p>
 		 * The ref did not exist when the update started, but it was created
 		 * successfully with the new value.
@@ -82,7 +82,7 @@
 		NEW,
 
 		/**
-		 * The ref had to be forcefully updated.
+		 * The ref had to be forcefully updated/deleted.
 		 * <p>
 		 * The ref already existed but its old value was not fully merged into
 		 * the new value. The configuration permitted a forced update to take
@@ -92,7 +92,7 @@
 		FORCED,
 
 		/**
-		 * The ref was updated in a fast-forward way.
+		 * The ref was updated/deleted in a fast-forward way.
 		 * <p>
 		 * The tracking ref already existed and its old value was fully merged
 		 * into the new value. No history was made unreachable.
@@ -104,7 +104,7 @@
 		 * <p>
 		 * The tracking ref already existed but its old value was not fully
 		 * merged into the new value. The configuration did not allow a forced
-		 * update to take place, so ref still contains the old value. No
+		 * update/delete to take place, so ref still contains the old value. No
 		 * previous history was lost.
 		 */
 		REJECTED,
@@ -117,7 +117,7 @@
 		REJECTED_CURRENT_BRANCH,
 
 		/**
-		 * The ref was probably not updated because of I/O error.
+		 * The ref was probably not updated/deleted because of I/O error.
 		 * <p>
 		 * Unexpected I/O error occurred when writing new ref. Such error may
 		 * result in uncertain state, but most probably ref was not updated.
-- 
1.6.0.49.gea35
