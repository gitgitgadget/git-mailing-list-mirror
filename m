Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630814;
	b=wP3tED5QBy9wne7a/A7eNTfLQ5k9VQwh7irLXX4UkVy/fpFv1fGffrYUo9wOtWWIBMm2
	 hiCSRdWnau5AgzLKKg1zG13lp6kfDpuKyKUxWMcH6t8Ln2CAYS69uAyb/UF+GEU+Zyd6d
	 4RZ2rtE1hOI9iyJza5C/S4BKtd+UtosklQBB+wgToNalmSX6W/15sdVEc8zF0yu7MzolA
	 B0vay6QB7e/rV6GDqsBqnHh2dDhIE6A8aSTZKFRFCKu0DGeT1uyVRYo6AB/hktE4BRvLp
	 LjF9VNNVyFajI/vMPFZBq6JMYYw4NcD/BlLg/+hdeqxWlmILLM3YHQ2DI7Ga6nLEuJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630814;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5yMFU/fQxnQde5x7SrdXGpaI2qYxgXHF86nTSx3gVmk=;
	b=gofoKqffxVeTEysllp12TRpa6dslEnQDwu8rOLHFvT2otrSYr14lPrYTqOMUhQEsSkRk
	 ozZJLwh6JVEjQdC46sKkYL3yVUPD6trAtCU3wW9OCZeSz/RXhP9gxTvBXDY2GCtVLgfXF
	 nL/GpGxKa5wxjBQ4nAfLuJt8WqCwCOIz6XnObfRni0BGAIwkiUME3C5j/NS7q1Ar8g1GN
	 Mz793c69WpDc6GXg2n0/EmCE2Ev22NM9wQFhhPxh6w7r8V2kw/zn4b1b+tAJi47SxPrtX
	 1XHSRBcDs7iNWEsfBkKqzUCO80avpcsjJK4g76BMv2WNKvf1Y+zkEELsLhMXyTUkqSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=dYSpt3wV;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAC606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCAC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=dYSpt3wV
Received: from lena.gouders.net (ip-109-41-50-35.web.vodafone.de [109.41.50.35])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6APIJxx42481769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 25 Nov 2026 19:20:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795630807; bh=5yMFU/fQxnQde5x7SrdXGpaI2qYxgXHF86nTSx3gVmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dYSpt3wVIMWsZeYSquwZ2XxlkJgL0iokQ+CDoilupe3+j2P0GQ6Wb/y4cHudoVwki
	 Dl+/WtagxTSGX/Jdns4f/M5vep3eSzOzD07dWNbUBQ1wRheuLs8ENr2rEb1LVJKOq1
	 Z/iyUTSYI2NJRF3I9jbqhTdCaeHdfUN+qxXB58io=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 25 Nov 2026 19:19:42 +0100
Subject: [PATCH v6 2/4] utf8: fix comment for utf8_strnwidth()
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-master-v6-2-cb60af83d189@gouders.net>
References: <20261125-master-v6-0-cb60af83d189@gouders.net>
In-Reply-To: <20261125-master-v6-0-cb60af83d189@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=dirk@gouders.net;
 h=from:subject:message-id; bh=rk+ndf/83sOHjvjcIms7f6CHP2pxSeV4xGqJ/l7vlbI=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLLZ1a7qKJxi45t68e5fWWXfXvHsntWbOx/zxl7w/rXVJ
 fnfBNa+TsYJLAyMXAxVYoosSycV2aWprHhR9k01E2YQKxPIFGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIwcIHL8DBrpBekO6fmlKalFxXp5qSWOppZG5kbGrmZmRiaOFq4W5mZuZkamZpaOJqbmro4
 uZsbmxqYmjpbODFycAjDrZpiz/3f33e980OrYwQ0SX57HiXfGHtPJZwv+zV2ScvzPh4eHLedwV/
 +w65r3827Yqm9vixhmVLB1JK24Xc20v7G6puT1zMKN/X/+12VoC0ZULc5QOa4jtnGV++8PW+Ptm
 G5la+l5vl6Ss2Uyo9xVpfcCDmr8TrsZV1so3CxrP+vN3iDyxGP1fed5lZtrFdn2KTLHsHyTczbZ
 +E1MV7HedWpxwgp+U63Z4hwXWWQztffOfuB91Pxia9Pxvf2+Uplf445rNn1NK/+x5ErerqPZ3xc
 vPDV78+yMiZtfXpGKyi9b0jJbbkWub9irbe939KjfnzY7KezronOvbB1NF3y5V2q40lByr83hPb
 4ii8J+Rq19oAYA
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

The comment for utf8_strnwidth() states it works on a NUL-terminated
string whereas the string is bounded by len.
It also states it returns strlen() for cases when the given string
doesn't look like valid utf8, but it returns its argument len in such
cases.

Fix the comment accordingly.

Helped-by: Andy Koppe <andy.koppe@gmail.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 utf8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index b161a5ee48..92c3bf29d1 100644
--- a/utf8.c
+++ b/utf8.c
@@ -217,8 +217,8 @@ int utf8_width(const char **start, size_t *remainder_p)
 }
 
 /*
- * Returns the total number of columns required by a null-terminated
- * string, assuming that the string is utf8.  Returns strlen() instead
+ * Returns the total number of columns required by a string bounded by len,
+ * assuming that the string is utf8.  Returns len instead
  * if the string does not look like a valid utf8 string.
  */
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi)

-- 
2.55.0

