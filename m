Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3CC4431
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053635; cv=none; b=sIbPZ2ZqGgAyxdrIqtKxsGOAREQvLfwDzxS5U4tHdo5hOQ2gWYDAT2yN/ux1RbsxEf/hO27D3dFQS6zJdPitt7xW1ewRU+A+PwVcWnegA7ZCBKpzSFz4+DW+Z7y+v7HnLO4PR8s5qMUS+cVvI6Rgj8t65IyDdpK8fORRwHOBWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053635; c=relaxed/simple;
	bh=Ddpg71eDm99y1YtJE85ulYA4kSVEGfhXpF2+21TIyt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLi9ofcUTm542fB/VdmABE+qja8UOFP/pLKHq8KEF0W2Bvg11xQi/aZFTPrIlX7g54XUXDhpn5BUDC6bxUIoKSxW7tGkhflAOWUPxdXFZzwJJFt0abIVDgKK5qtDfb7T8mgsHAazdV+EuUeA/MQrBrocfDyo6Q0EaYQhd0MDRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=t0VB2VZt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="t0VB2VZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720053632;
	bh=Ddpg71eDm99y1YtJE85ulYA4kSVEGfhXpF2+21TIyt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=t0VB2VZtxJXS8ZMGBLqFy2CqsFFJCTDnUYk9SOf9OWZKT/yky5FtsPQdHmyV4Uiwy
	 vxoI6EFVN85qW5LaSkXdWF+t0C9jyzL7iTYzPrMm7FMjg84QPsJMW0zTJNf1/hQNrZ
	 qKsdk4D2VMXdr6BPN0bVikJmrShpS8DkyyEy2sDWMwTbGWv30cVFybb6FM2i2B70FB
	 N7DdkP/zkVXDGroj/F/IQggkDzaCELAJ1Ey2judlGNFmvutui6TyA4UbJcjFQmZB88
	 3r3qCQJFtJuQDIfW3VQbDPLExwYJ/YDnVeDWPNfyLfX3nnsvi7ebHcA+iXSaEDeXRf
	 oKi9s79VZbmunavplaIkzaZrhk3ABM0NAbxWdnKqMfgCnFlIYeGvq4i73cbNxJcAuS
	 0OCDYm3PmMi/csmAHtozPvTdHVSPvCLfKNySXgdgVzL/6V7p1TYr0lwNBMWodPEFot
	 3/ufEiAT8hPOvKMIJuOXyBQBTrCsJpCra52F94nM4HpZ0/Bsh3e
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F04D52099C;
	Thu,  4 Jul 2024 00:40:31 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] doc: mention that proxies must be completely transparent
Date: Thu,  4 Jul 2024 00:38:18 +0000
Message-ID: <20240704003818.750223-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240704003818.750223-1-sandals@crustytoothpaste.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already document in the FAQ that proxies must be completely
transparent and not modify the request or response in any way, but add
similar documentation to the http.proxy entry.  We know that while the
FAQ is very useful, users sometimes are less likely to read in favor of
the documentation specific to an option or command, so adding it in both
places will help users be adequately informed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/http.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b86..a9c7480f6a 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -7,6 +7,11 @@ http.proxy::
 	linkgit:gitcredentials[7] for more information. The syntax thus is
 	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
 	on a per-remote basis; see remote.<name>.proxy
++
+Any proxy, however configured, must be completely transparent and must not
+modify, transform, or buffer the request or response in any way.  Proxies which
+are not completely transparent are known to cause various forms of breakage
+with Git.
 
 http.proxyAuthMethod::
 	Set the method with which to authenticate against the HTTP proxy. This
