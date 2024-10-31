Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD91E25FB
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730418944; cv=none; b=XkLBWBg5lI6cxbNbKI/1Eaf544931c9fmHzGwd6sG5ue1yw+nQ2JJhq5N89uNG/+WYcR8B1PkAhCYhHeaEB5FmjNlNPygVrjtEdxnAoxyiDZk28E7rPA17Ro8YDSmbeNffVMkBz8FhdrqlGklxzbGAC1atQ9C1tCCr8/PXNXitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730418944; c=relaxed/simple;
	bh=k276l7VHj5F8rJcaSGP6dcOjaMF2d9w7qZvwVvT9JBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSwwNjVMIaxH7aQ8g9TBkKHoHmRx/gFHDKRMxGL3khSllbL5NwPqm4mIesh7WGt2Ot5E4k/yCbtSWdTtG3240EiDowLV9KWwXegSmqimdbLRaFoR8pphkUA626uzF8E6VOnj5oOkTbS8fNsSSo2urLCwkRQvJYhUbpvi7XfKjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FBnZWz3R; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FBnZWz3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730418580;
	bh=k276l7VHj5F8rJcaSGP6dcOjaMF2d9w7qZvwVvT9JBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=FBnZWz3R6cK3xF7pIf9hxkLTOuSx3GJYRNwkj7yihtYSTRjMtBuIeWCWSZB5CMUks
	 xGiYAoEIEA8rHeFPO1kq2kZxX+dn1EL2aIXSeJbaATS+nu1nGl6X7M3WVCx16OjNVE
	 NRf4yXW/hjwQoTyeVAJ5JJozM3n7MlOSGKDnXVnNFmPRHebS7/V2jfzyK+1RrG7bR0
	 utiHHFZ1f7hR/9o56bggDbOQlkSYsV+++1IyD/mT9UsA/BmypE8uYjlRgehAjv8ENG
	 +0uOQF7CRmLMGMPfLBN0/uFwCDYrI/7Jfy2uzQmeoRBCWiXmAWcTUExTh04hyyspz1
	 vEQ90Kp9aqcc2ZTqr6OKkmCF8IrCi2eIfoDoOaWDoaY8heYqOB2xvdhFE/FSIGOHqi
	 0yJbzBHwS2tgsb9WnlD3pSeXJfUmaCUNyv1XmuWrsuAnqD+7RcN+fil3qNZuC69NEy
	 oK4WAJamcsv0vpDvhlvGYF84KLOxw3/iaiZzUFtsoqEgszbEtjh
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0506C200C4;
	Thu, 31 Oct 2024 23:49:40 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/3] ci: remove clause for Ubuntu 16.04
Date: Thu, 31 Oct 2024 23:49:33 +0000
Message-ID: <20241031234934.3451390-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
References: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're no longer testing this version and it's well beyond regular LTS
support now, so remove the stanza for it from the case statement in our
CI code.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ci/install-dependencies.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 126e570eb4..d30ae53a18 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -55,11 +55,6 @@ ubuntu-*|ubuntu32-*)
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	case "$distro" in
-	ubuntu-16.04)
-		# Does not support JGit, but we also don't really care about
-		# the others. We rather care whether Git still compiles and
-		# runs fine overall.
-		;;
 	ubuntu-*)
 		mkdir --parents "$CUSTOM_PATH"
 
