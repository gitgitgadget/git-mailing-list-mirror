Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204F3B895E
	for <git@vger.kernel.org>; Thu,  7 May 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165623; cv=pass; b=jlP38/jSDfkIVDGOln3cph9S57vb8fjWtWoKKuvPhh7AhlHXo+n05fcyKUUqg2p32WQB25rutzR9NuQG8rFJvxtiGSJOVujTwoVQHYOp4FjoxYdNUkAs8EeR+t39oF1qv82tj7S5JP02ZPuv5td1RzokZhdZfQZWYz5w1gbLfmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165623; c=relaxed/simple;
	bh=Ono0LJb53hAPnN1k7TZD1ID4yb/dDswStcI7aXKBwPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnILJDSaFANfjztgLIOlEnjeHiQ4HySSDFEzMeWSyDZOYTmt5bu82LgufQpsLYiU/3M6s54780ZcinnU0QGjwVU0t+9OQD5pHAaUIdEwmTgwEfmwBwVQ7J8AvJYtUl28DRQO0g+9GbChe7jKKls3k/N3SwwWA25Ysmc6cnBOHVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA27S+2v; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA27S+2v"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd5e373d07so9900607b3.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 07:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778165621; cv=none;
        d=google.com; s=arc-20240605;
        b=cVmQT9mw9rGVP5/b4lPFjq+3+2yAN1raSb/nnNiyyOOodQCVtjWKV1a/Tr6y6/0Q1C
         g+saY51zd/UGAhT1IdvWYcwxus41+tVvvJo5zaGjy9R3he0vGPscmYP52iPkvGViPwOQ
         u6xiVQQa3RSU0aar5jWzKfh49DtUTEdFTYeTfthoJ9yBUgIA6Krp26WdSd5CPFvY4DoJ
         14CzhJC2sc5ZTrOiD83rLFv8KtFca6Gkrt+cSY3u4GkF03Dlh1yPGxTJoKwmXtkX9xI1
         i2rA2Hwp2hVzniwpzRPu4MHbmkqPH2f8U3ctvlGVgVfAWmomP8aY2ECO7EnwYAGwJWvY
         4YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6NDGMCQmt+CFgoAVCJ+vcQplGvywN5fUmRbWeo4N+w=;
        fh=soNPjaifp3sUPfGhzvTFwZlMk7wd4yY31UPS9K3+ylo=;
        b=SW2P+KNhqUDf6NvKKfHe/mpZTmr4Qj1qhBNuYHMnDDdPjmggV4WNlJ6roaXcpN0bPu
         E562kWqwR1Ybd6Yntv+twPW0CKpwMDQGxFIGgAmXOE50H4ESWqEXpbfdBzR7Rdq/ldb1
         Ox8INgG8lvjHTvaGZMFX+Wpm9RtL6VqfxSkfIAtaK0CbXkfFPswruevyFg/7hFqPTIIg
         /4G0FyQeMhdORE3xvAxXfN3WCaqbYIAvaGlqfi2nQIoWT1cMRpxAUsK6l7bflNEyAoWt
         Y4OB46xKdk1h2+Wqud8Mq8ehjHxdWdy4h6hNVdYpsiNaX8Edgur5g16dfG72c2cEJrPU
         0uww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778165621; x=1778770421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6NDGMCQmt+CFgoAVCJ+vcQplGvywN5fUmRbWeo4N+w=;
        b=CA27S+2vh903jq8IFLQmEDStuEBRJwlKbDz8wFL9HkG9e12+gvgBN18ZoUh2vUVHxe
         gqJJ+aZsmBCcFMrxzpEw67eJ1MuuUpb36gB2bseKTgIwJU6MWz4Ge7v9KgTR646ceLbn
         FO4/+G8hirb2VcF6YBYHZup7EwB8MgxRHz8jj20m5de7PoeSdumJ+ws+B8ja6ZiBALY3
         XicoewhQL4OLTEASAB/ACP0ekIIdYjzaMTm+Rb0XceRJAexRbF6dEjwtJMfSZ16fow0b
         csX+bJjS5e0xtZqIadSAWz76TDycIh7WfCM+3bzYRlCnCKCrsAZ9MIQYS2NDGf/gHgYe
         IjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165621; x=1778770421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6NDGMCQmt+CFgoAVCJ+vcQplGvywN5fUmRbWeo4N+w=;
        b=rYMYLnNr5BSrmPMB+mCwpT2vNdNKXLWF9+i+lzCxtu5DLeD9g91WCwL8PbATfj5UaF
         VY0OqpeOV0AXcs5NdwB2fImEyDyXi9iJD3f+QOvpytgIIZFTZwP6d5x5t+OEQuFpm0dB
         zyqb2dbyQygMhS1e6qFPRe5bRoujtCeR3JF5nl4Ap6nQ9zKl5Kpjj3Txrg47HdEjvrd+
         C4OWaeQjtQXl/6UJQ2pQCIfOwac9krXN4mpvMXYvWdCMhHNIKNPlJcqSdfDMNFu2q1uo
         M8XkG9us8OrzpEQiFHQ5u5Y0N5RvXJrd7rUUoeO8vrXdEC17w7J+UY/aD9OcjMm+6nMJ
         QLSg==
X-Forwarded-Encrypted: i=1; AFNElJ8n4lGi0c4kiynHHUPM4pyEske1mu1/0bdWYcHqoRK0l0UfuMHM0pMgndNuK2qE/AZu3Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0mJGjWIs5k6RB7fa6ommav4SFPOQJzuZFYtUCph+z2QUFho5
	CEeSx6iD/2sqhKXUYUzHQ5C7Dvg9XOOXsopPBasPh1oPByJ/fmzBDTbUKd2nV1iNTDTTrl+U5Rr
	JvEtn9Sql14jyPtWIPjOzPLNqZM04qY8=
X-Gm-Gg: Acq92OGkFx3x7aETGB/x2G8H2zvd8TN12LOEl+VkR/IPHIk6P/vs5B7xph6b6LwQYxD
	x1XwzpIhNlO/2Yo+ogtT4935cIYdSSxb0Yh6jWR1KwsxVwVy362BVxkzjiEVZ8Lybdh8+ugJNfw
	yhqiorDoSrSh8N0LXwAlfcMjXOEkErmN+inckHL2kqCf/AtVaK50fjyAD1vgPWhCXXc7UEERaKj
	jl+3xg7f7rV60Lie0omRW0Rq+eJ5S13UmJIEP5nue1kuaCBtxr0faULOrRII0GbCPaMkWCbyck+
	/VnW+Szu//spPolw7Qn4DTFOGeNe+uh+PkuJt9q8hEggUChjqt7DjgpsE2X5b34hy42vvCzymU2
	LWiJfkuoweukJefaM4Eo1zwCJkHR7chhZHLfoDZ1VGVQTI9LWBYQikRolTl4Xw1fikI+EMiJ4+R
	4LaWjaiJiDSKQy64tN
X-Received: by 2002:a05:690c:11:b0:7b3:c611:7ef5 with SMTP id
 00721157ae682-7bdf5d6b8bamr92803457b3.6.1778165620861; Thu, 07 May 2026
 07:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506235459.529862-1-javierbassi@gmail.com>
 <CAN5EUNRT7V3BrtyU0UYwGVnJ51LWSsNi1OnzMB5WL=w8vhKmrw@mail.gmail.com> <1f811deb-7cbb-4fe0-ab40-49274b1db165@gmail.com>
In-Reply-To: <1f811deb-7cbb-4fe0-ab40-49274b1db165@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 7 May 2026 16:53:27 +0200
X-Gm-Features: AVHnY4KgZpZu1DvlV8GDfUqsHOGtT7jqdASLoAEHONjWK5VAVvZj3GA9rrfFcmY
Message-ID: <CAN5EUNTOtRvjiJ4v4wdCPazSafLRdUmzc9rGCMvwjRKVz6Hz=A@mail.gmail.com>
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with --word-diff
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Javier Bassi <javierbassi@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>, 
	Rene Scharfe <l.s.r@web.de>, Elijah Newren <newren@gmail.com>, Ruben Justo <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 7 may 2026 a las 15:24, Phillip Wood
(<phillip.wood123@gmail.com>) escribi=C3=B3:
>
> On 07/05/2026 08:55, Pablo wrote:
> > El jue, 7 may 2026 a las 1:58, Javier Bassi (<javierbassi@gmail.com>) e=
scribi=C3=B3:
> >>
> >> +static void add_word_diff_line(struct strbuf *old, struct strbuf *new=
,
> >> +                              const char *line, size_t len, char mark=
er)
> >> +{
> >> +       if (marker =3D=3D '-' || marker =3D=3D '+' || *line =3D=3D ' '=
) {
> >> +               line++;
> >> +               len--;
> >> +       }
> >
> > Maybe a tiny comment here would help, to know why '*line' is being
> > checked here instead of 'marker'. They seem the same and one has to go
> > to marker declaration and see the comment at 'normalize_marker()'
> >
> >    /* Empty context lines may omit the leading ' ' */
>
> That's a good point - it might be clearer to use
>
>         if (marker =3D=3D *line) {
>                 line++;
>                 len--;
>         }
>
> instead. That also trims lines starting with '\' but that shouldn't
> matter as the code should be checking "marker" rather than "line".

Yeah, I like "marker =3D=3D *line".
About lines starting with '\', "add_word_diff_line()" is called after
"marker =3D=3D '\\'" block which ends in "continue;" skipping
"add_word_diff_line()" call when marker =3D=3D '\\'.

>
> >> +
> >> +               if (marker =3D=3D '\\') {
> >> +                       if (last_marker !=3D '+')
> >> +                               trim_trailing_lf(old);
> >> +                       if (last_marker !=3D '-')
> >> +                               trim_trailing_lf(new);
> >> +                       continue;
> >> +               }
> >
> > Here we check about "\No newline at end of file", after this point I
> > believe that 'buf->buf[buf->len - 1] =3D=3D '\n'' will always be true.
> > Same should be for 'buf->len' because "\No newline at end of file"
> > shouldn't come first and a '+' '-' line should have been added on a
> > previous iteration, but the check it's fine, just in case I'm wrong.
> >
> > What I want to point out is, is the 'trim_trailing_lf' function
> > necessary? It's only called in the same place and it carries a check
> > that could be on the caller instead, leaving  the function only with
> > 'strbuf_setlen(buf, buf->len - 1);" making sense to inline it at this
> > point.
> > You could keep the buf->len check:
> >
> >    if (marker =3D=3D '\\') {
> >            if (last_marker !=3D '+' && old->len)
> >                     strbuf_setlen(old, old->len - 1);
> >            if (last_marker !=3D '-' && new->len)
> >                     strbuf_setlen(new, new->len - 1);
> >            continue;
> >    }
>
> Should we be trimming '\r\n' if the file has dos style line endings?

True, I haven't thought of that. Then I take back what I said about
inlining it, I'd keep the helper just as is (same for the if (marker
=3D=3D '\\' block)) adding a check for '\r' after trimming '\n'.

--
Pablo

>
> Thanks
>
> Phillip
>
