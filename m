Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756B34BA42
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146956; cv=none; b=JdQrwCGCquHFyqhlaInHGKqy9r8MWyMPS/LmPFrC4sgOUccd1mVgksI2Gg4qCtgoTuSfQi7okmT11Hkh+iT4l8ufEo3Nz0MGDDSbw+web1RoLAeZZtNKIuBlB2FKPdBIYnXD2JqtSB/PpR4to0bTFe6YIjj02dm97ugjmdsfM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146956; c=relaxed/simple;
	bh=FBUyJiy0jp9OmLIWdrrAKaWtmMRbV7WkR8wIP0x+K4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZrVyZDQNs5GGC3xqrZFs+7d9WlsBDB06pg06N0hNC4sR/NKw9wLLFENskbtbUOp2A8fEY3+80lPSAGKiZlFIY8CxrIJdjGxqrZRTctoecEBiQPhEflpXg61aVuzak4E3kL35GUkn1xd3lAOaO5pI3N7y6u/is/3Guw//VOX5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf1tnSI0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf1tnSI0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so1773375e9.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758146953; x=1758751753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0WKv9eDPIpyBD6HTtQxgon9/pmggG6/zfZrakqfEy0=;
        b=Yf1tnSI0c5JTqlobiq6xKkythhV3Vm2HGQT4ObIzkepSZkeBdKXRCQUPclo7r08Vuk
         rCyo4O2IFHfPh7KrzfJSP0qyz5EztB4nCdg9Zc81tFONsYiOLFI4IrwpO7QSOnwHWapg
         83RU3Mc1j/eYkaTAitxbCtp15KF5cEzL7Exy7xY+Zbxe+xc/JTa21fBo2h4nskKrGclY
         Lxh6+GBKd07bSyPpE1S+pw8wqK5gciS/c6a2Jn30yme2i78HrADuRA92rZdrhw+Bc0xe
         cKppsIs6yDkCmmkRiHwTBwko7hiPXTy9anluuHdgaCy2hvOtMItcJFSWtT8rt+0KiQ5m
         68lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146953; x=1758751753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0WKv9eDPIpyBD6HTtQxgon9/pmggG6/zfZrakqfEy0=;
        b=bdyFiGrDw9Z020lemnWZsLeqFxGmdyMxH6a56I6XCxgo0pI0p1NkEXcm0BHL7l2Mf6
         H3+6WLIytY80dKoZmsijCn2j2bEqnkRUBCgLKUEbmVp9aCFNZPu2YJ57TUxRfbLYHWHH
         go8qiyNdENz94kRtd/DD0pVWI9vIFTTQswqfrmlYeIUvGUJFOI4iPyRU2dfO2HpnbRaG
         12/Py8EidOWbP85m1978kPF5K31z0s02/31DXQH/HaT2QfIdfkLP1QFTn3byXCu26pjH
         AwXCi8EpINyjFL+GBz8+LkpSlIPaFQ9vgvlgH8GK/+nrwx15eoXp60YOCbXvyvVGMg3p
         xErg==
X-Gm-Message-State: AOJu0Ywzd7zQDcHkGODErMho2eVaMNczV2Q/W6CC92d84E61+e2WzJlw
	PhCDZ+ZFQ73AXCYlS53Ig3ICKF2e8ZfI+S0GI+744i5rZSwoICnERVop
X-Gm-Gg: ASbGncvPpmo2YCV8fMUTp/zEbySd4LZFY4j/K0WMVpEzxvqbK07Lr6mjyAVUvZtISu2
	qvRYmdxJX920Qze1cnidbwX3O3K9VYbbpAQgFT5qJYxXNN3FbWX8iB9Qpu0Gg+pYaxD94rVuKcX
	qEl42cykgCri8k9QDd8xzGgez5uToNiH3D13SoSCEJLcIH63Rk0kbMUIi/RRHqY7ksErR13b0ZF
	sv/IoxBg4pDjDMclnT3up7cdfK1Iy45rsFCuZV/itNtKEZTWS12F2cRC4lfe93eJxuW79f+XBpE
	yYf8/ZlM/2cPnE8JBFKSxLnh47g/ctXTAYYPxrSadsWmQEOb8ItF5EP2loiz/FhuE6wmhxvk6c8
	Q2vqsQM7yrXh7s54rXVPK5ASJlQVExV7fJ4knUvVoTTBW5AlI+a/hbcc6ooH87Mwav/347mw=
X-Google-Smtp-Source: AGHT+IEdu6k8nqTnM0LNBYgpROwpriF2NRlAHNKGK4JICzVfvWwByuI3MxQju1EbA0zG0TSr+EcCAg==
X-Received: by 2002:a05:600c:4451:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-46202a0ed52mr34389285e9.11.1758146952415;
        Wed, 17 Sep 2025 15:09:12 -0700 (PDT)
Received: from localhost (84-236-78-104.pool.digikabel.hu. [84.236.78.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f345sm13263595e9.11.2025.09.17.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:09:11 -0700 (PDT)
Date: Thu, 18 Sep 2025 00:09:10 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aMsxhp6ZO2Cdz7+k@szeder.dev>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>

On Mon, Sep 15, 2025 at 01:22:54PM +0200, Patrick Steinhardt wrote:
> Over the last couple of years the appetite for bringing Rust into the
> codebase has grown significantly across the developer base. Introducing
> Rust is a major change though and has ramifications for the whole
> ecosystem:
> 
>   - Some platforms have a Rust toolchain available, but have not yet
>     integrated it into their build infrastructure.
> 
>   - Some platforms don't have any support for Rust at all.
> 
>   - Some platforms may have to figure out how to fit Rust into their
>     bootstrapping sequence.
> 
> Due to this, and given that Git is a critical piece of infrastructure
> for the whole industry, we cannot just introduce such a heavyweight
> dependency without doing our due diligence.
> 
> Instead, preceding commits have introduced a test balloon into our build
> infrastructure that convert one tiny subsystem to use Rust. For now,
> using Rust to build that subsystem is entirely optional -- if no Rust
> support is available, we continue to use the C implementation. This test
> balloon has the intention to give distributions time and let them ease
> into our adoption of Rust.
> 
> Having multiple implementations of the same subsystem is not sustainable
> though, and the plan is to eventually be able to use Rust freely all
> across our codebase. As such, there is the intent to make Rust become a
> mandatory part of our build process.
> 
> Add an announcement to our breaking changes that Rust will become
> mandatory in Git 3.0. A (very careful and non-binding) estimate might be
> that this major release might be released in the second half of next
> year, which should give distributors enough time to prepare for the
> change.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.adoc | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index f8d2eba061..0512411030 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -165,6 +165,44 @@ A prerequisite for this change is that the ecosystem is ready to support the
>  "reftable" format. Most importantly, alternative implementations of Git like
>  JGit, libgit2 and Gitoxide need to support it.
>  
> +* Git will require Rust as a mandatory part of the build process. While Git
> +  already started to adopt Rust in Git 2.52, all parts written in Rust are
> +  optional for the time being. This includes:
> ++
> +  ** Subsystems that have an alternative implementation in Rust to test
> +     interoperability between our C and Rust codebase.
> +  ** Newly written features that are not mission critical for a fully functional
> +     Git client.
> ++
> +These changes are meant as test balloons to allow distributors of Git to prepare
> +for Rust becoming a mandatory part of the build process. There will be multiple
> +milestones for the introduction of Rust:
> ++
> +--
> +1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
> +   disabled in our Makefile so that the project can sort out the initial
> +   infrastructure.
> +2. In Git 2.53, both build systems will default-enable support for Rust.
> +   Consequently, builds will break by default if Rust is not available on the
> +   build host. The use of Rust can still be explicitly disabled via build
> +   flags.
> +3. In Git 3.0, the build options will be removed and support for Rust is
> +   mandatory.
> +--
> ++
> +You can explicitly ask both Meson and our Makefile-based system to enable Rust
> +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
> +respectively.
> ++
> +The Git project will declare the last version before Git 3.0 to be a long-term
> +support release. This long-term release will receive important bug fixes for at
> +least four release cycles and security fixes for six release cycles. The Git
> +project will hand over maintainership of the long-term release to distributors
> +in case they need to extend the life of that long-term release even further. In
> +that case, the backporting process will be handled by these distributors, but
> +the backported patches will be reviewed on the mailing list and pulled in by the
> +Git maintainer.

Providing an LTS release for those platforms that can't jump on the
Rust bandwagon is great, but...

Git 3.0 will switch the default hash algorithm for newly initialized
repositories to SHA-256, which, presumably, will also encourage SHA-1
-> SHA-256 migrations in existing repositories.  Alas, it appears that
the SHA-1/SHA-256 interop feature will only be available in Rust.

How will this affect those platforms without Rust?  What will and
won't work on such platforms?

I think it should be called out explicitly in the justification that
whatever limitations this imposes on those platforms with respect to
hash function transition, the project has duly considered that and is
OK with it.

