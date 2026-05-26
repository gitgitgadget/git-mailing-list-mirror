Received: from mail.fhannenheim.net (mail.fhannenheim.net [188.245.251.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E51922FD
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.251.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814245; cv=none; b=MuhMqz+7q37RU07A4a+OzTBxUqyguqzzny1J4J2WDlbPJ1cRSSZL6EYxqjyXGzwsNuvhOA7mbDTLGiLYHW0w1CXfyzFWXZTU/U2R1iTzBpoH3513mXENjBpTy8fst3OxtfMY/5Zqjn9JkySACi/1u5HvnAnxf6l+Vz6ojmByfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814245; c=relaxed/simple;
	bh=eYSY84fF1MJc2Bp5ty0BrtdUBEJPMbpWaLiOVnEzFvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHcfGn9bxFUxIHOigtioFkPXRvRXvaKZ9glJ/rfSUdFvAJojZrOyIp6X61JV1VMpAbPAX9v03lotuy4+0KTD7UAYE9tfZdrc6DzJNA1jP9lXiSmFoj9A2z2bI8xxMEry2an038No+3IINs7+4teBQEZx/b/CmSPlXB/d3i+jwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fhannenheim.net; spf=pass smtp.mailfrom=fhannenheim.net; dkim=pass (1024-bit key) header.d=fhannenheim.net header.i=@fhannenheim.net header.b=afPTag8D; arc=none smtp.client-ip=188.245.251.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fhannenheim.net header.i=@fhannenheim.net header.b="afPTag8D"
Message-ID: <1343ca51-c8a8-4a86-9b46-02468a92b98f@fhannenheim.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fhannenheim.net;
	s=mail; t=1779814240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eYSY84fF1MJc2Bp5ty0BrtdUBEJPMbpWaLiOVnEzFvg=;
	b=afPTag8D6WeA0wwHD5fSaEcS48sA0rLh7G5y8w3xlW5mwVi5Ors6ofaXU88PTqpzegJlpp
	hQBY4BXBbyKoFZdUAdUSAcrVq5qvEGxKpCLRX9AKb3ao8BgFNvHiOFU0IMZbUzIaCDOq2P
	zG1Y39AeOS5w7QLE9KJBn76IrZ34gLs=
Date: Tue, 26 May 2026 18:50:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: git mv after the fact
To: Chris Torek <chris.torek@gmail.com>
Cc: git@vger.kernel.org
References: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
 <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
Content-Language: en-US
From: Frieder Hannenheim <mail@fhannenheim.net>
Autocrypt: addr=mail@fhannenheim.net; keydata=
 xjMEaX+iTBYJKwYBBAHaRw8BAQdAjgnNmu6pLzUJq/DD3ZU3tTbKzC2npfFhEK6NYMLRukrN
 KUZyaWVkZXIgSGFubmVuaGVpbSA8bWFpbEBmaGFubmVuaGVpbS5uZXQ+wpAEExYKADgWIQRD
 lxn4P3kTLC9X/iFsAXPIt5MeUwUCaX+iTAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
 CRBsAXPIt5MeUzNaAP9KklaL+chH1bUa7To1Pn346guR/N/PkMkyvWgKRs+yzwEA6N2E6TZ6
 CJF8cW6gVaSFmNgGcGZUAw5A5MrUleV5PwPOOARpf6JMEgorBgEEAZdVAQUBAQdA51B2jbQ4
 iUnmggSYEqwukOYQmjBwsyUpc8Wkk9I8qkYDAQgHwngEGBYKACAWIQRDlxn4P3kTLC9X/iFs
 AXPIt5MeUwUCaX+iTAIbDAAKCRBsAXPIt5MeU3oKAQDyZDbjdjzNsJdliBQBkZXuaJDAB1Mn
 59LycSSRsRVCPQEAmNQIItBArt/kiQFu6vC4mXjtM5LzbPLmj/QA26ee2Qk=
In-Reply-To: <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SW4gbXkgcGFydGljdWxhciB1c2UgY2FzZSBJIGNoYW5nZWQgYSBwYXRjaCB0byBiZSBhIGdp
dCBwYXRjaCB3aXRoIGENCmNvbW1pdCBtZXNzYWdlIGFuZCBkaWZmZXJlbnQgZmlsZW5hbWUg
c28gdGhlIG1vdmUgd2FzIG5vdCBkaXNjb3ZlcmVkDQphdXRvbWF0aWNhbGx5LiBCdXQgSSdt
IG5vdCBzdXJlIGlmIEkgc3RhZ2VkIHRoZSBmaWxlcyBzbyBtYXliZSBpdCB3b3VsZA0KaGF2
ZSBiZWVuIGRpc2NvdmVyZWQuDQoNCkZyaWVkZXINCg0KT24gMjYuMDUuMjYgMTg6NDAsIENo
cmlzIFRvcmVrIHdyb3RlOg0KPiBPbiBUdWUsIE1heSAyNiwgMjAyNiBhdCA2OjE44oCvQU0g
RnJpZWRlciBIYW5uZW5oZWltIDxtYWlsQGZoYW5uZW5oZWltLm5ldD4gd3JvdGU6DQo+PiBJ
J2QgbGlrZSB0byBwcm9wb3NlIGEgbmV3IGZsYWcgZm9yIGdpdCBtdiwgdGhhdCB1cGRhdGVz
IHRoZSBpbmRleA0KPj4gbGlrZSBnaXQgbXYgbm9ybWFsbHkgd291bGQgYnV0IGRvZXMgbm90
IG1vdmUgdGhlIGZpbGUuIC4uLg0KPiBZb3UgbWF5IGFscmVhZHkga25vdyB0aGlzLCBidXQg
dGVjaG5pY2FsbHkgbm8gZmxhZyBpcyBuZWVkZWQ6DQo+IHlvdSBjYW4ganVzdCAiZ2l0IGFk
ZCIgdGhlIG5ldyBuYW1lIGFuZCAiZ2l0IHJtIiB0aGUgb2xkIG9uZSwNCj4gd2l0aCB0aGUg
c2FtZSBlZmZlY3QuDQo+DQo+IEEgZmxhZyBmb3IgImdpdCBtdiIgd291bGQgYmUgY29udmVu
aWVudCAoYW5kIHNsaWdodGx5IG1vcmUNCj4gZWZmaWNpZW50LCBub3QgaW4gdGVybXMgb2Yg
c3RvcmFnZSBidXQgaW4gdGVybXMgb2YgQ1BVIHRpbWUNCj4gc3BlbnQgZGlzY292ZXJpbmcg
dGhhdCB0aGUgY29udGVudHMgdW5kZXIgdGhlIG5ldyBuYW1lDQo+IGFscmVhZHkgZXhpc3Qg
aW4gdGhlIG9iamVjdCBkYXRhYmFzZSkuIEJ1dCBHaXQgd2lsbCBkaXNjb3Zlcg0KPiB0aGUg
cmVuYW1lIG9uIGl0cyBvd24gaW4gdGhlIHVzdWFsIHdheSByZWdhcmRsZXNzIG9mIGhvdw0K
PiB5b3UgZ2V0IHRvIHRoYXQgcG9pbnQuDQo+DQo+IENocmlzDQo=
