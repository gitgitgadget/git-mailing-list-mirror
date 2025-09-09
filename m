Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1B1F30A4
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402811; cv=none; b=ryCup6E+HdhhtLBSTzW/fXA9Dr7z9jmWmVIiWNUZj1Hr1Bh+MjYW1F+ncI45+Spzwy++Kplgfvk5w3g9yv3LCB9vIt+aMHbpQ+I40yd/fYBA1YxxyVUPAnY6ON72/v5FDvT5OA/Rr5sSvFYzhQoDwSe2pr2de8SzmMWUY5q2ofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402811; c=relaxed/simple;
	bh=NP+kLhN/OzFgCkKs3eLQSylW6+auKTwSQWsWNedWixU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJsWrdhGxbK0V9lUKwsCZ9DbSTboWZMrHjXEOP2g9sAU1d7nPdNJ0vF0zlhqHcPhJt766yztXSfj/ccPeG439iLI9T3tx3cML7S5oWKO2AI35CiA+mJR7xMyOFGz9jmdGlBsKvDcpjOT2yo1HXBvmzt69nf/NQoHOdh5iaMpVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjmhYYrQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjmhYYrQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so8420152a12.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757402807; x=1758007607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFI6S+nwAhWbGmhdiYt6nI3VZeIN1drbjxoNJsbl6pM=;
        b=BjmhYYrQTgeXuuCbV07uPZtigkyBErNhLMMit9gtRKddS71FoI402neOtGKNbqBAHG
         vmJnk6gmJQEGaTWx6BiqoD/8UwJ2N5o4cXQakTJzfCZi5wXZQweiKJhxz36tq3dHEP0t
         e9oYQUT8lTOD8aGDVpNNDZ60BvkcPcOnVesw49QUcCkBUV3GipeBdE9/dfoKTDiJ3Pp8
         mhgXxnbxMbVhg+RL7/wwXFY3rUxOfnEuua06pcF+ObC+IeRrP1Zxjop2XbrexjN0bWVY
         4Gfmm428IP24GQLT9L4Fk6i1zWH6uhAjQn90E1sQ9jTD4ScWbZoqhdXP/eDbROfSh77C
         i1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402807; x=1758007607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFI6S+nwAhWbGmhdiYt6nI3VZeIN1drbjxoNJsbl6pM=;
        b=JJdJTjwlIE47Rylrjikm75BnAMu0z5Rfh+2fRHTg8ORdOzXPSufOT2Z1zMDzNrEIsm
         +Pw/iMRTu7fMAV7MQuqZncJiTOdpL71mNqwYLveiu3yNCg9uLXl254kg38yF5A+bmPYe
         9CEqAfpqDPrt7HJYMZWr2uGMQxJOfVcUOiikpGH2ZgoO+3sc4HaXsYadcFq3nIgaLo8E
         4NbbojPQ2mDy4rIdWCLVtVzvPC6736WofqoXFy6Q7OZlDanwVfAVAZDH/vqo0fF73N0B
         tbfkWk8LDpAna7GrlbhxbOwJVYVQhrpLTn+uB9Pb/oLEUZ39Rf7hcTCaSf9lWDa657Gm
         D4VA==
X-Gm-Message-State: AOJu0YwoC0r+YHP3IVLTZegD9dhHqqq3jnstE6bmuaggatOcdMb/ebF0
	EPFSyQe05H6yWS4jYiaUef6oIHVn53f+/zO3DGg6Apr78J51u+fVU3beA/DbC1qipBlYhW3sIxc
	q4JeoWjRKyiomHIOvKQ0aub32k2dFM9w=
X-Gm-Gg: ASbGncukkbXjRFIhNwjaU7mqy3NHiwiNYi3sRboiMGJLjWwkfmNQcKwksxH+CkVI8+B
	ZrU0DyiM9KEzBE60/t6AoAeZPppjzigsesoAVedb+imrEv17L/t13GXmMKJv/Igz/no9AM+8+lM
	NJFLosDK83PUdk1N6uCMarCQD4Y6WzCikzHX5fFhFErFsaPIPsJVUvulfVwvlu3qTyBsSYP2jQK
	pz4WVPk9Q==
X-Google-Smtp-Source: AGHT+IHCyQ3IUo3/vIy+6OT0NPuSxgoGHa+jKLJrbjOPJatDswpdp8VEKKx3eiDASQbs2Zp2BVX6i6luhtqCHPSa2ZE=
X-Received: by 2002:a05:6402:24d3:b0:615:ad47:58c6 with SMTP id
 4fb4d7f45d1cf-62380d72a73mr8111702a12.30.1757402806735; Tue, 09 Sep 2025
 00:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-3-siddharthasthana31@gmail.com> <CAP8UFD3Db-n3CY=KBpn-2Nt=SYY=5ckF3J_4ho6C19SVcrfdsQ@mail.gmail.com>
 <7f90e1b6-acba-40f2-9e51-ad09c2bf6999@gmail.com>
In-Reply-To: <7f90e1b6-acba-40f2-9e51-ad09c2bf6999@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Sep 2025 09:26:33 +0200
X-Gm-Features: AS18NWAaqiX0S4C9tVMWUpeGW95AT6dOt8M0oiaAbNruiHHxf1iuSDZsroc4ReA
Message-ID: <CAP8UFD1J8fgjZ+din3P_=FjZZFJ+ocqvwTFjBNjpnhrx6=nMqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siddharth,

On Tue, Sep 9, 2025 at 8:36=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> On 08/09/25 11:30, Christian Couder wrote:
> > On Mon, Sep 8, 2025 at 6:36=E2=80=AFAM Siddharth Asthana

> >> Also document the --batch option which can be used with --update-refs
> >> to allow partial failures in ref updates.

> > It looks like a --update option was also added by the previous patch.
> > Is it documented here too?
> >
> > Why was this [--update | --update-refs [--batch]] set of options
> > selected over other possibilities like for example
> > [--update-iteratively | --update-atomically | --update-batch]?

> I was trying to provide both simple and advanced modes. --update for
> users who just want "make it work like piping to git update-ref --stdin"
> and --update-refs for those who want control over transaction modes. But
> I see this creates confusion.
>
> Would you prefer a single option like --update-refs with an optional
> mode parameter? Something like --update-refs[=3Dbatch] where default is
> atomic?

My preference would be something like [--update-atomically |
--update-batch] first. (Maybe names like `--batch-update` and
`--atomic-update` are better?)

And then something like --update-iteratively could perhaps be added as
an alternative, if:

  - it works exactly the same as piping to `git update-ref --stdin`, and
  - some users want to use it to blindly replace piping to `git
update-ref --stdin`, and
  - we document that it is not efficient (compared to
update-atomically and --update-batch) and should only be used to
blindly (bug for bug) replace piping to `git update-ref --stdin` when
performance is not an issue.

> > Also how does this --update-refs option compare to the --update-refs
> > option in git rebase? Is it working in the same way?

> No, they are different. git rebase --update-refs updates refs that point
> to commits being rebased. --update-refs updates the target branches from
> the replay operation itself. The naming collision is unfortunate should
> I use a different name?

Yeah, my opinion is that "rebase" and "replay" are commands doing
similar things, so having an `--update-refs` option in both commands
is a good thing only if the option has the same purpose in both
commands. If the purpose is a bit different, I think it's better to
use different names to avoid confusion.

> >> +--update-refs::
> >> +       Update the relevant refs using ref transactions instead of out=
putting
> >> +       update-ref commands. By default, uses atomic mode where all re=
f updates
> >> +       succeed or all fail.
> > This seems to imply that --update doesn't update the refs atomically.
> That correct --update doesn't use transactions it updates refs one by
> one like `git update-ref --stdin` does. Should I make this clearer in
> the documentation?

Yes, please.

> >> Use with `--batch` to allow partial updates.
> > What about --update, when should it be used?
> Good point. My thinking was --update for simple cases where you want the
> exact same behavior as piping to `git update-ref --stdin` and
> --update-refs when you want transaction guarantees. But I am starting to
> think this distinction might be confusing users more than helping them.
>
> Would it be cleaner to just have --update-refs with the batch mode
> option and drop --update entirely? The sequential behavior can be
> achieved with --update-refs --batch if someone really needs it.

About the options that should be implemented, see my opinion above.

About possible confusion, I think that to avoid it, it is important to:

  - name the options properly (see above what I think about the
`--update-refs` name), and to

  - document thoroughly how all the options differ from each other and
from piping to `git update-ref --stdin`

Thanks.
