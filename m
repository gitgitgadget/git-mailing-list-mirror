Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46F524A4
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOU43ngK"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso65405161fa.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704992262; x=1705597062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o78n9aI3g8j2ZlhOJs+PJKZClqEQ+eTC5LbSNIzIAzg=;
        b=ZOU43ngK1YlZ3Zjep0HwacjDSbxLLaOKUuFCw34KUoiwEhJFRcfKiucyyMXVFzrF4E
         Cgf6TiOCfvLtKI0ipx+SuqH8k+tenoSBNxof7NDu5ffkMUg5TmWMIsi2DBlmMsQO+K35
         JXeyzDopmKGcJ+ZjfKNP1WOuFxhpewm4NNZgq3H8H+jqv5lehkRB6A5csJrWDphKgFU/
         ofY3N4HYpY/c2HSuj+wa0zr6ChFIlCf9smbyp61IZo9IVbNWivqvbEXMWCaqu1hl6O0R
         KL54CTMhh8lNgqrFXgdvx6t2ToaXNGrtdI5Oohw2Y3x+eUgM7r4VS5oxB66Uhxq43sUa
         uh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992262; x=1705597062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o78n9aI3g8j2ZlhOJs+PJKZClqEQ+eTC5LbSNIzIAzg=;
        b=LJ5T4pIAE0LZ8FfdyXTYEPMiVIQxzjNyVpufObYxzGHWR5S67TQa5O1oC/Z0FC8qs8
         tqiK/DACSjQyRh27SU6FkLs19WhRVeaQ1QLVu8VYlUYTdABe9ifeDW1w2SBHM6nHoraW
         ZvkFuNbCmCEc88cuEWzSqapzgs1isNH905Kb3AtBL/+sgf0psg2h2IXacnzooU7AZtiq
         IMz/87u4VYGxAwyL0GbGXWD3NtWq91B+/iI5eENTJisbN6+NQWYnraPSJDDiPudQFS12
         4ZaumXtpsH+bnsgV39kwLsRu4O0hedJ91q5IBCuRUsIhtNLBcDdzbdlKBgk0+KzqUaU4
         5LIw==
X-Gm-Message-State: AOJu0Yyj64gd4dJq5ZqhJ4WSMvI21YAJcBV0qKMsl2Pevi/ZRJYohnzt
	AA8GHAXgnJVJn+g+jYqrxC0TUA/trNA48TwASFK6WtnQTUY=
X-Google-Smtp-Source: AGHT+IHVk8s86JNe5A+qIpxPSIIOSVRhlWCbsln8k/4U6Lqq+hN+mqS2wm3O6gMCOUZOhcBLn1KcUBm9gzj/cKAfzMU=
X-Received: by 2002:a05:6512:3b14:b0:50e:c7b2:cc7b with SMTP id
 f20-20020a0565123b1400b0050ec7b2cc7bmr833386lfv.130.1704992261362; Thu, 11
 Jan 2024 08:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <CABPp-BH3sva=CNtx8YFGP4Egyau-hR+7njZPFEd-DRTw91BK2w@mail.gmail.com> <f5b9a57b6e2b513f1d79a93c6f0ccf45@manjaro.org>
In-Reply-To: <f5b9a57b6e2b513f1d79a93c6f0ccf45@manjaro.org>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 11 Jan 2024 08:57:28 -0800
Message-ID: <CABPp-BFWsWCGogqQ=haMsS4OhOdSwc3frcAxa6soQR5ORTceOA@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: Dragan Simic <dsimic@manjaro.org>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Wed, Jan 10, 2024 at 9:39=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-01-11 01:33, Elijah Newren wrote:
> > On Wed, Jan 10, 2024 at 1:57=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >>
> >> Thus, Git should probably follow the same approach of not converting
> >> the
> >> already existing code
> >
> > I disagree with this.  I saw significant performance improvements
> > through converting some existing Git code to Rust.  Granted, it was
> > only a small amount of code, but the performance benefits I saw
> > suggested we'd see more by also doing similar conversions elsewhere.
> > (Note that I kept the old C code and then conditionally compiled
> > either Rust or C versions of what I was converting.)
>
> Well, it's also possible that improving the old C code could also result
> in some performance improvements.  Thus, quite frankly, I don't see that
> as a valid argument to rewrite some existing C code in Rust.

Yes, and I've made many performance improvements in the C code in git.
Sometimes I make some of the code 5% or 20% faster.  Sometimes 1-3
orders of magnitude faster.  Once over 60 orders of magnitude
faster.[1]  Look around in git's history; I've done a fair amount of
performance stuff.

And I'm specifically arguing that I feel limited in some of the
performance work that can be done by remaining in C.  Part of my
reason for interest in Rust is exactly because I think it can help us
improve performance in ways that are far more difficult to achieve in
C.  And this isn't just guesswork, I've done some trials with it.
Further, I even took the time to document some of these reasons
elsewhere in this thread[2].  Arguing that some performance
improvements can be done in C is thus entirely missing the point.

If you want to dismiss the performance angle of argument for Rust, you
should take the time to address the actual reasons raised for why it
could make it easier to improve performance relative to continuing in
C.

Also, as a heads up since you seem to be relatively new to the list:
your position will probably carry more weight with others if you take
the time to understand, acknowledge, and/or address counterpoints of
the other party.  It is certainly fine to simply express some concerns
without doing so (Randall and Patrick did a good job of this in this
thread), but when you simply assert that the benefits others point out
simply don't exist (e.g. your "Quite frankly, that would _only_
complicate things and cause fragmentation." (emphasis added) from your
first email in this thread[3], and which this latest email of yours
somewhat looks like as well), others may well start applying a
discount to any positions you state.  Granted, it's totally up to you,
but I'm just giving a hint about how I think you might be able to be
more persuasive.


Hope that helps,
Elijah

[1] A couple examples: 6a5fb966720 ("Change default merge backend from
recursive to ort", 2021-08-04) and 8d92fb29270 ("dir: replace
exponential algorithm with a linear one", 2020-04-01)
[2] Footnote 6 of
https://lore.kernel.org/git/CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=3DD8ws=
CCVwqQ@mail.gmail.com/
[3] https://lore.kernel.org/git/b2651b38a4f7edaf1c5ffee72af00e46@manjaro.or=
g/
