Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92E3294FD
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061727; cv=none; b=Gdp81PNUpw0zh2UDmXDv+YaFiYvobXXTnD/JUUM3mY2aikximEm+Gb+LiwVexEQNS9IndRtbX54TbeXYqF1e5B8AwBtznBPaK3JlVH9FKk4aoU8/y2gbTTGYFvwfPaGURN/atYd6HasU9QiBw4NcSH0+/6wONL/xKeziK5SE/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061727; c=relaxed/simple;
	bh=QyuP03tP11SLFn2iVWLibdZcHTLgBTHteQfXE0+HyGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uyd1fY33YREiA1Eb8xaaLI/iEPookpPHIIlsqybwTiLtzPzJzTQ+LGc5Z5EvqPwo9m7grznUHNF4YbgcMd8EIyYvoB2u4O2JYlE61ZGXPxbTO8PwbJlRRbn6++4/tUBksjwIgVGC+fU5XLH34eJL0VhBADTuF2w40IHRoxq/B+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=bShDK9Iv; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="bShDK9Iv"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id ye74uTT42AXelye75uZVcK; Tue, 16 Sep 2025 23:25:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758061535; bh=rEotNgLhzf/q0GRdtMLMbmarvZ//oOK28vqVJihAp4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bShDK9IvOWLVkrqG4EtrBVX1YFrOsw6wFX5wplqhtHc8xom+EcFPNihF7rj5tfXwq
	 WmO5XSF6KmJwtPRc0c3nldK2DHCXmcu22kQRwJUZ+Hl5BRiqTcQz1oJnwjbCltNr7C
	 Im2xtOHv+3TuzHr9zihHray9XMyZJWCun+xDcXrUsNq3Amzn9vO5W4x0NFaGIrF/OG
	 ycaoBlExMbipxrhuLcv5oJuFRMoQABjhSpbC6KYTKUGrg7MUUDVaSlvUuJQVllD42T
	 Pv82goJh4Q/+gK6LXewFAm0pqtWcsrUKL9cGED58JY4mZDrbDzvQwX55Q46hBBwL5S
	 ce+E5vvGGlgRg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HNtgFZtv c=1 sm=1 tr=0 ts=68c9e3de
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=GLsIAnh6LJklEuWwgoQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <1feb8bd5-ef47-4cf4-b306-e38c5edac601@ramsayjones.plus.com>
Date: Tue, 16 Sep 2025 23:25:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become
 mandatory
To: Ezekiel Newren <ezekielnewren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC8bHp1NxjjaZDuJrWgyLdB/Tg6FOXQDORf44DKpeNCevMZegFPj9Akvw2ifbk9MBBZmbxf3urbuobCMGHIFz5tsmmVA9Ofxd696h6JOc8Z2cergjzKS
 +jC6p6lwIsuvjcaW06slF7CsnCODSIL3PlQKXYrJBWrnAp9tve1Hu1nl7pPAXM+Zl1P918iz5tFRgMl+L+eJTt9jtGIlVHY9VxM=



On 16/09/2025 03:03, Ezekiel Newren wrote:
> I am currently working on a patch series that makes Rust optional and
> addresses several concerns that this series does not:
>   * Rust calling C: Makefile has no way to build or run Rust so it
> would have to call cargo test, but that doesn't work unless build.rs
> tells cargo where libgit.a is (among other things).
>   * Build tooling alignment: My build_rust.sh is called by make and

I meant to mention during the initial 'xdiff series' that running
the build_rust.sh script failed for me on Linux Mint 22.2, because:

  $ rustc --version
  rustc 1.75.0 (82e1608df 2023-12-21) (built from a source tarball)
  $ cargo --version
  cargo 1.75.0
  $ rustup --version
  Command 'rustup' not found, but can be installed with:
  sudo apt install rustup
  $ 

[if you try to install rustup, it offers to remove rustc and cargo!]

> meson which eliminates defining how to build Rust in 2 places.
>   * Cargo vs Meson: Meson is adding support for Rust and it's getting
> better, but Cargo is the canonical build system for Rust. cargo is
> released in lockstep with rustc, and we _have_ to use cargo when
> building with make because Meson won't be available in that case.
>   * Crates: Patrick's series assumes the Git codebase is _the_ crate
>     * cbindgen: Cbindgen outputs a single header file for each crate,

Also:

  $ cbindgen --version
  Command 'cbindgen' not found, but can be installed with:
  sudo apt install cbindgen
  $ 

[I haven't tried installing cbindgen, so I don't know if it would uninstall
rustc and cargo :) ]

ATB,
Ramsay Jones


