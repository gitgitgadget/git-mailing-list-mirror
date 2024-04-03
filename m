Received: from mailgw1-at.powered.services (mailgw1-at.powered.services [213.227.179.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD314831D
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.227.179.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150888; cv=none; b=j6le2U+sUpqORlgylQf4iOBoRG8QcOtjTF2al0Wn8JTW1zQLtbsHysIQffs/zqrXx+X3PwhrN2UQq7Ty3EWj2+r3oiW5n4t6QahwO1UaD2Mr7S/tt5cGLMH3TCnB47j09ne2TxOoJGbdldpcMpRJ7tUzQxtzh2Y6zvRxwmaMGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150888; c=relaxed/simple;
	bh=hzhNfNf9QcwYixfyTWosfws30/klsUA/aKvUFEAbCVI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d4R8YJevCndDPmG+y/xGtW0OCNbpM+fdK30NTtNC7rAEQk9mWBbGgjxKVzPKUNDgGna56M7VBkhzmqHKMqMvtxK15D57QxR4THMvWgsQ9kOfY+i2leL9NH2VNIabkqo6aio/bj43FyLRz+XwIEX2ME+GQY4zOXiD8lGXRwbYoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anexia.com; spf=pass smtp.mailfrom=anexia.com; dkim=pass (2048-bit key) header.d=anexia.com header.i=@anexia.com header.b=lGlqtzPr; arc=none smtp.client-ip=213.227.179.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anexia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anexia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anexia.com header.i=@anexia.com header.b="lGlqtzPr"
Authentication-Results: mailgw1-at.powered.services; spf=Pass smtp.mailfrom=JOster@anexia.com; spf=None smtp.helo=postmaster@mail-out-relay02.cloudpowered.email
Received-SPF: Pass (mailgw1-at.powered.services: domain of
  JOster@anexia.com designates 45.132.62.165 as permitted
  sender) identity=mailfrom; client-ip=45.132.62.165;
  receiver=mailgw1-at.powered.services;
  envelope-from="JOster@anexia.com";
  x-sender="JOster@anexia.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:45.132.62.164 ip4:45.132.62.165 ip4:37.252.233.40/31
  ip4:37.252.235.122/31 ip4:37.252.241.92/31
  ip4:37.252.242.34/31 ip4:37.252.250.192/31
  ip4:37.252.252.140/31 ip6:2a00:11c0:dd:2::24
  ip6:2a00:11c0:dd:2::25 ip6:2a00:11c0:d:15::/127
  ip6:2a00:11c0:df:2::/127 ip6:2a00:11c0:49:4::2/127
  ip6:2a00:11c0:47:8::18/127 ip6:2a00:11c0:dd:2::74/127
  ip6:2a00:11c0:69::2/127 -all"
Received-SPF: None (mailgw1-at.powered.services: no sender
  authenticity information available from domain of
  postmaster@mail-out-relay02.cloudpowered.email)
  identity=helo; client-ip=45.132.62.165;
  receiver=mailgw1-at.powered.services;
  envelope-from="JOster@anexia.com";
  x-sender="postmaster@mail-out-relay02.cloudpowered.email";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.07,177,1708383600"; 
   d="scan'208";a="4093437"
Received: from mail-out-relay02.cloudpowered.email ([45.132.62.165])
  by mailgw1-at.powered.services with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 15:26:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anexia.com;
	s=cloudpowered-email; t=1712150814;
	bh=hzhNfNf9QcwYixfyTWosfws30/klsUA/aKvUFEAbCVI=;
	h=From:To:Subject:Date:From;
	b=lGlqtzPrxbEuZUS+9uSe7eGZTb518B2xYbQygjpKSVdmsmOv7pokzosVMUrcsZBYe
	 jmAabEkvVNXGiwW8zyldQyvh6cF/c38/mbCyCvU20kNtZYipdXjaCjQi7/V3vyjC6q
	 awBSCWsTEWRKzrTc9wci4TIm/Pr+BOWnsqBTU9uZZp4Q8/y6mXb24KTXkXQRii8PEf
	 x8P6koDSUrlf6EX3AS3NOyz0WPUawrCP4mD2t1hKkkUvyMe3nXAd36QR3dwA9Upli6
	 ib1HqjHDA6TxFdfo5/GXX3FZwI4zqtMAJJCcCIhIfGYa5UorzNr31AR+adC+WfbLAa
	 YOp33ZLXJ9kog==
Received: from exchange.anexia.at (office.anexia.at [188.65.77.77])
	by cloudpowered.email (Postfix) with ESMTPS id 4V8ls96Sksz2slc
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 15:26:53 +0200 (CEST)
Received: from anx-i-ex0102.anx.local (10.0.10.82) by anx-i-ex0101.anx.local
 (10.0.10.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Wed, 3 Apr
 2024 15:26:53 +0200
Received: from anx-i-ex0102.anx.local ([fe80::cda6:51a8:2b07:e1a5]) by
 anx-i-ex0102.anx.local ([fe80::cda6:51a8:2b07:e1a5%5]) with mapi id
 15.01.2507.035; Wed, 3 Apr 2024 15:26:53 +0200
From: Jasmin Oster <JOster@anexia.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-merge: --no-commit is not respected on a fresh repository
Thread-Topic: git-merge: --no-commit is not respected on a fresh repository
Thread-Index: AQHahcqXeb/i6YbVtESVtuxaCdMZ6g==
Date: Wed, 3 Apr 2024 13:26:53 +0000
Message-ID: <22efe19e-de44-4b6d-8e8b-57e2bddb321e@anexia.com>
Accept-Language: de-DE, de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E695EAA0B8E34243AEB75A126BDD2B20@anx.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

IyMgV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpDQoNCldoZW4gdHJ5aW5nIHRvIHBlcmZvcm0gYSBzdWJ0cmVlIG1l
cmdlLCBlc3BlY2lhbGx5IGZvbGxvd2luZyB0aGUgYmxvZyANCnBvc3Qgb24gaHR0cHM6Ly9udWNs
ZWFyc3F1aWQuY29tL3dyaXRpbmdzL3N1YnRyZWUtbWVyZ2luZy1hbmQteW91LywNCkkgbm90aWNl
ZCB0aGF0IEdpdCBkb2VzIG5vdCByZXNwZWN0IHRoZSAtLW5vLWNvbW1pdCBvcHRpb24gaWYgdGhl
IA0KcmVwb3NpdG9yeSBkb2VzIG5vdCBoYXZlIGEgaGlzdG9yeS4NCg0KMS4gQ3JlYXRlIGEgbmV3
IHJlcG9zaXRvcnk6ICQgZ2l0IGluaXQNCjIuIEFkZCBhIHJlbW90ZTogJCBnaXQgcmVtb3RlIGFk
ZCBmb28gLi4vPHBhdGgtdG8tYW5vdGhlci1yZXBvPg0KMy4gRmV0Y2ggZXZlcnl0aGluZzogJCBn
aXQgZmV0Y2ggLS1hbGwNCjQuIEluaXRpYXRlIGEgc3VidHJlZSBtZXJnZTogJCBnaXQgbWVyZ2Ug
LXMgb3VyIC0tbm8tY29tbWl0wqBmb28vbWFpbg0KDQojIyBXaGF0IGRpZCB5b3UgZXhwZWN0IHRv
IGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQ0KDQpUaGUgcmVwb3NpdG9yeSBzaG91bGQndmUg
YmVlbiBpbiB0aGUgIm1lcmdpbmciIHN0YXRlLCBpbiBvcmRlciB0byANCnJld3JpdGUgdGhlIHBh
dGhzIHVzaW5nOg0KDQokIGdpdCByZWFkLXRyZWUgLS1wcmVmaXg9L3Byb2plY3QvIC11IGZvby9t
YWluDQoNCkl0J3Mgb25seSBhIG1pbm9yIGFubm95YW5jZSB0aGF0IGNhbiBiZSBmaXhlZCBieSBh
ZGRpbmcgYW4gZW1wdHkgY29tbWl0IA0KaW4gYWR2YW5jZSBvZiBwZXJmb3JtaW5nIHRoZSBtZXJn
ZSwgeWV0IGl0IHRvb2sgbWUgc29tZSBtaW51dGVzIHRvIA0KZmlndXJlIG91dCB3aHkgR2l0IGRv
ZXMgbm90IGJlaGF2ZSBhcyBpbnRlbmRlZC4NCg0KIyMgV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAo
QWN0dWFsIGJlaGF2aW9yKQ0KDQpBIG1lcmdlIGNvbW1pdCB3YXMgY3JlYXRlZC4NCg0KIyMgV2hh
dCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5
IGhhcHBlbmVkPw0KDQpTYWlkIG1lcmdlIGNvbW1pdCwgZXZlbiB0aG91Z2ggdGhlIGAtLW5vLWNv
bW1pdGAgb3B0aW9uIHdhcyBzZXQuDQoNCltTeXN0ZW0gSW5mb10NCmdpdCB2ZXJzaW9uOg0KZ2l0
IHZlcnNpb24gMi40NC4wDQpjcHU6IHg4Nl82NA0Kbm8gY29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0
aGlzIGJ1aWxkDQpzaXplb2YtbG9uZzogOA0Kc2l6ZW9mLXNpemVfdDogOA0Kc2hlbGwtcGF0aDog
L2Jpbi9zaA0KdW5hbWU6IExpbnV4IDYuNy4xMC0yMDAuZmMzOS54ODZfNjQgIzEgU01QIFBSRUVN
UFRfRFlOQU1JQyBNb24gTWFyIDE4IA0KMTg6NTY6NTIgVVRDIDIwMjQgeDg2XzY0DQpjb21waWxl
ciBpbmZvOiBnbnVjOiAxMy4yDQpsaWJjIGluZm86IGdsaWJjOiAyLjM4DQokU0hFTEwgKHR5cGlj
YWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiAvdXNyL2Jpbi9maXNoDQoNCi0tIA0KTWl0IGZyZXVu
ZGxpY2hlbiBHcsO8w59lbiAvIGtpbmQgcmVnYXJkcw0KDQoqSmFzbWluIE9zdGVyKg0KU29mdHdh
cmUgRGV2ZWxvcGVyDQoNCkFORVhJQSBJbnRlcm5ldGRpZW5zdGxlaXN0dW5ncyBHbWJIDQoNCkUt
TWFpbDogSk9zdGVyQGFuZXhpYS5jb20gPG1haWx0bzpETmFtZUBhbmV4aWEuY29tPg0KV2ViOiBh
bmV4aWEuY29tIDxodHRwczovL2FuZXhpYS5jb20vPg0KDQpBbnNjaHJpZnQgSGF1cHRzaXR6IEts
YWdlbmZ1cnQ6IEZlbGRraXJjaG5lciBTdHJhw59lIDE0MCwgOTAyMCBLbGFnZW5mdXJ0DQpHZXNj
aMOkZnRzZsO8aHJlcjogQWxleGFuZGVyIFdpbmRiaWNobGVyDQpGaXJtZW5idWNoOiBGTiAyODk5
MThhIHwgR2VyaWNodHNzdGFuZDogS2xhZ2VuZnVydCB8IFVJRC1OdW1tZXI6IEFUIA0KVTYzMjE2
NjAxDQo=
