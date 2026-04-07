Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABF38F62A
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545124; cv=pass; b=AjxV0ZVf5k4CevOaop/3GBkOgPi0H1nNGNS6+Ysvw2ioZUzEf2AJCip9VQNEy+z6qFQpMWdZWyYtje2dzclRrLokDTqeYH9edJmrBOdSD2FEnx3x8+HzXLzlUMciQeYtjPSS+ybjXaGMcEMiRltR0J/ll/yIpPV6PO4FNqrSNSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545124; c=relaxed/simple;
	bh=+kFn84dqDPSzB/8DKgrTS9jQXKUAK49AYPbd5KEK/oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiq3RDWH9Ngzl/k/UmysewMLfvi7HkWReX9oaM5iKJPcNbZ1tql2Qxc+gH7I4Kj32Ha8M0A5cP1sh+0oOH3PofNvqzutFkhBVobXEFYJi+CbBN+tc57m8QgVim8SyzDlMNNgGwn/mlPWPF516YSp//JdHwqTgCCaPxAHD+OfWMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDL5W/wD; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDL5W/wD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-127380532eeso2979190c88.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 23:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775545122; cv=none;
        d=google.com; s=arc-20240605;
        b=X4WVT2kmC+VpVemnFoupUPZsOE4/GTMq787/sKa/oUw/YCYU6IRwRHBL0XMk9rChsJ
         GDSYqYE74vUJlB2WdCnW4Grk7aAfYKb5GSX19JpWdpt7x8iW/z7MtrNmzCD+pxRrjHUQ
         mOyEXY4XHxO0Is8tDWElE2CDzADF9cmqNsAPE/44+ogsQuK8lZrK5hd9TmbvjpuCLWJr
         8THbMQujUR0tmdhin7+ziOqrxSuwfhVigz0cTa5DQUw65dvbNX76veFxF6KUcD2MSsfT
         75r0wqLrM+DPXcLaqLxdcwnnSYnEc4hqkzx4E8VyDnKHfZySJK44u9TO1+Bg6kou8XDV
         PruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+kFn84dqDPSzB/8DKgrTS9jQXKUAK49AYPbd5KEK/oo=;
        fh=xo4/eVEn7Wj+xqfyG5ybqduwcU/zlHd+qYlyIeUZPW8=;
        b=bu6uQY3KtV1ANsOLvyEUAoJy2R/85YwGly98asL2qRg3FeIqP9ElI5YMe7uklvf7Ya
         jAu+8mJPZlkLyTytsPO0XTYKiR+IAojkex5kmnd+nV9dyy09DvRNSC+09pZSSm2gTtB4
         MGawsuG9HWAbKaZv3cp0G4CyNqPVI3HD6OZnSp/v9BhZJzhY6W1fLrWTMqXPlzAJ5YtS
         ChgMECtyf8UPrfGJnhLUBev/XOv5tB+60N1h/9qokHLeQ6UZLmFO5MtaeQqaxolJTZgR
         g499dEU1zh2Wb/yv+Opl7KKWSZLbJqUGbPNT7aZPVmlt4hII4FHn6dEU+H2RKaL3JD1x
         7IUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775545122; x=1776149922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kFn84dqDPSzB/8DKgrTS9jQXKUAK49AYPbd5KEK/oo=;
        b=BDL5W/wDXvyzMqgFNQdm9bq+7i2EEyuR0lJJtYTV6NwSLggmcfDy/+bGNJntPQ2nVi
         Kt3stF33wlNVu9F0MR/ZnILvWsYM5DGndtPlucKxA2xUFXT7H4tOJGpR2pPcpcTOwEYa
         alDe+3D/N8ksbKDJG03fiDueO20AY3xRD935GwCM+lnAxN2l9n9/mbUX3niL0dkMDNGS
         WdKAgRrhops63RfCDI1xj10SqAN9IjTcNpLLUsdDn3b7CDoqAXynyTRSjOBMjjG2Sd25
         YhiHjg2MlAL5AMX+kD48Cbp3d2eeuX3p/rOgS3xKzzaO4cxn4Zmb8iwtwDiYxDJXoyjR
         u+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545122; x=1776149922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kFn84dqDPSzB/8DKgrTS9jQXKUAK49AYPbd5KEK/oo=;
        b=ZEjeRZxthPd18JoRlTb903NXfGEsvro6wZ7IsAJ0gNfzp2PvwR5KLtL592AWphBtw1
         u2oMKQn+UNnLv833XZZQyK5cbpWhr8bAk+sRvJ1eK/qOr00GSMZbepgsROqOzH701L5U
         +iCo/LuERqvsJL1Y6UoYBPM0t1KujGcuRsZ4Y2u20XiN/ts0Fkjp29OZscMpGXl+HCYe
         QvFCV4rs/n+Zw57HeufnAv/Diec2rbosPZDoBywntxrad0dzdRbgHuluLs3B2qTIzzzl
         Ax895S6lDAxf2cAbTfb42VujUgghuuMYH97mmpfSr6GsDJU1knbEL/Mx1CO3UNfgwIvY
         +PQQ==
X-Gm-Message-State: AOJu0YwcHVCFunQq3dP4/eVUP3Cqbns6zrd7U2iJK/XoyTkFTnBFAhyc
	wo+LP6NPPsMmt6zBsXCP4SMBL1ZSITNWHgJe+DJSLW1ywPOVvle1VfGchdm0CUhsMC4scUD5mmc
	776EVJz45uRiA7svkWMSEWFG6CwuW4Pw=
X-Gm-Gg: AeBDietlqe/KgAAJlyAoU8tKq+reUIMacQhlkOrtUuhtKQdpcdCBmlSO0blbI9C+xeY
	3O5uXBylXXtdpv1EN7giNBl+zUm2duSuD7op6Zjxswa/bx9gCGv12tVZiP/c9+BYxvon0/17k4R
	W84vMX2gF23FQF5Yawa6ebxZ5NmHmi3vfQJWpUNUNQZBz65RTVjhoy3hYcIq/b0uWI44kApfzrg
	fu1r9DoQChfK0F5z0T4/j/nEvBNLIcS1Kx+8WNwlDcUAZod7X4pwOV1t1k6aWstMniMEqDiY/T5
	sRQV7kxM5p9IyGS/bF7WOecj3qSQzimuPSjCfWGBtESPVP+nR4SKuHo2VaMev5KpAhLl
X-Received: by 2002:a05:7022:6713:b0:122:153:d161 with SMTP id
 a92af1059eb24-12bfb745308mr8341370c88.17.1775545121772; Mon, 06 Apr 2026
 23:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL=1hhxP08w=pMa39izN7SyFzsv+5HWZhtzhh136ZmG2dg7Xtw@mail.gmail.com>
In-Reply-To: <CAL=1hhxP08w=pMa39izN7SyFzsv+5HWZhtzhh136ZmG2dg7Xtw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 7 Apr 2026 08:58:32 +0200
X-Gm-Features: AQROBzARspfH7hjsN8Q9jJ6MHNd1_5Q6Qw4NJb2dH0v6-ZhMQNUM3TYsbKbScxU
Message-ID: <CAP8UFD0uAr6-aXGV1+HDFVczXGTc_K-E-jqVvqTT9JJ=QT2L0g@mail.gmail.com>
Subject: Re: Super repository
To: Gabor Urban <urbangabo@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 6, 2026 at 8:36=E2=80=AFAM Gabor Urban <urbangabo@gmail.com> wr=
ote:
>
> Hi guys,
>
> I need some help. I could not find how look for solution.
>
> We have a project in:../foo/Project1 under git locally for a while. In
> a couple of days (or weeks) we are to start two new projects.
> According to the management we have to make ../foo/Project2 and
> ../foo/Projetc3 to be brought under git.
>
> The real issue: we are told the create a new repository for all 3
> projects (inf /foo/), but we must not lose the development history
> stored in the local git repositiy of Project1
>
> Is there any good solution for that? Thanks for your help in advance.

This looks quite similar to the example on:

https://github.com/newren/git-filter-repo?tab=3Dreadme-ov-file#simple-examp=
le-with-comparisons

Best,
Christian.
