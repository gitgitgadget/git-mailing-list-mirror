Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA662E851
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469880; cv=none; b=FR7fqHkWtZSJq8EflD2m2ZVl0ZZ2XwkkgaqG5O8nRLMcoh+57ntlI1cvB9sR8Y88YaOCTV8R7oCYs0VqykajML5c1NaloIaZVcDDoY+S11r/NveeWqzJiabgE6+8FPMrDSA5j71CdBKWScMLkrmZ1orarWVw1K6TkCsQcatk3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469880; c=relaxed/simple;
	bh=fCbmIPeDPI2WxwTDdMepyNX2z/V+IAN1HlU0F7r+iv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnSFH/znqevB0KWfOG5qfp0FkgaM5qAfqAQY9LjHfUGgJ0ERg+UCrIR7HL5twG7cckOdoSadsfdumO3qDnmwuv5mbxXudMMWAoy621D11Gy2iMyguTl32NY2+KLY1zFGYbKK8uml4dAzdp2IzaOZiTKEnGu8hvGUC3lK6PXDJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b5f90373d4so25785186d6.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 13:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469877; x=1721074677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7y22GVntKS4sm4JzEwj6o2K/ecFLCNXDxSLWRshmIw=;
        b=Sp8zpt6nWk7n93AL3j3hav+KsLWPrijDW7A+bMpdGh/AmQF3E9+XFdyCrUf5EZVr1I
         cB14pM+81COKe/H9QOoZegrAjSCzBI63LjyjEPAGPGQpa8KQC1IFoj+3UrW7rNns0Cdl
         M9L/U1KXorI9RFxSEtcUj812glZXycMid4okvaPOT5MxZCi/7OON16FEo6pe05UYyHxL
         AHBgozLI/TfkGAZBo8ZkUygB8Yz0QtwswjR5cnNxX0DFKe6RwIwkWV9kP2X9sCg4TPED
         XSucryhNYD4Bsqpsu7tUWDJwYeC9enUVicsZEuLhYhlYv7ZkyLy3TRkwYEQRc5CWTZX1
         Z5qw==
X-Forwarded-Encrypted: i=1; AJvYcCXWl+1q53qNhkE/t8HwrTvXq02gylHBnESnK+ab9Q/hpe0sGqzpNVCswvs4Yz0h6wCmgERyoOkJoMuNUDwK851rfy+d
X-Gm-Message-State: AOJu0YzWEOxXUsaFaXhrqSEVwyJDP7PBDagzKv4W8n+CoAtvEjZIBZPP
	dcmAyAMFoQya+K9WyEuCThY/JQoFoxdROK/gT855+gqZHVKUnAdYNfnjwnqnLQxeh2/oBlKJr0h
	BM+VvWcit9rnoJAwUPG9uyfmp9tA=
X-Google-Smtp-Source: AGHT+IFI2fss7XmQcuQfPoyO7dPh4AmJx/KevgOQ8YXA3jAbLOnGHlZAWPF1AHlIpzhn88cpC5u7kMT5JFcOFeWbAIQ=
X-Received: by 2002:ad4:4f10:0:b0:6b5:2c82:7d7d with SMTP id
 6a1803df08f44-6b61da71233mr4989476d6.24.1720469877132; Mon, 08 Jul 2024
 13:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net> <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g> <20240706231128.GA746087@coredump.intra.peff.net>
 <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>
 <20240708090837.GD819809@coredump.intra.peff.net> <CAPig+cRzJXPa07wBXibCjfZ_uYtbAnRnOsXFrbMbCqRfwSxszg@mail.gmail.com>
In-Reply-To: <CAPig+cRzJXPa07wBXibCjfZ_uYtbAnRnOsXFrbMbCqRfwSxszg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Jul 2024 16:17:46 -0400
Message-ID: <CAPig+cTUsLHnCKcVMGTGUFXX85bDgMOAuvb6uXmDqpB3XswHcQ@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:46=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> On Mon, Jul 8, 2024 at 5:08=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> > I took a look at running each test individually. It's surprisingly quit=
e
> > a bit slower! About 4s instead of 200ms.
>
> I'm not surprised. As currently implemented, `make test` chainlints
> the self-tests and the Git test scripts unconditionally, even if none
> of them have changed. As I understand it, =C3=86var idea was that the
> costly initial `make test` would be offset by subsequent `make test`
> invocations since `make` will only recheck the self-test files and Git
> test scripts if they have been changed. His particular use-case, as I
> recall, was when running the full `make test` repeatedly, such as with
> `git rebase --exec 'make test' HEAD~n` to ensure that the entire test
> suite passes for each patch of a multi-patch series prior to
> submitting the series; the repeated cost of linting unchanged files
> adds up, especially when the series is long.

By the way, regarding your 4s instead of 200ms result, I don't think
that is necessarily reflective of what can be achieved. In particular,
to properly measure the effect, you also need to remove all the
threading support from chainlint.pl since using "ithreads" adds a
not-insignificant amount of time to script startup, especially on
Windows, but even on Unix it is quite noticeable.

To test this, I think you can just replace this block:

    unless ($Config{useithreads} && eval {
        require threads; threads->import();
        require Thread::Queue; Thread::Queue->import();
        1;
        }) {
        push(@stats, check_script(1, sub { shift(@scripts); }, sub {
print(@_); }));
        show_stats($start_time, \@stats) if $show_stats;
        exit(exit_code(\@stats));
    }

with:

    if (1) {
        push(@stats, check_script(1, sub { shift(@scripts); }, sub {
print(@_); }));
        show_stats($start_time, \@stats) if $show_stats;
        exit(exit_code(\@stats));
    }
