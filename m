Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CF3AC34
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501322; cv=none; b=WtzCG11Sq8lG2B1LiHRQZQqujnzJzEgPMZivkYWoie1S0wjMJuSvXyUxHGgw3s1+iQr824biomTjol4O5O7ufpl33YYXvYRwM75oMVP4G1F5ZD5jok/Z/TRh4ESTDrqw92xcwIqMsMKM1dOGfXgBVTkhSR4uFF7QSY+rz0fFHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501322; c=relaxed/simple;
	bh=n4qBTKMqMhYdQsPTxKUC2qs7u4ly146QPdprQ59splY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyOC136lGZ0Z9hjNsD3an5UGeXxvDF8rJPBI+I5ALdop4EyRfF+13fNIY93o6xd+/oVi5T/QSrUqSkfv10J28/6chHath9TAY5xGIvg19Jz+Myl0VBUI9yYqTa9pPkTgmzKyqZr6yQpv3y8nzlzs7Q0ox9WuGXywLLX1sjQXXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=cN9GgDlX; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="cN9GgDlX"
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id CB5CB5FFB7;
	Wed, 21 Feb 2024 08:41:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1708501312;
	bh=n4qBTKMqMhYdQsPTxKUC2qs7u4ly146QPdprQ59splY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cN9GgDlXxgWmHJph1FK9nYOn/2daXMsEdT0HVJp+VGFAbMVnHfo1sdMdzSo5tgvDt
	 YIEyL1wwFYtmPYWLkY/FI2NigC6hciF6cabRCLI94pRL0AD/HZWfrWOvPYdSKhZk/f
	 U+/SqQ8ZJoUr9HKiwiDJI8DLYK8bukt0k5X9zKC6+5gBIVVsJbMo6Z5sfr69tn9+cQ
	 HRBA5cv60QefgbcMTmE3dgAmtfMmDoVrW9obHJsjtKDoP3Grq4aSSvkyR8COYszhv+
	 yeiUIYJGSZNvB1QK5Gw7Br2MKfimOOEG/KQGUun/VWRifR9W82RS8lNQkSkjRyZ9AZ
	 4egq7bRBHGpqw==
Message-ID: <67dca173-3048-430b-88a1-d3b5d853f84b@free.fr>
Date: Wed, 21 Feb 2024 08:41:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line description
 syntax
Content-Language: fr
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
 <17b0284c379e62a756e1bba008f4671f6afc0ad9.1708468374.git.gitgitgadget@gmail.com>
 <xmqqsf1mlp6f.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
In-Reply-To: <xmqqsf1mlp6f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/02/2024 à 23:57, Junio C Hamano a écrit :
> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>   [verse]
>> -'git rev-parse' [<options>] <args>...
>> +'git rev-parse' [<options>] <arg>...
> 
> Good.  The "or more" is signalled by the ellipsis, not "args" being
> plural.
> 
>> ---short[=length]::
>> +--short[=<length>]::
>>   	Same as `--verify` but shortens the object name to a unique
>>   	prefix with at least `length` characters. The minimum length
> 
> This same comment applies throughout this patch, but in other places
> when we use <placeholder> in the option argument description, don't
> we use the same <placeholder> in text as well?  I am wondering if
> the `length` (typeset in fixed-width) should become <length>.  What
> do other recent[*] documentation pages commonly do?

This is another part of the inconsistences in documentation that I'd 
like to tackle (hopefully, not in another life).

Using angle brackets for placeholders everywhere they appear is a visual 
link to the preceding syntax description, but may feel a bit heavy on 
some cases. Anyway, I'm all for applying the rule everywhere, for the 
sake of consistency.

Backticks and single quotes are used indistinctively (by the way, 
asciidoctor does not process single quotes as markup) and are not used 
everywhere they should. Using backticks is also a good hint for 
translators to mean "verbatim, do not translate". Obviously, the 
placeholders ask for translation, so the backtick rule should not apply 
to them, even if another formating would be welcome : _<placeholder>_ 
for instance?

> 
> 	Side note: I say "recent" because rev-parse doc is one of
> 	the oldest ones that did not get typesetting attention they
> 	deserve, compared to more recent ones that got nitpicked
> 	while they were written and updated.
> 
>> ---branches[=pattern]::
>> ---tags[=pattern]::
>> ---remotes[=pattern]::
>> +--branches[=<pattern>]::
>> +--tags[=<pattern>]::
>> +--remotes[=<pattern>]::
>>   	Show all branches, tags, or remote-tracking branches,
>>   	respectively (i.e., refs found in `refs/heads`,
>>   	`refs/tags`, or `refs/remotes`, respectively).
> 
> Ditto.  We see `pattern` that may want to become <pattern> in the
> description (after the post context of this hunk).
> 
>> ---glob=pattern::
>> +--glob=<pattern>::
>>   	Show all refs matching the shell glob pattern `pattern`. If
>>   	the pattern does not start with `refs/`, this is automatically
>>   	prepended.  If the pattern does not contain a globbing
> 
> Ditto.
> 
>> ---exclude-hidden=[fetch|receive|uploadpack]::
>> +--exclude-hidden=(fetch|receive|uploadpack)::
>>   	Do not include refs that would be hidden by `git-fetch`,
>>   	`git-receive-pack` or `git-upload-pack` by consulting the appropriate
>>   	`fetch.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs`
> 
> Good.
> 
>> ---since=datestring::
>> ---after=datestring::
>> +--since=<datestring>::
>> +--after=<datestring>::
>>   	Parse the date string, and output the corresponding
>>   	--max-age= parameter for 'git rev-list'.
> 
> Good, modulo possibly "date string" -> "<datestring>".
> 
>> ---until=datestring::
>> ---before=datestring::
>> +--until=<datestring>::
>> +--before=<datestring>::
>>   	Parse the date string, and output the corresponding
>>   	--min-age= parameter for 'git rev-list'.
> 
> Ditto.
> 
>> -<args>...::
>> +<arg>...::
>>   	Flags and parameters to be parsed.
> 
> Good.

