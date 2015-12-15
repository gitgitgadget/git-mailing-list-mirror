From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/3] Introduce a null_oid constant.
Date: Tue, 15 Dec 2015 01:52:03 +0000
Message-ID: <1450144325-182108-2-git-send-email-sandals@crustytoothpaste.net>
References: <1450144325-182108-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 02:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8emn-00008k-HP
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 02:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbbLOBwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 20:52:14 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47200 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932695AbbLOBwM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 20:52:12 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 65493282CB;
	Tue, 15 Dec 2015 01:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450144331;
	bh=mGSm2kCtSKCpdSxcWdo82EM6xNSlLqQrqB1tGGFbsUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXHHvS3ZEzb4DI/Zy7Lo3GJmcsAHYtf9Nrq/NLHGp/nQB67b4JcWjpGohqL4dRKYb
	 Y+kHq57EztiK6gFh30KTutUf82q6ShGM1u80vkadUbfzIAkY8dEsv9z5m9XneZePlj
	 2U7rBvL+jwob3RMp2xBFTQvqLRJqoT0J3Fdtg9+oBF5bQ9mAXOa5lUr3/H4cXtMS+E
	 Sm2/UYhbc9MlwNqsL7MkzIydQm4d5sOb4JvesZvoqX9yunWhDUM62ruGIvERah12/R
	 sKIHAbokq0uMunuSxju/qVzPGNLUSZCJ+zAB7/WE4vAvFulbz5bQqa/0vmMjrbo47p
	 tb0MNm+9+DreSqx/J6i7IXSkaeGyWYo8zEaH8KJc8TqbDiYxKhfe2+IW+FcJs7PdzD
	 A4wwQvVz4ld0alH8uKczL/3i+FHouERki9txJ6rDxTE1yfDVVYiQP8ITkKQY6uxHPW
	 aNfHGPsxTz7n2fce0jtZNt5TqVv5Y7xE3rVLNa0v1+MbON2hA+Y
X-Mailer: git-send-email 2.7.0.rc0.173.g4a846af
In-Reply-To: <1450144325-182108-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282461>

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
2.7.0.rc0.194.g1187e4e.dirty
