Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB023497B
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751500002; cv=none; b=N4qjRKN70wLTpb5haw0nCXMt3WB0Nq0mRHQjnttB5nIIGxCH34aoSgYz4NyfDP48c8xPMVndzrDHHXmWphplfhJ5dUJ4OnZMlxTZtD2x+8vRVvJktMsJyy9v/zOO5Tpgn0br9IrxmIszlapyGsDHFAiYwZKkoznVdfcnBhCcCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751500002; c=relaxed/simple;
	bh=CThcIzrg4sCGDYEELJOFsyzUcamgtJyLOJk+bjM01Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ma5pQhjAQkQuZewBndtVd/DY1AtSmEoUiJOW2A8jEsrpeL4Yl6PnmktleBqBVjS3c0g7XH45u0QDYJXXTCCLBnoKu5ULj4ikNLKkqicB4NXSqpvuMdLAoQa0pXTLIBp6yAVq7sB/4yQQcgl27bRdFYvnMnIrEP8rzZlYyy/htGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjuvUEli; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjuvUEli"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso5087604a91.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751500000; x=1752104800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9VA7VG6iRQI9LjlYcdga6PUfm2eD5i5MQ3nbQkIWhs=;
        b=IjuvUEliz2c1t3IfmQpfJZ/ajWBTNGzqQgGKz7TyfzvLgFYhpFUcO5JdDXZmcVawpB
         izF/P2KhOjSJ0Rfo5TXd+f55+czZOgZrXyMLA2Jgi7sZplj2sQiYKQ+cIDSHcTSFv+OI
         vwi+UJrrXIFrqhEj0n0I3Jhyy5u4Cpi9VeJF97HxZgliKFi+bfpxOeiMNFMbwfoNsU1W
         dwNR0QZhSoL1YZjo8zyeDL8s6A9WgHietPmp13gyh8UrHMClT9Ayezzho5T6BJsGjFeU
         XDAjbJYhAtmR9q1eqMCaLkldcu1ppKouz+q5Dit31qP8jSImIu2VdMIcTRbzlGVPjUta
         XRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751500000; x=1752104800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9VA7VG6iRQI9LjlYcdga6PUfm2eD5i5MQ3nbQkIWhs=;
        b=LU06vQzuXWQIEUd4qGEtoD8C1TMLsztSSfXx91A4gcmxuoPXQ/dle7kl9+KtahBj4n
         C3xSiSbg1ybvmVQiBwTORsNcHQ1VlJ4ez7L4DKVAZTRRmiXtiOiDKcogafJeGJZk0vJS
         rBq25gXHgf/++SZ9bvDk+dtadvVR6vJR7nP7KfNduSxYhYRJH7W3Eu9qOVBr3VIf8tfr
         uL5llRzlTx1a44lxkrbNDOIsmXPKpDPGEl47EXo4Z5eWVStB+O666ER/Q4A2ralyza9I
         lpqPyqkdFZK/5gQ8YBW2SBFk4a29YouaVm+NS9uCAqnILOtWEqLyrBbWQWsuV3VH+TY0
         vcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOJlM/eK8ycUCsNIK6n/w08YfcTVYw5+Leb6KGwkXvDeFBFcAiGNnpQ7Nh9jmFsHkGn0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyToyOtKlViqqxsylTBNm1OlncWbfHFleGF7oi5ssJxIE7+kzQc
	P2joppu7sTWe2dPEZ6Rsid+JdjwlqiiQwP/KxNxa5RmIuzhQsyvqFVZb/j3hXXHzWnyohUB6aAo
	I4905GKvrom2HEDW/UMoUtBvMUH1ZcpM=
X-Gm-Gg: ASbGncsnIuYGakWTtBFmsXne8J07VVYrBe/fniGY4y2p7dVyOpSsw432cHJuU3u3AOy
	g2lQdgoZramgr738NjFisyMBUkN7llcVz/0lVlYG2/F4kKTixi8TM4Pk6mRvMgFNBA6tD6XHKeT
	fhsZb1Jn/huFdjC3moUhzy/vQ6DbVqK82aLhziVKrzR0wgI6k+gX6OXu/zaEpwa6LXSPfKtInhR
	8o=
X-Google-Smtp-Source: AGHT+IEGXnH7A46t8QIIo4Tti7uwdo5IYYilU5ItTmSPbHVgyW1PfLGfeSQNbGyILNs9ZRYrDkMlaX8Tq52WXFPeO+A=
X-Received: by 2002:a17:90b:53cf:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31a90b0fe26mr6627862a91.3.1751500000305; Wed, 02 Jul 2025
 16:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250630182527.69167-1-ayu.chandekar@gmail.com> <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
 <CAE7as+Z7GXMB4LJGwESK3Pj63ppfFMKDq-xw46YCELJ7E3p+DA@mail.gmail.com> <9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com>
In-Reply-To: <9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Thu, 3 Jul 2025 05:16:28 +0530
X-Gm-Features: Ac12FXwIkkLGKF3JMNmw76SmRNL1Td5vkm_5CLRmxmkQ78DR5f6FB0Z5zzr9K2w
Message-ID: <CAE7as+abNzqbGSCWsuYe8D_c5dBUuRdDEbHL0pVW5j3kTMER4Q@mail.gmail.com>
Subject: Re: [GSOC PATCH v3] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	kristofferhaugsbakk@fastmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, Jul 2, 2025 at 1:02=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ayush
>
> On 01/07/2025 19:33, Ayush Chandekar wrote:
> > On Tue, Jul 1, 2025 at 6:47=E2=80=AFPM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >>
> >> The changes here look good but I think we want to update the config
> >> parsing as well so that comment_line_str is reset to '#' when
> >> core.commentString=3Dauto. We probably want to do that in its own comm=
it.
> >
> > maybe something like this?
> >
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -912,8 +912,10 @@ static int prepare_to_commit(const char
> > *index_file, const char *prefix,
> >          if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
> >                  die_errno(_("could not write commit template"));
> >
> > -       if (auto_comment_line_char)
> > +       if (auto_comment_line_char){
> > +               comment_line_str =3D "#";
> >                  adjust_comment_line_char(&sb);
> > +       }
> >          strbuf_release(&sb);
> >
> > or we can do it inside the `adjust_comment_line()` function.
>
> We need to do it when we parse the config so that
> append_conflicts_comment() uses '#' as the comment char. See the
> (whitespace damaged) diff below
>
> Thanks
>
> Phillip
>
> diff --git a/config.c b/config.c
> index eb60c293ab3..bb75bdc65d3 100644
> --- a/config.c
> +++ b/config.c
> @@ -1537,9 +1537,11 @@ static int git_default_core_config(const char
> *var, const char *value,
>               !strcmp(var, "core.commentstring")) {
>                   if (!value)
>                           return config_error_nonbool(var);
> -                else if (!strcasecmp(value, "auto"))
> +                else if (!strcasecmp(value, "auto")) {
>                           auto_comment_line_char =3D 1;
> -                else if (value[0]) {
> +                        FREE_AND_NULL(comment_line_str_to_free);
> +                        comment_line_str =3D "#";
> +                } else if (value[0]) {
>                           if (strchr(value, '\n'))
>                                   return error(_("%s cannot contain
> newline"), var);
>                           comment_line_str =3D value;
>

Thanks, I understood it.

What if we simply return the function `adjust_comment_line_char()` if
we get a non-zero value from `ignored_log_message_bytes()`, i.e we
won't scan the commit message in case conflict message exists, and we
let the old code exist as it is?

+       if(ignored_log_message_bytes(sb->buf, sb->len))
+               return;
