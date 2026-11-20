Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185883;
	b=vCSMyNIZCpwK/5Im1PZNcjTF4g+vYJIy+IPApK2vzqbRUwhIzR1io7HMyJjXwfyFSbG0
	 gExRxF/46UD/YQvgHlkzzN34VZlXx0FEAGACXX+RyYbSop1MGr6VNxz5COlKIk2Czujun
	 Ke+WuuIOtc+9/PC9XUjcaQARocZ+unYI1rfqaacUujTkdv6UakhTJbCKOo0c+cfA9tBTs
	 hAlKlpZwUnmH6ogyExTctkgSahOuvklcUvn2L3Ol0lS9i0hDEJ4h6RNFPcqAv9jh+heFl
	 yiWNCiARPng4mStyre0iaQj3rUZnUUZbIENUvA7bRw0ZqDrNqfg01EFyR6eBURfC2dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185883;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xjv4A7czop9Oi7QS1LtjXT5c+jSkFaj1zY689VXW/Gg=;
	b=kYzmAPZha4QCH/bx/ElTm4ENadJaNcJUuM4UaAY7oc8IYfsxDLHYsXvkfg70rJGazT9U
	 iyHNeS2H0+hYSpmz2kzg4EgTGjAl8Wmv05J4Zg2nAJ2Fp+dz8CgS3+7EBxHv4JbxRNYs0
	 F4ROSjl7gWeJYzifgIyxcsYdp2mAgpItdplQgh2qOINewS/A9CyCIjfvkVS8oWpIPEdi4
	 AVdqECk2uZQvP84+AZ0TcC4cl3vr1EVBfcOPiB6g3F0hCtPfzOacbYG59NMZ/yphmyznW
	 f37nWkX7J5C5VLCY3cVJRWz9whIu3XKGo4s2rfq61zP24kX2rLO2yP+Hg62UUAT5yyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Q3lpyDtQ;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5D7606A335
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5D7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Q3lpyDtQ
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKEiRt82079849
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 15:44:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795185870; bh=xjv4A7czop9Oi7QS1LtjXT5c+jSkFaj1zY689VXW/Gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q3lpyDtQIpMFdw5V40Gi706Ras2Rb+gTd6VFMiycCfKkkowORfkpywrJpfLV8tjbQ
	 bHYxncVGPhr2b9Bz9MzJ/PEEtdxRVf3Sh1abMPxecc2fO6fZSva4FSD05K+7EpQHSe
	 KbK/FDZ/RFEOYuH962GqapM9MGVGYbzpkceWoeRg=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 15:44:25 +0100
Subject: [PATCH v3 2/4] utf8: fix comment for utf8_strnwidth()
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
Message-Id: <20261120-master-v3-2-d28e8c75d26d@gouders.net>
References: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
In-Reply-To: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>,
        Andy Koppe <andy.koppe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=dirk@gouders.net;
 h=from:subject:message-id; bh=7Q/dLjy0C+4A71zqfLOtgzeTadDNsAEqs3xnKEwXRQs=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZYs4ckHmxrj03bvYG7nVsGlXJEU7pxmXZPodYKoL0Z
 Z3nm9h3Mk5gYWDkYqgSU2RZOqnILk1lxYuyb6qZMINYmUCmSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY+QAkeNn0EgvSHdIzy9NSS0q1stLLXE0tTQyNzJ2NTMzMnG0cLUwN3MzMzI1s3Q0MTV3dXQ
 xMzY3NjVxtHRm4OIUgFkXysD+3y3c9Gzvpi2dL10iLDdwXFNrOh7+dxej9eb/wZ7X0uwND16Rf3
 ulaPXGeSLy5u66FwXzTponSrA2OUgH/X1w5q5msKU947zfxS423+92H3g1uaut76bt+nxtiTLuP
 ztdD2k4BT7U2tcrwGsWq2ycuiu0TMzZ4ucM51OJ01kUOlkd2RTVZWYLJB29Fn6QS2f9xrDXtzfZ
 f/nMtTGxcMLHyub2B2on16QutmQNyJnwf6dH1VOPTKZGC/5Pq5N8Glnqn+SryjHdz70eVbg6edu
 l6ubsYp9HM/+eyZh7YmX/AfNKKYETF09ufKtxuYp991q9d7eru5+s69Hf6sD/1/v7hWShzmX+Rg
 Lfvn3qfGIAAA==
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

