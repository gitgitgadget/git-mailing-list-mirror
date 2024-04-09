Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE516E5EF
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645589; cv=none; b=rCXkkQmIfoEboiLlwCTSozpMFgGhA3AitEDjSamV4NB3FI2yfe2ApZo7REbaJm0u5bh0rbK09y7eVs99QOBgQO+sdK8B6WSDKGEA6CgoY5yto6+cyPG/Ml+/aic9cxEc3Kk996mLxtonfgeI7oEFerJLfUAf0ULbRX5eX+Q7eEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645589; c=relaxed/simple;
	bh=fgrcIbNpmrn8zHi0j+0m7Ys1hXg0MUiFtM3SbIhl94k=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=sd95FRBIEiPLdrknUMyUQ9ZYismjPQ3HYRZeunwKGZ5WhsidLRQydgLGiHVyIkQuJIP6WcvbCJIILZvK/OSXJ9tYShiV3nJcWDvS9M0aJOyilZEa49r+y4gQCYpkCXffbq0nw0Z1WzJhM7mRXcLDh0xTU85NhAtCyenQcuFdocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=e3OoIRGr; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="e3OoIRGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1712645582;
	bh=fgrcIbNpmrn8zHi0j+0m7Ys1hXg0MUiFtM3SbIhl94k=;
	h=From:To:Subject:Date;
	b=e3OoIRGrtGZyiyPZava2jrQgukl8mba5jsuCHlZtuAj3OcVNCTRpUnwJYWtS5LYoH
	 0CSMvi9i7TjYbgJBeYL8ilu+vz6wUaZoSiELWhIYNfdUkraNi5U7ceWt+V6GlB9ieL
	 gqVPvtYLUHQRRZr9kJwNlHJoZ/EjLnGsgGp6jET0=
X-QQ-FEAT: oHWrrGTW1dCni6VLWI7Xi3lwP5c1dnPf
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-XMAILINFO: N0JG5d2dvsRDR5j+walb2+tOIrSQaKtu3s8abVYIcceN1sLAYAmBleEQKFfD0M
	 hFdRM1prhGcnS25+64VqeF0CnbIrf4g2pmtLJlBBw/QdZyw5ZgyvkoY5XqUlatqLRG1EjRcRk3Q0r
	 C07AM9yCA9fVipv2TboDnDVGun5N274mt6uSRCaC1/abU5iF6hhBw63HZJuUPEhHz6Srgji+wmOnL
	 PQhusmMctBiRXHn1kC0gTWW/5D1bOWdIEKDxZo6t9p0ncVnwnavo/kJ7aCwi5fjah8L1M01Xr4kkP
	 6N9i5WsxQ9OAyvEThmCHcGcuBIcUUAhx5fqjo7dEMZ/j98OZW2xnFRM/oI5RAiJShc3KA06ndFyLy
	 tb52Yz32jsdVAHs7lWe40ueP5iUPs7o8fvMBCf4wxRN08g673cU5rnwgUqDp7evr94c9/T+vrDbmd
	 ZvBu75mKzNmRJpeqG7YGF+Rzku6xHRAJYPQEv9Dk5xByd+8rb7asdEbphsG2fq7/EbPANV2z28Hmx
	 VaaBUXrWQfoJgS5teeKwjG9mXKBmWFYNWZTl1cvnEH/Di50IOGUt3unKS8Ls0in11pibXJQenCe+W
	 X7qSoRVymyj5zLdsbFnGa0jBQcNEe/YOC8Us2o7dfEglrDdy2P0JWugfvwWBYlgfH0Lq18gMo2zBF
	 lxVMTaLcyEjlisWygcQtgxRk8pKJHthVYOYDZY+AUlkPNDg2Lc/igY4vqAcXPmjzhtPqvtyD5QHji
	 Zg4kkUpI3G/LC7F40E+8OCFOFM3ZarcJc6jRWgMPpp8Q99loHhazLw9ZUvP7l+HnTzNq6vMdnBulx
	 8Xb2Nj2K2NxobaqAkjQZ7U+RaNQBMO+aWtYXa6a68YVVLhnhG8hXTLhZOLlwxpPQUhvINgjZR9OQ/
	 AzVp3Cg1wprmZtNAzmxoMKZ9tQtcvn6UUyZd3TNWGthEr3RLZE68BcKMM+bbJigkMgM3wP4doD/RS
	 uu36xLy+ygsGdvNGyK/aCCjYEJ8IEUWJVRLoYEu1CydEFKHYR66W31K5sBVks=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail431t1712645582t5641427
From: "=?gb18030?B?Z29yZG9ud3dhbmc=?=" <gordonwwang@foxmail.com>
To: "=?gb18030?B?Z2l0?=" <git@vger.kernel.org>
Subject: git bug Report: Inconsistent behavior caused by [] in.gitignore
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
Date: Tue, 9 Apr 2024 14:53:02 +0800
X-Priority: 3
Message-ID: <tencent_A24B502465766F850E47E415283861089809@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

MS4gV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpCkNyZWF0ZSBhIGdpdCByZXBvc2l0b3J5IGluIHRoZSBm
b2xsb3dpbmcgZGlyZWN0b3J5OgouCnwtLSBmb2xkZXIxCnwgICBgLS0gYS50eHQKfC0tIGZv
bGRlcjEzCnwgICBgLS0gYy50eHQKfC0tIGZvbGRlcjIKfCAgIGAtLSBiLnR4dApgLS0gZm9v
LnR4dAoKMyBkaXJlY3RvcmllcywgNCBmaWxlcyIKClRoZW4gZWRpdCAuZ2l0aWdub3JlIGFu
ZCBlbnRlciB0aGUgZm9sbG93aW5nOiIKIyAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAt
LSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAt
LSAtCiMgSU5WQUxJRCBGSUxFUwojIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0t
IC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0K
Zm9sZGVyMVsvXQpmb2xkZXIyLwpmb2xkZXIxWzNdCiIuCgoyLiBXaGF0IGRpZCB5b3UgZXhw
ZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpFeGVjdXRlIGBnaXQgc3RhdHVz
YCBhbmQgb2JzZXJ2ZSB0aGF0IG9ubHkgZm9vLnR4dCBpcyBiZWluZyB0cmFja2VkLgoKMy4g
V2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQpFeGVjdXRlIGBnaXQg
c3RhdHVzYCBhbmQgb2JzZXJ2ZSB0aGF0IGZvbGRlcjEvLCBmb28udHh0IGFyZSBhbGwgdHJh
Y2tlZC4KCjQuIFdoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBh
bmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8KRXhlY3V0ZSBgZ2l0IHN0YXR1c2AsICBmb2xk
ZXIxLyBzaG91bGQgYmUgaWdub3JlZC4KCjUuIEFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8g
YWRkOgpXZSBzZXQgdXAgdHdvIGNvbnRyb2xsZWQgdHJpYWxzIGluLmdpdGlnbm9yZToKMS4g
Zm9sZGVyMVsvXSBhbmQgZm9sZGVyMVszXS4gVGhlIGZvbGRlcjEzIGRpcmVjdG9yeSBpcyBp
Z25vcmVkLCBpbmRpY2F0aW5nIHRoYXQgdGhlIHBhcmVudGhlc2VzIFtdIHdvcmtlZCBmb3Ig
dGhlIG51bWJlciAzLCBvbmx5IGZvciB0aGUgc2xhc2ggLy4gKFRoZSByb2xlIG9mIHRoZSBw
YXJlbnRoZXNlcyBbXSBpcyB0byBzZWxlY3Qgb25lIG9mIHRoZSBjaGFyYWN0ZXJzLCBpbiBv
cmRlciB0byBzaG93IGEgc2hhcnAgY29udHJhc3QsIEkgb25seSB3cm90ZSBvbmUgY2hhcmFj
dGVyLCBwbGVhc2UgaWdub3JlIHRoaXMgc21hbGwgZGV0YWlsKTsKMi4gZm9sZGVyMVsvXSBh
bmQgZm9sZGVyMi8uIFRoZSBmb2xkZXIyLyBkaXJlY3RvcnkgaXMgaWdub3JlZCwgYW5kIHRo
ZSBmb2xkZXIxLyBkaXJlY3RvcnkgaXMgbm90IGlnbm9yZWQgYXMgZXhwZWN0ZWQuCgpNeSBv
cGluaW9uOgpJbi5naXRpZ25vcmUsIHNldCChsGZvbGRlcjFbL10KZm9sZGVyMi+hsSwgdGhl
aXIgYmVoYXZpb3Igc2hvdWxkIGJlIGNvbnNpc3RlbnQsIHRoYXQgaXMsIGZvbGRlcjEvIGRp
cmVjdG9yeSBhbmQgZm9sZGVyMi8gZGlyZWN0b3J5IGFyZSBub3QgdHJhY2tlZC4KV2hlbiBs
b2dpYyBpcyBpbmNvbnNpc3RlbnQsIHVzZXJzIHdpbGwgZmluZCBpdCBkaWZmaWN1bHQgdG8g
dW5kZXJzdGFuZCBhbmQgYmVjb21lIHVubmVjZXNzYXJ5IGJ1Z3MuCgoKW1N5c3RlbSBJbmZv
XQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24gMi40MS4wCmNwdTogeDg2XzY0Cm5vIGNvbW1p
dCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApzaXplb2YtbG9uZzogOApzaXplb2Ytc2l6
ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gKdW5hbWU6IExpbnV4IDYuNi42LTI0MDEuMC4x
LjEub2NzMjMueDg2XzY0ICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgVGh1IEphbiAxOCAwOTo0
Mjo0OCBDU1QgMjAyNCB4ODZfNjQKY29tcGlsZXIgaW5mbzogZ251YzogMTIuMwpsaWJjIGlu
Zm86IGdsaWJjOiAyLjM4CiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6
IC9iaW4vYmFzaA==

