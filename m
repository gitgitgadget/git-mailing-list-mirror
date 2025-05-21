Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C938385
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835297; cv=none; b=oDtn0ZwL2pumPw4zpYd2cjJ+7WxUL1U6Se5ipLGtD3/e2gN7I1pzcysBCvZNV/WAto4BcGwJ8s8Jym3PXGH79ktuihOUVVnoiMSm0G2Wibg7aFRc+/a/rdAWVwPwJRDxr1JIJ6TmJI6aMW16f81IpWnhfySX6PrOz7thVJsGGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835297; c=relaxed/simple;
	bh=y/DpsqPE75vTCq8tiUOsWvUNHPArovCzLHwVle/wimU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ4+y6SH2woIpXmdcdr3qEqnUUnCSalUm4zeoj8SdlPQOnNd0Jh+MD1uq3mZCtOfS1hRwo0BW0fPJQpOreU2tYS02Hxaq4aYp6IDpNBC77AJtwUtMvBSDLkrBt/I8XOAYWkL2VOd5nrNlVroWdpo8/89M9RIKDlRskbYmO3Yl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEwiGddF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEwiGddF"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad51ef2424bso1046189966b.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747835293; x=1748440093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsBaAD0CxyJe+ibzwUpV1GGNNnmCwUMvJBg/gIV8ZRo=;
        b=LEwiGddF2zTgLAvm/S/6P2wkPaaIInVfuKJR7Rj15vXbSxH6I2k7TsNsRaHHLf28EV
         EGSt+TbqBZ1XrxqJj3TZOr7rU1vILRNClwqj0E7tYfoQx3inqxIJKWYdc7pwbmcH9sez
         1admwplgkP5pIcq5nZLxLTR2L8reeH2IH5N6rRR3oyXn44y/fOuCuJTGf49tdmaVjHBH
         nowtIihiOErB93qrj66ZNkr/JBXUvfQHSrrdxqZTZ3BNCQIfpEHsM6CfJsaEDh6ESejj
         VRJ4nYRTSXJ1QFznaiBB7WvPf5shcU5tQIAjAqoN8CjXWsb7VEl6LS2jlG3qcpdUy1UP
         L5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835293; x=1748440093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsBaAD0CxyJe+ibzwUpV1GGNNnmCwUMvJBg/gIV8ZRo=;
        b=HlKXTGbHvJepnR2fWU5fCKcsidcCFve4bbU05nOX9Y42wYP+t9FX4C177tVANUixgG
         WYlEHV18nMEvLbOyW0V+vSNpnX7auyKl0FLekmgy4CAXEyejDCSb1GndKL8nGg/W57tI
         AZ1myqVtzYG1U4DO9GKVVWCVfSK8P/nSyzFabe+IcNK3N6mjve8jwLf9K1GvVoZ+JfSs
         5Z1KtOKQzjY3UW1XDaN1OiPdyb/Fx8xche9X8sntf1jaISyicV/yHxX/3X08dL4U4l5u
         OnmCVnSWB6BWaTW4uCbZC9y7hthFc+M6sfF+NT/GfaGVwiMUSzCXY4y0q/TYGu6rpiI3
         GzjQ==
X-Gm-Message-State: AOJu0Yw8y7Bc/FC8mA7/uCuJcS46fjYgldx9MiHx3hbdnIcKB8rhilpv
	AoO6holqArIMuRvSVuRaZ9FFsR2Fjq/9FzwgUDdNZGrB84WM5AYBFdp63wDPij9X5G8JacdKD13
	b82BHURRyBHFn6FCjqxlTW8tFrhdHDuU=
X-Gm-Gg: ASbGncu//KyVrpdH0+Ttsm4dmLknaeQaZPWDQ1JMSftjCsQgaWeaRcIug3I/Jsqg+rj
	R6c81/VPZ6X7BxDYzYT3hlmrmd3rSXh71vmvpBRsrmpseR9tu0dFBsHa5fBc70BPXmuxlHq3BU3
	C6Fy2WIM2lOehwFHfFRqLYYI1TvPsdX7FY2W2ka52cS+q76fpjOfzXyhZdzAdqVkIjotM=
X-Google-Smtp-Source: AGHT+IGXH4cNxFs3AepS3fwydL7bdYJd2RocuQoCWz06iC7u/DF3+B1rp/N5mprL7+r9CvjHepslu8vTPF3rOkSswmg=
X-Received: by 2002:a17:907:980d:b0:ad2:3f1f:7965 with SMTP id
 a640c23a62f3a-ad52d43838fmr2048799866b.4.1747835292885; Wed, 21 May 2025
 06:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com> <aC2OaeLYJQAOE_S1@pks.im>
In-Reply-To: <aC2OaeLYJQAOE_S1@pks.im>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 21 May 2025 09:48:01 -0400
X-Gm-Features: AX0GCFuITD4OgvKZNVsRRB8lw0XJ94CK9jhkCkCQU1LPigjqXHiKRCTUrDdQALQ
Message-ID: <CALnO6CCjrYB+ejLfeRaopXW2CytrxtTtOaFDznEfXDuN73EYjQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 4:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, May 20, 2025 at 03:34:58PM -0400, D. Ben Knoble wrote:
> > We setup_path() with git_exec_path() unconditionally (8e3462837b (Modif=
y
> > setup_path() to only add git_exec_path() to PATH, 2009-01-18)) when Git
> > starts; as a result, all child processes see Git's exec-path when run,
> > including editors and other programs that don't need it [1]. This can
> > cause confusion for such programs or shells, especially when they rely
> > on finding "git" in PATH to locate other nearby directories, in a
> > similar vein as a0b4507ef7 (stop putting argv[0] dirname at front of
> > PATH, 2015-04-22) solved.
> >
> > Since we only need this for finding git-* subprocesses, drop it from
> > child processes that aren't Git commands.
>
> I agree with what Junio mentioned in a parallel thread, especially
> around Git hooks. The expectation there is that those may execute other
> Git commands, and that should typically be using the same execution
> environment as the original Git command that has been invoking the hook.
> So refining this patch so that the mechanism is opt-in probably makes
> sense.

Ok, will do in a reroll. Though if you have time=E2=80=A6 see my message in
that thread about only affecting uses of "git-*" dashed commands.

>     A slight tangent: I wonder whether it is even required nowadays to
>     adapt PATH at all anymore. As far as I understand this was a
>     requirement back when people still executed dashed binaries
>     directly. But nowadays scripts don't really do that anymore, but
>     instead use the git binary. And that one doesn't need PATH to be
>     adapted at all, as it knows to listen to GIT_EXEC_PATH and its
>     built-in path anyway.

Good point. I haven't tried running the tests with such a change, and
GitHub CI at least reports a number of failures on this branch
(whether that's because 3/4 is wrong for Windows or not, I'm not sure,
but I suspect it's actually because 4/4 violates some assumptions).

>     So I have to wonder whether this is something that we can deprecate
>     to finalize the migration away from dashed builtins. There probably
>     are edge cases though. Shell scripts for example still execute ".
>     git-sh-setup", which I think relies on PATH to resolve the script's
>     location.

Those scripts are, at least according to the manual for git-sh-setup, wrong=
 ;)

>     In any case, this is of course outside of the scope of this patch
>     series.

Noted; I'll leave it for later to tug that thread.

[snip: style and leak discussion]

Acked
