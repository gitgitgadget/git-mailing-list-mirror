Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F2140E38
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736527; cv=none; b=BF17tqxCPqpSMejOKkIGgOIPICwRHlefG/9G5Pd9x5zXpIhAAa5CRTMXlR/cGcwhu5Ex41CcnqVpmQIje5bbbbx/7qzOy2ZjrC/24hNoRNRF35SdTIsBG+zPjG4HieNx1+pO4WQtv1j61BxonIM2AaZzA6C5AmKqpJlJRTkXsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736527; c=relaxed/simple;
	bh=P90fbOfKJRt5t1wdmJ0LZ0jo5Iy/464hDJNW23LsoaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXMzrxYUT9S4hL2xNpxIZKfy3NyqPDyCM0Sq8r0leoC8MDqx3TVd/R3OrblfFydPrediBttrhGj3xqgfbWQqarXOZ5t+hvmzZmRYMyt0ic+wu6hYJQfgOie9CF9y8e/wXXEKu3C0VAKkndl2XdquJ5cmgYo8T1X9cznXv0smObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d41a4736d8so264606d6.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 11:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732736524; x=1733341324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAXPWqa3922tTe6VjS6Eny9w/b7rGlHO6cDroqp/2oE=;
        b=J1QpqO2q5JZqrhA2aqJU+IQUCT/PhG/rKsuFc0dAevEf3WeTpCQnCDPfc1QnKIHNSw
         DovnGqD3EfAxDVEvBx6xVEB629dRm8tI5YIcv3pG75m05ruD6WpRVSx/8Rsze6d3Yldu
         xzj6Kr09OMtme3ZPKAXaA2E57kGqW559cBXhp5EEvOo0/RshlNVOa7g9jmZ3k6j6YbN1
         +1Ib6wWBSiNY9A8yJv/O6dwgPj2kWUFcx5P+20kslLhXhZqD/bLNHaESEWIUI8WJdnQ/
         p9xGTy96kpyHiu7Yd6Km/9grP9trDBXslU1BSrzKyYr9fwLg1TDP6K5viFjvlrv9rwwT
         Uw0A==
X-Forwarded-Encrypted: i=1; AJvYcCWQFNAE0GmgiXbJ9T7frHolAzzJhnQZiHI1Wvdhkd0IDuFgx5Hf+o/Y4otBYCdvPdqBAn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhf44I2lD6vVWygNoQ8uYF4kIfUSaYil6sHSwDzjNVi9ChYs72
	J8A1AqeOGz+jbHU1EiBEQgb76yEESGo3wKHB3KxUtxaLVix25naDdj5ab8mtb00OBAipTYol3gf
	8ch5UJ8Sk3QfCrawgswjrxt0vuoY=
X-Gm-Gg: ASbGncuFl77Twl8WHZDPkBKJbLXjp7WnnJFsJ5l9sLnHdM64PAavRbcRYFiA4GOgB/G
	QJBBdIAsaY/DwSU5H15m7Spa4AadWXg==
X-Google-Smtp-Source: AGHT+IEd7wciHIee67zgno3MRxhxmiNfkZSdvWISaef6OZ0q+UWs2GnIqpoUEXU0hgZjoDkljzCGQEeCB3EZNpeBbkU=
X-Received: by 2002:a05:6214:2aab:b0:6cc:2295:8724 with SMTP id
 6a1803df08f44-6d864d2a17amr23895906d6.5.1732736524027; Wed, 27 Nov 2024
 11:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
 <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com> <79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
 <xmqq1pywvmhq.fsf_-_@gitster.g>
In-Reply-To: <xmqq1pywvmhq.fsf_-_@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 27 Nov 2024 14:41:53 -0500
Message-ID: <CAPig+cR+-QCjoobdaMf_t5AJGxxXqbCkn9UeiPMQFvAt2T6kxQ@mail.gmail.com>
Subject: Re: Re* [PATCH v2] fast-import: disallow "." and ".." path components
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 8:23=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> [PATCH] CodingGuidelines: a handful of error message guidelines
>
> It is more efficient to have something in the coding guidelines
> document to point at, when we want to review and comment on a new
> message in the codebase to make sure it "fits" in the set of
> existing messages.
>
> Let's write down established best practice we are aware of.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuideli=
nes
> @@ -703,16 +703,22 @@ Program Output
>  Error Messages
>
> - - Do not end error messages with a full stop.
> + - Do not end a single-sentence error message with a full stop.
>
>   - Do not capitalize the first word, only because it is the first word
> -   in the message ("unable to open %s", not "Unable to open %s").  But
> +   in the message ("unable to open '%s'", not "Unable to open '%s'").  B=
ut
>     "SHA-3 not supported" is fine, because the reason the first word is
>     capitalized is not because it is at the beginning of the sentence,
>     but because the word would be spelled in capital letters even when
>     it appeared in the middle of the sentence.
>
> - - Say what the error is first ("cannot open %s", not "%s: cannot open")
> + - Say what the error is first ("cannot open '%s'", not "%s: cannot open=
").
> +
> + - Enclose the subject of an error inside a pair of single quotes,
> +   e.g. `die(_("unable to open '%s'"), path)`.

These changes all seem fine.

> + - Unless there is a compelling reason not to, error messages should
> +   be marked for `_("translation")`.

We might want to spell this out more fully, such as stating that
messages from porcelain commands should be marked for translation, but
messages in plumbing should not. Also, perhaps mention explicitly that
BUG("message") should not be marked for translation since they are
intended to be read by Git developers, not by end-users.
