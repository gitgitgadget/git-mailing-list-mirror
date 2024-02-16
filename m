Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5EA21
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042621; cv=none; b=lO8wx8qCV+LMj5saq1B916QT96nzbTqiC0FnRAGcofSdQHLhYQwiUnIyJBNjXAbbXIX1zaanH351DrPUaAOe/TEEGEEuUpMSSWPlwzWYssdwMdGG1gLr1r/Y0ZgTTOZ8oL2lzaUONaWLETL1roIxrGzy3h4Iev1cwNSHaTdU7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042621; c=relaxed/simple;
	bh=vXYJydJzqiSQ72MYIwQ6JnBqIAVjz6GVDQFRJvDumsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvuo4kaDP4dY8UfSeXwB7OGEpWcd7pahaVb2xDzdoACscrLphiqoEAtrXHvvDnqD4j5gtkSvFFLw0VF3H3GXNVbbTM2Ylc4DPMT7DB3uN5JhsM1UYDOw7VzEYu3mfzYskWVJd7M12+eBGoaZqsldfuRhox+Xl7gDEwOMSQCt3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GcP6SQid; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcP6SQid"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso31466877b3.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 16:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708042619; x=1708647419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZqeU2VMcvUFbCqbusCS1783aHn0mdFDfokFl60tMeM=;
        b=GcP6SQid6avJtpuHOVDCuH9QgdeiyzZkSnEF6B9iG3vXolk3czE8gh8FPXdes+cu/X
         rTFh1f0X8un+Hz6xkiyHNKXmAOZ+nwKkLznkhQ5pwAoNFBCJ/j9hx8G+xrm1cnoaL0V+
         gsBs+O/3aVpwhmu+vk38rg20L/b0zJLPTdM10Azz0bMIkze24prKVMZPFlXSRQRG9UmE
         IeJmJpslbEuIrIuw899vs4oD6XNx9sR0WsYJIW31bYdJeDaQuR3qgh5a1TAoWpXu9ADy
         JrXOovXUUdAhVz3ry4UgpKcbJsvTbepMMUQlTv+kQ8kdJ/zB9WDVfLjWVP5vL6J4aDja
         A7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042619; x=1708647419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZqeU2VMcvUFbCqbusCS1783aHn0mdFDfokFl60tMeM=;
        b=rkyCZqEFNqXdQY2j6GZQRxd/9tKuDxMsFDs8IDYno2ZWsWXAACcRoglzMB1i0etJ8T
         3mnf2voKHfPxmAgXtZ8C+O8EzanP294gFrYrnB86zjr6E0vqg5LPCdQwLNZDN1LsmzSa
         bFQ0hOIRxsxEeyIjS53Vl2cYycnmBeUu1Tq9c2Pk4OukzsX9w8NrLltwJK2rWCS0fDFf
         jA2m1h/caSIQVDmp5jJuWunxWBbLpSp2uCpdYk4GheJ/p7vog+dBVHkekRddeUF71zip
         lSy7P7UP/G9E3e+98I8YyWTV0lpgOkQl8PfvQMSSDnF7JQ+f/hHs/arRNdl1nbKjYAN+
         1X3A==
X-Forwarded-Encrypted: i=1; AJvYcCX6kAGR/JeQUz2yYq+2MKuQ8kNPg4ddFSl/axWHkmejQ0CQEYh1VB7F2LTz1AbFOqSB6o5L8jdvtrmxH6z2afAI3xk1
X-Gm-Message-State: AOJu0YyDQCW+eMeHV/4e7Y6iER1JUOvrd9+auphbazGed27ouu0SW3oQ
	RRxj24M1Wj2CwxyuqL/B+qYRsZ3WEOBUXrYa1wLjfnVF5YkFi+oydyge+PKh6Izmant9Ix0ch5P
	r0A==
X-Google-Smtp-Source: AGHT+IH5/QOz3XuLjscDmoe8WBNBP6HYlf0rTlAEc8cw8OvQBp/Z41GNvu5UtR+1uUKgIh3D+oi0LNojd4A=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1104:b0:dbd:b4e8:1565 with SMTP id
 o4-20020a056902110400b00dbdb4e81565mr947653ybu.4.1708042619175; Thu, 15 Feb
 2024 16:16:59 -0800 (PST)
Date: Thu, 15 Feb 2024 16:16:57 -0800
In-Reply-To: <8734tumekr.fsf@gmail.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-2-ebiederm@gmail.com> <owlya5o4dbj1.fsf@fine.c.googlers.com>
 <8734tumekr.fsf@gmail.froward.int.ebiederm.org>
Message-ID: <owly1q9d9sau.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple
 kinds of oids
From: Linus Arver <linusa@google.com>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>>
>>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>>>
>>> While looking at how to handle input of both SHA-1 and SHA-256 oids in
>>> get_oid_with_context, I realized that the oid_array in
>>> repo_for_each_abbrev might have more than one kind of oid stored in it
>>> simultaneously.
>>>
>>> Update to oid_array_append to ensure that oids added to an oid array
>>
>> s/Update to/Update
>>
>>> always have an algorithm set.
>>>
>>> Update void_hashcmp to first verify two oids use the same hash algorithm
>>> before comparing them to each other.
>>>
>>> With that oid-array should be safe to use with different kinds of
>>
>> s/oid-array/oid_array
>>
>>> oids simultaneously.
>>>
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>  oid-array.c | 12 ++++++++++--
>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/oid-array.c b/oid-array.c
>>> index 8e4717746c31..1f36651754ed 100644
>>> --- a/oid-array.c
>>> +++ b/oid-array.c
>>> @@ -6,12 +6,20 @@ void oid_array_append(struct oid_array *array, const struct object_id *oid)
>>>  {
>>>  	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
>>>  	oidcpy(&array->oid[array->nr++], oid);
>>> +	if (!oid->algo)
>>> +		oid_set_algo(&array->oid[array->nr - 1], the_hash_algo);
>>
>> How come we can't set oid->algo _before_ we call oidcpy()? It seems odd
>> that we do the copy first and then modify what we just copied after the
>> fact, instead of making sure that the thing we want to copy is correct
>> before doing the copy.
>>
>> But also, if we are going to make the oid object "correct" before
>> invoking oidcpy(), we might as well do it when the oid is first
>> created/used (in the caller(s) of this function). I don't demand that
>> you find/demonstrate where all these places are in this series (maybe
>> that's a hairy problem to tackle?), but it seems cleaner in principle to
>> fix the creation of oid objects instead of having to make oid users
>> clean up their act like this after using them.
>
> There is a hairy problem here.
>
> I believe for reasons of simplicity when the algo field was added to
> struct object_id it was allowed to be zero for users that don't
> particularly care about the hash algorithm, and are happy to use the git
> default hash algorithm.
>
> Me experience working on this set of change set showed that there
> are oids without their algo set in all kinds of places in the tree.

Ah, I see. Thanks for the clarification.

> I could not think of any sure way to go through the entire tree
> and find those users, so I just made certain that oid array handled
> that case.
>
> I need algo to be set properly in the oids in the oid array so I
> could extend oid_array to hold multiple kinds of oids at the same
> time.  To allow multiple kinds of oids at the same time void_hashcmp
> needs a simple and reliable way to tell what the algorithm is of
> any given oid.

Makes sense.

>>
>>>  	array->sorted = 0;
>>>  }
>>>  
>>> -static int void_hashcmp(const void *a, const void *b)
>>> +static int void_hashcmp(const void *va, const void *vb)
>>>  {
>>> -	return oidcmp(a, b);
>>> +	const struct object_id *a = va, *b = vb;
>>> +	int ret;
>>> +	if (a->algo == b->algo)
>>> +		ret = oidcmp(a, b);
>>
>> This makes sense (per the commit message description) ...
>>
>>> +	else
>>> +		ret = a->algo > b->algo ? 1 : -1;
>>
>> ... but this seems to go against it? I thought you wanted to only ever
>> compare hashes if they were of the same algo? It would be good to add a
>> comment explaining why this is OK (we are no longer doing a byte-by-byte
>> comparison of these oids any more here like we do for oidcmp() above
>> which boils down to calling memcmp()).
>
> So the goal of this change is for oid_array to be able to hold hashes
> from multiple algorithms at the same time.
>
> A key part of oid_array is oid_array_sort that allows functions such
> as oid_array_lookup and oid_array_for_each_unique.
>
> To that end there needs to be a total ordering of oids.
>
> The function oidcmp is only defined when two oids are of the same
> algorithm, it does not even test to detect the case of comparing
> mismatched algorithms.
>
> Therefore to get a total ordering of oids.  I must use oidcmp
> when the algorithm is the same (the common case) or simply order
> the oids by algorithm when the algorithms are different.
>
>
>
> All of this is relevant to get_oid_with_context as get_oid_with_context
> and it's helper functions contain the logic that determines what
> we do when a hex string that is ambiguous is specified.
>
> In the ambiguous case all of the possible candidates are placed in
> an oid_array, sorted and then displayed.
>
>
> With a repository that can knows both the sha1 and the sha256 oid
> of it's objects it is possible for a short oid to match both
> some sha1 oids and some sha256 oids.

Thanks for the additional clarification. I think a lot of this could
have been added as comments or perhaps in the commit message. The "short
id can match both sha1 or sha256" is a very real scenario we need to
consider in the sha1+sha256 world, indeed.

>>> +	return ret;
>>
>> Also, in terms of style I think the "early return for errors" style
>> would be simpler to read. I.e.
>>
>>     if (a->algo > b->algo)
>>         return 1;
>>
>>     if (a->algo < b->algo)
>>         return -1;
>>
>>     return oidcmd(a, b);
>>
>
> I can see doing:
> 	if (a->algo == b->algo)
>         	return oidcmp(a,b);
>
> 	if (a->algo > b->algo)
>         	return 1;
>         else
>         	return -1;
>
> Or even:
> 	if (a->algo == b->algo)
>         	return oidcmp(a,b);
>
> 	return a->algo - b->algo;
>
> Although I suspect using subtraction is a bit too clever.

Agreed.

> Comparing for less than, and greater than, and then assuming
> the values are equal hides what is important before calling
> oidcmp which is that the algo values are equal.

I would still prefer the "early return for errors" style even in this
case. This is because I much prefer to have the question "how can things
go wrong?" answered first, and dealt with, such that as I read
top-to-bottom I am left with less things I have to consider to
understand the "happy path". WRT emphasizing the "algos equal each
other" concern, a simple comment like

     /* Only compare equal algorithms. */
     return oidcmp(a, b);

seems sufficient.

But, of course it is possible (perhaps even likely) that my preferred
style is in the minority. Up to you. Thanks.
