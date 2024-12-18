Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E19192B94
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565938; cv=none; b=EQEjC+/O3tJiXMbmCaA6Scu+AOsW+wsKvEj/ZFvhPsa2jDHt7akf3SiBw+NNflBMjujZlXE4GtNSOkVjnFk5xdYVfnpQ1TLS6D0CiDphT0CkvLrGRK6Dzl5tzyyXoCqQxJBCuX+Au50Xu3x5fBUrJitqKWaqlGNlGRxPv064wZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565938; c=relaxed/simple;
	bh=NIWgCoTyxsLNu8Ogwn5IbMb9LEhnxbkbAXtEBJ/1pFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb1biMa8BMSFy218AVbN54dXmrUDPjU4cBR7XHocytqPoQke4NIfEpo2HkjEiUy5FReB2E6f+cDVsSLg5+EjSqMITO/zHxZay0Jdra+O3GS5xDJU0RhrcxFHxTeHqlvpz7S5aQtoyGjgyRx4el3XtWOYb1NtAN/OQ7CyYFXAdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8eacc4194so205586d6.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734565935; x=1735170735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQq/JnxwACZ3M4ORMIDs8wqa+aB/fnN/MXzEbOrn1cQ=;
        b=KNuZM+0UIgPp/rtUM/5Ji4b1/XNYTKUdP0pkJ06dxeBFZBEzKA50dhaOM3SW4vRTyj
         FkRT6rjE6b62t2sKUwR7k3ZiO0MDBP1fKoc7jV9h0ARnpnBX7EOrxmIdO7H9D/DQ+NY2
         cbL98Xk9rFWVMjGQ4Wew0JU6MtapGeFF2WS2BNIqmE7+mP7U2Cb9+8Vv5o/EcgAWrs8L
         nTWEESmCKmwWHhhWtUoaIkjsDdWqM2VEhoc+D/uQ6vgxsJq8XDu5XhjC8ptLsjmOQlYY
         rTePhlv0q5W8GKBwoagUMH9AaV7skOQ04mD1O3iEt+va/dvXubPSw6oe77co0YS3e586
         /yTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqJy0Pa2PpyRT0LG+ruKKEFtpkcmM93POtk4TbgnvvAlV7n7WXUExwQ06IFnTA6i94TCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCtkjdjbKj60ToGKC0n8Q6TDol6aDokNiTXhixb3LlSbuxdQf
	faLl+rsH5O3sjKGZbB8H39q+danHG1QcAjaWCqrCnXfIQ676SoMM4SJZfb0ib2pGNMMks5WQYGy
	RXFvg7uNhorqC0Fdu/QmyJIRpJUPafCf2
X-Gm-Gg: ASbGncs4UmSGsCTziJqCB63WhPM/WzhL0JLpw/AyqtmBZJiD/BU481+YxsCXn/hcbLE
	51x49YbJ7y3KkDQZzqiGeJ10r7GOCst14AqHdL3b0oS4DyAWhxVqTJlwsOO0dqtDStTTtkp8=
X-Google-Smtp-Source: AGHT+IEx77QFdD45jEpgfJBwB7dfPEqqOfYsQMnWnaWlF2UWD/R7VLEaPE32nA65yijWCEmYlbNevkDrw6U11tEwA0E=
X-Received: by 2002:ad4:5948:0:b0:6d8:a5b7:6581 with SMTP id
 6a1803df08f44-6dd0919889cmr28742046d6.3.1734565934904; Wed, 18 Dec 2024
 15:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com> <Z2LOpOxu0oAY0DW3@ArchLinux>
In-Reply-To: <Z2LOpOxu0oAY0DW3@ArchLinux>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 18 Dec 2024 18:52:02 -0500
Message-ID: <CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>
Subject: Re: [PATCH] refs: exit early from the loop if it is not a main worktree
To: shejialuo <shejialuo@gmail.com>
Cc: AreaZR via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	AreaZR <gfunni234@gmail.com>, Seija Kijin <doremylover123@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 8:30=E2=80=AFAM shejialuo <shejialuo@gmail.com> wro=
te:
> On Wed, Dec 18, 2024 at 02:20:45AM +0000, AreaZR via GitGitGadget wrote:
> >               if (is_main_worktree(worktrees[i]))
> >                       continue;
> >               ret =3D 1;
> > +             break;
>
> So, when we find a linked worktree, we just return the value. From my
> perspective, if we decide to optimize like this way, we could drop the
> loop because the first element of the result of `get_worktrees` is the
> main worktree. And we could just check whether the "worktrees[1]" is
> NULL to do above.

You're correct. get_worktrees() guarantees that the main worktree (or
bare repository) is the first item in the list, so merely checking
whether `worktrees[1]` is non-NULL would be sufficient to answer
whether linked worktrees are present; no looping is required.

> However, I don't know whether it's a good idea to exit the loop early
> in the first place. CC Patrick to help.

If the loop is retained for some reason (though it really isn't
needed), then exiting early is indeed desirable. I suspect that the
missing `break` was just a silly oversight on Patrick's part.
