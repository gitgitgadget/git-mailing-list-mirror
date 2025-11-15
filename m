Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF86212564
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209565; cv=none; b=KsP9Rcaok/Su0XvWFhdon90IbzmVLQU74z3EDrzx5EeZjvM/rlvZcJaIDyiCnjK2WW3kD+MhdOTI0VgGLVzhuYiiSw3ykSRljrlCQL8bLEEb8xfD5elmxOjsAW0DY3/9fxtOg+j8sVha188ozaSA3X1X7775ur5ZEgYmgUgTBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209565; c=relaxed/simple;
	bh=smu5AaiS+BE3ioWxe2kCjiUF86UOp//6ISPpj0SrNXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYiIoBrkD98bu+1fOQJ98/jELtPH4qzLLY7njXQiagej1sn96WQmDzU1HbOz5moza0Ny3IMLWTRShA4sKGkxfGviwkv3WlCvPyORwWxgPDalTATwtTOE7zjUXoV2YGg6JFLNDWjW1foY6cr2ETR7NdqOGG5pUo4ajJGSyOBVTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCi0Ov7t; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCi0Ov7t"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so2547244d50.3
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 04:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763209563; x=1763814363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyCncDNuIxIH3545ACWUvvj8mQuAl5sS16ORfy73MMc=;
        b=NCi0Ov7tyPh3zTlBP/HzSxPeS2/zvypTi0Xk/tiPiNFMpJtfXDSIiu4o7zRfRjc93u
         B1JU2Fzc+oTt3cg/rGFNM3ZF6K/pyghn7WWh9yPmB45u8o+9d4ljxR/EiF67IxNAZMCB
         48OTN8+Yl2y/kZzsyGgysm5ohi46RU0rZzsMkoLndpZmC6HjcCz4p4wNKr6dG3ueRh4N
         vsYFjli85f/jJuAqhbAWGFN0JO75YNmeG4tHj0xopob5oFGij1pU6EzVjUALu8iFDbNu
         Lfyyy+RqzJd6pPk+6DlocNy3K60XJFeQ6u6TskQvXrohj29ZnFPEXyY6XgqmF6Y4xOv5
         erRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763209563; x=1763814363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MyCncDNuIxIH3545ACWUvvj8mQuAl5sS16ORfy73MMc=;
        b=HgMNrF+KtYlXAIcyR5RLKZqgzKVxLFyvVqGAtIRhJRU1ha6k3XzBFESPUniKFzBUwW
         58lMQsPK+Kzd9ShUTTudhTuUHAZHkT0N8MS+3m7wdFZ2O8s3Rg1t9gXFzDApIRiJBF2R
         Cz2KxRhq7NPe+D6jRvA3UZW862kczPUp68BWqvleb17m7bOs0t9BjLmEUnE97XHhAIMu
         9wdc0JnHlkYD64iaZiua7+VSvIqrFjjhS5Go5brlzJUMKHBHUbsZPycQy4RKwonlrQbd
         z8bsgXCiEAlAFh21Szs/2l6F5wB6FVwbdqehmaPWxKLga2H5YiPFQgzZ9vycBXvgSbHr
         o7Ww==
X-Gm-Message-State: AOJu0YypzxiC5xIl/0jXD10ZxTmO6KrFfUB+CKP8Qy//9bJ08k/twSS2
	6Izq0Olk9lPr5p9n6YL2v2z1lQ/UKgiXgXJ2HtR9LxKP6I8wl5lrR0DVYTla//1re/xzgvO9wew
	QpWL23/mWtjuVM4zySJ2YTZihaWXGM7w=
X-Gm-Gg: ASbGncv3czRTTrxrh0GIqxdND9LcHz2lGOhIcdSAdiw/06+huiPvejywre8N8wk4seM
	GEBJBU0nUvh9mCEq46nwZBMOK6P0v/1v+erYw/MKYo2U/pCD6oNBSIpbf1LfVOm66d9SZmUZcO2
	JjVKH+uNynmVSQqXo14zgQAV+97XkJpDk0eZSJyyqJ9uO3trPjk685JO/vmXmlj4b1wvmaX7peb
	VRhXRt2Aau8kE0q4J0H+C/HnvEA74mvRNJfm7xRxlCWIAcdb6WqVXrJ6ag/SYaa+Pk39/8d
X-Google-Smtp-Source: AGHT+IH7kzKl99XczCE1J5abwXf95g2vOhtODZiQ//IUOAkmdRwxXFerY0jHLCGgWsIZ3LhLGHvN4mrh8rysD940lb8=
X-Received: by 2002:a53:b10a:0:b0:640:d038:faef with SMTP id
 956f58d0204a3-641e74ab9f2mr4706962d50.9.1763209562626; Sat, 15 Nov 2025
 04:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763098804.git.worldhello.net@gmail.com>
 <8cb5d668-783f-4400-89b4-35054a6cbea0@app.fastmail.com> <CANYiYbGyGKy=S6a3NJFyrv-bOZos+BXdR=nPXDT3W_dGxeiNPA@mail.gmail.com>
 <xmqqecq0ifld.fsf@gitster.g>
In-Reply-To: <xmqqecq0ifld.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sat, 15 Nov 2025 20:25:51 +0800
X-Gm-Features: AWmQ_blWqkEeDN2DXJULyWE2AZ4Dy-jgsBjyzR-kiTY2NLEjtx5BJGRj9N9oSAA
Message-ID: <CANYiYbGqLyZ9zvhR73z91yo2Yk-tT1LVcP--uEdaKL1hHJOEHA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix misaligned output of git repo structure
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> >> Is `Co-developed-by` supposed to have a different meaning than the mor=
e
> >> common `Co-authored-by`?
> >
> > This is a very good question.
> >
> > **Background**
> >
> > At Alibaba Cloud, our development team uses a variety of AI coding tool=
s,
> > including Cursor, Claude Code, Gemini-CLI, Lingma, and Qoder, etc. To
> > measure adoption=E2=80=94specifically, how many developers are using AI=
 coding
> > tools and how much code is AI-generated=E2=80=94we needed a unified tra=
cking
> > mechanism compatible with all these tools. I chose to implement a git
> > commit-msg hook that automatically detects the AI coding tool responsib=
le
> > for a commit based on environment variables at commit time.
>
> In other words, addition of this is solely to help corporations like
> Alibaba to measure which AI tools are used (and what correlation
> there are between success rate of the patches and the tools that
> generated them, etc..
>
> What is in it for us?  What benefit are we getting in exchange for
> tolerating these additional trailer lines in our log messages?
>
> A few random thoughts about generated contents:

Regardless of whether the trailer used in commits to identify AI
coding tools was leaked intentionally or unintentionally, the
following insights are extremely valuable=E2=80=94thank you!

I=E2=80=99ll add the appropriate configuration to disable the commit-msg
hook=E2=80=99s automatic modification of commit messages for git.git
repositories, and I=E2=80=99ll review any AI-generated code more carefully,
if present.

--
Jiang Xin
