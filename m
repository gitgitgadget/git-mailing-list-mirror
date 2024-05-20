Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CB155C29
	for <git@vger.kernel.org>; Mon, 20 May 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205727; cv=none; b=S/slcQlZowFs8SV1lAcvar8avaZ/eJ/YVfK56ChnKl3PP32JsfrA6Pbnfmm1D9Sx30KwRskDwG4GqeD609lCzGRfMIr+7ZGBu2opXnL4Uj/ismnxhfQs1/Gi/3dyaUM29ecOVWmMV91FblsJZhJLLgHSOVuA25rufFROYGRR87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205727; c=relaxed/simple;
	bh=4BUcFFpxBQPo3j/hqQhEfNPgJIcFt4I3TPzoLA2L7sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bUJxWqHFwkcjMUqgiUK4oTub9h0Sa0QZAjA6lHkhn8kIWV6aGC0UEC+daBLNr3L5UAQOQ8KedttpDgCLATT4U+Jx7cCih3hp0mYUQJz5uURltSaBst+h10IceZ1Cfx0VYchLxxOtaSzRvB6In8tWfX7zwAiJGdB5LhLXWgJqgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=pNcylgnf reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="pNcylgnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=USnRMA0ZjLNxElkK01JMRYH8iFT8M9yfuUI2GCUsUNQ=; b=p
	NcylgnfHOFHHUmGC2EuBIPA0WushNF43ya9KvFeTEWLBLdjr8A07pRRr0y8YUWrN
	isTL0m1qwgOPFmFM7OjEIcuvUUDWjDVXWSaieyCY868B6kiz9VsyHX65GPFWd1Id
	cbVBofYHyOGdm4ZGu0o27NeUjOC+XonEKLVblTDeIQ=
Received: from bupt_xingxin$163.com ( [122.224.123.146] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Mon, 20 May 2024 19:48:08 +0800
 (CST)
Date: Mon, 20 May 2024 19:48:08 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, 
	"blanet via GitGitGadget" <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, "Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH] bundle-uri: refresh packed_git if unbundle succeed
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <xmqqikzcl8js.fsf@gitster.g>
References: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
 <ZkbkgT46mdNEhcf0@tanuki> <xmqqikzcl8js.fsf@gitster.g>
X-NTES-SC: AL_Qu2aBP6buk4j7imfYukXn0oVhe85UMW2ufsg3YReP500qSTMwRk6Q2JiOkr63921CCa3rQWudSJh1856bYpffZCj5SLWtxeTJzlt9ib2cOJZ
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5e61daf6.ba64.18f95d49895.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v2R4OEtmE8YQAA--.3198W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiYhHkbWV4H68p0gABst
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNS0xOCAwMDoxNDo0NywgIkp1bmlvIEMgSGFtYW5vIiA8Z2l0c3RlckBwb2JveC5j
b20+IHdyb3RlOgo+UGF0cmljayBTdGVpbmhhcmR0IDxwc0Bwa3MuaW0+IHdyaXRlczoKPgo+PiBO
b3cgdGhlcmUgYXJlIHR3byBjb25mbGljdGluZyB0aG91Z2h0cyBoZXJlOgo+Pgo+PiAgIC0gRWl0
aGVyIHdlIGNhbiBub3cgZHJvcCBgUkVGX1NLSVBfT0lEX1ZFUklGSUNBVElPTmAgYXMgdGhlIG9i
amVjdCBJRHMKPj4gICAgIHNob3VsZCBub3cgYmUgYWNjZXNzaWJsZS4KPj4KPj4gICAtIE9yIHdl
IGNhbiBhdm9pZCBjYWxsaW5nIGByZXByZXBhcmVfcGFja2VkX2dpdCgpYCBpbnNpZGUgdGhlIGxv
b3AgYW5kCj4+ICAgICBpbnN0ZWFkIGNhbGwgaXQgb25jZSBhZnRlciB3ZSBoYXZlIGZldGNoZWQg
YWxsIGJ1bmRsZXMuCj4+Cj4+IFRoZSBzZWNvbmQgb25lIGZlZWxzIGEgYml0IGxpa2UgcHJlbWF0
dXJlIG9wdGltaXphdGlvbiB0byBtZS4gQnV0IHRoZQo+PiBmaXJzdCBpdGVtIGRvZXMgZmVlbCBs
aWtlIGl0IGNvdWxkIGhlbHAgdXMgdG8gY2F0Y2ggYnJva2VuIGJ1bmRsZXMKPj4gYmVjYXVzZSB3
ZSB3b3VsZG4ndCBlbmQgdXAgY3JlYXRpbmcgcmVmcyBmb3Igb2JqZWN0cyB0aGF0IG5laXRoZXIg
d2Ugbm9yCj4+IHRoZSBidW5kbGUgaGF2ZS4KPgo+SSBsaWtlIHRoZSB3YXkgeW91ciB0aG91Z2h0
cyBhcmUgc3RydWN0dXJlZCBhcm91bmQgaGVyZS4KPgo+SSBkbyBhZ3JlZSB0aGF0IHRoZSBsYXR0
ZXIgaXMgYSB3cm9uZyBhcHByb2FjaC0tLXdlIHNob3VsZG4ndCBiZQo+dHJ1c3Rpbmcgd2hhdCBj
YW1lIGZyb20gZWxzZXdoZXJlIG92ZXIgdGhlIG5ldHdvcmsgd2l0aG91dCBmaXJzdAo+Y2hlY2tp
bmcuICBXZSBzaG91bGQgcHJvYmFibHkgYmUgcnVubmluZyB0aGUgImluZGV4LXBhY2sgLS1maXgt
dGhpbiIKPnRoZSB1bmJ1bmRsaW5nIHByb2Nlc3MgcnVucyB3aXRoIGFsc28gdGhlICItLWZzY2st
b2JqZWN0cyIgb3B0aW9uIGlmCj53ZSBhcmUgbm90IGRvaW5nIHNvIGFscmVhZHksIGFuZCBldmVu
IHRoZW4sIHdlIHNob3VsZCBtYWtlIHN1cmUgdGhhdAo+dGhlIG9iamVjdCB3ZSBhcmUgbWFraW5n
IG91ciByZWYgcG9pbnQgYXQgaGF2ZSBldmVyeXRoaW5nIGJlaGluZCBpdC4KCkN1cnJlbnRseSBg
dW5idW5kbGVgIGFuZCBhbGwgaXRzIGNhbGxlcnMgYXJlIG5vdCBhZGRpbmcgIi0tZnNjay1vYmpl
Y3RzIi4KVGhlcmUgaXMgYSBwYXJhbSBgZXh0cmFfaW5kZXhfcGFja19hcmdzYCBmb3IgYHVuYnVu
ZGxlYCBidXQgaXQgaXMKbWFpbmx5IHVzZWQgZm9yIHByb2dyZXNzIHJlbGF0ZWQgb3B0aW9ucy4K
ClBlcnNvbmFsbHkgSSB0aGluayBkYXRhIGZyb20gYnVuZGxlcyBhbmQgZGF0YSByZWNlaXZlZCB2
aWEgbmV0d29yawpzaG91bGQgYmUgdHJlYXRlZCBlcXVhbGx5LiBGb3IgImZldGNoLXBhY2siIHdl
IG5vdyBoYXZlIHNvbWUgY29uZmlncwpzdWNoIGFzICAiZmV0Y2guZnNja29iamVjdHMiIGFuZCAi
dHJhbnNmZXIuZnNja29iamVjdHMiIHRvIGRlY2lkZSB0aGUKYmVoYXZpb3IsIHRoZXNlIGNvbmZp
Z3MgYXJlIGludmlzaWJsZSB3aGVuIHdlIGFyZSBmZXRjaGluZyBidW5kbGVzLgoKU28gZm9yIGJ1
bmRsZXMgSSB0aGluayB3ZSBoYXZlIHNvbWUgZGlmZmVyZW50IHdheXMgdG8gZ286CgogIC0gQWNr
bm93bGVkZ2UgdGhlIGNvbmZpZ3MgbWVudGlvbmVkIGFib3ZlIGFuZCBiZWhhdmUgbGlrZQogICAg
ImZldGNoLXBhY2siLgoKICAtIEFkZCAiLS1mc2NrLW9iamVjdHMiIGFzIGEgZGVmYXVsdCBpbiBg
dW5idW5kbGVgLgoKICAtIEluIGB1bmJ1bmRsZV9mcm9tX2ZpbGVgLCBwYXNzIGluICItLWZzY2st
b2JqZWN0cyIgYXMKICAgIGBleHRyYV9pbmRleF9wYWNrX2FyZ3NgIGZvciBgdW5idW5kbGVgIHNv
IHRoaXMgb25seSBhZmZlY3QgdGhlCiAgICBidW5kbGUtdXJpIHJlbGF0ZWQgcHJvY2Vzcy4KCldo
YXQgZG8geW91IHRoaW5rPwoKWGluZyBYaW4K
