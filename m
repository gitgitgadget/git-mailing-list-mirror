Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8D27706
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311240; cv=none; b=nMU1nsDiB6WTMT5J4z1cM+NvYGhoQJxOk0cFaHaSmHSQq+d1h7hYJacFzHBfFzgTR/XjC3QP0s5aYO/yMerdVUHz+gxAHniXVY8INCuT7riHxuH6oL/vJv5XO7Z7HdDcXekc4XLH5x3+9UJU/tEfrABsWavd+zxFg/CQXI2Z3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311240; c=relaxed/simple;
	bh=/ogG4isJumKMn5BYgVoMiWBZadouR7VIdV/NW6jFlq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h72uLMH2WT16p0RTy7eTLMZ2SN+pxM1B6EPUZwPnYecZ1huG8pAiMCYdgPcmCwfYsLkEqEmeYnXcUR8WQ00SHTU3oV8cLQZQ4t4KY88nURffxetx6pcF8PFMF3BxVHP8/1CQU/TgezOCTFhSCpD1vOqFld3Sdpc7rimRZU4arm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbVFYBY5; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbVFYBY5"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5235db99207so555162e0c.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 17:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741311238; x=1741916038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n46trzAMtr23Yiyb7rRC7VbUwXrfZZfQ1tMIU7TAnKM=;
        b=WbVFYBY5tPmToZmnxR1arBkuY6+OSVUzabjq1Meq3VCDKuoWY9kJSjcLBE7L7msdks
         xgKv8Wge4mNCqbiDsDyxQMlx/kwYyXEFmo7i3enCFSGjaB/IrY8gSvm6fl8fDVZxGV/T
         RYiiU3SMXK2wZ9hINzWeJTwl2XBh7rhXnlwYXdyXkZaZc6/qTuhpBooSX4AL93Cey9Ro
         v7FIVYodTzeltAZg73jKkwcRHeOiep/DxL7VHd7V3sFGN9GCa/cw6AL1NSBgU8grHfnI
         80mXY7OEHqBtlUfwUKv7/AoDX1qPUeTG840TUxp3gdKvv/ip58pp7Pnzv1ZNvEjaJfAc
         XXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741311238; x=1741916038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n46trzAMtr23Yiyb7rRC7VbUwXrfZZfQ1tMIU7TAnKM=;
        b=pvdNk8H/+H1FRjGDGC6FZLKhA200pdirJ9um73Fxgx2VFoy4tLdbxRX7mSdi6FA9Oj
         HT8Pd7csUQFinDFDGCdgkw4ilzovTvkeAs4aBToJutbSzQC14lw2ZRWBX8ybOcAfg4yQ
         5sPbkRgaYC2Tlhkt/LWpbMsPDsflM3uXXbXyJ24AHH2QAkSHvFdbnI1rNnkgBwQSLicA
         DssQVfXKNimkjRPTS0TqVsFQbGMks1NrvqGb8eGY/cx3nnHc3yypu/rvgV+Rqh6wWe2X
         L/m6UrdVcKrlv2/GGzo5hvIImmlw/xn7Odu1DPNDiG+ImtoV7pKmtBITHftNohQ97/eP
         VPTA==
X-Gm-Message-State: AOJu0YwUD2tjYF9nHKgVFvvUU4n4SopjZXrMPhoRMlIu5JkUTapK7c0a
	sLi7Ra4ayaF4wAmk+WfrhUmfpUAOixFhbl6Fz6vfG/SClg/JsA3l78sJz/A15SgZ+rreMvxnfHW
	E1nw15IYP6n61TYEab1/cdeUt0Gw=
X-Gm-Gg: ASbGnct2QtDZVdWWfzczXEtv7ReqnDDiQXzYEoFKGXYKrRDrIlG//2Okma24ukVrUGm
	Rmp9lanra5+vFHxfnNqRuuq0RGqgwI5Cwu7gtWjsvXzBikX+z+PaG8eCtdjOtUbWo1qJKNiMRfZ
	Q4u9Ejyvg4Asg8bTckKRNhclt8VA==
X-Google-Smtp-Source: AGHT+IHMpF0XSHfhv/D7G0egi96ZKA+Ikr5NlMdkmFTZdGnJC5YWm9v9BUvbFCCcuG21KiNoTkoyEpqwQ3BEKy8+alk=
X-Received: by 2002:a05:6102:54a3:b0:4c1:875e:2215 with SMTP id
 ada2fe7eead31-4c30a534d15mr1058329137.1.1741311238057; Thu, 06 Mar 2025
 17:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com> <20250306143629.1267358-2-usmanakinyemi202@gmail.com>
 <xmqqcyeuhwqb.fsf@gitster.g>
In-Reply-To: <xmqqcyeuhwqb.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 7 Mar 2025 07:03:47 +0530
X-Gm-Features: AQ5f1Jo4AckckjB1iJZuGSWmrMU8cHrK8MtMpWi2naVj2iO5Zd1O9SoKA6u_q5E
Message-ID: <CAPSxiM8m7oeQ+DNPjzZzve4F510RYhWTfM-wsg5RabJ9fSF7Yg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] config: teach repo_config to allow `repo` to be NULL
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, johncai86@gmail.com, 
	me@ttaylorr.com, ps@pks.im, shejialuo@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> >  void repo_config(struct repository *repo, config_fn_t fn, void *data)
> >  {
> > +     if (!repo) {
> > +             read_very_early_config(fn, data);
> > +             return;
> > +     }
> >       git_config_check_init(repo);
> >       configset_iter(repo->config, fn, data);
> >  }
> > diff --git a/config.h b/config.h
> > index 5c730c4f89..1e5b22dfc4 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -219,6 +219,9 @@ void read_very_early_config(config_fn_t cb, void *d=
ata);
> >   * repo-specific one; by overwriting, the higher-priority repo-specifi=
c
> >   * value is left at the end).
> >   *
> > + * In cases where the repository variable is NULL, repo_config() will
> > + * call read_early_config().
> > + *
>
> early or very early?
>
> I am wondering if we should describe the effect we want out of the
> design more prominently than the way we try to obtain the effect
> here.  In other words, instead of (rather, in addition to) saying
> that we call helper X, wouldn't it be more helpful to future
> developers why we call X, to convey the intent, so that they know
> how to adjust when for example what X does change or X even
> disappears?  E.g.,
>
>         When repo=3D=3DNULL, skip reading the per-repository
>         configuration file but still use the system- and globa-
>         configuration, by calling X.  Note that this ignores
>         one-time configuration override "git -c var=3Dval" given from
>         the command line.  The only use case the feature to allow
>         passing repo=3D=3DNULL was designed for is to support handling
>         "git foo -h" (which lets git.c:run_builtin() to pass NULL
>         and have the cmd_foo() call repo_config() before calling
>         parse_options() to notice "-h", give help and exit) for a
>         command that ordinarily require a repository, so this
>         limitation may be OK (but if needed you are welcome to fix
>         it).
>
> That way, folks who are planning to update read_veriy_early_config()
> so that it pays attention to the "git -c var=3Dval" in the future will
> be rest assured that they won't be breaking this caller with their
> planned change.
>
> Of course I didn't spend enough brainpower to make the above comment
> more concise and to the point, which the final version should be,
> but hopefully you got the idea.
Yeah, thanks Junio, I understand clearly. Your comment is well explained al=
so.
I will refine it and add it in an updated patch.
Thank you.
>
> Thanks.
>
