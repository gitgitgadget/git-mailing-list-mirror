Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215C139CFF
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976806; cv=none; b=S2fVAI447ek0KZEnRzQUPteO4nCO5WrHSj1oSKEyQEpNFlHLurOQxiTnO6bnYOvkvFjp4IA/+7vhdljECmGc7eSmw54GMvj3LWyvu0Jn5m2nQKPZp42n21tpEI+8xo9KhkTtJjP2V+MUA4dZHWTHUJKBoG8cJS5VFm3xkHwka+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976806; c=relaxed/simple;
	bh=r3eFq96VQnUmoKDE5qQf5Cv5Oq3uxVLQL8aIHO/Jpnc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eU9MGH44XxC1rI0FtSFSNDX8PpkkS2alt2UEY4AUi7xAanQznCiCkozrc5DdQcRysFB5G4dygZOKnHjiNWxqhEZdA4ANmnMZWvHlXt/kc2wssMFe0SG8Rqt+dl4fV+Q0YxUTo5De2USabylnJjXyo3ZPfVmgdKuc+P0htYZNSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GVl7CtnP; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GVl7CtnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720976791; x=1721581591; i=l.s.r@web.de;
	bh=MoY1mp0ageR8xQtyedW/hcfK1BjDZkHAUQ4yYcIcTFY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GVl7CtnPrqNMaoiCr91OI/ViSAKnf9GkgwmP42OuI3PEjLpd+0g8sgWxtOnIBBaR
	 Vc6rnxQtVHTmCRyEy8y7jP1ZsBeWA/TtMJl1N3FqUsDgU+8lu0OIErIPzVZtdnavs
	 1CPSeMHEY/TSRBngaZMWfm9WFqBqEJxXN2gqtNsP3iRHEEZhN+coqQDWxcfw2Ea8V
	 o1znlQJi1+M3bymDUWe3QDAu0NV/Y/ymWEJwj1eQtbDSUrPfGZDyk4RGSI+KH7I15
	 CjomGBsPxCJSriKfb0gG6zv9r0w2soM1vmqZnoVjzZksqLD2hM5lqJICXGL+uBeiy
	 GT1h2cPxFziG7F8/SA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUUAG-1stXnC3TGa-00V52T; Sun, 14
 Jul 2024 19:06:30 +0200
Message-ID: <d91c794a-296f-469d-9f1d-0b45351e8ba7@web.de>
Date: Sun, 14 Jul 2024 19:06:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] t-strvec: improve check_strvec() output
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <5bbef273-382e-4096-9ca6-d74781223e55@web.de>
Content-Language: en-US
In-Reply-To: <5bbef273-382e-4096-9ca6-d74781223e55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:odmaZ6TCBCY83a2nhu3LTpRKqIKi19t2oLxSq6SaDzXUvkO1/Uw
 s0cBDWlOlbr/FzW484kXquEOa01fXGJS8VyUFho9mGXlRPs5BZ+f1f4ZN/H7LC48u1Z7EY7
 87IWafSWJqUcU6I2qJJ9VfpGMMOYCgdb/r/yuO8ATuw1if2eHdzIbEv25Zo9J0pc/LAkfjU
 38n/WcxE7AWSGaS9Sc4Xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UXYNNhEn1eM=;0DcU9AKdOOsKLau0jjglxMQ7L55
 wB64XE5db1sf700Lr0PVJsYhCm1b/ThgICm7/NRgyS+RErLzur8V9awz2B4lMiqgtmuwcg+f/
 YBMKK6G8Zs97Ukq7nfc16qCLTIWkyn4ZnN9qZC+AqDQxEfJ5gjCbLLh4WNeVlFEBllIVfiBIM
 +PeEpC+cyjjxqqPwrriPAP+M23kzvQHRmbRhDhwDZ+5nJZ+S4YYCBJjrw1ap/+aqhYUMHvsgT
 r7cyb8eVKPR73xajQnS8Ru9f7FiXbFdSLL9tk7NfnI+9rL/rxQZvn+y/2zjoDB6638nBZbdHf
 k67QIOI3C5qrRssMy0CyXXGy5wjFen91k9D9BiG93/Gsutrqp/Q/gT/YEAU/zU7AC+hOOtgGQ
 Em8QQ/HckTTj4C5z9aAw5yHFRkeUnNe5/ePvNg0LVL1pFkN4gVYr7NXaLpnM4VhJowQkBIWBH
 4mqT8HFUmraR/R3LrPLrHsLU2X0ABuCkOPfk0Yz6dga4DF3ziZ0DdJkJeR247oY0SELl9BUmN
 Rr7kHazYtGZxM5DaMU94SfDxCR+NhFwyu/OMtUsGo4r+arswpQAb3YTWY+xNsbN8Fuw3ioqPS
 iaKFIyxGl00ChPa/MyW/yVSo0H5nj5RxP3EIMA6yEDVbMXJbYQ7wrcbjq22IOm7izJc4d9WLJ
 wet/bjsudsISUSlGcs8xgHZM+ys0KwdjqjmB4XNXONWNmvB/EoNy8zl1RG3XQ7J333ivnHwdu
 0J129Gnq9zhCP3PrvbQQW+z5ajvdTPvQNon9w9kVitRzdQSQAOvbYNRVObCghPRpV5IMzwNMp
 TvO9d+bqcCN2aNNGBRcqlnHQ==

Oh, v2 is already on next.  Will send the equivalent of v3 as an update
on top of next as a replacement.

Ren=C3=A9
