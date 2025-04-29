Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F482777E2
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909224; cv=none; b=oCIM8EWLxEGiLPlScR3hlfFIQ9jZ8vAmnMWfIRYVL3STCVukYe0hbFYQzQtlVnaDO0QuQb5WpWv63ehpBJnUSqUDzCbzmGCwbHYy6OUB1XYyS+Ro8mqBQdHQDslde2oE4P+LL/Of2kFBMA7Zjza5GB6DiGnsOTuT8nYkizbmrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909224; c=relaxed/simple;
	bh=Y22LUbY4HOpubOnJ59EFTBL+xOpT01VYkw+SbIY+nlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjqYgcR/xdJrAZBZswuTsFAptd7fyq+dOqjrU/Z81SCb/DlmmMIo2l9lbQGl7iiiU2/Dib7yy7EBMTqUr+ddE3XIRtdfnVA2fnLFz4hifI/qg+6QBFJkhPtjRfWO9HOKgeljlxSH069BRQyBt8YbKlSPUfUGpOUppQsQIbCGLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arujvI0c; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arujvI0c"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7080dd5fe92so46765967b3.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909221; x=1746514021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gt33JNk51OEdgfW49F/EJsu0SPRx58lIxlUxOH59HU=;
        b=arujvI0cdX8Sj0WQJc8TnjhVC7VRo6kge4kgyTTlciW0r3my7wztJ0ie3xfBLL06fr
         3fU7/n3eLwkDO87kXXK7Fale7a4O/1/dNd7zkk1jn+tjzMSTQX3GLaWRQKmDSCmD1rCc
         s8KYYlWrOh8lc8RPkbhSmQWCAc0oFXyRiItc+yig+8aviNWEfLixafta6YmZv8magu4a
         Ah+ougq8W6hd3LCnkMXzpQ3mxYkLoVFBh2pYcizNeN6Q7xaIUtkw6LUbah1Kqvpw4kjB
         /VPfaz2v3CiIayV8tAM7kVtW1s1YnztO3Oz4kM1A00/oEc0Lbjpzu0/snJWA4S40WwzH
         bZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909221; x=1746514021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Gt33JNk51OEdgfW49F/EJsu0SPRx58lIxlUxOH59HU=;
        b=pfqRt54Nl/pQR2hO4WC/7aIJy/XvPj1+bydN1WC5+/kRLRaIQ1glsArKxImGuynpS1
         iKQYLqv4301NNdiWpad8pKU1DnaaKNdFxknx2fP6Txpm4MmOvTdEmNO2K4hhrgEV0K7u
         HDcHOdD+gSHkPtbulw8JSIXUoGpaGWIhRq5EVoPlyMSfigF0q76jYjtG1JaPtARPe/u5
         2houuimFVlAO3Yj80IEue5Gi/m99qCY+rT4OdZ4JNg0qLOo+hKkqAuvfDsuIA5tnxp/3
         1HmglGoHR12VDP5O+jwXo/mbLfhwA9f23P1M/IHSh6MnzbsMPvf7JsDOD3TP01qlwHcZ
         7+uA==
X-Gm-Message-State: AOJu0Yy6q7y3/dOXCnHXnCXt8a/t859WDbowqtg1BMJBMuTygWQ6pztF
	Q6KXOVzhjrRHQmvWC6NQCRLu3Z0Ia6eL0bIB87Q4R8zx+pHJCLjAbFRHD8A3kDpFwsO+iMNTmJt
	Yr7O6VvkLwvEcgRaGUHDCsk7NzChpGMaTkb2+HxTH
X-Gm-Gg: ASbGncsmdCqtqQMQfCgzIFHx1Nap9mYgtuCFAsYN6KuMunz8FaI0WWxAXH2hD3QPQvO
	X8oyqBYVstCN0JxrL5tfew9sOCCQ1LAorNdas60WyWizINBm3ncWHOQT7ONQuA4AIElmWb3hPXi
	Ulf4RNB3BJCHlMckAqh+wNg7g=
X-Google-Smtp-Source: AGHT+IFixfTlvm3PGTzyJWLx27C0oD/0NOm2foQgS8YCeqROzPDOWQR1a4ssWMjk1FkOVfIN6vqxQDrLE4gMBF5kQJE=
X-Received: by 2002:a05:690c:6f8c:b0:703:aea2:6bbb with SMTP id
 00721157ae682-70899778c52mr37651217b3.31.1745909221140; Mon, 28 Apr 2025
 23:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427185351.82520-1-kuforiji98@gmail.com> <20250427185351.82520-2-kuforiji98@gmail.com>
 <xmqqa57zamuw.fsf@gitster.g>
In-Reply-To: <xmqqa57zamuw.fsf@gitster.g>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Tue, 29 Apr 2025 07:46:50 +0100
X-Gm-Features: ATxdqUEQvI0BS1RLhkBML5hIWcuVo_scDZvMJ8N0EdlxgE5LVfZEVxwzXrUjcws
Message-ID: <CAGedMtfwA2vqOFxjLnusvFNcwKpTCLq38bZYBz-9cpzFmbhUdQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Apr 2025 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> > Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
> > required for the reftable-related test files to run efficeintly. In the
> > current implementation these functions are designed to conform with our
> > homegrown unit-testing structure. So in other to convert the reftable
> > test files, there is need for a clar specific implementation of these
> > helper functions.
> >
> > type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++)`
> > Adapt functions in lib-reftable.{c,h} to use clar. These functions
> > conform with the clar testing framework and become available for all
> > reftable-related test files implemented using the clar testing
> > framework, which requires them. This will be used by subsequent commits.
> >
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > ---
> >  Makefile                    |  4 ++--
> >  t/meson.build               |  4 ++--
> >  t/unit-tests/lib-reftable.c | 26 +++++++++++++-------------
> >  t/unit-tests/lib-reftable.h |  6 +++---
> >  4 files changed, 20 insertions(+), 20 deletions(-)
>
> With this step (and nothing else, as this is the first patch in the
> series) applied to 'master', I see tons of these errors:
>
>     CC t/unit-tests/t-reftable-merged.o
> t/unit-tests/t-reftable-merged.c: In function 'merged_table_from_records':
> t/unit-tests/t-reftable-merged.c:37:17: error: implicit declaration of function 't_reftable_write_to_buf'; did you mean 'cl_reftable_write_to_buf'? [-Wimplicit-function-declaration]
>    37 |                 t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~
>       |                 cl_reftable_write_to_buf
>

Hi Junio,

Yes, that is expected, as there are `reftable` test files that depend
on the old function names. I navigated this by temporarily porting the
functions into the `t/unit-tests/unit-test{c,h}` file to convert the
files and moved them back as soon as I was done converting them. Would
it be better to leave them in `t/unit-tests/unit-test{c,h}` and then
create a final patch that migrates them into the
`t/unit-tests/lib-reftable{c,h} file?

Thanks
Seyi
