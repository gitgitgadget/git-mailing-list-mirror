From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 21/20] Make isBetterDeltaReuseLoader() static in PackWriter
Date: Tue, 17 Jun 2008 23:28:54 +0200
Message-ID: <1213738134-6221-1-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-20-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Jun 17 23:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ikW-0000iC-6c
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbYFQV3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbYFQV3A
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:29:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:54242 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYFQV27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 17:28:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3670856fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=srywIu9dmEKN/iYEgffFUCyAMX6AdyL7b95yqpcs79I=;
        b=ofiUYAyjtPRcGPyHAPrc+MEoHHOZj+i6JppcCD/G4J4jxbbbA70g8qJetNLbQLts6L
         GDw/aU5Fosy0MXlaA9j3Ij3iDefqWICqIKfv81LFPnCPAMSMjOMH/oxpXkDFR4G8svpx
         SiCnWVRpQtJ5ZmhmWN2rxptrnd8kQUtz/WS20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=yCTc7QBS8iIoeTHhZwE/liuZ3PqcP58g8K4TOlUxGW0RAu8CGgOTAsxM3tMEoqYgvv
         ez7qxZenySWoMWCTvt8sv7KAkSb8rEZu/COAxCUO6bT5NPHLvTyGLfcd2DJOkSQud8g7
         XxBkZ56L+MTUbXWtP6PCjPs5nXNI3gXKO7h0c=
Received: by 10.86.76.20 with SMTP id y20mr9524737fga.5.1213738137134;
        Tue, 17 Jun 2008 14:28:57 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l19sm13899584fgb.7.2008.06.17.14.28.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 14:28:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-20-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85324>

Implementation was already static, it's just a fix for clarity and
potential speed-up.

Reported-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
It could be squashed with patch 19/20. I can clean up this mess, adding 
also Shawn's patch - just let me know what is preferred way (squash
commits, commits on top?).

 .../src/org/spearce/jgit/lib/PackWriter.java       |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 18d3ec2..ba43da5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -543,8 +543,9 @@ public class PackWriter {
 		}
 	}
 
-	private boolean isBetterDeltaReuseLoader(PackedObjectLoader currentLoader,
-			PackedObjectLoader loader) throws IOException {
+	private static boolean isBetterDeltaReuseLoader(
+			PackedObjectLoader currentLoader, PackedObjectLoader loader)
+			throws IOException {
 		if (currentLoader == null)
 			return true;
 		if (loader.getRawSize() < currentLoader.getRawSize())
-- 
1.5.5.1
