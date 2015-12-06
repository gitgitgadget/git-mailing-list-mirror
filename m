From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] Introduce a null_oid constant.
Date: Sun,  6 Dec 2015 22:16:35 +0000
Message-ID: <1449440196-991107-2-git-send-email-sandals@crustytoothpaste.net>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 23:17:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5hc8-0005Lt-1z
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 23:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbbLFWQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 17:16:59 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60830 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754481AbbLFWQy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 17:16:54 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B6AF32808D;
	Sun,  6 Dec 2015 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449440212;
	bh=9Jp1lZJAvz8LA6Jn9gdIQfTUQW4e77rvxUGwElASv+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GG0LjDk3fU1iTnk5XcE1nmKJ3MfGUUdLBOUHPkKjfKLHwLoIGNpM6uzog6tLYXmWP
	 CrDhImdMNGWW42LVaQXe4Qzp6Ns7iT8rPIBEyz+wvZ2/5AL1oKqoZ6EgPmnkGychO0
	 l2EKNACME5/IxeJC+prYSRWd5HZFqpxIWiMPDH7SE0HnjvbKUgoeHDBLTFXdf++hMQ
	 pYAp9WaWNQNJ71agnKt62dAd0kxFoWX7uIyTt6a5FNxQd8Anu3kGGlZc/dAnr2XWvV
	 qmyGzOL29c5Jvp1ABQXf83ieMlmLnPd+CW2xOqjBU3qNEkxUmna79iAvEs9LPDIMit
	 UVphVcvka1lDAqdQArQkB1gfC/mSvyWIfMXxymeDVSvDbSBvukt15sAbi0/KN0Jtrq
	 nuK8Xp/zKIoULaWkfxc3HfUDwq32Ojus2t0yTfXr22g+agIhsIXAJDZsicE4KtIEJq
	 V/06MFQMxCnnc5XaQFaTv8u31Kfo0rnERYQvYvXmhtaLdKpq6ja
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282068>

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
-- 
2.6.3.658.g85d7f57
