Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBFE14AAD
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058830; cv=none; b=kn4GkBG9x+XSpIlLQx6Q6rI5sOownbztJqV2qoqm7CfTClcD/wdsVHX8gkk36UHlaHvZJk2X20ByXywJF5ERbCd183P4CuexIps+C/UhsYS7rEiaR0L9mjPH/d3JnFT21sdI7ucCGcKH/O6Vgq5isODBhDywnHObp4jrqCjPAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058830; c=relaxed/simple;
	bh=quWxHcHaYfCCjTB9P9IVtt2jtqKm7CIBcnF/S3T81vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HbYUxfeQi96IUf8+6pc49sPx0VJiuT8buwgiVSAH+XGpLwn0H6qitKYdTPmVLc7cRxRQVl41leCVN8QFYd37d1Hbh4UWqH038uUXFDOg3X8pfmiMNJWASkyV7qqB6OMRwpSEq67M5Lg0Hq+5Dn7+XWwrAiK15bLmswX0DKziO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=oy0IfRDl reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="oy0IfRDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=bxUMsCcctgnXHC5xZiZeDcyVKiHVraSAi9GYbGYV0dU=; b=o
	y0IfRDlEy1VsTaU3wh8QjONaKAQeGIshsIIzEjlM3TtHcrbNl4eAkPI7jh6X+hLJ
	1zaQPWYz0NXRRgE/6LibV0dgc1UwMfZIow9UfDU3pgKgjbjmSNs9LFjWw59xjIjq
	qnXKY5mj21iCJtOt9UqiZhcETUuPv0ZGRRHW5MG428=
Received: from bupt_xingxin$163.com ( [122.224.123.146] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Thu, 30 May 2024 16:46:50 +0800
 (CST)
Date: Thu, 30 May 2024 16:46:50 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: Re: [PATCH v3 2/4] unbundle: introduce unbundle_fsck_flags
 for fsckobjects handling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZlgC2TaXGjcNv2C0@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <057c697970ff49301cd9dc6adef099f53d440c3c.1716824518.git.gitgitgadget@gmail.com>
 <ZlXIDXfc_1lGb51J@tanuki>
 <1d097be.b642.18fc58dfb70.Coremail.bupt_xingxin@163.com>
 <ZlgC2TaXGjcNv2C0@tanuki>
X-NTES-SC: AL_Qu2aBfyet0Aq5iWaYekXn0oVhe85UMW2ufsg3YReP500mCTM4QcEQltABUHxzMyBNyqhlDytThRXwdhIdIxYfI6x72082WdsU71eO612ohii
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4d855732.8dfe.18fc8ae32a0.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_zD6PFhmR7hSAA--.50562W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiLwnubWVOD9PEDAAEse
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNS0zMCAxMjozODo0OSwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6CltzbmlwXQo+PiA+Cj4+ID5Xb3VsZG4ndCB0aGlzIGhhdmUgYmVlbiBhIG5hdHVyYWwg
Zml0IGZvciB0aGUgbmV3IGZsYWcsIGUuZy4gdmlhCj4+ID5zb21ldGhpbmcgbGlrZSBgVkVSSUZZ
X0JVTkRMRV9GU0NLYD8KPj4gCj4+IEl0IG1ha2VzIHNlbnNlIHRvIG1lLiBDdXJyZW50bHksIHZl
cmlmeV9idW5kbGVfZmxhZ3MgY29udHJvbHMgdGhlIGFtb3VudAo+PiBvZiBpbmZvcm1hdGlvbiBk
aXNwbGF5ZWQgd2hlbiBjaGVja2luZyBhIGJ1bmRsZSdzIHByZXJlcXVpc2l0ZXMuIFRoZQo+PiBu
ZXdseSBhZGRlZCB1bmJ1bmRsZV9mc2NrX2ZsYWdzIGlzIGRlc2lnbmVkIHRvIGNoZWNrIGZvciBi
cm9rZW4gb2JqZWN0cwo+PiBkdXJpbmcgdGhlIHVuYnVuZGxlIHByb2Nlc3MsIHdoaWNoIGlzIGVz
c2VudGlhbGx5IGEgZm9ybSBvZiBidW5kbGUKPj4gdmVyaWZpY2F0aW9uLiBJIGJlbGlldmUgd2Ug
c2hvdWxkIGV4dGVuZCBzb21lIG9iamVjdCB2ZXJpZmljYXRpb24KPj4gY2FwYWJpbGl0aWVzIHRv
IHRoZSBnaXQgYnVuZGxlIHZlcmlmeSBjb21tYW5kIGFzIHdlbGwsIHBlcmhhcHMgYnkgYWRkaW5n
Cj4+IGEgLS1mc2NrLW9iamVjdHMgb3B0aW9uLgo+PiAKPj4gV2l0aCB0aGlzIGluIG1pbmQsIEkg
c3VwcG9ydCBhZGRpbmcgbmV3IG9wdGlvbnMgdG8gdmVyaWZ5X2J1bmRsZV9mbGFncy4KPj4gU2lu
Y2UgYnVuZGxlLmM6dW5idW5kbGUgbmVlZHMgdG8gY29tYmluZSBtdWx0aXBsZSBvcHRpb25zLCB3
ZSBtdXN0Cj4+IGRlZmluZSBuZXcgb3B0aW9ucyB1c2luZyBiaXR3aXNlIHNoaWZ0aW5nOgo+PiAK
Pj4gCWVudW0gdmVyaWZ5X2J1bmRsZV9mbGFncyB7Cj4+IAkJVkVSSUZZX0JVTkRMRV9WRVJCT1NF
ID0gKDEgPDwgMCksCj4+IAkJVkVSSUZZX0JVTkRMRV9RVUlFVCA9ICgxIDw8IDEpLAo+PiAJCVZF
UklGWV9CVU5ETEVfRlNDS19PQkpFQ1RTX0FMV0FZUyA9ICgxIDw8IDIpLAo+PiAJCVZFUklGWV9C
VU5ETEVfRlNDS19PQkpFQ1RTX0ZPTExPV19GRVRDSCA9ICgxIDw8IDMpLAo+PiAJfTsKPj4gCj4+
IEhvdyBhYm91dCB0aGUgbmFtaW5nPyBJJ20gbm90IHZlcnkgZ29vZCBhdCBuYW1pbmcgOikKPgo+
SSBsYXRlciBub3RpY2VkIHRoYXQgeW91IGV4dGVuZCB0aGUgYHVuYnVuZGxlX2ZzY2tfZmxhZ3Ng
IGluIGEgbGF0ZXIKPnBhdGNoLiBXaXRoIHRoYXQgaW4gbWluZCBJIGRvbid0IHRoaW5rIGl0J3Mg
YWxsIHRoYXQgaW1wb3J0YW50IGFueW1vcmUKPnRvIG1lcmdlIHRob3NlIGludG8gdGhlIGB2ZXJp
ZnlfYnVuZGxlX2ZsYWdzYCBhcyB5b3Ugd291bGQgb3RoZXJ3aXNlCj5hbGxvdyBmb3Igd2VpcmRu
ZXNzLiBXaGF0IGhhcHBlbnMgZm9yIGV4YW1wbGUgd2hlbiBib3RoIGBBTFdBWVNgIGFuZAo+YEZP
TExPV19GRVRDSGAgYXJlIHNldD8KPgo+U28gZmVlbCBmcmVlIHRvIGlnbm9yZSB0aGlzIGFkdmlj
ZS4gSWYgeW91IHN0aWxsIHRoaW5rIGl0J3MgYSBnb29kIGlkZWEKPnRoZW4gdGhlIGFib3ZlIG5h
bWluZyBsb29rcyBva2F5IHRvIG1lLgoKV2l0aCB0aGUgaWRlYSBvZiBleHRlbmRpbmcgIi0tZnNj
ay1vYmplY3RzIiBzdXBwb3J0IGZvciAiZ2l0IGJ1bmRsZSB2ZXJpZnkiIGFuZAoiZ2l0IGJ1bmRs
ZSB1bmJ1bmRsZSIsIEkgcHJlZmVyIHRvIGdyb3VwaW5nIHRoZXNlIG9wdGlvbnMgdG9nZXRoZXIu
IEVzcGVjaWFsbHkKaW4gdGhlICJnaXQgYnVuZGxlIHZlcmlmeSIgc2NlbmFyaW8sIGFkZGluZyBh
IG5ldyBwYXJhbWV0ZXIgbGlrZQpgdW5idW5kbGVfZnNja19mbGFnc2AgZm9yIGBidW5kbGUuYzp2
ZXJpZnlfYnVuZGxlYCBpcyBjb25mdXNpbmcuCgpYaW5nIFhpbg==
