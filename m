From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 09/12] Add getSize() method to ObjectIdSubclassMap
Date: Mon,  2 Jun 2008 23:24:40 +0200
Message-ID: <1212441883-12990-10-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-8-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-9-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXs-0006g0-Fy
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYFBVZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYFBVZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:45136 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYFBVZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:15 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1247612mue.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iEOUDCWov2d3M1gCIoyxrvib/dBIG+XS59P034lTh8E=;
        b=jjmP2nn/GHsWdzIzjwAB38/d80oSJ1w+J109mpaYlJSWweQylU0tIqM8JmDORunyWdQlgrxqWdMk6f1fbjF3Pglep1xHGO4NL9uwsLW/J0pcjhznbRL8lnPeWwSXRboP+sN6oD1HMtvEqoh0AYZk8pecztj7Orzo/v5mCsvCR6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lkQKKAVrveaQdsFUDYQfKPeq9Rym+j9vt59RnZpyKx8P6QXFq7iCafhbYjABEK2hKNINUoFzsMCHtnM4PV9uHDQoOYFxZF/xe/IANJ9PPRKdAcieLV0OSEpvXrX0GuziaomqStcOaxPFkDuvYVvwbcFgglwfYEBjvChHMMZg3d8=
Received: by 10.103.208.15 with SMTP id k15mr5767752muq.84.1212441914311;
        Mon, 02 Jun 2008 14:25:14 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id g1sm21233691muf.7.2008.06.02.14.25.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:13 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-9-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83572>

Method is based on already existing field.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/lib/ObjectIdSubclassMap.java  |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
index 79ef5b6..76bc9d9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
@@ -107,6 +107,15 @@ public class ObjectIdSubclassMap<V extends ObjectId> {
 		size++;
 	}
 
+	/**
+	 * Returns number of objects in map.
+	 * 
+	 * @return number of objects in map
+	 */
+	public int size() {
+		return size;
+	}
+
 	private final int index(final AnyObjectId id) {
 		return (id.w1 >>> 1) % obj_hash.length;
 	}
-- 
1.5.5.1
