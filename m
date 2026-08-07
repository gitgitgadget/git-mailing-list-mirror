Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC23BA22E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091194; cv=none; b=tcpg4EE5CfJpUW7tZndEr04X+KWBcKyZG7gehkMrhv9GYhzqZL8JocH1glAhzewOs4iqtOk2eCdfRAZARcWde+ij0E8Nsno/+023td9cU1JBLPydHK/AENUUTurHX8HX+IyAonb9SMgOs1MYqV3+tm/aixoActGd0YDrlNZbdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091194; c=relaxed/simple;
	bh=J3iLzH9vTc82R2d6YLU6ZD465CrnstpJQjiiqNT3++4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2u4nbY4d6I5FZ3owGK1pStwmihRF/NWerhJCp0PHbN608WTbjGgFtyfd3B76RBLdZYfXgA1nJoSEbDT3U69jw4GQQOc4z7rNRW5D6iERNw7feh0ud0hYscxMSiKP54wQzoJT0KoOl+rtUa/QPyppzIKKN6e24ml85+rfi3db5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=GwRUhpnd; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=REYl3W6T; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="GwRUhpnd";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="REYl3W6T"
DKIM-Signature: a=rsa-sha256; b=GwRUhpnd6P96T/sMwcvY5GYvH8cnkvyBXGdOUeLVmPxGlsIGnH3lVEsdwO93nYRe/otBGoEJWJ3dAiT+L5naBBrFJKpEvKBQrq/ehneoGuL9GWdHUHMJs13jCNslTOoobRdGeVJm7nVGjIiHJTMjHehIjTuplX5GoBZR/O0Pz3f4oWAccfRSN1V5uAlDnJNAl+V4yCLeGcxp2xI04MfkrKgB8sX61AfHkxJravW03G93YuXIyV0pE2P7+dALSy1FXjjwJJY1Xf9OkRlBB3jn+sdcAZCyyZJwgBZ40gMOdKJcOW/dhDjtd1I0sCtIBwLSS2ee/GmKLAi0gBaTDw19UQ==; s=purelymail2; d=malon.dev; v=1; bh=J3iLzH9vTc82R2d6YLU6ZD465CrnstpJQjiiqNT3++4=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=REYl3W6TyUcqp8OfrRI1vlDR55Fbjb5j201RZEDL6DFvDOtZy0bFuc7mUUqbeUaeUpgwtcJycwVCe5CZbt2qVcb1shYpcqAOtSBUlLcR6d40n0B0KQfA1iT4TOcHFyRJAJpMkSRY8NdYXhikOhebXnrhEidMAE9PdWmHRpCcJznlRYRP0+EWnKVOBGAOB7qFL1t2ezykQZoJrfBdwEjoYzjyGQg6zmdVWDAg4JBDFn4/mJPRcWJgU6mLxTA6zU/XMNaoUGSxSp81F3n+3+i0yBv4xl6NC/v7HkpH946M7HeacFp8ikT5fcIwhspTfTCli1vXStbpfw8lowJWymJgzQ==; s=purelymail2; d=purelymail.com; v=1; bh=J3iLzH9vTc82R2d6YLU6ZD465CrnstpJQjiiqNT3++4=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 329137153;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 07 Aug 2026 08:26:23 +0000 (UTC)
Message-ID: <dc22396e-21b8-442f-a93d-f49e7af5e99a@malon.dev>
Date: Fri, 7 Aug 2026 16:26:15 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] environment: reorder variables in repo_config_values
 structure
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260805115342.3939931-4-cat@malon.dev> <xmqqo6fgnssx.fsf@gitster.g>
 <dbcbb042-5c50-4569-9b18-3edcc7b1ef4b@malon.dev> <xmqq5x1nmc90.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqq5x1nmc90.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 00:42, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> On 8/6/26 05:47, Junio C Hamano wrote:
>>> Tian Yuchen <cat@malon.dev> writes:
>>>
>>>> Reorder the fields in struct repo_config_values and its initialization
>>>> function to follow the order of configuration sections.
>>>>
>>>> Keeping the declaration and initialization order aligned makes the
>>>> structure easier to review and maintain.
>>>
>>> Really?
>>>
>>> Do you have some automated tool to make sure these initialization
>>> assignments in the environment.c file and declaration in the
>>> environment.h file match the order in Documentation/config/*.adoc or
>>> something else?  Have you designated some list as the authoritative
>>> source of truth to check these against?  Without such a list to
>>> check the code against and a mechanism to enforce the ordering, I
>>> find it hard to agree with such a claim that this makes it easier to
>>> maintain.
>>
>> I see.
>>
>>>
>>> It is typical to list the structure members in the order of stricter
>>> to looser alignment requirement of their types.  I do not know how
>>> strictly it is followed for "struct repo_config_values", but by
>>> spreading pointer valued members more widely with smaller enums in
>>> between, the change certainly is making the overall structure size
>>> larger by requiring more padding between the members with different
>>> alignment requirements.  Not that we would have 100s of instances of
>>> these structures.
>>>
>>
>> Oh, I overlooked the size issue. Thanks for pointing out.
> 
> I didn't mean to "point out" any size issue.  As I said, it is not
> like we have hundreds of these, so padding bloat here and there
> would not matter and if we get a readability boost by reordering
> into a sensible order, that by itself could be a win.
> 

Okay.

As you said before, the boost on readability seems to be limited. 
Reordering by config section is not a strong maintenance rule without an 
authoritative source. So let's don't reorder them anyways.

Thanks, yuchen
