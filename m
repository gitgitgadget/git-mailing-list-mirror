Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6217BD6
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797000; cv=none; b=lA9C9dBH4XWoIiMTqigHbtDOTaTmTVHle669M19l3OvboKBcMVfUorrfROGXMDu7SLefMSE6vtY+NHbxU07d8jdt0SlRyo+7r/493nwWNz1cRTmgY+jka8pgmli6o1YDtiyhzMiEk1tz3DhB4Inm+Rr2Qm9QARpLsEQKcw66KDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797000; c=relaxed/simple;
	bh=Fud0qXwODrtkkS+5U+D6fIlYlwixq96/1Kh4j1HJoaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hDNDFVJKTM78OxgcIvwhhsO6o1slCdwvlwBFqzCgfY8zxXvEe8Y284bf36CYAaQxbxkM6ZZO1lcrnG0BqmTs3Q6dq4GRgdqbwuiIP3KBrcNuBPHLxZEIuv3xO9Jido2zzeko+Tw5FgQkI44K/1TSDHDoyw7RlPahDBFMvjz+pMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rbVBT3NG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rbVBT3NG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BFF91F7D8;
	Fri, 12 Jul 2024 11:09:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Fud0qXwODrtk
	kS+5U+D6fIlYlwixq96/1Kh4j1HJoaI=; b=rbVBT3NGo4ijAxCToE1wjAG1cmYF
	1ryArQKUwjg8lwsm9eFw7XEnU2l4KuznH8jg/dxMFvap0PSCaGqNWBsz4GhqdN47
	zFVqTttYF0/PILr/f/hfXY6md3dPKxQ2HDPvBoNpUh4tPGiDLP2eKDBsmzSHgT5y
	3PUK5FzAcyxQGZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 616EA1F7D7;
	Fri, 12 Jul 2024 11:09:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B801E1F7D6;
	Fri, 12 Jul 2024 11:09:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com
Subject: Re: [PATCH v2 5/8] clang-format: avoid braces on simple
 single-statement bodies
In-Reply-To: <CAOLa=ZSJ-PQ+8rsURP16QQ_K8rR8xrhFO8tnAPSZD88COrzj1w@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 12 Jul 2024 03:48:58 -0500")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240711083043.1732288-1-karthik.188@gmail.com>
	<20240711083043.1732288-6-karthik.188@gmail.com>
	<xmqqcynjswz7.fsf@gitster.g>
	<CAOLa=ZSJ-PQ+8rsURP16QQ_K8rR8xrhFO8tnAPSZD88COrzj1w@mail.gmail.com>
Date: Fri, 12 Jul 2024 08:09:55 -0700
Message-ID: <xmqq7cdqpry4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CCBC5B5C-4060-11EF-88D3-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>>     Setting this option to true could lead to incorrect code formatti=
ng
>>>     due to clang-format=E2=80=99s lack of complete semantic informati=
on. As
>>>     such, extra care should be taken to review code changes made by
>>>     this option.
>>>
>>> The latter seems to be of concern. But since we only use clang-format=
 to
>>> verify the format and not to apply formatting, we should be okay here=
.
>>
>> Hmph.  Could you tell me where I can read more about "we tell
>> clang-format only to verify but not to apply"?  If that is truely
>> the case, perhaps I shouldn't be worried to much, but it is not
>> clear to me how we enforce that this is to be used only for
>> verification with non-zero false positive, and never for
>> reformatting before submission.
>>
>
> I was referring to the fact that, we expose '.clang-format' via 'make
> style' which only prints the diff to the STDOUT. The user has to still
> manually make these changes.
>
> However users could be using tools to auto-format on save and this coul=
d
> be an issue.

Yes.

Of course if we really wanted to avoid end-user confusion and still
want to have this in CI (if only to see how well the rule fares, and
what the actual false-positive rate is), we _could_ run CI's job
with custom .clang-format file that is not visible to end-users in
their normal checkout, or something silly like that.  If we are
going to use it, then we should use it everywhere, making sure
everybody is careful.  If the cost of forcing everybody to be
careful is too high, we may want to retract it, but we won't know
until we try.

Thanks.
