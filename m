Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396670;
	b=y4MNXaK3AXGvQGRaDdlJ2+uxrLSxBieGIwu37Gdoh/sFK3oCJ/O8EK5APpMD+PSuPurV
	 2Y7TEmKiqwUfTY+os9KeE4L9N8jOilBAByz3dBtgwUD5uH/1NAOzVtH1je7GXi9b0su+6
	 fjAGp3eYX6XRvzLXGvpoQlAIbW8Y3+y9tdBbDhxjw+hB/bPh4y7msK0s3pzKu75bXNcUf
	 sTHBX+y/MCGxm9Rt/NxMzafkLLBGaY6uJCBf+EimB2rbJJclLrhZsgrEZ9uOdxtysR+u6
	 WvE9MZbtQw+R1B3s37OznxRmUkE/Bg8ozFe4We+B351EPhJ2Zm/1Dmh6smgfdEId/VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396670;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RcdS02zp3/YRjCF6c8Yp3K43fQ5EDp/T3pW5in9iuWQ=;
	b=DHmiAEXEOcLhk4aHy5EPpPpq6nXex9Gh7xCKKsFI82vUQZB+u7MNWn4Er1XJ6AzTrbjo
	 Z+Evy3jWN2Cxo0R2WRGpCEJ/0X6YkOKEDEQouWVccp2dfIiD7TUXHLr0SEvv/7NgykkD+
	 oPhgBpW0e9s/uwYdKfR2iw3OVtB0gGlPbxYxHxedVxEFUuw48cCxTGJ223As6iExQP2pc
	 z4tZLzEUErm+9zVC9NbaOSQHGWxLijnTCnkggtaMHfln93NiGJi+Pqv8ZzfN3owH/5Vok
	 UKKSmySwvKLspbvzO98q9eN2CsV/h3hfqW0hmcKko1VCTntavqwglOFfvDq7tqCHd7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=A5Gej2NZ;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0CB606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 01:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=A5Gej2NZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795396668;
	bh=SCfkUFrapIIMK/uRYgtLi5GZ3GpBCnlBJDzqLVxrqK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=A5Gej2NZ2+KnMpHa4TfZ4LWYdxbsMO4mFMqWK4NRfE2m9dMI8mzNZDncqi8SqtelJ
	 5a+DMyRuB+NzJY+t8Sb0kpnNk3INiScQgyiAjkPqh1Z2QMqx2682/ahF+YV5Rt6/+W
	 Xu+2xn67e7DPP90qe7B4dFfGwgSoKAFG4ir3lyWQeL9zachTWI+1XrEGdLMfSsxvgF
	 jyIYKflzVD5DMLl7LGNIf1U2OqYsD2P1vNknBc8wRceHmxEGhGD/jse1DaIWVXuby2
	 02ckCged1SGr+x96geW4svlQflv1GqN6SpUN7JbvxbJykpFHmP0mKOFjlJm/HiWZQ6
	 UE0prXqB2A+1OaJv5xzNk8nSbuNRyaomtagF+BaKaQCGIHuH8gwmZlameQzIILSnxQ
	 9hkh9oy3osieQNneE+nrEMFrwsGvx3ym6a7SvVZqkiFCCTDRsBmrT66dP/jbzvSkQ/
	 H7kZy8py15NGUFFqKWw2AwRoGyg5389g8qbjwm5Loq/b8BJ+rVX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d948:43c9:4db6:a02a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BC866200AA;
	Mon, 23 Nov 2026 01:17:48 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] docs: indicate clearly that http.extraheader is not for creds
Date: Mon, 23 Nov 2026 01:17:44 +0000
Message-ID: <20261123011744.723147-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20261121222723.23714-1-sandals@crustytoothpaste.net>
References: <20261121222723.23714-1-sandals@crustytoothpaste.net>
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
Changes since v1:
* Include missing word.

 Documentation/config/http.adoc | 8 ++++++++
 Documentation/git.adoc         | 7 +++----
 Documentation/gitfaq.adoc      | 3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..d61180c909 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -111,6 +111,14 @@ http.extraHeader::
 	more than one such entry exists, all of them are added as extra
 	headers.  To allow overriding the settings inherited from the system
 	config, an empty value will reset the extra headers to the empty list.
++
+Note that this option should not be used to pass credentials and using it for
+that purpose may cause security issues.  Using this option for the
+Authorization header can also break some external tools.
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
