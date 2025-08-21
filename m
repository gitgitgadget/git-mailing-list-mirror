Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52634F48D
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800662; cv=none; b=lr/wIq+CWXrcibggyK3m1ioent3XviHM4p0KWD0OI1tkgLjlrsoCfg6JFwKRfBi8COtvRRpwfgiuCgzDYJ6ccHaKqLlCYWvfDOsS7fJtsQg/tOpOjOi3jUeFML6BYko/8MJa7UR64jO5ETepeViV4l3XZxR/Mrju0/g88DXe8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800662; c=relaxed/simple;
	bh=ipojMDePC16pksMwtc+vLZeAy06HFlNGWYlF8ffawuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtMZx2UMaxtBmsmm86qVR2JcuCvBlgVEYkAraXzTutdnXfWOL6U8ttCQfEFaueBQSrP4Pjf75VckqMQK863j/b+rRdYPnKCiFNtmWEbBj7RZ5EOVlsomFtWDi8gIwHMB+OUJ7KVWHAaVKFfboxmoar/x8qSdmcq4lTbXH1jVTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=kimAPKZQ; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="kimAPKZQ"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 5BDA34CDE9
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:24:10 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:a2fe:cac3:5774:9094])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 05B3260128;
	Thu, 21 Aug 2025 20:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755800643;
	bh=ipojMDePC16pksMwtc+vLZeAy06HFlNGWYlF8ffawuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kimAPKZQ9wRzr8Be0Fv9mjVu2Kn8nlXF7JelpSq2a3kN/pELKxaq8eRcr2ZuVovvt
	 Ve5SVH78M2zm0RI6VP4XcwT+/sMOmmPVXA+NSpMcDUchI9asCdaAV1mlSd2MFGRPpn
	 EUiG2TOr2gPRqhOwFayDdrfCNApbot3EY/rFr5qQsVNEjRROWvkcVrp+qDEzKFEUPH
	 GTW/5jzOxFVce//huzr3sjbI/MSxdgee0LPFaHh0ONxDiEDkJp/CvnrAta2NQuPn9N
	 mwRfSH+hl5pGEnBthVvbFiAW8+cFsNPaiXPvgwtjoo5fJSwIpPy0uNieHHG9T9+OM3
	 yEzHZGhSmU99A==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: ps@pks.im, karthik.188@gmail.com,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject:
 Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for --format=nul
Date: Thu, 21 Aug 2025 20:23:58 +0200
Message-ID: <6186055.lOV4Wx5bFT@cayenne>
In-Reply-To: <20250820144247.79197-2-lucasseikioshiro@gmail.com>
References:
 <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250820144247.79197-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 20 August 2025 16:42:46 CEST Lucas Seiki Oshiro wrote:
> Other Git commands that have nul-terminated output (e.g. git-config,
> git-status, git-ls-files) have a flag `-z` for using the null character
> as the record separator.
> 
> Add the `-z` flag to git-repo-info as an alias for `--format=nul`,
> making it consistent with the behavior of the other commands.
> 
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  6 ++++--
>  builtin/repo.c              | 17 ++++++++++++-----
>  t/t1900-repo.sh             | 12 ++++++++++++
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 2870828d93..f2dc71193c 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
>  SYNOPSIS
>  --------
>  [synopsis]
> -git repo info [--format=(keyvalue|nul)] [<key>...]
> +git repo info [--format=(keyvalue|nul)|-z] [<key>...]
> 

In fact the correct formatting is:

[--format=(keyvalue|nul) | -z] [<key>...]

As stated in "CodingGuidelines:

 Use spacing around "|" token(s), but not immediately after opening or
 before closing a [] or () pair:
   Do: [-q | --quiet]
   Don't: [-q|--quiet]

 Don't use spacing around "|" tokens when they're used to separate the
 alternate arguments of an option:
    Do: --track[=(direct|inherit)]
    Don't: --track[=(direct | inherit)]




