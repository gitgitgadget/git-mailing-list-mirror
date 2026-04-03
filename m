Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FD1BBBE5
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179046; cv=none; b=Qc/ghopgPgAblZnX83tgAlBVVglePU7tF/yF6omrFEqx55gOQqOSgrB42/G/yngYb2gcfUU5kBAwgcdCzmwP5in3qE8kgOQrP5pYKwKWFZjxm+dYnrzo4JAERwoXHV5JC8sxYyYo7S2cKqe9UaAYmN3+sb3EOClG7E69MBQFnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179046; c=relaxed/simple;
	bh=uof5NXHfYlbZGdNi8ldfg9xjmVLC5Auxx3ouo/3MHJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOQYY/1k8Qg/yB65NJkXyPajXJhNiiBJVfaRCXs2cg0FraSYTelqWU97UaM9U/Q9ePWtnEkUtry0BT7WuebzNIQYCt8XirudJZNE/rEKqlu6cOHfY+JPgbSCoFcAtwgiUl/NW+EBxmLfEvgiieqjPGaspvxg8giDiAOl2MsG6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fXb5Z6lo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fXb5Z6lo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775179042;
	bh=uof5NXHfYlbZGdNi8ldfg9xjmVLC5Auxx3ouo/3MHJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=fXb5Z6lojONPanRzbf44qALXiiPkVv8f5/X7uJo2dnpRuaTp/sd+kaoPU+3o32KUk
	 Hn3iH6HFVuAoqzIN5KDDgbb1/MO6BHom0HYjTjReaJHrTYS8nLChZRifQxrQPGVm2t
	 2PwsOhSjetSqujc4bWOxLOLDdO+/ji4cv9nxmtTzQVp3PCxiKanLctp28moOwEhbXj
	 TvKvogIdVCNZxgLRr/+mOICLM5UY5ZdqnJBgNZJ48pRQy7N0qwRLAdsYvMQmg5npFd
	 WtyddyBuRv7fIEE2F0fgz4GI3MuCJ/BnEXKMImOSWaIl3bIe66BiSBnUrEjDnMHMdD
	 D13eclmyILTU6I/G3HOGMHSBbtI2fTekhtJaa/nogmYT573yg477l3Az+LkC5MY/Qc
	 ik1HlL/xNmPsaqsuINC+vi1OLFUeYYnAruZFZN13DAXHJCWCnqmzz+Mz+/Lg/zjW1o
	 Ste27NEcCi+ZO+psoMyyW1c4xdf3ZDi8e3EwIBlYHJzrAKVjTPr
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4fc4:8150:dc47:49e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C548320126;
	Fri,  3 Apr 2026 01:17:22 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 1/4] docs: update version with default Rust support
Date: Fri,  3 Apr 2026 01:12:46 +0000
Message-ID: <20260403011249.4133372-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We missed the cut-off for Rust by default in 2.53, but we still can
enable it by default for 2.54, so update our breaking changes document
accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f814450d2f..510ed98b65 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -190,7 +190,7 @@ milestones for the introduction of Rust:
 1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
    disabled in our Makefile so that the project can sort out the initial
    infrastructure.
-2. In Git 2.53, both build systems will default-enable support for Rust.
+2. In Git 2.54, both build systems will default-enable support for Rust.
    Consequently, builds will break by default if Rust is not available on the
    build host. The use of Rust can still be explicitly disabled via build
    flags.
