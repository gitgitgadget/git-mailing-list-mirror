Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B21E8857
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604600; cv=none; b=jAZ/fmwulpesH2eT4QfH/MLGd11XQbyVdCMfEWoUAyyn75L7ZZX++xIPEIgEwXKBHoUySkNYY9weKDu1vCzKylrT/DPwUvI12uI6nLI962mYj19anNZr6OlxFTAALN0IkMlIhk6aQ6DICrVNctX7EpRYZiMm41UtHtmxHyF9Wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604600; c=relaxed/simple;
	bh=u9igHWBuSr2c88DQ0ItXsvOXaMorSxMBiSW3OfzCajQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4RW5eD2SQ3keJjcPIoOBwE2MatgeNBFxaxEgyZpBetJsm4wKzGCBWjyNtDTuxPP2bqktuhPtzwKm14pHrKM8CKgqC+QUzzPEEF9PujVju/DTKu97aeh3eNUAdjg1iJOPlpbn7ApVLXPGuCAl73mbst/UIbEEVIQEMR9XIPyNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oPnB3M1B; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oPnB3M1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=u9igHWBuSr2c88DQ0ItXsvOXaMorSxMBiSW3OfzCajQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=oPnB3M1BPrgtWtOrbj10jLpoPxoCqb9XeHxDZ1e/i/pePwbglMWOYzua/HzyB65Gu
	 uIVgQmHuTpY/dJgp5hWdBwElBRmb2LmitNefZIrZL6nn50oxJ+XO0CBEv0Vjcj790U
	 dNZ8sEeKaWASMWlQoDiO4/oHhjA+EOG+PQ8aigs1iaifbXxu7RAPWOskAi/tqKBMYS
	 ceftE6fTw8EKY50+BpKh318jDqUgga9/Qk1EsXDn4aov8s4Fq2yk6nKq0x7SerE/uX
	 gZsdc7MxLGx9JT0TR1DuVvQ/4dnJrA10drYWQKGcOw032aAF+WL3qsQ7amqytq+3jb
	 oEn3yn8fyRTkS6AFajUKvhc4ErLe7Hgc+35oGWY1kpT5av9/IadTTJBsJR30vOIzuK
	 E7YXxVxToukN+xXRSae4WLk7OOl8TEuorEaPYbWC/yglu2CdNpl1iL9giKQLYc+lXK
	 mxcPSVMYLdWtpR9gur5rHGLgN3/AycziM0Cw/zg4tYHGawC7ACW
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 651BD200C0;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 10/13] INSTALL: document requirement for libcurl 7.61.0
Date: Thu, 10 Oct 2024 23:56:18 +0000
Message-ID: <20241010235621.738239-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
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
 
