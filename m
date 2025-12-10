Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04120276020
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389713; cv=none; b=ec3rRZQodolCSg6gjN6c1lzjdmzd7oWtZ08CHRZcsERCY/VQsIxUfgkYqfbMqwNwx7hdW1hXnPIygui6QgyB84/CIBvLDYSbRlfoYgD7/M13yT98+oEQ430bquvgqWvR1fkn0JfTkbYjcmgq2nnxhuPHjWuXQ2tHWJMjCqvnR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389713; c=relaxed/simple;
	bh=1xnqBniz3TDN8i39qzM9qVpgfIxJFge76ZPk4lJjJQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJOYeZxvxDXpLAyU6GEJ1YNPgSzQ82AyTzn9GM0VkA7s8meWb5QJ1zgCkodi+PiQm4u4PoRK1TvWabCO0XxccE+Eyi2a0qAZMq5qK/BDps87TpQpbh7ocQOiZw1zQHXqA3ux9WG2qb7nWsf86rUWFbg5mOOd52XWt5sAdwRk2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NbHahcwY; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NbHahcwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765389709; x=1765994509; i=l.s.r@web.de;
	bh=ToUuD6kzrgt85+oJxr3nTVn6+37BnIaTXzEUaMF+q5A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NbHahcwY9llLs6lyreTBUC2RdsbBtzNXr2TEZsNIeRNvXH8fiN0UqOtR5G+u6Ujv
	 EamlrPdf6NiC3Thlu8AS5NT+YNs2pf2mLbQAPzQTU/nyRxseJA88R88l71eX7/CI8
	 U0pgC77JbYMUjWjs2aRKivAPT/70zFSGepoLfDh/TE5uKdUjDaDBqQHQw6RKmeG0p
	 y9dj/3W0Sthpo6yJhtgk+nNLe4WMDi5VxZu8dXVDvFqUgYxn/1oHf9M4RP7odlVPb
	 V1Lk5GCrO0nJsk1P+AkUO6pcObNrjuSwe6kE4+0i4BVvJdNLOJmVIJK1avcDOxVar
	 001in4V4f/CLhVWwtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79NA-1w5m6S0qTc-00tQGP; Wed, 10
 Dec 2025 18:56:36 +0100
Message-ID: <1b3509d7-e421-4136-a62c-de86213d65b2@web.de>
Date: Wed, 10 Dec 2025 18:56:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a/BgPtmA0XSqKiPqIi5ek5gDXwbsY1Ewf9G6S97zyHmBI31prJ0
 y9hj5Vxfmcw8aWnYc2bs+0ztUzK4BRpd2AiTnujeQSw9dGJfLNQWmkVTEDqA7GqPCiOyVSK
 AqYcP5eNLWHexv/QSZbURQlu1gXj3DvBMWBXPiJld8bHmZBsG3Vmg5my6J7dpBdTABoGmhw
 PKz13aJDnhShAzp/ozdmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pjQF+tEcaAw=;U366KEqYIC/0Ygo2Zkk/XLRLDMu
 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

On 12/10/25 12:17 PM, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> On Tue, Dec 09, 2025 at 08:35:34PM -0800, Ren=C3=A9 Scharfe wrote:
>> The library function iconv(3) supplied with macOS versions 15.7.2
>> (Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
>> ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:
>>
>>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>>
>> As a workaround, use libiconv from Homebrew, if available.
>=20
> While I think Homebrew libraries are usually better than the ones that
> come with the system, there are reasons why you would prefer not linking
> with them and therefore forcing Homebrew as a dependency of your binarie=
s.

The patch doesn't force, it just changes the default.  You can overrule
it by setting ICONVDIR explicitly, e.g. this will use the system's
libiconv:

$ make ICONVDIR=3D/Applications/Xcode.app/Contents/Developer/Platforms/Mac=
OSX.platform/Developer/SDKs/MacOSX.sdk/usr

> One particularly good reason is that if you are building a fat binary (
> useful if you target recent macOS which still supports x86_64 but don't
> want to distribute different versions per CPU type) then the system
> library (even if broken) might be preferred.

How do you do that?  By calling clang(1) with -arch x86_64 and -arch
arm64 and using lipo(1) on the results?  Is this possible with the
current make files?

> Slightly off topic, but should another patch that adds a `NO_HOMEBREW`
> Makefile flag similar to `NO_FINK` or `NO_APPLE_PORTS` be added to help
> drive this?

Sounds like a it could be useful to someone.

I'm a bit puzzled that they are implemented in a Darwin section of
Makefile.  config.mak.uname would be a better place, no?

Ren=C3=A9

