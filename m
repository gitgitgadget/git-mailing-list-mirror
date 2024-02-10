Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BE2B9B3
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707561323; cv=none; b=NvgL+u3wUW4BKDarCsl2JIUk1aO2TLlA7JTucBT0kiwLNsbX/rKAS+f/fKa7stAl92zm65nqmmM21oebvDYn2DDHwNb2SV4o71AJ/3tjBR1jdPo9EopBlc4ofxeMDfek99jLXEFv42rs92P3DVZzPN58dDSJfNVqksEAuBE8Sew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707561323; c=relaxed/simple;
	bh=v6lC/AMj9mUrO8F9aqNVmagYqjr5HejHXscdTB5EHTs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=aG0Ta/sWxYObOvpA2lCXd+OISk7VP453hxkUAGwcTBt4RWXzrbgXgckqGPxW+E10rKBYeI/Pe20dzxyea+gGUCLh/yLuaVk5FtFcrjbDx8Hw0yRSrKNtM7HUyTTL7eR7wbdYQt7fI9nrmZa05PyhDw76gK6Cn1Q3QH9w4kzujuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=ceaOUJfr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="ceaOUJfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707561318; x=1708166118; i=toralf.foerster@gmx.de;
	bh=v6lC/AMj9mUrO8F9aqNVmagYqjr5HejHXscdTB5EHTs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=ceaOUJfr07dXPLWDY9qcSRbfy2+NZp2xaVYcGVS4zcS7+w7DutJ/UrtvIa+jswoZ
	 GORg+qk8rqiimZj4Fah1iOskShqzCIx/uCwsnQ4qRcPEatLmq2pRNwIhR7/5xmtvg
	 WsTERK1UP0loIA+BUGfuP254ReXputPF5FC1opi0TGL6YEJC+K36Bl5z2hBEiyLEd
	 o7WTTBjn5rNlyqtRgA7yEKryCi25etrEo0FsioIx+oDJROlqG3+mwEp07Pxw+ChJ5
	 3heorUfIELNc2WPZten6/X/h37iNcNfsTWTfLcL5rbE0O1kBStRT5B+FFR4uUlF+e
	 mtlsIhHV5eKFX6hB4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.1.190.122]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1r44ik36lk-00dm2P for
 <git@vger.kernel.org>; Sat, 10 Feb 2024 11:35:18 +0100
Message-ID: <c936daec-df9f-44ab-8626-5f0813593246@gmx.de>
Date: Sat, 10 Feb 2024 11:35:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cloning the linxu kernel repo at a VPS with small RAM
Content-Language: en-US
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
To: git@vger.kernel.org
References: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
In-Reply-To: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DSO/P129kna+b9Sv/HL8oFKO2YvOyxZPFwx//9gKjfGbEfKcgmz
 B2fZlGrVZE8dy48kucO5qvyQyaVGZlkcAZImjo9jnibwIhSBYbmsw/GbH7WH0Z5LzGwdlDO
 NfNOqBgbGyUwFdnInIsXa8kfx0uK8RKE7JKmDKGaR4DcxKA5IT1N2CzZgi0aqYvb/QSyyIo
 5C2X93gFKlY0PzHnINMoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g2w2/C1f4t0=;dfTIAy2wUj2chA9R5+9TjxIu8OW
 ByMYpZBZCk1eo0mKxOLPx4HJc4n2y02C2UDhP8m5MmjGfi/Whn05QSqV88A9bz/NovphoxN6u
 Q3dE09lcrdUYLyhTNpzDgsgQQwAyYaFMZ3n+vFZC/ImADf51vTuzS2/V4ZueqrPOa9XqxZEf5
 uDtjzUsZSKwhv2v5bNTubGNtGNLNlU8Z4xHJQuOdWK8iS6OmHzI4zsLqYl+1ZoDe1INMGsiVD
 Phozo9J6oqPKkdnO8J+8AQe7TakGI1iwpz9Z2bvTv0UOBa9NnatDmf56rell5/b9BuQE6jlJy
 sceaENn33iswAgbzMKkakLkbtzKNh42IHhtnuwsRqPpWS4+U5TVZAF/kJYjuU4EIyFzZS+tI2
 Dx+niMqKt7IT+Ou+7KlGUhPL1p3DBSvc3VzsGR8Ow8kosB2pUdiISKB+KnqEfNK6rboDwmgjW
 KeXtTQ3JZkKw0lpR4kwJ45l7cMlrbQyQKWPpi11StTtOqpeHDkGYWacsz/bmBy/qFf0rk4SSw
 ljLQyllRP+LSaRELPN1BnLvYM6Ql/VXtyO/2J7yJKXARJ3lp1FQgOzJzCmtRbnrGdFldw8jwb
 udo1pl7SiIKCwwUG8aNMmO5O26SRGFAcMVU+QrU8lpyQY4XU56XMYLgDBpf5Lw9NDlq41s2JC
 bB3p0CbBieLGdXl5+1z2PnyxU+SnCcONHUDRbVkI57SFDdM4MmMnendcyRDSjxnlZ5SxVISEt
 /J1QJy+bslXfVsDwR68UDVpctpBRdtMH2ny+9Ae7nKl31VfiKutUw2rAfVPwOWA3ZcMZc/AlN
 KU0pzLN01/vh0ffNFnWH1c88wKWi1vYteriWA8CY/pkmE=

On 2/8/24 18:32, Toralf F=C3=B6rster wrote:
>
> Q:
> I do wonder if Git could automatically try to deal with only 1.5 GiB
> available=C2=A0RAM?

Given that git fails for the linux kernel repo - where Git was used
first in the wild (?) - it should definitely works for that repo even
with a small RAM, right?

=2D-
Toralf

