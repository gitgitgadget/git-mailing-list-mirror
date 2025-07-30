Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4842264AB
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912548; cv=none; b=gY9WFbb4VZNzvVQKqflwNOmpR1GYnXaXlOInv1JEXveEmiOoc7duPcBgw3AWS/yNr4pPdDWbW0h1Rq1UJHt6alPJrYqF89g8v1Uy1enUjzMBb7f3W6cdWfUv6NoWG9XGNoIi9cTCYF7iERgnFWNRLds1J5L4ay9Sy4KMUM9v4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912548; c=relaxed/simple;
	bh=YwGAXMJx6crHHJ5IkepU3CvtNr/baqMXccp76vhY8eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lx3zf8bb7KXSTmeXMILEjo9b/wAMlwwitI1cvxSWNo6KVwQwkArsjUJt9cyXXcIZ0YxI0rSCbIXgzEOORNNIZ7g3uTK7oWMbL8u/7GnVxX+lqzjsAk+cnluAmNK4nqZRNUpPH113Emo7hCkCDAjqqII8iGqbBnEUUEp5dZXjCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSPWSQkE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSPWSQkE"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae708b0e83eso55166166b.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753912544; x=1754517344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD9gIO/zURLhz6C7suaWBZGic8W7FF2qChkER6MDk/E=;
        b=NSPWSQkEBzikaTStZO71G+hMrjZbSfkRsVYAyrQMiwJKCoggGKcwPyDO4nCEHLy2xi
         l+qBaXYYhat5/pwFOxEu5SjSSQQgSdX/HkttMAk1ebdn61ihDD40COLSyRefJ6ZF8t2m
         6vLbifxhrhFX5nNyI9s9WTy+TgOMh6PeBk9iEsgjEna3mCM4KlmP2Hzumx7uxZ1OdEtS
         oP2Rr6nPELyyKDVuSddUPeIQjV2oAAoeOb3yijNYm1C3KV7t0SIuy6no8f8OTGKiikVW
         YtxPBvLDrNQSiHqppCi/HQASPQnhhyqPvqEPrUZicgi0ipTfvfjVdZ+ZEjXp3Z39UKiC
         v4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753912544; x=1754517344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD9gIO/zURLhz6C7suaWBZGic8W7FF2qChkER6MDk/E=;
        b=sJDILkxX2k07ZF968L5w+Sb4dq86RV6EH++83NokRpcN9Va6L/BfP/G4jFEe82v3hz
         rRtyX983gSPmvKiDAL6HKT2W/8Fph8kGqIfMCXRW1DBJfylqdTRI995eB1cAGWHdUKcw
         i9pBvNEy3IDFDvDiyOF//ldwqV+7tYFczNlk5GgE/HD+FM1P9sZxYoYBU7AyPQB4rR69
         6SW8YjVdOxZpv4MYNipLK+7DjJQW2dP45Bf61fOAiCJhyvveqwFoU7Hb7MbU6FaqBEMm
         6O/G6ka4uevjslTte1/dupzCRmZGvvMJdotDUHW5YcHWXmetori5k9UTgiglW3T4zYI3
         NK7Q==
X-Gm-Message-State: AOJu0YzOs6238Jl6zZ0zrjzBBxaT/Ki4DmEvPdVe91Af+hprHUhh1vk0
	DRu8nES9FA3X5mNaE6EwC4CDAZtM3PXHfsR8c6gfdHVUO2Io+dq0Hi+q0Waob3IGtqvAwjcp/S/
	FufsVtWRi0IAo3huC3snUVTqWesdY9eQ=
X-Gm-Gg: ASbGncvXg0qrLoewGxrEWo+8mhEHMnF9JaQpOy0XpgmRTYTA6Wj9SYRNYWOaYoCWPEZ
	/DGhNkWHPz0qFe75BX883fTLkQUitZPzxcKyz1a8fzyBTjpCUIcw3C2WRhKXEMBoKstRRjJuYz7
	rxITNyYsh8Rf4ZrfnOgKKqmScYTq5xcBbKeEGz0s9WM1BtCu+4ZZQ0/A3WhCTyIOT+1zTD+BGpi
	zyWY0OxIEkw1hDMU9dXKe42ilNRg9BEzYeYFnaq3w==
X-Google-Smtp-Source: AGHT+IFPRGtqPyxpTKeiglmpY3G9lqbVura/ibRKW4j1eZjk/UTkmh5G3j1hZkTfDgM1juPwHKONpNenYm1wnrGwoTI=
X-Received: by 2002:a17:907:7290:b0:af2:bb2d:9b1e with SMTP id
 a640c23a62f3a-af8fd69be39mr558695166b.5.1753912543469; Wed, 30 Jul 2025
 14:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
 <20250726165320.4039-5-ben.knoble+github@gmail.com> <xmqqms8qzdd0.fsf@gitster.g>
In-Reply-To: <xmqqms8qzdd0.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 30 Jul 2025 17:55:32 -0400
X-Gm-Features: Ac12FXztKQjLB0lfqRBTuq4JnjtOuX6gEmn1DuQ_HQXKDZf8eotwTDVDkgLdG4E
Message-ID: <CALnO6CAbTjuFrLbhC24VDmdy4Utx29g92M5eYV9BPahXK+o+1A@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtins: show help on "-h"/"--help-all" with more
 than 2 arguments left
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>, 
	Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 8:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > When asking for short help on a previous command, the user may use thei=
r
> > shell history to recall a command like
> >
> >     git rebase new-base
> >
> > Then inserting "-h" after "rebase" doesn't yield the help; make it so.
>
> I doubt this is a good idea for at least two reasons.

As I said in the cover letter, I think this is the most controversial
and can be dropped. However=E2=80=A6

>  * As "git help cli" says, we should be discouraging, not
>    encouraging peope to say "git rebase new-base -h".

=E2=80=A6that's not what I'm encouraging here. Instead, it's more like belo=
w:

>  * "git rebase -h new-base" that shows help is probably a bug (think
>    what should happen with s/rebase/grep/) in the first place.

And at least according to my tests, "git grep -h new-base" still greps
rather than shows help. Compare
- "git grep -h squash" (greps squash)
- "git rebase -h @{u}" (shows help)

> If anything, we probably should fix the "-h" codepath to
>
>  - react and do the short-help only when "-h" is the only command
>    line option; with argument, it should probably barf, saying "-h
>    does not take an argument".

I think we have the first half already ("argc =3D=3D 2" in the preimage).
I'm not interested in writing the second half right now, personally,
if we end up dropping this patch, so someone else could take that up.

>  - if "-h" resulted in reported an alias, it should stop there.
>    E.g. "git -c alias.x=3Dls-files x -h" would currently invoke "git
>    ls-files -h" after reporting that 'x' is aliased to 'ls-files'.
>    If the alias is to one of our commands, it is not too risky, but
>    otherwise we should not assume it is safe to append "-h" to the
>    underlying command and run it.  Imagine
>
>    $ git -c alias.x=3D'!echo rm -rf .' x -h
>
>    and worse yet, if your alias did not have "echo" in it ;-)???
>
> The only end-user expectation we can safely assume is when they
> say,
>
>    $ git frotz -h
>
> is that they would get a help on 'frotz' without doing any harm.
> If frotz is an alias to some external command, for which we have no
> idea what it would do when we run it with "-h" appended to the
> command line, the user would be in a lot of pain if the aliased
> operation is destructive.
>

I think this is being discussed on another series, and I'll leave it there =
:)
