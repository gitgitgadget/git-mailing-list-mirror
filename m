Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDA65EE78
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934635; cv=none; b=W/Ue6v2K+d+0pBZiNaXWoXfz7xugXmaZkd0XflE200RsHr7EfBhnbLranIG1+CMjAgRtsthVFKy/SMsDeax5u6ksNx1MkW3zm/rPIxKz0TruzDQ7KFmh29QOYRTCgzQAxqFhe5liM+qjb2rdQ/VvScLQOuwlj9hjt0aaqUEqtdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934635; c=relaxed/simple;
	bh=umkhLmmYyLOA9mqJ8WPBhsm0bpKI5f1+2NbzhgYNBmE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=CXQDPlhem/X2SJIdx9gf+SngT2tN0ZWlhm/Gs21eDsJFPPBR9FD7rBajkqb2MagDThfctMAWHKb1u3MWjRKAtD0BewQ6SHGNGOVow0CcPEdBtMffzURD2vwDbMShFuZBljJsvnBtebulvplCxSfj0ZJGM7jM9RRoNqykQDr08Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/eG8i4n; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/eG8i4n"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33cec911a31so477944f8f.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707934632; x=1708539432; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=umkhLmmYyLOA9mqJ8WPBhsm0bpKI5f1+2NbzhgYNBmE=;
        b=b/eG8i4n8Hwi+otxj1b5Lsm0lcXcUzfXLPZFslmXlD80u+VZBdopABN8UjaURGlLmP
         vIbZE/RkO4rXUdRv8X31BwqFMaew4gW3uHkaSaiA1Q5u/9aSdWsuz7BppUxZBCtg4eVA
         gJ203HhM0qZomMS8kpJpw4cPEl7nG+ARQB/ZV7xUHTZCrKCOUU4eutMXM+Y0VNrk1lpH
         dvLfrfiBZJ8xo2gtOrjT2TYEqvUDt9qEcnSD9fiE+T73Qsg5YxXkHPQBDoa5EudfRi6W
         qfiMvF17S0WcSvFhsf4efANFl6Wxl4iNo0ApyOOlP8wXNqHiLD8kX+wJQxkiO4vDiVKS
         q35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934632; x=1708539432;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umkhLmmYyLOA9mqJ8WPBhsm0bpKI5f1+2NbzhgYNBmE=;
        b=PKRRUSQGyLwI+wc3g+7Dru42w7yVQILLq86Oa1j1tpIeM2F6qS12uCMzvysUgdl/P9
         OOd06Ad6KCswShIeGXvysj26ZKgwbkz3S/SgB4EqjANGJ6EYQ+wwTXlfnD5b5jdtkbfA
         +AZ3pNAZ8iZ3Hc1SuJWYCjzd89CuXIVl1rzRCD2NwyZuo/o/jw+oZXmnDE8ezG9N1m/+
         pZg+0bcaggDeglqTHHHLXyykTkPZ7X9vkXDePxiSUqIVbYRCHrL+7VAMLwpDirWW6HDl
         cjnqeV2rmtBgQthHYuZg3IxVr2eiuF34Y8XlVwgKInzcjMMLoELVjhwvFB/t0X1OooOg
         qsqg==
X-Gm-Message-State: AOJu0YzdeawszkNzrVE7vi4rx3EDHXRH0+vC9GkYcAfiFpayrmKI4b2v
	Hr/TIVV0uHFPol1ETti1Npuy2wtrrTQMKKwpzd0Pv3q1mH5n6/r3zD8BAX9/
X-Google-Smtp-Source: AGHT+IGQWsaPBHd5+eYX3dLfIcPr26z8uegwhBokDBuk/Jsb3BjvrX11aSXPyALukNkvyse40aULeQ==
X-Received: by 2002:a5d:53cd:0:b0:33b:14f8:732a with SMTP id a13-20020a5d53cd000000b0033b14f8732amr2358466wrw.45.1707934632021;
        Wed, 14 Feb 2024 10:17:12 -0800 (PST)
Received: from DESKTOP-T29D115 ([39.49.135.219])
        by smtp.gmail.com with ESMTPSA id bp9-20020a5d5a89000000b0033b4796641asm13286576wrb.22.2024.02.14.10.17.11
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Feb 2024 10:17:11 -0800 (PST)
Message-ID: <65cd03a7.5d0a0220.72a87.c501@mx.google.com>
Date: Wed, 14 Feb 2024 10:17:11 -0800 (PST)
X-Google-Original-Date: 14 Feb 2024 23:17:12 +0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: krisbrannon920@gmail.com
To: git@vger.kernel.org
Subject: Project Estimates
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQpHcmVldGluZ3MsDQoNCkkgaG9wZSB5b3UgYXJlIGhhdmluZyBhIGdyZWF0IGRheS4g
SSBhbSB3cml0aW5nIHRvIHlvdSB0byBpbnRyb2R1Y2Ugb3VyIGNvbXBhbnkgYW5kIHRo
ZSBzZXJ2aWNlcyB3ZSBvZmZlciB0aGF0IGNhbiBiZW5lZml0IHlvdXIgYnVzaW5lc3Mu
DQoNCldlIGFyZSBhIGNvbXBhbnkgdGhhdCBzcGVjaWFsaXplcyBpbiBwcm92aWRpbmcg
YWNjdXJhdGUgY29zdCBlc3RpbWF0aW5nIGFuZCBhcmNoaXRlY3R1cmUgc2VydmljZXMg
Zm9yIHZhcmlvdXMgcHJvamVjdHMuIFdlIGhhdmUgYSB0ZWFtIG9mIGV4cGVydHMgd2hv
IGNhbiBoYW5kbGUgdGhlIGZvbGxvd2luZyBhcmVhcyBvZiBleHBlcnRpc2UNCg0K4oCi
ICBDb3N0IEVzdGltYXRpbmcgKE1hdGVyaWFsIFRha2VvZmYsIFF1YW50aXR5IFRha2Vv
ZmYsIENvbXBsZXRlIENvc3QgRXN0aW1hdGUsIE1FUCBFc3RpbWF0ZXMsIEdDJ3MgYW5k
IFN1YidzIEVzdGltYXRlcykNCg0K4oCiICBBcmNoaXRlY3R1cmFsIFNlcnZpY2VzIChE
cmFmdGluZywgRGVzaWduaW5nLCAyRCBhbmQgM0QgUmVuZGVyaW5ncywgTUVQIERyYXdp
bmdzLCBTdHJ1Y3R1cmFsIERyYXdpbmdzLCBIb3VzZSBQbGFucykNCg0KV2Ugd291bGQg
bG92ZSB0byB3b3JrIHdpdGggeW91IGFuZCBoZWxwIHlvdSBhY2hpZXZlIHlvdXIgZ29h
bHMuIFBsZWFzZSBsZXQgdXMga25vdyBpZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4gbGVh
cm5pbmcgbW9yZSBhYm91dCBob3cgd2UgY2FuIHNwZWNpZmljYWxseSBoZWxwIHlvdXIg
YnVzaW5lc3MuIFdlIGNhbiBzY2hlZHVsZSBhIGZyZWUgY29uc3VsdGF0aW9uIGFuZCBw
cm92aWRlIHlvdSB3aXRoIGEgcXVvdGUuDQoNCldlIGxvb2sgZm9yd2FyZCB0byBoZWFy
aW5nIGZyb20geW91IHNvb24uDQoNCkJlc3QgcmVnYXJkcywNCktyaXMgQnJhbm5vbg0K
TWFya2V0aW5nIE1hbmFnZXINCkNsYXNzaWMgRXN0aW1hdGlvbiBMTEM=

