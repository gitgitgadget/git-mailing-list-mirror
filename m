Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF818641
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088431; cv=none; b=kAyE1iYndghE6lXJsin3R0NRlUCpeqH5o2MMBqfHoq9LW256ocKVyTKGTzWr2ERSAzmhhNrVJH4lVkzISqfGwDPY5mnURyIwS/0A0VGMjr1Gjs56iPHRZSHZiddZcba8ltuttdZuSNgQajBdhVXKtpwKZVSF+lmmn54NfVFAQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088431; c=relaxed/simple;
	bh=P5uuCSZpJtEDIZkNFjzEUWEBjLTxwY6kDQWy0CB+0vI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=B1s0+SdejC4m/UyiAKnJuHwCXw3p8pvVCDq37TNWQKNWHjFJSmNg3uVjqoUZqPXQgmWG+uo4IAYdzb7DErzYcB6xehuebUr2yhmKAq0t9DoUoF4+wxrWQyzgYwojb34s0y1NcjTOtu0ZwqHk/AybiCFkoHriIVAdXFKlfNJrXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LgaYLHwU reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LgaYLHwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=EZVJABbGGjdCYveuQEfxyT227YS2cAMipGJgzvF1bIU=; b=L
	gaYLHwUra0OSnfB5PNcNRZwBuOAH42KdH1mYs5+laj4QwxhhbnoXUoFWUHiq1O0F
	zypxupp83DyU+mWwrNAsypxHcZgEhy24wuC7FbINF/Qb05QY1ZY4id7g2hNnqaha
	/R+wEJO0SXdU0NmcbCv0FMtrGlB2kirPzdR53jywl8=
Received: from bupt_xingxin$163.com ( [124.160.72.194] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Tue, 11 Jun 2024 14:46:47 +0800
 (CST)
Date: Tue, 11 Jun 2024 14:46:47 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v4 2/4] unbundle: extend verify_bundle_flags to
 support fsck-objects
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZmGmUcO8OYuPnH9H@tanuki>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
 <beb7073581123c1a9096d466f1ccff7fa68f3a19.1717057290.git.gitgitgadget@gmail.com>
 <ZmGmUcO8OYuPnH9H@tanuki>
X-NTES-SC: AL_Qu2aCvyTt0wr4SKQY+kXn0oVhe85UMW2ufsg3YReP500lSTjxiIlZFJ9N1fa2/u0FR+unTWLfjh2xfRKcalEdLw3G5NkZ1efX0WZs5t1/yR0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5670c216.6e3d.190060c98fb.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3fwzX8mdm_fUwAA--.46598W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiRRn6bWXAmx22egACsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNi0wNiAyMDowNjo0MSwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6Cj5PbiBUaHUsIE1heSAzMCwgMjAyNCBhdCAwODoyMToyOEFNICswMDAwLCBYaW5nIFhp
biB2aWEgR2l0R2l0R2FkZ2V0IHdyb3RlOgo+PiBGcm9tOiBYaW5nIFhpbiA8eGluZ3hpbi54eEBi
eXRlZGFuY2UuY29tPgo+Cj5UaW55IG5pdDogdGhlIGltcG9ydGFudCBjaGFuZ2UgaW4gdGhpcyBj
b21taXQgaXMgbm90IHRoYXQgeW91IHdpcmUgdXAKPnRoZSBmbGFnLCBidXQgcmF0aGVyIHRoYXQg
d2Ugc3RhcnQgdG8gZXhlY3V0ZSBnaXQtZnNjaygxKSBub3cuIEknZCB0aHVzCgpUbyBiZSBwcmVj
aXNlLCBpdCBpcyBhZGRpbmcgYSAiLS1mc2NrLW9iamVjdHMiIGZsYWcgdG8gImdpdC1pbmRleC1w
YWNrIi4KCj5wcm9wb3NlIHRvIGFkYXB0IHRoZSBjb21taXQgdGl0bGUgYWNjb3JkaW5nbHkuCgpU
aGlzIGNvbW1pdCBpcyBtYXBwZWQgdG8gW1BBVENIIHY1IDMvNF0gZHVlIHRvIHNvbWUgYWRqdXN0
bWVudHMgdG8gdGhlCmNvbW1pdCBvcmRlciBhbmQgaW1wbGVtZW50YXRpb24gZGV0YWlscy4gSG9w
ZSB0aGUgbmV3IHRpdGxlIGNhbiBiZXR0ZXIKZGVzY3JpYmUgdGhlIG5ldyBwYXRjaC4KClhpbmcg
WGluCg==
