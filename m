From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 10/12] Add getObjectCount() method to PackFile
Date: Mon,  2 Jun 2008 23:24:41 +0200
Message-ID: <1212441883-12990-11-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-8-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-9-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-10-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXt-0006g0-2v
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYFBVZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYFBVZV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:39632 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYFBVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so844313fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=n2n/5awD4JhIXFt4v/HQQjctZ8MjoWayE1EKsFGjyeg=;
        b=S6ua2ZDGepyecu99xxN9ZGULnmZQa6+ID0pLnKSqwjcBu5OmOSJzY9qxXkHe+nyEXveUqJsYDF0Qh3qeKwx/VR2SuuxNB6tFY9yP3DsWgD0pzjmQGKhEQvAjQQ8uTpUKJ9/6Nh1ZvGrEzwPBYiYf8W2m5SydRgvmVJzma5hSGIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X07ytNZTmCD19Nt4ncSFO2yuVT48zZHz9Zc3tSzgMCnbjPTX/1LhyS+yg8L5jp4CH2LP8Thk7Th1sGlPvuMzO6I5YS0oS0GW76NUZLy6UMxAVygnsoFr5h11QWiiAWcElx7tLbnVaPo6rF0VfH1UioX3zZD+bA0dBzknihcUubw=
Received: by 10.86.4.2 with SMTP id 2mr7227130fgd.16.1212441917150;
        Mon, 02 Jun 2008 14:25:17 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d4sm4340507fga.8.2008.06.02.14.25.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-10-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83570>

Method relies on PackIndex getObjectCount(). Exposed only to package.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index b1fbc2a..84562aa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -145,6 +145,16 @@ public class PackFile {
 		pack.close();
 	}
 
+	/**
+	 * Obtain the total number of objects available in this pack. This method
+	 * relies on pack index, giving number of effectively available objects.
+	 * 
+	 * @return number of objects in index of this pack, likewise in this pack
+	 */
+	long getObjectCount() {
+		return idx.getObjectCount();
+	}
+
 	final UnpackedObjectCache.Entry readCache(final long position) {
 		return UnpackedObjectCache.get(pack, position);
 	}
-- 
1.5.5.1
