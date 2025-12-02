Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B8190664
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639980; cv=none; b=CUwHNzWX0zv1pNsqADRQ3t9WJfUD4IdOwvxu47Vib3tCmXTMyZi6+Dr4THKLvjc8niEwAF23Z8ZcGj8c+suI28WCb953eFFrJPbPi1Z3gMPU9YLo2/gGqXNOHorKsNSo3OOfPd7HbL2a/qk3JAYYRa2yNsZwTxZ4oTYmqlgZ1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639980; c=relaxed/simple;
	bh=NxL+5hre2/uA/T+1g2K0oEIoKWFxsM3TlMV1XhJGfhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPZcGZqw7glAOruXP6CiXjTmiQnntkvj6a0kHIbZpLSDfaO+2VgZB5ASyzeyxeQXQLcGLL1Yl06ZIcsM9tyTUVapiH8PWqjLt53C3fjtqgc2IiQNvRNNEf7IwRNeKypaEsAvdoviDfmY4UbLWKNnX4RjgsYrhN9utlZbaTXbT04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=g+iqcQPO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g+iqcQPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764639969;
	bh=NxL+5hre2/uA/T+1g2K0oEIoKWFxsM3TlMV1XhJGfhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=g+iqcQPO9yO2hlMGTvZ6W5W56ajuhAidUy9PUK7TcH3wN9+icR0FUvFrVgpJ2JZ10
	 jgMRPCM761X8Lu0Hm9u0n+ch7gy7zi6S8J3aXjPxGlmgQEbqMwJnJ9HxyjykMEbsm0
	 hbndFlnqw6KNHWrMZgEl7zl+g5l7Wa1iFPXs6sijS1kQxQSIyl0rXrvwEuQbqwHk5m
	 6Gw+H5DiOZxmUFglvzCvf1dvxvqjtH/KARBxuObV2hLWUoJ3bRwu5CKQT9Kc+zccf0
	 kUeZyiLlblpsDL+liNv5megTQ/EzUdVpqDtnREzDhM7sWVx1zl4wByfvilI1H0585R
	 RzJsU0i28tpIyPZ0+svb1jb0l7hGCQQCpIfSzM9mjXSbBEfR5gHcXJ/VyoZ9whqiGC
	 bzr1BZ7LlOTQVJDDO7zShwv1SgDTHGVLNedofoPZ2PIo1yz3lUhoUJKCBeeAeb9Y7b
	 hAnPqgTtpWjoAb8lir5KNtV4GIjcPDROCNm7mWzHI3bT74hc6Aj
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb0a:dd97:4aaa:b0f9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C14212551D;
	Tue,  2 Dec 2025 01:46:09 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/4] docs: update index-pack hash algorithm for breaking changes mode
Date: Tue,  2 Dec 2025 01:46:03 +0000
Message-ID: <20251202014605.52110-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251202014605.52110-1-sandals@crustytoothpaste.net>
References: <20251202014605.52110-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiled with WITH_BREAKING_CHANGES, the default hash algorithm
switches to SHA-256, but the documentation doesn't reflect this.  Update
the index-pack manual page to reflect the correct algorithm in this
case.

Be sure to conditionalize only full sentences to aid in localization.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-index-pack.adoc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.adoc b/Documentation/git-index-pack.adoc
index 18036953c0..8f05f5494d 100644
--- a/Documentation/git-index-pack.adoc
+++ b/Documentation/git-index-pack.adoc
@@ -125,9 +125,17 @@ information on the possible values of `<msg-id>` and `<severity>`.
 
 --object-format=<hash-algorithm>::
 	Specify the given object format (hash algorithm) for the pack.  The valid
-	values are 'sha1' and (if enabled) 'sha256'.  The default is the algorithm for
-	the current repository (set by `extensions.objectFormat`), or 'sha1' if no
-	value is set or outside a repository.
+	values are 'sha1' and (if enabled) 'sha256'.
+ifndef::with-breaking-changes[]
+	The default is the algorithm for the current repository (set by
+	`extensions.objectFormat`), or 'sha1' if no value is set or outside a
+	repository.
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+	The default is the algorithm for the current repository (set by
+	`extensions.objectFormat`), or 'sha256' if no value is set or outside a
+	repository.
+endif::with-breaking-changes[]
 +
 This option cannot be used with --stdin.
 +
