Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06009291C0D
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414412; cv=none; b=AHkibAxo2T6TOIsWq2fz88P2RasysRU2RPQ8Uldz6SXLzwzSjshk2P37CCJYUDzfBVN88LILrE3NoSyX1XbXSwmq+5Ohw7vmwYwpsAfyalPUgoc+oRQ8o7+1wzkZF2pfdovLgG51DoSdednRslmUxJ7/5WbQUOhoqjJl9UsTz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414412; c=relaxed/simple;
	bh=QUWxLvW6i8tiHSjYApKE50u+VQdYBgSdoCgru+6dScE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBBWOQ6ZTkXFBI+UY+zDbA/k/HQGwrEaQOVynpa8VvUxkQ9R7x2EIuWHva/Qd8cazkPeC/hbYV4kssxztgfsZrqFrspUDKeTQCz2UzWLoLlAqcU7Qa2cW9Z7x2/wNw7WjZ6EZ8PWidhNQiTLgAyEAv6carnpA5fNzdkgwEd2SLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Npwoptqs; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Npwoptqs"
Received: from cayenne.localnet (unknown [IPv6:2a01:cb06:114:e600:28d2:9042:8b81:c43a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1A2CCB005B1;
	Tue,  5 Aug 2025 19:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1754414408;
	bh=QUWxLvW6i8tiHSjYApKE50u+VQdYBgSdoCgru+6dScE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpwoptqstTZ2Fh/R+rcU8yJWvmmUXaYEhnVQcXji+Geu5UzSq7XEhWQ0Vd4MbxR3t
	 6X+LECLApI5OC9FcvGNGg1KueSWAwAi4wIItn4tZe6Xob4PVoorWK0oSoL6VXPNnyY
	 q6c3bqhrE0i4wW7COrK3QEeTah5xoVU5UULodEG52sBVaiu+q/Ov/xU5bWnofOau8i
	 p1rxPbXF3LmB0FNRN1iLf+gMRqJQv5ojFZIvEAX/xf+TAXBm1YAti2bunqkFgf0yjm
	 ZL8RST+j9Pt35j/vbOqgLZLvvmgQA5zNmL3pEH+fgWdFCxUFxUV6kVrReX3LZVHGsR
	 hSDyFNtqi8fbg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
Date: Tue, 05 Aug 2025 19:20:05 +0200
Message-ID: <1929210.tdWV9SEqCh@cayenne>
In-Reply-To: <87tt2lu2rx.fsf@iotcl.com>
References:
 <20250730175510.987383-1-toon@iotcl.com> <xmqqjz3h20cs.fsf@gitster.g>
 <87tt2lu2rx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 5 August 2025 18:55:14 CEST Toon Claes wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I am happy with the updates, but am wondering if documentation
> > update along the lines of attached patch is also needed.
>=20
> Ah (annoyed grunt), I should have added backticks. Yes. I missed those,
> sorry about that.
>=20
> > I am not sure about the last two, i.e. things that are not dash+option
> > appearing as enumeration labels, though (and Cc'ing Jean-No=C3=ABl to a=
sk
> > for help).
>=20
> Well, this gave me a nice opportunity to test Jean-No=C3=ABl proposed docs
> linter[1].
>=20
>     $ make check-docs
>     [snip
>     git-last-modified.adoc:25: '-r::' synopsis style and definition list=
=20
item not
> backquoted git-last-modified.adoc:26: '--recursive::' synopsis style and
> definition list item not backquoted git-last-modified.adoc:30: '-t::'=20
synopsis
> style and definition list item not backquoted git-last-modified.adoc:31:
> '--show-trees::' synopsis style and definition list item not backquoted
>=20
> It seems only dashed options should be backquoted.
>=20
> [1]: https://lore.kernel.org/git/pull.1945.git.
1754399033.gitgitgadget@gmail.com/

Well, the check fails to catch all the missing cases: The last two terms=20
should also be formatted. For the <revision-range>, you can either enclose =
it=20
with underscores (as a placeholder) or with backticks (which the formatter=
=20
formats like a placeholder). For the last one, backticks are definitely nee=
ded=20
to differentiate the formatting between the placeholder and the syntax mark=
s.

As for my patch series, this can definitely be checked. will reroll.

Thanks

Jean-No=C3=ABl



