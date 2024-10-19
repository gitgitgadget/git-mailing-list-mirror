Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C718872A
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729314731; cv=none; b=h7UC+HjnPjpdeFDwU5pIV7tjgHUgQ/0U7pDliJSAyjY3IEXLkO0EMiTdET58jw+EF3P9UzXLTU+bxfs58biLKoWu88YRbWe9q/cHjiX1ChDwYtsjrWK1790qo2qhJP8R4W52bwsvqiLQ1LeJNczHWKx/ykwTF04lZBcY5pN6SyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729314731; c=relaxed/simple;
	bh=HYgB07UnNYpmU8zMzAkOojyXGKwmafmyBzEOUkLBwR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=um0f+XsinVmLv44lnFfY1oa8mUzueCOJp9uGGggv+EnT+aRtMUPrEPJ6RwGUPrvXHiFcK8VsA7l2XjZRTqkct98fwBuJC08o5OrD7L4+k5l/l/6s9eejBb40lCINyq1hVnnIMhxYGeH7LmyyxQ96D2siO6EEaDrUV7aofGvTY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe53e370eso2739956d6.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 22:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729314728; x=1729919528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYgB07UnNYpmU8zMzAkOojyXGKwmafmyBzEOUkLBwR0=;
        b=EItK2dTjB//OXlj0ObRPsKpnwKhdnpv2WHVzdfSZmz6eOQTjSHcgGkdGEIi3FQtEkt
         40eYdaW3U9xjCBJ/z0XodaD6/rmmJTcWlyx7/5FMxFngjABqEX1Y50Xi8IA5W3FntzHG
         04euHkgZO+Srha+zMGX40Qy7xCRO/WcyfmNuFkTUDwlT2kKmpWSvnS8M2Fc1dGq10mT7
         3DfWpm6YCzsmYf8Z+l1VMf05hBPHOyNTnuqHyPenPIhN/HCe+0TzRuFzIpnccKLNYbz2
         afUT9lmytog9KZaWr2PWdl3GwxCDamrAkT7pKbvjECRWLtE+zOa+E367yQLZV7SqjHtX
         /jvA==
X-Gm-Message-State: AOJu0Yw3DMJJOQs5F6f82iQnJI/EaUhg3vjoxDeS9XK9DgudY+YhI+ep
	2bsIFpmsBr6dbTWJHHOYTq3IWapTTeCAXQMIY/Y1Z4mTqtiCEq3fNtK9sihkL9fVUXsd60HL68h
	xAKyAL6r0I9V4B2MxRkRfQmPKvI8=
X-Google-Smtp-Source: AGHT+IHy188wLh8+wjG68i3iMCTHjvjhtSGPm8DvCnRieBrj9eRHY1ltg21kKgO8iB793oeKIAkPtX5iiv4rO3F0IFU=
X-Received: by 2002:ac8:58d4:0:b0:458:1fc5:a2ca with SMTP id
 d75a77b69052e-460aeb9bd3emr36844201cf.0.1729314728296; Fri, 18 Oct 2024
 22:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im> <542b01515e186203ea12b0a69fc1dcb619df2f73.1729254070.git.ps@pks.im>
In-Reply-To: <542b01515e186203ea12b0a69fc1dcb619df2f73.1729254070.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 19 Oct 2024 01:11:57 -0400
Message-ID: <CAPig+cTWmmDJc06Qb-OaTd6_j527dKze57viK1ppEv41NoZ9yw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 13/15] t: allow overriding build dir
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 8:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Our "test-lib.sh" assumes that our build directory is the parent
> directory of "t/". While true when using our Makefile, it's not when
> using build systems that support out-of-tree builds.
>
> In commit ee9e66e4e7 (cmake: avoid editing t/test-lib.sh, 2022-10-18),
> we have introduce support for overriding the GIT_BIULD_DIR by creating

s/GIT_BIULD_DIR/GIT_BUILD_DIR/

> the file "$GIT_BUILD_DIR/GIT-BUILD-DIR" with its contents pointing to
> the location of the build directory. The intent was to stop modifying
> "t/test-lib.sh" with the CMake build systems while allowing out-of-tree
> builds. But "$GIT_BUILD_DIR" is somewhat misleadingly named, as it in
> fact points to the _source_ directory. So while that commit solved part
> of the problem for out-of-tree builds, CMake still has to write files
> into the source tree.
>
> Solve the second part of the problem, namely not having to write any
> data into the source directory at all, by also supporting an environment
> variable that allows us to point to a different build directory. This
> allows us to perform properly self-contained out-of-tree builds.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
