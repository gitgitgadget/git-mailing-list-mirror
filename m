Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6C1E4B0
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235253; cv=none; b=CyQPWDLHTI0DZvbW3Ta0fZUWclaRJwQkcn84D28FufzRBkMBTqnU4xedAwDVUVUG6Kbz1NRhekb8k2TtXKlbPdpQMyqt6ClLzt6X8gurpdGhh/X2oqwDfCa+te9y8VS5JHMmPf6UKdevJ0o0/bRIWjjMkWSdAFa4iL4BHqVb/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235253; c=relaxed/simple;
	bh=zSPMCqgHxmeb7WxmRbQfCpX3S4enQsxEwyFaJPGOguo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugzZcig8AXFu5Q5cVuFnE/dr9Oej85JKNXWuIbiPh7FniQDj2N3PiF06Ei3TOqA38ISfgXJKqauAmG3wkZAMCWuLhsIR8W+7OHn2rl8dFQA22NQ2zXVHpe+GqziGz8dD4V5/Wo4lFy/afD7ndER0GxtC5S6Pj9e16MqnDAJBJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i3rvz4gc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i3rvz4gc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EC61F35EC5;
	Wed, 17 Jul 2024 12:54:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zSPMCqgHxmeb
	7WxmRbQfCpX3S4enQsxEwyFaJPGOguo=; b=i3rvz4gcZlo7C1Rg/laGvYQUMd4L
	0Q0SGh9++enK+1FHM7w0jKAFpxA6j88jItGpAAOymJc1q2mYrDEOyIBXrdG04oIu
	brB8ipdtSuOUh6QHDnNuyFtWO5j8u8q9vQiSLzciby4k5PzsWqeJuyhPR0J5ETin
	ljZz6ubq4OJ+bXE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E5BE035EC4;
	Wed, 17 Jul 2024 12:54:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73A1A35EC3;
	Wed, 17 Jul 2024 12:54:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
In-Reply-To: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
	(=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 17 Jul
 2024 06:17:41 +0700")
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
Date: Wed, 17 Jul 2024 09:54:05 -0700
Message-ID: <xmqqikx42c42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2E851892-445D-11EF-AFB0-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writes:

> With at least glibc 2.39, glibc provides a function declaration that
> matches with this POSIX interface:
>
>     int regexec(const regex_t *restrict preg, const char *restrict stri=
ng,
>            size_t nmatch, regmatch_t pmatch[restrict], int eflags);
>
> such prototype requires variable-length-array for `pmatch'.
> ...
> Thus, sparse reports this error:
>
>> ../add-patch.c: note: in included file (through ../git-compat-util.h):
>> /usr/include/regex.h:682:41: error: undefined identifier '__nmatch'
>> /usr/include/regex.h:682:41: error: bad constant expression type
>> /usr/include/regex.h:682:41: error: Variable length array is used.

I get the same with=20

	$ sparse --version
	v0.6.4-66-g0196afe1

What I have locally in /usr/include may be a bit older.  It reads
like this:

        extern int regexec (const regex_t *_Restrict_ __preg,
                            const char *_Restrict_ __String, size_t __nma=
tch,
                            regmatch_t __pmatch[_Restrict_arr_
                                                _REGEX_NELTS (__nmatch)],
                            int __eflags);

where _Restrct_arr_ and _Restrict_ would become an empty string for
older compilers, and _REGEX_NELTS(foo) becomes empty when VLA is not
available.  I think their intention, when the compiler fully supports
all the necessary features, is to turn the fourth parameter into

	regmatch_t __pmatch[restrict __nmatch]

I can see how your patch forces the fourth parameter to become (ISO C99)

	regmatch_t __pmatch[restrict]

or even plain vanilla

	regmatch_t __pmatch[]

to erase the mention of __nmatch that is not understood by sparse.

> diff --git a/Makefile b/Makefile
> index bc81d3395032a..4b9daca1dcc58 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1381,7 +1381,7 @@ ARFLAGS =3D rcs
>  PTHREAD_CFLAGS =3D
> =20
>  # For the 'sparse' target
> -SPARSE_FLAGS ?=3D -std=3Dgnu99
> +SPARSE_FLAGS ?=3D -std=3Dgnu99 -D__STDC_NO_VLA__
>  SP_EXTRA_FLAGS =3D -Wno-universal-initializer
> =20
>  # For informing GIT-BUILD-OPTIONS of the SANITIZE=3Dleak,address targe=
ts

But it makes me feel a bit dirty to define the macro that only
compiler implementations are expected to define (or not)[*1*] to
cause header files behave the way they would with a compiler without
VLA.  I dunno.

[Reference]

 *1* https://port70.net/~nsz/c/c11/n1570.html#6.10.8p2
