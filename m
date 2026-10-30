Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.194.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357172;
	b=nhAiMa74/kZreixjii3ES/keM2U3lVKREbQL09Iak6fD0FkF/1N4RsqjFZzcg78eaiTx
	 aGNkOkCwUAiDKjV9FyfdKBY4DGzqyArpbTmOXIXfPFEyN5b8cAP3mxvm+5OgG0MHLg6Cp
	 8TwXPYR4N11VE7HExtDlmrNGEuj+4SI67C9+vosfjxFL0vWX+2zO42I4rSd1nl4ZvoopK
	 LUdR2ddjrYBZpM6e468cdcypEXU4RPyjDW0J9ASOAAqbRbfzbvBJvKSDe4WF/bMb8EJH/
	 OWMORycliGJWvSwHhVVn7NSoC+ddxB/uzc4RD2sJgXF7BMjrS36d/JZ4xcP0o0K+rOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357172;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Signed:X-URL-LookUp-ScanningError:X-ThreatScanner-Verdict:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:DKIM-Signature:
	 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ThreatScanner-Verdict:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:From:To:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:x-tm-snts-smtp:
	 Content-Language:MIME-Version:Content-Type:X-SM-outgoing:
	 X-SM-Actions;
	bh=PiRN5elvK6eUsTiZNARF5attN/S0M/cVKURHq/EJiaI=;
	b=BCgixoH3FRlUmu6oHIKpZXkClP2bg3HSz0D7QYF3ME7A/tDznGX57xPZu9oniI8P91fZ
	 KC/KAatDQgboFMmzlD2ZVQ2Pezut5pHJOpv35SplWksZwvfL8MAKqce7bNTJHXQ1wD4ku
	 kiqe1m+5etXt0I+miQRAaeJXRqtYf2Dk8EYzJBMDiuRF3lNoLX0QfamkqoetOTdXHqM9k
	 q/68U1VRYQsYB8Bu1RCeGTrSvFqyxD3EXalVJ2xrHaS8gv7Wm6Cy3aJxeecrEHwo1XqvY
	 tRBOe6467jt2DyEXncBq7Zo14S3Azop8du9hh1RRKleesQnIcu8ZifehUs9HG6EIU+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ukr.de;
	spf=pass smtp.mailfrom=ukr.de;
	dkim=pass header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b="hSB8gjZ/";
	dkim=fail reason="signature verification failed" header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b=PvMQU+2z;
	arc=none smtp.remote-ip=193.175.194.181
Received: from mail01.ukr.de (mail01.ukr.de [193.175.194.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30818606A321
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30818606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b=hSB8gjZ/;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b=PvMQU+2z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ukr.de; i=@ukr.de; q=dns/txt; s=ukr; t=1793357172;
  x=1824893172;
  h=from:to:subject:date:message-id:mime-version;
  bh=PiRN5elvK6eUsTiZNARF5attN/S0M/cVKURHq/EJiaI=;
  b=hSB8gjZ/hEeskGldBFn2nwpWko5Ql/9GwxcKZ7kVTJ5DhxaI6AaWacTA
   6a/ouM/djoVFaBgBpwwBrNa4qZCjgN104eKR2/AjKS7CK2IYOdu4bEldU
   COJ1oX/Ul2wNfmgcL1MLBAmia6GjUgNN325hisLXuTjm2+6muNXUZaJqZ
   5envbOC9W+ArxMjwcwsNUiXdoPTEvSEMC0PthuS3UYWFzcX4Bvd4lGwQs
   XrDr1q5lafcy8sZj8LHUxZnHVH14jlD2FLT5aXAd3arc0SXei6mRkgCA2
   yUyTgJuOP8O/FvTqkpJR8rDWy/bxTgDjTIUrqCeEIoSt9WvY0Bwt4fERu
   g==;
X-CSE-ConnectionGUID: XFxYKbRtTt+pVAPcW45dJw==
X-CSE-MsgGUID: L3385ilHSaGgZdRWfgRfvQ==
X-Signed: true
X-URL-LookUp-ScanningError: 1
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="14475627"
X-IronPort-AV: E=Sophos;i="6.27,186,1787004000"; 
   d="p7s'346?scan'346,208,346";a="14475627"
Received: from unknown (HELO dmz-infsep02.ukr.dmz) ([192.168.236.69])
  by dmz-infcsg01.ukr.dmz with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Oct 2026 11:46:04 +0100
Received: from dmz-infsep02 (localhost [127.0.0.1])
	by dmz-infsep02.ukr.dmz (Postfix) with SMTP id 4jGHnl3BJyz5G3N
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:46:03 +0100 (CET)
Received: from dmz-infcsg02.ukr.dmz (dmz-infcsg02.ukr.dmz [192.168.236.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by dmz-infsep02.ukr.dmz (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ukr.de; i=@ukr.de; q=dns/txt; s=ukr; t=1793357162;
  x=1824893162;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3i/u2ctxOuXA0IuqapvJe5qzcR9+b5x4ul7gu2t/uWk=;
  b=PvMQU+2zrIQWczlfo1VPmN4R8oKYUeR+C84qv+tyKEH8MXRmPUlWWd1q
   kY2XsHFc1BhM74+jvxZgtjn2LGmeupyHHPYFQQKAOkaqz/6cbcwdgLkK2
   KP6Zxb+yX1sA0ATGa26MPp/cYaX7AUZFG9FfQLgQLug7EVKlwhyhgf5Ty
   ACasA7nT0xA/JdaoqNrblHqGUUOG12tbrGvZPJDJFBbDnd6bZuymbo7vs
   Fax8Yl5aJuKeS6uIHkdx25MSQt49JaToB4ClyQalI60yjA9GBbzNW7CU0
   PgMIy0G2LH3BQDrbA3I9RInX3GyPyURd2LTgr46qETU05gdprFIr8Fkw1
   w==;
X-CSE-ConnectionGUID: CgyTmyZIT9+McLSyfkEy3A==
X-CSE-MsgGUID: NjGoAAMvTwWxAGYABIB+GQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="14442000"
X-IronPort-AV: E=Sophos;i="6.27,186,1787004000"; 
   d="scan'208";a="14442000"
Received: from unknown (HELO ukr.de) ([172.24.2.107])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 11:46:02 +0100
Received: from ukr-excmb07.ukr.local (172.24.2.107) by ukr-excmb07.ukr.local
 (172.24.2.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 11:46:02 +0100
Received: from ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac]) by
 ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac%8]) with mapi id
 15.02.2562.056; Fri, 30 Oct 2026 11:46:02 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Q: .gitignore and asterisk "*"
Thread-Topic: Q: .gitignore and asterisk "*"
Thread-Index: Ad1oWxeTogpFgIDeSbuRePGsSlmGkA==
Date: Fri, 30 Oct 2026 10:46:01 +0000
Message-ID: <07b3498d83424cac87221724b371839a@ukr.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 306743C09838471670C3A432CBD12B959EE002431AAD245CBBDAB492F1292A552000:8
Content-Language: de-DE
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg="sha-256"; boundary="----DCD5165E653A5BFB36710517F9706881"
X-SM-outgoing: yes
X-SM-Actions: SMIME_SIGNATURE_ADDED,DKIM_SIGNATURE_VERIFIED

This is an S/MIME signed message

------DCD5165E653A5BFB36710517F9706881
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-version: 1.0

SGkhDQoNCkkgdGhpbmsgdGhlIGRvY3VtZW50YXRpb24gZm9yIGdpdGlnbm9yZSg1KSBjb3VsZCBi
ZSBpbXByb3ZlZCByZWdhcmRpbmcgIioiOg0KSXQncyBub3IgY2xlYXIgd2hldGhlciAiKiIgbWF0
Y2hlcyBhbiBlbXB0eSBzdHJpbmcuDQpTbyB3aGVuIEkgaGF2ZQ0KZm9vLmxvZw0KZm9vLm1zZw0K
Zm9vLnNoDQpmb28td2hhdGV2ZXIubG9nDQpmb28td2hldGV2ZXIubXNnDQpXb3VsZCBlLmcuICJm
b28qLmxvZyIgY292ZXIgYWxsIHRoZSBsb2dzPw0KDQpUaGUgbWFudWFsIHNheXM6DQogICAgICAg
4oCiICAgQW4gYXN0ZXJpc2sgIioiIG1hdGNoZXMgYW55dGhpbmcgZXhjZXB0IGEgc2xhc2guIFRo
ZSBjaGFyYWN0ZXIgIj8iDQogICAgICAgICAgIG1hdGNoZXMgYW55IG9uZSBjaGFyYWN0ZXIgZXhj
ZXB0ICIvIi4gVGhlIHJhbmdlIG5vdGF0aW9uLCBlLmcuDQogICAgICAgICAgIFthLXpBLVpdLCBj
YW4gYmUgdXNlZCB0byBtYXRjaCBvbmUgb2YgdGhlIGNoYXJhY3RlcnMgaW4gYSByYW5nZS4NCiAg
ICAgICAgICAgU2VlIGZubWF0Y2goMykgYW5kIHRoZSBGTk1fUEFUSE5BTUUgZmxhZyBmb3IgYSBt
b3JlIGRldGFpbGVkDQogICAgICAgICAgIGRlc2NyaXB0aW9uLg0KDQpLaW5kIHJlZ2FyZHMsDQpV
bHJpY2ggV2luZGwNCg0K

------DCD5165E653A5BFB36710517F9706881
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
e2BPmIyTjwErMeZYaQ==

------DCD5165E653A5BFB36710517F9706881--

