Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53E17C61
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580536; cv=none; b=ptCstau10Tm3A/nUhoxTL+f1BKNrDA0oSV4KRI/yz7+sFTC+dYSHQJMKHN7mEdEnrFRMl6mKLYWrlRhKwHPCDgaPQrEbgM7OSV3VNzWj7802KSO10tgjq6QeHbOkaB3ysmZw5sI7vvj+LQjl93fRjUoQ2rGGtSydLrIjlCfw070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580536; c=relaxed/simple;
	bh=i/o4tTYsdhKuMzFkvO1/3VRX8/9woLy5lMjREzVN+fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9WKy8xp0uzDbLztoJPeLJuHuRDluXPq90263+g4kNoFbxjmdXbVPpW3fhcJms43iXedQv9UmZWqLqiY0MnBiNsWF61uwjVhaQ0fk/jTLAdqHlXe1su0rXzkk8LJZDaJCZGPy5esy7F2/LzVReV6OV78kl8HqkWIt2A0IDEzjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5eb69e04cso34969256d6.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 20:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580533; x=1721185333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf0WFk28dqScgB8C9DRwJgnOIjsAr4rOd0y2e+gicug=;
        b=Vb6QbEY/6FVM5FaL6bb67HHGXjYbX1r2CJ65NR9hwJq0q4xcnEX6pzegh2J4CEWDv3
         gkY4rVfIOoSrMhoyytOd1V5UyPiakIPKFIovXtJosEQh5kIKDMhFOSG/d4sh0FsXUP74
         DFi+cZlX+IHLK56UbxIU7GyWRy33ePgQusaEsO3z4h/uI8Fvv6rpUpZpwwV5GyhFknM7
         h8VhUDxgPgoEN3fmajFdJpQxWN05P98lpIPZGEXGd8M9+kbssgiAc0WhGfVEoOQi5pe/
         9mu25HgP7gYdEhAd1a/Cjfqne08CW3OoR2v4OvWU8sf7tWXmM+eb/M1J/nZ+vrUjwXZG
         9RKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvYy+bNNpt4+Djk3k5A9i7/FoPay0gGw8Zzav6qEIfEfKL9E9dp+8amM+/+DdlpVFdp6lpbXsuDlzUxA0UY7UoiEiV
X-Gm-Message-State: AOJu0YzntFHkmYXonYK93yg6toWwAvRu2egSuruGIVKQoHsgopqKKY16
	WV8fvtOfEDjb36xZUknxoMCp7I2KW2tVwxsFzMGD92Pzs7S0nWvtyxaApwPsVTvdVXq7RbuxKvJ
	pt9DvR5emR8TfAAlwJPPTOQSiYcQ=
X-Google-Smtp-Source: AGHT+IGsWqy5fJgdNc4hig6rOlgX8m7M4PUDKCjBfi2uILILJoghjnezhCSBM4juHDZTmy5ze3dSZWj7sbh24mYP2VE=
X-Received: by 2002:a05:6214:c86:b0:6ae:116b:ef6a with SMTP id
 6a1803df08f44-6b61c1ed50amr45284006d6.60.1720580533569; Tue, 09 Jul 2024
 20:02:13 -0700 (PDT)
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
 <20240708090837.GD819809@coredump.intra.peff.net> <20240710010927.GA1529709@coredump.intra.peff.net>
In-Reply-To: <20240710010927.GA1529709@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Jul 2024 23:02:01 -0400
Message-ID: <CAPig+cRXkOesS_ctvxY2X=rwesTzgrBB0=5fvQLQsG3hZVY9TQ@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 9:09=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> The chainlint.pl parser chokes on CRLF line endings. So Windows CI
> produces:
>
>   runneradmin@fv-az1390-742 MINGW64 /d/a/git/git/t
>   # perl chainlint.pl chainlint/for-loop.test
>   'nternal error scanning character '

As far as I understand, chainlint is disabled in the Windows CI. Did
you manually re-enable it for testing? Or are you just running it
manually in the Windows CI?

> We really just want to have perl handle the line endings on read. And doi=
ng
> this works:
>
>   # PERLIO=3D:crlf perl chainlint.pl chainlint/for-loop.test
>   # chainlint: chainlint/for-loop.test
>   # chainlint: for-loop
>   [...etc, normal output...]
>
> Which gives me all sorts of questions:
>
>   - isn't crlf handling usually the default for perl builds on Windows?
>     I guess this is probably getting into weird mingw vs native Windows
>     distinctions that generally leave me perplexed.

Could be. I'm not sure how the Windows CI is provisioned, whether with
some native-compiled Perl or with msys2/mingw Perl.

>   - why wasn't this a problem before? I'm guessing again in the "weird
>     mingw stuff" hand-waving way that when we used "sed" to assemble
>     everything, it stripped the CR's in the "chainlinttmp/tests" file.
>     And in my series, that "cat" is replaced with a perl script (that
>     writes the "tests" and "expect" files together).

Assuming you manually re-enabled chaintlint in the Windows CI for this
testing or are running it manually, it may be the case that
chainlint.pl has never been run in the Windows CI. Specifically,
chainlint in Windows CI was disabled by a87e427e35 (ci: speed up
Windows phase, 2019-01-29) which predates the switchover from
chainlint.sed to chainlint.pl by d00113ec34 (t/Makefile: apply
chainlint.pl to existing self-tests, 2022-09-01). So, it's quite
possible that chainlint.pl has never run in Windows CI. But, perhaps
I'm misunderstanding or missing some piece of information.

That said, I did thoroughly test chainlint.pl on Windows using Git For
Windows, and it did run in that environment. (But if the Windows CI
environment is somehow different, then that might explain the
problem?)

>   - why doesn't "PERLIO=3D:crlf make check-chainlint" work? It seems that
>     perl spawned from "make" behaves differently. More mingw weirdness?

That could indeed be an msys2 issue. It will automatically convert
colon ":" to semicolon ";" in environment variables since the PATH
separator on Windows is ";", not ":" as it is on Unix. Moreover, the
":" to ";" switcheroo logic is not restricted only to PATH since there
are other PATH-like variables in common use, so it's applied to all
environment variables.

> I'm tempted to just do this:
>
>         while (my $path =3D $next_script->()) {
>                 $nscripts++;
>                 my $fh;
> -               unless (open($fh, "<", $path)) {
> +               unless (open($fh, "<:unix:crlf", $path)) {
>
> It feels like a hack, but it makes the parser's assumptions explicit,
> and it should just work everywhere.

Yep, if this makes it work, then it seems like a good way forward,
especially since I don't think there's any obvious way to work around
the ":" to ";" switcheroo performed by msys2.
