From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH v2 09/12] Add size() method to ObjectIdSubclassMap
Date: Sat,  7 Jun 2008 02:10:57 +0200
Message-ID: <1212797457-31081-1-git-send-email-marek.zawirski@gmail.com>
References: <200806061524.15823.robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 07 02:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4m2J-0003vl-FD
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758641AbYFGALG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758500AbYFGALE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:11:04 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:44072 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYFGALC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:11:02 -0400
Received: by mu-out-0910.google.com with SMTP id w8so754442mue.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 17:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=243TCJMozqQflOa2sXoofbj9Uy0bJAJyPSqDbda3G+g=;
        b=g3o/6jMHxpFuZPznnhQzjuSP6NEarRTveZHOrZHhU7w1/rdfe5wFca4bF0hPGDemgA
         a0Vq1M/hFBrytIWu/hRMzF3DqYQQrGqUV9khda1nyTwHIX8ovYVn5leTgQx87hZlmH7x
         AChOyDKkHB/DbmUnJKp2pwI6ExiPm7SbIQ/QA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oTk3bdGlWdecEqqX5Jb789lBGy8LP3hdpwHLI0txd/2OPinEgjKGKTRmva6E7cZxPJ
         zj3Bw96pK6CnLBP+JcyiLYlplm475swZA9koKTEo/rrJ4Qeouu9EdiUA0LpS0X2U/kKw
         ZbUv6dwi3F2BMungsFqpbRUDqEELpQO6lkREk=
Received: by 10.103.204.1 with SMTP id g1mr428037muq.9.1212797460252;
        Fri, 06 Jun 2008 17:11:00 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id g1sm24305954muf.7.2008.06.06.17.10.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 17:10:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <200806061524.15823.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84150>

Method is based on already existing field.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/lib/ObjectIdSubclassMap.java  |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
index 79ef5b6..2a13204 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
@@ -107,6 +107,13 @@ public class ObjectIdSubclassMap<V extends ObjectId> {
 		size++;
 	}
 
+	/**
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
