Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7313C8EA
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354243; cv=none; b=dA72dV/TUC2GiDO2yfeqUJJqdoxaueGKWcKjmBJEa+avk0WrQ4MUY2a7MkCIuuiobgT8zMUOggpAE4/vhI5s/AvfVI20UAoisx5HdbsrGnkIfV1yNjpmkVnc0SxTX3CiTqtxeYn1Q8wcOjT7JyDumrD7dEXxgueVS7O07r++SO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354243; c=relaxed/simple;
	bh=wbabYIZG7moFtHrilRsO3VsQPJOibqORvDGeL/DE8wc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NqctZ8TOPaMFx1P+M32LQ7Vk1py01xtMlsfytryawdn79KZNjNtDzSolJknd+Qm0EGcfub5OwZuAd87f4xw7zzPTZ58GR2jR63JCkJzO/uLVKzGmWySw/BAD6miQ5zT6vcQaIB2mjBf6u/N+Mu4tKJGjPu+/qZYoxSY1OZfKrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=k0H+hi+t; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="k0H+hi+t"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713354239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQnKH5adKaofQNE9C+2vjHi7990Akt3KEiCOZ8RAUyQ=;
	b=k0H+hi+tRHsFo4iVbfJn0YqP/e2aMri8o170xk2MwZn9wXKYEFnZpjQfEO/NXBv5tkh06e
	tLBPEdzLY6Q8sdCMp3eBXj7NnODBWpKUvZd5Y5dx2CUc0vVVxsrlSOyekf6FEV6hKb9kyQ
	R/cMC9raK108He4dtaMm2+yBKLfgiGtQxlpS8L7S+rPTG03HDttQLDNbsJh3aiGwT8+vPQ
	60Pf9IRU8610tTgrJuGyTCC3Gmzwx5mv8c2mzm103zlBv7FFpSg9qgcekFfP2OFxEzq5+W
	Hx3oR8/Mstj94pUZqngzrNfw6bFKegTRM8G8Jp1DOLXqMow0lxDeW92oWPRQ0A==
Date: Wed, 17 Apr 2024 13:43:59 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <e3caab896300a2da9fcde2e0b2efe3d2@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <1f31004bd8445e1e4717817638d5509a@manjaro.org>
 <d60e5ddd-643d-41f2-849d-6ab660df734c@app.fastmail.com>
 <e3caab896300a2da9fcde2e0b2efe3d2@manjaro.org>
Message-ID: <b4d2b3faaf2914b7083327d5a4be3905@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 13:34, Dragan Simic wrote:
> On 2024-04-17 13:31, Kristoffer Haugsbakk wrote:
>> On Wed, Apr 17, 2024, at 12:52, Dragan Simic wrote:
>>> On 2024-04-17 12:02, Phillip Wood wrote:
>>>> On 17/04/2024 04:32, Dragan Simic wrote:
>>>>> Add --resend as the new command-line option for "git format-patch"
>>>>> that adds
>>>>> "RESEND" as a (sub)suffix to the patch subject prefix, eventually
>>>>> producing
>>>>> "[PATCH RESEND]" as the default patch subject prefix.
>>>>> 
>>>>> "[PATCH RESEND]" is a patch subject prefix commonly used on mailing
>>>>> lists
>>>>> for patches resent to a mailing list after they had attracted no
>>>>> attention
>>>>> for some time, usually for a couple of weeks.  As such, this 
>>>>> subject
>>>>> prefix
>>>>> deserves adding --resend as a new shorthand option to "git
>>>>> format-patch".
>>>> 
>>>> Playing devil's advocate for a minute, is this really common enough 
>>>> to
>>>> justify a new option when the user can use "--subject-prefix='PATCH
>>>> RESEND'" instead?
>>> 
>>> Based on my experience, "[PATCH RESEND]" is roughly as commonly
>>> used as "[PATCH RFC]".  In other words, it obviously isn't used
>>> as much as the good, old plain "[PATCH]", but it is used.
>> 
>> The format-patch generated string is `RFC PATCH`.
> 
> True.  It's just that I more often see "PATCH RFC", for some reason.
> Please note that I'm also taking other mailing lists into account.
> 
>> The number of emails with `PATCH RESEND` for this list:[1]
>> 
>> $ git log --oneline --fixed-strings --grep='[PATCH RESEND' | wc -l
>> 28
>> 
>> For RFC:
>> 
>> $ git log --oneline --fixed-strings --grep='[RFC PATCH' | wc -l
>> 1181
>> 
>> † 1: According to http://lore.kernel.org/git/1
> 
> I wonder what does it say for "RESEND" only?

Here are some numbers pulled from https://lore.kernel.org/linux-kernel/:

- "RFC": ~400,000
- "PATCH RFC": ~50,000
- "RFC PATCH": ~200,000
- "RESEND": ~200,000
- "PATCH RESEND": ~30,000
- "RESEND PATCH": ~30,000

Though, I'm not sure how accurate those numbers are.  Even a cursory
look at the produced search results shows inaccuracy of the search
matches.  There's probably some "fuzzy logic" at play there.
