Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A1184E
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683601; cv=none; b=VaZXfZAzT9Phf+5/RS688ybf4Ule+iqsrcBHLxZrXdmmOPRcLQkzJ0sofZp/+IPHi9BGO4fuDkw0pO3WaMXKIx3ESE6fXAKxV0bTa2ZYe73FpIAMXXfb5+ZbYWfnx0Hru9vDFv26pi0g23uFITxbtn5UivVayxBjuqyY42Jsj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683601; c=relaxed/simple;
	bh=yUI55ZitJHJXBHDKUpHxGHHn1Pt5RhRSMV151olgqME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e3xtRJERhT01clgkh8Gdci2CaP26ick9QWDB4u8hWcE+bDN4pOrYsNaLV2rV6vKVs3cqu/PT14SKmZRys5iY03T6D3auR9twogTCeBhWS5uIE1GOLWhs8dn3mePaug4poStD6MXoUYdqQWI91WRsmmQT8J/N4LDyDZw97GvBkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnycO0L6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnycO0L6"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-434b5abbb0dso19891cf.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712683598; x=1713288398; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Cdkogty4CfXhM8JNuP/dsas2fYdJPm89iUliNJZMeM=;
        b=jnycO0L6STBuvJHkcGh7/OjPVIol0aPMvUq9HxkJkP4kROTAbM9d6sNz7mtnJiN+vV
         cRt1nOsy/53A4N78eR2EFhmGwKCu1wjx8cMW21OjmfvrvUIaiUAJw1EfEFt/uFNz5W2X
         BXwVeb7yQ6gBz0cUVmfhU1px82YTvvo5R4HZH13xXgzitRWWYCvlfsdfR07DBDSH2wTc
         DbKH+D1eSsBZbpl2x4Gxc4KHMh1/27Cxwr3G13avL3zopwxqYyu2VQsaO4oyeGYZvuXW
         LI0a5mLooa+QPeB1bZYB9DRrq6tBeWO8E7qLYbMRXsKr9UTRk1Izcs3dQvmepsc5rFT7
         /MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683598; x=1713288398;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Cdkogty4CfXhM8JNuP/dsas2fYdJPm89iUliNJZMeM=;
        b=pGZ2jw315xd4UXeA95aI9S314bOpWwPWxrwg3GXkegZ1HFE6gbg5d/f7AEu7IAaEuY
         2ioVJXxhM9MD6fDhEx2xmyjwiJCyejJL0ZsxLDRbI/9myNxHEb3O0O+4TSrB8eOvifWg
         4RaU/fXPSJvtPKZJ6RPn8jUILqJtxmNY4tm0ib5JJxys2k2yhNH/iW/FGDKmNAIXXaUx
         qNCpwLoofqqyBZZ2pIcqNmRlYS7vLg+/ieJ+EW+YwIO0sSci1u0IXqycSWWAa0aqChq4
         8lKUsXjtDgY5Mu27pHuczFGbjTCWzz29x/Kpn2LtGINJLgnSzaQPYx3XHbzCHUCGdmtA
         8RlA==
X-Forwarded-Encrypted: i=1; AJvYcCX2hn7qNcXbn7Z30w/iSpmVP/to1vDRLkMulFhElTh6YT4J3xg8ZR6fZ+DJqCSFQey/WdUVdKtPDuKOnMmYC7Y9ZMq6
X-Gm-Message-State: AOJu0Yz9+yOrzLn2XAr+ekU51R70qLMb12IkVrAY2shNDh85+PU1r+3x
	f2ZXRjKhuLL2bltwLcum8xEG6w/S+GpMj2b9z+3DwR3kZyBGQJocta1QNKN2HgkLdu6Jcv/NGrI
	5Q/FZdPugcxH2S3w+vR6QQJdj6cnkhw5GkTm6
X-Google-Smtp-Source: AGHT+IGfjFwx+ikouyb4AOWawgyJMQZo4IC9qLIThR3x/kZsKsX3zon617Or3bIrKiZ2Px/JrY7ELew0qGlQwpB1xhg=
X-Received: by 2002:a05:622a:428d:b0:434:bab1:3df8 with SMTP id
 cr13-20020a05622a428d00b00434bab13df8mr243575qtb.20.1712683598250; Tue, 09
 Apr 2024 10:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net> <037001da8935$4a6e3720$df4aa560$@nexbridge.com>
 <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net> <xmqqr0ff8rwo.fsf@gitster.g> <ZhSNPTiaPbfekOrJ@tapette.crustytoothpaste.net>
In-Reply-To: <ZhSNPTiaPbfekOrJ@tapette.crustytoothpaste.net>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 9 Apr 2024 10:26:26 -0700
Message-ID: <CAFySSZBMGx_Uvak7WEurwWk00=6o3SciJnN9zAGbvTTbBk=Axg@mail.gmail.com>
Subject: Re: [RFD] Libification proposal: separate internal and external interfaces
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	rsbecker@nexbridge.com, Calvin Wan <calvinwan@google.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 5:35=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-04-08 at 21:29:27, Junio C Hamano wrote:
> > I thought one of the yardstick to gauge the success of this
> > "libification" effort, if not the purpose of this effort, is to
> > allow Git to be its first client.
> >
> > I am not sure how it would supposed to work.  Unless you are giving
> > parallel implementations of "main Git binaries", one with the native
> > code and the other replaced the native code with thin wrappers
> > around the library calls, that is.
>
> I think the plan as proposed in the original file was to have an
> internal and external library and to have the binaries use the internal
> library.  However, perhaps I misunderstood the proposal, in which case
> clarification on the part of the proposers would be helpful.

We are still working on the specifics of how we would accomplish this
(part of the reason this is marked RFD). Thin wrappers make sense for
functions that should be slightly altered for external users (e.g.
anything with a die() should have their error codes bubbled up). On
the other hand, there are functions that are already suitable for
external users out of the box, so we could just provide a separate
header for those. But those functions may still need to be renamed
anyways to avoid symbol collision, so thin wrappers may end up being
the default going forward.
