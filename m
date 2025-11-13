Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96C350298
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038331; cv=none; b=aZwCMxegf6xhjCZO34MTcRaj2tR1mG86jmOIGeGGr0B+dePKeFbDhu02H57pEsKH5Ia2ARczhv3jXfFM2b0wUYO1QK4jOvfSXOh7HGQtZBaR6WI0Alg/IQJUYSg0QT6/aLGky584Zd5G01n8oKqx7IQJ62wf1KeYQWzfZhacOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038331; c=relaxed/simple;
	bh=2dPqIFixs5BI5l2HaNGnwy4ERb71WNLuE9gCQaSF1E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGTXAAxACSrCawPH3HoG39YyJWq2NqlEB5ljLBzhCjt5MK/3kmMVCM1z4mvghp0rGggbL645Cx0J8TziEFu0ynhuUMp7C55sXqmCgbyMaBkARRTRo5eRcWohapeSH9Vo3kaAvvC07lcb1eu5CxwUNw4GUIIC/Sc4duYNCBAlWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=CpdyMCQm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="CpdyMCQm"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b727f452fffso302440966b.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1763038325; x=1763643125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NP4phDvzAePfQrJhQ3QzQxxfTaC7/YxJ6mJzvkITSY=;
        b=CpdyMCQmd1pltu6qXSkseRj1CyA51FMkrHu9E56ncHa2tGI+ovW5/laoB+irEOBrab
         7+boWBVCSJ8LXpjWJSWO/xxq5O7iJFdhnU+9A3mcXK+bULb33QVUUQ0sw2vIKRH0vM0R
         X6oefQSAuv0twh8/aUCi3OztDxmdQG5FZRD5qcMOEM4kkdcTL7SuL3SA0WEv7X8NqSZK
         5XtmVS9IBXsGMcjU/YfyJ0RsAvgOfCxSkpn4z8u6idihhoQtrWpe3+OKkdrl7edsuLju
         TzXFXq4aw+/I2TVY9CSMX7wZMqMKJqhUu2RFqXfZ/Yn5Wg2+3Omt8AQhHk5TjVkKaB06
         PB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763038325; x=1763643125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NP4phDvzAePfQrJhQ3QzQxxfTaC7/YxJ6mJzvkITSY=;
        b=UY7ht76PtCUu7eZ+WxxlG9L01LWIHT3HEQSf9Bqpek3+FvkiXeCHN3Px5E2o1KWsy5
         snWa2/9ezRMZkFhvtMpgWk0/X/RZcEvcNbkKqm9x3JRc6BJF9M7ONg2EFv380C0MGOtf
         MNmPf6zdXGjbpYPBGIm04yBRGW4PWlQZdISIzxLvYoBIzS+DfJqPXuv4eZE7a39aIzGj
         iR87hxkCk2phlHfBhW21I2T7jdE/mTYZruxQ5U5rbsdF/CNm3d+Agqw7BoQ8vjjm6WTD
         CkxPN/mr8y/Pdb848bP8zAM0GMLSP9eP72cC4IolgJFOG4hM7siS6etaKd1TbKqUyKcd
         3x/A==
X-Forwarded-Encrypted: i=1; AJvYcCVAYIx4Q6EV9BjYI1dwlKmp9kqol/W//wTuKMy0XyC70AWyp7veQM2JxX9dxiwxOUH9DSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwozgWbAfk0LWY8fLMfe8RMKttn9sgnCrzF7FCugKo+orfXj8Qn
	GKPJm1xz3v6pn0/ZLqxk4rFRmDYrzhOrteuPbobzWwFj+k6sGIkiQRwxSezYYU5F04jZFrDwfH1
	jdAK3a3wO28VONHJJsHEICClJv82jkLUYNjsqGwDP
X-Gm-Gg: ASbGncs8qPD1nWwSAKXUpiKmziG6Yag75rCo6OUzhN9P99jsfwWlKu5EAxhAhLjUCuQ
	pPKZWzY7D0MPlSFBcV1n1+ualtHQmJFSSKNhBXsuO9ICKeO58QYLG8xwBw/9k7vP8DNN4OvauVH
	1+XBFKjRu+zDgslNyIpbkFoG9ErXHTAcSMw3sNzuFvJMDBVcrmr9Gtsp36x7zTYWcYdFsp1mcb7
	ba1QhwmZ9o3r3bWGqZz5O9SUe0t1DdNrHZf93nN3PLBMfz0gVc5Ro71l6J141IDgysiR/SOeAGk
	chMIA0Yar4jg3PgJUxgqZ8BYANpplo+9OnXKRh6gU8t1HJtqqPjLd6HVYLm6BKLz5F14TAFETwx
	8fn3K41/WzE73tgQViEBpbyxflGtSmteldtKXLQ==
X-Google-Smtp-Source: AGHT+IEzCst4gVoJqdkNFId+rlQG3srt9PpA4RBtZkQ26Y/e3e4hBPrrvvrDE04od/5Fg9/I8eq7xFWuiOUQ70dA+cI=
X-Received: by 2002:a17:907:3f9d:b0:b73:42e5:a59c with SMTP id
 a640c23a62f3a-b73486157d7mr303646066b.26.1763038325452; Thu, 13 Nov 2025
 04:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
 <2688a523-e324-41bb-858f-b32040e1e909@gmail.com> <CA+GP4bqb775U5oBbLZg1dou+THJOjTbFN+2Pq1cBPqq1SgbxHw@mail.gmail.com>
 <63d07c3c-ac4b-4ef9-ad90-d79f00cc7ca9@gmail.com>
In-Reply-To: <63d07c3c-ac4b-4ef9-ad90-d79f00cc7ca9@gmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Thu, 13 Nov 2025 13:51:53 +0100
X-Gm-Features: AWmQ_bkL7gs35ZtHG2Fq1DMjjmTntNFPbGXlQdbZ36yml0vLU8wJ7mGO8Ni9X94
Message-ID: <CA+GP4boOQ0YfKHOup4qxA2hiwA63d=61LF7jdD-=bHGTw1CfxA@mail.gmail.com>
Subject: Re: [PATCH 0/5] git-add : Respect submodule ignore=all and only add
 changes with --force
To: phillip.wood@dunelm.org.uk
Cc: Claus Schneider via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback and suggestions.

I have now implemented the --include-ignored-submodules option instead
of --force.
I have also extended the commit messages with more reasoning.

? Is it best to have a single commit with everything or a set of
commit for each part of the solution

? How do I update the patches with the modifications accordingly (
from GitGadget PR with a new /submit ) ?

Thanks in advance
Claus Schneider

On Fri, Oct 24, 2025 at 3:55=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Claus
>
> On 19/10/2025 22:39, Claus Schneider wrote:
> > On Sun, Oct 19, 2025, 17:34 Phillip Wood <phillip.wood123@gmail.com
> > <mailto:phillip.wood123@gmail.com>> wrote:
> >
> >> I was curious why, when "git add" uses the same machinery as "git diff=
"
> >> to figure out which paths need updating, it behaves differently. It
> >> turns out that add_files_to_cache() contains
> >>
> >>           rev.diffopt.flags.override_submodule_config =3D 1;
> >>
> >> which makes "git add" ignore "submodule.<name>.ignore". Tracing the
> >> history of this line, it originates from 5556808690e (add, reset: ensu=
re
> >> submodules can be added or reset, 2017-07-25) which made a deliberate
> >> choice for both "git add" and "git reset" not to behave like "git diff=
".
>
> > Thank you for your feedback and for investigating this. I was not aware=
 > of the setting that causes `add` and `reset` to override submodule
> > configuration, and I will need to look into `reset` further.
>
> You should mention the commit that added the current behavior and the
> reason it was added in the commit message where you change the behavior.
>
> > I understand the problematic aspect of not being able to add an update
> > of a submodule reference, which likely led to the overwrite setting.
> > From a Git developer's perspective, always adding it might have seemed
> > like the simplest approach.
> >
> > However, from an end-user perspective, it's not logical for `status` to
> > show nothing while `add` has an effect.
>
> I'm quite sympathetic to this view, I think you should explain this in th=
e
> commit message where you change the behavior and see what others think.
>
> > A more intuitive workflow would
> > align with how ignored files are handled even though it is already trac=
ked.
>
> As I said before do not think conflating ignoring changes to tracked file=
s
> with ignoring files is a good idea. The two are fundamentally different
> because ignored files are not tracked. I would suggest adding a new optio=
n
> such as "--include-ignored-submodules" instead of piggybacking on "--forc=
e".
> Using a different option also means that user's will not accidentally sta=
ge
> ignored files when they're trying to stage a submodule whose changes are
> normally ignored.
>
> > My patch implements what I believe should have been in the first place.
> > My implementation still needs the `overwrite=3D1` set in order to get t=
he
> > diff files list so I can 'operate' on it and make the `--force` logic
> > like the ignore files.
>
> Oh, you're right, if we want to print a warning we will need to keep
> overriding the submodule config.
>
> Hopefully someone with more experience of submodules will be able to revi=
ew
> the code soon.
>
> Thanks
>
> Phillip
