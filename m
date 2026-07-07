Received: from star.nullroute.lt (star.nullroute.lt [80.209.228.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2BF395AC4
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.209.228.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451481; cv=none; b=UJBZqxkcbwdYathaFVU5Kw9nkQGrc1niEwIgBfuho6Ztm1CWVEQsuqaPraMoCTsAgr5KeoIrHUMB0qLRR3v/QBvGpeghoRb0trQBCGyfX7NOmpsennUFoWjDdcxi2fZAwfBZinRYv9Qh+LyEEL3BQ2vMtJHfeTKsKrk9oRD9f/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451481; c=relaxed/simple;
	bh=P1tGtmKUHgppxjsYKbSpPq3FVOe0+YvLhZxiNN8iAzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGj1A6BPSpEjy0BKxdKiuKWZWDGgDdHisdfIvtxG27TD/pheNapzZmMiEXs1v2wFPJ/yBpsxL4DdyvlIG0gr4Y/wHb3hmHf5wpaGR1p93fCNohxQy/AhGIyasC5F2XX+3UYeqvJgBp5XAe56K0BkbFAuJg1PBP/wUQTesYScrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nullroute.lt; spf=pass smtp.mailfrom=nullroute.lt; dkim=pass (2048-bit key) header.d=nullroute.lt header.i=@nullroute.lt header.b=um1rUuWZ; arc=none smtp.client-ip=80.209.228.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nullroute.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nullroute.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nullroute.lt header.i=@nullroute.lt header.b="um1rUuWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nullroute.lt;
	s=20211002; t=1783450911;
	bh=P1tGtmKUHgppxjsYKbSpPq3FVOe0+YvLhZxiNN8iAzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=um1rUuWZIrgjol/Et2IFRqT7VDz7BgreMxj094N2jCzqVb4dJSoEne5/ORPGaR9Ow
	 RVYB22lejSiVkIdWhntBJ++qg/WDsmPK3I1mrhF5mOD6xSZ662SUY1I8hARwMNr5S7
	 TNRZpnI0x/e/sXd7Vr1A62vgLXgWDiF1opG/wU7/ncJgtV4wcA3Hn/ukQmsgZgDkUq
	 ZyMkDjDl1gsYeHudmuVGCrcfC9tJih8GguaULhhotX7OLTbhX2EIYdAvwTs2Zd+o8Z
	 AzbDstbwB26Wm+SLAddNS9bylrZQh9uPrEYnbX/LqzkT/s/JVs2cu2308Xhh7B2eMo
	 MZ8ixi6Ykh7+A==
Received: from [10.147.2.15] (unknown [85.206.91.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature ECDSA (prime256v1) client-digest SHA256)
	(Client CN "grawity/blizzard", Issuer "Symlink Enterprise Root" (verified OK))
	(Authenticated sender: grawity)
	by star.nullroute.lt (Postfix) with ESMTPSA id B78112007E6;
	Tue, 07 Jul 2026 22:01:51 +0300 (EEST)
Message-ID: <897cefe6-18f1-4c53-bf2a-dd91052e70e5@nullroute.lt>
Date: Tue, 7 Jul 2026 22:01:50 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sideband: allow ANSI SGR with colon-separated subfields
To: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
References: <20260513070803.163546-1-grawity@nullroute.lt>
 <8addf7c0-ae39-f1c0-20ab-52114702aaf6@gmx.de> <xmqq4iia4q8t.fsf@gitster.g>
Content-Language: en-US, lt
From: Mantas <grawity@nullroute.lt>
Autocrypt: addr=grawity@nullroute.lt; keydata=
 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
 aETxZy4lQ+jpsbG/q9fvS/sAZA==
In-Reply-To: <xmqq4iia4q8t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-07-07 21:19, Junio C Hamano wrote:
> A need for fix-up like this does makes me doubt out decision to go
> with whitelisting very narrow cases that are known to be OK (and
> finding that the cases were too narrow and we need to extend),
> instead of rejecting known-bad cases, by the way.

For the SGR sequence (CSI ... m) AFAIK there are no other value types 
besides what this patch adds (i.e. colon-separated decimal 
subparameters), so the filter will now include all possible cases. It 
already isn't picky about individual values.

As for everything else (that is escape sequences in general), I'd say 
there are way too many "bad" cases – which can toggle terminal modes, 
display images, send notifications, copy to clipboard, move windows 
around... which a remote "status text" output has no reason to include – 
and basically zero "good" cases. Though the code already disallows the 
majority of harmful cases by only accepting those starting with CSI 
("ESC [").

In fact I might personally go further and disallow even all of the 
cursor movement sequences and leave only SGR and EL (clear line). I can 
imagine a use-case for free cursor movement (parallel progress bars like 
in Arch's pacman?) but it practically requires the sender to know 
terminal dimensions to be useful, so IMO is entirely out of scope for 
sideband status output.

(Progress bar for example (OSC 9;4;n ST) might be useful, but IMO it 
should be generated client-side, with the server instead having some way 
to report an integer percentage through the protocol. In theory the 
"hyperlink" sequence (OSC 8 ; ... ST) could also be useful to send as 
part of status text, but I'd personally disallow that as well, given all 
the reporting last time someone discovered it was possible to link to a 
file:// URL.)


> Thanks.
>
>> Ciao,
>> Johannes
>>
>>> Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
>>> ---
>>>   sideband.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sideband.c b/sideband.c
>>> index 04282a568e..6cf70ef6f6 100644
>>> --- a/sideband.c
>>> +++ b/sideband.c
>>> @@ -163,6 +163,10 @@ static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
>>>   	 *
>>>   	 * ESC [ [<n> [; <n>]*] m
>>>   	 *
>>> +	 * where <n> can be either zero-length, or a decimal number, or a
>>> +	 * series of decimal numbers separated by a colon (for 256-color or
>>> +	 * true-color codes).
>>> +	 *
>>>   	 * These are part of the Select Graphic Rendition sequences which
>>>   	 * contain more than just color sequences, for more details see
>>>   	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
>>> @@ -210,7 +214,7 @@ static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
>>>   			strbuf_add(dest, src, i + 1);
>>>   			return i;
>>>   		}
>>> -		if (!isdigit(src[i]) && src[i] != ';')
>>> +		if (!isdigit(src[i]) && src[i] != ':' && src[i] != ';')
>>>   			break;
>>>   	}
>>>   
>>> -- 
>>> 2.54.0
>>>
>>>
