Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7941D953B
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659078; cv=none; b=phGBC0OPai8Bzw4dVWWOmg+AJ3JixsED8JbWdbDgUPVg9dF/AnhBqIVI/MZS1w3xl8NSQ6OuhwOn2VBD/QhxqrX+J3KS2XNnankYTQZK6jcWgzQofoPyIPyInJrtAinrDpHWzkvG1AIh0bFgpzGElyWGJ76ptEFrAKyiO5WYyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659078; c=relaxed/simple;
	bh=uNqg27c7ASQ7g5FIf7HXVvyVk+s61NMiiJoCa+6rgdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMmGTNN6fLTrMJexglwdFt0bP9JyGxNF2MmNGdQj8dz8+qQMgIwIE21QLyJXowlL9q9MgZotOpqcMwFmQo/t1/eFJBXawluialu6CQqnUdbIDaGFu9jAr41GrJriAhVehimQ4Rt4EzKTagN0pov0wDNwZnFSq+iJjI6WTcHbDgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9TW3CV5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9TW3CV5"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ba1f60eb96so2806684eaf.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718659076; x=1719263876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDZ6rtLwVOt09qF6rRaw+vVm1n1qrFRJzaqRKrFaNWY=;
        b=n9TW3CV55IsseuNxbwIPTS872MsFGdw34uXPQPJM5q528jEAfxOwIxantwK9dlONIv
         CX8Lb6G6xOpxnVwQz93bEeT6aDm3SlNfluNw7IduK2CC3+B5lf8lo01uMM3izvLuUsuD
         QYBiIvTYTtwFOVaiA7FRl5eYGdQilmB2Y8/fDTvaEMKOnZ8z5opU0bhxoqK8Q+r9d+VB
         3cPyQrsPZ36QQet1rWNigomr1WfhwCcrhdVBw+rEHw7yLtD0PApVoGoU6RRV5Thng23e
         69DwTLwIvosb3z/A36AzVqjPgKhYJFUYcYQj5BvJoYNAaYyErhKxYKGJsimOyqCMt7Eo
         ZY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718659076; x=1719263876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDZ6rtLwVOt09qF6rRaw+vVm1n1qrFRJzaqRKrFaNWY=;
        b=OLDMlSBMnwBcXVdCDakZkH7jzqGowc5SflbWzojeUzFoXYeoU4BdkKR3+4bx1+qr3A
         ciWacZpzz1FabhdRzJMJjNctWKfMzcgw/VS/iJ+rLBzzAtj0nL0RwdeRA/FTjmyQDj5b
         sR5Eu+e1MrHGxYCUHyGTkvrKmTTkDoHe4U7r656G2l0wXEFHbkznfc3Ko2LQYLzdLFt3
         WICbBDHNDV5QDNafu7NdB2hOHFC3Gj7TApC8SuEdWeSMICHiedyxFrrFt8yqtkm9Iw+5
         XBffkeyIa2eAlG6C75FaIZ8lNqCFSa7M8xv//zjDTc+dqfx0GDpbFx5wwpFFaHj1oZHZ
         vUIw==
X-Forwarded-Encrypted: i=1; AJvYcCUjRz69O4r6hqSQuMINntYZbHucT4waQh4Q9YLcZR1FolA1pF+DdURKYdvO1WejO4dkoW5B1VOs8vyMyFTTa4i0AmMx
X-Gm-Message-State: AOJu0YyP5McpPEgrTctk9Gg6wqCw7kX1OQZu2JPxeWmFWdRYlmUrTM5S
	cGm9hSaCihaQUJXYFO8EgDa18RT20Md7TI2sIpVyD06Rynou59H6aC0vBtXAeXYYiIZVd/emv82
	56IdOOxVdOH/GPzGlYQSsMO6vjVD+xtHxCRRat9I/1OCb4BOUOw==
X-Google-Smtp-Source: AGHT+IHamODQQinCd8YgFIz1ZlrMQgPL9NFUmj1ksipEn6KJRDfIybhjKKHLAklgMU7G0oI9yB+Gdf/X9ggDtfOa7I0=
X-Received: by 2002:a4a:350d:0:b0:5bd:bbb1:62f0 with SMTP id
 006d021491bc7-5bdbbb167damr6879979eaf.3.1718659075593; Mon, 17 Jun 2024
 14:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1747.git.1718654424683.gitgitgadget@gmail.com> <xmqqcyof5n2t.fsf@gitster.g>
In-Reply-To: <xmqqcyof5n2t.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 17 Jun 2024 14:17:28 -0700
Message-ID: <CAO_smVg1GuyreBw7Dw0RjLPjD1KhH-NmFMkkC-D4hB7kfPqjCQ@mail.gmail.com>
Subject: Re: [PATCH] attr: fix msan issue in read_attr_from_index
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The issue exists because `size` is an output parameter from
> > `read_blob_data_from_index`, but it's only modified if
> > `read_blob_data_from_index` returns non-NULL.
>
> Correct.
>
> > The read of `size` when
> > calling `read_attr_from_buf` unconditionally may read from an
> > uninitialized value. `read_attr_from_buf` checks that `buf` is non-NULL
> > before reading from `size`, but by then it's already too late: the
> > uninitialized read will have happened already.
>
> Yes, but it is dubious that reading an uninitialized value that we
> know will not be used is a problem, so I am inclined to say that
> MSAN is giving a false positive here.
>
> > Furthermore, there's no
> > guarantee that the compiler won't reorder things so that it checks
> > `size` before checking `!buf`.
>
> This I do not understand.  Are you talking about buf vs length here
> in the callee?
>
>         static struct attr_stack *read_attr_from_buf(char *buf, size_t le=
ngth,
>                                                      const char *path, un=
signed flags)
>         {
>                 struct attr_stack *res;
>                 char *sp;
>                 int lineno =3D 0;
>
>                 if (!buf)
>                         return NULL;
>                 if (length >=3D ATTR_MAX_FILE_SIZE) {
>                         warning(_("ignoring overly large gitattributes bl=
ob '%s'"), path);
>                         free(buf);
>                         return NULL;
>                 }
>
> At the machine level, a prefetch may happen from both buf and
> length, but the program ought to behave the same way as the code is
> executed serially as written.  If the compiler allows the outside
> world to observe that resulting code checks length even when buf is
> NULL, such a compiler is broken.  So I do not think that is what you
> are referring to, but then I do not know what problem you are
> describing.

Once there's an uninitialized read, we're in undefined behavior
territory. There's no requirement that the compiler keep the code
operating the way we'd logically expect once there's undefined
behavior, especially with the optimizer involved.

I think that you're right though: when I wrote this I'd convinced
myself that this wasn't guaranteed to work, but taking a look now I
can't think of a way for this to go wrong, because afaik size_t is
such a simple type, conceptually. When compiling `read_attr_from_buf`,
it can't actually assume any relationship between `buf` and `length`.
Maybe I was thinking that with link-time optimizations (whole-program
optimizations) it can go wrong? I'm not remembering what I was
thinking about when I wrote that, sorry.

>
> Having said all that ...
>
> > Make the call to `read_attr_from_buf` conditional on `buf` being
> > non-NULL, ensuring that `size` is not read if it's never set.
>
> ... this makes the logic at the caller crystal clear, so even if
> there are suboptimal checker that bothers us with false positives,
> the change itself justifies itself, I would say.
>
> >       } else {
> >               buf =3D read_blob_data_from_index(istate, path, &size);
> > -             stack =3D read_attr_from_buf(buf, size, path, flags);
> > +             if (buf)
> > +                     stack =3D read_attr_from_buf(buf, size, path, fla=
gs);
> >       }
> >       return stack;
>
> Thanks.
