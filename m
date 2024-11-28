Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E991509B4
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732832842; cv=none; b=qNDz/R4fA9nKk0xhnwlMbFS0s52VYynPocOihhaxFe8ydFwm8ZFQlpsHtKOV2KbD/J7uzv5o8T8YV6a7iXaIFkidt0viz/UmvfmzIgn9gWquUq+CsXRy5yBr/esUi2qjFqktz2OEVKOwqdYGA4bPm2wB/yv1e43n2bOP7TG34fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732832842; c=relaxed/simple;
	bh=wxYi8IoB8CdkZfAgSJtM3dw7kWHPvjme4PT88y9Al6I=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=AjBWXgQW70IJbzSsR0QZnpMg+mrLNmJBkkpyspcdvEzl0+LU/8NXiSjxm1DadiFcJOtS3U/epu7QCzh+9E13LMT/WVCDucYLnEcnMcUfPI9z9ObmG/wKT40lPmwHqDVh0/C8bIoSPHaIMItb3948iUQfz/b8yS+GzLTrzDlgiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcZCAxHD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcZCAxHD"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa51d32fa69so175510666b.2
        for <git@vger.kernel.org>; Thu, 28 Nov 2024 14:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732832838; x=1733437638; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxYi8IoB8CdkZfAgSJtM3dw7kWHPvjme4PT88y9Al6I=;
        b=mcZCAxHDwrPFc9WWWrD+pctAyqI+fVOPaUhLYVrbgzAU8RcJHBv96WKlAqDgXPpum1
         MBbjVkcgGlfS89bXB3muc0o39Fyhz0Q2rCkoG8zANHQS7k8yrPVCAdN4QQ2eXs74yb8T
         CmevSr/ztuYiSx39rcC+uBU3MWbCRdyogcL88GXcy5LPhJfOn5afIttV0XYMXxL327wJ
         pT4c+7YAZcarg/yc0xCLSnP0apkJBD4RPU/xZ3TmtBpK80DzkZGnxusIQ0m32ItJNKE/
         nZFDV+Wk1Fd4x0gXK2el0O1CBkk3UpcYjnWHkNhPkEL4eoLfpErLm4ADetiyN5gbZQZr
         SQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732832838; x=1733437638;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxYi8IoB8CdkZfAgSJtM3dw7kWHPvjme4PT88y9Al6I=;
        b=cxIfPkfYuXASX8XiuGXiMi1L8kDlXrUT7Qhud8in9uspaQBcwTs7QBN56jgCS4lHHa
         mcYfsyFcAB67VnMStLXI9a1xr7Et3wQEmg86xY8fVlDXx/DyIXoSeTczB8DGX6Dnugxc
         eXKxXNkiIQOU2NAsuz7pMil+5pO2045d4T4MOmzIQB/XKRKiTFjCXpjjGkbevy7a+372
         0DYqvLW4M/Ks3fwoQUjRUdvV2jT4PBxrZ/Is/MP97BPnAVjTU6sHh3TtfAAnHmN717TC
         KeDVpiq10CtGAMAxya0Jg9FEO7NbA3qNN1OWMngpzLNCYFbmAQ1FfjmVPnTIuCtLL6x2
         8gjQ==
X-Gm-Message-State: AOJu0YyEkR5am4ohaV/Fd0RTY4CKJPvRaPx/vt0jz6OYORb9r0k3iFp1
	uFtsgev68NFMcfCraKfVztICyCiG2JS3tXe5RPDkuJQeY1gR2OG5
X-Gm-Gg: ASbGncvpRi6QISjNU5YsPSv2hSOG5G2j/CLJKZw4UBdiqzvnt/7E96dZ8of0OGknPID
	/sYMHTUHiX7zFk89s5vEPwe6vdao/KBwPlMT6pHwuMf7eZGn5eqv9JiOeJonWvd7k5PDgQfrryL
	EcOiTA6o4hoLjcnZhlF4AKc4x2pkTsAsit+E4HdowAuoZdqkCgF+7aRtgW32SUTEVUu5VSPTVdR
	Jjc8UlpOS/hkDIjHQOa3/yjEfFgT7uHmoja/2eh+aug
X-Google-Smtp-Source: AGHT+IEMAfjLpIFckmmI5gr/CtW2YCrsVA5hppdobT512biYb4GPT8RSnXu+vIFtT+GpFVnYxl46bQ==
X-Received: by 2002:a17:906:3cb1:b0:aa4:c721:fac0 with SMTP id a640c23a62f3a-aa58102aa40mr670972066b.40.1732832838382;
        Thu, 28 Nov 2024 14:27:18 -0800 (PST)
Received: from localhost ([5.18.181.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c1738sm108191766b.21.2024.11.28.14.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 14:27:18 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Nov 2024 22:27:16 +0000
Message-Id: <D5Y5Z3NCOYPB.1VT7HMAHZTOVE@gmail.com>
Cc: <git@vger.kernel.org>, "Lessley Dennington"
 <lessleydennington@gmail.com>,
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>, "idriss fekir" <mcsm224@gmail.com>, "Joey
 Salazar" <jgsal@protonmail.com>
Subject: Re: [PATCH] git: fix paginate handling for commands with
 DELAY_PAGER_CONFIG
From: "Matthew Bystrin" <dev.mbstr@gmail.com>
To: =?utf-8?q?Martin_=C3=85gren?= <martin.agren@gmail.com>, "Junio C Hamano"
 <gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.2
References: <20241120101741.8225-1-dev.mbstr@gmail.com>
 <CAN0heSoryo-DO6WXKqqASJ5nDLqb3PNNiZv1TP=Pq11wsiSM6A@mail.gmail.com>
 <xmqqmshrrxpq.fsf@gitster.g> <D5SWT5JKU6S9.2LH8H7ECRZXXM@gmail.com>
 <CAN0heSqb+dzGAVnN6=_AkKa-qh4GYo7ku90No=uXBg2+wobL1Q@mail.gmail.com>
In-Reply-To: <CAN0heSqb+dzGAVnN6=_AkKa-qh4GYo7ku90No=uXBg2+wobL1Q@mail.gmail.com>

Martin =C3=85gren wrote:
> If `git add -p` is a long-running process that wants to repeatedly
> launch a pager, what could the opposite look like? A long-running
> process that wants to repeatedly launch an editor? While paging?
>
> Maybe `git rebase -i` could be one such example. TBH, running its output
> through a pager might not look super-pretty today due to it producing
> temporary output that it then erases, but at least it works. The editor
> might be graphical (or a script?) that won't actually suffer from the
> pager running. Killing the pager might be unwanted. So I don't know.

Agree, killing might be unwanted. Another approach proposed below.

> What is the original problem here? Is some kind of tooling issuing a
> `git -p tag -a` where it's not possible to teach it to drop the `-p`?

I faced such 'wrong' behaviour by typing commands manually.

It feels like one flag should not break execution of interactive commands l=
ike
`git -p add -p`, `git -p rebase -i`, `git -p config -e` etc. I took into ac=
count
Junio's comments, so please let me describe situation in more correct way. =
The
following is related with workflow in terminal.

Currently when some interactive command is called with `--paginate` I see
interfered output and cannot proceed to desirable actions. A good analogy i=
s to
call `vim | less`.

What I want to see is if we are calling interactive command with
`--paginate` (1) it would rather fail explicitly with an error message, or =
(2)
it would close+reopen/bypass pager when some interaction is needed. Bypassi=
ng
pager is a complicated thing, I'm not sure it can be done (because of how t=
hey
claim stdin)

Of course we can just simply do not use `-p` flag with interactive commands=
 and
provide some info in documentation.

Thanks!
