Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790150285
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202924; cv=none; b=np0m5RNiwlebh/ycy+OXJuOIPQD9EMbMxbm0skwE/1HVeQcRNoQei0ePvAeo9oo0wfK8AjapPq8d8i3OIIoeT653ZIgQX/CBUGKI7jm8SI/XTrN3vuDagC8OiqBvHzq/L6ddZLbcA1L1l1lgjzGGb95J821X3XKpM8pEpgyiv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202924; c=relaxed/simple;
	bh=EQMpGptMBbJ7eDFRyOQVXOXW8u1T8/JW6FajqM/mPiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKNW9thEer1V0QTyPW4jNVPNzGnajUbX+Zf1OQlb5yee8monUm7mMahgfA/Aiev8HvYY4ZT5MvN9BiHOqFWB2CmPNKEWo34fuF5TsnjzgEOvNr3jEZPk1G3+wbN3nL0RTb2a8FuZwQ0NntYE70MPXdOYXK+8hE0wI0NWwZ2b7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6df8f7f9442so281736d6.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 14:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202922; x=1736807722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtm1T3H91NhGOAhB0G4WVmf/lK6sxwnA3cp26JEClos=;
        b=h71vUTqFO/OAXIDMiQT8fWIsep1XI562XKY4rFo+cfph80t//cCYL3MYxRFheJwMYh
         wjnJijU3KRn+ul7ZP5z291flFAQDdvE6qDrL9LabD/Y9j5bIBxsIfFkkhitol6mlvWBM
         EKAwvDg0u4WdbJoAoGLCyffqO8fcWvoAG3fzm5JKyKQrYnvJj0GbE8eiCytkD7COxJ0l
         tP0NlDH6pnXn5++2zLBkNXue7HBbjiHMhwhvp5PNkXTtFVUGNU2PVQVJRgx/7X+zM+z9
         xR9ptuZzrboJ0rFvspd93LZLijY6jseGrXH7qFpqpD7nGxUmOKoivHx17u15uC0DDAoP
         2v/Q==
X-Gm-Message-State: AOJu0YyuGAi31V//kSTMecEToP7DjmFjRKfBAKs+A3VEM9GQN8P1gtTL
	wJKB1ZD7SsBZ6Ags24jF8a0iLvWZeG3HyLGLjxQBD3hobBHmKsOP9Bqa1v16qaYxQqNTniHMd+p
	CoYjt8HbSdG+kdAtrXncNjlIgKlI=
X-Gm-Gg: ASbGncvvJoMptyjs23yiAZ8SIQg51CxL0HO9jwsC6hHTnU3kfyuFPVGt6bVZTgTx94L
	AlhwO99dT9XxHMohtifoV5OtmJ313uQMghkwU4KiBScnXVIHDy8VbOrQFRh+Cm/wYEiGoXnI=
X-Google-Smtp-Source: AGHT+IHEiFyzJKEJNww6ecO9fzHbjIVE0DefCa9rNx7J3QOQ2kwbjk/U7Vk9NuRb7T9SR6qZFl6QOBk/OORCuAs/Qsc=
X-Received: by 2002:a05:6214:27c2:b0:6d8:8915:bd8d with SMTP id
 6a1803df08f44-6dd2339c746mr347604596d6.8.1736202921891; Mon, 06 Jan 2025
 14:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com> <20250106103713.1452035-2-usmanakinyemi202@gmail.com>
In-Reply-To: <20250106103713.1452035-2-usmanakinyemi202@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 6 Jan 2025 17:35:11 -0500
Message-ID: <CAPig+cQz+2Q7Z=uMYvKNrK2MACQC130u5iiMcsUPjNTifeWSbw@mail.gmail.com>
Subject: Re: [PATCH 1/4] version: refactor redact_non_printables()
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:37=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> The git_user_agent_sanitized() function performs some sanitizing to
> avoid special characters being sent over the line and possibly messing
> up with the protocol or with the parsing on the other side.
>
> Let's extract this sanitizing into a new redact_non_printables() function=
,
> as we will want to reuse it in a following patch.
>
> For now the new redact_non_printables() function is still static as
> it's only needed locally.
>
> While at it, let's also make a few small improvements:
>   - use 'size_t' for 'i' instead of 'int',
>   - move the declaration of 'i' inside the 'for ( ... )',

Regarding the above two items...

>   - use strbuf_detach() to explicitly detach the string contained by
>     the 'buf' strbuf.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
> diff --git a/version.c b/version.c
> @@ -6,6 +6,20 @@
> +static void redact_non_printables(struct strbuf *buf)
> +{
> +       strbuf_trim(buf);
> +       for (size_t i =3D 0; i < buf->len; i++) {
> +               if (buf->buf[i] <=3D 32 || buf->buf[i] >=3D 127)
> +                       buf->buf[i] =3D '.';
> +       }
> +}
> @@ -27,12 +41,8 @@ const char *git_user_agent_sanitized(void)
>                 strbuf_addstr(&buf, git_user_agent());
> -               strbuf_trim(&buf);
> -               for (size_t i =3D 0; i < buf.len; i++) {

... the original code appears to have already been using `size_t` and
declaring the loop variable inside the `for` statement, despite what
the commit message says. So, is the commit message out of date? Or are
the patches out of order? Or something else?

> -                       if (buf.buf[i] <=3D 32 || buf.buf[i] >=3D 127)
> -                               buf.buf[i] =3D '.';
> -               }
> -               agent =3D buf.buf;
> +               redact_non_printables(&buf);
> +               agent =3D strbuf_detach(&buf, NULL);
