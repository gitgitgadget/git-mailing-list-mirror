Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548914D29C
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732775; cv=none; b=GSt8t/0X46dqyJ5derjqSEt6ZWAgt2QM/JQGrJbrdV/bHQ9uTZI+uTFX0y0RmvDbb1Mw5ay2LtgD+knbNgI3NgNa4msim1UVmOMn68PN1tOpceGEuyHVfxAqCJEzqTi9HoTXsgeZfSkI1pfP6XeOEh6kly/h8tdpG0kfXbs3GmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732775; c=relaxed/simple;
	bh=gCwkJjEL9oAcLNp8htxHwHMuB19WSMjk7zJvbNHQShk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPXmddZOxdN/7Pz6CbrVVnIEyKJfrIk/7cPoFyyGir88xS9iNVoRRcs9TMoabatG4iRlUQG1RqPMUj6wm4TxXc6s3bPGc6CsCxy1a8PMuXdfG9TO/YRH6G8JBK/chWEtrKdeuWwwPPxA8rgMJ3Fr57tWXjHoEiwmihPVOiv0Vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=qezxRIng; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="qezxRIng"
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0BD6E5FFAF;
	Tue, 23 Jul 2024 13:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721732769;
	bh=gCwkJjEL9oAcLNp8htxHwHMuB19WSMjk7zJvbNHQShk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qezxRIngyWCMcixsZguOHDNSPMDbCzRjvrp2MBqqXom6fG0o1JJQfNZctvNC683MS
	 S1+gjZHCZLS60b+lwWZlW1eo1e00Pr6LFBCgzKyeshNc+erVm4VyXrg8vb6kEFhJnt
	 EtVe0trX1q4DhK1s2v+owLv8PLAw7cpP9PYcxYIp9IXL8A2cBwE5G04m162Hsp60Yb
	 boOQZOBCbrxQ5K0DoL8s+7b947GWixMpQ6P5mUHmApdLFrOCH62KWUDGNlnSpZB9n4
	 j3nYr3Ni2PIcswbx76eDQnqpI7Eq3PHatnj87VeKxoF+oLHvkJDnL8H1fN8grKcZOy
	 mL9E03a5UA8Zw==
Message-ID: <89d00235-71db-4087-8ffb-7e93c3f470a0@free.fr>
Date: Tue, 23 Jul 2024 13:06:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
 <xmqq8qxvhcy5.fsf@gitster.g> <8404759.T7Z3S40VBb@cayenne>
 <xmqqplr5e5yk.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <xmqqplr5e5yk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 22/07/2024 à 18:39, Junio C Hamano a écrit :
> Jean-Noël AVILA <jn.avila@free.fr> writes:
> 
>> Sorry for not being clear. Indeed I was wrong, Asciidoc.py also has this role 
>> management  behavior for any other inline markup (++, _, *, ^,  ~) except for 
>> back-quoted text.
>>  
>>> How about phrasing it more like so?
>>>
>>>     Writing a string inside [square brackets], immediately followed
>>>     by a string inside `a pair of back quotes`, causes asciidoctor
>>>     to eliminate the string inside [square brackets], because it is
>>>     a syntax to trigger a "generalized role" feature, which we do
>>>     not care about in the context of the synopsis section here.
>>>
>>>     Work it around by inserting an otherwise no-op {empty} string to
>>>     forbid asciidoctor from triggering that feature here.  AsciiDoc
>>>     is not affected negatively by this additional empty string.
>>>
>>
>> OK, but let's get rid of the "generalized role" stuff, then. 
> 
> I agree it is not relevant what the feature is called, as that is
> something we did not want to trigger and take advantage of.
> 
> It still is necessary to mention the fact that [strings] are eaten
> by us unknowingly triggering the feature.  
> 
>> While doing the styling of synopsis, I tried to be smarter than that. There 
>> are basically 3 semantic entities in the grammar:
>>
>>  * the _<placeholders>_ in italic
>>  * the `keywords`, in monospace
>>  * the grammar signs: [, ], |, ..., (, ), etc. These signs are not typeset.
>>
>> Setting everything in monospace would mix keywords and grammar.
>>
>> With this schema in mind, I don't find difficult to understand how the synopsis 
>> is written (putting aside the  {empty} hack). Fair enough, this is more 
>> difficult than just plain text, but the aim is still to get decent output.
> 
> Thanks.
> 
> It appears that asciidoctor considers `monospaced` that results in
> <code>...</code> is a bad match in the SYNOPSIS section
> 
>  cf. https://lore.kernel.org/git/xmqqsew3hdmv.fsf@gitster.g/
> 
> but we should be able to sort it out.
> 


Please hold on this patch. Cranking on your reflections about the ugly
markup and upon advice from Dan Allen (of asciidoctor) [1], I'd like to
push another way of managing the files, which would be to define a
custom  'synopsis' paragraph style which would allow to process
automatically the grammar.

Thanks

[1]
https://asciidoctor.zulipchat.com/#narrow/stream/279642-users/topic/Is.20there.20a.20way.20to.20disable.20role.20attributes.3F
