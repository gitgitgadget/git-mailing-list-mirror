Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179A1848
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778680; cv=none; b=Mw+R4ykvtDXr4XTpy7gwhJp+di1vwYuOCgrPGZ2JmQzr3EPN5QI5j7yhVH8wwb2cy5XF29MZLAwyTKEDG0GH3BHsgLrMvQ8nejI+fhxiUjnA64wgi3H+C7Gk3ZdZNnUl/lZ0GBf57m+4DuYXdHucwtPQgFvS2rsg2NXv8xI5eeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778680; c=relaxed/simple;
	bh=a6CA8H1DRERHRSFcu5mnNNPQXQBLpTe/yxjjku6Bsd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=V9c1ru6cf74umFRikNO5rNxKlfgPvAnl1W0+ujH1tCZsXfrlPYopVmkwRdlm3MkbALt4itwEMswvqgWGwkksNy3Nuft2QSh8yvQdXO8hXMlg6P9SzKfZhVeiL5vhwemQ1OtIPY0cLk0jRCKgzfe6uculryP+AcqMvlbSL0Ud7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=XUF4TFPx reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="XUF4TFPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=YHZxwLgYZyNYZ6zxspu3slMsVh3RbAvnc2emtbbvrXM=; b=X
	UF4TFPx3gqIQtrja4QPYQZ7sQ3AdHR1KRJx5os8a8o+2L3jLecgbZ5VUZk3PYXjY
	SLH+WZWoDsTTyqoxVyrCFLhfbCi6SyXcAUPnFsRMJZdF6Krh0as4fbC5d8bVoL9S
	v5cA5eVW8M0B59YajjVDAYJHE4BZ3spti0aAIEdQfU=
Received: from bupt_xingxin$163.com ( [122.224.123.146] ) by
 ajax-webmail-wmsvr-40-134 (Coremail) ; Wed, 19 Jun 2024 14:30:34 +0800
 (CST)
Date: Wed, 19 Jun 2024 14:30:34 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt" <ps@pks.im>, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v7 1/3] bundle-uri: verify oid before writing refs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <xmqqr0cuyww9.fsf@gitster.g>
References: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
 <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
 <fc9f44fda0032ab1e5ee0c9bcc2886ddb8e17722.1718632536.git.gitgitgadget@gmail.com>
 <xmqqr0cuyww9.fsf@gitster.g>
X-NTES-SC: AL_Qu2aCvuct04o4iiZZukXn0oVhe85UMW2ufsg3YReP500miXX3hoMdERYMkbG6OexGx61iyOucypR8eZ1bY5JXIb3DembKJnk6ZbwbPchRkRO
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ae431a7.611a.1902f30a243.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3__YNe3JmGzxHAA--.40970W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiYAEDbWV4HSI8NgADsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNi0xOSAwMTozNzo1OCwgIkp1bmlvIEMgSGFtYW5vIiA8Z2l0c3RlckBwb2JveC5j
b20+IHdyb3RlOgo+IlhpbmcgWGluIHZpYSBHaXRHaXRHYWRnZXQiIDxnaXRnaXRnYWRnZXRAZ21h
aWwuY29tPiB3cml0ZXM6Cj4KPj4gQEAgLTMzLDYgKzQ2LDE2IEBAIHRlc3RfZXhwZWN0X3N1Y2Nl
c3MgJ2Nsb25lIHdpdGggcGF0aCBidW5kbGUnICcKPj4gIAl0ZXN0X2NtcCBleHBlY3QgYWN0dWFs
Cj4+ICAnCj4+ICAKPj4gK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2Nsb25lIHdpdGggYnVuZGxlIHRo
YXQgaGFzIGJhZCBoZWFkZXInICcKPj4gKwkjIFdyaXRlIGJ1bmRsZSByZWYgZmFpbHMsIGJ1dCBj
bG9uZSBjYW4gc3RpbGwgcHJvY2VlZC4KPj4gKwlnaXQgY2xvbmUgLS1idW5kbGUtdXJpPSJjbG9u
ZS1mcm9tL2JhZC1oZWFkZXIuYnVuZGxlIiBcCj4+ICsJCWNsb25lLWZyb20gY2xvbmUtYmFkLWhl
YWRlciAyPmVyciAmJgo+PiArCWNvbW1pdF9iPSQoZ2l0IC1DIGNsb25lLWZyb20gcmV2LXBhcnNl
IEIpICYmCj4+ICsJdGVzdF9ncmVwICJ0cnlpbmcgdG8gd3JpdGUgcmVmICdcJydyZWZzL2J1bmRs
ZXMvdG9waWMnXCcnIHdpdGggbm9uZXhpc3RlbnQgb2JqZWN0ICRjb21taXRfYiIgZXJyICYmCj4+
ICsJZ2l0IC1DIGNsb25lLWJhZC1oZWFkZXIgZm9yLWVhY2gtcmVmIC0tZm9ybWF0PSIlKHJlZm5h
bWUpIiA+cmVmcyAmJgo+PiArCSEgZ3JlcCAicmVmcy9idW5kbGVzLyIgcmVmcwo+Cj5XaHkgbm90
ICJ0ZXN0X2dyZXAgISIgaGVyZT8gIFRoZXJlIGFyZSBvdGhlciB1c2VzIG9mIGJhcmUgZ3JlcCBp
bgo+dGhlIG5ld2x5IGFkZGVkIGxpbmVzLCBidXQgSSB3b24ndCByZXBlYXQgdGhlbSBoZXJlOyB0
aGUgc2FtZQo+Y29tbWVudCBhcHBsaWVzIHRvIHRoZW0uCgpCb3RoIGB0ZXN0X2dyZXAgIWAgYW5k
IGAhIGdyZXBgIGFyZSB3aWRlbHkgdXNlZCBpbiB0ZXN0cy4gU29ycnkgZm9yIG5vdApyZWFsaXpp
bmcgdGhhdCB0aGUgZm9ybWVyIGlzIHByZWZlcnJlZC4KCj4+ICsJdGVzdF93cml0ZV9saW5lcyBy
ZWZzL2J1bmRsZXMvdG9waWMgPmV4cGVjdCAmJgo+PiArCXRlc3RfY21wIGV4cGVjdCBhY3R1YWwg
JiYKPj4gKwkjIEVuc3VyZSB0aGF0IHJlZnMvYnVuZGxlcy90b3BpYyBhcmUgc2VudCBhcyAiaGF2
ZSIuCj4+ICsJdGVzdF9ncmVwICJjbG9uZT4gaGF2ZSAkKGdpdCAtQyBjbG9uZS1mcm9tIHJldi1w
YXJzZSBBKSIgdHJhY2UtcGFja2V0LnR4dAo+PiArJwo+Cj5DYW4gdGhpcyByZXYtcGFyc2UgZmFp
bCAodGhlIGZhaWx1cmUgd291bGQgYmUgaGlkZGVuIGZyb20gdGhlIHRlc3QpPwo+SWYgc28sCj4K
PgkuLi4KPgl0ZXN0X2NtcCBleHBlY3QgYWN0dWFsICYmCj4JIyBFbnN1cmUgdGhhdCByZWZzL2J1
bmRsZXMvdG9waWMgaXMgc2VudCBhcyAiaGF2ZSIKPgl0aXA9JChnaXQgLUMgY2xvbmUtZnJvbSBy
ZXYtcGFyc2UgQSkgJiYKPgl0ZXN0X2dyZXAgImNsb25lPiBoYXZlICR0aXAiIHRyYWNlLXBhY2tl
dC50eHQKPgo+d291bGQgY2F0Y2ggc3VjaCBhIGZhaWx1cmUuICBZb3UgYXJlIGRvaW5nIHNvIGlu
IHRoZSBwcmV2aW91cyB0ZXN0Cj5pbiB0aGUgaHVuayBzdGFydGluZyBhdCAzMy80NiBhYm92ZSB3
aXRoIGNvbW1pdF9iIHZhcmlhYmxlIGFscmVhZHkuCj4KPlRoZXJlIGFyZSBvdGhlciB1c2VzIG9m
IGdpdCBjb21tYW5kIGluICQoY29tbWFuZCBzdWJzdGl0dXRpb24pIHdob3NlCj5leGl0IHN0YXR1
cyBhcmUgaWdub3JlZCBpbiB0aGUgbmV3bHkgYWRkZWQgbGluZXMsIGJ1dCBJIHdvbid0Cj5yZXBl
YXQgdGhlbSBoZXJlOyB0aGUgc2FtZSBjb21tZW50IGFwcGxpZXMgdG8gdGhlbS4KCkZpeGVkIGlu
IHRoZSBuZXcgc2VyaWVzLiBUaGFua3MuCgpYaW5nIFhpbgo=
