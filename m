Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793000328;
	b=aWvdToB8552U+B/JYP2I/GvVn6xyXTQtzVt27Qoj8xs7DQhXl0+dwjbkp4ji71RkseBx
	 YH+Q4BymVRKo4azhFLoqPv5NR1skbys7zFUYUrXPJdPGK0T0kMNZkzMLic1b6VBEMlECr
	 LCckyGcJ1sRtsLf3PC6bT/vDhCI68jaK5BGmxUMslanBIAxrwPWzd5o14v5mcRLhteUm8
	 dFiim3w55YYi44NSfaJk2RT6Ypaug2em2/bM7leayj6AyCcGENZQaq28xsqxZjY0vmMFk
	 snH8KHbaCvqJ+PmXyeELT7nbxqsYlhbM9ELGhX8ApN0IB7FflNNBFInF+lWwHXPD1xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=f1DIz5URKWYgeSU8jCzlpnWHBoA+fHXAkVhyHhXSGR0=;
	b=1sA8ixnD99y1Wq3p1qJPSQ6bBkaVw5/AIb3CZc10f8fmXbqUpIsqAnWyP7EFi8kcHuv7
	 52U3YP2wI1vQ0lvs552cKc327xFiurAiyfWJzkQlz0KrRTzfQXbOUuGcZ+7mLshZ9E8pp
	 Tv+hMx1p/g1RbSGM1XN3ex+atnADAZaFrekwsXz1IGgCCXLadwV0NqoOIeC6QuiTq0tU6
	 pVzdlHpcpDg+ZmP+DIxe1S55rXuKc90+9K0l5zBLYwoHHs5Iej4DMmjiaXyfFJhL7ZCS1
	 uXXkIRRohn7WT6bWKviUgv41QLwrnsLq1N4DkNofnvciAAktAQVO6+IgcanRZQyMoGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I+ZpQLq1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F12606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F12606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I+ZpQLq1
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c169ae1cb26so570395466b.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793000327; cv=none;
        d=google.com; s=arc-20260327;
        b=FuMFTt+qxPiIsvuuqwBwjRLNBOcs4LvQjYpASakAqAcy+E8o3P3h2QAKZKH9J8DmuC
         pkEFiyZgZQzko0dZx3mbpmCkgXIP6LrXXEuUxLITscU2BApB4vpRKSmm2f7fEGF4xK6D
         fFW5LLKA/tx+uwb2h/9xyTS+eV4kDAfcuNjnp3zJQcxoV7ZRIvtu2Xe5bSI45r8Kucqp
         fjISsHvdgQY4mx5j92nyYA1+P1inqNt1SCh8QmrRh/I5SIh9Wt0Twq2HpQF5SrF5dAUO
         cDW+Wa/LRUsjJG2HRP7d6YRt7RhaTeEEkfcMYuxplpfSuiID9ns7CpIpe+pvp7wwMcUm
         ujdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1DIz5URKWYgeSU8jCzlpnWHBoA+fHXAkVhyHhXSGR0=;
        fh=ejb2MQ4TYQkcXdQU8uSy3CNItbEek4RrldEIwb9Kn44=;
        b=VtFSaATju3aofa2Qd13gF3YjC+As40GE6hJoizlWww10HKr2MBqbhjgghnbP4NiUkr
         FEXgqaqjQ9yond1VpwzGZs4su/NuNnEGqp1381fWRSa/e/eRtSCRJaJunvVyTmdFy5Q4
         iMnxJZeKgpCLvPRe1gb9tdco3rgwAM7jCvVPNuHQFW4DATpzlBfNFt1sdkQiPwrofGU+
         UqsUKKlKfmVk95qWA8APCQgvMFaUiW44vsEt2VSlffPgiFFkOK4T/k+1J99o0HWdF1dc
         n3ELuYxrY8u597JASpr4AmmdlZIjmmXDkXFlKfynccK3OiiSAUBDh6ed9T7IaquJT6e+
         PbpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793000327; x=1793605127; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1DIz5URKWYgeSU8jCzlpnWHBoA+fHXAkVhyHhXSGR0=;
        b=I+ZpQLq1lovQK5dLTn/+chHL3xfV28WO7Wp2oFdyk6FZ0VZH5Cx/7wgBdnNJDsH9Xy
         R4yuskqaXmFEKPOgTrw5y0hLj2MVyF1lASMzJxKOm+B8sxJ9X/tuYnyVs3It5jxJ4yK5
         AicQJHolkFGuSkaB5cDGLJHBbMqCgRgtk1vKJXd1P5pkCdeiqIz/LM1pcz9C0WIizEUf
         NPQyAbioeUwaY7H1W30iOypARUaEW8THXFnJE+NQp6XKP3Qm/wpuwIMUL99VIRanTCiO
         ksoKNrdEHX2Nv3Q60/lN/+H2ADvWo+4ksl7c2Ku34DisE8PxqGkY5vImoY6fQ6bOFd/E
         xuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793000327; x=1793605127;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f1DIz5URKWYgeSU8jCzlpnWHBoA+fHXAkVhyHhXSGR0=;
        b=Y/so20LI3kGrF+XEuhA6HOZBww6tCU1TrUfvRtB6mMYQRDZ+4yRs+XSkb4zQi0wqGC
         qXN0XeOlmlUOqxeGTqVNW+NLfOi64ZLTc7jTyZIICGXAVTevHYkE6oQ4d/CZO4iluy82
         Iod6q9NvuNIqyroBNp/gQ8jy9RWENn3Fy84DEktmYdRa/CL7t7YW0etoOdlpB0w5XVAI
         cbQ0nxY7Z3ryE5m6ifT99WlroSBwhp458pir33OcafmWsuALFkPx+/T9R0tW1YbdYcDF
         1GK7Q+p18IzbFDOihDF+FXMVtr8fdfTL7M+aAZesvoHEuvwCf+rNcqhL+EBd6no1hsIZ
         cqiw==
X-Forwarded-Encrypted: i=1; AKwUvBxT/oBJrAxCR6oxFoIC8Lhs+8o/gtg5FiNFEe/Qj9bqszXIbrcVA6HO4OnoyBL0F+NfBDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJt5Tcgw++7w8T8SUK/4Yi0UsuxSEdO8oaxtX4bjXZETfxBtgs
	1//6MzjKhg78cieUuZ2jC7KwD+nbwB65UPjZfCmQCXgiM+hconA6/mSjelWpsvpI300y99BQiee
	j+GnQUAOTsrYBa2YEZ16VukTGBj1M8J+hCEaB
X-Gm-Gg: AYBFou2JrhGvf1fhQ1/3LcbNQW/M/OlNYdjQHkFadzv/tb9y26dk5MPn7ZFuboIMHRW
	rLD9NOL79p7k6UQKbLJIPCDYQYe6Mpk++cp30X86WVyhCchcBfV0C8DsDRQycEMBhpG1EjI7vnC
	y/BHPDx+1SWJgd2Dq5WUwHCfB/YUFSRWKwH0apGOnzMzxfdIt2xtpWpbfac1hhIhF8vY3fxDxb/
	uC1slKaUjwi0683H0YOwL3Dgs0qTot+CERcFIuA5a6MFKJ8uKD3ZljotuCiU1owDMgGVr/DCyL5
	jjZc5ZhSmMMZoWs/+TB8e1+dkEJ3PN+RDTEtgSoMCpJV8GgztwTT/y7oPe6WKolDJx/J9YMXwVR
	ap/1BhQjJoK34P1Ws0PxrQeoFOWZ+5bhpSGP7AMq4FXY/wbFlsW1zHsc0Td6rPL8N5TFDyg==
X-Received: by 2002:a17:906:586:b0:c46:ca2b:84ab with SMTP id
 a640c23a62f3a-c46ca2b88c7mr382712266b.13.1793000326676; Mon, 26 Oct 2026
 00:38:46 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com> <at79nEHLDrcoCgn_@pks.im>
In-Reply-To: <at79nEHLDrcoCgn_@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 09:38:10 +0200
X-Gm-Features: AclHuK-fJd24f8D-qbmROd8Mr2e2qUev5PEXHtJm1ITPhN2q7YSxvts84FXweB4
Message-ID: <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >               wget --quiet \
> >                    "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
> >               tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
> >                       -C "$CUSTOM_PATH" --strip-components=1 \
> >                       "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
> > -             rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
> > -             rm -f "$CUSTOM_PATH/git-lfs"
> > +             rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
> > +                     echo >&2 "error: could not install git-lfs"
> > +                     exit 1
> > +             }
>
> This could all be a bit less convoluted if we had `set -e` in
> "ci/lib.sh". But that certainly is outside the scope of this patch
> series, so meanwhile this looks good to me.

Yeah, `set -e` is a gem of a command. Would be good to do later!

> > @@ -121,9 +133,16 @@ macos-*)
> >
> >       mkdir -p "$CUSTOM_PATH"
> >       wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
> > -     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
> > +     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
> > +             echo >&2 "error: could not install perforce"
> > +             exit 1
> > +     }
> >       sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
>
> This line is a bit curious, it makes me wonder whether we want to
> tighten it as well now. Any reason why we wouldn't?

I asked Claud about it and it said this, does it make sense?

'wget/curl never set com.apple.quarantine in the first place (only
Safari/Finder/AirDrop do, via the LaunchServices quarantine API), so
xattr -d on these files always fails with "No such xattr." Tightening
it to fatal would break every macOS build, every time.'

> >       rm helix-core-server.tgz
>
> Nit: this is inconsistent with git-lfs, where we also have the call to
> rm as part of the condition chain.

Good point!



Harald
