Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864332695F
	for <git@vger.kernel.org>; Thu, 28 May 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996317; cv=pass; b=ulJL9e5VTSZ2LuMXOMk0On8JTHe/otwqayc0utCRCVCQl6CMa6/Px6tovZEhDe5fKzjyVNpeori2rcYPMJfygl76KhcwXE7i/V9jik6OnxBMuYObjqOfih9jb8S3luDa/Hw78fTAeVNekrQUCB5LcEi+OanxLLZviytB3OmYt0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996317; c=relaxed/simple;
	bh=N69ihSJQKQuKk7NfHCwcWCXiG4jyaKdjODWX9uEGPRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCRU1ADQ7UIFvNV1Deb2mb5DxccyY2ayFmv2oopGS0x5sGM3IB6BPmbeKISKyuAis3ZdqePsmfmMFzG0zQYiOgs2Zzo4gcE/27ECtJoSBixIrVO2YU1O/NhJjnRTmE7IxnL5EP6oEITaXJbF6Hvp7O5gC17g7grPaeQhSNQTsoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt5Jequj; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt5Jequj"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e61e251966so2831139a34.0
        for <git@vger.kernel.org>; Thu, 28 May 2026 12:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779996315; cv=none;
        d=google.com; s=arc-20240605;
        b=RNaCMgWDqd1AOuTHFBp5FBxdcZyryU/dxWQ5WghSFnLghQC+NB9uhttMnTJ7tU6mQS
         rQWmdWKGnkMhZfktY4NTN29EZv37iCrSp/S+irhO5f+QmK+LKAr6JaVG6o4SSDI2n6dD
         euwIvCxyeqzf2B+QXAmqmpWSBMDe5alopP7jXmhX6grUfmRSvURpWtlh6XFWjpCEj7v4
         bxkzZVz+sti/A0nkMUEAgY/P6yfH+qQjQmCGeraB8Ny9mFS6Y32sIl3SxMpb0otVzp1f
         50g4PYVQ3J+DR6Up6cLTAnThF6CDr+woi7gnuyRXRgcXruAuXiz3iCz4weLuhsr53mX6
         rYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7sdJqFbimNi4vCOVILnuXN0OwbHYNqY/FkRmagiiYg4=;
        fh=JMmuO7brvYWqrhAwyGXuH0bKGLkIdTdk3zONN/jj1T0=;
        b=i85zvRlZIcPd82WS9HUK14kyNCr3I+y0wVedkmoxAiVno/M7bHwgi4FuwlvCwXi0Aa
         WFZuww0/NBC47svEMh66m5HeoTAnutxV3qw+LnYyTj/WfvzkXsLOrkJKHDkRbeFlhais
         BeSj+pJGAjCiXhMbCmfZCy1MwhvUSnXm2ZSqZ/P/SqAaHENZdvAAdbPJqmqdM4qNI1t6
         2dhvzFpVVtLc4ToP0Wuhq5q/G8w9lfQBnIbxngHYPDYGJ2HgNAmaK2YTf+pVnjjBuKb/
         9I19Xd77GQ6tgNUozsE06QLUk9PuCuDkW2rzxoYHJXdRVZP779fN3NENY4fq3MZJiQbw
         HwuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996315; x=1780601115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sdJqFbimNi4vCOVILnuXN0OwbHYNqY/FkRmagiiYg4=;
        b=kt5JequjFrDwFtSflwZzv4iaLrJLHqDdvubYKxXzPMuyiFcVucL1wh/EapZhIBV8DU
         Ka5/lLl9ZO2HBH7+jaTmI0SqbigpLMpHLaStpASU49q4o0tW+lhQNNm4X2SiXlBP0MJJ
         UX1PwBzMYh4lR5Ld8jP6mCRL3S8YMv8lbYsxwhq+MZJHfPyBOAA6lVK89Ew2wzHzjFBp
         Esj6HqKJV1992imP+meGr4h4G+aXKmvWuFQzp6GeeTUnXmDbyzuYlcz8hyQy+DsqmQam
         Ir/X32IyO1xoQhAfZi6h8gHXvfC9Q+HoUUgbtxDSg/y5Ua40Eo4y96xvs3g/OsW14ELd
         EvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996315; x=1780601115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sdJqFbimNi4vCOVILnuXN0OwbHYNqY/FkRmagiiYg4=;
        b=o9qqq/ya3w+JDHfX25Po0myDx5O+yHS9h7DukFL/ZQMfQ6R+hBqdJE7v3C26kq9JjT
         aCRlCbEaYrIKCFIvi6S4v0xgEuQyXvJzzggWufBFPGjnc8+3Zi3tOyL25QmDlSp3R0wu
         6NIwcLioEjJHualPMmm5SM10YAraA0n65Q0ZKLu9Qs7dTYfeB22/FmV5yQNWOSpIVKWL
         /ST2Gpk1kZfazJE6eBVydOwiNE8/Z8U9eUjBdBEsp2pKo5BQvkT0yUuZdr+OO6e9vBJQ
         8OMyu5ZhCI1CNhMWqjkP0xY4sx4aV5riK89PV2KRWsWQzieaUuoN/Mwq8f+gtn9AkUnu
         WYaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+a/HYNnjR4UxC3puA7XIGdsIeNSQW3+c7DvPFJQSJmBoneu08XOa6NSGmBAjQ0b+RQ2Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUczUEEAgnMvEn2CMsNCNkESmG8q7AC4xaKuOaMxlS1jIIv/85
	MSwGDl24ZhSkM8s8zRsxcz65Q37uvYqDloH0z6QEbmCkIYp/p8YgU5ZP2nFEZBM7AT50WsqJdMc
	Crd7081PlmXrlfQtPGhE7361O2UwQYDH4nuPO
X-Gm-Gg: Acq92OHmg49KzZmVyCFznAxiTjGN+m2SKlZxByRrGENhlchvnx+5l6HZ3WKqjwj8uIX
	x1p4y4IFtvBn+spvzJ1z6D8I5g7Q4lgp7aBpOwckG4aWBM0ae8NSE5IfiiGiShT5OLmrG18+9zS
	t4tmxBuRayBu2sBX4M8T8g8FMsdfciOP+TMaC/5wNX6qWVuVK9Ppk3UWV6/81/0Za9Xi0MMe2HT
	+bXGbt513Z9WIX9OsuoQhkKCtL4MAtcWgjI0E+Z4yXJQNBOJq9DlgGhr3X/6q1LTynz8kBlJ2DV
	Hx2QTwDHKYsQhJK68/FXsUT1w0vMK7SltOervUutdl9e9WEjf8A=
X-Received: by 2002:a05:6820:1625:b0:69d:a224:6ee7 with SMTP id
 006d021491bc7-69df738dc2amr1800338eaf.54.1779996314707; Thu, 28 May 2026
 12:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g> <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
 <89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org> <CAC2Qwm+BLNf-2kvePKNF-FKQX3raOBzSRmwd0ZEdzmo8TqkMGA@mail.gmail.com>
 <CAPx1Gvd_FqnsjCkpAA5uy7aDz9oQnWx7WTvKk-kLWemkqF9PsQ@mail.gmail.com>
 <xmqqo6ic8564.fsf@gitster.g> <CAC2QwmLXk=CXNo8+Ja0fL5pN1YYMTkh7XHAUwN1c9VxuFhyy4Q@mail.gmail.com>
In-Reply-To: <CAC2QwmLXk=CXNo8+Ja0fL5pN1YYMTkh7XHAUwN1c9VxuFhyy4Q@mail.gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 28 May 2026 12:25:01 -0700
X-Gm-Features: AVHnY4LXj44K9vKGcjOLudzxYn2oUWQ8vzPOsxAtVwAIa7POYTroWqo7rj9bx84
Message-ID: <CAC2QwmKjr2eiFNPPmERq7n-UjE-SF2vE4eHDanYE-4heWxzQVw@mail.gmail.com>
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>, Johannes Sixt <j6t@kdbg.org>, vincent@vinc17.net, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 1:21=E2=80=AFPM Michael Montalbo <mmontalbo@gmail.c=
om> wrote:
>
> On Mon, May 18, 2026 at 8:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Chris Torek <chris.torek@gmail.com> writes:
> >
> > > Call it an "implementation note" (or, if you like, a "practical
> > > consideration"?).
> > > Something along these lines might work...
> > >
> > >   Implementation Note
> > >
> > >   The --word-diff option currently operates by taking the same
> > >   line by line diff that you get without the option, then massaging
> > >   the result into a word-by-word difference. This may cause an
> > >   unnecessarily-larger diff than you would see with a more-clever
> > >   implementation. If and when Git acquires a more-clever
> > >   implementation, the output may change. Note that this is
> > >   similar to the --diff-algorithm option, which may change the
> > >   output.
> > >
> > >   Regardless of which algorithm is used, _any_ diff simply shows
> > >   _a_ way to achieve some particular change. It's impossible for
> > >   any algorithm to tell whether someone deleted two lines and
> > >   then put one back exactly as it appeared earlier, saving the
> > >   resulting text, vs deleting a single line, for instance. Only a
> > >   keystroke-by-keystroke logger would be able to tell what the
> > >   human operator actually typed into some editor. Git does
> > >   not have that information, and having it is not desired.
> > >
> > > Chris
> >
> > I understand your frustration in the second paragraph ;-) but let's
> > not go there.  The first paragraph is excellent.  It gives readers a
> > clear enough explanation to understand what is happening and stop
> > complaining where there is nothing to complain about (which is
> > already hinted by the "Note that" at the end).
> >
>
> Thanks for the ideas, Chris. Here is my attempt at synthesizing Chris'
> suggestions and Junio's feedback:
>
>   The `--word-diff` option operates by taking the same line-by-line
>   diff that is produced without the option and computing
>   word-by-word changes within each hunk.  This may produce a
>   larger diff than a dedicated word-diff tool would.  If Git
>   acquires a different implementation in the future, the output
>   may change.  Note that this is similar to the `--diff-algorithm`
>   option, which may also change the output.
>
> Does this work?

Updated the patch with the revised wording:
https://lore.kernel.org/git/pull.2113.git.1778686956622.gitgitgadget@gmail.=
com/T/#t

Please feel free to pick up, modify, or drop as appropriate.
