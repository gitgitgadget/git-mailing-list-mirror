From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/3] Introduce a null_oid constant.
Date: Sun, 13 Dec 2015 17:27:16 +0000
Message-ID: <1450027638-788102-2-git-send-email-sandals@crustytoothpaste.net>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 18:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ARP-0000Gh-Di
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 18:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbbLMR11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 12:27:27 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44768 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750822AbbLMR10 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2015 12:27:26 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6E75E282CB;
	Sun, 13 Dec 2015 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450027644;
	bh=SNdocudNXaftScLyNpkZWyi7bVw7IcN5q7LoE7QGQB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z80DF0OGJNk/lB1eIU/yxOhUv/VJrUde423aD4uGiGfpcpGVFVjON+fB1c3dMXnf5
	 T8F1P7cOXxff95to74pbSdeQM6heIm+wR4g9Bqs2+whrtZbWLbUkVLFgjBtKOBoyL0
	 rvnI5kVzYm4ZlPvhi+83BCMIuXMb5VOtovjYPUMht2cV1Ms5vg6LebFcLToewDOO1P
	 hjnB5cIR3l6h+SGY6eQP8dXfmRvPY7dePnpvFrL/4XDTEN7fj3mOvibii/h+V3qnUW
	 sJUixayU5/UQ9+ZejyQhA6XV0QAogYQc0gU186/2NwZNp5gARfM1g2xqDSmboZFdFN
	 4Jux52vZjW7M0Z/uIhuj7StaCoCHf+k+cCFCkxdf7Q2f1zGQdIXG21qabfHsAt4VrD
	 sNyFQGZUR8Kd6fMdc3e9UZxUOWbJgRYmLzecZ+JRWTjHeqriAHJMrR8yXMDRZw6++W
	 TH6R22phKdZ6LpPGvyAHPqTXI+RRVR1xAaTyflfQAcnrHZOm3Ce
X-Mailer: git-send-email 2.7.0.rc0.173.g4a846af
In-Reply-To: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282334>

null_oid is the struct object_id equivalent to null_sha1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 1 +
 sha1_file.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cache.h b/cache.h
index 5ab6cb50..c63fcc11 100644
--- a/cache.h
+++ b/cache.h
@@ -831,6 +831,7 @@ extern const char *find_unique_abbrev(const unsigned char *sha1, int len);
 extern int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len);
 
 extern const unsigned char null_sha1[GIT_SHA1_RAWSZ];
+extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 27ce7b70..a54deb05 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -36,6 +36,7 @@
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
+const struct object_id null_oid;
 
 /*
  * This is meant to hold a *small* number of objects that you would
