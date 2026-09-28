Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C34CA784
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602908; cv=none; b=OcGSUkHzf4R4jeasO777RQLsXj4Eh0jMpRKtWEaiwMdQzwtfmXzNia92oPJiPkfINAnVx0VOBaBQd41VyOwjuC7lyFRbUt/RkrqJTYwzCbcYTwkjTBeGbxt09zkzJglldfP0t7pKUk6byKzaJQkVPxhxL495aB0GbCh0mc6muoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602908; c=relaxed/simple;
	bh=4naMm5lpidmlYnCcGe3d+mo6JCp144v5ps1N5KtMRk8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P7rlENM2XpM+BWjFwk2GVfGi/AfE5jfXVuehP2VLlFsk52grXrjXW+SVrXIYk7KPJMjt9EXTptSwV7KvtnRNjZyO1+vLWhMEikOjL9RAwRgtm+8lF5ewBplyuhWKIIPsacOD8zNBP2qgpv1Q8FeV9My25Nk1xrJ3OtN2eysqa9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KYIyRIWg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KYIyRIWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790602901; x=1791207701;
	i=johannes.schindelin@gmx.de;
	bh=6lGX/ZyAhmyR3CB6+fxdeEmioFP/Yt4qRM8f3ywzaGk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KYIyRIWgUUEkXZwHF08G1qDF2mR3oi0ydeWyap943STucAz36BJWMqSkoBdbDHcw
	 SW3pHZ8W1MrNevEkwwMkjudR+Dm1jXrtvR4MFOprxQXhQ5Fe2SvKoZeO05KVZDv8c
	 ha2rJlQa/b+Cqv4ehLUe9LrcnuiqrqZvznPTDH/jquHZkqNh5/acuCUqP8COUcjdt
	 OyfzYWO60+QjdFH/UrA6etGxTB3irGn6riGPE4ndfB7/BfHcQ9DlSMXp/dGOWDpN8
	 6HTFJvtlMbujmOvvzW60Bfapyjdxpe0G1/qTF16Zg5bvUtsOSc3Kp6vblcqYLdd8Z
	 Awj+Op0C95voij5CxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1x3Ajj3ZRf-0043Ub; Mon, 28
 Sep 2026 15:41:40 +0200
Date: Mon, 28 Sep 2026 15:41:39 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/4] gitlab-ci: fix the cargo invocation in the Windows
 job
In-Reply-To: <aroOHoSXsemSlP-7@pks.im>
Message-ID: <139c09f8-a126-c24f-9264-154f9b2e38bd@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com> <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com> <aroOHoSXsemSlP-7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=832332865127377717906029011272
X-Provags-ID: V03:K1:cct9h2zHiYUBrgmqaEsfeHMLGDVI61YjaqO5hKlA7/nnktF2Bdr
 Tew8WejgpXf67baLKZUgWfjIKM+lHq+phjiK3mXFBs5QKFwQiHIEfp2UaBpjB7/gG9P2EG+
 pB9oxUy8Es86FhqtfPlgbU020Quw5W/AOcup9Pl5IA8XRRliMFKaRw53nrb7PEbhjVHATaZ
 USs2j9xtpLxvUNmYlqUXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vIOGnKf6FwQ=;fRPxXbEzNJ4NiDxEGQla5c5Vm8e
 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
 tXyJJZcQ==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332865127377717906029011272
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 28 Sep 2026, Patrick Steinhardt wrote:

> On Thu, Sep 24, 2026 at 08:01:49PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > Range-diff vs v1:
> >=20
> >  1:  6a389b2bad ! 1:  cdf2eff480 ci(gitlab,windows): provision GNU Rus=
t for SDK-based MinGW builds
> >      @@ Metadata
> >        ## Commit message ##
> >           ci(gitlab,windows): provision GNU Rust for SDK-based MinGW b=
uilds
> >      =20
> >      -    The minimal Git for Windows SDK already supplies Git and GCC=
. The
> >      -    MinGW Makefile build needs the GNU Rust toolchain, not anoth=
er Git
> >      -    installation or Meson.
> >      +    The minimal Git for Windows SDK already supplies Git and GCC=
. The MinGW
> >      +    Makefile build needs the Rust toolchain that targets GCC (as=
 opposed to
> >      +    the more common MSVC one), not another Git installation or M=
eson.
>=20
> By the way, are there plans to eventually include Rust as part of the
> GfW SDK? Just asking out of curiosity.

I'm still agonizing over that. There is now this new `sha1dc` Rust crate I
want to integrate (patch series about to land), therefore I need to get
going with including Rust in Git for Windows' SDK. But it's not looking so
rosy! As described in the PR to include Rust in Git for Windows at
https://github.com/git-for-windows/git-sdk-64/pull/132, the addition comes
at the price of roughly 110MB.

Given that `git-sdk-x86_75-minimal.tar.zst` weighs just under 70MB (see
https://github.com/git-for-windows/git-sdk-64/releases/ci-artifacts), that
would more than _double_ its size!

So I'm really torn between including Rust (and having a strict subset of
the same setup in CI as is used to build Git for Windows releases) or
alternatively stick with the current strategy: Expect the correct Rust
toolchain to be installed separately in CI.

On GitHub Actions, Rust is basically already there, and we'd save a 110MB
extra download for _ever_ `win-*` job (of which there are _a lot_ on any
given day).

But GitLab runners do not (yet?) come with Rust preinstalled, so... =F0=9F=
=A4=B7

> Overall I'm happy with this version, thanks!

Thanks!
Johannes

--832332865127377717906029011272--
