Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0E175AD
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719134240; cv=none; b=d1ERyU2GTt4eskLCYTybbhNtoBL8TsOtZMVms/ZrqLo3azsmWxqB2XuuCrFIZ/z6Nind6zQl0hOivBu4ssHg71QuALpLn9nMoOPj0rg9AgatfThgfBzIUw9Zk3REqyWhGStLMx4o/NFf7N4GmhtNKNaYaGjNi5kRCzqitM7L3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719134240; c=relaxed/simple;
	bh=qvrFcI3E0s0D2fQGeSMjH2IscxFLld9wMbZZtmXC5Eo=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=mZhCVtogOlrn4bO8+CQbaz1niak0UWIVw8XEhv43VtnAqmtGN8t+EuuDRP8GI/5AUZ99ASqMvagwOzt6rj+xuVQC+ggwWM2GVpjZqu7WBoeA8a3Nm5LeDWUEoUmN4/L8TLAYTDt8hvinhdB5RLvXqvKXc0mKVqhXnpnl2eooqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b=mvzAz8Y5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b="mvzAz8Y5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719134235; x=1719739035; i=lolligerhans@gmx.de;
	bh=qvrFcI3E0s0D2fQGeSMjH2IscxFLld9wMbZZtmXC5Eo=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mvzAz8Y5apwbw3VyQjSE+oXEDalDAo17DjQWelaZWQS/WttDjvcx86/eSa2/F4Ji
	 Za7QdPaXooVjMsNPEmTQUDNk52zudA/P3NLKeD01R1mRA0FXAQBnI0bNgmI+VkIUO
	 UkQLBXS+WgQzO+N70adqVn+pRrkmnn45q9znz77nVEhvTi9O6yoOgrhBWC9Yd4Dmg
	 CkCFbxeZzgFUAkTtjZZS9IyPXF3RTBdBL4rp4NqerbDqG6gvyncAcvhf44ZdJDAEE
	 1mscH7ETR2Ghdmps+593IP/K0DAjl82XCqlgC3YZwmrKkTipepzNkzP0cTNPnTi5b
	 u0/D4cYlbYe995UhPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [92.199.253.147] ([92.199.253.147]) by web-mail.gmx.net
 (3c-app-gmx-bap30.server.lan [172.19.172.100]) (via HTTP); Sun, 23 Jun 2024
 11:17:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-5166e20d-147e-4205-99b7-f13a007ed5f9-1719134235233@3c-app-gmx-bap30>
From: lolligerhans@gmx.de
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Aw: [PATCH] diff: allow --color-moved with --no-ext-diff
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 11:17:15 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de>
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
 <8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:o770PU6LC5Wc+Ie4Jw/rO8DoAp0xSZS4DH2YsERBx1OKHE3xfl2YVCYPq/1AUVleG+IPd
 gBok1/hqmKX38X6QH7t9qkKgvHyLMfIFwDkA3BXOzD1FzTQF3ALA/Kl3mUtcCX+TZ7A+Q42gYYFD
 xhbHv8anHrwd075Cre9m6NlE+lMI0DfNlOvagHU49l+fTXyYEwGDB1EROJGoM415loUW61s4YQIL
 /QaeG18QABageyAFcrYhOItS2Sy3AGP9yQ/g/k5eHmiEe/Ldrk6pn9eLa1Uy5+xnQJ1YA2nkb8cQ
 7o=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eDpMIto+sxQ=;ZFUGYlT+QMYWCnBp+4+oLGkzR0+
 11az0o7uFm4fEDo4ZTNM2A3WBvPIyWpq1r3XXc2FR9pZix95mzqM37zykVSl3ijoSBJTlbpuk
 UrQtvl+bbG65YBDgFkXCA8RGEF+zBWCGKt72z7AFdnT0BLnuPBRP4EqaFrSmc2utKlARLK3DU
 F2+K0+lL1uRgMS3LEbqxSMVeIV8WwEST8zatVc2fYQ4L3cnctK4sgZ9YquaLmioSUQ4KXwAAu
 FktGCjXJcRF047TfrEF/wy3tOOurDA1U15oU7xH7KyGHoVp6/MEX4tfMQf2efncBMLmIJXuEr
 T60lTkkXfFpmhtDAT8HDWZs36EepG/So+m79jiztopP/mLcArODJOe9q0lIFirKetWuN4EZy6
 B3Q4F0gECzQ74T8N9dRPKsV9JwgqBdzrDXjJaJ1FoKCD1Kcin/xk4YBpyfMfaCJ9j40XIpJNe
 YF9pRAi3qZXA9FxrloUfLNgh4nM3uL7fNnFCqhlQ8iSmX419gOpknoMiXFkyolztQ3JHn2pmu
 NhFAd02Ojt7+NQC59TFzqYeWSufThfE/1pWRzOupk8DVkmEs3K2BRfQqerWiU0Dpx2ClAIYjP
 4vcJWBAQGgQuUBE/sd3r+IbGZDOJsJMT9RduhtgEDKvQyc95y3qMYBZfDDqsyXzGTzbhypFIJ
 E23fCVLCzKutGmWb3N1tI2gn6yFSz/rMEuVBJL9zLB+z9xcywSZYvIWBmlrUcxw=

Hello Ren=C3=A9,

using red/green coloration is the current buggy behavior=2E When setting o=
ldMOved and newMoved I would expect the correct behaviour to the the same a=
s the buggy one=2E

Could this test pass despite the bug?
