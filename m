Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E791D7E42
	for <git@vger.kernel.org>; Fri, 30 May 2025 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639779; cv=none; b=NFAcKvWi+Owe859+YkJFvK8lxBnvGjZr8Nbv9NXkqIr/zUTx3VtBq39FxVvSBMoodoVnlM/75cxAVdHHn/f4yA8SbuWSL2NLRTnO5+DKJwmeeu1jJCZxICGuyhp7sTTMiq7mGW6CrIeWJte+st7SYLkx3uA5vd+XnsmSPtXMRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639779; c=relaxed/simple;
	bh=sF5LHt2lP8XjUUfk+VXZBvXUNsA7RJvmW54hZ90K9KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzuiyOhdfkGFh5KZWRW/03EJJznEQBH//Q9CvGO9rSfd7Z4ZEmfO622davpTwvAZVGpBUhfWelm6SnYR34Lr81KEylnBMjHz8nxKDcDTuhZ4T8M91tF4SfpZ6p259TE6i9MEFWemgwbhCOWm3GVTK+STW7EPkRalFiZzv6E8UVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7cd34b6ba10so34714585a.1
        for <git@vger.kernel.org>; Fri, 30 May 2025 14:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748639775; x=1749244575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpvW48HXylnq2a9aRwm+DXT5I/KzydaCsvxakXdUvaM=;
        b=CNJ631ETonuu/FF+gGI58e+AO2Y+EB95ttdo+im9CEeEWKVy12IO4eWMv87gHYYP7u
         6HSBgof+yoZh0cLEtaXZXzZPC2yAoN2BheYLobsIVv6MCe1VVMqZfm7i7F/qePCOBU3U
         NmD5JA6jfYlEM5mwltfiwDtpaW8x74nKmd8ixc8s7NnE9whYYm6Zmyp670CtM5jjTknx
         N1gRXmTFYEZGDKeWqR/niPrd2kln6zypaPluXvRHUWoK+GYKX7sNZlwlZtwSg+Gw7eYj
         GkWWPbAw3WN2jhD4xdod/PpGMsSMj3QO3X6wMe/PpdSuBMLyynx0qdTyY5RDiOKr4HLz
         AeWw==
X-Gm-Message-State: AOJu0Yx6KVFfkwGw/9B+93v3acaO4MlHOS7IzWEALcTZGvVpuIodWg5/
	oMxG3/t6ovfvLNkQv+2gKdYPT2jaT38eaOXl+c1S62eRs3pz9IMCwRFbKKAjkUziOvUKyoGT2AB
	W0u9znr/61iaW0loKjH+iVh10inL67uD/Q+6b
X-Gm-Gg: ASbGncuYYxWB9b+QSaQ3dpU4Q5EfQ+j11huW3/gopJuKIKJGHYs/j71Rzd+gA4+zACg
	qDLcivndz3+4rTKozEwlo8FW9AjBhWbV6XHi+rKVkOEttr3Gnb8S+jc0Ek+kWi8QDgjKuKb14gR
	ragMfARPfq1QMKnXtAZJ9bDl9PBJQzog0=
X-Google-Smtp-Source: AGHT+IFg7z3ebf0dgbriaYyXyZ4cU9qB4XKx9L8psJR85uAVhuw8sCr0sZFK/pakT4D+E248yrjUjPVIHS44+r3dgr0=
X-Received: by 2002:ad4:5dcd:0:b0:6f6:d4a8:1a6c with SMTP id
 6a1803df08f44-6fad06460f3mr26317586d6.1.1748639775629; Fri, 30 May 2025
 14:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im> <20250530-pks-meson-tap-v3-2-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-2-676f5e41f2e4@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 30 May 2025 17:16:04 -0400
X-Gm-Features: AX0GCFs7KDn-Hj3W-MAu9FYZx0kOytFJ5oype7WCbWYmYYDVu_ue5_HLlqVT72o
Message-ID: <CAPig+cT+pX2RF0+0E2FvA1TUjh_R8p==8ePFqg=zP+YxWPsCHQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] t: silence output from `test_create_repo()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 9:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> There are a couple users of `test_create_repo()` that use this function
> outside of any test case. This function is nowadays only a thin wrapper
> around `git init`, which by default prints a message to stdout that the
> repository has been initialized. The resulting output may thus confuse
> TAP parsers.
>
> Refactor these users to instead create the repository in a "setup" test
> case so that we don't explicitly have to silence them. There's one
> exception in t1007: we use `push_repo()` and its `pop_repo()` equivalent
> multiple times, so to reduce the noise introduced by this patch we
> instead silence this invocation.
>
> While at it, convert callsites to use git-init(1) directly as the
> `test_create_repo()` function has been deprecated in f0d4d398e28
> (test-lib: split up and deprecate test_create_repo(), 2021-05-10).
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-op=
tion.sh
> @@ -48,11 +48,12 @@ commit_file () {
> +test_expect_success 'setup submodule' '
> +       git init sm1 &&
> +       add_file . foo &&
> +       head1=3D$(add_file sm1 foo1 foo2) &&
> +       fullhead1=3D$(cd sm1 && git rev-parse --verify HEAD)
> +'
> @@ -235,10 +236,13 @@ test_expect_success 'typechanged submodule(submodul=
e->blob)' '
> +test_expect_success 'setup submodule' '
> +       rm -f sm1 &&
> +       git init sm1 &&
> +       head6=3D$(add_file sm1 foo6 foo7) &&
> +       fullhead6=3D$(cd sm1 && git rev-parse --verify HEAD)
> +'

Nit: We now have two tests with identical titles ("setup submodule")
in this script. [1] and [2] suggested using distinct titles. Don't
know if this is worth a reroll, though.

[1]: https://lore.kernel.org/git/CAPig+cSYhY+LQ5pD+a1O16Rxwo_js45WqfcW8wtC2=
daYmNyMCQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cR+eham=3DuSamUFmTuWDhZ6_r3dnMm1z+X2=
5aw2K6maN7w@mail.gmail.com/
