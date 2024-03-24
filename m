Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A263B
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242798; cv=none; b=OOe7xgIOC90qTj2y/toa1x7rrZ6S7ccCh5LmTKfEWTZUVV1O8/pWZ7ZqLDGNzPyBuLt6qflXrV4ZNKzdhza7ZyCUQVQamEt4iaa3NV8CxyIv/eWewkDqYQOMIY1wrIRLA3+QRxOfDlSDSiwOZlZPCFELnom00Fy2KZu/rfzx+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242798; c=relaxed/simple;
	bh=7Ulw9Q79yAh4T6HWJyFx3Sz5OWBYpwI8IR1SDRUOcvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDUdgLJ5R5HX15PpgEOHdIySqFc2/BvavTdyTes0vD3gdKVVhusTvrfMxU2r9Oxg4oFTqPOzloXVKL+4XqDbkjWfihHKgdXSF4uiIKsMVGrg+ZtANSi8TBqq2U2BbHCcTcC52bH3+kJPVvWUL5NZPnGstr49LyVVGTviAjhO6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mUTnGNgh; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mUTnGNgh"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0F5F25D40F;
	Sun, 24 Mar 2024 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242786;
	bh=7Ulw9Q79yAh4T6HWJyFx3Sz5OWBYpwI8IR1SDRUOcvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=mUTnGNghL9DpCdo03OYzb2KL2vfO5C+D4kR0Dze1iJvktYm4XkESWYKKz7AA0Z5D3
	 CMBwMCNCyxCcy0HW/qS3VcO78zCStMZBOJWE8M99PvsJR66YiLZMH3mPXaBT7vW9Pj
	 oZPYT8BSase8SaO4UJr94101xC3JaUxzAwYvGqz/kCTFnSGCkHLktfqZyoHE6N8ssa
	 VN9n3ZzMU9ZimMjfZzX36JTZcYsvzOR5jIva3igOq5CWIsLw7Vuyy2eDOD6DXcMRx2
	 xsVgESkh7l3Cz/4sl5JHnstWvnr2HH7zdG+m+9u19ei8M+E/glaYE6WmnYZ4bgCv1n
	 NCTCCSFFSrX+e7POzlFZnWQdByK8qqgjF+FJGJ2vYi9ZSXj2jcw3FX41EKZct/8Z8r
	 ivXs/OdUnLzWygt7KyYMMeS9H0GWj2gWXSqydUCM8jYRKbc06JbBQpwPo+E+TfX1kj
	 i3XNAQZ2J+mvzpidSAcZbhzrHqY1jW+mqeadJi70Ys8BK7bnaG8
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 06/13] docs: indicate new credential protocol fields
Date: Sun, 24 Mar 2024 01:12:54 +0000
Message-ID: <20240324011301.1553072-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have new fields (authtype and credential), let's document
them for users and credential helper implementers.

Indicate specifically what common values of authtype are and what values
are allowed.  Note that, while common, digest and NTLM authentication
are insecure because they require unsalted, uniterated password hashes
to be stored.

Tell users that they can continue to use a username and password even if
the new capability is supported.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-credential.txt | 34 +++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 918a0aa42b..f3ed3a82fa 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -178,6 +178,24 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`authtype`::
+	This indicates that the authentication scheme in question should be used.
+	Common values for HTTP and HTTPS include `basic`, `digest`, and `ntlm`,
+	although the latter two are insecure and should not be used.  If `credential`
+	is used, this may be set to an arbitrary string suitable for the protocol in
+	question (usually HTTP).
++
+This value should not be sent unless the appropriate capability (see below) is
+provided on input.
+
+`credential`::
+	The pre-encoded credential, suitable for the protocol in question (usually
+	HTTP).  If this key is sent, `authtype` is mandatory, and `username` and
+	`password` are not used.
++
+This value should not be sent unless the appropriate capability (see below) is
+provided on input.
+
 `wwwauth[]`::
 
 	When an HTTP response is received by Git that includes one or more
@@ -189,7 +207,21 @@ attribute 'wwwauth[]', where the order of the attributes is the same as
 they appear in the HTTP response. This attribute is 'one-way' from Git
 to pass additional information to credential helpers.
 
-Unrecognised attributes are silently discarded.
+`capability[]`::
+	This signals that the caller supports the capability in question.
+	This can be used to provide better, more specific data as part of the
+	protocol.
++
+The only capability currently supported is `authtype`, which indicates that the
+`authtype` and `credential` values are understood.  It is not obligatory to use
+these values in such a case, but they should not be provided without this
+capability.
++
+Callers of `git credential` and credential helpers should emit the
+capabilities they support unconditionally, and Git will gracefully
+handle passing them on.
+
+Unrecognised attributes and capabilities are silently discarded.
 
 GIT
 ---
