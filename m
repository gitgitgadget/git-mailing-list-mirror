From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [JGIT PATCH] Skip executeBit-tests for filesystems which do not support this feature
Date: Tue,  3 Feb 2009 18:44:08 +0100
Message-ID: <1233683048-22767-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPKs-0002I5-Pj
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZBCRn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 12:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbZBCRn5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:43:57 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:35441 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZBCRn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:43:56 -0500
Received: by ey-out-2122.google.com with SMTP id 25so506355eya.37
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=9MB1VoQ8kNC1ctAi2OydnGb0rZKtpBBPNptR0WSI/30=;
        b=gv74aLnS1MBMZAGoeyjETP/BpEle2X1y3MCLxNez9bS5OzWIOFpvoyEsT3X75590WY
         /SbK3leJd03VR4t0dF5Bb42AdfTomPusssS35OqOK4to7WWrUfiBUq3OpnPg2FqZ0DuQ
         T+JQKalJxf9DwMpvGlGTGzj1WEcmGiPnLGT2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=v7+S5etLVt0y8QEHBV7I/IR5rluVtXAYVMiOAa/LEI1e4AhgXAsi1okfwy+/ZGHbtR
         MlFKbQ2Izix7eQRuyqwBdsoB0RL2j9qGqn7eq/63orzYpEQXQ+xkoEXUxiyp3GqMSCYk
         Z3i4xYTNTV5dyRfmer8ICV6arUGBZaBEeywhI=
Received: by 10.103.52.7 with SMTP id e7mr2540653muk.115.1233683033306;
        Tue, 03 Feb 2009 09:43:53 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id u26sm423564mug.48.2009.02.03.09.43.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 09:43:52 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 69B2F468001; Tue,  3 Feb 2009 18:44:08 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108225>

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../tst/org/spearce/jgit/lib/T0007_Index.java      |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index=
=2Ejava b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.ja=
va
index 499812e..fbda4fb 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
@@ -46,6 +46,7 @@
 import java.lang.reflect.Method;
=20
 import org.spearce.jgit.lib.GitIndex.Entry;
+import org.spearce.jgit.util.FS;
=20
 public class T0007_Index extends RepositoryTestCase {
=20
@@ -319,6 +320,10 @@ public void testCheckout() throws Exception {
 	}
=20
 	public void test030_executeBit_coreModeTrue() throws IllegalArgumentE=
xception, IllegalAccessException, InvocationTargetException, Error, Exc=
eption {
+		if (!FS.INSTANCE.supportsExecute()) {
+			System.err.println("Test ignored since platform FS does not support=
 the execute permission");
+			return;
+		}
 		try {
 			// coremode true is the default, typically set to false
 			// by git init (but not jgit!)
@@ -370,6 +375,10 @@ public void test030_executeBit_coreModeTrue() thro=
ws IllegalArgumentException, I
 	}
=20
 	public void test031_executeBit_coreModeFalse() throws IllegalArgument=
Exception, IllegalAccessException, InvocationTargetException, Error, Ex=
ception {
+		if (!FS.INSTANCE.supportsExecute()) {
+			System.err.println("Test ignored since platform FS does not support=
 the execute permission");
+			return;
+		}
 		try {
 			// coremode true is the default, typically set to false
 			// by git init (but not jgit!)
--=20
1.6.1.2.309.g2ea3
