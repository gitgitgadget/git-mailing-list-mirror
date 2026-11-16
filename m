Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855441;
	b=z8uvB8GJlLkOlN5w3r6rh56onyIg8mnUeGjk5BYjkknsbPJ4V3F57p9QjigL4LY8AzVX
	 pu26QaXrIPMRiDbzGLtxCzY3jqvHHU1j07NHT3gLG4kYzWrNIsI6/rA9FsG5j5eNNRZz/
	 /r2REABv1M0b9D9Vg4RH2+ZCB1+idGHiu7iKp4NFYHfLfq0plcgIIxJmhhc9Im2eJMqI/
	 IPM8rk7/98CF24iXHKQvaPGaoSv7oReiEsnZdLEMwwCWgh2ZVjbY0iSb3AUJBq1CtdQuy
	 z4a8+MrZ3Ff42qNRnvZ/zWS9HAcjFNxeOixV0XG2tmApkWMg8NiY6zUhcrZu1av4uRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855441;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7mIB5/oY2GbfzJLxqayjcGNkKC8jW0SePDNpsY/d8NA=;
	b=L31CNPtm/yGIGToy5sibu/6KRNYjSS0/k/zjuH3olTY8OB2tRZ3al7OFk6C7fUGnPa5n
	 n4+xC8HGw83LKwDqXcApuq3g2eqXForVHcDJnGY3s8cEMsISoo6E4fTo4MwoVZahWNu9k
	 KpwbGZshrV+YVFnpl69031LC8GZ+Zyfg8hGDmrQXFXkz7FAB6cFRtDY3tUdQqL7Oegdbl
	 JBgxRazQX8qd3XT1TJjEQNpYH4fdY4dIXJP+B9Dv5oflZsy6NUwci+/kuRNm/cmfZrqLs
	 umM17HtzKpTEahJQ/NMQri0RVkO/9ouQeymYUnWhjr7mANjboulRTYQqi0ZCqSdyUIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=k0PtNYID;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1F606A336
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 18:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E1F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=k0PtNYID
Received: from lena.gouders.net (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AGIv93N1753958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 16 Nov 2026 19:57:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794855431; bh=7mIB5/oY2GbfzJLxqayjcGNkKC8jW0SePDNpsY/d8NA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k0PtNYIDVmXLjDsUMBK/ps4rPIuMj2FddTv+cRTNLWrcWTiItvFNVeLRdc/YDojTN
	 WKKPeheID0mCvZ21P5XhNCJEEL9TJhZMGKQciCWS55J+TTRLMXM3Uu06/m8hDwdiWi
	 um/NELclHFnmHWnwzZLymgoYJKhtCnOVXjgHRmEg=
From: Dirk Gouders <dirk@gouders.net>
Date: Mon, 16 Nov 2026 19:57:01 +0100
Subject: [PATCH 2/2] utf8: fix comment for utf8_strnwidth()
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
Message-Id: <20261116-master-v1-2-dc2a50ce0aa0@gouders.net>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
In-Reply-To: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=dirk@gouders.net;
 h=from:subject:message-id; bh=oBI9M2uGUfH/Ox5svCTTPIo99LNVun1R5h0kgLQhDug=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLJ+B7Gpy5Ucvni3+JXjFaXL6jvrXMMjg6Y5FfVLcjzV5
 LzwauL+TsYJLAyMXAxVYoosSycV2aWprHhR9k01E2YQKxPIFGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIwcIHL8DBrpBekO6fmlKalFxXp5qSWOppZG5kbGrmZmRiaOFq4W5mZuZkamZpaOJqbmro4
 uZsbmxqYmjpbODFycAjDrntax/9MpljJ8yHbG51rONCXZDYxe9ybfebfZOO/XQsWv838m7Iu9N9
 +G9RDTMxvmgmcdf5INQ2wN+JcIno/M4jiwcsPzq0dXz9v48mB5+NWJn87vs7o9QVFq/zyFVsWZi
 ewHhY9XPt1lXb0/1bZ/yyRnL5uHh1L/Pt10euWMH4+k5x/o+X7ntfDesgOqvGYKO9cc9Pok/+hw
 4ztL7V2Gy3u4g6rat3AWxgoGT9pwjXfNpQ3zKzrzHyyUq9mpdEXGqlPp7SPbBI/IzhdiXspfTVe
 dm1x0Y3brhPiDX4MmrGJsTjX5bfL/yBYrWy+Fcqufkww4v15/d7z+btV5lvXCLVcq2JrOvLy+6/
 7/twIxe0u2zV/DDwA=
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
index 7e050bb2c4..e6d1510b60 100644
--- a/utf8.c
+++ b/utf8.c
@@ -205,7 +205,7 @@ int utf8_width(const char **start, size_t *remainder_p)
 
 /*
  * Returns the total number of columns required by a null-terminated
- * string, assuming that the string is utf8.  Returns strlen() instead
+ * string, assuming that the string is utf8.  Returns len instead
  * if the string does not look like a valid utf8 string.
  */
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi)

-- 
2.55.0

