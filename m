Received: from esgaroth.petrovitsch.at (pelargir.petrovitsch.at [78.46.69.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8F1C84C0
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.69.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600403; cv=none; b=O3iTEQmf+ylttakxfIVBLDQj2wK+coQ66C6bTzGrGmL7sKh0YHvqvmVFY69QzbocIgR7TcmQLunIQxA96HCJG5OrowP2fTZTI/AbtdIUliiWfKA+ysMqeBPRMG0yOUuzr1hGXHT+Ra1hzFWW952nDJ8gsdO+7i9C+FbuPspp9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600403; c=relaxed/simple;
	bh=NxytnSQLW6oghejncs1zehd10PlTIVR0LuH0us2OuxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJiyZetZh1GXGsv4DqfaIlMZm2JSscDn6+4P7PWmvczaKda8zVfCCa5tZCS0R8GsWIIPD7zeIEU3ImO9AYsC5RXgCx3J3G54Pdp/AZWxUxS2FDXJ84voqIm8RCxPi+WDDHf3yqqEC/Y/ed6qhHC4tAiBWPm1mKiKGFQUcEiMsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=petrovitsch.priv.at; spf=fail smtp.mailfrom=petrovitsch.priv.at; dkim=pass (1024-bit key) header.d=petrovitsch.priv.at header.i=@petrovitsch.priv.at header.b=MBCGC3nT; arc=none smtp.client-ip=78.46.69.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=petrovitsch.priv.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=petrovitsch.priv.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=petrovitsch.priv.at header.i=@petrovitsch.priv.at header.b="MBCGC3nT"
Received: from [172.16.0.14] (84-115-213-150.cable.dynamic.surfer.at [84.115.213.150])
	(authenticated bits=0)
	by esgaroth.petrovitsch.at (8.18.1/8.18.1) with ESMTPSA id 57J9pjbG504801
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 19 Aug 2025 11:51:45 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 57J9pjbG504801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
	s=default; t=1755597106;
	bh=NxytnSQLW6oghejncs1zehd10PlTIVR0LuH0us2OuxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MBCGC3nT5vdnGl88dwUU3exsPa4chn6mlwUKtFh7BCqNlIEuPuzIEvZhgDbboqNQ+
	 OjKcF67hYJM5Ak/y53uGvDZUDbQSTmni9vWfwSEf73/1gSwFbEGT9Hd12vhYnBDyrq
	 sKLbchFQldDiiEByp64scOVFSfOJ75oLxX/5Gg5o=
Message-ID: <260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at>
Date: Tue, 19 Aug 2025 11:51:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Graphical tool to merge and reorder commits
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
 <xmqqplcsiimq.fsf@gitster.g> <aKQws631-giQS5Qr@pks.im>
 <aeb06554-77b5-4f07-a659-7b6825d6f3e4@rd10.de>
Content-Language: en-US
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <aeb06554-77b5-4f07-a659-7b6825d6f3e4@rd10.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Virus-Scanned: clamav-milter 1.4.3 at smtp.tuxoid.at
X-Virus-Status: Clean
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	*  0.0 URIBL_DBL_BLOCKED_OPENDNS ADMINISTRATOR NOTICE: The query to
	*      dbl.spamhaus.org was blocked due to usage of an open resolver. See
	*      https://www.spamhaus.org/returnc/pub/
	*      [URI: www.luga.at]
	[URI: petrovitsch.priv.at]

T24gMTkuMDguMjUgMTA6MzUsIFIuIERpZXogd3JvdGU6DQpbLi4uXQ0KPiBJIGd1ZXNzIHNv
bWUgImdpdCBoaXN0b3J5IHNxdWFzaCIgY29tbWFuZCB3b3VsZCBiZSB1c2VmdWwgdG9vLg0K
PiANCj4gVGhpcyBpcyB3aGF0IGZyZXF1ZW50bHkgaGFwcGVucyB0byBtZToNCj4gLSBJIGNv
bW1pdCBzb21lIGNvZGUgY2hhbmdlcyBiZWNhdXNlIHRoZSBjdXJyZW50IHByb2plY3QgYnVp
bGRzIGFuZCB0ZXN0cyBmaW5lLg0KPiAtIEkgc3RhcnQgdGhlICJjb21waWxlIGFsbCBwcm9q
ZWN0cyIgcHJvY2Vzcywgd2hpY2ggdGFrZXMgYWJvdXQgMSBob3VyLg0KPiAtIEluIHRoZSBt
ZWFudGltZSwgSSBjb21taXQgb3RoZXIgdW5yZWxhdGVkIGNoYW5nZXMuDQo+IC0gQWZ0ZXIg
YW4gaG91ciwgSSByZWFsaXNlIHRoYXQgYSBzaWxseSBtaXN0YWtlIGluIHRoZSBmaXJzdCBj
b21taXQgbWFrZXMgY29tcGlsYXRpb24gZmFpbCBmb3Igc29tZSBwcm9qZWN0Lg0KPiAgwqAg
SSBmaXggdGhhdCBhbmQgSSB0cmlnZ2VyIGEgImNvbXBpbGUgYWxsIHByb2plY3RzIiBhZ2Fp
biwgd2hpY2ggdGFrZXMgMSBob3VyIGFnYWluLg0KPiAtIEluIHRoZSBtZWFudGltZSwgSSBj
b21taXQgeWV0IGFub3RoZXIgdW5yZWxhdGVkIGNoYW5nZS4NCj4gLSBBZnRlciB5ZXQgYW5v
dGhlciBob3VyLCB0aGUgYnVpbGQgcHJvY2VzcyBub3RpZmllcyBtZSB0aGF0IEkgbWFkZSB5
ZXQgYW5vdGhlciBsaXR0bGUgbWlzdGFrZSwgYW5kIHlldCBhbm90aGVyIHByb2plY3QgZmFp
bHMgbm93Lg0KPiANCj4gVGhlIGNvbW1pdCBoaXN0b3J5IGxvb2tzIGxpa2UgdGhpczoNCj4g
DQo+IC0gQSAtIEIgLSBmaXhBMSAtIEMgLSBmaXhBMiAtIEQgLSBFDQo+IA0KPiBJIG9ubHkg
ZG8gYSAiZ2l0IHB1c2giIHdoZW4gdGhlIDEtaG91ciBjb21waWxhdGlvbiBwcm9jZXNzIHN1
Y2NlZWRzLiBCZWZvcmUgdGhlICJnaXQgcHVzaCIsIEkgd2FudCB0byByZW9yZ2FuaXNlIHRo
YXQgaW50bzoNCj4gDQo+IC0gQStmaXhBMStmaXhBMiAtIEIgLSBDIC0gRCAtIEUNCj4gDQo+
IEkga25vdyBJIGNhbiB3b3JrIHdpdGggYnJhbmNoZXMsIGJ1dCBicmFuY2hlcyBtYWtlIGV2
ZXJ5dGhpbmcgbW9yZSBjb21wbGljYXRlZC4gQSBsaW5lYXIgaGlzdG9yeSBpcyBlYXNpZXIs
IGVzcGVjaWFsbHkgd2hlbiB5b3UgYXJlIHdvcmtpbmcgYWxvbmUuIEJlc2lkZXMsIGl0IGlz
IG5vdCBvZnRlbiB0aGF0IEkgbWFrZSBzdWNoIHNpbGx5IG1pc3Rha2VzLiA7LSkNCg0KLSBg
Z2l0IHJlYmFzZSAtaSBIRUFEfjExYCAob3Igc287LSkNCi0gbW92ZSBmaXhBMSBhbmQgZml4
QTIgdW5kZXIgQSBhbmQgY2hhbmdlICJwaWNrIiB0byAiZml4dXAiIGZvciBmaXhBMSBhbmQg
Zml4QTINCi0gc2F2ZSBhbmQgZXhpdCB0aGUgZWRpdG9yDQoNCkFuZCBkb25lLg0KDQpLaW5k
IHJlZ2FyZHMsDQoJQmVybmQNCi0tIA0KQmVybmQgUGV0cm92aXRzY2ggICAgICAgICAgICAg
ICAgICBFbWFpbCA6IGJlcm5kQHBldHJvdml0c2NoLnByaXYuYXQNCiAgICAgIFRoZXJlIGlz
IE5PIENMT1VELCBqdXN0IG90aGVyIHBlb3BsZSdzIGNvbXB1dGVycy4gLSBGU0ZFDQogICAg
ICAgICAgICAgICAgICAgICAgTFVHQSA6IGh0dHA6Ly93d3cubHVnYS5hdA0K
