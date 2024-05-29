Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311C15B562
	for <git@vger.kernel.org>; Wed, 29 May 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006392; cv=none; b=k1J7+23q0JWejHcBXbiefctZVzNGapETsqKz/05lbURa3vym+8Yatk7ID09Inq4KDcIRzUxkoIl8sTT5xVLltpGVhv0fxF4Sw8r6ChzaeIu0EhkHaXNZakWH6VIytyBbrnynRSR+GqJSxbOMBiaAD0f53/odtpKknQAIOosMDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006392; c=relaxed/simple;
	bh=b2T12/WP82CnVg07Abmmln8zdCkbihcFKNmSQPALSGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HrrwF3bDMDymY1Ias/GElYhQ9BzunOA1dImBaGh03Rcp+yDxH2sxx5yrd/TEeGKW2XAMTM2Xz0m7yZd3mJBXyG7iy4EW1weyLq4gJt0YxtDFvGG1XIq+S/RfsDXRa9hMR5Dx156TBg1vW+7ucp+Q2jvDo+d/5sSkLcvJKdZPACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=b5RtJ3MP reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="b5RtJ3MP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=flX982wzTuqO9LLl80mWQmhO8yly8RBTGo2xK/bD89M=; b=b
	5RtJ3MPj+x7j7GFSp1rVPlRq2QZTrYmLp3tMBvnt0zVWjxoLl1mDhsDToqT4C3e8
	xGC+s23nheBB/QpnnljyxVYdZuvW5xu/2+ougA2a+tz1K6cmNGI+aVk0t9QAGpIU
	ZkQTCR6UJqxk4GrWiQClUXRHK+oUM8Hg+YY6rRRvDw=
Received: from bupt_xingxin$163.com ( [117.147.107.113] ) by
 ajax-webmail-wmsvr-40-134 (Coremail) ; Thu, 30 May 2024 02:12:47 +0800
 (CST)
Date: Thu, 30 May 2024 02:12:47 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v3 2/4] unbundle: introduce unbundle_fsck_flags for
 fsckobjects handling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZlXIDXfc_1lGb51J@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <057c697970ff49301cd9dc6adef099f53d440c3c.1716824518.git.gitgitgadget@gmail.com>
 <ZlXIDXfc_1lGb51J@tanuki>
X-NTES-SC: AL_Qu2aBfybuUst4SWRZ+kXn0oVhe85UMW2ufsg3YReP500miXL9ScDRkRsOmPqweeIGRq1iyOrfzhv8uZ4VIlnT7oY8YV/taBh872ZGfXEmaV/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1d097be.b642.18fc58dfb70.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f+EfcFdmcUlJAA--.12561W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiRQXtbWXAmhsI-wAGsV
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNS0yOCAyMDowMzoyNSwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6Cj5PbiBNb24sIE1heSAyNywgMjAyNCBhdCAwMzo0MTo1NVBNICswMDAwLCBYaW5nIFhp
biB2aWEgR2l0R2l0R2FkZ2V0IHdyb3RlOgo+W3NuaXBdCj4+IGRpZmYgLS1naXQgYS9idW5kbGUu
aCBiL2J1bmRsZS5oCj4+IGluZGV4IDAyMWFkYmRjYmIzLi5jZmE5ZGFkZGRhNiAxMDA2NDQKPj4g
LS0tIGEvYnVuZGxlLmgKPj4gKysrIGIvYnVuZGxlLmgKPj4gQEAgLTMwLDYgKzMwLDExIEBAIGlu
dCBjcmVhdGVfYnVuZGxlKHN0cnVjdCByZXBvc2l0b3J5ICpyLCBjb25zdCBjaGFyICpwYXRoLAo+
PiAgCQkgIGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgc3RydWN0IHN0cnZlYyAqcGFja19v
cHRpb25zLAo+PiAgCQkgIGludCB2ZXJzaW9uKTsKPj4gIAo+PiArZW51bSB1bmJ1bmRsZV9mc2Nr
X2ZsYWdzIHsKPj4gKwlVTkJVTkRMRV9GU0NLX05FVkVSID0gMCwKPj4gKwlVTkJVTkRMRV9GU0NL
X0FMV0FZUywKPj4gK307Cj4+ICsKPj4gIGVudW0gdmVyaWZ5X2J1bmRsZV9mbGFncyB7Cj4+ICAJ
VkVSSUZZX0JVTkRMRV9WRVJCT1NFID0gKDEgPDwgMCksCj4+ICAJVkVSSUZZX0JVTkRMRV9RVUlF
VCA9ICgxIDw8IDEpLAo+Cj5Xb3VsZG4ndCB0aGlzIGhhdmUgYmVlbiBhIG5hdHVyYWwgZml0IGZv
ciB0aGUgbmV3IGZsYWcsIGUuZy4gdmlhCj5zb21ldGhpbmcgbGlrZSBgVkVSSUZZX0JVTkRMRV9G
U0NLYD8KCkl0IG1ha2VzIHNlbnNlIHRvIG1lLiBDdXJyZW50bHksIHZlcmlmeV9idW5kbGVfZmxh
Z3MgY29udHJvbHMgdGhlIGFtb3VudApvZiBpbmZvcm1hdGlvbiBkaXNwbGF5ZWQgd2hlbiBjaGVj
a2luZyBhIGJ1bmRsZSdzIHByZXJlcXVpc2l0ZXMuIFRoZQpuZXdseSBhZGRlZCB1bmJ1bmRsZV9m
c2NrX2ZsYWdzIGlzIGRlc2lnbmVkIHRvIGNoZWNrIGZvciBicm9rZW4gb2JqZWN0cwpkdXJpbmcg
dGhlIHVuYnVuZGxlIHByb2Nlc3MsIHdoaWNoIGlzIGVzc2VudGlhbGx5IGEgZm9ybSBvZiBidW5k
bGUKdmVyaWZpY2F0aW9uLiBJIGJlbGlldmUgd2Ugc2hvdWxkIGV4dGVuZCBzb21lIG9iamVjdCB2
ZXJpZmljYXRpb24KY2FwYWJpbGl0aWVzIHRvIHRoZSBnaXQgYnVuZGxlIHZlcmlmeSBjb21tYW5k
IGFzIHdlbGwsIHBlcmhhcHMgYnkgYWRkaW5nCmEgLS1mc2NrLW9iamVjdHMgb3B0aW9uLgoKV2l0
aCB0aGlzIGluIG1pbmQsIEkgc3VwcG9ydCBhZGRpbmcgbmV3IG9wdGlvbnMgdG8gdmVyaWZ5X2J1
bmRsZV9mbGFncy4KU2luY2UgYnVuZGxlLmM6dW5idW5kbGUgbmVlZHMgdG8gY29tYmluZSBtdWx0
aXBsZSBvcHRpb25zLCB3ZSBtdXN0CmRlZmluZSBuZXcgb3B0aW9ucyB1c2luZyBiaXR3aXNlIHNo
aWZ0aW5nOgoKCWVudW0gdmVyaWZ5X2J1bmRsZV9mbGFncyB7CgkJVkVSSUZZX0JVTkRMRV9WRVJC
T1NFID0gKDEgPDwgMCksCgkJVkVSSUZZX0JVTkRMRV9RVUlFVCA9ICgxIDw8IDEpLAoJCVZFUklG
WV9CVU5ETEVfRlNDS19PQkpFQ1RTX0FMV0FZUyA9ICgxIDw8IDIpLAoJCVZFUklGWV9CVU5ETEVf
RlNDS19PQkpFQ1RTX0ZPTExPV19GRVRDSCA9ICgxIDw8IDMpLAoJfTsKCkhvdyBhYm91dCB0aGUg
bmFtaW5nPyBJJ20gbm90IHZlcnkgZ29vZCBhdCBuYW1pbmcgOikKClhpbmcgWGluCg==
