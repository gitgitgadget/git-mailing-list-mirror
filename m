Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055240BF5
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646234; cv=none; b=AEjAGp47PGDffQwUnmuHjZTFglTpQGYHxhOs+g+/1xqjGrQ6ziCNQbPq0D2HeHHb/IkVICqP84OKlXgfGWaxU69adcRE91XXCi96MG8M6q/u8f7h01VX6QBKy3AaunUIN41rn9JSm1vxZw1GoX12shDsO/VJK6ZOc4nWRM1W6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646234; c=relaxed/simple;
	bh=W6i26DlicNn3SNtrRAiuZj7Zx6BELcw3iQ441o5HMBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZupNGfNDIYtKRXwQhXYwnNUVaX8WLS4r+tfUDmFwhh3t5/PRgfR1sAOUyAZ+USoj7MSYTT9IBoSDPeSmqfvE5MUyGUAnKVUFay9NGQmpQFXITnDQPCKjym1Ra8rJ/pYzcvLrILZppUHur87QZijyjhqLJw1P0ac5FDHbO9521tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzatzhVu; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzatzhVu"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d439f01698so15410025ab.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741646232; x=1742251032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zga+2l+TLWn5tzrLXQOwWuKCVGPoMELU89rEXuIqS2U=;
        b=BzatzhVuuNddf5rNU1yxfpySB/nSXHdbJbkyOcE2vCAYagKPsHZ5ajcN4yx8EdeYq8
         Bygx9KCfjYD66NbZ/XpnI/dA5SgLZk2APrnejf54DpgE7GYy+SR6CfXucUTdvQGmgCtU
         XUxME75sTZSvYUlTSx79cYCpQ/kD5H0zDcnWnWywqICxrpZ6XRk3VeVEtjM8LcAHYgiT
         fPy8sUr57Uw7juUBz+D9ueHe1gUx3E/fTGJ9AeFx40i9smjlPW4y3StWn5ZxkbqYlXt6
         f/xSjohYh+wFQuD1qnguTBNVvCDru/A7S5piDwCgL7SekQwWamDIhg1akKEFj1njtyRP
         15uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646232; x=1742251032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zga+2l+TLWn5tzrLXQOwWuKCVGPoMELU89rEXuIqS2U=;
        b=MpQENRmf3Mtc2taDLtP5XnOtsfb31HetshAEAEtOU6mtCqDt5f2K/RAFrC/kbilT8Z
         fvTz7MyPBZ5igUvAjN0snsua5HMkvn+PBXagfssc6B0lnvajxCdXuVPIaBXasjPajRy5
         k8HCL9yXoo0dJ8QEHQd6OBFgdR2P3NkovBtq5Sr1vmHJXp1QUogZYc4VSHF1e/Hs5rx9
         wdseGl3Skx7NVF0TfPRN02iOvdWfSH0GuOcnYGbvHN44gHSmWNfEefr57peVF7xtIB4i
         +xim+27lsa+ln8jtfqGt3vxvbN81TOl2/ylYysyCx79FGyo8tcwZBvuySgXk1UtghCfv
         xnpA==
X-Gm-Message-State: AOJu0YwkNnu7vb2VkY0WD63fsz5o9r9cWre9MFVKzLWRnpHTocTEUoZ7
	S1mqUJGKCRYU8QHnva/ukcgrVR3L9zpRCAOCpyewXmPse0sNv3Eqq04tfAG+Dq3OrxwrL4rSxLa
	7lBv8kmjndyD/hU8+pS3lFxEWuKw=
X-Gm-Gg: ASbGncs49daLvXuWaAfTwx+cXRDwlENcgkDRb7fYC1WIqoW4glHSKAt+VREssFPsE3o
	LN/QLd4g6dc14hMnph1hVQcC+FbBubil8eid4yz3r9Y0Qmr/5l9MHWQhoHiO/KxBflsR0bj+VCa
	+6NWmK2efPs+SQfQlCyjZeTdVmKsaVeUIlamzj+JzsLyveDGRfJC59/ojdIm4=
X-Google-Smtp-Source: AGHT+IHZWl0/nTT55zAR0LwrizzGbIKHQEbrGnZyxyYrmV9F7m8a9Ipelf/64PZVBczy5YZobINQ+MThUDnlbnOxIUw=
X-Received: by 2002:a05:6e02:ecd:b0:3d4:2a80:74fb with SMTP id
 e9e14a558f8ab-3d46915efcemr11451455ab.3.1741646231739; Mon, 10 Mar 2025
 15:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
 <20250307-b4-pks-objects-without-the-repository-v3-12-7bccf408731e@pks.im>
 <CABPp-BG0AtKdUH2g8+_f0J0ViWs5xZKM9kCcbWYZ=uEu6bswdQ@mail.gmail.com> <Z86Qh1yLUC7aIaG9@pks.im>
In-Reply-To: <Z86Qh1yLUC7aIaG9@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 10 Mar 2025 15:37:00 -0700
X-Gm-Features: AQ5f1Jqhrh1fCW5WIrGnWkUTU2EfBq721vBXFobFavf4GB3b_fLcL1ZeuOLdhU0
Message-ID: <CABPp-BGXJ38txpr=B_xi7V4+uVhLiDX2n=czZjoX3f+-9E6ZRQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] hash: stop depending on `the_repository` in `null_oid()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 12:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sat, Mar 08, 2025 at 08:05:09AM -0800, Elijah Newren wrote:

> > What you have is an improvement since it's at least making things
> > explicit, but these should really be opt->repo->hash_algo.
>
> Oh, yeah, I suspect that we'll have a bunch of places where we can
> already plug in a repository as available via the context. I typically
> refrain from doing though unless really necessary (e.g. when the file at
> hand doesn't declare `USE_THE_REPOSITORY_VARIABLE` anymore). This is so
> that neither I nor reviewers have to carefully vet every callsite, but
> to make this a mechanical change that is obviously correct because it is
> identical to the old state. So I'm basically leaving it to the next
> patch series that gets rid of `USE_THE_REPOSITORY_VARIABLE` to think
> more carefully about those callsites.

Ah, ok, that makes sense.  Thanks for the context.
