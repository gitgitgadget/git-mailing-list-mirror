From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 02/19] Add test-index-version
Date: Thu, 20 Aug 2009 20:46:56 +0700
Message-ID: <1250776033-12395-3-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me7zR-0006kO-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbZHTNrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbZHTNrb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:32782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbZHTNra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:30 -0400
Received: by wa-out-1112.google.com with SMTP id j5so957051wah.21
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+y/tsHzU7menwXhvFVYum2nHl39DpCltd4lE4gP6JFY=;
        b=c0u9Y6kuOtXQciP1GwOD0TTFAeep6nmpE7jFulodDNgrERuOApJINU1YKrts3LHe4x
         wTROUaZbNt1Vv2GhBqNnt+dD6/pU4Wwa9xu6lzUxl7zaQ9lh1XcGVvMnVaTD+lR3zWxH
         VFNVBw3uJzpmRNWLEr0oILNZeAEhppVGcl6qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HllzmzTpGbF7MQTe1yY1vPYMCAb05ciPbRShghYHRVHIXAMW3R74cDy6B80jPJCIqZ
         wy5NAWds7n9lYouOiGH/c+5SsqQm74tRNiwQR1eHi1A5miqa2zmKYKiaGlTJj4muVfla
         lz4yQHaXA1jiBQahcJPij6o6P+ri0CDslm21w=
Received: by 10.115.100.23 with SMTP id c23mr9382702wam.9.1250776052546;
        Thu, 20 Aug 2009 06:47:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 22sm186432pzk.14.2009.08.20.06.47.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:47:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:26 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126623>

Commit 06aaaa0bf70fe37d198893f4e25fa73b6516f8a9 may step index format
version up and down, depends on whether extended flags present in the
index. This adds a test to check for index format version.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore           |    1 +
 Makefile             |    1 +
 test-index-version.c |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 test-index-version.c

diff --git a/.gitignore b/.gitignore
index c446290..01753f8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -157,6 +157,7 @@ test-date
 test-delta
 test-dump-cache-tree
 test-genrandom
+test-index-version
 test-match-trees
 test-parse-options
 test-path-utils
diff --git a/Makefile b/Makefile
index 4190a5d..f49435a 100644
--- a/Makefile
+++ b/Makefile
@@ -1586,6 +1586,7 @@ TEST_PROGRAMS +=3D test-parse-options$X
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
1.6.3.GIT
