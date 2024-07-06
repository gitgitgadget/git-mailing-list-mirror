Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D71C696
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248493; cv=none; b=blpag3DFPFUVzkagkZssL1Ok7BLn9W1kf/QiAEUvzMcISBHSMt2/1BC2ZOonA5oslXdXxwv0Wf12GkJqxT9Bl71IDM6rxBMh0KV8qNXLGS5XSv1jpzdHBAZx+FGn8cxkUk8SFYH7xTR7VZl50sPhPZDFKRiOl04sVro8QkrrQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248493; c=relaxed/simple;
	bh=bMzoWzInxr5t7oxEBVIklQPrMxGRua9V8IhtXCrBXeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/eMeapG7vrQlS4wDN3WhjM8cYtaQg5ELB86OoEzqpYLj8vG8pgdCImQ1wVOmUnSE5diOjDvZVkpOOAp5JTMblJOiEf3Glb5/IW/MpBeFA1ARJDz39tFSFwtvOLUUkC27d/FdQgpbOrLf7RI82jcEtTHDj5NiWn7bm8PXymOMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5d6ba7c90so11744806d6.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 23:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720248489; x=1720853289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMzoWzInxr5t7oxEBVIklQPrMxGRua9V8IhtXCrBXeI=;
        b=dDeQ5xP+Fwhiraj4/Ai+MUUtgYU35aGC05uN6/KyMFKWDxyQubyy9xaUOcfpaz2t4Y
         JnGeqUYjLZCOsKhSlXfBfGyUsZIkHQe3Ksxg0yOaM+gD2l7NPX2ZBR2eysCBiTJ8hKj3
         68lR8s01+ABonwjg7VwVpNxc4xHjf6mPGjs0xphjVg3SDg2qSWZXpuN/LbUx4PccQlTE
         Hppz655/s9aIDgWvz3BoLgbwmF7NtbfJHv9NFhdRFTXotqM+y/Inn+kTbZ8bm5Pj18Sn
         nLpVUH4URQ/DF9nYJTSF4Fz7En7HZesE6XDKE+a6irX+TiFUzyV9c5GoClrO/rkZHhvP
         YWbg==
X-Gm-Message-State: AOJu0YxHKZutv1A/jKw9TgJJrrvLcusxEn4VPQFuXlo9th1v/BGUmMun
	rzGU/0S/Y7Zop7JyOdeQVWochZpUSjd0VyAKOyQs2WuLlGL5m9bXXKFNpv+zURbeRxkXqwvJont
	jJhntWg8puP7a43lOF1fFppBL/gI=
X-Google-Smtp-Source: AGHT+IF/yJpTJPleo3VJ6axBmFemlBDkUxzwvEk4S8GrRZuJ9yIJwMzNgzAmFLLkCWsX4XZ5JcIy0xj6egEa9DxAe6U=
X-Received: by 2002:ad4:5e8d:0:b0:6b5:7d92:3dd3 with SMTP id
 6a1803df08f44-6b5ecfbddd1mr83167406d6.24.1720248489315; Fri, 05 Jul 2024
 23:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net> <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
 <20240706053105.GB698153@coredump.intra.peff.net> <CAPig+cQnZjMBPooBqMJjPY78EiCEXQOSSyHBm4GtLcbsSqZKrw@mail.gmail.com>
In-Reply-To: <CAPig+cQnZjMBPooBqMJjPY78EiCEXQOSSyHBm4GtLcbsSqZKrw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Jul 2024 02:47:57 -0400
Message-ID: <CAPig+cTSAaZmoKHRPiVkV=Jc9z_JZWmGn_JZj+Atsc4DdC7XeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 2:11=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> So, the above example simply can't work correctly given the way
> ScriptParser::parse_cmd() calls ScriptParser::check_test() as soon as
> it encounters a `test_expect_success/failure` invocation since it
> doesn't know if the heredocs have been latched at that point. To make
> it properly robust, rather than immediately calling check_test(), it
> would have to continue consuming commands, and saving the ones which
> match `test_expect_success/failure` invocation, until it finally hits
> a `\n`, and only then call check_test() with each command it saved.
> But that's probably overkill at this point considering that we never
> write code like the above, so the submitted patch[2] is probably good
> enough for now.

Of course, the more I think about it, the more I dislike relying upon
what is effectively an accident of implementation; i.e. that in the
typical case, the heredoc will already have been latched by the time
ScriptParser::parse_cmd() has identified a `test_expect_success`
command, due to the fact that ShellParser::parse_cmd() has that
special case which peeks for `\n` immediately following some other
command terminator. As such, fixing ScriptParser::parse_cmd() to only
call check_test() once it is sure that a '\n' has been encountered is
becoming more appealing, though it is of course a more invasive and
fundamental change than the posted patch.
