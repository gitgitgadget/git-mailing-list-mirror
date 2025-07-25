Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4D2550D7
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470104; cv=none; b=tA2apgr82KDVkyurH/NTuInGbQD4kXhtfNshT9fmIo9XWxP9JUUTFC/0NTwEAcI16I/d8OkMEP8y0ly1uGuDvLvL/oUN/RQnqPt19GQGHG5vQcZeaBYx1Ozi1Bhkt+0Uj1ksaQ1Pl1e8+kj2Y3vwIRD+nDYlY94yTY2fgYXfrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470104; c=relaxed/simple;
	bh=I5xMJNwmX5Sf18JPLtRGK2m0hs0ZTRmqAk171k5khlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+O4R9xRk0n/rPmxaulpWyAc2ZpOiEOLmvgswIW8OB4+ApsSzU8fXJVt3n7mZKvgSl+xTDmwQrG8S4SUoA2sbAS24qXQynIndLdzK+P0wA38EEjzYspCmacHtOT5pQIf/sLvnf/qnQu6o5m2/4uit2HaZluUzt9Nf/CEqq9jucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl0+6fCq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl0+6fCq"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae36e88a5daso465692766b.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470102; x=1754074902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5xMJNwmX5Sf18JPLtRGK2m0hs0ZTRmqAk171k5khlg=;
        b=nl0+6fCqJ40X6Fltj1BsDcXGcpjfhEiB8occvtAH+ElmbaqtThes7B/5OKfZR75mqF
         LUDPfojwc2AfcUP/Efwtt+oyjP6muD23uO/m2XZFJwthfmB9c4HbNWvMznzEjaef7y6G
         GT7peyP0ehB90/msX0FSi2o8rIyIQ2Kir0LA3JL9aTi+Db+7pWSVK+zPTqsMcYqZm0xN
         lNMmDjWTEJklg8xc3CHFbUODBgrbHd+109iGOPXV59h9Hwn5WNZXOo78WKMThItXZ6OE
         /GWnFoDWgNC8VzC3Vg2+F11hMH6WxM6S75hrwkzUS5/bgc2lGNvhl4X32UjT+lZDbanj
         InLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470102; x=1754074902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5xMJNwmX5Sf18JPLtRGK2m0hs0ZTRmqAk171k5khlg=;
        b=TThXajYrG7G1R2R6K9xzT3EH+w9IHl5ysCGHdagLwuGfYl+HI2q4AP0ZYeE4Wm2FEw
         JRwUilOoXSADN3PY1MkyITeYIE4GgTiTrhiHVeMROp0zyR9mEKpZLqOw0eEoiTY20HwS
         2N/wdmxLrSfNe7QpvVg/tKQNYOJST0r1kcU6N4x0H9gAY/weXzXrFlYwmgNs+O4rEJMQ
         21lpEdiYxbeQ8FHamekSgYQ8NRsLIDxE6Cl3ioiux/ONHHlB21VWSQygowlodvuz2/03
         E+FYkggZUx7nI6+J+pK0HF2zQ+JS79lGtIsbgefjpmSgI1SXI2ygjiWxkBKcXousf8If
         3bTw==
X-Gm-Message-State: AOJu0YxN3SdR20CnTCJT6rVKMUZRtOd84K08vd5X7xaGbuoVhvlvOEL3
	PM+WbaCBzkR5waywqNyv2O3SwPOhQ0MwGMVuGbhEspEUNNZq7TJ3dyCdUsRBhK5h4dNsGMn/iPu
	jSjVO1HbIuo8bnUKWa9pGLiUVB6g2KtI=
X-Gm-Gg: ASbGncur9nBuLNk2m6W04Bz/a5ojtM7RC43z0Q1Ey/i68VRzN+Q7Tmi38LEbbknqqVq
	vvXEN4tb22/IclRkHbS7ln79YrohOopDW+ub0/BFAhmqCz39TqmVOqsA71dQT/GckdMpCSHMtoP
	+kaGXx/ccT8rcGqkpF7wSfNvz3jcvP8kqqXSBX83SqXd6/i6tMIhVIX8fiR0+O3A+6Fkjn+y+PS
	Z6ODSPDgQ==
X-Google-Smtp-Source: AGHT+IF0bY4a5PF9xdqjX2TbcUIs4+dKoJ4TihbtySQjgmgReAT0wiVL1/xc3jDb3X4GHKCvwNYwk7LnEe8p5LnKrts=
X-Received: by 2002:a17:907:2d8c:b0:ae3:c6a3:f833 with SMTP id
 a640c23a62f3a-af61730b8bbmr350221866b.23.1753470101147; Fri, 25 Jul 2025
 12:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4b40536-346f-45a1-84ee-99b1200c022b@gmail.com>
 <CAP8UFD10KuuM8Xu5YDxDf+rzN5r0TxgOw=do94dPO51hOCyE1w@mail.gmail.com> <fe5d1d5e-15fe-4d00-96c4-d5a4a3b568c5@gmail.com>
In-Reply-To: <fe5d1d5e-15fe-4d00-96c4-d5a4a3b568c5@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Jul 2025 21:01:29 +0200
X-Gm-Features: Ac12FXwRLtfgt5P-N5mNtfgtXwxIxNS0LHFPfOUm5I_fQ_PF7Z4bW8pV9XZYIRw
Message-ID: <CAP8UFD19rjmOYR2KZ6qBM2zWMaNJknSdwbOijMRVn-RQoejezA@mail.gmail.com>
Subject: Re: [ANN] git-phoenix - repository recovery tool
To: Daniil Iaitskov <dyaitskov@gmail.com>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 8:40=E2=80=AFPM Daniil Iaitskov <dyaitskov@gmail.co=
m> wrote:
>
> On 7/25/25 10:12, Christian Couder wrote:

> > Thanks for creating it. It doesn't seem to have a license, which might
> > prevent some of us from using it, though.
>
> License is specified in project file (BSD3):
> https://github.com/yaitskov/git-phoenix/blob/9a88c55fd45f28d4e1865df3ac74=
6b409474eaf7/git-phoenix.cabal#L135

Ok, I just saw that GitHub didn't display the license information at
the top of your repository page, and then only took a look at the
README where I couldn't find any license information.

It seems that you need to add a file named LICENSE (or LICENSE.txt,
LICENSE.md) with the full text of your chosen license in the root
directory of your repository for GitHub to automatically detect and
display it. I could help people find that information and be more
confident that they can use it.

> The tool is also published on hackage under BSD3:
> https://hackage.haskell.org/package/git-phoenix-0.0.2
>
> I don't see much difference between open source licenses and picked BSD3
> just because it is popular here.
>
> What license would like to see?

It's your choice and I don't have any say in it, but I am happy that
it is open source :-)

Thanks.
