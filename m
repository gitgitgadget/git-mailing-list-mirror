Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4B261585
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855914; cv=none; b=dUdLY9IyJ7kTbIi4r70MWqeICzXKHbvriz1OGlfd1NiIw1cnrX3mTQkdGXUhJtB34nmBTzmUJgfwwVAraugphBq6PZZams0v7Ql1HcmVye4Ts2R8BKHGgRC3q69OH2G/69qwQdMQV4RbTC3VXnlG9I/rDqjI2/u2uWpILnodrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855914; c=relaxed/simple;
	bh=w1zTkdPiF8QCqtelW1FKqfn9JYDFBLMNPNyqOeU7piE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7KXWxvxTduTH8Ly6pU6FoyZlXtvUfG6SXBJZuf4MTWlWzBoupChButWTKHYPn6ThtZdYX6MkNhtb88GWtbByddfvUtCARUmbhE6E+DmucJGEvJh5dZrR+Gspc+Drk9pIUnKSlg1e+wT7T+CgDBEs7bAE50SOcx6G2grFH29LNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gov02KRn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gov02KRn"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0c571f137so118111266b.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855911; x=1751460711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBvpxLkoso/jjVvZYpw0WV0I7hyT787Q/kk/xe8qh0s=;
        b=gov02KRn+agg9H+I7SUgnpIMzPq9hnk6L5yFFPOmRjf+R86yIUaJPIYckbLZ/qCNZE
         gglmAR8SymoeMeTk70mfn0xEEKw6FIr1twjIkxR+OLtRroVqjHLbotK09c6SDh6qdqCj
         G+nkPDkwe8TjbcKXwvrTfZGYk9/Ao5u2FOa2ltOU9giBWo1zACV641IkI7yh1OKxkBw1
         TOf+sRNrRtpATj8Lwk4gkHZMxOUya4kPrLaI/7vX/LQrcg0ei9JLbSmI6xfccW8n43uS
         LI3V0A0WtIricDvfy4LNFQP0yOmBPJS5IhOTBcFb8dP4yHU9sWKd/MlXa96yR7o52alc
         nG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855911; x=1751460711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBvpxLkoso/jjVvZYpw0WV0I7hyT787Q/kk/xe8qh0s=;
        b=H4bCMNBssUxC/KGzHPhJwAYa4M10B+hYRK4xNHuo7qUh99Sxi+AK1jTKi3rFENV1Pw
         403R4ZuJ0XGAzR+1HniTIwvJuJXMuh6lNuc2lhQJ60B9wCbsxx7ziYeEryEPR+OIpSZn
         6VNPnFS6PALPMVadgY3s81Sxi+cLXtp+NldpmzO5rzpim4cww3A9YBe/TIBTyqT2jlSO
         LxrFwOH64ienHk+VGGvOgFwIPj/Tl58g/76gFUSL+ZeNGAUqOmgpqqw5xmMuV4xh42SR
         69NUL1ZXb4gKX7vWVw489UgTnlhY2/ddx3lnF/dy4ROtkzMJ3cqq9v5FrfAvN4pDufDR
         0nPw==
X-Gm-Message-State: AOJu0YxuFzY/ZDDLIuReLjgC4D/3ewtyMbij5hTm9jZOS8RdRRvyLVCl
	o3AFu8G2Ozbp6tujN6xqUE3d25g4vhQ3eI+JgEZTQarbrK1sgZt+uGtpOA56L+3ZcVP60LT2zQe
	YWaDqUKJ9hxUu00TnlUJn4uzdIvg+Lqk=
X-Gm-Gg: ASbGncsFA9aHKZI8G5gzArNMg4V8dzg3OYtgJ7od50ErMo33z4sqxaXHn8ZNMBn970o
	bRjBQbS60QQ6zSehGceno7mj0LjdymUlYtnxVcH/1plFVjw6dJXzWaUYkiJd0UYK2B+ztuS/JlR
	5DU3t1Iz2smEYBfvHUO8UIRQyYPmneAKz8WCirMAi19HF6XA==
X-Google-Smtp-Source: AGHT+IFBcC+vj56/iQfg1p2Qai9bxb0wJcyKMkgMoIrvQZjIUQQbRE5UIdWSpCY4nElDDwVQSVvRpt3Mc0GZn0xdewg=
X-Received: by 2002:a17:907:3f0d:b0:ad2:46b2:78b2 with SMTP id
 a640c23a62f3a-ae0bf0190a0mr279226766b.18.1750855911204; Wed, 25 Jun 2025
 05:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com> <20250611134506.2975856-3-christian.couder@gmail.com>
 <ojee3heqvvlk3v4ftuzaulm5vu7tvmc5idvqbda2ioiuurbmdw@sevh7jtsbbad>
In-Reply-To: <ojee3heqvvlk3v4ftuzaulm5vu7tvmc5idvqbda2ioiuurbmdw@sevh7jtsbbad>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Jun 2025 14:51:38 +0200
X-Gm-Features: Ac12FXzUqefFfcinbwVSkOz16QRbYxBWx47-VrkUgUSzCGdcr-a_v1GP0_M9XC4
Message-ID: <CAP8UFD2TYwXPm7djcpkuCjmh4h2FBPF5eD7NAQHt1GGOn63OgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] promisor-remote: allow a server to advertise more fields
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:04=E2=80=AFPM Justin Tobler <jltobler@gmail.com>=
 wrote:
>
> On 25/06/11 03:45PM, Christian Couder wrote:

> > +static char *fields_from_config(struct string_list *fields_list, const=
 char *config_key)
> > +{
> > +     char *fields =3D NULL;
> > +
> > +     if (!git_config_get_string(config_key, &fields) && *fields) {
> > +             string_list_split_in_place(fields_list, fields, ", ", -1)=
;
> > +             string_list_remove_empty_items(fields_list, 0);
>
> Ok, in this version we now filter out empty entries from the
> string_list. Previously if fields were specified with both a comma and
> SP character (i.e. "partialCloneFilter, token"), an empty entry would be
> parsed in the middle and lead to a warning message.
>
> This change is good because it would be pretty natural for a user to
> specify the config with both. It might be nice to leave a comment
> explaining why we do this though as it may be confusing without context.

Yeah, I have added some comments, so it looks like this in v5:

        /* Split on any comma or space character */
        string_list_split_in_place(fields_list, fields, ", ", -1);
        /*
         * Remove empty items that might result from trailing
         * commas, or from items being separated by both
         * commas and spaces.
         */
        string_list_remove_empty_items(fields_list, 0);

Thanks.
