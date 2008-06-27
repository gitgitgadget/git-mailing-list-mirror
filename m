From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 21/23] Don't accept RefSpec with null source for fetch
Date: Sat, 28 Jun 2008 00:06:45 +0200
Message-ID: <1214604407-30572-22-git-send-email-marek.zawirski@gmail.com>
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
 <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-17-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-18-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-19-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-20-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-21-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM99-0001Lw-2E
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762970AbYF0WIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763242AbYF0WIg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38733 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763028AbYF0WIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182445nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YXmgA2gZq4pVSB1RyzA5+0BxveTHy2N9Ybv2WRUeYgc=;
        b=k5GC8buS3ZxfDM/5gN1A9HMUuLQuL+F0Gzlg0T02EE9bF235GOwKPrPof++8vPtaHm
         1TRp/XkFSdMIE3ORmZYhmnGtcHIXbntQ1dG5WbbqeRTghRaUy8Ea24usvT8Kf/3YVwk5
         cbSiGSmJ/BHzEDmqfvn4zUTfcEE15yBCTDeoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F0qzoWzPngCE5Bp1Z8kxlYrqTPXZqfX8fMVRq57K9FNKCh9GxBmN/zVfXWBnwSPtDv
         GEF+GaHavKrcDKKaEZ4DWSdUkgA6IBa8YyZb8fnWHHYmBtsVufNKB8PUyFBcuPzhMpXD
         c3kSjxtwHKNRDnYr76N2onfDcFXlAJNivnAh4=
Received: by 10.210.29.11 with SMTP id c11mr1630181ebc.16.1214604510355;
        Fri, 27 Jun 2008 15:08:30 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b33sm2446813ika.2.2008.06.27.15.08.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-21-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86663>

RefSpec with null source has no sense, so let's inform about it.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/transport/FetchProcess.java   |    4 ++++
 .../src/org/spearce/jgit/transport/Transport.java  |    5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index c765c12..f9c2266 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -100,6 +100,10 @@ class FetchProcess {
 			result.setAdvertisedRefs(conn.getRefsMap());
 			final Set<Ref> matched = new HashSet<Ref>();
 			for (final RefSpec spec : toFetch) {
+				if (spec.getSource() == null)
+					throw new TransportException(
+							"Source ref not specified for refspec: " + spec);
+
 				if (spec.isWildcard())
 					expandWildcard(spec, matched);
 				else
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index da5b41e..8260da6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -363,14 +363,15 @@ public abstract class Transport {
 	 * @param toFetch
 	 *            specification of refs to fetch locally. May be null or the
 	 *            empty collection to use the specifications from the
-	 *            RemoteConfig.
+	 *            RemoteConfig. Source for each RefSpec can't be null.
 	 * @return information describing the tracking refs updated.
 	 * @throws NotSupportedException
 	 *             this transport implementation does not support fetching
 	 *             objects.
 	 * @throws TransportException
 	 *             the remote connection could not be established or object
-	 *             copying (if necessary) failed.
+	 *             copying (if necessary) failed or update specification was
+	 *             incorrect.
 	 */
 	public FetchResult fetch(final ProgressMonitor monitor,
 			Collection<RefSpec> toFetch) throws NotSupportedException,
-- 
1.5.5.3
