Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838C1CEEB4
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807890; cv=none; b=US61nYwgdF3/rYcto+b1tCvZ4Iz/x7jA5B0ocw/ayAaNWGpkqxAD0f7NZ8uykvI0nGFkdBCVmH3AHfDPQgGmMn6S4BlQKGLgXrROIHwQLLYDFIZXh6KbBLerkcUfqUduXMD2zck0+XrIUWR61ozjgqxZRLevsk6ZlXFvxAVOpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807890; c=relaxed/simple;
	bh=EyjucFl+LommO5XMCw7LK2VMZNKdrRSEqWg2CuLzTwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlrbTa8efZ6s/WiQLHTkNR/fn2Ue/snKAXJNdrMreiw9KPSCmOH8kc0NNTKVzZrD1VmRGUUhwTpt1CSR0VBFBc+PrqnZpCQPlBHdaiBF4zDq8xLRA3L2PJun49c5Gh4PZ5QMzv9eb6h3RNx9+G2ful9nP9MHitJqadLwlVHJsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC7rYR4J; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC7rYR4J"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so747618466b.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 14:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736807887; x=1737412687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP5PbdVua/VMOTq7eZ2zOUcCjsqsNq9vW0sSqPVe3NU=;
        b=EC7rYR4JF4SKWcBYuoD6wEFZcWKEYJT+bvv40QOQdFfETcZsFoNWBhXBMwG0RV8n9J
         wWuFJmtkUiUNWPq7QeXZB1oh+Wm6BSpSxcnL6Fqn1QQO5/8kxkmXIjaZRLpmW3bSFFuw
         RkNfTrhVNcDfP3e6H1yReYWnUnHfXrtlVlxO8GlUwerxqO0kYlP1M745H9pzyyxShbUt
         JX6nR39OMr/p1zpp1m7M4mPvGvcgNxjdT79tB4TBryvmFXhJKurRUHTJuMyc1vHmKjIe
         cxjIRX2bvCKfYU1DiJ2kVgdZKf4ZJPAzFLNciv57nXGhv4X3OlZbNig2LMPI/9ZhwjSh
         Xz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807887; x=1737412687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP5PbdVua/VMOTq7eZ2zOUcCjsqsNq9vW0sSqPVe3NU=;
        b=Da7Lsy0kQbJ6hohHNW6zzQrhXoeXQi1IEcpUq/VSiiVhb+pPpJQLdoBSs0MAMoRM92
         l/DUA9V//7dmwsNLA4yZl2ZS4/d+EEG/y3+2gO5UQ8gMJ6p/nLrQt2HWWL7hvt6x9WZd
         2LA4q9ekUMfBV3qpMU7OfNnLA/tTuXyW2ZHJQ14zPRTuzMUHhXwBRAhOJaNtleZcpisB
         Yh1jBGVYZuxdwYwgqhlEOTc4Q/muFVAyPqcqUI01vYFxXiF0QfRb43RrJ1eSbyztv3Ne
         FXswN+4We8Jgwh+SJZHzroqO5Gqb46SUlPnR1yHMOFx1AkmQXUnQ25dQSbsV7RF+wuEQ
         Gb3w==
X-Gm-Message-State: AOJu0YxP6GdD4GkxNyAuIAhlUwVdu4p3gUhSAZ/ddc6WrO3NFwGHeKwy
	C7k2bW36sFS5ubvUBBWNsjkiPPXpOCR4bKCX2hURxlTKw8k15Ehqmo9U6+yUKQc5Rm50v68820z
	eFeirpcvKefdW2UOlTW8K1MhmafehcNRR
X-Gm-Gg: ASbGnctmiFgcISvVtWBEw8YQBHAAkNftkOyV19VfRU2rXaCvoCFmt89ACiTwAuDhlhf
	lPWvOCJVH3e6swldK0g7zMAcOuisJ0NBJS7NuMZ3PYCKv3cJ86VqMgEdc8xmD4jIuaEG+Qg==
X-Google-Smtp-Source: AGHT+IEHPGNPEEsUXoHqYiIcvV7/pp8584wkRJb6Spv1JLtu7LIwweg4ZbTZ/m+OX58RCFEh+fFlQUeyVDhAl5gtRS4=
X-Received: by 2002:a17:907:7e81:b0:aac:4324:977e with SMTP id
 a640c23a62f3a-ab2ab73b67dmr1917585466b.27.1736807886806; Mon, 13 Jan 2025
 14:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
In-Reply-To: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 13 Jan 2025 17:37:55 -0500
X-Gm-Features: AbW1kvYhUeFTJ0rfFighnu56w4L77vRW3VknRY3DUWC-dMJ2YhG8jZdHFd9htek
Message-ID: <CALnO6CCLhsQbkC6nsaeiFDksbh_UAxC9igFD3r5V1Bz+YLyWaw@mail.gmail.com>
Subject: Re: [PATCH] docs: add vim syntax modeline [RFC]
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:05=E2=80=AFPM M Hickford via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: M Hickford <mirth.hickford@gmail.com>
>
> Git documentation is written in AsciiDoc. This format is easily
> mistaken for the pervasive Markdown.
>
> Add a vim modeline to help editors identify the format and provide
> syntax highlighting, rendering and autocomplete.

FWIW, Vim by default only has a single autocommand for *.txt files,
and it's to see if they are help files.

Now, there is a fallback $VIMRUNTIME/scripts.vim mechanism that
performs various "heuristic" checks, but I can't find a reference to
markdown in it either. So stock Vim treats them as "filetype=3Dtext."

>
> This makes editing the documentation easier for prospective
> contributors. This is particularly important because new contributors
> often start with documentation changes.
>
> An alternative could be to move the modeline up or down the file (the
> location is not important).

Not quite. :help modeline says

    The number of lines that are checked can be set with the 'modelines' op=
tion.
    If 'modeline' is off or 'modelines' is 0 no lines are checked.

and the default value of 'modelines' is 5.

>
> A simpler alternative could be to rename files *.adoc. This would have
> the advantage of being recognised by even more tools.

Indeed, Vim knows that *.adoc and *.asciidoc are "filetype=3Dasciidoc".

You could also see about submitting a patch to Vim to check *.txt
files for asciidoc syntax, or add your own ftdetect rules [1] that say
that files with %:p matching "git.*/Documentation" (for example) get
the filetype asciidoc.

[1]: https://vi.stackexchange.com/a/23251/10604,
https://vi.stackexchange.com/a/18493/10604,
https://vi.stackexchange.com/a/28109/10604, etc.

--=20
D. Ben Knoble
