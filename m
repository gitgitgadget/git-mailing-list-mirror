Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795359092;
	b=XO5ynRm5rAa/CxKqIppUW59Jfy5rfyjoxt9NXbEigXvwXwQnetv8ze4936i+cP79Lkme
	 wo2jOrPvpXefkg1paLHUiGbyAUhKhYYhNmR1itUMkoqbpLs3md58L/85ZIR+tU899UjcD
	 A5SHFpF5lmrcGwVutdahVTYnNYFtzTjGUWTVcMwUTDVwjWXkuT+YeFfLxIHxT0G2jeWn9
	 mtLGeSKEI6GZAxfBJX+/ZvEZ6dsu0ZF93L/e4egje7aoPaGzKKrxqki8uR1VWKK/g3vyB
	 Zg8RWuPdfJZdzH5An+E1F/Es3v1H6S6R2/2rXriyFFJ6dwyV+ztC4ydX0u0fglnS5zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359092;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sf6iS0ZvKkqSDcl9esuW1oe2LLZZB/q0/dDaMyUgNMk=;
	b=gmtWvrT0LmGI8YGUWbRiH3zql04Q5acqw61VRMMl9qghmCcMl8/bE5T4Zib9pMyJF/ri
	 G8oMgCPRRffBwZT1nVJWSAHyruDW4BwfU1RQTE+BSj66g9elGBH2nZ9CkmX7cWpAFaoad
	 v6zsnfk3xFZsHd0M3lA4Zex8m0daRLnopMhA/13G3cwsofjwjfZJjc9GfJdYwBYmUyv9Y
	 OcqTP07eGchAvAR9uq9e5LA+l8NIDgH7EJUyUMtexI0DkWTm8MAT4UOz3d36kdJeeYw6i
	 /F0YnJ75o2J+lTZISCnzNReDY3HxsKeF11FYBH1CKB/SefOKTfPLMmWr+4yi05yWidQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Edv5d2ob;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA68606A330
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA68606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Edv5d2ob
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMEpQ7s2232929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 15:51:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795359089; bh=sf6iS0ZvKkqSDcl9esuW1oe2LLZZB/q0/dDaMyUgNMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Edv5d2ob7btkmlJ6PyHD3nnwrUP4cVO1O4zaUcTUOSOBenec+calbICBoEh2WmGZ8
	 JxUpYAOHFswvOXi9Za8rjVSzmXiQ8BPxVAJSA4Ww88iQzF3Ti3qiulY+lpBW1kI/yo
	 T2ziJw2/Mix68WX7Rkot5zfPQ7xhtWy6ob6Ncg0o=
From: Dirk Gouders <dirk@gouders.net>
Date: Sun, 22 Nov 2026 15:51:25 +0100
Subject: [PATCH v5 2/4] utf8: fix comment for utf8_strnwidth()
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
Message-Id: <20261122-master-v5-2-313bd1bb3c45@gouders.net>
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
In-Reply-To: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=dirk@gouders.net;
 h=from:subject:message-id; bh=VzCGBbx+9jqQ4AYj0saWu1eDYnLQATQtozzWr0tYJOo=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLKZGfNDu1XP3LdTmdZa2cL55/e+Qydu3mJauOGzjH427
 7b2z2mrOxknsDAwcjFUiSmyLJ1UZJemsuJF2TfVTJhBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 zxDI0DFygMjxM2ikF6Q7pOeXpqQWFevlpZY4mloamRsZu5qZGZk4WrhamJu5mRmZmlk6mpiauzq
 6mBmbG5uaOFo6M3BxCsCsm7yA/a+kpIFLmoVE+Knka3tPvbfhY1OJ2Fp1ab6xO8e6jj6f18WRLR
 71/+MO6KrOW5HndpDxWalWcI/EOfM/zsLVc07O3RAms2XrbYe3E27FWi5NFr9ew3diss8Nsdt79
 /2YxNciGPNxg36ZUs6NcInLjzg3hNjFGodwHim9XPwr46VOz29Nq7Af7DdvHOLbpyOyqPzq3Yva
 X7P2pO4JmNujctp4/dqtfRffbznv6KquzztN690/hdT5/eyHXZZJzzMUZL780Oztp1ne109mZn2
 5xTr9sPXL+UGv5e5Hd8/jU/kR+ZUx3rV8Tvzp4/ekZRnFNDx+mvw9+e1I/YJ0w8R/75frTux3e1
 yxkU3W/bOU1n8A
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
index 503edb8edc..009e8fee39 100644
--- a/utf8.c
+++ b/utf8.c
@@ -217,8 +217,8 @@ int utf8_width(const char **start, size_t *remainder_p)
 }
 
 /*
- * Returns the total number of columns required by a null-terminated
- * string, assuming that the string is utf8.  Returns strlen() instead
+ * Returns the total number of columns required by a string terminated by len,
+ * assuming that the string is utf8.  Returns len instead
  * if the string does not look like a valid utf8 string.
  */
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi)

-- 
2.55.0

