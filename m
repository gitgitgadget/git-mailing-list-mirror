Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280543081BA
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765386; cv=pass; b=dBAbATyguptA+W39JaNE+its3gNMseNYYnAKD1uPJ+miAsLX6c5jiBQcBRimDT4ceBzlkgTcg1IqRzVo7DStNEvZH/1yvBqTrpRUP+gXgRz70uGi+GnJiuhvewMQgMeacy13cqeZzC7uW7xW/YkmRGfPKZhBZaxF2a7GXnElKpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765386; c=relaxed/simple;
	bh=OKsVDwcuI4/hGzfdNL/XsGhK1mX6Ci2nZRT7TwgE2sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlMTnkVSjQ7nHRNsNxRCBK6hx1WKFPBHMigG1Z2xUfUHfkug8Ka4MusT0VJONZgu/DXMRTC7cGe5Z12Jowd0xFtcJcf2Td6ExsQXqQhkBi+ayen3pRBH87fBUfei57/SOnB+z2L/MQeYDfvjO08m+k0Jaa4B3/gk5uHrVrBG0H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=nwZJFPuR; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="nwZJFPuR"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b82c605dbdso3048798eec.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 15:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770765384; cv=none;
        d=google.com; s=arc-20240605;
        b=lHuWsPCwlbz+am5Lzkq4hqSqimJXktilIgSiJbQpSnN13Wz5WWxDKGNTmCILPJ1xa2
         vJZCZbBXT2vP5py2gePB/F3pjQ9ECw6HtR+u66jrbyu7BpD6dXL1ZkJBBN0WXnK1G+ox
         deBNXJ3wx/ck8WQnA5aN2Lc3zEUP4m5fxfjRH31+RQccNGBt3o+EuMjF8NwJXM5bKpHw
         0tEBBwdtqkE7Bpea4dW/nBVvOiLvcbpP7kvfsYayXN4/SsjBzqsTL94gy4IyWpJUQ2cq
         QE9LO5vSU2M1EmDGXx63otl0LSUfXAamlmjVcD/rfJG6r/yM4gwLVbHUTvkRDgdHMDD+
         QkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BYLOXC2g5Ug98cqU4IYwYyLoQiHCcPYcsoPQf7kvYlo=;
        fh=qFlJCMy0ZUajtRZE3faBRTkQOOyQsgM6XSWEyv+M82k=;
        b=JWcFpaCuTHVqr6hvYch9Hq50vxmvcUmsoOc3wABQQ1tsULDr+uWK5oSKCegtv1kuZ3
         FL5bMkT3lT11in/Kus6dMWwqo9gwYPbx3vsxD75o0fLje4sqHi7U3LH3CsnhA3HERfkF
         zTTah5CFxLJpaCmRhQQh8V9VAgFlbHXOCOK1dYbPRRgk6T6XqAqmN7pXEmZEWhjILYeA
         dxr+aPPIpsccSV2F8WLk+dyDZzDASwcZqm6q02cHoWsVBT4LPTlxx5+Mm94ctEbRmIRq
         xWjG8AkFWDTrEdZSyO5N7E06etVePanz+XRcTKfjrvOzjb/+aRuYLXWfl3oGvIa7WHmo
         9KOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1770765384; x=1771370184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYLOXC2g5Ug98cqU4IYwYyLoQiHCcPYcsoPQf7kvYlo=;
        b=nwZJFPuRcSTCNYbegrvxCqjhgKLVqLR7abk4P8NoxruFq4IHHHG9UWf90o2VmjVEvH
         LvSFNDOcO2F/h0EPMM5P1Mw4RmGh+VHXwWUGGe8Ov2GaPLvmKESTuM3I0dFDSprY6u9J
         oAMwXsD7o0DJuo9ndZ9l1ydFNaXr2KY5yi77KcrEgXsZIIeT9MnG1CZOjVpwWC1wS7f9
         EqbW31KXaSiHC7FpNSGLz2ucXMtpwdkfqjJSOoTDQEae0O5S8QUi1t8cvWra3gnd9tSv
         JsZnusTga2D/xIV2oHiQFOJ5NxSj7u4vcq0XpvK1DnBxBCB81rteoUfI0KQP05wCTzj+
         vnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770765384; x=1771370184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BYLOXC2g5Ug98cqU4IYwYyLoQiHCcPYcsoPQf7kvYlo=;
        b=vELmSrsNF9wAt7O6bJ6osWV2WC5/Ta+gZeclUcZtrwHnE8Fk0cz9SyJZFQqrK9dfad
         I+CprG7mduoqMDL5QfV1ZqUiaLjkjjqcOK2tC/ZDf9yb/I87JK9EsMh24e1kuI9qmV9A
         54lP8SLs1dAjCugJcEpVEnklTAFFrrtrg7poPMg33Yzg5z1QqDer2bxPjUZbu5PDqy89
         qZAa1tVPG45lBIdH7nl/4s7FY7kvEVffp8j4kHx3FPlnOF8YrxGUXH8sTyUOQ0l0H159
         3gy59i3AOgxSo9jvoxVoVDTM21ekwoPpAtGm1CB/IOkhM5QBqJIZVxT2pGDyU6OKVrH7
         lJfw==
X-Forwarded-Encrypted: i=1; AJvYcCU/twZeSTZxLYCoaxb+U4z0PPRVWjZKxaxl7n2OEOQWzNKp7JQh5pD6YuQxrMv4dElvBQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4+RMTJ81+DuZN6WVScvU1UsIOyU4XV9W9b67v6y8IHTRY9y7
	2AIgc8yEfo5sgy/QvMFFXb0KlzI0EQxw1s+qTVXKl1vRVX71TChihCex/4oEUGht7deJ4Cwtnq3
	rGFNOyyWET87iC1SYYz+tYEijhsUMKjYGyCjX7vRb2G+vPpclS+uK5LdB4LupU4LihObqWD3wJW
	m0uNe3Yx5EB7Eet2eUjP+Gp2HvQ3vGKLKNZkh4VbVFfufw+gaAgFQVIKnxVNwGSP6Z6X9fquKzU
	QgUqHiLkgEiZxDliRkEgtWEsHIdcHg7l18cgf1JpaECHdSgfdEJMLRtvEAW7Giprt6V5FIhN9YU
	MOLgwZWw96vKr2+e8qb0gAFIuCTDauI=
X-Gm-Gg: AZuq6aLLOUPsNw+8jEI4PjCwbxra21toWa4cyje/qgpI4g9G3JyGA/CeRaYpdFvlSnz
	VHGA3aPVYbJSlgkDyXQwvNCxVkyQC+PczFy1PEyC5N4x9Wz5EjBeoY1DqkHu+P0vavImOkCrbAM
	cKv56Ax1FWzxr3HTSQu5CUCIUMXUoGcTj5Z/PEndcQsb9ElnZAYkIzWPIzw24MsRZnIUfnsWAIv
	UBuLcr5qI8n/DWS9BEv8KbzNWdb28TdTn8KlBktTxXpKs9WLbg7tpOONUnuUrS4E0hjjLU2gFYz
	jxS5qNW3CA/G7n+irjY=
X-Received: by 2002:a05:7300:570b:b0:2ba:72b1:40c7 with SMTP id
 5a478bee46e88-2ba72b14a53mr3159354eec.4.1770765384102; Tue, 10 Feb 2026
 15:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com> <xmqqpl6cxtr7.fsf@gitster.g>
In-Reply-To: <xmqqpl6cxtr7.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 11 Feb 2026 08:16:13 +0900
X-Gm-Features: AZwV_QhzOhXRfXzfHSztF7wUyIpUERkoko1jcY0jI5HSJWGkuLJtI3zCbC0hsys
Message-ID: <CAOTNsDxjuzWUNp4RGABZmPJZBa3wEBXN79kgNPHZCZYsqiOa3g@mail.gmail.com>
Subject: Re: [PATCH] osxkeychain: define build targets in the top-level Makefile.
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 4:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  Makefile                                | 17 +++++++
> >  contrib/credential/osxkeychain/Makefile | 65 +++----------------------
> >  2 files changed, 23 insertions(+), 59 deletions(-)
>
> Nice simplification overall.
>
> > diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credenti=
al/osxkeychain/Makefile
> > index c68445b82d..ddb29f0563 100644
> > --- a/contrib/credential/osxkeychain/Makefile
> > +++ b/contrib/credential/osxkeychain/Makefile
> > @@ -1,66 +1,13 @@
> >  # The default target of this Makefile is...
> >  all:: git-credential-osxkeychain
> >
> > -include ../../../config.mak.uname
> > --include ../../../config.mak.autogen
> > --include ../../../config.mak
> > +git-credential-osxkeychain:
> > +     cd ../../..; make contrib/credential/osxkeychain/git-credential-o=
sxkeychain
>
> Let's not write "make", but stick to $(MAKE), perhaps like
>
>         $(MAKE) -C ../../.. contrib/credential/osxkeychain/$@
>
> > +install:
> > +     cd ../../..; make install-git-credential-osxkeychain
> >
> >  clean:
> > -     $(RM) git-credential-osxkeychain git-credential-osxkeychain.o
> > +     cd ../../..; make clean-git-credential-osxkeychain
>
> Likewise.

Thank you for the review. I'll apply these changes and submit the next
iteration soon.

--
Koji Nakamaru
