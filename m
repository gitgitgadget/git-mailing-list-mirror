Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109049F130
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308704; cv=pass; b=TZZMzDQV4/aN0yve3ArkLFuFcqCwT6h4rCJJM6tlccElB2sutJPM6wz62sPp2Z/V49/jjHE86i1kK6xX9dPoqtKSCZ14KpoPZt1vxi0FUS4hRAoGQ2899FlMm2fnyR8N8Iju5valmOECQ/x5hcjzfGuUpMKUxIejlMY02a5a28Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308704; c=relaxed/simple;
	bh=TnDZyGsRzErj9Qne5T6P25NHzXHxcoM+kaNZak368Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5fMu1u1s5/bdScVgkFzgMcVFUzxMbCZf0JjLH2CBOBoncUhkpnqhX5P0UQAAZnq9Hvr0wEc3z0TGehHGIA1ZSgqeCqyzC9BpKYZkOlnIbfcxhwYSdCmhBKCbc9S/OK1QolNB3piBTEVWOaHvGlfdqGGF6Mz11IEE1/M5YkoN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXyOe7e8; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXyOe7e8"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-988d33f8fc1so413274241.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 10:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791308701; cv=none;
        d=google.com; s=arc-20260327;
        b=CJr4zqxF613kXa/cbvTMX1ImwIqRRnkyLE1G2pxoahrz2jD18qLTLI4laXBPd4855p
         r1K3BduPO9UbiPkBEShRn257OluBMIsPdOVewp5DdkzinRxL8jvQcduDYf9aYuvBbYDe
         7zau511kOFLjwduHqXu1LbyjuJJ6Q9lasbcUF7UqIvkrNnF4viwji+lbxweerwfGvU/A
         S1eVPLKPtCJc6ak5ZnBFn7SD8ZQ1YnIiqNmZAZvBZbntTWSjrA2Dp0BnVYnvpk6FJ8Dj
         bo0lV1jcviENU+55pLOTvL04HgCkFI41iqKo6m+FAgqGac+giLdZqadqFXJkhlST2eUl
         wP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHhcHH0GR6DuQPWNRjpTz839ecJClTNivrkyQuPZgfM=;
        fh=US49SmSqGmr+7RyudMU+Uago+u3Y/PygyzSf8TN+5gQ=;
        b=Zp0oG+/iN+Z+OKpWsGgUvFWGiBRZCthBjPZR075y4u9HDw3ZOZ0wFvy3p7qOPvfw1A
         g7lGIGVm0pV6gWoi2EpjPlU6ca0qqYzj0PH8ipwebmdWr2ejHdonBNU6Yt22HeW/aBUy
         i33kVjfdM4j1rSXs+mryYdVUbgS6l9TyoEEmTRg4j8qLYNRtV8Ht6URePPQvCKtTMQTB
         VhuBpc70AzzsMZL0n78q7CE3O5mlhD8GfUUwr2vUavSfwYCkeTbj1rpH9iWfQpzC7VjG
         PoQ0gHAd8Dwq9s3cwF7WekkvzOzpL+TG6v5/7r+Mq+CIJSd4IyTe6dlcxFKb+ae9x6mK
         hAwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791308701; x=1791913501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fHhcHH0GR6DuQPWNRjpTz839ecJClTNivrkyQuPZgfM=;
        b=jXyOe7e8XSkdQb58Q9+VGfcNwhPdkBFn5CVZ6GY1JxP08ltpzJc9C2LYHOLX1eksG3
         C1LiphvnUQ9wIOtOP5y3c92OJ3U4o0ME8UHajUjb16KBB2nYr/Wj8VCRkxAKDsgc0anv
         m1JTi/6xFMOnBwin2uwF15VdXoMSjcHWBG5Us9vOheuSMuTAjuIq42xM6d1S/5C9TwRv
         0Jxn4/0G1zToIriFIGccxQeY7QRpJNou4n9FDAbAfN1TSs+ZuLu6KJUFqxf8BbFvvSvn
         xvqfhAoYyEOQgoPVwQ+X/crBSFPGgdWllOmO1T8zOMQhpoiMvLWirhBAEpFctHYR0WOf
         I6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308701; x=1791913501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHhcHH0GR6DuQPWNRjpTz839ecJClTNivrkyQuPZgfM=;
        b=vFNWKl00Cxo/iTniuniY88zexWvoHKP3+X/edufJelQRmCTctVdItN6f+zx/pwb46a
         uK+qpHdvxhI0FBkd8Cb5dQw4hichM9bqq2xlqaoCxoHm4KnwZlTcrtek/tKt7dG7kljh
         U+57C4V0rteqNASI2GnBeMZdMeOGdGrak3QAIO1cZpGtDAYDVgNP2Wh4vSDtx6gc+JiA
         xG/8r3aAYeu4VSKOPWjs0snQf8AxcYorqCkCaqsMmzi1JdaEZLn9xWBwLtWr+G1m1vPe
         2rqpm0jIzQholSF9KgwPhBIlBmaS+ivyndGK7AjY9fD9UC0I5TZBcyM5YMDpGqkNYsaG
         uDRw==
X-Forwarded-Encrypted: i=1; AKwUvByrFypQbvkOTIEw5C6EBy8Gx29tfOoPwRufSgrqo2ZrkKf6QM1bwDzTwSXCfhF5EK9zxLs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZF/RLVCZlN/fUINl6u7Iw1fK2V6tg5yCxZx93uboDJGXZvd8Q
	st7jD2eHXAR7HcA39HowGo3AD2h+yfIurTzsFOEKK66GUvLGBCawJo3teJ0NIGuRbeg5tWzUsMo
	T2pNoLOk7jZ0yDdo3eHzz8cdz8ZbAVkQ=
X-Gm-Gg: AYBFou3p4XwWmLL8r6qXLeMPfWCniGIZdRbqex577MaJ7phuxz7NcyVeVBb9sKob1G/
	4lbKOR9nchWRRZnjFcoLez4Fz0gMNighP47btjA26FDalC+TwXVaBfR1MyJRAKBzE2kflGo2qjy
	b8drUKxDv9ykYgaZuuwhsPN2HJYYA9Gf4xLH+h00ETf8f46JJnF1PepTq6K43TUWgubMh5LvVzK
	OPM3qZIt/ZmYoAssLxyJwxgoOMJ6hA3j6TwzXzgSMBHiJ/pmFzhaPENFYQ72hHLWTC5iOMoGuUn
	1kiHQaOnM2JT7EpqEJojaYcjgJbcHIlUovTmTropOSMulXx0VjWDoXeIv8FuUYz4s6ohbzLZcRn
	HA3KGYLfJEnY=
X-Received: by 2002:a05:6102:3712:b0:7c2:7a0:ae28 with SMTP id
 ada2fe7eead31-7c87c6e3e85mr709082137.30.1791308701373; Tue, 06 Oct 2026
 10:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
 <b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
 <xmqq1phdavik.fsf@gitster.g> <CAGHpTBJKaTURMJmJ6W4iiCAy3-M2YWb48rF8GMoEPCfpGcE=QA@mail.gmail.com>
 <CAGHpTBLvZGAaqkue47Ne9DHPSwxx4fPo5KusP5=sh3C2AxgAMA@mail.gmail.com> <xmqqy0d47oaq.fsf@gitster.g>
In-Reply-To: <xmqqy0d47oaq.fsf@gitster.g>
From: Orgad Shaneh <orgads@gmail.com>
Date: Tue, 6 Oct 2026 20:44:46 +0300
X-Gm-Features: AclHuK91SgBdMbR7d91kcokd2ctK2BELs5HDTVun8lwhAaGdhXkQuOm--ZP8EWg
Message-ID: <CAGHpTB+5_pL38sDL1aTVmYm0xPP_pSLMpyY+qPjyMnAC3pVxvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: clobber existing tags with --prune-tags
To: Junio C Hamano <gitster@pobox.com>
Cc: Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Orgad Shaneh <orgad.shaneh@audiocodes.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Orgad Shaneh <orgads@gmail.com> writes:
>
> > On Thu, Mar 26, 2026 at 9:57=E2=80=AFAM Orgad Shaneh <orgads@gmail.com>=
 wrote:
> >>
> >> On Sat, Mar 21, 2026 at 8:27=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >> >
> >> > None of the steps we see in the added test do not seem to check that
> >> > --prune-tags does clobber existing tag that no longer exists on the
> >> > other side.  It only checks the "git fetch" command exits with
> >> > status 0, but does not see if the tag actually went away after the
> >> > operation is done.
> >>
> >> In these tests, the tag is being replaced rather than deleted. Existin=
g
> >> tests for the pruning mechanism itself are located in t/t5510-fetch.sh=
.
> >>
> >> Would you like me to add a check for the tag content itself to verify
> >> the update? I suppose I should do the same for the existing test cases
> >> in that block as well.
> >
> > Junio?
>
> Sorry, but I do not have 6 month old discussions in my context
> window, so no immediate comment.  I'll respond only after I swap the
> context back in but not today (yet).

Maybe today? ;)

- Orgad
