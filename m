Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DC222565
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826996; cv=pass; b=VPg/1Th6E4EiSRrxGxF763CQzlCwL3zRHRWJs+SmDNnIErHRsAK3m1/z9ZMQRu6gx64lJLWPNz9bBNr8LcZWWb+a4h9gNy/i1pn/zCgqzByo5zyLhEIIw/Za9Zt6UOvKg217hU/knrLq6N6TKZi3QjsEPC6WFYVhFqE/n5lNEGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826996; c=relaxed/simple;
	bh=Dsp10BViORKUocAaol8JwCYHBjkMiWZMLR8mm+JeWEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+D2pJ80aTbXwy2FpvdP8r4xkJZiUS61zkcqigoA4M+F2Ll/bnYKhqs5yYgxL3aDxLs1QzN4zwztiUkepKCZX2ckXGu67U0jxnfr5ifsloRDj8fnx6Ulvub4cLk8XQjfb2sTKNfpcD1GxBJGrCZ99PjTgVT0SqhJygc23T6pzmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Q2r/+UDE; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Q2r/+UDE"
ARC-Seal: i=1; a=rsa-sha256; t=1767826980; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T2FT+Cy54USzCz+Ozix/RxNdE57XgvmKEoybrqJnVtMXR1uWc/+Pt3RU33vgTgpOMrtw5syyyn3dXdysPBx3itHChjg3bqPB7EQ9AFRPXpYlN1OfBlmC//qJLL6kTwbWJ46ptVd3SPy1nyjjgL321vreKKE9VjvoD9ErP12Gw2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826980; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6tL2I7roLPNU+zsghwkt1hlH4utinv4q5aG2Oe5MF+k=; 
	b=ctWO7/smxXIlhWGQZyEQkEsJVFfCCCkp3QtJp9vt7tH5EMsp1goWV4ir91ZH6zX/jn1+dANSw6gEEZAepN8YMvb/60oCsjARlU4dKTrg3pU8B40+R/lkd2VCWpWEhznSMrByYDUwh7cBSrbQZ4UIaqR+M5c36lafAOdlHYkEb8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826980;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6tL2I7roLPNU+zsghwkt1hlH4utinv4q5aG2Oe5MF+k=;
	b=Q2r/+UDECjv58xaYFMLwLljWYXIDr8Yf0KBCZXjSRAmyOY+fxV8ZGV/AEOhkp68F
	fIEMYJMez0p+Hh8zI/VRO9P6yyokm/C3Z/d6sPXGBTT/WxY8aI/kYEnuTn7bW3caKCp
	02urJZAo1PBNsEv+ArMlwZOVwqG0jtiqhZeZVWhM=
Received: by mx.zohomail.com with SMTPS id 1767826979756335.5949673555655;
	Wed, 7 Jan 2026 15:02:59 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 07/11] builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
Date: Thu,  8 Jan 2026 01:01:41 +0200
Message-ID: <20260107230145.517562-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107230145.517562-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

is_rfc3986_unreserved() was moved to credential-store.c and was made
static by f89854362c (credential-store: move related functions to
credential-store file, 2023-06-06) under a correct assumption, at the
time, that it was the only place using it.

However now we need it to apply URL-encoding to submodule names when
constructing gitdir paths, to avoid conflicts, so bring it back as a
public function exposed via url.h, instead of the old helper path
(strbuf), which has nothing to do with 3986 encoding/decoding anymore.

This function will be used in subsequent commits which do the encoding.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/credential-store.c | 7 +------
 url.c                      | 6 ++++++
 url.h                      | 7 +++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index b74e06cc93..bc1453c6b2 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -7,6 +7,7 @@
 #include "path.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "url.h"
 #include "write-or-die.h"
 
 static struct lock_file credential_lock;
@@ -76,12 +77,6 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to write credential store");
 }
 
-static int is_rfc3986_unreserved(char ch)
-{
-	return isalnum(ch) ||
-		ch == '-' || ch == '_' || ch == '.' || ch == '~';
-}
-
 static int is_rfc3986_reserved_or_unreserved(char ch)
 {
 	if (is_rfc3986_unreserved(ch))
diff --git a/url.c b/url.c
index 282b12495a..adc289229c 100644
--- a/url.c
+++ b/url.c
@@ -3,6 +3,12 @@
 #include "strbuf.h"
 #include "url.h"
 
+int is_rfc3986_unreserved(char ch)
+{
+	return isalnum(ch) ||
+		ch == '-' || ch == '_' || ch == '.' || ch == '~';
+}
+
 int is_urlschemechar(int first_flag, int ch)
 {
 	/*
diff --git a/url.h b/url.h
index 2a27c34277..e644c3c809 100644
--- a/url.h
+++ b/url.h
@@ -21,4 +21,11 @@ char *url_decode_parameter_value(const char **query);
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
+/*
+ * The set of unreserved characters as per STD66 (RFC3986) is
+ * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
+ * components without percent-encoding.
+ */
+int is_rfc3986_unreserved(char ch);
+
 #endif /* URL_H */
-- 
2.51.2

