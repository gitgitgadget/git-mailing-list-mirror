Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415879;
	b=tMrv8XNt4kIDZZIydmVEFAy6FZRcDg0juhKdTp4VqQRbdoFzJT1Xf0MdZyyUlbwwJU3g
	 zdGpRHAYV8sziEzAnuTaaXJUYPGXNXwnSY4ac/1SnH3sxz8/Vjg7rNzeAarCTYJpZs/TY
	 JSLwGuhRGvMYwksR6G333NtNqzrr8l4v0GF/R0lTdtmGwCPUYKsWQm/OoAXbEJHyL/cvz
	 BF6Dl/1RVdioReuVie69Qr0itJthN0tsbHfTH1xsk/J+J13Lck1BwbZe6x5jJVko+K+/f
	 N3sOYTvNMXAfnPexkboWzQaHeHsTpscTpoZK8Poz7zy4T6gLTUxJVj44xv/XkpuLTTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415879;
	h=DMARC-Filter:DKIM-Signature:X-QQ-USESPAMBG:X-QQ-XMRINFO:
	 X-QQ-XMAILINFO:From:To:Subject:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-Priority:Message-ID:X-QQ-MIME:
	 X-Mailer:X-QQ-Mailer:X-QQ-mid;
	bh=VOCRRyu+pfoSw1k5JnHmtUWtJTBOocP/YNkkmqpYYlQ=;
	b=uRjjHxGpL4vEml9nUxy5To3wCSGfe1CIyrhp4fKL2vUcElKm+MNL4MwBgq6cS5ICPJDI
	 aDvfyBRmi1N/dFkel5Kh/jPPezbvQ4A8i+dvAKOp1SkwkNHJQLlibPK0YH/Hfi5KmD0Fn
	 7WN+jHLIZUE3wltbj4N5g8mhIAANjzbuRJIBzss72qLuuxJkY+Oq3820WdrKZpQwrBzKi
	 5s8/JHGOX1XhBQfRwuntSQ1JauvUOicECfhvCq85bSR3Eso5jwv/lrAZZ9Ww+0ioKqOT5
	 ZRdrgKBja1BHZj9owYkuMyEEu79pGvqOi56WLlMGGLFi2VFaKcmygmAWywN6W44GMNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=YdqeeNZF;
	arc=none smtp.remote-ip=203.205.221.250
Received: from out203-205-221-250.mail.qq.com (out203-205-221-250.mail.qq.com [203.205.221.250])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123B606A88A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F123B606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=YdqeeNZF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794415868;
	bh=VOCRRyu+pfoSw1k5JnHmtUWtJTBOocP/YNkkmqpYYlQ=;
	h=From:To:Subject:Date;
	b=YdqeeNZFLpHo6W3G4HQzb6h0TLk76YKZwi4Q/6rTS7cpY3pJfYVYt3hFjSdwXvJE6
	 W3KgMaZ8cdBJQMw7rGlWnN+3kxLmfr6/TOtQ4RP3PxZe/1nnl2QnnxnAUAaVjLks6g
	 PU5heyMFw1aeg/+cp27wfYO002pS/wwlOWY7/r60=
X-QQ-USESPAMBG: true
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: NnBlO8MsmACrlD7QnE8E83tmlOUTpc1Ly17B2SivjZV67pvj8pSuyNwX8kCkJs
	 PGtbw9cbEetuuXWKewMhseTI9n2UdbMetg9Jy3X8uJr9Fm/Ag3pEceq2k7pYFa2Qf/ZzZ+Us68MpE
	 KeBL3WFS5Ip7Wph57phHpv6rAHgyNTBooQjUEucVgMx8Oh31sZKa3u9aPCqMU1qzlUGdcH1xJjrte
	 9X2PgWMa4pMc9lglNwKuNEuLSUVhDKkL42D5YDa6tP4lLecfKBin5ETxcD+/P9ivRmQLbNkNif25W
	 USLeXtXtMHTp66d4FI69AA+0kw2yWNfdTTTJYL70kDDYbl6k/o8RZx3D4TwuB1Kxy4rQjj96UAQUk
	 Hk/Wu0GfWf05BQ61gauPJ50WckG70eFLCwfs5kfP/Qs5vQUh5KopYBbEq/5I33G1Z9ha3UbLSc8op
	 EZ5hWcJtkx8crxmWP6khEfHH/MNUgbpheCKnzEAe4JZeBcEEfegYz2X7+9DTwpSUlgUHQKU5+e0/6
	 ShoNWQfBltcd7yHMtREmzLv/X9Xc9fSeqbDEDli7KYitYA7TBzBPx6reYyrJHHvNq3lkGDxiSDItv
	 x+Hc1xPW/tlMQAPYm+q7foTnuxXrndxzKnt0ZtSY387Sxeylf5Hs/aKRF28JjROwGwDC+jWQzdJqJ
	 F+Us1MMaPI8E49YEwqj3QFIl7ncat/LUvDEPFQNilj/taKFDvpsoP4hIm+ksdC8h6AKekLUKvHWFL
	 N9SKs1E9gEbmDhu0P6OHwclzzGWq8ubYNVldBGB+IcfFpY0dDJxZRw8HvV3lKvaGD433WXGzgG1Hj
	 CvOCvkkPmJhFxXAeZ+L8YUEymRJIorH88sTa10s8w5jMzQ1Ox+kgFk/WcSkFuxyREh52DKb7+EbHr
	 NLspJGAKRIam69o4HAbAHQl14jf2MFx+8PB3JLfH6pVFYNQChnJ2zOF8m+BcU9kOGH5gZzoKqGrvl
	 63YRcnaXpY4F+VSVYuRFupcwJ9GksNYQ+yjxdgMx+Ba48O53kqU2EK7im0rlwQpTTpiPFaoztf93W
	 iVDtHrWG1yZrR3Z82pE23MCDjGjBf63fCpw6mi66ROj49zq7KwyDuyWAt1uFIwy9gK6XrgWJLz+tB
	 Acw=
From: "=?utf-8?B?a29uZ2ZhbmthaWthaQ==?=" <kongfankaikai@foxmail.com>
To: "=?utf-8?B?Z2l0?=" <git@vger.kernel.org>
Subject: [BUG] repack --drop-filtered aborts when a filtered blob is referenced by the index
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 12 Nov 2026 00:51:07 +0800
X-Priority: 3
Message-ID: <tencent_AC7FF23968DCD0078A6B863A42BCB5ED4E05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb58-0t1794415867tnlsodndh

SGkgR2l0IGRldmVsb3BlcnMsCgpJIHJhbiBpbnRvIGFuIGlzc3VlIHVzaW5nIGBnaXQgcmVw
YWNrIC0tZHJvcC1maWx0ZXJlZGDCoGluIGEgcGFydGlhbCBjbG9uZSByZXBvc2l0b3J5LgoK
UHJvYmxlbQoKV2hlbiBhIGJsb2Igc2VsZWN0ZWQgYnkgdGhlIGZpbHRlciBmb3IgZHJvcHBp
bmcgaXMgcmVmZXJlbmNlZCBieSB0aGUgY3VycmVudCBpbmRleCwgR2l0IGFib3J0cyB0aGUg
ZW50aXJlIHJlcGFjayB3aXRoOgoKYGZhdGFsOiBjYW5ub3QgZHJvcCAncGF0aC90by9sYXJn
ZS1maWxlLmJpbicgKG9iamVjdC1pZCk6IGl0IGlzIHJlZmVyZW5jZWQgYnkgdGhlIGN1cnJl
bnQgaW5kZXhgCgpUaGlzIHN0b3BzIG90aGVyIGVsaWdpYmxlIGJsb2JzIGZyb20gYmVpbmcg
ZHJvcHBlZCwgZXZlbiB0aG91Z2ggdGhvc2UgYmxvYnMgYXJlIG5vdCByZWZlcmVuY2VkIGJ5
IHRoZSBpbmRleC4KCkV4cGVjdGVkIGJlaGF2aW9yCgpJ4oCZbSB3b25kZXJpbmcgaWYgR2l0
IGNvdWxkIHNraXAgYmxvYnMgcmVmZXJlbmNlZCBieSB0aGUgaW5kZXggYW5kIGNvbnRpbnVl
IGRyb3BwaW5nIHRoZSByZXN0IG9mIHRoZSBlbGlnaWJsZSBvYmplY3RzLCBpbnN0ZWFkIG9m
IGFib3J0aW5nIHRoZSB3aG9sZSBvcGVyYXRpb24uCgpGb3IgZXhhbXBsZToKCkJsb2IgQTog
ZWxpZ2libGUgZm9yIGRyb3BwaW5nLCBub3QgcmVmZXJlbmNlZCBieSBpbmRleCDihpIgZHJv
cAoKQmxvYiBCOiBlbGlnaWJsZSBmb3IgZHJvcHBpbmcsIHJlZmVyZW5jZWQgYnkgaW5kZXgg
4oaSIHNraXAKCkJsb2IgQzogZWxpZ2libGUgZm9yIGRyb3BwaW5nLCBub3QgcmVmZXJlbmNl
ZCBieSBpbmRleCDihpIgZHJvcAoKVGhlIHJlcGFjayBjb3VsZCBjb21wbGV0ZSBzdWNjZXNz
ZnVsbHksIG9wdGlvbmFsbHkgZW1pdHRpbmcgYSB3YXJuaW5nIGZvciBza2lwcGVkIGJsb2Jz
LgoKUXVlc3Rpb24KCklzIHRoZXJlIGEgc3BlY2lmaWMgcmVhc29uIHRoaXMgY29uZGl0aW9u
IGlzIHRyZWF0ZWQgYXMgZmF0YWwgcmF0aGVyIHRoYW4gc2tpcHBpbmcgdGhlIGFmZmVjdGVk
IG9iamVjdHM/CgpUaGlzIGJlaGF2aW9yIHdvdWxkIGJlIGVzcGVjaWFsbHkgaGVscGZ1bCBm
b3IgcGFydGlhbCBjbG9uZXMgd2l0aCBsYXJnZSB3b3JraW5nIHRyZWVzLgoKVGhhbmtzIQoK
CgoK

