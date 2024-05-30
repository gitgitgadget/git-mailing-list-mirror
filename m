Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCE20322
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055564; cv=none; b=NG5R3s9kLng2z1Op5ivtS0nmYMtJ9OKZjyl+rR2QfYmUl870oBNu+TwN/nshFjpI131PQ6khmW5Ee7z7tHg13shBKXF/1JkizIrIQxcXvEljwPU+kTK+Cn3blor3R9puhNjYn5o3zPOueSFpao9Iuk6Jls8kkCpLytIlM8QqDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055564; c=relaxed/simple;
	bh=1OU2aTuWwLwG2FzR2TXsto3VdiD2zHqWRwoiBxEqod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2yqeLX8LJ3+m5oZGtuid/nDv4CYPtD5Cwaqf3ikZaLun73FNivgjimxM9fWTFqpROxHzC4q1K6gpvj7aS44DS12XOPEVaKGU7bNj9Ht5jCLc1UmXXgSq394gbEKhOBucjpiPgRhi/Zv3fdg9BgdfkSZRTe2Dd0B1Ne4dAs5It8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZfDLNQP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZfDLNQP"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73359b979so6162011fa.1
        for <git@vger.kernel.org>; Thu, 30 May 2024 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717055559; x=1717660359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OU2aTuWwLwG2FzR2TXsto3VdiD2zHqWRwoiBxEqod0=;
        b=lZfDLNQPCIEVKJgU5CzrIV7bosCzLbO0/f/8U2zBaWmvYfIKtAZVr6ZerHIjN4cZN/
         7v+DOgGyUIBEzOWEdUmLHSqlXTPn8/fB/tWpgO6KW/ADGyO7onJJQeU92lSQVhpQUPYf
         xUyU9UzwrkWhMdFXHV1j703vlpn25eZXeFdkxC995MWASgajnP34+7TxyE7HVmlBFkSA
         /b2EOl7lH6c5Es+UHU/LdISfOcp/JXw7Gw0VvLoUeDhWlPYGwuJ96D+SgG8elL/KN26X
         c4mgVpOCoUWx3i4a1tpcC/NPKc4nYj92u70d0cyIkWoXlBsBXiis3oP5/+RNdNnhb8BE
         LbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055559; x=1717660359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OU2aTuWwLwG2FzR2TXsto3VdiD2zHqWRwoiBxEqod0=;
        b=ekBK2T0mftw2Xx9zG8vqQq9xg3IfsamrJp/xzXttFiRrKBuXx3faUy8uof9Euua04j
         Or94ZVsn3LlNiu7cIaywXlr11a2CeCmU0JsW3IkKyNuIQj49W+pPh/9VJSdubwyPYYGT
         8/jXS3ys51dJPQDuOYYkn4Lmre0lY0MJaXB77a79jgfTmHGRyOswB5phaTUK3ItuaeJH
         vrwab/SL0/epqFtIp01vzQjS1oLVOfjyQgWOxJOdAluW3bA+66qZYqkoyqn7WnUXuTKZ
         nWyO0UlhcC+H7INZsBjgUUe1zlUGtQq99AClB9jNJ8Rz5Cy6VBbF73YUsEuSVdSNNDfU
         tw3w==
X-Forwarded-Encrypted: i=1; AJvYcCUw0/An/WeOy2uH1gQSiInIc1hePREn0YVUvffMI8pAHTlvQMe5hGyVfe+TsbO+rnNcQQgMb+72eBKUypCXZDedlvH2
X-Gm-Message-State: AOJu0Yw3QXVLam5xzGxa5hcllL1zEv4H4FRWDK6r+g2GWWJzO3n2qe+p
	f/lytnzzf+ZjQrNC4BUFbLrTodMu5I7O32Dwsd1lSbVcydeI3484OIlrdao+QIg7xLamH4vcMmq
	hC+Iz4qBGY22URX29DTucjxceFbFXbA==
X-Google-Smtp-Source: AGHT+IFEB68pZ4n8Z5bXtvaDABhpiRHlHfdYy5gMcbSIG7zrJVy1NX/ZfTl2TYP9Pw482CItomjiP2ukZ+Xwp5jyMD8=
X-Received: by 2002:a05:6512:2c97:b0:52b:77c9:183 with SMTP id
 2adb3069b0e04-52b7d435138mr941343e87.33.1717055559214; Thu, 30 May 2024
 00:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529171439.18271-1-chandrapratap3519@gmail.com> <ZlgCKsawq54QNe6h@tanuki>
In-Reply-To: <ZlgCKsawq54QNe6h@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 May 2024 09:52:27 +0200
Message-ID: <CAP8UFD2UrestEMsh=q0WOrJjk3DwhOz8XpweggWQ+VTwCpDtsw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 0/4] t: port reftable/basics_test.c to the unit testing
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 6:36=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, May 29, 2024 at 10:29:26PM +0530, Chandra Pratap wrote:
> > In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> > testing framework written entirely in C was introduced to the Git proje=
ct
> > aimed at simplifying testing and reducing test run times.
> > Currently, tests for the reftable refs-backend are performed by a custo=
m
> > testing framework defined by reftable/test_framework.{c, h}. Port
> > reftable/basics_test.c to the unit testing framework and improve upon
> > the ported test.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> This version looks good to me, thanks!

It looks good to me too.
