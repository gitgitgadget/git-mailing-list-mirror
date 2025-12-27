Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09173A1E94
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766830055; cv=none; b=rot6orjKDx9B8NMMn2HV0YpiykJ2uChKTFZjIvTgyCyu1bYaYng2fQxxIPLtK0TxP4FrcJKAUb6QsjibxZ+Zp/O/uv/7WechA/0U7yCBhuEbjiLLF53vxNhiAaJfSfamhmMMHa3s6VUaLxhpW5Nbc+59cOJ7b2Wabm0lFRk/vMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766830055; c=relaxed/simple;
	bh=/r2V1nzLx838PO80uUNUNOOBaCGvgj3Ot+Z6lwYzZLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDSRWIHz9W8EtB/ceqcgLNe+KOjlNGJQbEyadAc12HbQ0XmL1NkYhizHIjEvsfMHs7c9g1X8+leN+UYibSktyI5dmvZgbTrqD5m5lAZjRiCTysuP2YIUS8G+lhayGP6Pbuv90UgoQLe+D5fqmzPjdqXLHeZ00YmkwVPkVOKvsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eknhQN3m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eknhQN3m"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7a6e56193cso1258202266b.3
        for <git@vger.kernel.org>; Sat, 27 Dec 2025 02:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766830052; x=1767434852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r2V1nzLx838PO80uUNUNOOBaCGvgj3Ot+Z6lwYzZLo=;
        b=eknhQN3mTJMByg2d/izv3tGGLK19atI6aDHaE7f0tifvXwyPR03V56wX1vG6zvBq12
         Id3dqjw6mDHXdlEaMdPy97ucYMNzyqaxYwfN26RSntPDCOqsUWd+8RFwnrRlg9gCwZMJ
         9ITORdqhNE292hAHxZ4VPKHFLvRgarYbv5uVVMwNjshpu5LnKBRWlr/1Q/fqxpTGE7k2
         eqmErP6FYakolqqydUl200eoNTbSyyUtLfOET5CFxw4/ZnzXylSPQh/KpEYxVL8MBwtn
         QBisRicS2xkyhPChsxpW3ETUjwU0GEWkLReBzdUEz4mkGfuGDN1NMWQbt4toDfi6MGQk
         sirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766830052; x=1767434852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/r2V1nzLx838PO80uUNUNOOBaCGvgj3Ot+Z6lwYzZLo=;
        b=tV1gyZ7tUlf+H7cS/MPqsx485VgampXqFmWgdkNG84OSGlJEriv764os4bqJE0onXA
         UrNGoNJCmcXtgFBgzkU0Z8+D5y0RBujCOQ32zLJdPuyac3rGicMdh0snk2QUXmhg18IW
         5JrLE1bAoazHhr7HMJg3uBtnh6wzCPlxaP2wqMCaK7x2N+1ffV7Ig8y0uHKzfDdNiXG/
         o6jN17AtVlYXJF94UIV+f8IkDR3t8EcxonDnD4XJQWnXAPwCh0MjBDMm/huwI9OV/TmH
         8VqxRSw2PVpc16mzCaSIF+11BORZ9Z2+sYd7rTPTzuwdyy92z2jYLeHJ3vqJIBnlOvaW
         lBng==
X-Gm-Message-State: AOJu0Yy0GH6ZBV3yoP3/s56vGMjGtH/llvX/MkVqM5TJZ8tbM/LagnyQ
	ScBbSUbGAuovrCBVpPn5T2eois4gizE5HO2MNjmuVsZlGJMVCOw9E+COw/eOSJJj913v49DbOdI
	rCJmz5vYoaJH78m0bhSTi1XVdcS4qz8kzA2rO
X-Gm-Gg: AY/fxX5AMv5OQgBRCN9S95d+Z2Q1jTfo53jKtEtkr+wjbqNHV394bWPMhdNl0zxIQIr
	0GeHEbIVTlRz6/9gG27oUiU+9lUUc4aGVfHzxwp4f+n+l2FWxCTFIVFICUcGFKLEMfns0/97M9p
	Ug02KazwkduyoMliC+SJ+YFjdI6+2wmWEh3E/jrR6II+m+we/KD31kZ4/FunIe1fJJt14+5oOmz
	YUaYqPovCTEeqBm+h90ERzVwxyFSBzniTfI/Mp5W7wCzif19aE6750xmXXTzMLmEb+kkGBrzbTe
	0xCVyEVEOqlqkPawQgTi2gJL8TFg1+Emc2i96oOBUnLyRWK1mcbXxtFqIgIe23DWfjY=
X-Google-Smtp-Source: AGHT+IEJOUzDj17aVcafyY004oz2iJSboiPy0J5wn/rlmDCroU8bZd06kDO3mg+TXAbpCdh1nQ5Sy2AFqQBxRAc7ifI=
X-Received: by 2002:a17:906:730d:b0:b7c:fe7c:e380 with SMTP id
 a640c23a62f3a-b8036f2fa9amr2612290266b.13.1766830051656; Sat, 27 Dec 2025
 02:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be87d487f73e6c68ac3064adc192a747@fastmail.com>
In-Reply-To: <be87d487f73e6c68ac3064adc192a747@fastmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 27 Dec 2025 11:07:19 +0100
X-Gm-Features: AQt7F2r9T8UGK2Wm6bDhgSnZtGPrUISVxZMhjnZ7BqVgvKbXKXhPfEcXjk33BS4
Message-ID: <CAP8UFD06kTxrzdVA-uRpAkGGA6itWuKu+6RH5YPWPmFFU=A4=g@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To: Andrew Chitester <andchi@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Dec 24, 2025 at 3:14=E2=80=AFAM Andrew Chitester <andchi@fastmail.c=
om> wrote:
>
> Hello Everyone,
>
> My name is Andrew Chitester, and I'm a student at Cape Cod Community
> College working towards a bachelors in Computer Science.
>
> My interest in Git flourished after discovering Magit in Emacs. I've
> kept some notes on my progress towards contributing to Git on a github
> page[1] and my overall goal is to improve my ability to communicate and
> contribute.
>
> With that said, I think it is in our best interest to learn from each
> other and collaborate. I am determined to learn about Git and am looking
> forward to becoming part of this community.

Thanks for your interest in Git and welcome to the community!

You might be interested in the following pages if you haven't read them alr=
eady:

https://git.github.io/Hacking-Git/
https://git.github.io/General-Microproject-Information/

Best,
Christian.
