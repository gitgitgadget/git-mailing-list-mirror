Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CD1494CC
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393025; cv=none; b=YdoOTscGewNw5DJVRUjFvYWdnDof8WK9RBFcX1eykVnaf2GWH3y+wtzed/hSXK/QZFRdHkDJu8SNABvnyTt26DaPSanFeAqUs/KDoGuw5EDblXg1ybWLa9kSdWleD/b9ZepNO9eGtGzPh7JpI2NziGScfyJzU263jpzz/v8WYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393025; c=relaxed/simple;
	bh=mMx1Av+/IXoiQ3deQ/z+07B5olUN92KUQDUt7OaCsmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIg4f2YYlXj78Bg8hF6UflgMa1aYo1Oo4Ka1V3oXTlDIN0dZtevQ3LsUkuSHb/28u6gKINzyBTD7gyJkbTq0rW13vs0UtwY+59qPrT4NPZrdrZHicjvmAGfeZYDD5zxeFnGoDskar6Bzj9G/DR2/vRAmcGvR7sAGWngdtMAdf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPzI6k2R; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPzI6k2R"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51873bc7377so1356844e0c.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737393022; x=1737997822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExmiSfY8rvQWSv6zvkyr/qK+3evng+rdEClwhoQpJQk=;
        b=bPzI6k2RJzR2Tp2PW2NJKamu5UTE5DblyIwn7Xaxblz3tuy6izFTtryEHvmKDL2UUe
         +cbfydq+dxGw90KTdMGTjUJeVNUkhMN7scw0Wd4yukCYEagqvKvHDWQHWUQX3l3P7VGu
         Z4aAwSW1RFOpViLNABFU6diUmcduUaLyHwbk5yPa/RT4tNI/R/klbHi2Fj3sAteE3q1Y
         62drzhuJ0gZnvbgAZERSAVpNgsSn+J5DA6cFj4nGg9EupIVxAE29mXdDRIyV5FLOWr8v
         youjOeUXbRJYZrJY+ViK7zM2DCjeGQj7WHp4KjVnJdmUUie8unYsyFxBLb7RXCcS02s5
         Ua5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737393022; x=1737997822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExmiSfY8rvQWSv6zvkyr/qK+3evng+rdEClwhoQpJQk=;
        b=AOFO7umoOBKeaMoK4teW40leLa4NAbaFnSLVDUhW1F+acashqabmQDIAhUUJeMV6jl
         MiwmNZ2aH+2io0RYq42FiSXNGVq1xOBdWgT3yBye8YIFpWTPQbdCJPQMvUCNnbPG74iA
         igID0s8HD/fY4OAJ4paot8BGf8V33hK1CuGmPwPqbJ7Ew2iJs49MHwWVdtj1tMBMhQQO
         +RxZzcOlUl7uTcNl8uHz+0gHWbOIX7fwVsfRbrtrV1R1goDFIj4jzoeEt1qpT4bXIgmC
         YnOxW/0HJal1jk4EyLLp07mHhgpCKVqKO3OIR6x6XYbmN+9bHFBnS2DcHUyJj5WPtJxt
         Czng==
X-Gm-Message-State: AOJu0YwqBtUxnGddzAqq6mEPukb7G1oqy45HMv5jLGouXecvR1HcKhMq
	uJ0bDb4bEdGs4DJbQoK9goBM0cbo3r90PjGYkz0M0C6EsJcfdF1dG+PdPFE+ALKky5vAFBLi0fa
	XnnMyWSH0TbN99Jdq2KrF0v1c62Q=
X-Gm-Gg: ASbGnctL3fTksFH+cukZApi6ywhqP9mdUM3AbDQSUOYKN1yi6GRMt2gMyMh4KT4KaCB
	E66XxUdeKpPpdZIf3ZTRULcM/1Ze7XjJ8DM/aoE8+goUH4IULIjs=
X-Google-Smtp-Source: AGHT+IE+IevTjRNDmrcfqXfqM/0I2KcV2vNUABSFYhav4tZDY6y+HySy1LJ4EgP3zrkdqgYPtod+OYMuCwhhPyKC12U=
X-Received: by 2002:a05:6122:481:b0:51d:eb9b:6b5 with SMTP id
 71dfb90a1353d-51deb9b325bmr8067443e0c.2.1737393022289; Mon, 20 Jan 2025
 09:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-2-usmanakinyemi202@gmail.com>
 <xmqqfrlhl2jv.fsf@gitster.g>
In-Reply-To: <xmqqfrlhl2jv.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 20 Jan 2025 22:40:11 +0530
X-Gm-Features: AbW1kvY-LZU0Olt8UH0q6Uktqwq_3LsT6vc9D3NKHsus70BkevtdG8EylnXR0js
Message-ID: <CAPSxiM-NPobarwmeRA+Z1L1DCLMEJy=1REobt3tyCKKFZOO_gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] version: refactor redact_non_printables()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, sunshine@sunshineco.com, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > The git_user_agent_sanitized() function performs some sanitizing to
> > avoid special characters being sent over the line and possibly messing
> > up with the protocol or with the parsing on the other side.
> >
> > Let's extract this sanitizing into a new redact_non_printables() functi=
on,
> > as we will want to reuse it in a following patch.
> >
> > For now the new redact_non_printables() function is still static as
> > it's only needed locally.
> >
> > While at it, let's use strbuf_detach() to explicitly detach the string
> > contained by the 'buf' strbuf.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >  version.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/version.c b/version.c
> > index 4d763ab48d..78f025c808 100644
> > --- a/version.c
> > +++ b/version.c
> > @@ -6,6 +6,20 @@
> >  const char git_version_string[] =3D GIT_VERSION;
> >  const char git_built_from_commit_string[] =3D GIT_BUILT_FROM_COMMIT;
> >
> > +/*
> > + * Trim and replace each character with ascii code below 32 or above
> > + * 127 (included) using a dot '.' character.
>
> /*
>  * Trim and replace each byte outside ASCII printable
>  * (33 to 127, inclusive) with a dot '.'.
>  */
>
> perhaps?
This sounds confusing, it sounds like the byte we are replacing with dot ar=
e
in the range of 33 to 127 whereas, it is those outside these range.
>
> > + * TODO: ensure consecutive non-printable characters are only replaced=
 once
>
> I am not sure what your plans are for this change.  Has the list
> reached the consensus to squish consecutive redaction dots into one
> in the user-agent string?  If not, let's not mention it.  Making an
> incompatible change to the user-agent string is not the primary aim
> of this topic anyway.
>
> > +*/
>
> Funny indentation.  The asterisk should have a SP before it, just
> like on the previous lines.
Mistake, thanks for catching it, will make a change to it in the next
patch series.
>
> > +static void redact_non_printables(struct strbuf *buf)
> > +{
> > +     strbuf_trim(buf);
> > +     for (size_t i =3D 0; i < buf->len; i++) {
> > +             if (buf->buf[i] <=3D 32 || buf->buf[i] >=3D 127)
>
> <sane-ctype.h> defines isprint() we can use here.
I think it would be better to add this in another commit so that one commit
does one thing. I will add it after this patch series got settled,
what do you think ?
>
> > +                     buf->buf[i] =3D '.';
> > +     }
> > +}
>
> Do we want to do anything special when the resulting buf->buf[]
> becomes empty or just full of dots without anything else?  Should
> the caller be told about such a condition, or is it callers'
> responsibility to check if they care?  I am inclined to say that it
> is the latter.
I agreed.
>
> > @@ -27,12 +41,8 @@ const char *git_user_agent_sanitized(void)
> >               struct strbuf buf =3D STRBUF_INIT;
> >
> >               strbuf_addstr(&buf, git_user_agent());
> > -             strbuf_trim(&buf);
> > -             for (size_t i =3D 0; i < buf.len; i++) {
> > -                     if (buf.buf[i] <=3D 32 || buf.buf[i] >=3D 127)
> > -                             buf.buf[i] =3D '.';
> > -             }
> > -             agent =3D buf.buf;
> > +             redact_non_printables(&buf);
> > +             agent =3D strbuf_detach(&buf, NULL);
> >       }
> >
> >       return agent;
