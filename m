Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504E13341F
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235643; cv=none; b=F7r7UNtoPtcfwtBEO2jNqmF3m8I7i9r9BYSWucM2aUKmn9u2ByhhTEpDTORFTpF2LaTMezuQE4MXbhs5UI3FadmS0L6wd2WqYXYhU3Ev5xAPFDci6s6WwSd4DxN2WvQIn4qiOBjptrd67wmxTloi7kdHDXFBkEs4VsxdD4UGOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235643; c=relaxed/simple;
	bh=2mCK/N1qELeSbT2nWkaGXZlfxsgXiLObt94LNCOo41U=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=q66f0NTYX/IzvSqw3Q1PWi778dhG1t0YO8HTryovAp64yXJId5RpR0AkRnfZnya/lUBV2WDCgYxwpa72LD/E8rD3ZOPzg+9KJNSk9pGNdIjaKE0e5MQBstT7CEjVClz4pAlcNftw2gXXpKxCJR3jqi9F4YSqHFUzmqd4s032Zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=OGHp0wH3 reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="OGHp0wH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=DmglOQpLcp37TfhKxywoNtaUnVu+F1YoUYIiFhLykFM=; b=O
	GHp0wH3JqITr2yuWju9r4936c4GOUf8roQJUGKfSeh6Xql5C/xnq3aq2/ZvcYLjl
	eAlGUTpJz3+oNrCH344fxQ3fBIzULs/Eelz0BYqVR6x6/VbSnpZIpZXp6l6tqdy5
	IAIwYJbZGD03hbvVJj8CZrk/g1zzVk4fxFdVbVtd/8=
Received: from dingjunyao0703$163.com ( [39.144.159.248] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Wed, 7 Feb 2024 00:07:07 +0800 (CST)
Date: Wed, 7 Feb 2024 00:07:07 +0800 (CST)
From: DingJunyao  <dingjunyao0703@163.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: git submodule update doesn't give a prompt to add pubkey of
 remote repo host, and failed because of it.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2bBf6Yuk4p4SefYelS6TNw4JVpHZXE6LhlnuMkavwRlw/I2yUeUHp6HkDo1+JV/IiCdGy7mwHu8nPAy4Or
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <37a01273.7951.18d7f2c5303.Coremail.dingjunyao0703@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD338ArWcJl+mnOAA--.19824W
X-CM-SenderInfo: pglqwy5xq1t0iqxqjqqrwthudrp/xtbB0BF84mWXv2GjgAACsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

R2l0IHZlcnNpb246IGdpdCB2ZXJzaW9uIDIuNDMuMC53aW5kb3dzLjEKT1M6IFdpbmRvd3MgMTEg
MjJIMiAoMjI2MjEuMzAwNykKKEkgZG9uJ3Qga25vdyB3aGV0aGVyIGl0J3MgYSBXaW5kb3dzLXNw
ZWNpZmljIGJ1ZykKCkkgY2xvbmVkIGEgcHJvamVjdCBmcm9tIG9uZSByZW1vdGUgcmVwbyAoQSks
IGFuZCB0aGUgcHJvamVjdCBoYXMgYSBzdWJtb2R1bGUgZnJvbSB0aGUgb3RoZXIgcmVtb3RlIHJl
cG8gKEIpLiBCb3RoIG9mIHRoZW0gYXJlIGNvbm5lY3RlZCB0byB0aGUgcmVtb3RlIHJlcG8gb2Yg
d2hpY2ggYnkgU1NILCBhbmQgSSBhZGRlZCBteSBwdWJrZXkgdG8gYm90aCBvZiB0aGUgcmVwbyBw
cm92aWRlcnMuCgpJIGV4ZWN1dGVkIHRoZSBjb21tYW5kIGluIHByb2plY3QgZGlyZWN0b3J5OgoK
ICAgIGdpdCBzdWJtb2R1bGUgaW5pdAogICAgZ2l0IHN1Ym1vZHVsZSB1cGRhdGUKCldoZW4gdXBk
YXRpbmcsIHRoZSBmb2xsb3dpbmcgZXJyb3IgaGFwcGVuZWQ6CgogICAgQ2xvbmluZyBpbnRvICcv
cGF0aC90by9zdWJtb2R1bGUnLi4uCiAgICBIb3N0IGtleSB2ZXJpZmljYXRpb24gZmFpbGVkLgog
ICAgZmF0YWw6IENvdWxkIG5vdCByZWFkIGZyb20gcmVtb3RlIHJlcG9zaXRvcnkuCgogICAgUGxl
YXNlIG1ha2Ugc3VyZSB5b3UgaGF2ZSB0aGUgY29ycmVjdCBhY2Nlc3MgcmlnaHRzCiAgICBhbmQg
dGhlIHJlcG9zaXRvcnkgZXhpc3RzLgogICAgZmF0YWw6IGNsb25lIG9mICd1c2VyQGhvc3Q6cmVw
by9wYXRoLmdpdCcgaW50byBzdWJtb2R1bGUgcGF0aCAnL3BhdGgvdG8vc3VibW9kdWxlJyBmYWls
ZWQKICAgIEZhaWxlZCB0byBjbG9uZSAndGhlbWVzL2FuemhpeXUtZGluZy1tb2QnLiBSZXRyeSBz
Y2hlZHVsZWQKICAgIENsb25pbmcgaW50byAnL3BhdGgvdG8vc3VibW9kdWxlJy4uLgogICAgSG9z
dCBrZXkgdmVyaWZpY2F0aW9uIGZhaWxlZC4KICAgIGZhdGFsOiBDb3VsZCBub3QgcmVhZCBmcm9t
IHJlbW90ZSByZXBvc2l0b3J5LgoKICAgIFBsZWFzZSBtYWtlIHN1cmUgeW91IGhhdmUgdGhlIGNv
cnJlY3QgYWNjZXNzIHJpZ2h0cwogICAgYW5kIHRoZSByZXBvc2l0b3J5IGV4aXN0cy4KICAgIGZh
dGFsOiBjbG9uZSBvZiAndXNlckBob3N0OnJlcG8vcGF0aC5naXQnIGludG8gc3VibW9kdWxlIHBh
dGggJy9wYXRoL3RvL3N1Ym1vZHVsZScgZmFpbGVkCiAgICBGYWlsZWQgdG8gY2xvbmUgJ3BhdGgv
dG8vc3VibW9kdWxlJyBhIHNlY29uZCB0aW1lLCBhYm9ydGluZwoKSSBjbG9uZWQgYW5vdGhlciBy
ZXBvIGZyb20gQi4gV2hlbiBJIGRpZCBpdCwgSSBmb3VuZCBJIGhhZG4ndCBhZGRlZCB0aGUgcHVi
a2V5IG9mIHJlcG8gQiB0byB0aGUgbGlzdCBvZiBrbm93biBob3N0cyBiZWZvcmUuCgogICAgVGhl
IGF1dGhlbnRpY2l0eSBvZiBob3N0ICdob3N0IChYWFguWFhYLlhYWC5YWFgpJyBjYW4ndCBiZSBl
c3RhYmxpc2hlZC4KICAgIEVEMjU1MTkga2V5IGZpbmdlcnByaW50IGlzIFNIQTI1NjpYWFhYWFhY
WFhYWFhYLgogICAgVGhpcyBrZXkgaXMgbm90IGtub3duIGJ5IGFueSBvdGhlciBuYW1lcy4KICAg
IEFyZSB5b3Ugc3VyZSB5b3Ugd2FudCB0byBjb250aW51ZSBjb25uZWN0aW5nICh5ZXMvbm8vW2Zp
bmdlcnByaW50XSk/IHllcwogICAgV2FybmluZzogUGVybWFuZW50bHkgYWRkZWQgJ2hvc3QnIChF
RDI1NTE5KSB0byB0aGUgbGlzdCBvZiBrbm93biBob3N0cy4KCkFmdGVyIHRoYXQsIEkgdHJpZWQg
dG8gZXhlY3V0ZSBgZ2l0IHN1Ym1vZHVsZSB1cGRhdGVgIGluIHRoZSBwcmV2aW91cyBwcm9qZWN0
IGFuZCBzdWNjZWVkZWQuCgpJIHRoaW5rIHdoZW4gSSB1cGRhdGUgc3VibW9kdWxlIGFuZCBJIGhh
dmVuJ3QgYWRkZWQgdGhlIGtleSB0byB0aGUgc3VibW9kdWxlIHJlbW90ZSByZXBvLCBpdCBuZWVk
cyB0byBnaXZlIGEgcHJvbXB0IHRvIGFkZCB0aGUgcHVibGljIGtleSwganVzdCBsaWtlIGNsb25p
bmcu
