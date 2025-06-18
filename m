Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CC1C2324
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750290191; cv=none; b=NmHwrIWI4cUYP7EWIPXi+G5xYjcS55jgXr3gYYsSfKYHWIyEHbmvW9+6aQHSpYKBjzxSd7n6rDT7WUcpZ1V76sgQfzcXn9PNDgBJo9cs/mUVmiaSqomaAa7KV+k61J0b1jb84l67V85xvSmaxYXsMFBnj05tj3XWbI0Y3z+7d4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750290191; c=relaxed/simple;
	bh=SIyKjjrLLA1nNJ1tXU+V6FVm9ydHFstsEZLNdkBD5Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um9vTmgiNCeRguw07MBorMRCjTPhd+YjBIi7XEwNoMBrMBX/Xygvqgd1XmI4T9uXzqSqtFV9gLxfdu8Z/+OpWXmj9vMVta3Ck5mIHOkZb3ewYQbhMHOksnxh7Yqy0+yXVZ+f2NuapRtwp0GqIn5jBdz4ysnyUSX9YxW3htDG8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlxmpHdK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlxmpHdK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236192f8770so1444065ad.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750290190; x=1750894990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PVdUNbri/UkABZZLrNDM/Id89Bg6JPiE+J3o8wGued4=;
        b=jlxmpHdKdCxLolL4q6lcFCgQMy4qGFbYU3u3qrMFcfRe4gbwfVYRh/eWQJt42CEKGB
         6FNHNnqlskbg0bCvy/YMd+EJD1fPKY8eHA2khxEiXnqrvUN/ylgpTmWBd1NphM178ecl
         4ADq9Ru1xLOCDlkTLGA/jnhGWNnBoQNcUtRW93ka/Ww5p9p4PUPFGusFiGKq4mZHYU9d
         QfukrYKmUlzEEzhLrOS4O/V7zhjz6FatqfJ1kOTmzQZI1ZLBYbk54WR3PMJNkLqUq2AA
         mj1GT6IddNOqDycO7ilOuhiYv0XyOhTTScO4srmUKKrpsfOuPRe0up4pCOOWS12h/mDM
         SNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750290190; x=1750894990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVdUNbri/UkABZZLrNDM/Id89Bg6JPiE+J3o8wGued4=;
        b=GcGf0ApvYz+FnWFKSdO1yf9Dw0B6V/OKOxlGM4rKSsWYtaukFEvT21e7WjHbVZqlpf
         OIusgWiwKVNGIJVNqZVcgVvA40IlJuo825hhdP5wom2J2S5dqY6n9wTAa9eoy7xvAoGe
         ijLZddlRmGtyBMl6rABiijNDtYcUrMkuRzsfQbzh8FFAIQ9/TgA3O82t1ecEVGphITtk
         bY/VjSUvidX2Nys3lH1K1NaiDEKaIn0YyWaX1gt2HZYYmaehs1wETbU6FlpvauA/vOu1
         W8+50CODFqg3hPRGMRNauTPnEIJwYeMoUdxN9e2G62glWdfO399AazW5NwcYCyxZ32u/
         e73A==
X-Forwarded-Encrypted: i=1; AJvYcCUAETyRJiS+nS/EyHWdcxBa7etjAtTLVha02UtLdCvhEwXf8mM391E5oFStu6OWU5vT+Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHa41ueBaWYbuvfWB2APnjptNGH/rLKi1H29VOIA2SdjuCEDlN
	ukXVnFBMtkt1ic2RQbUb0036TYmG0qmR+dzevqj4bYH86oIAznb+Pw+v
X-Gm-Gg: ASbGncuWUXP8EhxttHo1MD5Vv14QttBwrPyXr58b5YAqVcAAt77OWYmd8/DJf958et0
	+LqRbtB7s7I6CLI/zU9WBnEJycAE63Pp6A9A93McMsIpvtFHqqDu9r5QBKdve6BM6w4uBc+bRzB
	YPc0WaCTKAHhwXFWzG5v1hS5kbIki7U6psf4K6NbaqWYwtRITdXdHpAgFZJuDti2EEI1RkgBN/B
	SZUUIBxiwVLKBGQO4j7OSd4pQPtuLR1TJoaOktdEqO/6G2v/fdoVyZF6sqWntgXtE4+Ce1oOKzm
	612A8nPUwv31prDy0RwA5wzaKpTkqmXVBBteo9mQy8j4bGuzjTl/IG+wWbzvZCiv1NujGhFDiLU
	LD613QrRCaJLm90Z1ztbfOjc=
X-Google-Smtp-Source: AGHT+IE6szRQfudicPfDwj2dN1GuXclhOoqOB6jc1ms0EZkpvDAhkEkQmenHuP5FoAmpB2Vp31/NXg==
X-Received: by 2002:a17:903:11cc:b0:231:e413:986c with SMTP id d9443c01a7336-237cbf33db7mr22590115ad.11.1750290189541;
        Wed, 18 Jun 2025 16:43:09 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:55ae:6bc4:8c5a:1603])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a17fasm107092705ad.65.2025.06.18.16.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 16:43:09 -0700 (PDT)
Date: Wed, 18 Jun 2025 16:43:07 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: James Duley <jagduley@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	James Duley via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ensure restore_term works correctly with DUPLEX
Message-ID: <ckzjxolc5jthge62zcm5abnssefwntc3ryu6sumpvrdontmyyq@d4ahvg5umked>
References: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
 <xmqqh60euqhc.fsf@gitster.g>
 <zpv3nkpsjqlg7evklw4ui5q7wonak2376rclu5ksmumdvk3tic@tfxmcpjmj3nw>
 <CANZAkJuPUYSCd4yGHFhs6hfERovzjwWoM2gU2MyAHvY_AtjLkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANZAkJuPUYSCd4yGHFhs6hfERovzjwWoM2gU2MyAHvY_AtjLkg@mail.gmail.com>

On Thu, Jun 19, 2025 at 08:38:29AM -0800, James Duley wrote:
> On Wed, 18 Jun 2025 at 22:07, Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
> >
> > On Tue, Jun 17, 2025 at 12:18:07PM -0800, Junio C Hamano wrote:
> > > "James Duley via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >
> > > > This is because save_term doesn't set cmode_out when not DUPLEX,
> > > > so an old version of cmode_out was being used.
> >
> > To fully address that bug though, something like the following
> > (untested) needs to be squashed on top, right?:
> >
> > ----
> > diff --git a/compat/terminal.c b/compat/terminal.c
> > index 72b184555f..8a197ffea1 100644
> > --- a/compat/terminal.c
> > +++ b/compat/terminal.c
> > @@ -279,7 +279,7 @@ void restore_term(void)
> >
> >         SetConsoleMode(hconin, cmode_in);
> >         CloseHandle(hconin);
> > -       if (hconout != INVALID_HANDLE_VALUE) {
> > +       if (cmode_out && hconout != INVALID_HANDLE_VALUE) {
> >                 SetConsoleMode(hconout, cmode_out);
> >                 CloseHandle(hconout);
> >         }
> > @@ -299,11 +299,15 @@ int save_term(enum save_term_flags flags)
> >                 hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
> >                         FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
> >                         FILE_ATTRIBUTE_NORMAL, NULL);
> > -               if (hconout == INVALID_HANDLE_VALUE)
> > +               if (hconout == INVALID_HANDLE_VALUE) {
> > +                       cmode_out = 0;
> >                         goto error;
> > +               }
> >
> >                 GetConsoleMode(hconout, &cmode_out);
> >         }
> > +       else
> > +               cmode_out = 0;
> >
> >         GetConsoleMode(hconin, &cmode_in);
> >         use_stty = 0;
> >
> > It would be nice to know, if the problem with vi that this was meant to
> > address, and that needs further changes, that are only in the git for
> > windows fork is stll relevant, so this could be cleaned further.
> >
> > Carlo
> 
> I thought about something like that, but I figured:
> * restore_term is only called if save_term is successful
> * hconout is always invalid before save_term is called

but it is not always set to invalid at the end of restore_term()
so it can't be relied upon either.

> * 0 might be a valid cmode_out that should be restored

cmode_out == 0 is not a valid mode that should be restored, and
indeed the original code was (ab)using that fact to decide if
SetConsoleMode(hcounout) would be called at all (as a proxy to
know if DUPLEX was used or not), hence why it is a bug not to
update it, as you pointed out and found unexpectally, sorry
about that.

> This is my first patch so I didn't realize git-for-windows had a
> separate fork. That makes sense now because I couldn't find where
> save_term was called from in this repo. To test this works I had
> downloaded the artifacts from
> https://github.com/git/git/actions/runs/15692373534/job/44210362705
> but is that right? If I should submit this patch to the git-for-windows
> fork, please let me know. Or, if someone, who knows what they're
> doing, wants to pick this up, they're more than welcome.

You are going to need to get the Git for Windows SDK installed to
be able to apply this patch and build your own version of GfW.

IMHO getting the change that makes "cmode_out" reliable again (which
would include both our changes) should be a good start regardless,
and at least that change could be submitted here.

Carlo
