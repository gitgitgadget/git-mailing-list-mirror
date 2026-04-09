Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CA395D9F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774678; cv=none; b=j45WW8H4ZfAe2RFG0uh6CVI/t+S18n1Hi0zFi5G+I5MqHuZS4HYZMP11BkruMfcT/oCdBK5h2I3s63XjahkFHfdf6pQUz6pCR27VsjsgH1DXOZXXpHsL9iBGwkWDplRITyGnbs3yH4ayEzjV3I5WqKSidzvBoH0upngiVtpOegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774678; c=relaxed/simple;
	bh=uof5NXHfYlbZGdNi8ldfg9xjmVLC5Auxx3ouo/3MHJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWwGhOiUWNnS3X2CFIOJpm5fpRJrBTniBi04Ami221rj36P8ehmFD00aBQakDbIB7lbRDCVp3yWBzh/vabMCMp3A+ANduaHwofx6UktPo4kBT7sOX5kp0OhAYJScGXzD+LZ/ARf74RPbgH9BQ3x/S076U77IZloyynPGmyc5MAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oU9qRMdc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oU9qRMdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775774676;
	bh=uof5NXHfYlbZGdNi8ldfg9xjmVLC5Auxx3ouo/3MHJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=oU9qRMdcEFCLmyYtVtlHzQUTdJ8yISY4sewZP4mHb3G5cHB0fkCTbWFir7rvvBkc3
	 wzUqVy8g43aCzX6DInDq/MCo5gzA+Wn9Y7+Ms+Sxd5zgnnQFx8MPjU8WSYMSXPALfj
	 WEFqEg+5hsgV+oY0yhXdX4HfK8mIXP4N9wBrpNz4blZ10U6VTukNi6Cq2lvMGbNhUY
	 DUYcn+1/gdQsTS88MH9RSKd6IXiAsijg6UQa+T+N3zKbsYd/fX127f/8f+T+epar/1
	 s/iQ8BoL3sazUZXxPKOEm8MBtKHpk859o45n1CfgRoMLsEfs89jzaCKH0GkL7B+nOq
	 UjFPVo5Ilmx+/E4etgv6LmHYoSCYYoqh8aGlv36UxnoTS0fMXhvcA+eVLQhkXWevLj
	 BffhI7fqf9mgKy7/tABXdxRMkyrQ/M2tfE64cG1QhhgqyT6la9Gh9/X8SFU5NGck7R
	 t0c47f2vIbzfGBB6n50SJ8H1Y0oRhZSIfH9XWs4vfa/NEiFJQLy
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:fec4:70ef:431f:d174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 429C720144;
	Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 1/4] docs: update version with default Rust support
Date: Thu,  9 Apr 2026 22:44:31 +0000
Message-ID: <20260409224434.1861422-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
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
