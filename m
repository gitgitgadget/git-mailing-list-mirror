Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595F23F42D
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771084; cv=none; b=ZI4L7PJlqF03vqbyNszXzazE3XvxXgzf2lmnlYL3LvpM800YEsEYts+b+WR/Ta+vUFIQHwW8vV++2ArdlSv33phht8SNN3uqSngyD8PCSsiwT3aEkitdn52fmamnbbNpEUjHH2sIxDc7eiJe5b5Efp0FHiYCNKAhejT+3of71Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771084; c=relaxed/simple;
	bh=Xvbppr2hm5tpYp+BTigb60r0OrtmW9i7oMOBI61EK6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh2acWQClogyM7kwQYLOe13GMQ5TvDomS8KJImheO3bQ3DAZi5igxTAf1Byv1mNtqS8zDPOcRdnsvJOLwsuLq0qQAoNl4Tby4xR/woaMSO6gcs4bGxMTFS9s1cH5hrqK4i+Cb8n0aQvC3d32YbbmUMKNstS3XrcnpNrNyTGivzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XU5SfEGE; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XU5SfEGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771074; x=1760375874; i=l.s.r@web.de;
	bh=5eO6afJORU5ivj43ecu3ALiC3Bf61HbaJvOjWNwNMNk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XU5SfEGEjd6TicwSEMtsg7c9pW6UwwRmjZLtqoGBKTk1ennmMhI5kcSScMn3e3bN
	 i6B59PHpH+3ubj47iRDKvqJUFJUey/NRFjK7YjM2p4ZoY9nrS3acS2uu90GeCFu2A
	 3lxsUABfKQSUkre4cTbDCBBA4dozyOiGeKz9bsQZKYa9vh7/1/gFcsf6Kdc+alkAi
	 Rp3et2tsmssCkMqrmmHc1ad7etb0rcY51XBt/DaR38EMaEm9jdTHE6HdmJzjIjrnu
	 8GMwzX6naw9kp875Im35xa4+/aAUdXZh8FY+W9p3R2BvJKwqas29wQp1MTZcVxkM0
	 oPutnHtiHWLM8JeQ4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62uQ-1uCYVm1BJw-00temO; Mon, 06
 Oct 2025 19:17:54 +0200
Message-ID: <16d5908b-bed6-4ad2-bb27-9c6523f904d0@web.de>
Date: Mon, 6 Oct 2025 19:17:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] add-patch: improve help for options j, J, k, and K
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "Windl, Ulrich" <u.windl@ukr.de>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
 <75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de> <xmqqbjmlrq8g.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqbjmlrq8g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QqUaH+r1jpFp6wKxjQWauRYhaBlL4gbOM3GDLqUmYkfiCN3oSKP
 U6iQ/3kwjKqFLw4yLrc0TZ14u3YPN0UQfXSEbi4EIEMbOtgmBsiORjVfdoPSPjT/Ly2U0db
 QJp9l+Ghj46L1jAUtARE9SxfDBi4GAG0bUBfSGFxtf/G6LYNOxZih9Eop3HACwK9CAeaXEx
 iNYlnjtpbP/VNORupFU8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:we45SR2unqU=;LcnziR0IXH979w31Uxo0ciQU5HZ
 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
 BLqflU1XF3aazT2Ys=

On 10/5/25 11:30 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> The options j, J, k, and K don't affect the status of the current hunk.
>> They just go to a different one.  This is true whether the current hunk
>> is undecided or not.  Avoid misunderstanding by no longer mentioning
>> the current hunk explicitly in their help texts.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  Documentation/git-add.adoc | 8 ++++----
>>  add-patch.c                | 8 ++++----
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
>> index ad629c46c5..3266ccf105 100644
>> --- a/Documentation/git-add.adoc
>> +++ b/Documentation/git-add.adoc
>> @@ -342,10 +342,10 @@ patch::
>>         d - do not stage this hunk or any of the later hunks in the fil=
e
>>         g - select a hunk to go to
>>         / - search for a hunk matching the given regex
>> -       j - leave this hunk undecided, see next undecided hunk
>> -       J - leave this hunk undecided, see next hunk
>> -       k - leave this hunk undecided, see previous undecided hunk
>> -       K - leave this hunk undecided, see previous hunk
>> +       j - go to the next undecided hunk
>> +       J - go to the next hunk
>> +       k - go to the previous undecided hunk
>> +       K - go to the previous hunk
>=20
> These obviously make sense, but I wonder if y/n should also say that
> they not just make a decision on the current hunk, but after doing
> so they move you forward

Yes.

> (and if so, that may fall within the theme
> of this step, which is to improve the help text on options).

I see it more narrowly: This patch removes unnecessary references to the
hunk's status, while a y/n doc patch would add missing pieces.

Hmm, would the help text need to adapt to whether the current hunk is
the last undecided one?  E.g., "stage this hunk, implies 'j'" if j is an
allowed option and "stage this hunk and quit" otherwise?  Stuff for a
separate series, I think.

Ren=C3=A9

