Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD81F7569
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991135; cv=none; b=gSpb53f6LNiCC9sFi103wAfCav0W76NalfZgBiMhDah032rO3wmr5gAjjlaRdcc85MLzURBRWhoLB/XNdtLcy7Xw4+QhvGtcZFgQWA2ByJQ7fcWmcVQy6DjG4UL/TAAeBZ+n9HDK5xHwIXKJm0keuwS7U2szznXzf0HzAsF/L6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991135; c=relaxed/simple;
	bh=G9lf2tFu6FK/vFeIMVq2U5A/LDIFJede6cU9AuiUksg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro4mFdxEd3t+KH2jyRLxtxYHrLbvpClZ0JOcx54unIvEmfSRY0oo9OFrWAqYXGbHOoywAbyo9t9oXLRSckIbFo9oRDydEyKEHcg+6h+k9utnyWfSY3KI9EfFB+4i9rf5AyY1JEWpPH00KNdaXiDmXvHmk2nDwsBGkYA1mVGnAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70736940fccso504326d6.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 12:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753991132; x=1754595932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMv5zACpf9BaTT+GT/2U34kiOHwLi/wR0vFa4OBHGOg=;
        b=WWvLIfDXEdN0v2AJzdwAeq+0GZ57ELqqoMD6LSCfouCx+diWTVkCtxuABjrBLiGJrJ
         s8ceHIHHKdzOonGiwB1glSpr/Vy99iJZVVAcQ0MqM/Zb+jcxgC6lLZgVupqD+1B3c8OE
         wQAhvDxHkRR9SNl66rsNdBCNtjn78Cz/N3kBJ8zOSsJLYjQdH8lwwg2N3JYtCwKNn1GJ
         gRgMcA5lD8IX/9hWkjZLXTRo6g50BgMWYrLoiOtRSmQ6UL7Ao8BQ6bxEmvxHTHCiiIwU
         gZfhDfHC9BwMpctZwmtW34tRmTJN4XP2V+MfAmY/YzS/EO98HkoC6TBDOEhPOuHntJ8O
         JNew==
X-Gm-Message-State: AOJu0YwODxfUnWdCRLeIHeXfCtxgjnojwG7yRvggj4VM/s+/u6F8yPV9
	baGQgGUvfJgr6mdPBK0cEU6kAiYBd7mTDczhViceqS+7PzmSwoqVXu4k50YippFg2z4mNNr+cY+
	RGFXeNISDHdy/KjA2eyFeS7Md/zdD8twHKw==
X-Gm-Gg: ASbGncsPxcg/HywdiHdiNt2GqiSmA59wLY9XGiVrusQez3bj6JRiFmCbKk9O89K3INJ
	7MjPhjnFLLglcgGGCCpXXeKUfSVqwRCyBvrpd/7rpzQk2yNdDS85VnXGR1qr4oO7AppXwEjp1qG
	LIqODuCNUSa8/n68q+QfRnJTWIzHOGuNUsCLagbpTeiPNj6GvsJaJDB0LMN4O5WtIwIPs16PU65
	fV/XaSljbt+/OHyLDGGFGOBbSxrMUop1X2mV+U+XI3xhP68yVdd1cs5Clq69A==
X-Google-Smtp-Source: AGHT+IGZz0R6OodNZcONqdomtKIf4P4PJyMJWxa6MeCjFFWUD17JGtH+/3mPEQbhWf8XLrfWd6NZuG1SBLzJ8GPxGvE=
X-Received: by 2002:a05:6214:2aaf:b0:707:40d4:44e1 with SMTP id
 6a1803df08f44-70766a38db5mr55028666d6.0.1753991131949; Thu, 31 Jul 2025
 12:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731063949.1601669-1-gitster@pobox.com> <20250731063949.1601669-6-gitster@pobox.com>
In-Reply-To: <20250731063949.1601669-6-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 31 Jul 2025 15:45:21 -0400
X-Gm-Features: Ac12FXwj_lGu-KHhZCNKxs6xwVuqhNUQQFTtviQDiMKYbAiLuEsKEXLFkXDjOkw
Message-ID: <CAPig+cSed8ZOfLxDGYVeWhA_46FQ8LZ4E0+1KQu=V7NQZmLZxw@mail.gmail.com>
Subject: Re: [PATCH 5/5] diff: simplify parsing of diff.colormovedws
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 2:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> The code to parse this configuration variable, whose value is a
> comma separated known tokens like "ignore-space-change" and
> "ignore-all-space", uses string_list_split() to split the value int
> pieces, and then places each piece of string in a strbuf to trim,
> before comparing the result with the list of known tokens.

s/int/into/

> Thanks to the previous steps, now string_list_split() knows to trim
> the resulting pieces in the string list.  Use it to simplify the
> code.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/diff.c b/diff.c
> @@ -327,29 +327,23 @@ static unsigned parse_color_moved_ws(const char *ar=
g)
> -       string_list_split(&l, arg, ",", -1);
> +       string_list_split_f(&l, arg, ",", -1, STRING_LIST_SPLIT_TRIM);
>
>         for_each_string_list_item(i, &l) {
> -               struct strbuf sb =3D STRBUF_INIT;
> -               strbuf_addstr(&sb, i->string);
> -               strbuf_trim(&sb);
> -
> -               if (!strcmp(sb.buf, "no"))
> +               if (!strcmp(i->string, "no"))
>                         ret =3D 0;
> -               else if (!strcmp(sb.buf, "ignore-space-change"))
> +               else if (!strcmp(i->string, "ignore-space-change"))
>                         ret |=3D XDF_IGNORE_WHITESPACE_CHANGE;
> -               else if (!strcmp(sb.buf, "ignore-space-at-eol"))
> +               else if (!strcmp(i->string, "ignore-space-at-eol"))
>                         ret |=3D XDF_IGNORE_WHITESPACE_AT_EOL;
> -               else if (!strcmp(sb.buf, "ignore-all-space"))
> +               else if (!strcmp(i->string, "ignore-all-space"))
>                         ret |=3D XDF_IGNORE_WHITESPACE;
> -               else if (!strcmp(sb.buf, "allow-indentation-change"))
> +               else if (!strcmp(i->string, "allow-indentation-change"))
>                         ret |=3D COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
>                 else {
>                         ret |=3D COLOR_MOVED_WS_ERROR;
> -                       error(_("unknown color-moved-ws mode '%s', possib=
le values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-spa=
ce', 'allow-indentation-change'"), sb.buf);
> +                       error(_("unknown color-moved-ws mode '%s', possib=
le values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-spa=
ce', 'allow-indentation-change'"), i->string);
>                 }
> -
> -               strbuf_release(&sb);
>         }

An unfortunately noisy diff, but it can't be helped. The end result is
a pleasant improvement.
