Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7413A245
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087208; cv=none; b=e3oBk8WC4M89iHhXtTeZqF40+69jc00GSIqfMZ4Uc1LXFL7EGc+IwIOv/temaIzi0cqBMLpqsXoHknRy+HtilXPaEgeW/aCfM6fvItSjy75NChnalUbX93T6cSUoJmgLOFotenwsDxnJ66JDHFR1Q02TzPnLv9TrOKk5NJhTWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087208; c=relaxed/simple;
	bh=2D1G6vMGhy4MZTcOF3OPGJHwBJ+aQV/Yaot66immqW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Su+/hxEus2FrJC1D51SFv6KIwJYHWXZh7c5etxEV9AsB8kmnzHT8zjctgPkwwdXy+yniggYakuYNtiXtN+FAtRQOMrz0Uqev0d/RojpGWeKTm/wnXmkuTUlRmdeSFd2sdU8nWvc8YY8tS0ymPQiPP8bZMWBF9Yn18q9ZzSehrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=po7A7Zjz; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="po7A7Zjz"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C41A25C1C;
	Mon, 15 Jul 2024 19:46:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2D1G6vMGhy4MZTcOF3OPGJHwBJ+aQV/Yaot66i
	mmqW4=; b=po7A7ZjzDKrHnjClyYYxaKAPM+HzdCWp6h/3QVK3KavnQjex4kh05K
	CFdB424EhXGJKJd4W01OGNvGqG/GLTcQlnJb9a4rhU02IJz3wdF7PLMMuuU6Shk9
	jTE99A3k+u74vvq6ppUo3xHnVkgw+/pzqBDUcV7nk0jwbSWE9PZ4w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 44E3325C1B;
	Mon, 15 Jul 2024 19:46:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1FFD925C18;
	Mon, 15 Jul 2024 19:46:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] Documentation: add platform support policy
In-Reply-To: <CAJoAoZnUbgX1MpisdS+TkGLFrBUyX_x_M_Q6iZ2n_AhP8r4mNA@mail.gmail.com>
	(Emily Shaffer's message of "Mon, 15 Jul 2024 15:20:51 -0700")
References: <20240711232413.693444-1-emilyshaffer@google.com>
	<xmqqed7ylbna.fsf@gitster.g>
	<CAJoAoZnUbgX1MpisdS+TkGLFrBUyX_x_M_Q6iZ2n_AhP8r4mNA@mail.gmail.com>
Date: Mon, 15 Jul 2024 16:46:40 -0700
Message-ID: <xmqq34oa1an3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C9EF9B2-4304-11EF-B398-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> If I fudge with the rewrite a little, I get:
>
> """
> Git has a history of providing broad "support" for exotic platforms
> and older
> platforms, without an explicit commitment. Stakeholders of these platforms may
> want a more predictable support commitment. This is only possible when platform
> stakeholders supply Git developers with adequate tooling, so we can
> test for
> compatibility or develop workarounds for platform-specific quirks on
> our own.
> Various levels of tooling will allow us to make more solid commitments around
> Git's compatibility with your platform.
> """

This reads well.

> """
> Note that this document is about maintaining existing support for a platform
> that has generally worked in the past; for adding support to a
> platform which
> doesn't generally work with Git, the stakeholders for that platform are expected
> to do the bulk of that work themselves. We will consider such patches
> if they
> don't make life harder for other supported platforms, and you may well find a
> contributor interested in working on that support, but the Git
> community as a
> whole doesn't feel an obligation to perform such work.
> """

The part before "We will consider" reads very well.  The part after
that, I haven't formed a firm opinion on (yet).

> """
> * You should run nightly tests against the `next` branch and publish breakage
>   reports to the mailing list immediately when they happen.
>
> ** You may want to ask to join the
>    mailto:git-security@googlegroups.com[security
>    mailing list] in order to run tests against the fixes proposed there, too.
> """

Looking good, I guess.

THanks.
