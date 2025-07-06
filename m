Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C753595C
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751804420; cv=none; b=AuNfqkn4SdtBEsaN13hZtFgYeYQxdFE5e8f96JDQpJlGt/cBfVw0nzb/at2l8+HmGCgr4IW8sBA94BDzbYolq5WvNoD/khkrgqxZelsIJ0c0Po2c2+KPdc/kRimsjvpajneHCrXMtVXw/4LfzoEGePJgSh/olESWDai+NKQY1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751804420; c=relaxed/simple;
	bh=LH3x2oH0Q9vMnE2kESAt4YcwrYStw5gjagi6yRA4hPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ra2LZWxnthqu56UPnt+Wi5MNJY/Hrk4J/XcYr5eWDZmrIG/2BZsEx9VV+IswxFrquUbvIvrDsPnfgJ3xfbfk+MPhZ9wkHnqqQIJJni0HfZdeKMwrSnk5x6jmu8jvqxoHBSnsWxh/PiLQGF5nn4w3G/WjxOy3zzMoPHjrlfjdZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TDR8LYyw; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TDR8LYyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751804408; x=1752409208; i=markus.elfring@web.de;
	bh=LH3x2oH0Q9vMnE2kESAt4YcwrYStw5gjagi6yRA4hPI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TDR8LYywAFvurfOTbJY/FxcDqcDwCfX38mlszJwElwiVyeugICP0ckGUWCPFEIaR
	 QJmUJoYQMYb52TGOtoIrhrjza1LJcIDC2RpeAgx52t3NzaimlspsgAPIus+s0ZVji
	 ivaDm6N6mVsz3wAvxRhjAnJEPnnCeOc9xxeKFkvS7HoH7ZfHcbcHYRMTrasVAH4XA
	 IiTFxFycEF17TN3BvXZVavZEQegnHlIuQ8exp5abUq+bFtFsZXeZizzeZv2kAf7zK
	 eeQ4+nrPlTVQ/IGz3deXrhjFsupgstttDR1q9PWYjFh47UgKjwq0v/Yf7XpYtTr3E
	 hyRqpY5T6pS5dwD9pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1uJCqH0yxV-00SJHr; Sun, 06
 Jul 2025 14:20:08 +0200
Message-ID: <b1753222-0043-4b1d-acd4-9afac0197c65@web.de>
Date: Sun, 6 Jul 2025 14:20:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_How_to_restrict_command_=E2=80=9Cgit_grep=E2=80=9D_?=
 =?UTF-8?Q?to_the_first_search_result_per_file=3F?=
To: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
References: <fb74577d-f7b8-4fde-ab5a-5283e70b8258@web.de>
 <87wm8lo89w.fsf@igel.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87wm8lo89w.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:368lnqT9dYBegpB2WnLDiaBYsh6LfbhjGOk65IbskL2ZsZtqbIg
 nzy4PXBGIp8JEf5FF7yQygEUJNuYxf0O0CqLK2220oaKwTjSaUizgu+DMiyctC5t4LNuCIb
 Lz72Ep6agboBkfWiPGOHloMSEXcddK6IPWekBjy9ypXZ7JvuOc/j1qiLU5qkcdTgjTnTUMv
 SNGAH5zTqUPB7lNen3SNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yFHTiJawMZM=;+M3moALsjM5a0//UgJEejVXUmWt
 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
 qwiO6ewz/2Q==

>> Would you become interested to find specified items only once in each f=
ile
>> (instead of multiple times)?
>=20
> Does "git grep -l" suit your needs?
I imagine that it can occasionally matter see a bit more context for a sea=
rch result
besides a file name.

Regards,
Markus
