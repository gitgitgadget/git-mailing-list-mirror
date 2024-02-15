Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5350B677
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978169; cv=none; b=N5UjZnAsyXBrhsFTQwMZzlwiVUDhPRk2NPDUQ6MvN0knoCdCKhWgdeIunnNYDKGQi8ifPx/JbPFL4HokMHxpKjbfS+VJ0HNNTmSMa43xcOV5tG/fr5UJDqFlBwLJxmwLVH4OVFTbtQWaRbrawbXMb5Hz9LofMzqB+R9JI/XeWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978169; c=relaxed/simple;
	bh=VnWiUzC5uhjsMpF+5HraXHNEfPzFxNyrZHxGK1VDLzU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FP31+xEpeQtN7YxDns5gHEoevISq74Z2nvl0/8+lvsNtmaclUGxBJXugyH/rEbkWzIvB2NmB0SaMoyOrcaEY4wxCPbrjsGCDRWgLzYOXcZsqpLEN5EWT2qiQh86ry0Aje9FzAC1S1gh/LAmqabiLpfBM409bG6EK2yiwVPeo/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRhKB0TM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRhKB0TM"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c48fc56752so21970039f.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 22:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707978167; x=1708582967; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdKangsEw1VVOE9pJnhg2gtpftm+0dqsELSeq53apcM=;
        b=RRhKB0TM3PEJOLWSVkyK1glr55H00pkS1NJ50K2+LGvTKWWBpVKHw294tzg7h6ipPj
         J7icMupMVj8a/YmrStQyuwNBenf2mEI5K9N/7N08Gt5SSy2zLOyGolBS6RbfS9Kvg5rB
         DoOMuRUZEhQLyLXq99L1vSx2TLdjcYX5BZDEhPfwhMyyn2uaY4CS8rMFRa5MVoCE4CEm
         szXy40NNGZCLX6eZgMfMhtk+PpN+Yea1ByaHWJX9a2kTZnbM+1MD0OIqOYwO+RaDnMPQ
         kUyZoDs7wPNby18UF9YEjzuahWgqpun6YBUj93GABR4By4OFr5ayiW5q0jok8cLq6ejP
         IzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707978167; x=1708582967;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdKangsEw1VVOE9pJnhg2gtpftm+0dqsELSeq53apcM=;
        b=mTVpV+VlAhm7OFhJzCT5c2IMEQ3pQNOp6pyBT2asaBMFw5dqKVWhLTZ+1SKo6iexFK
         11yEttcRb712KK6ign3Gw6qvM59qxKqgHV1evkE4JaR1uULiAUimMvNz9ibMw3FwhvYI
         4X4Q7GNtPjH1jNHmhIUZWQWoB2xBwqB7sk2LwOvRcxR83EY1+STT58AR5PY/LXhWbDm3
         a07FihXcnkfGOwV4anEZmHfejA2t1IaOR2VrkoOL4Uq+JUzuagQqGxwRx1JcztM1+Egd
         5CZHk/9oOPLTWpbqJUEhv/SJzZkxKnBn7w3192W8eNC6Gb8+iVHR1t2mKqAIhQUBtD3K
         sl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTZfZ3aUqyn80NXZG26+X2mGQcM33/fnWK9JFd6w2BP1qH6kRdC/Mz5WQV1HqVJmdLg6o9HoVyg4J4EB/U195BVlQ6
X-Gm-Message-State: AOJu0Yw/QEmdDOjP5LPlbc/6v1UJmvWd5j5vmpBe5SIH2TQ3sgeNNjtd
	CrHmq2iH5rVOSvdG04YaVw0vBrlKX0x3PRuV2Fj50G6mweFUwUWH
X-Google-Smtp-Source: AGHT+IEjVAwCle0vFuHZ5d1aU681pM8iQ3UGkATE6+M60p0MC8MIzHb9H5SYdotrxdLVeQthV1tfdA==
X-Received: by 2002:a5e:8f09:0:b0:7c4:6158:f223 with SMTP id c9-20020a5e8f09000000b007c46158f223mr1099146iok.3.1707978166704;
        Wed, 14 Feb 2024 22:22:46 -0800 (PST)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id n38-20020a056602342600b007c41e541b8fsm135722ioz.32.2024.02.14.22.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 22:22:45 -0800 (PST)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple
 kinds of oids
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
	<20231002024034.2611-2-ebiederm@gmail.com>
	<owlya5o4dbj1.fsf@fine.c.googlers.com>
Date: Thu, 15 Feb 2024 00:22:44 -0600
In-Reply-To: <owlya5o4dbj1.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 13 Feb 2024 00:16:34 -0800")
Message-ID: <8734tumekr.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Arver <linusa@google.com> writes:

> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>
>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> While looking at how to handle input of both SHA-1 and SHA-256 oids in
>> get_oid_with_context, I realized that the oid_array in
>> repo_for_each_abbrev might have more than one kind of oid stored in it
>> simultaneously.
>>
>> Update to oid_array_append to ensure that oids added to an oid array
>
> s/Update to/Update
>
>> always have an algorithm set.
>>
>> Update void_hashcmp to first verify two oids use the same hash algorithm
>> before comparing them to each other.
>>
>> With that oid-array should be safe to use with different kinds of
>
> s/oid-array/oid_array
>
>> oids simultaneously.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  oid-array.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/oid-array.c b/oid-array.c
>> index 8e4717746c31..1f36651754ed 100644
>> --- a/oid-array.c
>> +++ b/oid-array.c
>> @@ -6,12 +6,20 @@ void oid_array_append(struct oid_array *array, const struct object_id *oid)
>>  {
>>  	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
>>  	oidcpy(&array->oid[array->nr++], oid);
>> +	if (!oid->algo)
>> +		oid_set_algo(&array->oid[array->nr - 1], the_hash_algo);
>
> How come we can't set oid->algo _before_ we call oidcpy()? It seems odd
> that we do the copy first and then modify what we just copied after the
> fact, instead of making sure that the thing we want to copy is correct
> before doing the copy.
>
> But also, if we are going to make the oid object "correct" before
> invoking oidcpy(), we might as well do it when the oid is first
> created/used (in the caller(s) of this function). I don't demand that
> you find/demonstrate where all these places are in this series (maybe
> that's a hairy problem to tackle?), but it seems cleaner in principle to
> fix the creation of oid objects instead of having to make oid users
> clean up their act like this after using them.

There is a hairy problem here.

I believe for reasons of simplicity when the algo field was added to
struct object_id it was allowed to be zero for users that don't
particularly care about the hash algorithm, and are happy to use the git
default hash algorithm.

Me experience working on this set of change set showed that there
are oids without their algo set in all kinds of places in the tree.

I could not think of any sure way to go through the entire tree
and find those users, so I just made certain that oid array handled
that case.

I need algo to be set properly in the oids in the oid array so I
could extend oid_array to hold multiple kinds of oids at the same
time.  To allow multiple kinds of oids at the same time void_hashcmp
needs a simple and reliable way to tell what the algorithm is of
any given oid.

>
>>  	array->sorted = 0;
>>  }
>>  
>> -static int void_hashcmp(const void *a, const void *b)
>> +static int void_hashcmp(const void *va, const void *vb)
>>  {
>> -	return oidcmp(a, b);
>> +	const struct object_id *a = va, *b = vb;
>> +	int ret;
>> +	if (a->algo == b->algo)
>> +		ret = oidcmp(a, b);
>
> This makes sense (per the commit message description) ...
>
>> +	else
>> +		ret = a->algo > b->algo ? 1 : -1;
>
> ... but this seems to go against it? I thought you wanted to only ever
> compare hashes if they were of the same algo? It would be good to add a
> comment explaining why this is OK (we are no longer doing a byte-by-byte
> comparison of these oids any more here like we do for oidcmp() above
> which boils down to calling memcmp()).

So the goal of this change is for oid_array to be able to hold hashes
from multiple algorithms at the same time.

A key part of oid_array is oid_array_sort that allows functions such
as oid_array_lookup and oid_array_for_each_unique.

To that end there needs to be a total ordering of oids.

The function oidcmp is only defined when two oids are of the same
algorithm, it does not even test to detect the case of comparing
mismatched algorithms.

Therefore to get a total ordering of oids.  I must use oidcmp
when the algorithm is the same (the common case) or simply order
the oids by algorithm when the algorithms are different.



All of this is relevant to get_oid_with_context as get_oid_with_context
and it's helper functions contain the logic that determines what
we do when a hex string that is ambiguous is specified.

In the ambiguous case all of the possible candidates are placed in
an oid_array, sorted and then displayed.


With a repository that can knows both the sha1 and the sha256 oid
of it's objects it is possible for a short oid to match both
some sha1 oids and some sha256 oids.

>> +	return ret;
>
> Also, in terms of style I think the "early return for errors" style
> would be simpler to read. I.e.
>
>     if (a->algo > b->algo)
>         return 1;
>
>     if (a->algo < b->algo)
>         return -1;
>
>     return oidcmd(a, b);
>

I can see doing:
	if (a->algo == b->algo)
        	return oidcmp(a,b);

	if (a->algo > b->algo)
        	return 1;
        else
        	return -1;

Or even:
	if (a->algo == b->algo)
        	return oidcmp(a,b);

	return a->algo - b->algo;

Although I suspect using subtraction is a bit too clever.

Comparing for less than, and greater than, and then assuming
the values are equal hides what is important before calling
oidcmp which is that the algo values are equal.


>>  }
>>  
>>  void oid_array_sort(struct oid_array *array)
>> -- 
>> 2.41.0

Eric
