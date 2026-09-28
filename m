Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A349EC77
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612457; cv=none; b=fzbI+GMsLRDMfUDW+kGIHtFkQDySLjXYtUH5wRHgo1YkFPN+n3S5/F51ahpynxpZ/v2iD1BWs26TJmy3M+3Lm+/ntDLG2rVSDiq/nvVViROvUvfshc7ZUUXd2QN5KTw5zWBvfDXxE2nKo9pkiMRqNKGcVWP/9XD1Ic51RAvb8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612457; c=relaxed/simple;
	bh=OiRxT1oMcEg6/1urUnFklkTZl6Kpahj5xDyyOTYCeaw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lswEzo9XMDFzbg6ydLOzar7g9C7EAL/oyDqi6h/ymPL8wy4zx7OOs6UrVbE0Y1EMannkyoOWGGJ61YooEQ5L8kaB00TMf/+6EMxuYp/vy/dd63nP9HxEEURx2G/IWsQxmrEw3DH9TJlQNwyU1MMy96+h7w/sfNcHhH8OoovuVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ecG5FIbY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ecG5FIbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790612452; x=1791217252;
	i=johannes.schindelin@gmx.de;
	bh=5bCrpLionc3fzWT3dFUkN6uH8ADfWSpZBcz2nmUZ4HE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ecG5FIbY+cJ18hpE3k2MPw932XuAPkm0imOavQyQLA5G0wQKWjHG5vmpb5muIb5W
	 3HlMrnkb7V89aIlnu8nsrubHECEokdK9QFGPvPNIuEx1/SpiSaFBEWtGl3cWn2Ttu
	 uBtLe9io2I7tNCZbkwl4u/oHuSikQnO1MWOv2RMEXV02dhhg6dPE6VpLgdsicQBfq
	 YAy3yldXEgw5i/Wwoni0tdfQMoQTaPHxo9xIMG8OQoKGyNgI38YhjdRHhjbM3fM1S
	 vCKhvHbnS30HaxS5Oi9jgqDTM1XRgi+B8SLWbeU5BJbNg0dnofJwSqX9Fl3YZ/ziJ
	 +WID2HFy3ioQvnrDog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1wQvyl3lSy-00ZYXG; Mon, 28
 Sep 2026 18:20:52 +0200
Date: Mon, 28 Sep 2026 18:20:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Add a compile-time option to use the new, very fast
 sha1dc Rust crate
In-Reply-To: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
Message-ID: <2f7509d7-1166-1303-87b4-58974702c73d@gmx.de>
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:rFjJMImnbcWFB2AmeOWjZz96REkPSGt1UL/+jzFIY9VmIBg+aoj
 1mWEbehE9wGncdC/P/S8vfpf5O8cWjFcfhTKdd433xt/+fwioYcV0mlZSToYA8l9FuIKjaE
 IMbJwY6QOl6dqd898vvsjOaYd1h5J6kofu0acqxZBkCzBkmVxdkSw9Uwm23mSRm9D12mwaB
 uVDxQWGzqvP96YrNMPMCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XeZjDQIyExQ=;D94Ys1c02/60CyScCZaOyNTvhcY
 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
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 28 Sep 2026, Johannes Schindelin via GitGitGadget wrote:

> I stumbled across this new Rust crate last week. Its performance numbers=
 are
> quite impressive. Naturally, I want to make use of this and get for Wind=
ows,

                                                          ^^^^^^^^^^^^^^^^=
^^^
							  in Git for Windows

My sincerest apologies; I am using Cohere Transcribe to compensate for my
inadequate typing speed, which typically works very, very well for me, yet
missed this typo. Likewise:

> which is used on many monorepos where this makes a real difference: In a
> pretty fast and loose test, I verified that a git index-pack runs roughl=
y
> three times faster solely due to using those SIMD-based optimizations!
>=20
> As a safety precaution, because this sha1dc crate is quite new, I wanted=
 to
> introduce an escape hatch: core.sha1dcBackend=3Dc, but turn it on by def=
ault,
> which is the reason for the three additional patches. Should these patch=
es
> be undesirable for the Git project? I would not be mad at all if they we=
re

                                    ^
				    , and

Sorry about that,
Johannes

> simply dropped.
>=20
> Johannes Schindelin (4):
>   libgitcore: add `sha1dc` as an optional feature
>   sha1dc: allow selecting the C backend without rebuilding
>   pthread: provide `pthread_once()` shims for Windows and for
>     NO_PTHREADS
>   sha1dc: make `sha1dc_init()` thread-safe
>=20
>  Cargo.toml                     |   4 ++
>  Documentation/config/core.adoc |   5 ++
>  Makefile                       |  29 +++++++++
>  compat/win32/pthread.c         |  16 +++++
>  compat/win32/pthread.h         |   5 ++
>  hash.h                         |   5 ++
>  sha1dc_git.c                   | 109 +++++++++++++++++++++++++++++++--
>  sha1dc_git.h                   |   5 +-
>  sha1dc_rs.h                    |  37 +++++++++++
>  src/lib.rs                     |   2 +
>  src/sha1dc_rs.rs               |  78 +++++++++++++++++++++++
>  t/helper/test-sha1.c           |  19 +++++-
>  t/t0013-sha1dc.sh              |  21 ++++++-
>  thread-utils.h                 |  16 +++++
>  14 files changed, 343 insertions(+), 8 deletions(-)
>  create mode 100644 sha1dc_rs.h
>  create mode 100644 src/sha1dc_rs.rs
>=20
>=20
> base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2240%2=
Fdscho%2Foptionally-use-sha1dc-rs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2240/dsch=
o/optionally-use-sha1dc-rs-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2240
> --=20
> gitgitgadget
>=20
