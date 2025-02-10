Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBF26461E
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739231459; cv=none; b=SRXDJ5NOlh79e4CiLiqy93am822Wb7Tqgl9DQ1pDAYdFhxE+r2PgPm1sZt0utEc3BRmK6VhD8ih0E7UtbQZVgLYlZyNjE2sF3MFpOeXcrqSi7qDMH+YmjFZNIBJBcLmjMD6HzPKxFaPi6y9A5XsnMgpKAIOSoNglcO8PA51V3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739231459; c=relaxed/simple;
	bh=Pqp2QKpPKh2spSxW873z9tWqc6fO7OZ+wC1UemBZVL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1nKGyZchjgz8Wf8bhJtWPsD1jz5sG+7LNEB8MqhCKoWtOUeHu48yzU7Rk/g0vXNGY8VxjbUzECrM1nurGIrnm3nr0PpCeMs2++49nccjiFRSyDVSE/os+V9cYcGkTwmyQIv7dLUiskh5RqtIXVAJRZUuxmR1rR0cVivns2BUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=R5vKzYb3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="R5vKzYb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739231455;
	bh=Pqp2QKpPKh2spSxW873z9tWqc6fO7OZ+wC1UemBZVL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=R5vKzYb3oxwHix+xcyPnEhpYGMhBOM1uij1La+aXePupGCvPFHSZpcJQEfbJOupbU
	 GQ9fsT1TqxSNDGaxGmcePtSLZfmYWu8pyNdhnDizr6Q+Xu/vY2btJr1hMA8vuUIxc2
	 8skXnuVXsZ3NTrSij1Z+OYNRRQUNKIIrCAaVlem1keHr/jTjl+tzJQfsXkHGPgNMli
	 zKUr1vlHY4LEyWo0EM9jUD4HwoUfCkz6s/6fAfnDjPde7v61c5aKKbJMEVOAHJqTg3
	 nSqHav6PhJcpZLj20t1GCzYdzt0nvl8IX4x9l9Mp6GRI+9OHcuizefUKFIqHPCLJUV
	 8tjdBpOENvlviS77LRvy+7Tilb+O7x9MKztpUaqIZMsl8k0STs2N/qAsiqfyBarcy/
	 NhpcnxpSRrFeiyAbahxgkYY5MxAMm0672Wo9qFJd9+J1TWdPufAeZrIiWIBvtav89a
	 tJboyChrx5ilE0b9NelGOUvo+1Fc7rZ0ZKkfwlFwNDDUW2FEPvp
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D2E4420076;
	Mon, 10 Feb 2025 23:50:55 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2] thunderbird-patch-inline: avoid bashism
Date: Mon, 10 Feb 2025 23:49:47 +0000
Message-ID: <20250210234947.1317056-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.48.0.rc1.219.gb6b6757d772
In-Reply-To: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
References: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of "echo -e" is not portable and not specified by POSIX.  dash
does not support any options except "-n", and so this script will not
work on operating systems which use that as /bin/sh.

Fortunately, the solution is easy: switch to printf(1), which is
specified by POSIX and allows the escape sequences we want to use.  This
will allow the script to work with any POSIX shell.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 contrib/thunderbird-patch-inline/appp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes from v1:
* Add a missing newline.

I'll note that I could have just written '%s\n' here, but I think this
is a little easier to reason about, so I didn't.

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 1053872eea..fdcc948352 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -31,7 +31,7 @@ BODY=$(sed -e "1,/${SEP}/d" $1)
 CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
 DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
 
-CCS=$(echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
+CCS=$(printf '%s\n%s\n' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
 	-e 's/^Signed-off-by: \(.*\)/\1,/gp')
 
 echo "$SUBJECT" > $1
