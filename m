Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54938146D49
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457549; cv=none; b=qNGQ1mFBsM6WvULLTtabCOXs+fqS8PeylL9hQ8a8dyhTSlz33dbLtekYg8xYuwNIiXlEYM3rCh2nkHKxKFlcIcaovbJ+wx34bHy29G6rtoT7WccuuiYseJGhN2rrBkgColHmi6US/I1n/cIQ3C1n2nTyxfQFyrM5WYAEkNCoR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457549; c=relaxed/simple;
	bh=myJRPnGYmGkM1r4UBgUhdh9k41wH5L3yQiAXAKc8PBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhizxD9g7JdKbOMKDw3zn6pnfqeCaJPgbSBH/hxOePvPytn3R7bozZdEe8ngTGb/R1ccd+5Hv+0WGYEDXV/mKUEoVrN3eeSc/mF5Q9QfkYCACyU1ZPcNTCj5Au+1dVIKZ5NAlSmuUmF3WLKH0hnXuB9ezTI9y7oYd1U2mboMnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-651961563d6so33399157b3.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 09:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457546; x=1721062346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myJRPnGYmGkM1r4UBgUhdh9k41wH5L3yQiAXAKc8PBU=;
        b=Cxhi9ZBrtma/bg3nmePyu4X8mjRj8C1X6BfUkQn1nJLV7Wdda2h68EtSeiG1j5ZSMr
         9L9xYrKf9FQYOkHwYVcZYwIZhqsxyzIVOqEYSwEmvDPammNjmNY4QEdK+O2B0u1ZgUrm
         WhhrBnWzCLygt2Fdb0Df0LQ2vbLWi2o5jEN8OPY/QmT2iNFnDIfWRoOM5iI3FBwlXyVy
         qb2RLITVvPROke6+MDBebowlIiPoffY3s7Ga2LMOKPCT3cKEbTGfDxdPkTBOZ8JXjwPC
         y/Qw5h0Or3n1ReXyChicmCvgF1WPaGHVfLf3iagMw8CWRCzW82txIfZfeVoAOdOwYGsI
         W5kA==
X-Gm-Message-State: AOJu0Yw7FXFpOnvVzzhjX7Uze2JnszBd68WMbeinIwO5b42rXX0T16c4
	5XdsG3M1k9gZkv3RvjYS3xab43mFhgE/syeMqhhYPSVhKqlCD0oHUjEN1yQWyfS1aQmfmvCbnIU
	PXKWCBvS7u+GgEAMr61nnGWREZx27ZoOp
X-Google-Smtp-Source: AGHT+IFUe2f7Af7NP6S1dpK8aWGI+8nwgKswm9z5yo+V1XIB0ZK3Rq9QGC66mgi20JOLzuEQP6eMFBk24Jg+I22/khA=
X-Received: by 2002:a81:5cc1:0:b0:630:f6b0:6c3d with SMTP id
 00721157ae682-658ef249721mr3228597b3.23.1720457546115; Mon, 08 Jul 2024
 09:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
In-Reply-To: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Jul 2024 12:52:14 -0400
Message-ID: <CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com>
Subject: Re: FR: Provide Out-Of-Tree Building; Provide Cross-Compile Parameters
To: Nathan Royce <nroycea+kernel@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:38=E2=80=AFPM Nathan Royce <nroycea+kernel@gmail.=
com> wrote:
> For projects I built, up to the git project (think LFS steps
> (altered)), they've all provided OOT builds so the source directory
> remains pristine (albeit those that needed autoconf to be run for
> `configure` generation).
>
> They've also all provided `--{build,host,target,with-sysroot}=3D`
> parameters for ease of cross-compiling.
>
> Looking at what the git project offers, and I'm not seeing either feature=
s.
>
> Looking at the Makefile, I see mention of `HOST_CPU` which looks
> pertinent, but being able to point to the path of the target root for
> files to link is important and I'm not noticing anything for that.
>
> Grepping through Documentation for `HOST_CPU` comes up with nothing.

Indeed, HOST_CPU was chosen intentionally for compatibility with
`autotools` in the event that support for cross-compilation was ever
added[*].

A few years ago, I had started adding cross-compilation support to the
project but never finished the task. I'm pretty sure I still have the
patches sitting around somewhere. I'll look for them, but I'm not sure
how much they will help. Aside from the obvious patch adding
`config.guess` and `config.sub`, I recall creating a patch to fool
`autoconf` into not demanding that the project also carry the bunch of
other scripts/tools `autoconf` normally wants (since we don't use
those tools in our build process).

[*] https://lore.kernel.org/git/20171209094310.GA60808@flurp.local/
