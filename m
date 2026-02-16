Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2627A92D
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232267; cv=pass; b=syoMCHkTlYdnTam3c6nW70MvYx8l1GNx3hOjuTqQNAe/m3MVTJA7Fn/0Ug7kpOiMoWxshEZvM80UZCJ8NoUt4sBscOTIc19gklcyG1vhh2Lxa1GHqhQ4UvvYRCfxFUlE6Rtel+DvHYDkag68MiZ53QoA4UVD6n2iuZOWm4Y4lDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232267; c=relaxed/simple;
	bh=osbdAXCL+/nxICmKLlX+YJnyy+VxagnFckbAxQ9yNjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8SNWE6j2CPQzfQVMXr+1XELq6xp/beMJkOzM9rwe86IhJOZBnh3dohJPDlTUiSQX1psbDTIOpMcmgpBSZKIUA426b+diMnfsOoGQjwP8MZ0WxSJ2wSOCJBvsxPKlqFQfT6LdZOMxZ91E5ZpvEylSv8F+VF/2lMZ+BvlTVgy0Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K49ja2mR; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K49ja2mR"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4b77adso3475220c88.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 00:57:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771232265; cv=none;
        d=google.com; s=arc-20240605;
        b=BwCLXYNSJ4qPpI3Mm01RI23ydW9kQIS0ea7jW0r1r5pr5xMk+ytz7CUMjP+bLrYcyB
         duvRuOwNVPHYl/FpFmpzDeOOlzkV6mYomiDiJB0SQLxDQfFritGcuFCLm0FLgvkqYJEf
         8O/0dzN4S8yrRC6X5Q9soW6z0k/n08M5bcy9AK71BFeUMmdtq4F3UsZY0Q9mxKcjCDOO
         MSzFBjprU7xe2j5ipoel6dQoP7lcxT6E8R/wYq03XjBkPV6IntuEGmRktH1ijVXyojv1
         OMaAWrn8/OPl7uZhO0BAvhQ58Xh6BDE8sod9muiq1WjlzyOzHDT/eEn4+WrsdMtI7j9r
         vG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+6r0JeihJRojQuzZUGYy3W1DsNd9CX1i7BA4FnTqVOw=;
        fh=ixUb2l2hrASaZJ+AYipvdfT+QE47GqYCY6tByYLgH5k=;
        b=YYGvjIboKnHha/uHzYVBw7XaaS6eN3pJ40uCvtN3rq3lmThJ4+LGGjpZIpnC4xv3Dt
         YkobCa9oNKIk5Labw+/baJDUbZ7XHLiNhqPXN6eeKcOicCOXApApw0JKuWS2Sc+p43IH
         IPaC4YdVrupMRKeEBQX9TD8OZjfGJZGsdfNLr7CiQv83z6Vt3TanOk60zuZOwZ41HrPx
         3mQsJdt/GAHfHT+6TnUGoNlbtQbaItXEzVZNAeJ+J0Yh64fAkE+aJwAq+/8PAuZaA9to
         XPtO5iXCkyq3CDlOibyHmNHWVE0sF67s+FDUPdUe/tDDp+XDdP1xaEGvHienmkkj+wk3
         n3Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771232265; x=1771837065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6r0JeihJRojQuzZUGYy3W1DsNd9CX1i7BA4FnTqVOw=;
        b=K49ja2mRJsdYDCGZPC9DIgcEkH/1d5glIluQOlPcS9Hwk0xhUAbItLx5LvsC0/T2hI
         O6EOUGS6YLwADKmeEMjFjYP1LPlsWzcovJ0EnRWaI9TFHOJJ0lac80EdACSWEuDCLSFH
         WvnaE/dcgQK0M/Q5dI4RsdkTHoFhJstTKBc8fQbMXOKy1JNPKIWbff5l19fhWGtBZnKh
         pgqr2Fh+obPsa90464Yt/F/zpF6u1JD4xZ9TCHhSZEF6hYbQB0aml7e62bqlpeik3a/c
         IA2EstZKwyf7p3G8bGtoklE3/UMeR2zemFokxlo4jjEVeVNbmE83dc9Pg141vMeooSGX
         bB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771232265; x=1771837065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6r0JeihJRojQuzZUGYy3W1DsNd9CX1i7BA4FnTqVOw=;
        b=Mp3XRcQz95GbhE1YHo9jE230YfdJg/7Z/GvreIVI4MnGPcWU4F0pWBJrDSYK9GnGpX
         xuFX8GZIPhb8ggIfm6mJoXUB9JgLzWirmrMAdeMG2UC/Mc4hz7wEitj9ev9gkzt7CKQY
         IZ3BzbD/XZDYUDMpCcZNfofT5Jua300HCfw8Q7vE/Ug34Wh+6Ib0G6C/hbiUbIMWUQI4
         cpbBhuCKTF/z3wELH0XS1Xx5wHjfCnUZqlMTLMMCSLBvYPIUJVMPJw7ZCy09dP72yHVX
         kV051OKPtvPh1QTOUGDcsCSYgnqfNoaGR2iKdbqjIIVXG4XfRnTTuSJ1FbXH3BbfqX4t
         eN7A==
X-Gm-Message-State: AOJu0Yw8LyYTZelffs4SPTQjHjjRuH2/gMuw0Fgg21l1LhNcv14mOkN4
	qBNbQ06v4NgNrjsR+buYlXdRYprC8hB/kv0dEX2zBfP++DNGLD8N+VoNpcKLpVZQSCHFqih6fJ2
	qL8GRqTEKFSaLI+00NYFroz0tlJr2Gjf5DWZJ
X-Gm-Gg: AZuq6aIqlw32lDHfQVlV6GJ7Spm9Htx7nX0BScCghOu4VUFXzycgB6mFF76X34Wh8rA
	/ErPE9DNEGoAA5IKiNo6d4b0R/b0+YViIMD1EAxCQC7p0Jok0cr6PgmN5lCUljKLasIo/8WNOOI
	fyWQhIQjcoV+2oW6xgAS9L8vSHv6gfS2fk6rarq3GIvolYK/BztjzW5ZGsoelz/CGRiLOLVxNuZ
	eKzvne3a0A7xQn3rEyssmK7IWCvxxYv/M+dfjqvorgWwMEP4BYLeqL1gAU+ePJnybkCDvcBAgpS
	avRXnnJ78juDxotvY2SVyosvZCWqCkQs0BLx73NuhiGu0AysoFUHqbGVm+KJPyQ+w0/N/m+vLAt
	w36c=
X-Received: by 2002:a05:7022:f87:b0:119:e56c:18ae with SMTP id
 a92af1059eb24-127397c9950mr3945568c88.22.1771232265318; Mon, 16 Feb 2026
 00:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 16 Feb 2026 09:57:33 +0100
X-Gm-Features: AaiRm51gFGYBhc27lzuqjnQ86AHf-5sL5BTMQ1774bfrKU2MxzP9XbV8Aam-0ME
Message-ID: <CAP8UFD0zja_P7fOuCtLt46ubit+QTOME2K4+M9N=CQNceevMBQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix tests with missing iconv(1) executable
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 9, 2026 at 1:42=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> I recently noticed that th MSVC-based tests in GitLab CI started to
> fail. The root cause is that the iconv(1) executable cannot be found on
> this platform anymore. This isn't entirely surprising: we depend on the
> Git for Windows environment to provide necessary shell tools, and that
> environment of course is not a fully fledged MSYS2 installation.
>
> In any case, this patch series fixes those issues by building on top of
> the ICONV prerequisite. If the prereq isn't found, then we also don't
> assume that the iconv(1) executable exists.

I think it's reasonable to assume that iconv isn't available if the
ICONV prereq isn't satisfied.

> An alternative strategy would be to introduce a new ICONV_EXECUTABLE
> prereq. But given that Git doesn't perform any kind of reencoding itself
> in case the ICONV support isn't built into it I found it to not be worth
> the additional hassle.

I agree that it's better to not add a new ICONV_EXECUTABLE prereq if
possible, as it keeps things simple.

> In any case, this patch series causes the MSVC jobs to pass again on
> GitLab CI.

I think it would be nice if this could talk a bit about the NO_ICONV
build knob and how it still relates to the ICONV prereq though.

Before this series, for example, the Makefile says:

  # Define NO_ICONV if your libc does not properly support iconv.

while t/test-lib.sh has:

  test -z "$NO_ICONV" && test_set_prereq ICONV

Unfortunately the diffstat below:

>  t/t4041-diff-submodule-option.sh             |  8 +++--
>  t/t4059-diff-submodule-not-initialized.sh    |  8 +++--
>  t/t4060-diff-submodule-option-diff-format.sh |  8 +++--
>  t/t4205-log-pretty-formats.sh                | 50 ++++++++++++++++------=
------
>  t/t5550-http-fetch-dumb.sh                   | 20 +++++------
>  t/t6006-rev-list-format.sh                   | 29 +++++++++++-----
>  6 files changed, 77 insertions(+), 46 deletions(-)

shows no change in the Makefile, or any build infrastructure file,
despite the fact that the series changes the one-to-one relationship
between the NO_ICONV build knob and the ICONV prereq.

In the Makefile, for example, I think something like the following
would be nice:

diff --git a/Makefile b/Makefile
index 47ed9fa7fd..ed54071fd7 100644
--- a/Makefile
+++ b/Makefile
@@ -182,7 +182,9 @@ include shared.mak
# Define NO_SOCKADDR_STORAGE if your platform does not have struct
# sockaddr_storage.
#
-# Define NO_ICONV if your libc does not properly support iconv.
+# Define NO_ICONV if your libc does not properly support iconv. Note that =
for
+# simplicity the test suite assumes that iconv(1) is available if and only=
 if
+# NO_ICONV is not defined.
#
# Define OLD_ICONV if your library has an old iconv(), where the second
# (input buffer pointer) parameter is declared with type (const char **).

Not sure how a similar update should be done in configure.ac or
meson.build but maybe it might be worth clarifying things there too.

On the other hand maybe we can say that the situation regarding the
documentation of iconv(1) and the build knobs was quite bad before
this series already and that a full separate patch series would be
required to improve on that. But I think at least this cover letter
should say that.
