From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/23] Add test-index-version
Date: Mon, 14 Dec 2009 17:30:45 +0700
Message-ID: <1260786666-8405-3-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:36:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8I6-0000bW-2o
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbZLNKcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbZLNKcK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:10 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47974 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZLNKcF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:05 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so2177665pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zX/V9iZgsUYrTSwXXWh10UWnzL2x9Y24sXrsoeubb4g=;
        b=Z5AIpX7AsLPD23dsuWbir8yV2lEPhh1qcyvBk7hGzeymFEbFRNzCG7cvgIK4ScoZDf
         lTHebXiAjQidSKmvXpajSFw0CxFp7QqRgb0mxbEnavBa3VqVAmt8t4/NCX0YNQ2gepcM
         xJRCq+bxXyP2b2iyspEO2rTltE0T6naDuSFNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pe6OS/pW9xYqqlpCMy1l8AngcOlDQjsj3duBA58GNj5aKNAgeKuts5NqLbpV14hwdy
         dS2/eSar72jVty8puTiNjLIvKHmAKXI4U0Z7Ish7MBJoGsQVTMGS3Jmzd6f1d6pPdr4G
         ziEOPta3cIyz5fGOIHI0xbokru0i+69Iu+WyU=
Received: by 10.141.101.6 with SMTP id d6mr3203105rvm.180.1260786725362;
        Mon, 14 Dec 2009 02:32:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4903975pzk.3.2009.12.14.02.32.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:04 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:23 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135196>

Commit 06aaaa0bf70fe37d198893f4e25fa73b6516f8a9 may step index format
version up and down, depends on whether extended flags present in the
index. This adds a test to check for index format version.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore           |    1 +
 Makefile             |    1 +
 test-index-version.c |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 test-index-version.c

diff --git a/.gitignore b/.gitignore
index 41c0b20..e3a864c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -153,6 +153,7 @@ test-date
 test-delta
 test-dump-cache-tree
 test-genrandom
+test-index-version
 test-match-trees
 test-parse-options
 test-path-utils
diff --git a/Makefile b/Makefile
index daf4296..3c5b890 100644
--- a/Makefile
+++ b/Makefile
@@ -1580,6 +1580,7 @@ TEST_PROGRAMS +=3D test-parse-options$X
 TEST_PROGRAMS +=3D test-path-utils$X
 TEST_PROGRAMS +=3D test-sha1$X
 TEST_PROGRAMS +=3D test-sigchain$X
+TEST_PROGRAMS +=3D test-index-version$X
=20
 all:: $(TEST_PROGRAMS)
=20
diff --git a/test-index-version.c b/test-index-version.c
new file mode 100644
index 0000000..bfaad9e
--- /dev/null
+++ b/test-index-version.c
@@ -0,0 +1,14 @@
+#include "cache.h"
+
+int main(int argc, const char **argv)
+{
+	struct cache_header hdr;
+	int version;
+
+	memset(&hdr,0,sizeof(hdr));
+	if (read(0, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
+		return 0;
+	version =3D ntohl(hdr.hdr_version);
+	printf("%d\n", version);
+	return 0;
+}
--=20
1.6.5.2.216.g9c1ec
