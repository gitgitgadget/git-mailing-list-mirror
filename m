Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42837F4
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917964; cv=none; b=ByIcXSUNNElMlJr7pKkhZFCg+xtaGBVYpA4AiWuXV4h5fZqyXVWHdWJe6jau+XbUD2ry+Sr1IWyz+lRpHBujhJX0Ud1qJVPedr3bwX9qYwmdp5zxz6bx5x25vXI0QqDQsK4f5pYCFMWfv689i3uiPEMZVfnlfk+iftMZChBppK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917964; c=relaxed/simple;
	bh=L8sHXjJ+ypYTgstfPjid1yoc8eTeUotCQjiVJK7vd3k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ceF/P8E86RT8C6V3JaihhYzm9NCZHsmLAzfvZ0fWvFpACxfHBQi9g4GEd/lOZzrV2xlOMbI9N3DQbr+VgGxSvcJHhpgBgtHdOxVOfj3ZhKaNyn3mKEpvX+u5GujPML95IwsBcLzetpkGqL839EbLn8fY7Y9XVll95kmLoN2+w/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rdDMs1JO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rdDMs1JO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706917938; x=1707522738; i=johannes.schindelin@gmx.de;
	bh=L8sHXjJ+ypYTgstfPjid1yoc8eTeUotCQjiVJK7vd3k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=rdDMs1JO9dJN7hozO8RNWdlPgsrxW2ucFiulFSdiXqlIttNqydg5rDuyG9spXZNN
	 91an3qIY54GlEmnCQvz+lq8AvR9PuAaycMxYjsBYVyhmcDiY82aX70uKSmsDcKZmM
	 fffmMv+5JPzD+pljcvXMP9sX+AXze/tu41bKRFOTsdtzr/5CGrwGXGf+4MxdHVAyG
	 GAlFUKlv1au6cmeta7DEFg+ThSpFwB5Hy5v7s3JEuDLX70nVXAcaTxOdcF+Rq69V3
	 d64ZJb9MoE/n+Pk3SrEcNzIjoDv3qHcBSVtlfV49MV6jqKszv9ryS2GIawwjkIgs2
	 KQkxOo6ytYZVLfWQQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1rHXFv1jMr-00Edwe; Sat, 03
 Feb 2024 00:52:18 +0100
Date: Sat, 3 Feb 2024 00:52:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
    Phillip Wood <phillip.wood@dunelm.org.uk>, 
    =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
    Adam Dinwoodie <adam@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/3] some unit-test Makefile polishing
In-Reply-To: <xmqqh6irwtkd.fsf@gitster.g>
Message-ID: <b7b92f1a-9231-2f53-299e-ad58fc699284@gmx.de>
References: <20240129031540.GA2433764@coredump.intra.peff.net> <20240130053714.GA165967@coredump.intra.peff.net> <xmqqh6irwtkd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4vYCixqAidGiWNvSKisPFwJIdzTfMbgNQMKdVOALDnJGXj/D1n7
 3g4ESyWRd46H3/lijI8znYCM254mWKDlq2/b9t9Lf8vS05kPEYfxmQA2bqingSp6iyVx22Y
 uD2+Zfwx9z0CNLUYkwfiJhsf8BLWdACN5DGQ/coUrKOyijLtePohd9xXSmKPgZrf3TLYvrG
 NbQeNIDWdtPcTachYqTCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E3B+FPLJK20=;lniTouuvlcWCd9cnHSiHcZxola0
 aP34uDov0Gi/ebCu6hYlrd0iYlE/QlH/6i7Hf6s93vkm0x759qPEZA2ZWYdDePy4caFxeo88d
 qVmy83ZYKKPcyTy4dzDF/QwgsUgYqCvCioBrFL64OPMI6PjjGbw/8CM9LFsg9kShgt1yfvUDK
 0uFsuMqtD67J/Cs/0zmMc13rausKOyOM1j7t+AvS4DqUozUdMRkCqJNpJq6t0g+zUkU3hUdcc
 o+Vq7h0CDdB5k4JsEVKpXoR6Bsl99iNowPnuhNq9H69p9eUTwKVHEhWvtxAzJtLoT7nJeTtZr
 HqgQVrTAMydGpDbsgjnzVr9pAaFKAqGVkjSBt6Lw10NK3+vm6+DRqvKusPK9TRXj5ZtHjbesg
 iksZlPk4V3yMUI+1tkMxjesMoUg9XO6IHj3nJuk9z2KoUxn6bJxwgI3fYOshg7sXcVqwMHOc+
 S/cJbzmkTgLz4GbLbVPC8sPkTLjuAPNOdWKL0vcFfoiZyZn6oqAzqPFC7euDzGg/p5eIt2u0o
 4qFH5+kHBKEsIwgxKsT3FqXsBGIRVJoQmHnne129BClI/r2Xgv2G8pefR6DkGtJRZxu4yqJ5E
 JV2e+3jKQ/IFzh9YMM+QxVU3VFWNmJXVVnXQEWJOaLpubPaSO1xm7rPUcZGVDQlxcXjO6gGl4
 MQC7dDp2IelqE27SHV2jM6kc1oGy/g5sqWd7iKyURFwh1EPOMnP6rEgy5uhIk14KkwYBgELnJ
 BrLjyLiHyzou3CyHOpPUJFy4B//ivl3glkD0dFekVbmRlzHWv5z36VXbLWN7v24R/MkfNwVRp
 bKUmG6pqfHnvjlKLvCoKaOFPv+IvEO//HZKdQ9D4hTbmg=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 1 Feb 2024, Junio C Hamano wrote:

> https://github.com/git/git/actions/runs/7748054008 is a run of 'next'
> that is broken.
>
> https://github.com/git/git/actions/runs/7748547579 is a run of 'seen~1'
> with this topic reverted (the ps/reftable-backend topic is excluded),
> which seems to pass.
>
> Does it ring a bell, anybody?

Yes, it does ring a clear bell over here.
https://github.com/git/git/actions/runs/7748054008/job/21130098985#step:5:=
81
points to the culprit:

    fatal: not a git repository (or any of the parent directories): .git
    make: *** [../config.mak.uname:753: vcxproj] Error 128

The line 753 of that file (as can be seen at
https://github.com/git/git/blob/38aa6559b0c513d755d6d5ccf32414ed63754726/c=
onfig.mak.uname#L753)
is the first statement of the `vcxproj` target, executing `update-refresh`=
:

    vcxproj:
        # Require clean work tree
        git update-index -q --refresh && \
        git diff-files --quiet && \
        git diff-index --cached --quiet HEAD --
        [...]

This means that `vcxproj` is executed. And the explanation is in
https://github.com/git/git/actions/runs/7748054008/job/21130098985#step:5:=
78,
which runs `make --quiet -C t 'T=3D<long-list-of-files>'`, crucially
_without_ specifying any Makefile rule, and the `vcxproj` rule happens to
be the first one that is defined on Windows, so it's used by default.

One workaround would be to remove the `vcxproj` rule (which by now has
been safely superseded by the CMake support we have in
`contrib/buildsystems/`).

But the safer way would be to insert these two lines at the beginning of
`t/Makefile` (cargo-culted from the top-level `Makefile`):

    # The default target of this Makefile is...
    all::

Ciao,
Johannes
