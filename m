Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CFF2459F2
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754151032; cv=none; b=ReCPN/ff6jS1cHrsemxlcU5ZKzKTLyxCyU4dPLk7MSXL4sZcR+zRcjoONu0mT5Rtj/qZj8KqJ1ubcBviyjH7ih3Ip+IhZL7o6RWWBwKEoABKCnRaObHVuk9igq+RtTrm88cs/Wl12bNR3QGbBTrqdqK6G2PZs2TLYgik3Kd0qPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754151032; c=relaxed/simple;
	bh=EErPOm9XZ+RAJM9q88JlPhAzYq/m2+f8eemW/KKvdvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGdk6VHKOTp7dHskU6lTYp4E+6KE46goewoWFCt2X/J/2XUrHM7UcHyBnx80nM0uzgoWvwXlpvK6UcCuKQQMi3kwvUSeRXzR/qcgaxBmOOA7jv19NFb/ZjMteVEn1zyy+8ft1sI/+tZguauHNy1IPv+pOqyDM1iL7S4MRHUSoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erpol7Mw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erpol7Mw"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae9c2754a00so752919666b.2
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754151029; x=1754755829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZjuPI/YrzOub1ILAa1KJ8ZPbDfsmBajwgH9tN1t0P4=;
        b=Erpol7MwsR1nEQlJOM3Wu6Gz/TZctUo1bwzeMQKC7m/9D0eVOTL0mnSLJAzcAEP2DE
         bBPbWjzrv7llrCFdifR9Ljj0BYhpiAd3i6WmnyaR4bWtnP22mQWfbNr2hka2cFyW9Uw3
         7GKMnj6Qttvs60CjPW2GwXEg+zjE5JjlAt/NdrGt0vMqYaS8Z+p8yU5zRQuERbMYlHpm
         UaFauOiFc6JwhypXIE7QpUGzOA5DhVB3ILmnNwshm1J/fC6k2i6wQMa2H1lYl8+tpK9r
         1QmpWcihrZU5YNDbKfch9Kuq1sGHUOlmN9X8YQ/WfF2JSwvsS0lZSfle7ivsoQfhYRTX
         JWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754151029; x=1754755829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZjuPI/YrzOub1ILAa1KJ8ZPbDfsmBajwgH9tN1t0P4=;
        b=eNSs6H2iI5BuICL6AAEsWpMnkBwmVu4ioicKWhH7CkFu/I+8PW8jYsR8jDI0k8PKYM
         WG4MaPC0QnANndah/fkkuzf0U5bKU/naDUM6Sxo6PRwzdkog+SdrDBFS0TUutf9RxDi1
         Oo10fz+PXwloIBsqEgzds8gmLhY2CK+9SBgK0HnnXSVbV8BqxQrVyxnGp6Y8E67ZmioZ
         FvD4zRl9lzp6ljdiX9rapzDRlMSNYlz95cutwKdHWVP94NERl90k7kqDcS772WGDCzso
         u3TIVrxvwDD94syBkPkdo1JsY+N9kkPUc17qU3CsBuHpkj2rHPfjh0AEwB7tk3HDlY6K
         LXEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/voLpbR3Wfg5vMNwnS4tVjUy1ogYOTYIXrMyOTYj6/oRJ/qV/B+o2mHs9pC5JL98rtSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDTwt6uxv3NQrcEQp7lwM5hiblKFTFlAVuCzCpTiIUwm7bRwq
	IWetYVXdlPQfqFWIKC875pzdN96fVQAuGdLHHk/IxGIK0nhacpkP7g8y9egF4aOvGA21yMGsbXr
	0rTjYcnMzOzvUd8fFKm8gp0xQDY5zfq8=
X-Gm-Gg: ASbGncucKWFJhCpkeYUwJbtndEypV/0oP2JyFpU04wT8u8ghBt4QLypWv1xcCZP3qqu
	pMWElfFs+lHufSNGOVs4vqoMWKK4PpKZkzFS1J5kk/cV4YKGeiPnazqEaf7hf0OMot4F1ZLjsUV
	o4f0X6WUO/5MJCrRMMubUFbDgDZMJjsOSJYhZfkpSWQ3QHpMVdOkCe0bPknkNDgp3MzkGHQ4s42
	xRX6eYxrGaC9xHViI3cRuZtOqj+eYMRujSSVM0VBg==
X-Google-Smtp-Source: AGHT+IEMnKwRII+sQz7z8ODnCtP4ALUWkWxIgEqQsH4SG9LUmwvezuVxPMxSkwHMCVaZ60t1dnR1rras7C5oYkvDpds=
X-Received: by 2002:a17:906:c10b:b0:af9:3d0a:f37d with SMTP id
 a640c23a62f3a-af9401679d4mr397751766b.37.1754151029019; Sat, 02 Aug 2025
 09:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
 <20250726165320.4039-5-ben.knoble+github@gmail.com> <xmqqms8qzdd0.fsf@gitster.g>
 <CALnO6CAbTjuFrLbhC24VDmdy4Utx29g92M5eYV9BPahXK+o+1A@mail.gmail.com> <20250802092331.GA3721454@coredump.intra.peff.net>
In-Reply-To: <20250802092331.GA3721454@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sat, 2 Aug 2025 12:10:17 -0400
X-Gm-Features: Ac12FXwhM90cTTDueyu_Fz5jTQhqekFYT8-sGZiYU4jcSX7UHmT9ozZhoTgkMQo
Message-ID: <CALnO6CD_=ksmXrzS-k5rQukYcMSDLm0HSLZ35xP-Y1neKc70Xw@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtins: show help on "-h"/"--help-all" with more
 than 2 arguments left
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 5:23=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 30, 2025 at 05:55:32PM -0400, D. Ben Knoble wrote:
>
> > >  * "git rebase -h new-base" that shows help is probably a bug (think
> > >    what should happen with s/rebase/grep/) in the first place.
> >
> > And at least according to my tests, "git grep -h new-base" still greps
> > rather than shows help. Compare
> > - "git grep -h squash" (greps squash)
> > - "git rebase -h @{u}" (shows help)
>
> I was somewhat surprised that grep would still work, looking at the
> diff. The reason is that it does not call any of the touched functions,
> but instead relies on this line in parse-options to trigger help:
>
>   $ git grep -A2 'lone -h'
>   parse-options.c:                /* lone -h asks for help */
>   parse-options.c-                if (internal_help && ctx->total =3D=3D =
1 && !strcmp(arg + 1, "h"))
>   parse-options.c-                        goto show_usage;
>
> rather than any of the if_asked functions you touched. So I think there
> may be two problems:
>
>   1. You didn't touch this spot in the parse-options code. Would you
>      need to for it to be consistent with the non-parse-options callers
>      that use the if_asked functions?
>
>   2. We can only get here if we make it past the help check in
>      run_builtin(), that you do modify in your patch. That works for
>      git-grep because it does not use RUN_SETUP, and calls
>      parse_options() before checking whether we are in a repository.
>
>      So in run_builtin() we do set "help" to 1, but it does nothing
>      without the RUN_SETUP flag. But imagine a hypothetical git-foo that
>      takes a "-h" option and does require a repository. It would set the
>      RUN_SETUP flag, and then:
>
>        git foo -h bar
>
>      would show the help before we even get into cmd_foo() to parse the
>      options.

I think I need to consider both questions in parallel: as you point
out, this patch probably doesn't work for a hypothetical command that
both needs a repository and has a "-h" option. (I note that ls-remote
also is RUN_SETUP_GENTLY, like grep). Since no such command exists
today, we /could/ take some version of this patch and refine later if
a command needs both RUN_SETUP and a "-h" option. Or we could reject
this patch (assuming there's no workaround for now). Given Junio's
concern, I'm inclined to just drop the patch from the series=E2=80=A6

=E2=80=A6which moots question 1, I think. OTOH, if we keep the patch, it do=
es
seem like we might want the parse-options API to be consistent.
Fortunately, I don't think this area needs adjusted for 3/4 based on
the tests.

>
> BTW, I applied your patch 4 manually to dig into this. I wasn't able to
> apply the whole series. It doesn't go on top of the current 'master',
> and applying with "am -3" mentions "sha1 information is lacking or
> useless". Did you build this on some other unpublished series?
>
> -Peff

The base is published and mentioned in the cover letter [1]; if I can
make that more explicit in any way going forward, please let me know!

[1]: https://lore.kernel.org/git/20250726165320.4039-1-ben.knoble+github@gm=
ail.com/
