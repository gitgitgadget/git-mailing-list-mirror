Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083B15699D
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023659; cv=none; b=S9RiNAQVafxoz2pAcIQcgUD3g9wA//2Dl4CLUyXg9czSzhaBkkbAATj5XdPwioZ1B85tfndF95zp6iIrvdFtADEgBQlN/GcKKAbAjyS7gC+glYUiKghfpL5lnPS7V0frqwkhT3UYp9hXR8Y2AvDFZHk3btQvaq5ve0fM+6d329k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023659; c=relaxed/simple;
	bh=ndnVMqOmpqbMDGc7jdzIYk2NeThjzlFKodf8RnmJ5O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twgsqdXF5HddKaDZ8+SI4SXM6cKC0IeitjgrVVPy8xLB11kRIoqI5OUz3TXmyeNZa3xs31Z2v4vGpg9TTm8/1qhYtMVT3g1l0/flPwhFEtK1D2uc8WZDJEW7+iTXzcsnmzdfoeup8ENXcZ9Jq5rcnUw9yIL6SXya59NxtzafulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fH4VZPMm; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fH4VZPMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729023649; x=1729628449; i=l.s.r@web.de;
	bh=LcqQtQ0zy0PDaeEd8iO8OnBv0FWJSZF2PGCke/8+AAA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fH4VZPMmIGND2stRNTJF/tGF0IzpvyUC3HS7OLMzhPWPFgV/SkCtK7AWlRmMwWPK
	 dAnrZVlyuqI/WYxAlsmdU0/g9GdKwHpYQjz9oLvw4QAJfBiyJCFXCjiVgrLionA+F
	 UC1NzhOgLnpoUJ7GhmFlbEe3QL2mg4KovZXH3asXAlHAC7AQwlSxW4wsTQ+l1P836
	 sj01XRHf0QfB7UGXrHt1AEXxp+6jZVY62nX+d6e/sFS873WioXLeh8cYz0kHJLogn
	 pJw2Zt4RzYbKGK/ZZ7SHdpw9VlAioTodF06cNNG4zsm2qFehDsCsseNPA+nEFCO+Z
	 q1TCnerYAjUDaATIuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.30.137]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMEW-1tcd9C3hSw-00hPxd; Tue, 15
 Oct 2024 22:15:29 +0200
Message-ID: <0eaf6c1c-7205-4897-ba19-e5ba03194012@web.de>
Date: Tue, 15 Oct 2024 22:15:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git grep does not find all occurrences on macOS
To: Taylor Blau <me@ttaylorr.com>, David Gstir <david@sigma-star.at>
Cc: git@vger.kernel.org, Richard Weinberger <richard@sigma-star.at>,
 Jeff King <peff@peff.net>
References: <771C9C4E-45F1-4F71-B3A9-4E8E4A9CAC1F@sigma-star.at>
 <Zw22sTxyWCbczZy8@nand.local>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Zw22sTxyWCbczZy8@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:unjZGNliUkqBY8OFjYpuvD3Arg14O7sxJkb91YeUwNaSfe+SJ64
 5QOP+3LCmahMpxxtDUBpNSr9DDbpWcClB2eLNYKRfOaBKcCILndjIKzbjiz/+HT7ucDUeee
 R96PyjCWBd28DlkEzugrBQEMPGjqSyYFvhtDqwdMlqW6Ckc6roFQtQUxbzFtyX/05WWyCws
 RilEJZwQ7oUT4XShOeuOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H/6fZZ7otxs=;L5GrnTFmh0GN6sFZ7zAAR6VC/Xb
 580xic40iMBRnMUYlxzHJZg55qIgnkqZNFPMmsC4m2OSNSbAFvwj1yfvs6dHSOmz2z00wqOMb
 jUyjtcu1c3rAUIUjHZ7CpcGof6pV+Anm4iP2NCwXCkxKQTr3BbliXIBZrmu6kZXIpVYSA4Miw
 D6yRHxzxFGnNrrDHRnnHbEKxM3CNkVWNY5qDfWNR6Sp3mWUpNHT8V2MwfvlsF5v7C/+krvQL+
 GNmw+rdh7bRWW46Sr3Vc9yeREVo+yKNSUnG8ApXClbFEyEbVCMFvU8vtxzlCNR4V1olagGXFV
 e+6JGDSGETrf4HYznhzNQH70vWHLQ/9ITgglzW5YwpgvnhSGbIFJc64XsglZVtp7SZDVY8hES
 09gVRe3nEqC9T3vlWLqciHESwKAwJfC32s1RPTNDiyTGI1qll9Y1WeLTZGCBexQOlCPk6+FJ8
 lyKnCSXWaD1lrgaruzvRoQ8LgikQD4fLieXXIfkc2ppL9UbX5w1OoON2WFGqYZZfySStVAXVI
 Hlsps2pGudVt/kRku4+qNu0MRz7l/fSHN5ZzX2rfXuexU9nekK5vzPjibPlC92/WebGR9dawz
 SZTSr79E/V5tsdrAV9trnnfZKdjHZo0BHhHxQMYIGg2e6kzOr9sCCdMuOA9PZHNe1wL9lO2N5
 g9SeWiaffYXNMBNHhDJNz8Jhg/sJAtCrcwKoGBxzrIEYuI1EHMwml8vnmK3ANKEBES2Qj48hS
 3o/z6YorutvOq9iwjIPlQP1bRYh+qQT/v6QQy3rfPyubFHataim71Po1LLR79HEcKT/mp7c20
 NSHgtQx64+y4MVN6fMDGXqRA==

Am 15.10.24 um 02:26 schrieb Taylor Blau:
> On Mon, Oct 14, 2024 at 03:34:02PM +0200, David Gstir wrote:
>> Hi!
>>
>> I encountered rather subtle issue on in git 2.47.0 on macOS 14.7 (insta=
lled from Homebrew):
>>
>> git grep will not find all occurrences of string patterns containing a =
=E2=80=9C.=E2=80=9D under some
>> conditions. In my case I have an ISO-8859 encoded text file which conta=
ins umlauts.
>> If the string I=E2=80=99m grepping for occurs after a non-ASCII charact=
er in this file, git grep
>> will not find it.
>>
>> I=E2=80=99ve put up a reproducer here https://github.com/iokill/repro-g=
it-grep-issue, but the gist
>> of it is "git grep quz.baz" on the ISO-8859-encoded file below will not=
 return anything,
>> when it should return the line "quz.baz=3D3":

Can reproduce on macOS 15.0.1.  Bisects to 1819ad327b (grep: fix
multibyte regex handling under macOS, 2022-08-26), which enabled the use
of the system's regex engine.  grep(1) does find that line.

regexec(3) returns REG_ILLSEQ (illegal byte sequence) for that file,
which makes sense.  Interpreting that result as a non-match of the
whole file is not the best way to handle it, though.  Reporting the
error would be one option.  Turning off lookahead and matching each line
separately might be better.

Would setting the attribute working-tree-encoding help here?  Not fully:
The file would be converted to UTF-8 before commit, but git grep without
a tree argument would still read the raw file, without conversion.
Shouldn't it respect the attribute and call convert_to_git()?

Using -P to use Perl regular expressions would work in the example.

Ren=C3=A9

