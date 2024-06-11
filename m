Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8138DC0
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110092; cv=none; b=a1H266jiHeax1xQZGM/JtrImjs3EbWBEZsnGRC+l3EJkDMlq4mbZw5GkdvnNDyYWTndNwn8uhPlY3GnkRrEmy3skjsFTBKl7JP+p1juRfHhVpYRsdLJQNyZyuqGXQxquZ49rPayGN9UBuflVS2/OYtA2uBlN/RQLd3w3fWYFX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110092; c=relaxed/simple;
	bh=5mYRGL9m5qa44K7gF97PNuxZeSLVq4qYb39pOKUE8Ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SLo+3eMlnKtU2cfyRlpBwLhNYAU+neZZc+Ga7rddVsL41B+7wO7rbvGDbv2kbeGKzj1JHFLVVw15FXQPvY1zVHEL6rEKix0XDKwbMldfeBsif+vSNpQ1dgMeHjdrQeQr6OKy+3IN0tyJ0K5edqMVbnroZb2+/PhDfZIPYSLALEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Qi8c3CdC reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Qi8c3CdC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=VOLVEHn9kbmJ8PagAxxN7FH+o+oAhqhh5ePWaMiC2lk=; b=Q
	i8c3CdCxDgyDJkTPG2Kh3ADjzYsKYAYjUbYRreSSRNt1yD+R60Vf4gi87JlWBd2L
	idUGSlQEff3vUVfglkw2zfToOsp55un/CtpTF4Mhntn/lVvRvyRMLTD0Dl2Ae4Js
	v2qg3yu9hj1aCrlX7/m/RyEIQsYGjc0+6CJoWsF1aE=
Received: from bupt_xingxin$163.com ( [124.160.72.194] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Tue, 11 Jun 2024 20:47:54 +0800
 (CST)
Date: Tue, 11 Jun 2024 20:47:54 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v5 3/4] unbundle: extend options to support object
 verification
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZmgUrQ6D1xtQghPy@tanuki>
References: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
 <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
 <0a18d7839be67d6c0be137c7e15dff9663a161a8.1718088127.git.gitgitgadget@gmail.com>
 <ZmgUrQ6D1xtQghPy@tanuki>
X-NTES-SC: AL_Qu2aCv2av0gs4iGbbekXn0oVhe85UMW2ufsg3YReP500tybfyC0GVFZYMX/T68KUCwGCmTGHaR5A8MFGZZd2TpyJ3O3Gh1ZG3nc5tY/5g7vv
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5b47b697.c049.19007573522.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3Pwx6R2hmNTsyAA--.29600W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiLx-6bWVOEM-H6AABs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNi0xMSAxNzoxMTowOSwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6Cj5PbiBUdWUsIEp1biAxMSwgMjAyNCBhdCAwNjo0MjowNUFNICswMDAwLCBYaW5nIFhp
biB2aWEgR2l0R2l0R2FkZ2V0IHdyb3RlOgo+PiBGcm9tOiBYaW5nIFhpbiA8eGluZ3hpbi54eEBi
eXRlZGFuY2UuY29tPgo+PiAKPj4gVGhpcyBjb21taXQgZXh0ZW5kcyBvYmplY3QgdmVyaWZpY2F0
aW9uIHN1cHBvcnQgaW4gYGJ1bmRsZS5jOnVuYnVuZGxlYAo+PiBieSBhZGRpbmcgdHdvIG5ldyBv
cHRpb25zIHRvIGB2ZXJpZnlfYnVuZGxlX2ZsYWdzYDoKPj4gCj4+IC0gYFZFUklGWV9CVU5ETEVf
RlNDS19BTFdBWVNgIGV4cGxpY2l0bHkgZW5hYmxlcyBjaGVja3MgZm9yIGJyb2tlbgo+PiAgIG9i
amVjdHMuIEl0IHdpbGwgYmUgdXNlZCB0byBhZGQgIi0tZnNjay1vYmplY3RzIiBzdXBwb3J0IGZv
ciAiZ2l0Cj4+ICAgYnVuZGxlIHVuYnVuZGxlIiBpbiBhIHNlcGFyYXRlIHNlcmllcy4KPj4gLSBg
VkVSSUZZX0JVTkRMRV9GU0NLX0ZPTExPV19GRVRDSGAgaXMgZGVzaWduZWQgdG8gYmUgdXNlZCBk
dXJpbmcgZmV0Y2gKPj4gICBvcGVyYXRpb25zLCBzcGVjaWZpY2FsbHkgZm9yIGRpcmVjdCBidW5k
bGUgZmV0Y2hlcyBhbmQgX2J1bmRsZS11cmlfCj4+ICAgZW5hYmxlZCBmZXRjaGVzLiBXaGVuIGVu
YWJsZWQsIGBidW5kbGUuYzp1bmJ1bmRsZWAgaW52b2tlcwo+PiAgIGBmZXRjaC1wYWNrLmM6ZmV0
Y2hfcGFja19mc2NrX29iamVjdHNgIHRvIGRldGVybWluZSB3aGV0aGVyIHRvIGVuYWJsZQo+PiAg
IGNoZWNrcyBmb3IgYnJva2VuIG9iamVjdHMuIFBhc3NpbmcgdGhpcyBmbGFnIGR1cmluZyBmZXRj
aGluZyB3aWxsIGJlCj4+ICAgaW1wbGVtZW50ZWQgaW4gYSBzdWJzZXF1ZW50IGNvbW1pdC4KPj4g
Cj4+IE5vdGUgdGhhdCB0aGUgb3B0aW9uIGBWRVJJRllfQlVORExFX0ZTQ0tfQUxXQVlTYCB0YWtl
cyBwcmVjZWRlbmNlIG92ZXIKPj4gYFZFUklGWV9CVU5ETEVfRlNDS19GT0xMT1dfRkVUQ0hgLgo+
Cj5UaGFua3MsIHRoZSBuZXcgc2VxdWVuY2Ugb2YgY29tbWl0cyBpcyBtdWNoIGVhc2llciB0byBm
b2xsb3cuIEl0IGFsc28KPnNob3dzIHRoYXQgdGhlcmUgaXMgbm8gdXNlciBvZiBgVkVSSUZZX0JV
TkRMRV9GU0NLX0FMV0FZU2AgYXQgdGhlIGVuZCBvZgo+dGhpcyBzZXJpZXMuIFNvIG1heWJlIHdl
IHNob3VsZCBkcm9wIHRoYXQgZmxhZz8KCk9LLCBsZXQncyBmb2N1cyBvbiB0aGUgZmV0Y2hpbmcg
c2NlbmFyaW9zIGluIHRoaXMgcGF0Y2ggc2VyaWVzLgoKPklmIHlvdSBkbyB0aGF0LCB0aGVuIEkn
ZCBhbHNvIHByb3Bvc2UgdG8gbWVyZ2UgcGF0Y2hlcyAyIGFuZCAzIGludG8gb25lCj5naXZlbiB0
aGF0IGJvdGggYXJlIHF1aXRlIHRyaXZpYWwgYW5kIHJlbGF0ZWQgdG8gZWFjaCBvdGhlci4KCkkg
bWVyZ2VkIHBhdGNoZXMgMyBhbmQgNCBpbnN0ZWFkIHRvIGNvbWJpbmUgdGhlIG5ldyBvcHRpb24g
ZGVmaW5pdGlvbiBhbmQgdXNhZ2UKbG9naWMsIGFzIHRoZSB0d28gYXJlIG1vcmUgY2xvc2VseSBy
ZWxhdGVkIGFuZCBtb3JlIHRyaXZpYWwuIDopCgpYaW5nIFhpbgoKPk90aGVyIHRoYW4gdGhhdCB0
aGlzIHNlcmllcyBsb29rcyBnb29kIHRvIG1lLgo+Cj5QYXRyaWNrCj4KCg==
