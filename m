Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56942417F0
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209441; cv=none; b=GGngJmO8iWIrKAoPRX7kdo6RshM9z0LilZF7zxhPRFKLafY/6li2vlp4BUEwkH56CtY8yVenz2wwCVqMEYoQBHadelNpOtEY6hLqktjFPbawGrnwUJpJyPhuAX2EyRLmAFW2qXmca3r46H7NNDXbcqI2SbjFzLIt67knZPt7Ri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209441; c=relaxed/simple;
	bh=y08Xnia1KJfNLrwyxcWsbKg2UGELQyu3/dONbLY+6MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y09vkPWpzfUzRxUFz9s0CG7xVLKCZz0uM3YS9rqSy4ievVo+dLy6jrFICJFNsPgkC+ivjPiQAPNZU1aD15wwbwMgz60A96JBTdOCeslN13PNzANu/aYBl61rnaEJU+Rf7gID4qOOFD3Ffu/pMGjDiVXzWNMF9cL4my+/ZcMdem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com; spf=pass smtp.mailfrom=zeta-soft.com; dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b=SLQYjD5i; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeta-soft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b="SLQYjD5i"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so799347a12.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 18:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zeta-soft-com.20230601.gappssmtp.com; s=20230601; t=1764209437; x=1764814237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5tUvfP/Tcv6uO+wEDKU91i81IytHmfbfs8HgBWIBJw=;
        b=SLQYjD5ieYkppdDjFEmkO24+oDiZe7iUhpboLLrIWMJhr4e4eJcZ9pZPjVGef6RaRv
         Hod8AkAxtlDanaUA1nSix5XqsL9VNFSFNOfiEcFsHiqk+V8iH26jwF4hGbQjXbQNlgVv
         10FKCAj+Ie6uf7m044tsXjx6e2Vqk0TFx2LrNflSuX1roF7JBCqEDN8t5BNHXRl1IvyV
         vm43AZs9L9fe6RqrF109aoL/huxQ3Yc/Ifo2LFzvYd7JAyYhfhhBOChizNpYrt+l/P56
         gCEUaTGHqQBdDge/Qp/HabOL0d5oCtrXRdKn4oQw3cNPEXhvN1ekRa7CAzZ/vz9I6r/d
         5bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764209437; x=1764814237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5tUvfP/Tcv6uO+wEDKU91i81IytHmfbfs8HgBWIBJw=;
        b=nygFebB2cf4dPrZiNPaUBHvSLIgeCALM6Td32bHrHRrRjTDcb1UORT55IBeV9Fj2IY
         pu/+X+QF+0E0/foZxEWOO35onFMYD4diayFbIDOBT3o/NE9LAwac/e8iW6vMbcYc4HaF
         RA7A7GmYtVEkV3VXNXPx2pKysKoMV7rT8n+X7LCMmYTPvR8nsD6K83ycNZXoHgy3anfd
         WH8hCTBe1Np9U8+bwL19nUXC17BiTqe4LUp5d1b3iLwDupUuB0hUnIx1nI+i6XjX/R0o
         2aGS5Dwc1sZz2XG1HrNPEHZWjoSo1fl7vvLv5yq2q2Pg+pbOLuCmvVRI0KSISB3zrxjN
         dbLw==
X-Forwarded-Encrypted: i=1; AJvYcCW4xipDL8fMDZklD2eZkfJIfoG5/RfQThhhi7bMk5UB7J1yq6wLgdK8PyhDf/unpX/mU5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0mSA1TaHFaVc9f1Ls0KtNuLBUcqM0HvCaSSUu0Wc5yl7ltHC
	BIcdvhReeT+svPNTpIbFWo6RIRuP1h7N5cJ9CWuyjudk8bt+HtKs8jlsKqH2O6wngq58UMgASHx
	SuBdAqDRnpT6sVNUqMV4lsYnS1UxBpIIWF4KkusFNMu20ImIZ9UU1lMWh+liE
X-Gm-Gg: ASbGncuCFjpA0X6gexmzoDPSOk+Kl2yem1RAh5ZTMTpSywPcjFj9qFOhpkYbbmnAKzg
	RGzHUU6UDaAaSG8ypBwVq6u1L5CcYxSgaaEWBo/m8SJIpL7Ql9v12aQYAPBU3SrgAOJ8pxMGzZ7
	uvGmmJ7qRCvxPFOd9CYKO3gLJMf37WNldWJOFjLPVL4gE3vo7eeYoEu+lzutlq/KLHcQCX00tUb
	9BVGHeoyJPyWvEFbMTDx2uacDTevqnVfus2JCd3+hBInPJmU56XB3XNh4/O98TEsZw=
X-Google-Smtp-Source: AGHT+IGvVBOwq6yEZveJRzAlkYGvQ7fbOYFtU/w969Ig5kqh79klwKderwhU+J0gXnakI0K25QPykyoh+suajyVp0eI=
X-Received: by 2002:a17:907:6d1c:b0:b73:5936:77fc with SMTP id
 a640c23a62f3a-b76c54b85b0mr920535966b.13.1764209436938; Wed, 26 Nov 2025
 18:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org> <CAF5LJ4D4q2S2VFhvEgVOe1Ar0e6cu=H3e_o_98VwHN7wYHh+DQ@mail.gmail.com>
 <CALnO6CBFKjewrkPeEUh7Q-A2dZ7Fknjy4DszG8xCKu-NvGETfQ@mail.gmail.com>
In-Reply-To: <CALnO6CBFKjewrkPeEUh7Q-A2dZ7Fknjy4DszG8xCKu-NvGETfQ@mail.gmail.com>
From: "Scott L. Burson" <Scott@sympoiesis.com>
Date: Wed, 26 Nov 2025 18:10:00 -0800
X-Gm-Features: AWmQ_blxa4pG5pU6EiSHGzWomMgIjGoIGs98V6c-lC9728YY-Dr0dM-Pm4vZ6W4
Message-ID: <CAF5LJ4AgJvMHej1uRm5Q0v_BTavmm+aXPBC-nGmBp9URX16Gkw@mail.gmail.com>
Subject: Re: [PATCH] diff: "lisp" userdiff_driver
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jaydeep P Das <jaydeepjd.8914@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org, 
	"Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 8:47=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
> Without "going there," I think there are enough differences to warrant
> a different driver. (OTOH, I have sometimes wanted to teach the Scheme
> driver that most "def" things are probably definitions.) Our
> indentation is less rigid in that indented forms may be more deeply
> nested than only one or two spaces (and we of course have more
> definition forms than "only things starting with def"), and I don't
> understand the downthread desire to not permit tabs.

The proposal on the table is not to replace the current Scheme regexp
with the Lisp one, but rather to disjoin them, so as to match any line
that either one would match.  So you don't need to worry about false
negatives.

The thing about tabs was that, the way I had initially written the
regexp, it would have matched a line starting with one or two tabs, or
a tab and a space -- but no other whitespace -- followed by "(def".
This was not my intention.  I was just trying to match lines starting
with a space or two and "(def".  Again, this is in addition to the
lines currently being matched by the Scheme regexp.

> As for Scheme community, I'll suggest asking on the Racket channels
> (Discourse is probably best if you want a mailing-list-like
> discussion?)

I have asked on Reddit under /r/scheme, and got only the same
objection that you offered ("define" etc. forms more deeply nested),
with the same resolution (disjoining the new pattern to the existing
one).

Reddit says my post got some 4300 views.  That seems like an adequate
sample to me, but I can try elsewhere if you think it's important.

I have an updated version of the patch ready; I will submit it
shortly.
