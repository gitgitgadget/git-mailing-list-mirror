Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00019DF8D
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051803; cv=none; b=F5qul7318MayzbLdB9QRk2aaXI/YHRmxTjaC1obV+SJRLWJNMDvoaLPj5XPRNzKxxSdZRiT8d2nYa/fKdZ8bHdua19ervP6d873HzawZgtnNx0nIhJt6jP6UwMxKdIqNSEeClrttXvedVNYLP3foN4F1mj3pnp87cW4Gzkkbsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051803; c=relaxed/simple;
	bh=KKPPH/2VwJ/n9n5CEw5SkrYrM9DmtI37OYFUC8Q/zt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZKpnHQaTL/TrUa7KBlYSIl5XziA3k3daSLG6uayoXEoxdcO22NLd428ZUXDnJgJx0csEZoJtfCCY411iebk9Qwkf+oTrVnHIfaEPkSxhhS3XW+rpPGD4UZ9hUK26CCAwddou7uSKJuhUsfnPe6GK1INvVZ931W4TYerNzjfO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io; spf=pass smtp.mailfrom=pspdfkit.com; dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b=ZXmdES8b; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b="ZXmdES8b"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb2bb25105so1134403466b.0
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nutrient.io; s=google; t=1749051800; x=1749656600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTOEd7EdJob3rhPBIbjOEibyqw+PocVahNcLKGOtg74=;
        b=ZXmdES8b/bGEL+EWKfxFCmaW25cj4Cnp42HALU9000OUavdrf7XcYG14pKtRtI1uVL
         vt/Yn3Xz1lntFCSqe6oalhhnMI38ZGpyWWfoF5D3LyAsui/oVkD8j8sXK5mP/QLTWHBN
         fLcfs/R+O8OZJrccYyrc2hqzmnc01YVJQ3DO6VuxtYyiD4IR+DzBsetWdeG9z6VhY0OT
         1ijj9ech/EBa0hLTmIGZm0GmAWnQizjzY3oQZuz+S3Ql888vZRQ6/0UA7cZhHDZDlet6
         /vxuohvjuPHwQZnnUEYbzdAJkO+vHdlwv3fi5ej/gDEDQL84DY4k4NzExQTd+1G90xT7
         TNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749051800; x=1749656600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTOEd7EdJob3rhPBIbjOEibyqw+PocVahNcLKGOtg74=;
        b=DvlHMo+qz1T6fxCTKApT2Cdec4B3aSksn1y3il1Qx3N3T55+8RY+yNtRXI7QJYSSh0
         c0uJLqNjja2V10KZQy7gy992civWaWP0hBbuIp4lIhaQ4tjJYIS4PjxTlEkiY1gfFaLc
         h5iUfyANiAZWT/VhG1W9jxGEhR1rhvkXgtDO9MYWKY+NPc+yc4S+Fu5u7ew/bvm7UF2F
         hkFiUrIPZq3wf9SxRQrLzUN7MkBGp2sLoz7fMdtggWfMaxlyQ0MA6MEzi77DANLLkx81
         ZoJyxtB5rnAawzGNn4/jkaFQpzQA2L1qZdZfkaqau9gnv8FH1u58LExh3+ZWwG4IuSof
         TUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE2ZXL66TuJ8GfFpxbcPohfY5oQOt7nmBcaRvXMZZJpa8Yq62PEl9BolPOJGq8eIg6rlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjaRKnhsQqI79pZ9gMJXXmFNhycler0eMJBmx1BQM5mivzDtZW
	GxSyY+4WtElCn7SpPkbhuKi+jIbmudZTPNaF3VIlQEoXOxxq4RAkPuxv0IjDk76/1Xfr08FVTX8
	LR+//40xNlBCjKEO4CHTbF0D9yUGnmqWDoj4U8QCNsw==
X-Gm-Gg: ASbGncs5ia6Y7CiJlVZMtuARu+W1IvaXcM+dpfJ1n19DmW1CE/W+pBzwl/5YOmMtt1j
	kTBcm6lBGzYPpD6Vu4Wljokd9es8S0Xm1yDWdpxPzYVvRwYjAdV9n06WnJk4oBLaZwY8u4qqlWS
	8itubqLy8Oz9N++BaYs4Mf5FyFwUtT92H3wMyHdmbrl4/m2q2ek0q4XYM=
X-Google-Smtp-Source: AGHT+IHMVr08uzGlLjxJs9nFkEzkPOxGw6/rJfcocyL/e/59pcdTQYhVciDYr0/sxwSn5JlWo0FlTp3Kl27vbuAp7tI=
X-Received: by 2002:a17:906:548d:b0:add:fa4e:8a5d with SMTP id
 a640c23a62f3a-addfa4e8fe7mr204385566b.32.1749051800113; Wed, 04 Jun 2025
 08:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
 <fe7e918ba1831fffead46791441da350223998f7.1748882439.git.gitgitgadget@gmail.com>
 <CALnO6CDk4cP1Mef07F6Z8Sm-1MxwWWd-rYEfL-e5_Nnq50B4ng@mail.gmail.com>
 <CANMzfzjhe=mxrcxgyXYqOD3GJ0UdX=xsP7oq3H8OGPfuwOphow@mail.gmail.com>
 <0c65723e-fb52-43e1-8bf2-32bd421163a1@app.fastmail.com> <xmqqcybjcy5q.fsf@gitster.g>
In-Reply-To: <xmqqcybjcy5q.fsf@gitster.g>
From: Patrik Weiskircher <patrik.weiskircher@nutrient.io>
Date: Wed, 4 Jun 2025 11:43:08 -0400
X-Gm-Features: AX0GCFsmVe08q76ge2OIwtEplGxTbdf5baaXuoyV3sSQuop1R_rlT53ioPvytgM
Message-ID: <CANMzfzgOfb1O1cQTmDFRDWEDLO-J6E_iq-MRQimhpmgAkU8pYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] contrib/subtree: parse using --stuck-long
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	apenwarr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 11:41=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > On Wed, Jun 4, 2025, at 15:56, Patrik Weiskircher wrote:
> >>>
> >>> Here we mention "-S", but that flag isn't implemented yet, right?
> >>>
> >>> Perhaps something like:
> >>>
> >>>     Optional parameter handling only works unambiguous with git rev-p=
arse
> >>>     --parseopt when using the --stuck-long option. To prepare for fut=
ure commits
> >>>     which add flags with optional parameters, parse with --stuck-long=
.
> >>>
> >>
> >> Makes sense! Changing that. What is a good policy to resubmit
> >> something? Should I wait longer? Sorry, very new here!
> >
> > =E2=80=A2 Force-push your branch to gitgitgadget
> > =E2=80=A2 Edit the PR description with something like =E2=80=9CChanges =
since v1:=E2=80=9D to
> >   summarize the changes
> > =E2=80=A2 (`/preview` comment)
> > =E2=80=A2 To send the next version: `/submit` comment again
> >
> > I think that=E2=80=99s it. :)
> >
> > I don=E2=80=99t think there=E2=80=99s a need to wait if you don=E2=80=
=99t want to.
>
> It would be nice for potential reviewers to give at least 24 hours
> to ensure people anywhere on the globe have a chance to comment, and
> a chance for you to respond to them, before sending your next
> iteration.
>
> Also, for future reference, when responding to a review comment that
> causes you to drastically change the course of the series, you can
> respond whenever you want to, but it is nice to other potential
> reviewers to give at least 24 hours to voice their opinions, before
> sending an updated series based on that comment, since suggested
> changes in such a comment may be controversial and after seeing you
> spend some time already to adjust to it, others may feel discouraged
> to make you redo your series again even whey they think the
> suggested changes are not taking us in the right direction.

Makes sense! I'll keep that in mind for the future!
