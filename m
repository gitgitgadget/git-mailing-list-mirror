Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77034416D01
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092370; cv=pass; b=eB0ioeFIorBmE0hr98RF3R95FX2tqUpYlyovsytxk1K8b+v2Q++ghUR7F626TXCY9BD3a0/8722bfHTd4+ks9eQtI3tXoFQqMe5Gsa/SNNGOgKAAtawOXFzdruh1R5x4+GeXeMHDd7NCn4xwbfgOGXurZNRjpUVQJ/HJoXAsB2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092370; c=relaxed/simple;
	bh=vhHpX/usR8AIYVsQGYvsp6onTQBV8FbqRtcgXETDaUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpfUWNtvD+I1PGJdyYmYL1U51SzhUrU2Gsee+xOIeiwaPWMX7NbIqjMyXzBamZN/Ui7tyJ2e77CskvejZvIWVimb4eVvtfpIpje1zSDy0eXh4RjeKhUx7RIpwn3u4cDfNRoftczC99gIyvYOdO7Cq9lgtOW+f/jp9I/6+KAZMLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHQW3hrM; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHQW3hrM"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so927562a12.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 08:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783092368; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhUuLTxhU6NvLRSU7VfMdhPrFAfQLOJq2XaH9TOhwvsy/XeIgMKHX8AKUqD4Kq/F2p
         ZWj9ABydcu/qRJjUgW3n9D5TPe+fpdv038I6K4umqcqQCHlgwmNV3iTal98f2GZD5sHX
         XvZeRy45uKtREq/7XXGcBxquk+3NnO7ZLVjRUGbzB5R5uCypdoKZywJU18qDEa84DZvY
         rQQlaPh2UliVZDCrPdizeChrOo9TH8inu6DprwiVOB7GwqWcjDnhZfKGRE5h0Oxyi0Ue
         RN7j9I66jDeqp3esia0CNLgaZcUcs/CRBeKylR64LtFvadi5CRUm5RqOEN602gOfHw4f
         +4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnyEHclL+zoXeU+2/LpLz8k3SwP9kTydr4KEvyAn0do=;
        fh=bLcjbrYsporO1N3f5Jj7lV9884Wn+hA62L4wDdI18Fw=;
        b=lPl+k7j661HIpDdjn5s4ycuz/wY9b3k7D/nVwpE4ocW6RFceqsS5JwEKbaSXu1TKKw
         Q2e7pVBKa4kR0RA7He3C+NnI4moRt+mcV4iC4GEPyzErCvNN7er7CrGBgCRK7/Jl8M9G
         OgIuD54m2WSyVH85fCtSFOD/h+hhbyT+wI+3U+8FLyWT7P04KuQnV5SZVrc3xWtQaLMp
         6LW64yNwPl+dWcs+pGzydOuYDTzDAxKrt7i+0S63+1RDgK3l2F5j75uQv0T0mtxPmpnk
         kz85iQSLhf6LtR9N9rSkkh+fRAr4ceG59hhNlB2hVHZGWmVVhSP76/8GKC46CnGRwO63
         xtIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783092368; x=1783697168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnyEHclL+zoXeU+2/LpLz8k3SwP9kTydr4KEvyAn0do=;
        b=gHQW3hrMYVkYq2TFco5ryHf658RGH7a0iGmSjb1ZxMJu8MMAn3trBEgyDJt7MCv2oz
         BdNQT0CoC2Bjb2MwBfuKyCu5b30idIxELjdMg1BXlG2D763LQ3pKgToGcGReFPIO5yOs
         iFPkwIOcpLy0lOxuFLZNMlbsnRZQzx9d3OfYuhbii0eRML7v2SqmXv/JbRS1156+CqVM
         1Xn7Sn03+/YX2M0RANeVz5Z7V5jtDoT0OXyliOQ2o2lClnKbwthM0BWH8o7TMqD9mnru
         oFgFIVgeub/PlDQw5gsL/NCk2hMJFlu2YjAwnWrT3ks9l+mIqf7LaVTDNsMdLR4ePZ6T
         tuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783092368; x=1783697168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnyEHclL+zoXeU+2/LpLz8k3SwP9kTydr4KEvyAn0do=;
        b=Yl8tVWRmhGwoxQhu9HYlpQiaZgDiuLexZGTv2fK7F4dLLqPoSojvT0MDiQTKE/xgap
         AEFUVqLAE/0bT7FqZ3eJK+eaOjkEye2VjSoeYBQsEXhJ6/6QQgQnTKOBY8eFtGiatowl
         Veq9tLHKb2jD9R3NNSGkzHItOjJwr6nBZ/LNfUezq7pVh+STgYFocizlt9PNZhifCthF
         OVsb4zNMsIJb9+8k85qbZ+JKLA5BXnExOd3nbMdkeZDbG2A6ul47pomO7vMCbCrjSitd
         a5+TIKOdmefI3NiyiT9Cu6nCWI8gQX6rhsAKEIXv5zaqbgYAxETP29Bh6oxMo5GTAPWK
         R5yQ==
X-Gm-Message-State: AOJu0YwFpMmASOMkigYvkqbynJ9Lq7K8wktnZoPmhrVZKlKQ6ws/QecA
	9h2Bv7di0C5Ct1PVzBJ+RfDWKbqywJhMMLGfxv51CEojykifR8vTmvlr8vcNMjkhLmAgWc2doYD
	AG+dGrPN72Ba6dLEB8BB7wCaT5TktL0KKwuuw
X-Gm-Gg: AfdE7ck5SMf0wKFY+MFm0UkHseYsSJr2YIQIOd6PuF+SgciUob9Af/m6DqyCrFRCjEi
	wLUzeZyszDFfLMsM5I0T0vWkOmEd4ufsqQ/FMamaHhEWMXtWcTSsQvz3Cd9VtveRRCjX1qsd6lG
	maaLcctockjHInolR6F4PnsLf+jdId1kmsUi9OkOeCU1IuHaovGC3h1oc2Q3R4IJSvtBb5+NTlr
	8po0WqiatMwwF9bu99/qIQ9ExfFQPEdkbdEGZuVD0jGIla0eEbNfdxF4+WxAhpfRtZiMVoBE4fw
	l4++yw==
X-Received: by 2002:a05:6402:4497:b0:698:bf45:cd45 with SMTP id
 4fb4d7f45d1cf-69a1738ad2bmr139550a12.17.1783092367622; Fri, 03 Jul 2026
 08:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <323134122.20260702104910@gmail.com>
In-Reply-To: <323134122.20260702104910@gmail.com>
From: Mikael Magnusson <mikachu@gmail.com>
Date: Fri, 3 Jul 2026 17:25:52 +0200
X-Gm-Features: AVVi8CdTakK4L3XZkshUT2dMQSkqWfqAtTPJus0e8O3BvB0JwQMyPlhvd4SgUrM
Message-ID: <CAHYJk3RXY5-YgcYWY2y8vOcHG5Frf91ehNiZRr66sJJH5F=qLQ@mail.gmail.com>
Subject: Re: Unexpected recursion in 'git rm'
To: =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0J/Qu9C40YHQutC40L0=?= <eugene.pliskin@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 9:51=E2=80=AFAM =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=
=D0=B9 =D0=9F=D0=BB=D0=B8=D1=81=D0=BA=D0=B8=D0=BD <eugene.pliskin@gmail.com=
> wrote:
>
> Hello.
>
> The following git command does recurse directories as contrary to the ref=
erence (https://git-scm.com/docs/git-rm):
>
>     git rm -n *.json
>
> Without directory specification before '*.json' this command is not expec=
ted to recurse directories, but it really does.
>
> git version 2.55.0.windows.1

I can't see any formulation in the manpage reference that suggests it
wouldn't recurse, though you might overall get less surprised if you
set the failglob option in bash. Then the shell would notice *.json
has no matches, and you'd have to say git rm -n '*.json' to let git
process the glob instead of the shell. See also
https://git-scm.com/docs/gitglossary (as referenced from the git-rm
page) which says:

  the rest of the pathspec is a pattern for the remainder of the pathname.
  Paths relative to the directory prefix will be matched against that
  pattern using fnmatch(3); in particular, * and ? can match directory
  separators.

--=20
Mikael Magnusson
