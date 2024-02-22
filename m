Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27501D68C
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619921; cv=none; b=A7lWzvqX0KkHBWtA6bOOuQOecBbW2bY4mNC/nFWltmdwJxYyR49Z7wUAIOCB6SHGL7ZtkNRrJpXygHva0fbRYJ2uqy1w6OmB2o6+aRu23BHGCeh7QLV6kIi3oWentd35hkn9c5NBn7mBLEO5/F7NHQ88BC4QtxcqE7S8gAcJMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619921; c=relaxed/simple;
	bh=5jCqn/7jMP+qgMj9Tt58/ZhdnTXyN82rhf3n94Vxl5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bxrCRbHdSFfKVxPJias8Rt1AqdSphy9MyyebALj5UlWntdWKi65gCzKC7RdbTMnT9JLGcWuCkavO/rea/od1WV9T5TEGf3HEZDL7UE++576lJeAN3d0j8ED3h8zWFdmVKK7T5v1+CP/9LsXuKzamLiN8Yr1zsHXrNGLEJazvAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rfvsB/gX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rfvsB/gX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77E571D5B4A;
	Thu, 22 Feb 2024 11:38:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5jCqn/7jMP+q
	gMj9Tt58/ZhdnTXyN82rhf3n94Vxl5E=; b=rfvsB/gXyGtY6m4IqEk8RzJm2YWp
	enM5xAVXttLil57OUMniP0HplW3EyRrRuhKWEsxLVNmdmJWDJRXTu4R04xazXc83
	oDe8DxGsf8hnGJnfgspsCMzMjrFQqzts9QJRbDd3URMbvCOnDIiUW6dpOuq6fcoK
	wGgK9vodUzvRWEM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F4FF1D5B49;
	Thu, 22 Feb 2024 11:38:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D048C1D5B48;
	Thu, 22 Feb 2024 11:38:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line
 description syntax
In-Reply-To: <2926790.e9J7NaK4W3@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Thu, 22 Feb 2024 10:07:53 +0100")
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
	<xmqqfrxlpvv1.fsf@gitster.g> <xmqqbk89molz.fsf@gitster.g>
	<2926790.e9J7NaK4W3@cayenne>
Date: Thu, 22 Feb 2024 08:38:36 -0800
Message-ID: <xmqqr0h4h2sz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D41C7B18-D1A0-11EE-803E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> So, perhaps we do not have to do a lot of 'word' -> _word_
>> replacements, hopefully?

> ... At least, we=20
> should try to stick as much as possible to the common markup _ for emph=
asis.

OK, that clears up my confusion.  Thanks.

We do not want to rely on an external party indefinitely maintaining
what they consider backward compatibility wart, so the mark-up migration
would need to happen before it becomes too late.

> This would have the added benefit of differentiating single quotes from=
=20
> backticks, because single quotes would completely disappear in the end,=
 except=20
> when a real single quote is needed.

Given enough time, yes.  Or we can actively disable AsciiDoctor's
compatibility mode and/or tweak asciidoc.conf to do the equivalent
for AsciiDoc, to start early.  Until then, we cannot really use "a
real single quote", right?

> For the migration to "standard" asciidoc, I would also recommend using =
"=3D"=20
> prefix for titles instead of underlines which require changing two line=
s when=20
> modifying  a title and are a pain for translators in languages with var=
iable=20
> width characters.

I personally strongly prefer the underline format because I care
about readability of sources, but that is just me.  Is that also
getting deprecated?

Thanks.
