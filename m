Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABCB13A89C
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452194; cv=none; b=mqATsRL3THb7424zR8ClzOfqc2FdICBgsIIiKUGQBnk4X7h/vQgTAN1lkFVrhZODGhIC7sU3LE8ooKL4eRyhRKOpPr3Z9jntTiI5Gsw9CFINGJ45bDyUIZE7NpOuzpPO3IrH0hwSFKhk09AoDoOLG2ML9bMq4OILyLeKQiaO1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452194; c=relaxed/simple;
	bh=Y1adQzYDxMDUkfZUKOiEGxvZAUVoZZD33mi8MiK1Al4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhORTeoyovVzi7u/hAqHqKBVXee7UDbkF401/7kEma8gQowQOXLO/B6I1rPH+elad/qTdJcGXFe2Vgpw7Eb+s1NCFut06HkLsmlOwCX/4hYi+Hq314CE8I/9JJB69ZFKEZZ2jeIHV/m420IoOecNVlJwbGhVGkQfqQBSpkH74VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6af25fd44e9so18203826d6.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 15:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717452191; x=1718056991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZd+7ybeLSSO95IHucRxrLaqdbJl6sYykxQPBhG7tN8=;
        b=qUv7Y4sewsyD18W3zEOQeRfyHz5csZ6KAafHVWnb3FRkLzJFzhWQ/gqHKy4rWooUEA
         x6e9mDaL+tGnb+f7sg2StUIeUnj48c6DW4WIBDzK3/Yxg/+RaGoJK0ma7cWq+m+mBRcU
         fBRHUgG4JdKWQ7iw8o7z/OlpTr6koKNbRN1ZfDhFREJBw7CrjgLVV86Vb89Cd4/TcjRu
         q3VtymmydqXqWdqtvMipC/z2HZ8rmk7u+rP1vvICNBDVElrubkFPNw5yQ0C2hl5TAKwy
         CXq0nOAawlvr+YU62/yQS+M57pHgC72JV7FaVacToUnzBWZtTGceVE0u5oFEjZGneB7Q
         /KSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqzwvVsYhEQq/GxyhOkW0KcxuH7Y8+sH8AJQwOQoouiX80zKjo/qKy+kB7q57uSTuoJ4/dZ3Hyi9HTAIpxQcrzR3i1
X-Gm-Message-State: AOJu0Yx4pZzp7ps3xK3OA9zoP0ukK5dIHSVNJA9Eg2K/Q+klNpjiLzHJ
	eduVUxj16N+YnAOKN67JR3DVLGnMaIdSHRZcm8X2KV3z3pfucVmirQlfJORosjyc8XMk3hGexXr
	oSK+x2q9Y2LE2ki5sdpANWCik1qxUIw==
X-Google-Smtp-Source: AGHT+IFGUuslE1b+6gkak+IdxFrA2Q8quJjP94H0GVVtdZ2vNsr0yIZboK2Pgnro5Wji6dQz+XnH5vGWjACS4+UFKeY=
X-Received: by 2002:a05:6214:3d9d:b0:6af:39d7:a0c5 with SMTP id
 6a1803df08f44-6af39d7a5d4mr78683896d6.4.1717452191585; Mon, 03 Jun 2024
 15:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240530122753.1114818-2-shejialuo@gmail.com>
 <CAOLa=ZT895c-ag-8_r7SfJ+n92-S16JfCYgYhQf0caxg63cisg@mail.gmail.com>
In-Reply-To: <CAOLa=ZT895c-ag-8_r7SfJ+n92-S16JfCYgYhQf0caxg63cisg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Jun 2024 18:03:00 -0400
Message-ID: <CAPig+cQxnNUGT_w_chPxgufQpie0cRccipifOz1ZQS49JsgByQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/2] refs: setup ref consistency check infrastructure
To: Karthik Nayak <karthik.188@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:56=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> shejialuo <shejialuo@gmail.com> writes:
> > +/*
> > +  * Return 0 iff all refs in filesystem are consistent.
> > +*/
>
> s/iff/if

I had spotted this, as well, but figured that the use of "iff" was
intentional to mean "if and only if".
