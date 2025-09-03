Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF72ECE82
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937506; cv=none; b=rmpy4pzkez9zOc2/1RFiZI47bCr8NcYguzfqfc8TwBNPJlueKj4LORyTWrWYE5RyMLI4xNNqCaV+VbWer2TjnvlZljA5PYSqrEsRyZT1y3iORHYIKb5TPKgCyZ1+oargvU2s5xT1NEjryVdfGajmeROc0RiJU1j2qgPdDlobZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937506; c=relaxed/simple;
	bh=RYWCq1YO6mJK5pjnx9dM7S4bobU30kqDse6+36shiBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3ePZQg8C1683Fiy17pQV1mlzheKJ4R1/XWnH3jY2XJPs52ok/QGcxBkHDLJD8KZ0N2a7KZV3iP2A/DARq8HA919XirqpATHf71dEvOFqvLEsxAq/Gk0VJxYvkCX2lE+MyTEcGSXhl5zhCjz6kHr87PkGWjxMRkzhnf+DFNiSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b494e774bfso988761cf.3
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 15:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756937504; x=1757542304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtZu0K8pVnYpEgx8+xkKplTWorU93Ks6nu6DBHG3tms=;
        b=i37m9CtNQX5qXvxPCBcs1yxxDHaUeEoYW+Pz+9GogvmU/0rxEc8uFm+pkRAtBS71+c
         8Q2pAJTSC2K88SKbO2sLxp4RSsSqJCZQ9u0NftJGenT3ivMZEiw5m1hoPg2t/uXnb6mi
         sz6PywAslzFxNKveQbwk9i5QYZsf7MJarUP7ir3O4dkRi6xmzWiWrt/+dOYVc1NB2zNL
         ZbfJ11ROOqAVd90rptiKOMt7bWQWaIPAngv192BFYMGYfSiVwovYQaKI2U/3gXJ9YUWX
         VVE4H8heGaLU2GYSFeRNnqVWP3TtIteYmQ93sr5V6hHxmrdNn9lmlDRkX7A+J1eC78Xi
         LTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5O08mnmxsGJvwBybFCnfv27OGI5xPHV7zFbcp74+CX4dslnuJxmYE4OBdy95XUJBV2HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqorrhD9IGDo7szj1lN+tzDS9bO/g+drEnpapwJQikuVGg5IXp
	zNuf3gnzCL7SIZy4rzxHiDcAMhb2ZHrNv8Il6wyR4TaJtQJrD7mUdU2xhATXJiwk+TIcvf85C5b
	hZ3yJdMW7xNAyMtu+1/0qUtLg+pm+A98yIg==
X-Gm-Gg: ASbGncv3wgRZJK6dFsMDBrrRvbPR1cbnw4n1zio2yF159GnPSqz/4t19WNcCIkWMfWz
	4kXd2lu0OKcX+CbvIMyTru2hJir1zqUQZUeB6dVa2hwFrFEzg5fzVNS9+s9xu4G1YSuxuN5Wc6+
	DyhJ4H1m7RLHx4lzjqKATiPtao6gtciFyyGMDLiGTGyx9PO3RCqvZ0pMmzKiUPwC3UXi1hkN10d
	lJtFA==
X-Google-Smtp-Source: AGHT+IEWNlP+0JZHssPL7/iYjkHkb2zpDxP84bR7m5mEQP3Ex2l1//ryzEeWoOtG+MYGv285pB8b3vQdwqQEon1+Cvo=
X-Received: by 2002:a05:6214:21eb:b0:70d:f55b:e940 with SMTP id
 6a1803df08f44-70fa1b87094mr147370926d6.0.1756937503555; Wed, 03 Sep 2025
 15:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756311355.git.code@khaugsbakk.name> <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com> <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g> <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
 <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com> <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>
 <20250903214415.GA1915988@coredump.intra.peff.net>
In-Reply-To: <20250903214415.GA1915988@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 3 Sep 2025 18:11:30 -0400
X-Gm-Features: Ac12FXz8FaR0iqyHrFbqqUM14XDJm6rICyw_0C8iQ4h0sKNKiMpIk74I6v2iKVM
Message-ID: <CAPig+cTN9vwoquOKCRz9TXRLtwHaxF-mL6xbbXxUmoHxZkW5rA@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:44=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Wed, Sep 03, 2025 at 05:21:47PM -0400, Eric Sunshine wrote:
> > > I've seen  "troubleshooting" questions from git users
> > > who got one of those long and well-described Hints
> > > like e.g. detached head and default git init branch
> > > when either the msg already spelled eveything out
> > > or the msg was purely informational.
> >
> > I didn't spell it out above, but what I had in mind was something very
> > simple... not at all ong and detailed; for instance:
> >
> >    For interactive use, define a Git alias `git whatchanged`
> >    which runs `git log --raw --no-merges`.
>
> I think that is good advice, but... it won't do anything until we
> actually drop the whatchanged command, since until then we'll refuse to
> override the command (even the crippled --i-still-use-this one).
>
> We'd need something like the patch here:
>
>   https://lore.kernel.org/git/20250830022718.GB567900@coredump.intra.peff=
.net/

Indeed. I saw your patch in the other thread and had it in mind when
composing my earlier email, even though I didn't specifically mention
it (though I probably should have) since I was more focused on raising
the point that -- given the recent spate of muscle-memory /
mnemonic-value argument emails -- the existing hints in Kristoffer's
patch series may be insufficient to quell future emails.
