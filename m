Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB62BB13
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592271; cv=none; b=lnwQqEJTGigB6Wjz2w8vsChPd5rWP9EAEaLE5DpaZBXsMh/72PWRJljky6uUJgzL45L9tp5oUCPRD2/16C87Hl5gRRbYEFDd03FsU7PCV+/0vpj2DmYGvtplp0VCErYSxgVYT7VvoCNtuL/vL9Vfr2CJyA4cDb4sbKKYJBbDwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592271; c=relaxed/simple;
	bh=Ev1kyQhprDpCvHe7EZYUDTfnUl6STv3H7Xh/qtUFz7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6df4PpT1OXMILHY5SgWyec11oAGxLwvlRkGE0zUOAUK7M1CPaPEfnmVWkcwrbPPE5nFdNg3fMMqK6v9mbJHCKtWqD7JBcT7Xwah3cvx3NZXYfTOFGAAFa/BnodMVEcmRUoConaAt7dnOU/aGf7baRANS1awMs6G9/vBZP79bj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+IarkIT; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+IarkIT"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso2371461eaf.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 00:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708592269; x=1709197069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev1kyQhprDpCvHe7EZYUDTfnUl6STv3H7Xh/qtUFz7g=;
        b=k+IarkITPU16EXQwXfgdq3vm1Va3ug9wzBYqxikCu+kRdMCCIu4MJXJfhIq4zZsa42
         d6yz05qHTUqUC2sUWeQwj3CBO9T0PLfqo0vM8rFEnSqYK/kqb8iULo3dPQKOlZPhlke7
         49P/QOJucbDXLXY24mNps4t0WV/3dfXrnqlXDNhV0DJp1y5hX1mnz3D9wLmV/hKdait1
         t72/eNe2Tt9N1l2D5+U37lZ13hbCkl1mVBtYYPdCfDB9/oWeszi8Pqgg6uBu1IQnLqvb
         Jk6KkYjVG2YqvfkP/x2OKcMnhLMpdKhHUVWpWfWmfmwJM5isyZKAQXvzfTayxcqsG/WH
         qVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592269; x=1709197069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev1kyQhprDpCvHe7EZYUDTfnUl6STv3H7Xh/qtUFz7g=;
        b=d8tdzHh00u1cQmL1VyMhWGReRB5E/rQdN1AcHl8cciLJqP523pfm5xiZibaMLOJIMn
         q6eNQHwRlTJ/FgxRaJYyWusjOnBSWlpkLTZwKPEyDbSllDGEHOqNAkDUbEQUl2+UVnMk
         03HxG76j9dHu4AUt2CzqDd6mFyinemQIrmT79u9aJmO0rEqB8FFbSCztYeAZalX5FRpg
         5A2kJbFVpyUiUP0jH17tsR2WA8dysGpTF7S0OXqbXpXA8WKym6tKron/tC7jnmEO3jKF
         Qao5HMTQvRXM+vvNlzziKvGP+EyfMzNdd2A2QexYoiE9jhhtrebAtF5HJkiatW0IjwNd
         PIbg==
X-Forwarded-Encrypted: i=1; AJvYcCVV8A5YIUZTCO576vGonxTEyYTtV1cjG1uZUVIOftM2bcDlt9vSPW5s+mWBks21AQcfZXYlrxzfTDMc96I4yVU2c5NB
X-Gm-Message-State: AOJu0Yw904X8i/HG/yq6rBByQ4QZmsDoQFtrQZFy32tcoZuDfMDma52G
	xp1eRMLsuJlOBVQ5xpaGP9yhAe5weXnk5D4N35FTwD3XT6j2xf/sOnP43uliwzY2L6oFJnj2aP2
	4+WtuH25gwVqsigX5+3L4wZo3GriZFM8vbFw=
X-Google-Smtp-Source: AGHT+IFbLxM6iQeRNv0k59abagtUU98v/0aFHVmztyOCaWjlj0jsY4/ZhJQdel4snN5BeIdqGJ4CCeUaLrtnn5J+AF8=
X-Received: by 2002:a05:6870:d253:b0:21e:a47f:ec31 with SMTP id
 h19-20020a056870d25300b0021ea47fec31mr14341638oac.43.1708592268878; Thu, 22
 Feb 2024 00:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com> <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
 <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com> <Zdb8lnUSurutauRa@tanuki>
In-Reply-To: <Zdb8lnUSurutauRa@tanuki>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 22 Feb 2024 09:57:22 +0100
Message-ID: <CAOLa=ZSq-X7s2XwFAEu2umrQ5z2fsa=X2ai4EaU5ufyoacncVQ@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 8:49=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Feb 22, 2024 at 10:01:54AM +0530, Kaartic Sivaraam wrote:
> > [1]:
> > https://summerofcode.withgoogle.com/organizations/git/programs/2024/tim=
eline
> >
> > [2]: https://summerofcode.withgoogle.com/programs/2024/organizations/gi=
t
>
> I can access the second link, but the first one is broken for me. First
> it claimed that my Google account wasn't connected to GSoC, and after a
> reload it stays blank now.
>

Both links seem to be working now for me.
