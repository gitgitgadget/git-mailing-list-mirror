Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6116EB7B
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666397; cv=none; b=EBHE4FNC18eVd9cR5mvLjPlJqOHpYeU/tk4sZLGEQKpIIjLcUjps/QTJNfWROtjS4ZPiXDMxeOP3t2t21u0mxI1RJLsQA6p6lrcqjhFofbkVblONzG5dr7ju9yZMHfcPHKGCCQYx4X3Uz91fu14D8Q/zbZzrIqdREpM5d1/6VYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666397; c=relaxed/simple;
	bh=Aqg9A2qvoJ9o7evgLxcHGHEtnoxD00WYC3m6wELI3cE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HElJt8mwRWmdStL7erk3fWAH7qoNdumtQ8iZCQ+7YB2FfJpuIpVkdk2g8cvy2oR16WfeANk3FjDfjnlJfgAjODExGm2aVTHOEzWz5j18THoXg8JVS3d9ooe6BH/vsAew6h6dmHBaHKBuWcETkwmLcNrMzKy/bZ0fic6xjjyHDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LSnpzxsW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LSnpzxsW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F931FC81;
	Mon, 22 Jul 2024 12:39:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Aqg9A2qvoJ9o
	7evgLxcHGHEtnoxD00WYC3m6wELI3cE=; b=LSnpzxsWTDAuCI5F2CWrODa1B6FF
	3gMKZJ07COR6IwITFTfQQO8V98R514g32OXfs8lsAXfjO7mHpbr+ZeasSUaJdwUd
	+Pe38NqBHsp1yHYWqydPuu1/Ys9H4pD4F8NG/1DGesvqFXI5kR3MeXRInc7eZeZ/
	Y+z97of+cD2pRaQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A8E81FC80;
	Mon, 22 Jul 2024 12:39:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A053F1FC7F;
	Mon, 22 Jul 2024 12:39:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
In-Reply-To: <8404759.T7Z3S40VBb@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Sun, 21 Jul 2024 15:08:46 +0200")
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
	<xmqq8qxvhcy5.fsf@gitster.g> <8404759.T7Z3S40VBb@cayenne>
Date: Mon, 22 Jul 2024 09:39:47 -0700
Message-ID: <xmqqplr5e5yk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 02B0C776-4849-11EF-A3F5-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Sorry for not being clear. Indeed I was wrong, Asciidoc.py also has thi=
s role=20
> management  behavior for any other inline markup (++, _, *, ^,  ~) exce=
pt for=20
> back-quoted text.
> =20
>> How about phrasing it more like so?
>>=20
>>     Writing a string inside [square brackets], immediately followed
>>     by a string inside `a pair of back quotes`, causes asciidoctor
>>     to eliminate the string inside [square brackets], because it is
>>     a syntax to trigger a "generalized role" feature, which we do
>>     not care about in the context of the synopsis section here.
>>=20
>>     Work it around by inserting an otherwise no-op {empty} string to
>>     forbid asciidoctor from triggering that feature here.  AsciiDoc
>>     is not affected negatively by this additional empty string.
>>=20
>
> OK, but let's get rid of the "generalized role" stuff, then.=20

I agree it is not relevant what the feature is called, as that is
something we did not want to trigger and take advantage of.

It still is necessary to mention the fact that [strings] are eaten
by us unknowingly triggering the feature. =20

> While doing the styling of synopsis, I tried to be smarter than that. T=
here=20
> are basically 3 semantic entities in the grammar:
>
>  * the _<placeholders>_ in italic
>  * the `keywords`, in monospace
>  * the grammar signs: [, ], |, ..., (, ), etc. These signs are not type=
set.
>
> Setting everything in monospace would mix keywords and grammar.
>
> With this schema in mind, I don't find difficult to understand how the =
synopsis=20
> is written (putting aside the  {empty} hack). Fair enough, this is more=
=20
> difficult than just plain text, but the aim is still to get decent outp=
ut.

Thanks.

It appears that asciidoctor considers `monospaced` that results in
<code>...</code> is a bad match in the SYNOPSIS section

 cf. https://lore.kernel.org/git/xmqqsew3hdmv.fsf@gitster.g/

but we should be able to sort it out.

