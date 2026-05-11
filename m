Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8F4A35
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778458102; cv=pass; b=alTAKoXtBElaDnT5Q77I4F46kP1dZvUX0drw5334RY1olOQYRs5xydrddpJIKK6NzzqHSEWhPE9S2xkpzhtPWYRAyykoP6AK+4UL+ZDLbNaqcjcrmSEmRrescCvIfwbVexxsieWXnrKi0I9ws/rdWjrVKmb9ZfP7rxrVMkrMHEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778458102; c=relaxed/simple;
	bh=pZGzm8Emq0AlFkyMSYDBIUqJqMZtL0zGxzK5IfrMh3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9xV3eLqAVt3FB6Q3tsmO5j8rx3WI6CvluzpVDOWzbndVubhu1xSUKXW6daNfsQOAHZULQIHEoUZXsO1znZRErxlsZcCAy1GiMCnzzY74mBqhPN3cpai5GpUIXF17tz0oa+CbUSDuqumlzMUDz6TFbWWU0QzBkZJqRW+KZZIFn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGeFZc7W; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGeFZc7W"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so33238241fa.0
        for <git@vger.kernel.org>; Sun, 10 May 2026 17:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778458099; cv=none;
        d=google.com; s=arc-20240605;
        b=IIi8fqvmi41n8OhXA8uueDHlW3xowfJKcIAvkRYUr3GDv7IKVeIBus6w/3JTcSL7Rk
         5wsIw2IoK7CYzEjorwhHPyJJUg+0OBDKJ9PrF+XXVsKIgOi2oErCbtx+2gugJtiXM7Lo
         T/LTspg0UL6/ox3xxqbun8jOcSC7q3SPcI6vwCSyT1c14MY+T+ny97fAJy9eiA6sTMBw
         Lq9jC2NAFMvq3s9FjUVO4lkzxRcoQIHr6HPEJWRqyOoNNzHpicxFTUHejGg7s9/QP4/q
         k2GbyycJ/SA+CjNRQRouPQZ5xFov/M1Et0fiu1riG6ddf/EgmiKuwLMK1/2XrqaJ51Wu
         GDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dBkjIUsq/74RrwYQoQsdG2VI6ce5YYTouUX73f287Ug=;
        fh=DOj4aov6QCZNHIut7J9bRSVLpYXeERrLPgwttad+t8s=;
        b=IaGjEfeA5R7nCwIuH8I9wRsDxEquPNBJo4NInWmw8aCKQiOo9CPGVRZTdxg4QSTtze
         p6rYkys62/vuUVksDTHQ1cJQLkeI2KxADLktkKpR2+qt9NytARpjSG3Gqf6wbFW1LOib
         IaGsj5vzrutxzAUOkgFXnsOo9+VutrJRGcMzS2LuLfLvat4OPr22oBcl7/xUqmELSULA
         njV0E7lQawU99SazIcD6ahLniy4ZAKsvv4lTEJ+zy4p3uiVgMnnSQ7Gyvnb2i5OHmD/a
         5IdTVqzbTD5kjlkSB5Cfs3n3/UzDVsYLW6lL+Kztlmv48u52ArxiGM3xQ6Gdv1qi5z+I
         fquA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778458099; x=1779062899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBkjIUsq/74RrwYQoQsdG2VI6ce5YYTouUX73f287Ug=;
        b=dGeFZc7WOHMKYB3nJPrVFf8BtX9ytv8M4v7SKdu5o1VL9O+imR3/DHqZ8VI8/uZYFE
         ydjtoK5aLN3tVMyNbsgdoEnXXKLzz5xwopRgIb3dxDMmKGHUvXYkmfS4zavirGsyfBUc
         7bHoR247gIvNMjJvWDsaFGaj4pTx2zLPnB0reIEPxHmq7ACppY4rEkC253vgobuYnpzY
         K97U0WSmbRee+mpVieEVI+5pw2PGj8ntP4CShlH5EzTPsIt12MdtVzsVymyC8UtrPSwU
         s7Oa8aCis01+/uzi4o6kepIrJ/RBP08VdKVrB+IYuuacwW7So9r0zKzWZvYAPxqRNp/R
         rzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778458099; x=1779062899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBkjIUsq/74RrwYQoQsdG2VI6ce5YYTouUX73f287Ug=;
        b=B3hBD8VQx/SfDEeJUkszG1NNlz7QHkGah4I0EES3KHNGw7mqrohKL6xBNjqFVITlHM
         I2S+RzLE0RvxR/huykKpyyqaFkWeZ+L7nxiJmlpLznvNlGT59nk2Cp7V28qlvFuPFbbQ
         e9dbKAIVuwomfHQSXM+mqqYS4vWBxbACHNgVApwkxYOPC7DEM1cKevR41UBsCX1QmLl4
         ovXBs3leobdchzK3OGWKKOy8hKf8e+VdkIC1Ursyq622Sz3Oa3RR80omc39P2tP0lOYz
         X2QquWrFYheNbsqGipBYfdpB38lsvTn3U3CkuX9J4N056ghLdxCBZBiD5AfceUsZVRSG
         k1zQ==
X-Gm-Message-State: AOJu0YzU+79a7DQq3tPFVOA5yKc/2bcjf1cIcEZX6ADOHCeGkTV1wIIX
	cEYSW0EwseSyiQpr2FEykW4bmbR3YCIkmovHtOV0CE38o5HuJHxS7USx5qKBANq5BH0UZCwrVWh
	c+3K40qd+5KBxaqZ9WIiP6bHcNojJwaL/WlRr
X-Gm-Gg: Acq92OEBnbWs8vXpq/duauAjO0/VQI/63D9BK8ljOa1TNTK6YXQAHbjoqF/6DteMyCO
	vusF/CCKYs08mxwpf6acFieTAqFr4m1EEQ3qEqz6PmOtRXCqSwYEiY/y3TpBtBryhJFiKCjH3l7
	/lvltlzLBcvils6FE8OEyORAXfyY51B3KgNyYFLjOeKZL6iNtvY9JV+tFJfI99Z7LQy+68hBFFl
	yVhmCyqLEDM4jpZQhaV6cLApGZ71JuQ+VaaxK6sepsfJ8wS8LhS0VnPeilqHsg8H7fotQ7Xw6C1
	MTEyorWKqZEhgwlrrxYjoC5a4yfKJOfUmUb/OQTwMUxemvd/ouevjqt/PqFkngCGM/WzTpD2l7t
	0QVuJXyXKBR6yC5WxYDQ2IIOUtNgX7DUcXjuS5rDVC55BQrhWpScR2RkY1m90Xwk=
X-Received: by 2002:a05:651c:210e:b0:393:cb61:1808 with SMTP id
 38308e7fff4ca-393cb61272dmr77354431fa.24.1778458099466; Sun, 10 May 2026
 17:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
 <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com> <xmqqik8u95yn.fsf@gitster.g>
In-Reply-To: <xmqqik8u95yn.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 May 2026 20:07:43 -0400
X-Gm-Features: AVHnY4I4Uq1WpP3fdDuEzjP7sMrkJlguGm9LGjayd-Au_oFD3DAvu4EN7VeuHXI
Message-ID: <CAJ-ks9mPzCr3obAw5cE071GNjzy_ZLzF4mQdnUbQY5H4WPw3sA@mail.gmail.com>
Subject: Re: [PATCH v3] doc: clarify --follow and log.follow for git log
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 7:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> >  `log.follow`::
> >       If `true`, `git log` will act as if the `--follow` option was use=
d when
> > +     a single pathspec is given.  This has the same limitations as
> > +     `--follow`, i.e. it cannot be used with multiple pathspecs and do=
es not
> > +     work well on non-linear history.  When the pathspec names a direc=
tory,
> > +     Git does not follow directory renames, but it still uses the same
> > +     traversal mode as for file rename following; see `--follow` in
> > +     linkgit:git-log[1].  This can be overridden by `--no-follow`.
>
> Saying that the feature does "not work well" on non-lenear history
> is like the behaviour of the feature is "undefined" on such a
> history.  Quite honestly, when you do not give a single filename,
> the behaviour is "undefined", either, so I do not think we want to
> say what happens when the pathspec you give matches a directory.
> The feature only takes a single filename on a linear history.
> Anything else the feature does is "undefined" random behavour.

I observed this "undefined" behavior, which is why I started working
on this patch. I think it is not reasonable to deal with undefined
behavior by pretending it doesn't exist. The documentation should
acknowledge and explain what happens when this option is used for all
ways that it can be used.
