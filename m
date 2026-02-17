Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09E2D1931
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339713; cv=pass; b=U0QXrHSCzM8R9Qo3EsNE7hDlRNqLz/jjwI4fTe+SC1W7dxx4DAzdQVjHZIzcR1h1mwFfO1GLHlJeQTe64Z96UOM5o90DDJFDiL4+1kJxJTpIzABsjisioz5AACI0f9vSOSoeBLCXWTrX9Fka3RS384dEuAB2nP3azNQP3IpFBFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339713; c=relaxed/simple;
	bh=WBFp/UM1Wavzpn14fHwIJ7KTdVcgG/6hxjB3XVskWgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmoaIHrQR+Yn8GCZc6dmU4AZbhjzhz7XjQNFK781Rv6sjpV8wCwetDX4DKWlfHOSGNz6DW9o/VasXcMNx8lnMTQn8A6W7Zl7FWSD84rwkXf9P+Gn8H0fXFZs+ecfxlpq+1m8pPOlqH6rdPgWD++kW45d1lmRQ/jOtDUfIYA3h9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj5c8B3I; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj5c8B3I"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1270be4d125so4400635c88.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 06:48:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771339712; cv=none;
        d=google.com; s=arc-20240605;
        b=lTfQBBYLVzxgt/qwi2SWwbhTUeguuQ5W9TrVzdfiyoRCgh2Mnh0gzJ2j7FNFtU8J70
         DUwPfYDU/gsktrsOnEY9TPORFQLtzjmZvhNUyhkUGAx1T4dIqelIz5Uayyp5h+czVQdg
         a5YJZQI++SL9ik4QTSFUsCLcSaWbugpi9xL7tR+b7bFeo43s3G6Aw+zpwDhX9G4YD8Eo
         tyq9usNwOXhGVd1+aGOH9qzsV8Nxgl8Unzp0SROSLEAs3fBatxzFLNOWSULQpZgvRC+s
         BeOum3qiHf2DdKJE4WiVIxyIYSjerqwp93q+LYIRFocJw6Ti2d4WRA+Rb/tTbViMw8+x
         gCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ccaCv2Z0R81CPuLaKLs6nIDX4qu7ksqoD6JZKVIm8l4=;
        fh=ixUb2l2hrASaZJ+AYipvdfT+QE47GqYCY6tByYLgH5k=;
        b=BpAk8PBPSp0d76h5yibcOcu/WYo6O85Sukjww0iFRziv5Ty76YpesAc2xwyg9Fbqru
         lEfmLual2uS0FOR6LPLPtyZkTlIO2Bl4x39chCReUriBWGwWxePHVmB08yX4MDgwXkI7
         VMY3WbFP0L5Rr7f3oa2zudyDpQiKJEBCxRpqmYoLyJn/IU0h5pjf+T3rj4DQI3P741qY
         6mSmDz5R9oOnOyih+Ldnca8G16eAJIUQtAwCtGhG6hBhz4VhjH7zsu9Y2rSztQXM+NCs
         SufEm9BYO2wA8lKE5AFCAOTRVQufUOideoF6f9GymOBUrVwlDmicHkCJR4ioLmyp/b2J
         nPNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771339712; x=1771944512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccaCv2Z0R81CPuLaKLs6nIDX4qu7ksqoD6JZKVIm8l4=;
        b=Vj5c8B3IvMf29ElTa96OEMKX8Cm0yD3nCN39ecNQVnFpjmv0/jQCVf/4dXnFg+JJMt
         C1toBwY58gzOVej8fssYZsSYbe/RRcZuhvlr3M30bOg9adaMgclnpSNoZZVBe2HtDTD/
         lE5rQfIPwQhDmajtR50lZtqUNxt76+Vh4E+ob+lKnuAz4/jk8kGvx0pRerzX5DHUKqSJ
         sc2OFJbl/2KI6aOxCAIy0YADpMpx+fr2+ehCYLtrN5YMd8gMqbXf1EpotPoMYrg6OM/n
         kCMnZY8M+DUc7oNUylmcpN8G8D2Ny5WKF+Kyf8WfYXy2WzrnUGpo7jY1xVR7hkPgyyTm
         b4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771339712; x=1771944512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ccaCv2Z0R81CPuLaKLs6nIDX4qu7ksqoD6JZKVIm8l4=;
        b=mjgVhjXMVVRK8IR9MLViA5FDC1051+H15Frf/wC3rkZpDFDZD3oE2Ub9xbNRdK5Kax
         a+XYWv6hGSIowc9v1+fGZI3a7flwECHmjO/8IUshyaiWaNPVP1Vj0fqX3zSh5Yhq44+J
         nSoSsTPx/uZVxvxXjOP2K5v66ZgwP7DYpBeGwsTSBAu2wNNJ9uWi+91lllGUetbvcBP3
         GDJcNOYdIhIRpyJyavm65SMyidPwc6xk8ixtMicwb5Vf3GTIVomLaBD7YZbRzt8qPIuk
         3eJEGN6KYPSINIBtj/2zY9Gv/OOYRMGpQ81T6I/2z/dwY1W3O+Kht7fUCz0/5vqCUfKi
         eWkQ==
X-Gm-Message-State: AOJu0YxebqTQTZTCUYtklpPEKv3dEdxwAoDN+85AHbUb4ovikiQ3zZQN
	QkTUimWvd9Qr4dN6vqmasMAIkucNXdNuVdsiR7GpOniCq5h/dC/yqge520PZefslPxuByM8eqc9
	W83ViV6TKo9tQoMMBwisYy+Ie3pHMiUXJ314h
X-Gm-Gg: AZuq6aLrRM2ojKctfrHbBq3bIQDow82w+wVTpyrlDSpJnuVfNZav2H/iBeLxhO8bgzn
	z/oBiwR+XGc2OB/vlwWx0F4gTC7kl+2eYZq0aL50uWM1a344evzK8AYDD/k8wrs4ZFWptAX6s9k
	qtkG+Wkpm3q1Q1aktYp+DFaOI9JE4tuZPkpn076cCCWi0BOXDPwQLOJxiqIAxOxXOZkgZd/4Eee
	LR4f65Ev1GmADzDzfXFavNBFe/kStA0g3iC9tm9d9McXkUTq8BZm7qsgLpq4fgpdgeZsVGdgQB3
	NbEw4dIk0DuCrS8aHrbQ+i+ptqR5ASBRNVou5fq4Zv5KUdE56paI2mI/uzLJ9hMuXHcr
X-Received: by 2002:a05:7022:2387:b0:11b:f056:a19b with SMTP id
 a92af1059eb24-12741b8155bmr6563874c88.18.1771339711526; Tue, 17 Feb 2026
 06:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im> <20260217-b4-pks-ci-msvc-iconv-fixes-v2-1-25491bc8dbf8@pks.im>
In-Reply-To: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-1-25491bc8dbf8@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 17 Feb 2026 15:48:19 +0100
X-Gm-Features: AaiRm53BTqKz4bJoQzOU7Ffwc36SvTBbXTSDZuihztS3_obwazqkKGwnLsO9WKM
Message-ID: <CAP8UFD23MdTF3qVFhDFBDcnqh4dqiehvFz_3c-keMhSOa92Dpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] t4xxx: don't use iconv(1) without ICONV prereq
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 2:58=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> We've got a couple of tests that all use the iconv(1) executable to
> convert the encoding of a commit message. All of these tests are
> prepared to handle a missing ICONV prereq, in which case they will
> simply use UTF-8 encoding.
>
> But even if the ICONV prerequisite has failed we try to use the iconv(1)
> executable. But it's not a safe to assume that the executable exists in

s/not a safe/not safe/

> that case. And besides that, it's also unnecessary to use iconv(1) in
> the first place, as we would only use it to convert from UTF-8 to UTF-8,
> which should be equivalent to a no-op.
>
> In fact, Git for Windows has recently (unintentionally) shipped a change
> where the iconv(1) binary is not getting installed anymore [1]. And as
> we use Git for Windows directly in MSVC+Meson jobs in GitLab CI this has
> exposed the issue. The missing iconv(1) binary is considered a bug that
> will be fixed in Git for Windows, but regardless of that it makes sense
> to not assume the binary to always exist.
>
> Fix the issue and skip the call to iconv(1) in case the prerequisite is
> not set. This makes tests work on systems that don't have iconv at all.

Nit: when reading this, it's not clear if this commit is enough to fix
all the MSVC+Meson jobs in GitLab CI or only those related to the
t4xxx tests.

> Extend the ICONV prerequisite to cover these new semantics so that we
> know to skip tests in case the iconv(1) binary doesn't exist.

[...]

> +test_lazy_prereq ICONV '
> +       # We require Git to be built with iconv support, and we require t=
he
> +       # iconv binary to exist.
> +       #
> +       # NEEDSWORK: We might eventually want to split this up into two
> +       # prerequisites: one for NO_ICONV, and one for the iconv(1) binar=
y, as
> +       # some tests only depend on either of these.
> +       test -z "$NO_ICONV" &&
> +       iconv -f utf8 -t utf8 </dev/null
> +'

Yeah, I think it works to actually test if iconv works and to document
the small discrepancy between the ICONV prereq and NO_ICONV here.
