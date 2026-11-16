Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855441;
	b=SnLVw4DQl1kOinibeLg9Lhh60Qf9znCFLBR9s8WpxGWLqbMMrlK3Fqd67WqMv8WGwh/B
	 nY0SebE2MNi6CrTuYTiv++uGSYMqnwURLwEZNoJ54SzJJJAsUd1ew9XuvrShNjuC94MxK
	 899LaWPPzuY/85qH+QU6TuL3MG2mMDRNFz4UWvwMJUHh/LR5MA4ne6XdiivN7Z3PEeIB7
	 Dx79CmNT7AtQgc8CYOsfFhA8lq27etb/MJ8zPMKV9LHonDRX1gzavHbk6XXVvsxg4zeJe
	 +w9xc/H/QDvcCeYnkUl6sX2vNQXOJcYDa4iF6SHHccedDB6pubPZSj2AVWCy+QdUGKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855441;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=T+hWExNVYYqQaEDfVvxpzjFrUnE/A9t5euJ/CtZaS8s=;
	b=reDSCpumbvt/GJ2xAoJTWgVzk7jHmpuNvbZT4nVRx5C10QPJ9quyEAmlQY0sKlEDCS0F
	 YaYlmwZjtAc5uYI57rh0N6FMaxzjh/IrH/uzQ86dP4OzmBgL3qP2HPbI9YFfIVkBxqTVR
	 A+4NHHj4BeTEP1nOmSwcPhwzdkWeEWiIwRcM4pwADBdGFbK23hKuhjKCNItul+otAsesq
	 mGYWChdya0AelunGusgQZlYXCI/EmnONQ24YDY4ee0DMxfjOrWM2dM/LuO6lInKTFr1Bo
	 hq2biFszXQiwBT6uoQ4ZY8LLmjTF74oNy+FwHFhlXc8uxFj/yJqIb7HUlqgXZqOgqcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=TMxc0zak;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF7606A335
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 18:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5DF7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=TMxc0zak
Received: from lena.gouders.net (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AGIv93L1753958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 16 Nov 2026 19:57:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794855431; bh=T+hWExNVYYqQaEDfVvxpzjFrUnE/A9t5euJ/CtZaS8s=;
	h=From:Subject:Date:To:Cc;
	b=TMxc0zakYO+T4qoDtIFEubClmLSA1itWPzZ7cvfL9TX54bIlRHd2hnVc2XpWIv97M
	 yf8EnGNyUksuvzIVRnd1oUtCahWDlRNvrmH2jODBOgk1HiRrZ8YbeuOz3Yc238bEpk
	 8uzIZTskK+/ZJ1SHe1EXpqJCc9QWUQVAOuF2WOEE=
From: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH 0/2] utf8: two minor fixes
Date: Mon, 16 Nov 2026 19:56:59 +0100
Message-Id: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3dzE4pLUIl0zyyRDc0MzQyMLI2MloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0Av3iQmGoAAAA=
X-Change-ID: 20261116-master-69b171612823
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=dirk@gouders.net;
 h=from:subject:message-id; bh=qBiTQ4rcMnuiqe1zjWdW8NRh3ocIw22L2a5vPJsMg74=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLJ+B7GVWMjaKK/48H32hsJXV2wXCeornX9cGe161Wf3q
 c0fXt9Q6GScwMLAyMVQJabIsnRSkV2ayooXZd9UM2EGsTKBTJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUMgQ8fIASLHz6CRXpDukJ5fmpJaVKyXl1riaGppZG5k7GpmZmTiaOFqYW7mZmZkambpaGJq7ur
 oYmZsbmxq4mjpzMDFKQCzzrKA/a+QeFblgaMheY8/eaz/rWkaEPMrrzNW1eRi1WVBqRNPDh8NVG
 K2WLhyRuh9nX7FAu6gMxMdjgYsO72pzbHCjTcs1uzdv4/b6jUNb9jXrg7cVx6ilHt4w13jLVe/T
 f+9f8nM79EBCtYLOd8wf20xvWX/d65/ypU7tzVvXzvz5Pv61Nhtf1i+TejPYlHdMDV85vnJsZun
 su5xbvWYrbhh1UGNzZOkfV7eUmdrXC8te9jAeq/N92U9GjKTdXeF75m7cfHs8E2zbnM/1vGrNP2
 /f9bVtCWmQizOC3O/Bxk+1QvQfXzNnFU441SzwKS/MxfLtO+7/Lmi+q5qzwdpCfslMZu21NRIZx
 2ZM9dj6o4zv24oAwA=
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

A patch here on the list made me look at
display_mode_esc_sequence_len() in utf8.c and I found two details in
the file that are perhaps worth a fix:

1) utf8_strnwidth() disregards the given len argument when fed
   with proper string and len.

2) The comment for utf8_strnwidth() is incorrect: it states the
   function returns strlen() for cases when it actually returns its
   len argument.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
Dirk Gouders (2):
      utf8: respect bounds in utf8_strnwidth()
      utf8: fix comment for utf8_strnwidth()

 t/unit-tests/u-utf8-width.c | 11 +++++++++++
 utf8.c                      | 12 ++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)


---
base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
change-id: 20261116-master-69b171612823

