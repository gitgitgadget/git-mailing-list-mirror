Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1C2D47E5
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918273; cv=none; b=jl5fVys6UzGqwdVFS0v4B5Pnwet7WYTxoMek9Lw9Do9gO+qsk2XrZwZxq+6g2SL6GAApL+XrdmxKCKUDnoGtK5Ni27JEYOymBtMEqJ7UuWezehg4NpHEzKE55K49/2V7o5LQPvS/YejzX0MGZDMW+fnxt+T1yI60WsUkLCKMpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918273; c=relaxed/simple;
	bh=aIQANwN7PIk0QWE8W3bEziUMauaro0oteqU0OshDGPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFsVIL8ynNgKtyWrx8/3FZlJmV0Sd3rCya8Mh/mfVHebPz/c7QrjTx1V2LczLh8mByA+j46ZjinQRdClW5cRLHDqI1psFksQ0e9PvPPSeye0tnbv5j5O7Qd+vyQT2GoKxf7/bRUtsEhmBHg5ntDLOlNgUan8RDd7TDe5zhEc+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-71ec78d0c18so33986d6.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918270; x=1757523070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eq/MWE31VpLjIQhuHxonB/zZ2dJuHUU+9eFc6JvAgY=;
        b=uffZebNzv39W4EFnbtabiFh0fzg+a5qpe66EGjkJq/zyYIQDqbrDvcaIfcP7Pv5s/v
         LNX5Jw/I7hhplJmMubzbLYPbtICjY7F8pArey9rsI2TA4wFu2jTwSyEx/7y3w87U4iKO
         QO4s1mvUsnYnuG6JoGa7xf+a+JEBvHawpmlL8xjKtlN7+XU2+6LgRBcfj4Scjt91dpLf
         Xez65qhKg9751DkYhKY140aP3qSuXT7Fm66A2VuKpjZgAPdVUj5dgDQ5v3zcKOnEKnM1
         daHIeLg3bwGH7zLVQaQY93ZpP9VBdOS9Tw+lqW33Oq0RnMWLWgtWpwieTp0w5HSLihsy
         c6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW8FTYrDANNbuVvBWEgPyRo93szkEJOHdqCprKjJ6RRBlt3tz72LpCtUwsMUoWJLE56ZYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFz0YM3KkhWuugHfQ8fxA9Arab2DUJ+VHnwu11i+d72kSjm+K
	veUdtVqDhWzioaCRKHOzrk3urf6aEP7fZUfB33BtPUmfdrKhQZ+DW3bO3PkS7aNUrwXa8qqhqgs
	8TXAGNAU7GX7U+Cmx7pgV34E2okq1E91OVg==
X-Gm-Gg: ASbGnctFD8Ev92t5xUpePmY/57LLqOghf+wRIWJW0tvesE87vcwtv23BbKtSGPc6qSu
	ffeWQjYh23H/FoBYWnur5CQe4DF22Vr5sNle88K/BCMEE5od0vPoFEPxqqnsEX6lXGhUSd0zvEm
	+cYFUrJw+bsUJIeSYnC6NZMdPfPMYghiS1mslCJnbf5NQKDGSvaO6cGaafqCyI6nEYFucqYQTfs
	xeEew==
X-Google-Smtp-Source: AGHT+IFv2Er+oDUL7la3xY17s5p315922EWpDvHqFlmi7snyWHvx83hleF1QjKDPOro/MMhOKFY1iwf4S9saalq0odU=
X-Received: by 2002:ad4:5f8a:0:b0:721:cf8c:cb24 with SMTP id
 6a1803df08f44-721cf8cd83cmr43471846d6.8.1756918270181; Wed, 03 Sep 2025
 09:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756311355.git.code@khaugsbakk.name> <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com> <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g> <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
In-Reply-To: <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 3 Sep 2025 12:50:58 -0400
X-Gm-Features: Ac12FXxhfu1RKZDpigwVhHB1WIr-2a4q7vO1iQu1fiTB4aCkuLgUbzjSSXhq_0g
Message-ID: <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:27=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> On Wed, Aug 27, 2025 at 5:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > That's still inviting unnecessary emails, isn't it? It would probably
> > > be better add the qualification that people should send the email onl=
y
> > > if they were unable to find any workable replacement. Perhaps:
> > >
> > >     - send an email to <git@...> to let us know
> > >       that you still use this command and were unable
> > >       to determine a suitable replacement
> >
> > In practice, people will respond to such an instruction by always
> > sending an e-mail.  Asking others who sound as if they are promising
> > to give answers when asked is cheaper than investigating themselves
>
> Thanks for pointing out that my final editing made my suggested
> wording too succinct. What I really had in mind -- in conjunction with
> Kristoffer's patch [2/4] which provides hint(s) for replacing the
> command being retired -- was to reference the provided hints. So,
> something like this:
>
>   - send an email to <...> to let us know
>     that you still use this command and were unable
>     to determine a suitable replacement using the hints
>     provided here

I realize that the changes made by this series are not in any released
version yet, but from reading the emails still arriving which argue
for retaining the command for reasons of muscle memory or because of
its (strong) mnemonic value, I suspect that the hint(s) this series
adds may not be complete enough. In particular, the advice this series
adds (use `git log --raw --no-merges`) seems to be primarily aimed at
scripted use of the command. But the muscle memory and mnemonic
arguments suggest that advice should be given for interactive use, as
well, such as proposing that the user can create an alias.
