Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02831F951
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726807631; cv=none; b=By57FZ0t3PEupmRaJYSFnAdqaF3nEBLCY28EXOqCqYeT1uukUIqY5n5hLzd8rucZDVd4yI4sZHzi8qtRZJfCzekTaNoTuKatZuL9e0WSSLCl2e2SFn1f3JDlp5OL1VnLlDeJ+2o6428xnsgN8v25VuaWTgqtLWTampVzsdYPQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726807631; c=relaxed/simple;
	bh=F0SNX9RDVlXBevtmDvW5Ias04pp8d3Inn7IxFug1Lqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF5jEtO88XIRy6dhj8wI4RwuR9TpC5+5YKJtx/6Fg0qu13u87ZwSTLMmmKsrLwceG/CAWWDyhFt65kYbEuhKEs7pSEfefffWr0aBeIM5/3kVJGJrzFYU0qivCpEzu9UzbeBH4rz7Fx4J+ZCgF4hysGKv9yIpvZh/3UUjzwgBX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c35e1e1182so1793486d6.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 21:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726807628; x=1727412428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0SNX9RDVlXBevtmDvW5Ias04pp8d3Inn7IxFug1Lqk=;
        b=MQUWeKpllab5+t4r02Ty+k8zSpp7uoSzUJqkeYlcG2oW8JPmrZLryu4lEsx63nconY
         FFzQ6rBfk2fZ80atrte6SnGDSJrWwVaBM8+4FlX06Frn0r1Yw9eZGyiDr+6pGTHUc0aQ
         7hJrl8XaF0UaKNJPRVqP+QIoDZVbBN3cKnjbE+U3yKSPXqTSu7BWvh+2+nr7QF56SyEZ
         tvYyAcd4mcCnMjgiMIHPNsEHv8kme7xJ/uGzJotsBAJOwoIhaYLgwLp8FDf3GDngnj1U
         WGIXCj05ppVswLitzE7IZ20mmX5i2e37d2lpguJcWwII4nlUggaVQMpDqa1v/qMkE0m0
         QjhA==
X-Gm-Message-State: AOJu0Yywd0pb13EviRmKxxxOUdjNOuENWSOcUoN5oRNJmmppqVBhjdBK
	03MRoYC4iSUHqI7Nd9dQwmQeRU3sr1PmhpBClcU642xO1ScBorr35UqmpkswfZ/UPMV2d5hZdhc
	t52UOb7Xo6oyXFaKBhGjHlABDQxk=
X-Google-Smtp-Source: AGHT+IHqyiXMCgG14n4T04JJE/RVuX1cNhUmgNyS3rRIptFB7n1wHRShatujVRI8wGmvNMS7h5HxA8fg7WaCgYLaJI4=
X-Received: by 2002:a05:6214:250f:b0:6c3:6f2a:1fe1 with SMTP id
 6a1803df08f44-6c7bc681fbbmr11403046d6.2.1726807627806; Thu, 19 Sep 2024
 21:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920043935.56805-1-carenas@gmail.com>
In-Reply-To: <20240920043935.56805-1-carenas@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 20 Sep 2024 00:46:55 -0400
Message-ID: <CAPig+cRQUbwjo-+1mF5NMfi7JNPH_EP9E9LMmYiPWX6n-kwvQA@mail.gmail.com>
Subject: Re: [PATCH] ci: update FreeBSD image to 13.4
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 12:40=E2=80=AFAM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> FreeBSD 13.4 was recently released, and that means the version
> of the image used by this job (13.2) will be out of support soon.
>
> Update it before the job starts failing because packages are no
> longer compatible or the image gets retired by the provider since
> it is now EOL.
> ---

Missing sign-off.
