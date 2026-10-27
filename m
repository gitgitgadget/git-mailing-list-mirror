Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116742;
	b=xy5/sKwO/8Qv3BU1aLSCJGPNBYHrvF+v1bUStFfQDWm7ftZ/tL0GMSQdnkMlMMpvzPwT
	 q8nKITod59sBbPJcBtu5KTSnjhUN2I4GH67JNHXooZN0gTZPmG1ew3DzBPvHsu3VjcfGI
	 +KQReVtP57GG74OFNUxft8Ap7colMSlTbp0wEAi8XimU+3qMJvG6a1De04QnkEPzBRjnJ
	 I652ZS6s+9+oQDC2ctRCt49xoGQojTJb63ombeZh+0ibnU5oTtYPi8QLJNjFrzA84OcaE
	 Fyci6buAkar51oqFJafxN0aE6uAJvMJFjD8EaU9Zp3YYmrwRIpYiaiUt8ymFJylqrag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=SDg2i96V7omk3+T4EfuFmf5cD+SjsdYeANih2WGwVns=;
	b=SGnTtFBQlUWMuox2Vrd04sDAxHzKskKPcUZI0LO+7jj+ba6CifeHV7DPumioPPgu4LL+
	 T2FJox0x7oxdKtRJ63NfBW8mTxf2GZ95WIerY4+O/T8evm7A5cgpLh3W18niUUlenbicI
	 h3lQYL8D2/1ffaOeNZkOHKcXMOOFT6zShPT/IQGWeP4iWOh6bZgeIi3MnPVpXgFogafRf
	 NtqTK+Ygqjx4TbaVuYnBjJpuQ4FVNVWUTMcar0ppDSdxanm5SJLGzyBLygFImxrJJdWdu
	 sQdJddKf1vbYUYpxB09WbQHjkh50jSINwLKAVGR8nx79zpkXH+n+zaFFIvmlmvzndSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QIdtqNrZ;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B3606A32D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 414B3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QIdtqNrZ
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0dba37a7fso37029977b3.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116741; x=1793721541; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDg2i96V7omk3+T4EfuFmf5cD+SjsdYeANih2WGwVns=;
        b=QIdtqNrZ1EHdLw/lqYII10ZlLKNeAQtZhtrmqH9+3yzfYyDtLkhH0YzhtoNXYieWzm
         NKm88UsITTfbSsnRo34DO3SZsArGU1i6CBwsHD+XOSi3qLZD7iXhQvaZvH333lIvXFQD
         AF4kRwOvoNkm82KsCjZscXgApBCAJqjDvx+e6KkTNHx4bW78sD97Ejtuo2FpYwOsBtMn
         XL/osni0mdM4ogWwCdd9rCoBHtO/N0EODDlJQpDpvaYb7JCChCmOtBg2S0Wc5k/MWz4h
         xeDJymPPml426pNppbVwge9+N6426nkYBwaNJyofdcimhzrjpHTOYHU5FhWYycvry8zD
         7xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116741; x=1793721541;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDg2i96V7omk3+T4EfuFmf5cD+SjsdYeANih2WGwVns=;
        b=s6fTR06upwrzcOodbh3g7LioTMiNWZnn6o/hKt6CzU/ZexjJ+3lxnzCzAeniANuF2z
         7Ymz/a8V80XjgofOqojt4GScowtINVVb6npGfYGayAbdkod6LlKcWFHs0+OPryX0t2xZ
         r2PiFnyX1LNUUYXTaGHWQSxvYNF5t50hxTizf8qlUduOu1Pe+X+xBsBSVdrgQWJhckiI
         vtl1PeoNbOG7qrU4KuSnrkYr3adxfS6aJ9Qk3pt3aUMbtNLkRzIoP+xrELTLjjd+UEmO
         Q6Jrz16RbbtinfPCbgrOxCWUpz5mw3RpWYNq2UzTtc0VPdgVkHvgKq5H/0aPpVtiokMd
         /2nw==
X-Gm-Message-State: AFq9FYLdoEIiuf+NA/bHuSu7d6lQj6p22RpiyehmO1bih0UgrALWWNeC
	fVVFCgXydNZ7k0fHAd2XtGoZDfjaMYZC7U5IeME/jC3HqEwO3D0ZwsG7
X-Gm-Gg: AYBFou0PcrPxZXWVyCD/aO+aW0BSMqa+1ndtHoc6OrqoKSw0b7M60JF7aSbhZuSXzru
	hBcU2qwvKZ3eaHGMAD5Y2JnBXv3V7H0NeOn/J9HNfDRP+lmLSiYtN//89bElw91XPNL4KOnCoV6
	k7R8gfrR2dpph3LOVre4ua3cIt97rOPGaXTVwZ2CDI+jUyARXFxHtjgZt5bkBlwGqsAnhxFroWi
	aFcnSlgpAqBZp+u+xDrwxFX13Gww5JGtrUCTCbQooVkl9sTRPx3aapvh3cHMhfAyvNWTzqTTWNf
	+AarTVVGi0TusuQ/k5PXuj1HjqBDBYcS6kyAMt3FZBWD2O0xyANQ0EGndocO1x52pRpjBjRQz4A
	CAjApaGdFe9YzTkXiylEqC/fMWMZPBHGwKvUX2qcJWi5bnPh7oYjUiwpAPxToVTnPu1C6cxvA90
	8thLE97MESc25tksc/Y+pffoOLNmoplbfpODXlkK5aGh4LtjDXuu10XvISkrg4a3WowomrrnZRl
	+XGqpJzmB2vFqCy/Bvn1hkLRuO/jhRqmU6nsK3ST0AZlKoD801KFd0vvMAcymJDIhHYANaHyxK4
	oaM4CiU1E9QcTHt/kj9FL+EBAFI6u+ci2ApaWM87xzRQ9gqBmphAd5mcNZqChTjIFeTe2nxOrOF
	R88HGO7V3Hi/BmxMfEoYGUaMTg3ATaQ==
X-Received: by 2002:a05:690c:7108:b0:873:5bd1:98cf with SMTP id 00721157ae682-8b166c956f2mr62552017b3.65.1793116741077;
        Tue, 27 Oct 2026 08:59:01 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:4455:c602:9aaa:33ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e5adfd2sm14851947b3.25.2026.10.27.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:59:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Makefile: let ccache cache objects built with the precompiled header
Date: Tue, 27 Oct 2026 11:58:50 -0400
Message-Id: <579C36BA-1418-4E15-9CA7-70C752A69FCE@gmail.com>
References: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 27 oct. 2026 =C3=A0 08:49, Harald Nordgren via GitGitGadget <gitgitgadg=
et@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Harald Nordgren <haraldnordgren@gmail.com>
>=20
> Since 8d3a673147 (Makefile: precompile "git-compat-util.h",
> 2026-09-15), rebuilding Git with ccache is almost as slow as building
> it without. ccache refuses to cache a compilation that uses a
> precompiled header unless its "pch_defines" and "time_macros"
> sloppiness is enabled, so it runs the compiler for nearly every object
> file, even after a "make clean" in a tree it has already built.
>=20
> Both settings are safe for our build. The precompiled header is only
> pulled in with "-include" ahead of the source file, so no "#define" in
> a source file can come before it, and none of our sources use
> __DATE__, __TIME__ or __TIMESTAMP__.
>=20
> Enable them for the precompiled header and the objects built with it.
> On my machine, "make clean && make -j8" with a warm cache goes from
> about 100 seconds to under 30.
>=20
> With Clang, switching to a branch that changes one of the headers the
> precompiled header includes and back again still misses the cache,
> because Clang records the modification times of those headers in the
> precompiled header.
>=20
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>    Makefile: let ccache cache objects built with the precompiled header
>=20
>    With ccache, building after switching between two feature branches gets=

>    about 6 times faster. The first build of each branch gets about 25%
>    slower while ccache fills its cache.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2464=
%2FHaraldNordgren%2Fmakefile-ccache-pch-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2464/Ha=
raldNordgren/makefile-ccache-pch-v1
> Pull-Request: https://github.com/git/git/pull/2464

I can=E2=80=99t comment on the above, not being a ccache user myself.

> Makefile | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index a96be506b5..43ea5e0c40 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2946,6 +2946,8 @@ $(PRECOMPILED_HEADER_GCH): %.gch: % GIT-CFLAGS $(mis=
sing_dep_dirs) $(missing_com
> $(PRECOMPILED_HEADER_USERS): %.o: %.c $(PRECOMPILED_HEADER_GCH) GIT-CFLAGS=
 $(missing_dep_dirs) $(missing_compdb_dir)
>    $(QUIET_CC)$(CC) -o $*.o -c -include $(PRECOMPILED_HEADER) -Winvalid-pc=
h $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>=20
> +$(PRECOMPILED_HEADER_GCH) $(PRECOMPILED_HEADER_USERS): export CCACHE_SLOP=
PINESS +=3D pch_defines,time_macros
> +

This is a little curious to me. I=E2=80=99m familiar with the GNU Make-ism=20=

to set variables for particular targets; how does the export work?
Is it the same but with a propagation to the recipe processes?

Would it be better (for some definition=E2=80=A6) to put the export in the 2=

pre-compiled header recipes directly?

And, what about Meson?=
