Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DC1C20
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536694; cv=none; b=Tz+5HuubxH0pdThiRsXYWI5VYJBRBnh9RS2dQQtlanQutiItFK4rllxWUcCyS0RCFxa+jZUUJ3rOh2lDVcmrWSCnCd2/7EKuU6UPNlM1DMIRordx2qFYsSlhNu+ZdEyPnTCTg83pYBzQjtlUrNhVhD8bSY5kMNUwxllYJAmM1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536694; c=relaxed/simple;
	bh=BFzwzzs91k/ZygiyMVWD69cTIjVcCX9KjIMq26I6HbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fbn/8B83ROLfvLbTgsxpaSrUnJ/TMAwnd7iz8qu6qHoNR7Gc40digoREs2AKzq4MTy7AvyxfbYDz0dbD6MH26W8k3Zk0ZjDuJ86gb0//krHGY9laVRQEFzA6+4l6p63oi7KaACfRR64svXGEKBiUX4+gRkMYGtLJ/ck0D8PUHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xDvzZ3oD; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xDvzZ3oD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 012F91C3AA8;
	Wed, 21 Feb 2024 12:31:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BFzwzzs91k/Z
	ygiyMVWD69cTIjVcCX9KjIMq26I6HbM=; b=xDvzZ3oDFz4FoF+JZ+uSAkoh5EB8
	YVDhhcPf6f2r5YRI3tE8smSrU03IRZ2cAS3FvYLgC++D7G87Akrk84JrTelaWpt8
	ADhNeZ6rDSxoFHx16Vr3acO/hOtKVkX+U1UVaW1fxRkH+PbmcSlVK+evyOXxRj0r
	5GcQ0YjYJ5zMM5A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDF531C3AA6;
	Wed, 21 Feb 2024 12:31:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 548131C3AA5;
	Wed, 21 Feb 2024 12:31:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line
 description syntax
In-Reply-To: <67dca173-3048-430b-88a1-d3b5d853f84b@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Wed, 21 Feb 2024 08:41:48 +0100")
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
	<17b0284c379e62a756e1bba008f4671f6afc0ad9.1708468374.git.gitgitgadget@gmail.com>
	<xmqqsf1mlp6f.fsf@gitster.g>
	<67dca173-3048-430b-88a1-d3b5d853f84b@free.fr>
Date: Wed, 21 Feb 2024 09:31:30 -0800
Message-ID: <xmqqfrxlpvv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0D3F54AA-D0DF-11EE-9C19-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

>>> ---short[=3Dlength]::
>>> +--short[=3D<length>]::
>>>   	Same as `--verify` but shortens the object name to a unique
>>>   	prefix with at least `length` characters. The minimum length
>> This same comment applies throughout this patch, but in other places
>> when we use <placeholder> in the option argument description, don't
>> we use the same <placeholder> in text as well?  I am wondering if
>> the `length` (typeset in fixed-width) should become <length>.  What
>> do other recent[*] documentation pages commonly do?
>
> This is another part of the inconsistences in documentation that I'd
> like to tackle (hopefully, not in another life).
>
> Using angle brackets for placeholders everywhere they appear is a
> visual link to the preceding syntax description, but may feel a bit
> heavy on some cases. Anyway, I'm all for applying the rule everywhere,
> for the sake of consistency.

I agree that if <placeholder> is not an appropriate way to spell
them in the explanation text, we would want to change them
consistently everywhere, and until then, using the angle-bracketted
<placeholder> that is common would be better.  The text will be
modified again when we decide to switch from <placeholder> to
something else, so updating them now may be a wasted effort, but (1)
we may decide that <placeholder> is good enough after all, or (2) it
may make it easier to mechanically identify words whose mark-up
should be converted if we consistently use <placeholder> now, even
if we know it won't be the final mark-up.

So I am inclined to say that we should first do `length` -> <length>
in the body text in the short term.  But I also think we should
*not* do so as part of this patch, whose focus is how the option
enumeration header should mark up the option arguments.

> Backticks and single quotes are used indistinctively (by the way,
> asciidoctor does not process single quotes as markup) and are not used
> everywhere they should. Using backticks is also a good hint for
> translators to mean "verbatim, do not translate". Obviously, the
> placeholders ask for translation, so the backtick rule should not
> apply to them, even if another formating would be welcome :
> _<placeholder>_ for instance?

Yes.  The way AsciiDoc renders (at least HTML) an unadorned <placeholder>
is not so great.

In "git-add.html" manual page, we see these examples.  The first one
(unadorned) does not make the placeholder word stand out enough; the
second one that does `<file>` makes it stand out better, but as you
said, the `verbatim` mark-up is semantically wrong.

https://git.github.io/htmldocs/git-add.html#:~:text=3DFor%20more%20detail=
s%20about%20the%20%3Cpathspec%3E%20syntax

https://git.github.io/htmldocs/git-add.html#:~:text=3DPathspec%20is%20pas=
sed%20in%20%3Cfile%3E%20instead%20of%20commandline%20args.%20If%20%3Cfile=
%3E%20is%20exactly%20%2D%20then%20standard%20input%20is%20used.%20Pathspe=
c

The last part of the Documentation/CodingGuidelines document talks
about how to mark up placeholders but it does not go beyond saying
that they are written as <hyphen-in-between-words-in-angle-braket>.
Whatever mark-up rule we decide to use, we should document it there.

Thanks.


