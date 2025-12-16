Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C862C11F9
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851984; cv=none; b=Hh8jVNadWl6Y4AAZy2q5c7B2VB3qc/QAomLcH6Qmrjicih+5/oUyyV2cOMvuu8p1DNbVwyu4nVEnaCQdyVgL6BmWSK/rpMD9fN+49zxI9/qAUBKsqf6eEKRGlMtXLK+kzk/LD7GCCp+epeCHrI9P8VNWfNe+t+2GPWPH6zh1QVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851984; c=relaxed/simple;
	bh=lwrjBhhMyLqzhXqohpziAQgOgE7YdYszQsDrfAdOI9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=To9U9tXH7b1YjFkdYiXpFdlmquqg1oFgiu8cCMjtS8J4k8Tro4/euF87hnVRQoEfqud/GvXdnqdJa4+TqkjApwO8eoGyiWEJEyjmc+NNiLjkg6Yf6tBgDFe21YMzDJkDNIYjEC7wmQoA0rg74rqOk+o8limgwBFQHYpir0Udhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtN8uRUJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtN8uRUJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78e7cfd782aso17848797b3.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 18:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765851982; x=1766456782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYGagyuVlPBcJAX/7Hj4ZRcFWcBRUrF+e1mAds2mpEI=;
        b=TtN8uRUJ8f1zyunXAm6HbQUkWx7MLcBbtoGrsjkCcry9TS3HiwBahcKgy2PeQ71FT8
         Cpi1XpT5yU8h0Pyj23xuWRMEF9lZ8SfDUVluzw5axGpxJHGZHer6/V7z9iPdkjumFL8/
         e+CCPjKjpQqiCdjFYNNMICC5l5Bri/UC9b2l1jhphfWa8KbxulcbpJOuRM+8z9V50TYD
         yPjsCAKlg0IYSWvxxjTUJWmgKjYYImXtNF9KnPgl+mtAYOzjxJskBAcqwK1i7c92kTy0
         WO4CYsfdX5VUB7WrcwxWGWgIp6YsWlkto+evWXp989z/rRJYQ9exdr4s6FiCl95vXJDV
         zGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765851982; x=1766456782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYGagyuVlPBcJAX/7Hj4ZRcFWcBRUrF+e1mAds2mpEI=;
        b=GKfApMZNuiHNPL5KffH4jQqECM38SwmIEtICK7zKGjAc1UDxgPJ4NrA2P91nc5Yr28
         1wmV+j6fM7sFfkQ3TF0KEqmcSj2u00SeCDVsvCMw7Sn9naSvp/yPTZ3VAHxkcNtRuVcH
         fmrmqJfywRPwUoCAOlu03fT0aRvGlMOPliTW70kuaINKxOmnFgSvAo1c5uIDVAeFXWNS
         ILkh4Hznv/84JHHsF95z+/jUDljMCvsrGJPZ3jc1NJMu/nt0GiBmaP4rdzl1qC6ZiMUe
         R7D4DWajW0z0DVO0tB3LGTMqdtSigtyQEcxWvF0SwciKlaUK9NnV6ZELMaYn18FPFrGY
         ZFyg==
X-Gm-Message-State: AOJu0YzYrlavUSqdgiakCVd9hV1ZzJ0PM5WpRhv8bDPGgNwW/nxkzkgg
	0bryroyWUfmi+EkxwfXeueE+T904xu7yHZNrlBM4SpIHUBRe+qGa/b0B8f9ZYD1EKq4b2zhgJH0
	MrByB8Nou5JdC5+UPXDQnfJ99ycd2bz4=
X-Gm-Gg: AY/fxX7MKbZiV5i2o8GbmJ7amJYRcCd9OvvkYqHw3HWmeEnnZdYis53YyBBGa7q7aJE
	mMSktbnH0In/C1PuxRVhFE6JBsZmeKf2+bJPewurWaJkMWjXU/7bd+cazFCUq8qVw4xoaWpr/YC
	/mcPwHW9fYsyVRCV5IkfbhS8WN09Ux7OLAf0HnLBGP9Epf6btMLT58th0R8/Ha7uYdOXB5m04MJ
	QjohhMjc/S1WL/Q3f+tWTC8gMGWkt6i7CA4LndllLg4NFhcXbhmLXHpKe7zKd4NUXEzt/WPY0vx
	w25vb+yOJ6UlnVH8U0zwneWpuat5w54NlHy6XEXYa3dNmeB2AcOdoMtFNF0TQ+y36N+/ghTMQ9P
	DjcWwvg==
X-Google-Smtp-Source: AGHT+IEIwoQxgTyDczYr1evlq1SsYH7Q632rIdwBWW2NZxbTiHI5/nRtz7/vrmpin8r6YyIQBR4sE7UUPBshCi+WhxE=
X-Received: by 2002:a05:690e:dc5:b0:644:60d9:750f with SMTP id
 956f58d0204a3-64555680d70mr8176893d50.95.1765851981780; Mon, 15 Dec 2025
 18:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209225820.2861276-1-jltobler@gmail.com> <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-3-jltobler@gmail.com>
In-Reply-To: <20251212223644.3090879-3-jltobler@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 16 Dec 2025 10:26:10 +0800
X-Gm-Features: AQt7F2pCvdwll1jEaYgyW1vU7h-cq_XgGzaaA8R-ut-vtbXhLSSuGgiIyoIJCkw
Message-ID: <CANYiYbE3Tx6B5L5rEoDue7hTYzFGxw_qA-MRpC9RSxQ7HRczaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 6:37=E2=80=AFAM Justin Tobler <jltobler@gmail.com> =
wrote:
> +               return humanise_rate ?
> +                              /* TRANSLATORS: IEC 80000-13:2008 byte/sec=
ond */
> +                              xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
> +                              /* TRANSLATORS: IEC 80000-13:2008 byte */
> +                              xstrfmt(Q_("byte", "bytes", bytes));

We have already defined "byte" as a 10n string without plural forms in the
file "t/helper/test-simple-ipc.c" via commit 36a7eb6876 (t0052: add simple-=
ipc
tests and t/helper/test-simple-ipc tool, 2021-03-22 10:29:48 +0000).

    OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),

The newly introduced usage of "byte" is now marked as having a plural form
(via Q_("byte", "bytes", bytes)), which causes a conflict. This results in =
make
pot failing with the following error:

    msgcat: msgid 'byte' is used without plural and with plural.

This happens because gettext requires that a given msgid be treated
consistently=E2=80=94either exclusively as a singular string or as part of =
a plural
construct=E2=80=94but not both.

To resolve this conflict, we can unmark the singular "byte" in
t/helper/test-simple-ipc.c, allowing it to reuse the translation from the
plural-form definition of "byte".

--
Jiang Xin
