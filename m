Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE97FD
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738127945; cv=none; b=AhcqxSvuSOUMvmnvegyoapKy+6k7A8K4RVZwRbpxwwIRLsIuTeBLCHLRIg0wJgol4unNAxRsAYMJHewRXULHC7oo5FvFdFOjRfWqQ2RCZEGPKb9nY8kic6VsDAPK7aAgsOJwbYgVPgSzQmINy0Pt1ExcCYvJ/H8Oldfou95hKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738127945; c=relaxed/simple;
	bh=jFz8/3UKVBV22OGcSXxKU5G7WCKXwbgDB2RC/J8x+gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvuObduTBbYkfAFN743qMiZxcS08QLzenZdoANfaZMAaLyFhITzA9wU3s8ALm+IGIUJyKyVbgf6G3TDyLX4+2y+nJrlD40acZTEMEjM4IBWW8c/26wVLd1xNmLgK7eK+CX1n3vW23ydGQ8bxiByPvJmBKy00FPGLWOxEdndkS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGhUxPAH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGhUxPAH"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401e6efffcso6929226e87.3
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 21:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738127941; x=1738732741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/BDEgmOy2eeLpuFDkmjwQux0E0kBfr96eV9/bRIXUg=;
        b=XGhUxPAHY+1Sniqo5lW6TZ0O8lWsLHCfZCGioJCAMvLurV+KCpMNfVQp5E45wbNzls
         Bo7jACAqwfyMSirPN+umxgz2F1kUMCttQcMEjo/Z+TrLYr2X/LXmkaosWGVmBcfuXQTd
         E7A+kXu70qhBIWh2PM36GuFg3RgB3IY3xXByWf97zxzqQNJOJMw1ewqkcTMDPJSLQsDx
         3L7OCFiZRWmA+eXVbDWbe+LNEW1APWdU1c7m44mImE+HjfKSaZEgkuGsM7yK3kofK3g3
         x0OtuOE70yh0ESThTKvy+YpJcP4IaHUoj3RSvG0vEFJRF2x75tQtIMMwy6PMMgcT9gzf
         sY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738127941; x=1738732741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/BDEgmOy2eeLpuFDkmjwQux0E0kBfr96eV9/bRIXUg=;
        b=aCuV8wQ5XrGK/hnkQgumdF6hS1JX5QuGOdPqvUSvsi6R8MpdksH88xTmH2o96aKZuV
         dLxxotpPNGxs71HyONeLjg8ciYBr7mfuKBFwBPzev+OVN9zHOj8sTuvJ2IvNcmO4SZJo
         LsXe9OaHJAzXbl1hW1faSHr2bFv2C0lDqqJLlxveN3VYNvCEJ6GFRiAYxUzniQc1Cu8m
         Dk1KiVas+xFFDZd58F4cZHa/XRu45q51P++zHwzAJOjFCFgL0UiD0AuHMEWfSN4554uu
         TG0iinE5f5b0SGgAOb1DETZ6frg5TRU59WOIRZLc/r65aOF9rBUlVAsn9JAgr8h0IYjI
         mzoA==
X-Gm-Message-State: AOJu0YwP13w63yuJO8CHB1s5/ROUL05Mjkt89o0Z38SGDgG96hXe0gG/
	HiIDcBg/Qtxxqs+QOJUo9dIybMc3ibJRksoIxAvsBSp6FyicK4QpyWaEJStacxkHJIYEucFr9bB
	FfttD0Np62W302/5vYNI11MGkzmXsGOu/zZ8=
X-Gm-Gg: ASbGnctgQ8YOByvD8ePFwAbh/KCp/mY3E1Q0msdHcBviBciZDKXzdJlSG7G1qjQo1xE
	XcIKBrxAhdDK85A2vgQlnRqz3firQZITgMjWJGzS1M8QgLf/ivTw5fz1lKTDqrjSW+aeF1tsnCF
	LI+nPH6WHH+A==
X-Google-Smtp-Source: AGHT+IGVJTc/wK48+Mp7fa+ncaPc0LCDqXCnS5Lmn4Mfbvl19maWhsqrBqoYqDv7kaZXeG7mSGb4A2M75a6oQ3K0NaE=
X-Received: by 2002:ac2:4318:0:b0:542:28a9:dcac with SMTP id
 2adb3069b0e04-543e4c0184bmr409554e87.30.1738127941254; Tue, 28 Jan 2025
 21:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127103644.36627-1-meetsoni3017@gmail.com> <xmqqikq0ruuk.fsf@gitster.g>
In-Reply-To: <xmqqikq0ruuk.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 29 Jan 2025 10:48:50 +0530
X-Gm-Features: AWEUYZmP3SO3daDcUa1L51ydp5ekGdx_T8sy-SwtDXeUWaTVEYIU-k_v20O6cUM
Message-ID: <CAPhwyn3za29WwtFFJJodHXOpVRFuq8QhByE8ixjPPq9oyxfCmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] refspec: centralize refspec-related logic
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 at 23:40, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > Thank you for reviewing :)
> >
> > I've added documentation comments for various function signatures to
> > better understand what they do.
>
> Before saying all that, please help those who haven't read the
> previous round (which wasn't even v1 IIRC but RFC and may have been
> skipped by some potential reviewers) by summarizing what this series
> is about.  For other's convenience, here is a key excerpt from the
> cover letter of the previous iteration:
>
>     As Patrick pointed out in [1], the logic related to refspec is curren=
tly
>     split across multiple headers. This patch series addresses that by
>     relocating refspec-related logic from remote to refspec for improved
>     cohesion.
>
Understood.

> While I was working on an unrelated issue, I noticed that there is
> one function, "extern int valid_remote_name(const char *);" declared
> in <refspec.h> which is only about a remote and should probably be
> moved to <remote.h>; cleaning it up does not have to be part of this
> series, but since you are doing a similar clean-up effort, I thought
> you would want to be aware of it.
>
> Thanks.
Thank you for pointing this out. I=E2=80=99ll be happy to write up a patch =
after
this series is done.
