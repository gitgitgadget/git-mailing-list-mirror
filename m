Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36652158871
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844158; cv=none; b=b5Zuatli9L5FnqkkXBfXM3VYfHiSUewWOsbgNt0p2GdLTeK1Uqpvcypgfb1Q0kZnV/6AnhaogFVKSJ6XqcKua4qRwe9wTBBZQxRmjw5nUq6WCZJhjOJCrM+8HxFtB49/SXK+5rw8LkE43oY3CpuTPz7WArxw9A/u7hgDP5HfL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844158; c=relaxed/simple;
	bh=ArorJJ7PDtJMcmZC0P3eHc0xpQcPEWU3IKgl2KaIhTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipHiE+nSzfdcO8Dy12cPaSmKlnbs7tVXM02DHIfyY27gn9lZjwoL5hBazS2WjNp6x6Zo5A9VleALdkX3U2seMaV4a8v91kyJccaz5a/UQ2WI1tBg1ro4/C74vv3yXI4Bf5wyQu5CmAZ5UdkVw4x0isP25HkWq8slILOfh4yRy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kpjdh/NY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kpjdh/NY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2366A2A162;
	Wed, 24 Jul 2024 14:02:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ArorJJ7PDtJMcmZC0P3eHc0xpQcPEWU3IKgl2K
	aIhTo=; b=kpjdh/NYJPUugGn3odnUJF+4bzKbPf9nZeXA7k4k3NyGIiaog6XqPV
	lRtiqeff91cTVvbh1yZ6xCgF/9xnjS7XQCRFOXsHtoqIB/AzjdkPaeeJbr4Yzmym
	89MpjZae7QYARjgLI/uEPJR+U9tpJCLqkBvKTS5VjDhDpEF3d4Oe0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19EB62A161;
	Wed, 24 Jul 2024 14:02:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84D8F2A160;
	Wed, 24 Jul 2024 14:02:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: document difference between release
 and free
In-Reply-To: <1841a256-5c01-4892-99c7-ad7df14e6e0e@gmail.com> (Phillip Wood's
	message of "Wed, 24 Jul 2024 15:30:07 +0100")
References: <cover.1721818488.git.ps@pks.im>
	<5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
	<CAOLa=ZScBn+sMB7BWMpsS=Ld0sUW14Li5JVuKPGKtY91hVo4jA@mail.gmail.com>
	<ZqD9keTtimiqJnJP@tanuki>
	<1841a256-5c01-4892-99c7-ad7df14e6e0e@gmail.com>
Date: Wed, 24 Jul 2024 11:02:34 -0700
Message-ID: <xmqqed7iu0qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E803B2D6-49E6-11EF-B5E7-BAC1940A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> I noticed there is also `clear()` used in some places. Should we also
>>> mention that we don't recommend using `clear()` WRT freeing memory?
>> In any case I think we should decide on eithe using `clear()` or
>> using
>> `release()` for consistency's sake. Which of both  we use I don't quite
>> care, but the following very shoddy analysis clearly favors `release()`:
>>      $ git grep '_clear(' | wc -l
>>      844
>>      $ git grep '_release(' | wc -l
>>      2126
>
> I think a fairer comparison would be to look at function declarations,
> not all the call sites.
>
> $ { git grep 'void [a-z_]*_release(' '*.h'
>     git grep 'static void [a-z_]*_release(' '*.c'
>   } | wc -l
> 47
> $ { git grep 'void [a-z_]*_clear(' '*.h'
>     git grep 'static void [a-z_]*_clear(' '*.c'
>   } | wc -l
> 58
>
> So we have more _clear() functions than _release() functions. I think
> there may sometimes be a semantic difference between _clear() and
> _release() as well where some _clear() functions zero out the struct
> after freeing the members.
>
> Thanks for working on this it will be a useful addition to our coding
> guidelines

Thanks for doing a more thorough study of the current codebase.  I
tend to agree that the number of actual _clear() functions matter a
lot more than how many callsites call _clear(), and it would make
sense to standardise on it.  If everything else being equal, it does
not matter which one we pick, but it rarely happens that everything
else is equal.

 - "release" is a bit more cumbersome to type and read than "clear".

 - "clear" at least to me says more about the state of the thing
   after it got cleared (e.g., I would expect it would be filled
   with NUL bytes)

 - "release" places a lot more stress on what happens to the things
   that were contained before the release takes place.

For example, upon either "clear" or "release", I would expect
everything pointed by elements in an array member of the struct, and
the array pointed at by the member, are free'd when we are
"clearing/releasing" a strvec.  But I may not care what is left in
it after "release".  It can be left to hold all the bytes the struct
had before "release" got called, as anybody who called the function
are not supposed to look at the struct again anyway.  But we may
choose not to have such a variant and always clear the struct after
releasing resources it held, just for good hygiene.

So in short, I would consider that "clear = release + init".  If we
want to have both "clear" and "release" and have them distinct
meaning, that is fine.  If we want to simplify and do without "just
release and leave them dirty" variant, then we need only one name
for it, and I do not mind if we called it "release", even though
I would think "clear" is a better name for the action that behaves
as if "init" was done at the end to make it reusable.

Thanks.
