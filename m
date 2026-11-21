Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300052;
	b=wCXlzp9jDm5r9amXUbr2pOixRkPSJzVQXZ6BOAnoGp6tVGP7s4GEFBxY0sri/ESUfKV2
	 PvxHzJOC/v5jEiNlpb3nxsYTszH65wwvMg/MZURdlRnEusVFXflso/gtyNM7jC0/RsqRR
	 NY8JMsXxsTJZprfnMMVoqi0A3br+/8v6OkUx4zcxCJOJXkOgCGMHKBjX0kBie0KpwLped
	 ilO9XRMOHAmJhyfXwHpnZvC9bpjzSJkj9Ax4gm4nkfx49lAF3ypMwqzgRowCnM8OkjQQ/
	 cKvNcLE2egg3klv3eQuBYSXA0OkA3fVV8Wknt1uB9WIGtC1KMbVLCZUO+sLx8Q/o58Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300052;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5V6P/THnuzSbzvf01N45mYVIuvLpBVRxaZMPnMRv0GA=;
	b=lbcwTYHZSGW//6+006zvF5zo/GV4PkKZdnOsphG7uwZYabNvUEY1wMJ2tZyPm66ijZ0a
	 IDswUSE5Ecdji1lxbAoRvMuG1EeQLDKjuUZ7Nkx6wmlksB4cc1kQuzjTsTpxNBaguJbow
	 bpd+HYqYb3gVwwhq7I9FXc06THULeqYDettzL52HhoAPvaRJwy2nKiSLKoufvj/1jHMXG
	 WPW/oIjIRwLeTEPheQkr1oIM7fMHYl5QjuDepgPRJ2B/h1YXpmrqZobLUTdSVL0AJTfzX
	 yl4pTR8yge8VhtTjolefBSpVHJKSHmfTqf7ZaOetauVA4CzN7owB0NRSCFcsgb+YJbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=cIpGPCa2;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53925606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 22:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53925606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=cIpGPCa2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795300044;
	bh=IbRshyIMa/Z/NP0oAne1isFJ8F/l6O/AqAtNUYIHpeg=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cIpGPCa2jHqE+08fe2vYmMaT0jjEm1bKlgNwGfE01kmLCSTo7+eByQlQOx5dwyRqD
	 DEED/oakXx8qygQTyOJQ9MV8hSQocSltwxBWu+DF38XxzmMfZjzLTMLQGy+NOBF2G0
	 szzFYujE+HVChVW8IUMb2IgASuPWwhMrQ6gDSfvGqKBw6+9QWZeE4oJDk6pq74pCKu
	 NBYmhVHZpMwD6N0IuQNz9E25ZaT5S3MBO83d/niTTCgfV57lXG+v8x60r0qBuSCLxy
	 aJJKDONGSIFmKWdOc68VKpl0YlhGYvJbSfac8bT7OqBRm525TokaKX4dpwFkrNFR10
	 RYX1YiNwYv8TGbh9VYFlI3zI/CvkhM3EERkOKnHXu5zSZ/yPE6zXyPiMOfTb9b1dWH
	 n/WnmBncY2GNLsE5N1wjF3/SjmrX+U7xRm1/PbA+J9c45EQor6bNtqNKksQYEZxO1u
	 aG3djFFlMKkaMHNkuXbPLVc+HH3ZgR+qjNNc3BMvEHsvn7rzyPn
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb0d:bc2d:c7b5:8175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B64C3200AA;
	Sat, 21 Nov 2026 22:27:24 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] docs: indicate clearly that http.extraheader is not for creds
Date: Sat, 21 Nov 2026 22:27:23 +0000
Message-ID: <20261121222723.23714-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People frequently use http.extraheader for credentials, but it is not
intended for that and is easy to misuse.  People using it for
credentials often do not use the URL-qualified option, exposing their
credentials to every server Git connects to, or they specify it on the
command line or in the config file, potentially exposing it to other
users or to anyone who accesses the repo, respectively.

It's also known that using http.extraheader for the Authorization header
breaks some uses of Git LFS, where some parts of the protocol can
include their own Authorization header.  This is because that tool does
as Git does and always adds the header, leaving two Authorization
headers which breaks authentication.  However, using a credential helper
works fine, since Git LFS only calls the credential helper if it doesn't
have credentials.

Indicate clearly that http.extraheader should not be used for
credentials now that we have more robust credential helper support.
Remove text that suggests it might have sensitive information in it,
since it should not.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/http.adoc | 8 ++++++++
 Documentation/git.adoc         | 7 +++----
 Documentation/gitfaq.adoc      | 3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..a8bd957585 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -111,6 +111,14 @@ http.extraHeader::
 	more than one such entry exists, all of them are added as extra
 	headers.  To allow overriding the settings inherited from the system
 	config, an empty value will reset the extra headers to the empty list.
++
+Note that this option should not be to pass credentials and using it for that
+purpose may cause security issues.  Using this option for the Authorization
+header can also break some external tools.
++
+A credential helper is almost always more secure and does not impact external
+tools negatively; note that modern credential helpers can implement any
+reasonable method of authentication, including Bearer.
 
 http.cookieFile::
 	The pathname of a file containing previously stored cookie lines,
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 1aa0608bae..d2f56e2f91 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -104,10 +104,9 @@ where other processes might be able to read your command line
 (e.g. `/proc/self/environ`). That behavior is the default on
 Linux, but may not be on your system.
 +
-Note that this might add security for variables such as
-`http.extraHeader` where the sensitive information is part of
-the value, but not e.g. `url.<base>.insteadOf` where the
-sensitive information can be part of the key.
+Note that this might add security for variables where the sensitive
+information is part of the value, but not e.g. `url.<base>.insteadOf`
+where the sensitive information can be part of the key.
 
 --exec-path[=<path>]::
 	Path to wherever your core Git programs are installed.
diff --git a/Documentation/gitfaq.adoc b/Documentation/gitfaq.adoc
index b26e4e3a09..5bc33f7e26 100644
--- a/Documentation/gitfaq.adoc
+++ b/Documentation/gitfaq.adoc
@@ -120,7 +120,8 @@ them for a certain period of time.
 You can also just enter your password when prompted.  While it is possible to
 place the password (which must be percent-encoded) in the URL, this is not
 particularly secure and can lead to accidental exposure of credentials, so it is
-not recommended.
+not recommended.  For similar reasons, we don't recommend using the
+`http.extraheader` option for credentials, either.
 
 [[http-credentials-environment]]
 How do I read a password or token from an environment variable?::
