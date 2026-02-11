Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED9285CBA
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 02:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770777257; cv=pass; b=NCYQ0RZZ8U+707f6AcPXFhmcZiKLsnsY9Q653Uq0bKHQuY/3n8zC5Yjktt+7d1svc0AshoeesNgEi0yXqYXp6phF7rSFkymS94Q89oPfKzGfDUFRB3+S7EoG+bHdxJ6TxaYbM7IhYlEOFicJeuvHL1r9yMk1FuYhKz+JD2ghjrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770777257; c=relaxed/simple;
	bh=qLtGwBm8BDuWZvaWKKLCkfaC9pD+cJCbB5RaZF8wBwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OekDfvmbmAd6j1l412Roj2Aj9NZft+vmOwkQhbRYBPY7KmffKwoN6SUD7hGVHxcGEEDo24+r7DzVFFSsfKgMSer58ZksC0MmN8HZWBX5d8+BIxUGExJND26deJmfGQIRXuApvVjJZBkOL7veiYWRI03pbFiagoG4LSfVywOWoAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlNSnXQI; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlNSnXQI"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-463208653d6so1940669b6e.3
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:34:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770777255; cv=none;
        d=google.com; s=arc-20240605;
        b=OXWyhKQ+d++hT+XMNvwRrhh9pzT7DvO15aDh8mpAWsBSLVwaucSveSrX00MmUPIlMb
         lTm0tW08E4Xry0yPV8/RsCWGuQBnZK+pC3FFa20AWFGKVwOQoBDYqr/7smyf1CFK3QSw
         ljHevJuZmz+toRCJImvwpjsHbXXbbfsFp00kyrjLYYco10m1BTW+Fx4xkmZn96INc9Xe
         jcUtAUZucok0zuz/h+O8DBXwRSJ2Tt2xH7YK+GC/hE1PIc+WpKeRjwbS0AXMWVz9Lm9m
         2oHxH0SBVeel42vJrlTfLk8oYUBJRLxrK+/vQ3hHydEilHFUsOC+Li1onrVx7/jZqO4F
         K01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mAtUsaxYiORIA1h4ifUu7670BeT1Gh3xDzzs4xyqigE=;
        fh=NrT1gitenlmq9oJMYepXO7tBykf+I90nDGVhMoCNMww=;
        b=CJhHZNEkCT71aL6XRXG+ekaH7IQn+EiOI5vIkG9L8JeobW8c7TGJk8XR3NTOacrTK9
         Qbr4nVxoERsQi4Jjqoh3xYBlv9ggzFmECs7pXdmNxNbPiTajGHLCTpE9jmxtXCmYqa0s
         wec6mndGN8u9a6RV61NBl47Uvo+3hAJ/vcrDdTPfiaMms86b3+zh79HcxKNC/1w7ivs2
         kbhuvfp8vih59OQRIBUHhwKsyu3PgUO1zdS926uV93wBthJEOHIoN4kgtxGgYQq/ttsT
         YcwgR39H6V73ToeMDqtFI0e9C/BC9oQ7SofkaOo7lzbCkAowLgIUpIxfRmpMkBw33Ff3
         KnFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770777255; x=1771382055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAtUsaxYiORIA1h4ifUu7670BeT1Gh3xDzzs4xyqigE=;
        b=AlNSnXQIxJ3v9DAL0xGPKyTopqt9pF4lly/UkQOQOyVzQMdFawDJLhZc8C0yD9gWLk
         3iNtaRfq7Mpc5k5ugVLe/dz8O3HvRv/z7ZzPH5Lb3nu+S5+k9ivNf3OK9UJgh5PimXxw
         kXm1ygcOc2ESajhJ0yq5SwbjM9GyyVAkvNCIGluBbjZ5lpgOZ1KBlgRMS6xxHw5BtgyR
         pkfhoHeHoSfqXLKpU5wjvUbfGXiZ8Xsa7GFlw7374ct7wFmgjzq92Y5JhKstGmPKpelZ
         xSeqav7hlcOG1IYX51VWjjOCdM78+7p9lwkPcltNJ1hLaaVzUl2R8gvdO2gNC3SaD7Gm
         PWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770777255; x=1771382055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mAtUsaxYiORIA1h4ifUu7670BeT1Gh3xDzzs4xyqigE=;
        b=OXT5YidCU65mxeeKaCfwW+8CH2v9XKz7XVs+ySSk6XKDWDV4O00JXYCzwI4IhgJ3Wu
         UGEIpi0IxrTwb1PF3dHYDdAxO/AyYnRc1HtSUd8gsAht5baZwaqjPJwRkEdfye16TjRw
         5ZVC/1RiDoVF3bXAzH5nvZEeO9MPKp9sAgJ4ZoJQE8n3tFbyjuKqt13siDMG/kPXN9Bm
         kGcoYZF/NI2+v1SGS/qIgzDaUKpE29oYALLEhUhTEejoZm7vT9t7s0Mz6thEekjYMSF1
         0pwqrP4kLoVlGD2xLAJBZ8InxsscQ6wexcoJlwG9JuYwK91I8ouVnf/mU3oEQQrOSMgc
         eN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTW+roENomC0iHlCAZJjljyVxynAKFJ7mzivpE2VDSmI2KKyh2pzj+ozZ0JX/t/jamsVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbbZ9H+DB1ekLKZbWu8VjlQxGJxjOSK/xjPYOAJUzQpXuJAi9
	KV3L3X7yv3LDnlgutjOqm2bTSzrjZXV9eO0PB9StKg1yGEGBTOriubVFwmiyYADWilAyZkF3u+0
	73pCZ3znSm54TKs+SglOPETGLi5R0atc=
X-Gm-Gg: AZuq6aKHuU2+ATpBWvjy5drnY6li69Hnbqo2MV3QSMi+EiYeQO/4cmBy/+H99VeEigE
	hsMNmjc75FO8lZSiRqu3MHjxJk5Mel3MTHBk+iqpVJq1hX5/f6gUdfqN/55il0gQQDc6NO4yUFQ
	CpLp7nSHfWfLpMdqSqk76EelY6NcfaKnOd7VjnwSXjobQDQIkj7iT4hs1SaMyGTwHvZSmdXSQTi
	UnyMt+uGcOMbAYSyarMk3eJlHyU1ZhZotJXR90Oz7Ara1L45rwCr6Sp0CqTsJ4ihq+1Gj1wSzSY
	2g+lfA==
X-Received: by 2002:a05:6820:2106:b0:662:ff11:fc28 with SMTP id
 006d021491bc7-6748206a88cmr187161eaf.41.1770777255514; Tue, 10 Feb 2026
 18:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net> <aYoEO0CcVt2Qjgnb@pks.im>
 <CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
 <aYs_P8QujA6mL81-@pks.im> <xmqq34381tze.fsf@gitster.g> <CA+P7+xo0-9h_V8xGQaEdgBEaxjrbrNOdPfmFmhKup+Z-7w0zUw@mail.gmail.com>
In-Reply-To: <CA+P7+xo0-9h_V8xGQaEdgBEaxjrbrNOdPfmFmhKup+Z-7w0zUw@mail.gmail.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Tue, 10 Feb 2026 18:34:05 -0800
X-Gm-Features: AZwV_Qin68lkAtbe8oAeTZjmzFzU47EbJ4KUrQQzHZQDdHhFGrAO3BKPA2ygnJg
Message-ID: <CA+P7+xpYSyhBoC23RLycVXFSBB2=dgsQrnvLkk0D7afOqWyafA@mail.gmail.com>
Subject: Re: git-am applies commit message diffs
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, Matthias Beyer <mail@beyermatthias.de>, 
	git@vger.kernel.org, pyokagan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 6:31=E2=80=AFPM Jacob Keller <jacob.keller@gmail.co=
m> wrote:
>
> On Tue, Feb 10, 2026 at 7:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > That is worth a thought indeed. I guess one of the biggest questions
> > > here is whether we can introduce such an unambiguous mode in such a w=
ay
> > > that old Git clients/patch(1) would continue to understand them. I
> > > wouldn't mind much if they would still misinterpret the ambiguous par=
ts.
> > > But if so, we could make this unambiguous mode the default without a
> > > breaking change.
> >
> > Yup, if the old versions misinterpret exactly the same way as
> > before, then it does not even have to be called "unambiguous mode"
> > that is on by default.  I doubt it is possible, though.
> >
>
> Hmm. If we add a new unambiguous marker after the ---, old versions
> would see '...' and know to cut the description. New versions would
> wait for <NEW MARKER> and properly ignore any diff/etc prior to this.
>
> Since <NEW MARKER> is after a ---, it would be ignored and not
> inserted as part of the commit message, and because all versions
> universally accept cruft between --- and the diff start, this should
> be acceptable right?

Keeping in mind we'd have to use <NEW MARKER> as something that we
somehow reject as being a valid part of a commit message somehow, so
that you can't accidentally insert it, and we'd need to be careful
about rejecting formatting such a patch, and probably complaining on
the receiving end if we see multiple markers.. Trickier than it sounds
I imagine.
