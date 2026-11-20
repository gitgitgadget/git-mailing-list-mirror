Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187500;
	b=EKXRTmSayPWFVtNioslizTTsJE75aIBPjEHiNBkCfibKFfVGLq0wZ39hS4ljnUcmbvn6
	 0KIe3EM6+nU7AqSvlApTJHUXYokV1N+Mw6r6JFlRpTMfjhsU8fsYSDLhzuyIbB2r471mI
	 ftQYigb9c+lkxLM/mtqiU+l44/2cisfDKofZ1ovG2O08rCC7nT5UVwgo3IBX9tMOT9cE8
	 VdO+OCe4ePpDWGV95/CVtJASjmIGXl0geBj9pNwBxSGjk9XrKyZjq37r6vqtUbl5XbE4S
	 Ml+LTryd2BRLwGK8fWlX+zC/3P0wplbK/XML85DIOpwNBPhYRqqiDsjW59OpR1mNuWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187500;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xjv4A7czop9Oi7QS1LtjXT5c+jSkFaj1zY689VXW/Gg=;
	b=oOLNBw0I4Zy4+gjrTJ1r+qlQBDnZVV9NBxGU4b9Qer2g9Eh+EXXkEmLhE8Di9IvWHYR9
	 dG/bBHbNoiDg9STBuJPlkV6uC+b99cg9do0PdLdBKFgSlgKVnpYmwtkOzwF4QdnHnuydE
	 xQYt18WuK4ViWm+hM9nEBthKkZrWnkDSHqXI1f7HAhC8KXQAwIFZeM5gLNbkYw94xLT1G
	 +ZpjA7d3JmGBQ9rME1fDw9tHbhmMDfr7TC51FJ2iyS+INFxEnNQ6+3AjeO0kHYZNIwH2c
	 g1//JMioMtYwf7XI8Odc4+aQDqNaBWefEZcsLSjwrAeXdwu9KMxT2+bn2hcAkh6S9vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b="oPYJ065/";
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D96606A33C
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64D96606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=oPYJ065/
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKFBTTf2082197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 16:11:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795187493; bh=xjv4A7czop9Oi7QS1LtjXT5c+jSkFaj1zY689VXW/Gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oPYJ065/tYFgm3z/7F4g3ig5eHgb4XhKXk0YxIAzz3a5hphtAbtVwnUpqRKeTwrmo
	 OwmFnfX2ZXLIEG/aKyYb0ENinB1V9aFTjZJkJ74CurhB1Z4TvSUOb1+0vVaBHe6shq
	 Q7fmzelKsdrfckP+axaCUJ/vTHB33ky7nCe95YTc=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 16:11:25 +0100
Subject: [PATCH v4 2/5] utf8: fix comment for utf8_strnwidth()
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
Message-Id: <20261120-master-v4-2-5ff523db7285@gouders.net>
References: <20261120-master-v4-0-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-0-5ff523db7285@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>,
        Andy Koppe <andy.koppe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=dirk@gouders.net;
 h=from:subject:message-id; bh=7Q/dLjy0C+4A71zqfLOtgzeTadDNsAEqs3xnKEwXRQs=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZkhVFar2uXpvIXROZ+N/Q67Kn9YKL92w93H0/3c9zD
 etbt9q1k3ECCwMjF0OVmCLL0klFdmkqK16UfVPNhBnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMHiBw/g0Z6QbpDen5pSmpRsV5eaomjqaWRuZGxq5mZkYmjhauFuZmbmZGpmaWjiam5q6O
 LmbG5samJo6UzAxenAMw6Bi32/1UHZb2lrdavOv7hoLDOOmumH812vrnpvVvFBMMk1i89HrX0Y/
 +hkhWaBmF1MwLlfuzdp1Fwcek237fikg0dLdHmLRWm27Yx/9g+2dPinNn85x38z2XXJecXupXee
 tD35YxN28RZSgwzXhQ/eFEZL76lNiWE65hG8om0mL8nWxP/TwpbZKbw/bxu5xZVSxOD2VxF9jOe
 sF/s7H+h1Ri9S/8v7+Rnfy52mr7bu0/P+43z0uR1mUcPB33Kz1pzIn+dM1dp82FnLcntM5u6fhU
 ssLqkdzSWS32h5/Vmi/I1AU/Uj5j2W4QI+trb27NP++dmtvPa+7gTWj1bxIUfee03E61ZkvBYoa
 Mm5oS4CJ8qAA==
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

The comment for utf8_strnwidth() states it works on a NUL terminated
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
index 48aa189624..35b2bb8290 100644
--- a/utf8.c
+++ b/utf8.c
@@ -213,8 +213,8 @@ int utf8_width(const char **start, size_t *remainder_p)
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

