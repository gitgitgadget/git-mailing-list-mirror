Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036146;
	b=QRiweQmpjP8yLfiW+et72rcJFIBYafhRKO9ccyw7v3orV/hHqfrvMbBphZP5Eu92yVuA
	 hf1i+ak/BCqenL3abIjqr/dA4EHfHcg6qrigy1675vhDRagrAGY+611CcLHTkBeChM6RM
	 JhGRVRPTEW3E5yIUS8H7Zv+m2J3+3VelprDGn2XIzpYIzJXSrmEJNbkThee5aNv58girR
	 5MZnDEKOnnpxrwVPeGXpeAV1uHBRbPctzfENRxQ5Cz5RmzAiY6YanokGXbaUgWbSyEUCl
	 C3BqJy+GVwtBIF3Et0z23tOKQhVL+eQmYcIIshyR87cyRTbShY+njRbQGsLyhiF/+Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036146;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xMiP+RyUJxeAI1J7FX0ayGH+7ri0hNl79QgHmJQnfhM=;
	b=Bt6pwcLim8UkjOCDEyv9Ofph7xawW1XKKV/XNGP33lLEMLFl/W6DJESyGU9wMzH4KV/l
	 A16LbAVv35UJ/+Fa/i1MtTNUwxPSeXwNXydaCH033+BXyEUbvidNpSvmhGwUVw8u9hCuC
	 ypqDOV3Ww+7yPqKDBR/URqZVm2bZNwlXY0IF+6eipAk8a/oGDCcZwvtHtwKU7DFsU5k1D
	 CN6gaWSaocuaH9RNKhhAXisGFLwu0gMxZqJ4eSVSir9PZoaWRDvVrmg/sJq8nSHcaplOr
	 xgHjJ152BmZ2TRZGtpBB+vdtX5VES+ABWILl/pvLSsSx/k6zn8C12kgtzQKiGYEdPRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=l1vjkFlE;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60559606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60559606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=l1vjkFlE
Received: from lena.gouders.net (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AIL8tdO1931210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 22:09:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795036143; bh=xMiP+RyUJxeAI1J7FX0ayGH+7ri0hNl79QgHmJQnfhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l1vjkFlEDCN1NydOc9lMHQXnEfuXojp77ILRNdgVl8TbRsL3xzivfCF/IlXDk2w30
	 2xkI3A0HpyGCO3KC2mThmP7eU5Cc7b7NSV0nJ0FVCur32Z5Yazv5vSAO1jX9359MIh
	 58FyLpkqQlHPFk6pWCqdeff8+4QdPX/OwG7FPnC0=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 18 Nov 2026 22:08:51 +0100
Subject: [PATCH v2 2/4] utf8: fix comment for utf8_strnwidth()
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
Message-Id: <20261118-master-v2-2-3f2aaec15d31@gouders.net>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
In-Reply-To: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=dirk@gouders.net;
 h=from:subject:message-id; bh=pqDRYPp0z1D2bVF4vrlyAmPIwLoIDSx1FJJR9I/JLDk=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLL+Cb/ttHPY3tUVkul4YXpOQ2PRDFV7DvVr1R+urfiU4
 8rz6212J+MEFgZGLoYqMUWWpZOK7NJUVrwo+6aaCTOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYOEDl+Bo30gnSH9PzSlNSiYr281BJHU0sjcyNjVzMzIxNHC1cLczM3MyNTM0tHE1NzV0c
 XM2NzY1MTR0tnBi5OAZh1p3+w/+EWULWInGvqp+A2397e6yYDq4tDqcsBFeHNfX97tl49ePb5g9
 hXueE+OgasH4ps9DYUHo/pWLT7m2MIl6u1U7lHwfcK7SWPOD79zVubnJ67JtWwaU9q7RLN1rsrH
 rw8+5/n5xeR+thfN8Vivp5LcVXsTDd0l5uuzmZpY6g84TLzBuYVn9WnJrdsSYwyKxE//5X35tQ1
 G3kNOo+WlCWEFcn9jbXyW/HJenvqy5zjzM+CewREJKI3aB7vb/MJut+j3XVB837VnmmRJyMNd4l
 82cJeo6c178DKUjtdAcO3qX0rJsVP9vJ6Ftn7vy39zlP7Zfmzj4XtvPj2eYXrp7vTLySusHE6fm
 LNoVmXH+X7AgA=
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

The comment for utf8_strnwidth() states it returns strlen() for cases
when the given string doesn't look like valid utf8, but it returns its
argument len in such cases.

Fix the comment accordingly.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 utf8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utf8.c b/utf8.c
index d0546ab31f..b43f84a03d 100644
--- a/utf8.c
+++ b/utf8.c
@@ -218,7 +218,7 @@ int utf8_width(const char **start, size_t *remainder_p)
 
 /*
  * Returns the total number of columns required by a null-terminated
- * string, assuming that the string is utf8.  Returns strlen() instead
+ * string, assuming that the string is utf8.  Returns len instead
  * if the string does not look like a valid utf8 string.
  */
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi)

-- 
2.55.0

