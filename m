From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 15/23] Add String versions of methods in RefSpec
Date: Sat, 28 Jun 2008 00:06:39 +0200
Message-ID: <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM94-0001Lw-QI
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761570AbYF0WIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761376AbYF0WIN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38733 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758707AbYF0WIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182445nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7yW7aA2gQadZWy+zHfRLpdOZluX8pBclOlHPW+FFulE=;
        b=cUNRJ5u8SSRMftD9FEFvA0V593w9UyssK/XsGEa0A27Ff9zO9CLkbtbsoy0gbdOMf+
         eguKejRqEHJwAxEIhz6XcK5uGCoWls9oJzLlAfFgx98Qg/WmAGu4kEhPnE4r/3SMQRhR
         t3E4ZmpPF0IM1VtLybzHufRoN1JG+vEVlbRRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lTq0iZ+gFEW+cvK++KkUgVV0/Yrqzk3YIFtkprrUtJ7M24QoZIhiFJtP2b2AHMiGP0
         7n/P6ldRB6sllc80FyZoZz7kGc5s00SIzdrXhRTJXxrDci5vpRLAzN0UWsNHEv5KVGds
         ftePCFgOiSdIVUXGks9Z0Y9iQD/UHmC0hcN4s=
Received: by 10.210.47.7 with SMTP id u7mr1586982ebu.147.1214604481607;
        Fri, 27 Jun 2008 15:08:01 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id z37sm2449267ikz.6.2008.06.27.15.07.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86655>

matchDestination(), matchSource(), expandFromSourec() can take String
as parameter now, not only Ref (we just need a ref name).

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/RefSpec.java    |   46 +++++++++++++++++--
 1 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
index 38489be..1589e19 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
@@ -281,6 +281,17 @@ public class RefSpec {
 	}
 
 	/**
+	 * Does this specification's source description match the ref name?
+	 * 
+	 * @param r
+	 *            ref name that should be tested.
+	 * @return true if the names match; false otherwise.
+	 */
+	public boolean matchSource(final String r) {
+		return match(r, getSource());
+	}
+
+	/**
 	 * Does this specification's source description match the ref?
 	 * 
 	 * @param r
@@ -288,7 +299,18 @@ public class RefSpec {
 	 * @return true if the names match; false otherwise.
 	 */
 	public boolean matchSource(final Ref r) {
-		return match(r, getSource());
+		return match(r.getName(), getSource());
+	}
+
+	/**
+	 * Does this specification's destination description match the ref name?
+	 * 
+	 * @param r
+	 *            ref name that should be tested.
+	 * @return true if the names match; false otherwise.
+	 */
+	public boolean matchDestination(final String r) {
+		return match(r, getDestination());
 	}
 
 	/**
@@ -299,7 +321,21 @@ public class RefSpec {
 	 * @return true if the names match; false otherwise.
 	 */
 	public boolean matchDestination(final Ref r) {
-		return match(r, getDestination());
+		return match(r.getName(), getDestination());
+	}
+
+	/**
+	 * Expand this specification to exactly match a ref name.
+	 * <p>
+	 * Callers must first verify the passed ref name matches this specification,
+	 * otherwise expansion results may be unpredictable.
+	 * 
+	 * @param r
+	 *            a ref name that matched our source specification.
+	 * @return a new specification that is not a wildcard.
+	 */
+	public RefSpec expandFromSource(final String r) {
+		return isWildcard() ? new RefSpec(this, r) : this;
 	}
 
 	/**
@@ -316,12 +352,12 @@ public class RefSpec {
 		return isWildcard() ? new RefSpec(this, r.getName()) : this;
 	}
 
-	private boolean match(final Ref r, final String s) {
+	private boolean match(final String refName, final String s) {
 		if (s == null)
 			return false;
 		if (isWildcard())
-			return r.getName().startsWith(s.substring(0, s.length() - 1));
-		return r.getName().equals(s);
+			return refName.startsWith(s.substring(0, s.length() - 1));
+		return refName.equals(s);
 	}
 
 	public int hashCode() {
-- 
1.5.5.3
