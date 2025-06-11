Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6B1C84CE
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657219; cv=none; b=cb8q5Su2s3lA9R6of0lLFKJGRNTpC5oljwmBlEdTCeZ4QI/DYo9ja14YNhTC7aWsRuKf8JzyNY4NG6dFlY2yGRBdfHH+iswn1y7b8jWNR92fWx9yoKAKoTw3Z4KUs+gab2ycgUWRtnH1k2T36isnL/47pQjCnaogF6+/7flrdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657219; c=relaxed/simple;
	bh=u/NwemETCGO4j+9s1viSZiUhiXWRvOyf/lQn+hxJk40=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k8vg+JrwbNsCK3fBShNlw99scKteIuXsrnccnnvQiG18jyH0bQ/fsWkNIzHZE+NdoJmrqaok1Txmw+EXo6Dphao8LXKRL5qHTQ9st8Kfi7dvx5fb4f/Q5d+OfHDNMTiU0OLiXFxW17nQ36tFtvsHbgax77IChYfiwRlPa+AuqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=kqnCcPJc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="kqnCcPJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749657214; x=1750262014;
	i=johannes.schindelin@gmx.de;
	bh=OqmMGI+vSqfhJ4mxJuWqyeJcUMypKM68iEU4kloood0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kqnCcPJcCiCkz7ZPn32dkBTlVKHTL2wzuTd0MtYX/kzW0UE/GfXFgD0szJFvICQH
	 2Ce04oWFt9mYXLcSr5fIAcZBuSj7nHrQOgxRdfAoxk2aNOhyB2IhlV+jNSlP2w9zA
	 2uPldNcnLaGJsBjkPqbmmBe1VP/NHv9Zr0fDjmrH0ABXAAjI+nGuUkZKXjgdVGjra
	 pAafCnLjh+KgPzNW87rwIQWlvGz4NBYefGyIYCZr7Z+ldqntxompJ+egsyqCxP5iE
	 PH98ih5EXxerGwU+cfC7PeSZ7TE5ZeLprF+GSDh9gFm/GfD/B+iX3RPPwjhvVqsyV
	 3ZgdHTauVGlzI5RPhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.53]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1v22Qj1KUJ-00exTv; Wed, 11
 Jun 2025 17:53:34 +0200
Date: Wed, 11 Jun 2025 17:53:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci(coverity): fix building on Windows
In-Reply-To: <xmqqtt4mjqz4.fsf@gitster.g>
Message-ID: <8d71bc71-3e5b-c59c-8948-c07d7b4f62ac@gmx.de>
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com> <c65120f25704e9725c317a62b9a1231bd19f3e25.1749650552.git.gitgitgadget@gmail.com> <xmqqtt4mjqz4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FsuhjskV2MqYX+CRayseNE/Fq2JKZ3oQg0XMjV172fb4/xvflkd
 00j4kDLk1NdFEgHhYxrqaJxyFaWQulahj97MjJnCv75SGz4LInYP9k9Yt35S0YECJ1epqFd
 Dwn0/EZuLimNHom/mdrgG1WG+bmqiPi2i3/pDAb4H15yXYCKuZ/1MpXmrkreG7vJa60g226
 y7rjNGuopZHhF4npYWcZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qXVOQWB0mIc=;KbWrkGKGtUttJ0b5lRTuttWdaEL
 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
 1cd20/grFIK9BV/O
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 11 Jun 2025, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > diff --git a/.github/workflows/coverity.yml b/.github/workflows/coveri=
ty.yml
> > index 124301dbbe2f..a5d99e59d4eb 100644
> > --- a/.github/workflows/coverity.yml
> > +++ b/.github/workflows/coverity.yml
> > @@ -147,7 +147,7 @@ jobs:
> >            key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERIT=
Y_PLATFORM }}-${{ steps.lookup.outputs.hash }}
> >        - name: build with cov-build
> >          run: |
> > -          export PATH=3D"$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
> > +          export PATH=3D"$PATH:$(cygpath -au "$RUNNER_TEMP")/cov-anal=
ysis/bin" &&
>=20
> Additionally two things are lacking explanation in the proposed log
> message, though, or an uninitiated will still be left scratching his
> head:
>=20
>  - Why didn't the original need "cygpath -au"?
>=20
>  - Even though many steps in this job deals with different
>    env.COVERITY_PLATFORM, this part does not seem to be conditional.
>    Why is $(cygpath -au ...) safe outside Windows environment?

I am delighted by your feedback which points out a functional problem. The
`cygpath -au` is a left-over from some interactive debugging session where
I _thought_ that `RUNNER_TEMP` contains a Windows path, and I wanted to
make sure that it is a Unix-like path.

But yes, this is totally in a cross-platform part of the workflow (which
is itself already guarded by that `if:
contains(fromJSON(vars.ENABLE_COVERITY_SCAN_FOR_BRANCHES || '[""]'),
github.ref_name)` condition so that it is skipped in forks that did not
enable this workflow explicitly.

As such, that `cygpath` call is incorrect, as it would fail on anything by
Windows. It is also unnecessary, as I just verified in a manual run.
Therefore I drop it from v2.

Thank you,
Johannes
