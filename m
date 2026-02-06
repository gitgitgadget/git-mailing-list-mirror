Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA83EBF32
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409270; cv=pass; b=GIXtZgCbJCE0sdhh38jW+yi5LsxUDbDxod0sL7tngxQS/nHWACjuuDmyD9REZ562qQP53jBwUdrcgk0rJav0D54alo05xnlOE8xNlDH5iMy6v28eFUycaPcCZM4R0boUNoBb2s+P7TILDr5lz0hz7fYl6w+xV5WP4u6BpBGOg0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409270; c=relaxed/simple;
	bh=9reRe8U2vSOnDD3HeScNsZkyTPZYNuTQDMA4zs9gvtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzJspT1oCSHVDtSM+0e8/Th3kOZYUBC1gEsdE4uEi8aSWo9/XKFEG7iAx5GsB1ODiTgUlaoTu2HNDYark4vhLP3jABOoSpzBduGyz2Qr9ZPaIqWSvJ4u85AOVL4KudMTy4LgHnR61KKmJ5V2F7XsIsu5grLH1Pywzt1g3DdxQYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjp5baEn; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjp5baEn"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56373f07265so1769079e0c.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 12:21:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770409269; cv=none;
        d=google.com; s=arc-20240605;
        b=hRVe8uYkCVvctm3rmA8CtXE376hMH4E/v6mtEYOdQV2tNSkKNMNieRYsbDZ/ag5ukW
         84DoitY4x+Z710Zg5yKOY7TeN8YS4aEmsTKFxvkb+QwVgcRPLb5Mw7hO5Yii8pbUIRQY
         whGXdYk06k64/7drPHWh2vNBa63fi9rYjH118r6PvsMLkFNZ3ffRt0Jm+4rbW6bNEhUH
         60kuCmH3ytVsvCI5MA8oBLladv63GGPRs6ic92eJnEA8HggL4xlFh6DsbxBEQExR4sac
         OoU8IJSaahCPIH15qUFhCnVMgyOMEqvVEUKyVec8zfQmST02nL17/Kfy7GLteP3I6wnz
         T57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ko2D7Sw5aswnp25O+4oleqxFUUcFw5gb0w9nlVIDjGo=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=V/ynORYOj1iOt0JKyAPvHVBjMdjsxlUMqUoQDDCclG+OYX9pQ7/i5Qs0mBA2/ny6LO
         RvuW+khd7ffvjYlWoeiC3kFxL4m9V9xOMXtBs6ColKzTjwDCkps2M+WKT+hoCq5AwT7B
         CSg7uqHkhyQZoPyc6uTMroy+rx+QWpmqFLEO9MeME0iHx5bbrpD6ILckNmEJ5lOina3f
         frxxiryxykxXtDpJfoK5UuhJZTw65wvhK40G8DYJqh7owM4/NHN6v7yIt2Fy6xIMB00T
         65sw6IPXV4N4JLgM5T1Ba4HAwCabCUa5IE2DCdWvBj/ofwpg/PEOxlevvgo8Mo0k2AQD
         S/yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770409269; x=1771014069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko2D7Sw5aswnp25O+4oleqxFUUcFw5gb0w9nlVIDjGo=;
        b=gjp5baEnqXu3BT3T+SabrHHZWwZi3pQKvgp0SLws6i0yyAqpdagHfT8mVrJx80fFgt
         PJJKO0mrjbDZ6XJmk+LRwPsfbMoxn27xC1jyaCxc66P+Sssw/fCRRwD0QX0whpckkIkn
         u64mMVSGsXxN3eGF/qj8YyVmE+OOoXK6X/Gk9PQrw58QeW1uKq7AP7/9Ja4NaxV6xzzA
         UaZ4salUCij+WWFIaY1Ox8X7GBcpLu2y9o19UPSOU9ouhXZtIizCBo/m8iRKuNAyeUwe
         gUix8Jt4GgGRLJhoPa5d9vH0sTOdtEyA8KgEEg7aL8MzcwmDOSTGoP/1mB4/Xx6GF1tt
         V7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770409269; x=1771014069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ko2D7Sw5aswnp25O+4oleqxFUUcFw5gb0w9nlVIDjGo=;
        b=jmnZqYBa8qdWS2DcgXBUH+XdMOsKAH1DKtoKUFors0J32/y62Xw4BTtDidbCoksxA6
         qbRBWpUk6wmFXeYM4kxUH4i4Hrjo6z8AOqU3O40YcOirzoQNyIVCPAavhkv0/I5iDXlO
         861/IksOrQdO1HJbCIM8/BRRE0knpxOfWmVOIRyQWwKi9IQh5vg69W4K0oHN+wlPIyq2
         S1lHtAGXtby9y5sus8mE3/hfvecAx0eX1PukCn/5dtxWpl75+RwYh4B0/SPwwvna6qB/
         tmqH2i+ra8z4HELOwOoShwOpixmgcdQUnOJLxO9xdTlkm3Z6nwCoSFC6iO6ipkS+ONjO
         Tvnw==
X-Gm-Message-State: AOJu0YxsmUQI5SKYfT//bdQx/FDa3Q75O1xl/fTjha/OolztD1lfnjRl
	5nUPoFUCen9IDUNLeYKbSJxu5ss1emNVu1SgO/ANOEsEzOBP5be7wqyXMaDD80+SsGokUo4Gr0t
	mpUa3xdfaI+oe1eikpl9kN6eOFFxgyrA=
X-Gm-Gg: AZuq6aINZXHRMYBY5vzNN8QZsffZ3YWO3LpkFB6OzPw8Okf4sg+5TDQdo60DLXl8nd7
	Q1OFVXlNzpO3YgMwliXSECoZz3bGJJvsZ9p6/qBt07R41ArKQVk9PFfk7MuPhALtkgfBGzpDTsa
	sgW9RiSBETCWSCPf/KLrfPLvlVbkE2FchX60WV6NE6zA1ogVVrCfSB64W/eQ7acYXltTGk4qsag
	CKypb0yKqtunwPuh6dgogEHAOMg/I+s6Dr6c38LZSP2eWOuyEjHy8yQHyeL8qIWmytSeq6de+T7
	FDvLvcW9tw==
X-Received: by 2002:a05:6122:2a45:b0:55a:be72:7588 with SMTP id
 71dfb90a1353d-56705fe1e04mr1318848e0c.11.1770409268861; Fri, 06 Feb 2026
 12:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <c0fa65b429b4a5c33c4a2092e0e8d014a61e4569.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqq8qd5g25o.fsf@gitster.g>
In-Reply-To: <xmqq8qd5g25o.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 6 Feb 2026 21:21:10 +0100
X-Gm-Features: AZwV_QgAqGKffL0V015fMdm-Nw6wN5LZbr1tmNfC9KJ5BaC9h2R1JnS_8oNNsMs
Message-ID: <CADYq+fYMDyxgqe=CNJ7yxQZKsJJju=MDDBSXpuqmANoJBoWMyA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] interactive -p: add new `--rework-with-file` flag
 to interactive machinery
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 7:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > When using the interactive add, reset, stash or checkout machinery, we =
do
> > not have the option of reworking with a file because the session automa=
tically
> > advances to the next file or ends if we have just one file, immediately=
 all hunks
> > in a file are decided on.
>
> The last part of the sentence after the last comma does not read
> very well, at least to me.

Okay I will reword it.

>
> We recommend to fold lines in such a way that after a few e-mail
> exchange and quoting it will still stay within 80-column, so a
> practical fill-column value lies somewhere around ~70.  Your lines a
> slightly longer.

Okay thank you.
I will watch out for this.

>
> > Introduce the flag "--rework-with-file" when interactively selecting pa=
tches with the
> > '--patch' option, which does not auto advance, thereby allowing users t=
he option
> > to rework with files.
> > This ensures the current auto-advance method stays as the default metho=
d.
>
> OK.  There may be suggestions for better option names from others; I
> do not think of any right now.

Okay

>
> > diff --git a/add-interactive.h b/add-interactive.h
> > index da49502b76..aef2feca56 100644
> > --- a/add-interactive.h
> > +++ b/add-interactive.h
> > @@ -6,9 +6,10 @@
> >  struct add_p_opt {
> >       int context;
> >       int interhunkcontext;
> > +     int no_auto_advance;
> >  };
>
> We add a new risk of double-negation confusion, e.g.,
>
>     if (!opt->no_auto_advance)
>         ... do the auto-advance thing ...
>
> where it may be easier to follow if it were written
>
>     if (opt->auto_advance)
>         ... do the auto-advance thing ...
>
> Would it make it harder to arrange the code if we made this member
> "auto_advance" that defaults to "true"?  We have ADD_P_OPT_INIT that
> everybody is supposed to call already, like this
>
> > -#define ADD_P_OPT_INIT { .context =3D -1, .interhunkcontext =3D -1 }
> > +#define ADD_P_OPT_INIT { .context =3D -1, .interhunkcontext =3D -1, .n=
o_auto_advance =3D 0 }
>
> so I do not imagine it would be too much hassle.

No it won't.

>
> > @@ -28,7 +29,7 @@ struct add_i_state {
> >
> >       int use_single_key;
> >       char *interactive_diff_filter, *interactive_diff_algorithm;
> > -     int context, interhunkcontext;
> > +     int context, interhunkcontext, no_auto_advance;
> >  };
>
> Likewise.

Noted.

>
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 32709794b3..408827cf54 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -256,6 +256,8 @@ static struct option builtin_add_options[] =3D {
> >       OPT_GROUP(""),
> >       OPT_BOOL('i', "interactive", &add_interactive, N_("interactive pi=
cking")),
> >       OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks inter=
actively")),
> > +     OPT_BOOL(0, "rework-with-file", &add_p_opt.no_auto_advance,
> > +              N_("rework with files when selecting hunks interactively=
")),
>
> Likewise.

Thanks.

Abraham
