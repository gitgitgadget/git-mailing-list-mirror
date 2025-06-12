Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6062F4328
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746444; cv=none; b=M4tbrI/rt6r5YlTqdsigXjancOnzQpVUQum0CuPT2UUAwdHpkyTUVsH1Ab4j8cMJWxxBPQx5xrSQVHKZ5aIScXdQp/zW+5teyhyYAbQOiPdNJQFuvEXq9YrSUBIsek9SN1lXAlCka8n9CMTj9579LuO163GiUKjz2jyjvzZ6hWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746444; c=relaxed/simple;
	bh=yu+jEgcq5bq8MzBVi8N0y7NpklsSEB7M8K0M6Ogs6WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5tL8j2tQl/eA9tZpLz5MUGiajKascXXsoSjS3vIpcdFDfiZtJBEdFImU2mGVqRz2jrpjKp7E6/LPxZfWBmGrIX7hzgejMy9Fvhvl/uD8gBxambL7PEu3dj9ip/ObMtU+5Iu5K2STTrS9rjtZypQM39pnaXL+39uwLgMC8UbG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-48d4e47eec8so1865461cf.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 09:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749746441; x=1750351241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hxyn+G+r1LxNoBwjrMbOYK0rEWv8YLi1HHa9pdM7Hs4=;
        b=fuhktK5Oj6sZAGpimxpgPen2ddAIuZ2BAMZhH5UKAxA8srPJLBZxlmFOXiLOMitEkD
         peW8AAUsqjHEJYsH7M4BOcfj+p7psO6b2lqxielBXuXnQHcAV943j4xLqHuJWdwVmUX3
         36KkKJwwlcTQMqe6nhJ7zLkzeYjT9PXrRicp0avOkdS2ocC6hD7M5/NDp5PanNFmign2
         fUq8KwI2atsbd9JxjwQQ71dsBzQatAj0TkLoyTatLpyjNgWRa0radNw35SjMQU7Kur7V
         hk5BO6WsRZMvNIGUXzc+Ek+IfoOoDl4WUMtxrcaL4Sw1XzerrCufpeuTolb+Q4ZzsKHI
         R0WQ==
X-Gm-Message-State: AOJu0YylJFyS1ZHu6xF7Zb1uHEA2xP6MGPAiMr3phAPzJjUAfvnDXjvA
	usRnnUKS/uILOlnXNH+uKC9CimSR0INnThOUMPnSH6Xszw35d7woKgzNnMt8cxGVFJJouIeUx4c
	XwS/L8HVpfROHU0AfsT1j0aZ8wVEx36UMcw==
X-Gm-Gg: ASbGncvmz65wkh+ruEaCYX6eR41rugXM07UjMaMKvkJHFlrr432GgqUg4PSL7rcgOLG
	PGTp865jSN4bwBA5mDYXbNN5rj2HS9KDmdGRCgFvQktt4V8SzHvAOcUIdpOTeFoICdQqyfBbFCm
	d7hzleYOsbw5Zc9GlJayiNG75ebSw65tyTNLlCvJ7HWg==
X-Google-Smtp-Source: AGHT+IFSrfGou5r5/oNhP8dZQ6LMd+p8DUb8olUMEF5LayNfvE1vvXYyJRgYfhveMDbgJMWi2S05p6DByCRMLiaB4U8=
X-Received: by 2002:a05:6214:1c45:b0:6fa:c6c0:47dd with SMTP id
 6a1803df08f44-6fb2c3758d9mr43453166d6.8.1749746441390; Thu, 12 Jun 2025
 09:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
 <xmqqo6utfvxu.fsf@gitster.g> <CAPig+cROcMt1crKjvqcetFNGdE4ywmD1+NO+q+MnDzctx8ewag@mail.gmail.com>
 <b2d23be73902c8433295e2a5f30b051d044e227c.camel@mad-scientist.net>
In-Reply-To: <b2d23be73902c8433295e2a5f30b051d044e227c.camel@mad-scientist.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 12 Jun 2025 12:40:29 -0400
X-Gm-Features: AX0GCFurAqmha0jKsZ1Nr4Wz514YtQIZDmEnjD5Kt5Sf4zbG4b6ualn9B4LxnuQ
Message-ID: <CAPig+cREA6YdMgbZ59eGnU8SRWmfNR8bGGvLfTQEpS4PqKm9mg@mail.gmail.com>
Subject: Re: Solaris sed
To: paul@mad-scientist.net
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 9:44=E2=80=AFAM Paul Smith <paul@mad-scientist.net>=
 wrote:
> On Thu, 2025-06-12 at 01:50 -0400, Eric Sunshine wrote:
> > Had it used the simpler:
> >
> >     echo "$foo"
> >
> > this sort of problem (forgetting the "\n") would never have occurred.
>
> Just be aware that echo is not well-standardized: many versions of echo
> accept extra options or treat certain chars specially.  So, printf
> (which IS well-standardized) is always safer unless you are 100% sure
> that the text on the echo command line is simple: cannot start with a
> "-", doesn't contain special chars like backslash, etc.
>
> For portability I (personally) always prefer printf unless I know
> exactly what the text contains (like showing a static string).

Yup, you're right. I always do the same when I can't trust the
argument to be `echo`-safe, but apparently I wasn't thinking of that
case when I wrote the email. Thanks for the dose of sanity.
