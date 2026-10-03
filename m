Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D948A2CC
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047394; cv=pass; b=CQw6fampMpP/RcEMRKLc73pbhOyp0sOZNYzlMQy64JsSK/PxZC47IotEjv8zqUoZeocyVtdPhzXKDS4ejnV9UPCEXFMTvH/uXu2q0TgUDZCmMyvUsBUBHgAFmsGJbei9TB5dx3eleOUpt7apcAPQfRTUWNefRFXdn+Gl07Xpxj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047394; c=relaxed/simple;
	bh=AjWF9HXtUlMrZakVCm85iH0XXWLZMokIcojzDRjx5uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB4DGiPlRGp4JQJXL4PGGbKtwQinEiHz5aPtK5aR7hx79cN4R9RRxyqdd6Oqw6UPRy8OOzg4TEysoTZZ601ZvkIJhLyEe50vQjuluKCXGVJUcq9Ok3UpCT7iXpx7cdTULxB4X2GGFSEhob9WSlwK/w/ek0DdrHIuXX+agkXInvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyzc+rTj; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyzc+rTj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e30b9f1441so6108365ad.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 10:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791047390; cv=none;
        d=google.com; s=arc-20260327;
        b=G6vFxrSwDv1wgOrbD4H9HHgfE21yZsh9W0zScE88FLFba6ot13FHjd/KjUrnhjv3HL
         JJSl2+dOrYFEEIg+X7OnXU7BTycZqOImWGd4ygrygxiH4koVBVA+zuwbFiKiFwNPb82R
         n6aN6m8ZGNIk1Jo+tEQ54M/s0ydjU8biSmSUF6Ir2OGtP3MFXUvqmSuzEZuJBPVSEZQ/
         B/wY9NALfOi0IhqPNt6i+YXAnWsD0iJ0HXKDWLgpQa0XLTBNRzikCE/Wv+8c3EqnvifW
         AoUPDEzVjUOKBF7j5UH5X4iLWV/lXXhcnMZZ8Xg+6u21Sx5duVjXkNrB611m6FCdCd1c
         5i5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AjWF9HXtUlMrZakVCm85iH0XXWLZMokIcojzDRjx5uI=;
        fh=de6DvBU0RVoraYHaK3fivl/eAEQHTcGyG/lOj3rXsWY=;
        b=VWO+5T32xc2B+l0aNr86XqdU38JY3OHqBjNF1YxklJczg4fqtTEf1oQo3z5x7OfL6c
         xQO1/NNw6OZStE/xzMcdZwdCQdk5qKUJp50xCVVNEKTVGgLwJlJ2lrIhX8oPWJq+XYm+
         bXjaGWnRd4Pkp5XpA6IrK4N4WkBAiWgOnViKNox33w0H/oYIqo8Dgtie8oAFXV1YsbQ+
         VnqJRHLnv6ocC//KJIiDtGpcoTejw70Wgj1hU+3aXWrfMSeyqn+KiJXaJpAbWqrE9lg4
         VPTYJdnX1qKrkuw10jp4QRciIrC6DGiG3h0yYERm0drst59dIoGgaqSUDJSKmrHuMPbb
         g62w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791047390; x=1791652190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AjWF9HXtUlMrZakVCm85iH0XXWLZMokIcojzDRjx5uI=;
        b=dyzc+rTjVlfgUqNCsj2x3fZgd9QIoSPib3OG6NKBlcYfLlJ9GhWn6PHbEYP+FZlyiq
         w4KAoixVx8iRJCEnFD0ybM5JsBcnKgmkBCRJkwcIj/cFxJYr2cu9OG/+i7TeplSqY50n
         uJIDSSkqDZlpp8ydawuyLT5+8TOjik4vbrghuvWE45/MT8FJ1pkr8YXYfu5WwOPopV7T
         0qRDAfGy8xNaySZ9tbtvigQsFeQsKis11D1FM7SRydyb2zbe+JpbjATglXtXgUJ1QGeY
         IBEfLTF1D78577pB3PX927A4eAI2usNt7gyUG41g8/x0TBvtwpByuL8DMW5VrGPNCJbk
         Pcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791047390; x=1791652190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AjWF9HXtUlMrZakVCm85iH0XXWLZMokIcojzDRjx5uI=;
        b=EYBATJRfmg5shOyGbBe4wQ0YzWWF1t+XCnw5l1HQcnaD7BD77EyoVMAJCWrza9gkVe
         txfoz3pS/QUvhBbIi5bXn+IS+eGU+mkS/ej8Y7iYYEBAyUHQerGjKh+BbFMCVyDTOftM
         Pd6vhl4l/V5L1hci/Nks+Qui6F88rblyerw5TVA7rMd8fsOM33AzvMDrxRa/BJyy4aIv
         WITriRCXtJ24JVKVfXBMn0CNZV8gP0YcliYjK3SaShGLcaTTHeCeFq7PrGuMlRvtUCyq
         /GIJoqcI0w54MTq0vnrtKvpNKEy1yzjroTOp5sN9fgvl1Y7vAeU3+kGh+ombKiRQqCp4
         wYOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqqGlxMMUvpgWfVGGEDyosSEMFuDQvzHek0Af9U/xDLinKp5xMzayygg2/huyL7gOMDPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKE6L+BbZuqUTn0EHurSy1yz575JQwksdPb/AzbGbLY1swmJA2e
	9FNeE9RxN5qjaKfh9kKyciMOd1eiwDsAC1RnkZbWHY0KhjRQ9gnykkqoXzQSOXQLxd7sgvzDFiN
	G6sKpUj0NmypFKmMLpYFRyeFhSDV+4+s=
X-Gm-Gg: AYBFou0l33ZlQKC0yfVQi0S4Klr1bNeGrjEta+I8enrU1Igzu10+OLCWpZdHpSnIQnG
	iVHFZcMA0XUyidHMhnYbqdfGNHgJqC+nLEH5aqhnerYu77j65hgeoN6mW5qS9FAINwScUoCptuR
	6+U/jeN94WdZWzr8a/UzZDUssuW5qPC5ac1zK8wmX78e6ySvPsPKzZn/IaIjUGtvXnyq6WWXkA5
	EBzGXlqDE1J4hN3LBVhHDCuvDaIJ3c/vfQnw5QJDdPwAPuw3apyuVExh1t8D4T4FXLL72eGIfSJ
	yKCo2CXV0RwcYlzIwA8UdcmtHCxegma55EbgKJx8oMa2vXT94NnDRq9bH8fIcs8NFj1Kr7MbdHR
	gf85QwY3gm9tHcMNu/TEAvb3Tu8/sx+/yVNWk5zOR6Sw1b8gNBgg3t1/OXw//WFTs5jDkw3Q/5U
	ypSs+RsmKO9kC6mZlsKi+HHDMQ83dVch4=
X-Received: by 2002:a17:903:1ae3:b0:2df:9230:9916 with SMTP id
 d9443c01a7336-2e5105aca6fmr26205105ad.36.1791047390312; Sat, 03 Oct 2026
 10:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asDTWsH-RuIJOyne@debian> <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
 <37597cc9-0cfe-4a1b-8c7e-1d229c9f7cf0@app.fastmail.com>
In-Reply-To: <37597cc9-0cfe-4a1b-8c7e-1d229c9f7cf0@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 3 Oct 2026 13:09:39 -0400
X-Gm-Features: AclHuK9GeSTEpHeqsbNkKs-kbliCdFYimiea0Au1KEAvvzuH6cSC5o6nBDpexAw
Message-ID: <CALnO6CATXadzAfvwEpG7po5dH+scd6KxGxRqXvw6w+zN5krreQ@mail.gmail.com>
Subject: Re: git-visualize(1) plumbing equivalent
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 11:27=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sat, Oct 3, 2026, at 15:45, D. Ben Knoble wrote:
> >[snip]
> > On Sat, Oct 3, 2026 at 6:13=E2=80=AFAM Alejandro Colomar <alx@kernel.or=
g> wrote:
> >>[snip]
> >> The goal is to know whether git-bisect(1) has found a commit yet or no=
t,
> >> to stop looping.
> >
> > I think you are probably looking for the (size of the) set of commits
> > between bisect/bad and all the bisect/good-* refs. So you might need
> > to "git refs list" the good ones, and feed those as negated refs
> > alongside bisect/bad to rev-list?
>
> I think you can do that directly with `git rev-list --bisect` and the
> other variants that start with `--bisect-`.
>
> I have never used them myself.

Thanks, TIL.

--=20
D. Ben Knoble
