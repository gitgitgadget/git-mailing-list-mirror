Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF714A4EA
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040131; cv=none; b=lOVnKI5oevKeqzY537BOYndwoujvWyzzP/0ENJwoHjeFiWjDvQmyMs00TE39g4GaaSgqwg2n5UgTeSMUbDWgjgWqHhB7DVmD/agFeVWy8qHi5HnSdYzjozXBxus0iRvKCd0HLuEU9WfO60aVRkI+cKVZ75CUUNyMq/eSwp7LBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040131; c=relaxed/simple;
	bh=4Vi82dp4Q3CT0vNwwsyxBRbsS+4FLV6sq/ffqixpWR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roLJLwFJt+qv6jt+pxC+p3eNmj2ZYZoxNN7HkKGrlrQN2iCGJWONvdPecZ9BMDzSVE2+HhB205iDcI5fdg2g+mOHKxHTTIT2c1DWcfjp02shNZCBnQpLeY8CsIe8r5R9sq/FpNanYmHj0K6OaQDJsXyy/CA85ckrsoRUrrGIKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pVkrjNar; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pVkrjNar"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D2C730577;
	Fri, 30 Aug 2024 13:48:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4Vi82dp4Q3CT
	0vNwwsyxBRbsS+4FLV6sq/ffqixpWR0=; b=pVkrjNarPLT911x6iZQKhZfhQOts
	QfFUHf2SV1DATbsliJRZlnqsqT/p9Avhze92N0WLbJWCM/12dYFb9Ua3EOwaKdzK
	r31oVxfXs0cjfykI84msX1QpoZfHFcjvdCIHgJdgroct0dnQgdHZ9KgL1XUs6TS4
	QfhE2AA9ODCGMMU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 737FB30576;
	Fri, 30 Aug 2024 13:48:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C411230574;
	Fri, 30 Aug 2024 13:48:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Patrick
 Steinhardt <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] doc: introducing synopsis para
In-Reply-To: <1986021.PYKUYFuaPT@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Wed, 21 Aug 2024 23:05:57 +0200")
References: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
	<pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<xmqqzfp8cm30.fsf@gitster.g> <1986021.PYKUYFuaPT@cayenne>
Date: Fri, 30 Aug 2024 10:48:46 -0700
Message-ID: <xmqqa5gtsxz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1BED6280-66F8-11EF-88B2-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> ... It can be simplified further one step further: it is possible=20
> both in asciidoc/asciidoctor to override the formatting of inline verba=
tim=20
> texts, so that everything that is backquoted is processed as a synopsis=
=20
> string.=20
> This way, strings like
>
> `<commit>`
> `diff.statGraphWidth=3D<width>`
> ` --dirstat-by-file[=3D<param>,...]`
>
> are automatically rendered with the expected styles.
>
> However, contrary to the s macro, this is quite disruptive as it forces=
 the=20
> new processing on all existing manpages. Another drawback is that it is=
 no=20
> longer genuine asciidoc, but it seems more in line with the critics. I'=
m=20
> refining the regexp at the moment to check for side-effects.
>
> Is this proposition more appropriate?

Thanks for thinking these things through.  The fact that such a
"magic" processing will hide the gory details from those whose
primary interest is to describe the commands and their options cuts
both ways.  It is a very welcome thing for developers around here, I
would assume.  At the same time, I can understand that purists would
find it unacceptably ugly, as `backticks` is now much more than a
mark-up that means "this text is typeset in monospace".  Inside it,
<text inside angle brackets>, [optional text], and (choices), all
signal that they have special meaning by being typeset differently.

I do not personally mind that, and I would even dream about a future
in which other projects notice what you did to AsciiDoctor, love it,
adopt it, and eventually it feeds back to improve AsciiDoctor proper.

It is very likely that is because I haven't seen any "side effects"
yet ;-)

Thanks.

