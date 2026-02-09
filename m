Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628383793C6
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650984; cv=none; b=jib2oHj7yBP3wT9xXR1/MNou/jqwO3u7DnSMRpp10VfrzBA7CBD8+SETJe0+bqerQCWWfAdObR1ZwE+ZY+4KcB9HKeyqh868srnBhCFnRDHdFAx9Q19831ETG15NyqT2JwnKvIiyqQoSxhcC/LtsiypTtyStGPsqOyboH0jfj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650984; c=relaxed/simple;
	bh=eI9zj/EXtA/m4xzoU/BqHguSqYEPeamuL0wfM4y85OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5QeaP3OGZBV5T5O8/kKsRMwdt+xXEXH7UWokwIQa52+Q4PT6B7zIL5zwXD5YTzIxYS5A2462K75nOkVnDreBupR/CMISKxlglyYGwJYsdRtrmmH+M3nbXX6f99PR27w7jJrYbHDvQhaWMqxmDx2vc1W2yh2xsKK7CLBtqFtNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=bhdX/w07; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="bhdX/w07"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7257A3F7DB;
	Mon,  9 Feb 2026 16:20:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njeKi05r_cTR; Mon,  9 Feb 2026 16:19:59 +0100 (CET)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id BCE413F7AB;
	Mon,  9 Feb 2026 16:19:58 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55A26B1E35;
	Mon,  9 Feb 2026 16:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770650343; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IBgWOQDLd9n9fjq1m77qBnQ985YtoIKsSZtivBqIP14=;
	b=bhdX/w07Z++CuvLFdZkqTVCbnOXUJBuq0EJdwus3vc0XWjmb9OApiZuUgGLhaFdQAvNdk5
	F0QxGK6Mmz3wDSlKeO7GOhClZ8Ku4QFIYacPVBXk09yvY5Kru7gUWHN1qLvNPXRqOh5VwA
	hr3BMmbacK/GbtCNw449LnueRSwY4csxVcu9SPTEqmOex0XC5kQP9etmhlbHKKJ0kueied
	q8cbB7pDcdzpn5i4QF0HuIHncrKkLlH+OT0NFoqEs54fSg6DmJsfeBmEKhHMAOQ3Pu/MIB
	sOoeRuPNkfrbbTw6jpj0ShQq6XA9mcD8U2HRoKlcun29q9fsNZwu82K5wGgKdw==
Message-ID: <c3445fa2-a217-4e48-b0d0-ad41a563c6c4@jontes.page>
Date: Mon, 9 Feb 2026 16:19:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <aYkaepCu4lwT3xNl@fruit.crustytoothpaste.net> <xmqqikc66k5k.fsf@gitster.g>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <xmqqikc66k5k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Thanks for chiming in!

 > Isn't NKC/NKD a macOS-only issue in practice?  Anything on the
 > command line "git" potty and "git-blah" built-in commands receive
 > goes through precompose_argv_prefix() to be normalized on that
 > platform.

If we use Jeff's proposed alias.*.{keyname} approach with literal byte
matching macOS should already handle the normalization at the argv level 
before Git even sees it, correct? I'm not very familiar with how macOS 
handles this.

 > I am not fundamentally against this, as long as such an addition
 > does not introduce unnecessary bugs and ambiguities.  IOW, do not
 > force me to read bug reports in this area after it is done.

Understood. Jeff's subsection approach seems safest, it uses existing
config infrastructure that already supports arbitrary bytes in
subsections. This would enable

     [alias "förgrena"]
         command = branch

as an alternative to (not a replacement for) the current ASCII-only:

     [alias]
         forgrena = branch

Is this sound?

Jonatan

On 2026-02-09 15:55, Junio C Hamano wrote:
> "brian m. carlson"<sandals@crustytoothpaste.net> writes:
> 
>> I don't think we have any Unicode normalization code at all in Git,
>> though, so if you want a quality implementation, that may be a thing we
>> need.
> Isn't NKC/NKD a macOS-only issue in practice?  Anything on the
> command line "git" potty and "git-blah" built-in commands receive
> goes through precompose_argv_prefix() to be normalized on that
> platform.
> 
>>> Before implementing this, I'd like to hear:
>>>
>>> 1. Is this a feature the project would like?
>> I think this would be useful.  I don't personally plan to use it, but I
>> can imagine a lot of other people would, and in general I'm in favour of
>> better i18n and l10n support.
> I am not fundamentally against this, as long as such an addition
> does not introduce unnecessary bugs and ambiguities.  IOW, do not
> force me to read bug reports in this area after it is done.
> 
>>> 2. Is my implementation approach reasonable?
>>> 3. What concerns should be addressed in said design?
>> As I said, Unicode normalization may be a thing you want to support
>> here.  Not having it isn't a complete dealbreaker, but it would prevent
>> hard-to-debug breakage.
> A buggy normalization implementation would be also a source of
> unnecessary bugs.  We cannot have and eat that cake so easily 😉.

