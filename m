Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0C3375BE
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008716; cv=none; b=Ei0x5IdvF1+wXyd3fqbM6F4ULG5vzBjssKnhafH0OMtw2drT4gvND0EsDGvJMR7hEns7myK8+HNG03IJhPPK26J0LvpqR3eEKoMWj7+TLk0WRcczS5R9xLhLLRiM2Eks1mr1S6lGLvgGy7QST888LKhMA4/tCXkJ/OAFfqzU1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008716; c=relaxed/simple;
	bh=Qzz8dug53tgOR+hVc8mPOsqw74Up5v60nnCtsS5/Faw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OBb8gzEtX75LuD9jeLO7tIQfMFDwYGB2d+oBI4N3WRaFgDDq8JzXEcenYsLcrwS5jIX6DOTw9j6JHi9viBTAOJ2RZafa3gSLkghNtdysjuloQaa8XjzMNq1WFacSoOw10d/BxJmz69VqZrM69PyqR54SVUA0mZZDZ9Xh0Rd2uWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Gakqh9+N; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Gakqh9+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757008706; x=1757613506; i=l.s.r@web.de;
	bh=W7+MJdbIAb5xvHB53BgstxXlhSNVzQxDO0UuclfBhvk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gakqh9+N8y277t4yrimRYNgRLI7iJhtLM39CxkuYYT//tEfiLE6q5qACrZRiCqrs
	 XttZYLFdxRhvpT1D0s4RH0PpH0auUxxV7V6ihmDPglA4tbdKaMUFTxoRtEl5KOoIU
	 CQoJJTK5iDCWwaETszWPudqKb+RTONQUJg8jxMcvevQVxulG46dQ5XAii+/aF0szG
	 +qtaKW/qOJy+81HfpGTySKD+C1yzq9DvT4Zub5HBHXiT7S2FjhuQER7FXkqE8Dxew
	 /nSoKD1AUtJ3YgtBem4W31oRa6ubpmq7A9lB+K9XGc+4MupDcS5Vkp7tMYQ5NqE33
	 KkLwnIhiZyv/vgvQDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1ui9Q61Ans-0065mb for
 <git@vger.kernel.org>; Thu, 04 Sep 2025 19:58:26 +0200
Message-ID: <e0bc9a67-faa9-4218-a55a-c7d53c15cfce@web.de>
Date: Thu, 4 Sep 2025 19:58:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] object-name: declare pointer type of extend_abbrev_len()'s
 2nd parameter
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:66aNCb9mcqcWQYX4xZ28BltCljxZ15xZGv+5enALz1W5LmSfqmD
 uh5z+PFAuFlH08UNQgttlWq5DHVbORbEPyfdy93U9JgLaICm9HE88x7zOHsUo6dKgYjnM2Q
 1VW/5dsK/ZALf+g7LHMT6/Ol9/LrUSjOmogBJwnYOFh6BWZPyQXIzYkPVm2WpimBclwuFZB
 zPQvOGtoSaKPEFIM6HJSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Db2xyCyW61g=;HFr1WlGkzTzLq06edeTGc1lDR4z
 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
 1j7Be8gZhVn+9CxeWuGzeZWW7bZx

Expose the expected type of the second parameter of extend_abbrev_len()
instead of casting a void pointer internally.  Just a single caller
passes in a void pointer, the rest pass the correct type.  Let the
compiler help keeping it that way.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 object-name.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index 732056ff5e..1e0118e8a6 100644
=2D-- a/object-name.c
+++ b/object-name.c
@@ -696,10 +696,9 @@ static inline char get_hex_char_from_oid(const struct=
 object_id *oid,
 		return hex[oid->hash[pos >> 1] & 0xf];
 }
=20
-static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
+static int extend_abbrev_len(const struct object_id *oid,
+			     struct min_abbrev_data *mad)
 {
-	struct min_abbrev_data *mad =3D cb_data;
-
 	unsigned int i =3D mad->init_len;
 	while (mad->hex[i] && mad->hex[i] =3D=3D get_hex_char_from_oid(oid, i))
 		i++;
=2D-=20
2.51.0
