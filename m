Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07B4CA79E
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279875; cv=none; b=V0fZRH3aelX8hd/nZDA5gw6MGy1QGfao+dNTURyFZrYmrDFxA2xsCv7vGHjcgVhiPIZk6f3PJ5bu3vY5aJFJ8LlSADkgXsSBccgw1gxB3cwOiiB+wZ0LaJ4wuCFL36p/Wxi8OZlI2UOlUlN3U00qrRA5WPiUVqexXEHrdTdp99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279875; c=relaxed/simple;
	bh=6ISwXQPveki/3LKj4oHCoorht06xzaetIS3YtsJHKyk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m1xVqmNAm2IKC82TpJf/+ZpCbrvqiK82S2xqmfHcsi7xRDFHsTL+tKKt25ssOVvxETdMnJMnk+yFpp8gImQsDTikZy2cNhEtAILUiKofhdSXe0+WvTtV0EsLMPz31SD1oI28YnKQ0ld8WigtAsyNSFgOdCPglvf/veY0Qq/Vtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rWKZ9car; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rWKZ9car"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790279862; x=1790884662;
	i=johannes.schindelin@gmx.de;
	bh=6ISwXQPveki/3LKj4oHCoorht06xzaetIS3YtsJHKyk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rWKZ9carKOptianuwZFT1QcTjdXNaN1C7IOHSnXbqo1HkdQkg8gifMtBK3sDUrXL
	 XcQUOTloirH34t78zapqKqV+JyYvlPivUsrVdf8DdYvk4dAiNYJJUb0t3bef6r0pV
	 UEs4eHW5pQwWvCWc4POIzS3Rrx6eRIgrADXy/Lq0A7ZJ5VDCyzRP1q4G4gsgP7s0o
	 ouXv/bL7A110RBDFJ91riV2GofxNhUkG9G2AdwTO3iMQHX8fJFZSCQjhjKb4GbQ65
	 63DYacHqImwKRQzNXvqjdFrfKQwAZhJww/VsL/Ywa9ORicEyLuG6m5NvnJaxzRNp/
	 0/kumke1CF/EIG6asw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiU3-1xJZYR31AL-00ShYs; Thu, 24
 Sep 2026 21:57:42 +0200
Date: Thu, 24 Sep 2026 21:57:43 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 4/4] ci(gitlab,windows): provide GNU Rust's host-linker
 support
In-Reply-To: <arUH3Bi26yyVcrOb@pks.im>
Message-ID: <b62a7c6d-6248-d957-ef76-3b7e3bf28105@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com> <1ed79f00cf72b2d5f2e5f55bb11de51dceeeb2bb.1789819933.git.gitgitgadget@gmail.com> <arUH3Bi26yyVcrOb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:znuyMvU1WZj9nynrwWR2tPZMJqazW4/nlont0k8UYOIV/NTos63
 M85BnL/Wqe7QiZH54tdCvG1873LbUtF2RtZAtvI/nh+3ZdpInootWyZTTl8e+bRB19JPOFv
 Fbj6sZ1vTzcaeQYvo/SG08oSvOpgaLUkGhTUfWwfYOyKieJhLc7Kwv63VbI7FBzl7kPr4YD
 cj/n6tFqfj3Js6gI4yzQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8Lt+8ST+Vas=;QJHPlFayFjffaYHkz2vUSvlrlJr
 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
 FzKefdwVnkuah5JovUApGQ2xtg==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 24 Sep 2026, Patrick Steinhardt wrote:

> On Sat, Sep 19, 2026 at 12:12:13PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > GitLab's MinGW job cannot find `x86_64-w64-mingw32-gcc` when linking
> > gitcore's build script:
> > https://gitlab.com/dscho/git1/-/jobs/16593470275
> >=20
> > Although gitcore is a static library, Cargo first links `build.rs`
> > as a host executable. We omitted the GNU MSI's `Gcc` feature, which
> > supplies the required linker and platform libraries:
> > https://github.com/rust-lang/rust/blob/1.96.0/src/etc/installer/msi/ru=
st.wxs
>=20
> Hm. Does that mean that we now have two versions of GCC available, once
> via the MinGW environment and once via Rust?

I don't think that Rust produces intermediate C by default, so no, this
would include a second version of GCC. It will just make sure that the
installed Rust version can produce libraries that GCC can link to.

Ciao,
Johannes
