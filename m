Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755A25634
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644370; cv=none; b=AmV0v9EW5xcsIT25SKxr0nbGcQRtN/Ajy4WakvFdsm7QgVwJ/YVLG7RNmL1lcqWvkCDUWMQmIpRoL23S11DSJFIZTkbA3EVA8x9NXMalfxc5eupz4LYINiWhPwCAMpQlzyPkfPx1GNDvRFYHBi3Oz9VX3gNEhdWlfjhgUcZQFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644370; c=relaxed/simple;
	bh=u9igHWBuSr2c88DQ0ItXsvOXaMorSxMBiSW3OfzCajQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHBnZ9YLv9f7XUriYrUyvBrq4D2IhZciAvXUlEmbVlJaryhXSPBdeUXsYAHy0zsbAcigNAKUrXuOVN5DD6tQ0TKC8CndL91UCSF5JZC2WVGIk0wFN/ezT2xNW0tmZ9k2uekqBBwA5dHgwICmsPDXnkhmzGzMmIbeNqKmbEtYFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uDXMa1Vm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uDXMa1Vm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=u9igHWBuSr2c88DQ0ItXsvOXaMorSxMBiSW3OfzCajQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=uDXMa1VmKSxRwYd40u0Uo5lHZ1vXR4CPVvR/8qozQhOvp30nD5SOy6mPX0WOH3eis
	 Kj0pbnLhoelfT+WGEAfqmebxVlUwa+9UxhNs4o96aNyG0xpAFUJivfHtuBLyKe6ohC
	 iUFHCNPLlLKeDozUSvr9miVZsPuPyoOPG3HIvLzj+WwJfE3vzsuo1IDgYr64GKnnIq
	 eGG7myKTz8bjjkJCR6Us/Sa1xTLFt5GIHQRPngw6p7++ZfStuJXx9CITca7kkyR0vs
	 5/10pn1PCGhf14vLkX9RoMDCTvJsKQk9CHebqB19tlrt2p+YMsuEFWmOg/Dz+hYGJy
	 Ii61f22h9/7TQvu/MqPwnCfQn/GBprXTkvUTRdcrs3uVWiNiqgLBjmepvsAx3t33N9
	 NmpTcOIcsG8a6UiCasKwx1y+olcQn9lOg7z42bcByQuWQRXZLkf3sBmaSXUjBg25os
	 K8zceIUhXwI8tbAbnvfCbqJGmVRysz/Afub3XTe8/6HkcVty9zw
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8348C200C4;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 10/12] INSTALL: document requirement for libcurl 7.61.0
Date: Wed, 23 Oct 2024 00:45:58 +0000
Message-ID: <20241023004600.1645313-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241023004600.1645313-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our platform support policy states that we require "versions of
dependencies which are generally accepted as stable and supportable,
e.g., in line with the version used by other long-term-support
distributions".  Of Debian, Ubuntu, and RHEL, the three most common
distributions that provide LTS versions, the version with mainstream
long-term security support with the oldest libcurl is 7.61.0 in RHEL 8.

Update the documentation to state that this is the new base version for
libcurl.  Remove text that is no longer applicable to older versions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 INSTALL | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/INSTALL b/INSTALL
index 2a46d04592..6e0321ff0e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -129,17 +129,12 @@ Issues of note:
 	  itself, e.g. Digest::MD5, File::Spec, File::Temp, Net::Domain,
 	  Net::SMTP, and Time::HiRes.
 
-	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
-	  you are using libcurl older than 7.34.0.  Otherwise you can use
-	  NO_OPENSSL without losing git-imap-send.
-
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
-	  git-imap-send if the curl version is >= 7.34.0. If you do
-	  not need that functionality, use NO_CURL to build without
-	  it.
+	  git-imap-send. If you do not need that functionality,
+	  use NO_CURL to build without it.
 
-	  Git requires version "7.21.3" or later of "libcurl" to build
+	  Git requires version "7.61.0" or later of "libcurl" to build
 	  without NO_CURL. This version requirement may be bumped in
 	  the future.
 
