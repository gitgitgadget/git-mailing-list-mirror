Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2623A58F
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666010; cv=pass; b=fFEDPqbhl3JuKqLEnqQHjESdCIW4zKREJuWbkpn7HzQgYEk6vIc1GcEDt2fJ7nxUrw1eShbf2kTTFpRn2zgV+2lbjzfeVGBxZ7yn8bLb/zzk4rHFgKIvPuGMQmtuH8+pMgPI25z0vOWj3Ou62/dVKlZBR+aOCqnjvt061yf4gRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666010; c=relaxed/simple;
	bh=wrtO/yfE6DSr4uOLXO3n8HWfmEiho4d//JhXIDc0k+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiihWePmLT3+QonTlQC5U8b6FyOnGTYgpSiF1WsrPUOpKaugyfkO8uJgA5kRTDDRbWsu88+taX2josOMSpOy/454fTR5BrvJA3vWEXt06ThAeEv4nM+yuAG9zKhKtg+Iu7BfQLFo/W3BhYdBwB99ai++Nex+Jld9aO6m1PmqayU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCjNbASY; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCjNbASY"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-383153e06d6so25285441fa.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 08:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768666007; cv=none;
        d=google.com; s=arc-20240605;
        b=ZC5oTnyfy1dnH3IPex0Lq2yK9sqtEpjyQLO9siX2Ma1tV0V8O+Xx+r021xYudXJKsP
         C1RsrRX3xP+oobeGW29TkZqrsoZsZEYJDyfcXjZ4rTQja5hOwk4B9/2jNsEHcwtOfV9n
         FH9CjVtVwVVB5hs9n7b235jOYyNSDqSoMxPRLWFHLfmWqIdwTYUI7Dgu4hV5yziq+obK
         L4GFq/INfTpKyg75T1DaMobpSVwQk9JVcmt06ryFGgr/OF/7LQyz08FvmgvbXbW+Ehs2
         HJeZPOOOsZt4oON6eUriSMnT/FE3wy5dWz9GtuAsiAaqWLJLzWlJzAvE6Nxh9ZfhGJJl
         oidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hOsquFlfbEdSJnh/VWU1wTRllSj25sJhCnmfwNw0DEs=;
        fh=WbtTMoyxNqEe32j0rw/nukcp5oylJmbbNjRQv2o1Z3I=;
        b=HpEu8BOhvY7vmERZWr+zosxGdJE4zFbnsabVQ0sj5Qwya4M3f7bLf2e1hCS5GZ17d3
         kTrk4cg9x0BwyRIBD/q+eLwZj9Pq9gYpV6fAg8UWgQtCnB2GXWvJxFXYlrwspOVjqVWs
         gC63SpMw2a/JkpddNZ9+R1Vzl2KX5pe2ABlE0BaeE9DdinVYmig5ZI3WHbfXzPmkojIF
         B4j4okglhti14GWPdBylCpTThefRIJ+7nvsl6jeIDHYT3Adg3L5FH++L7QpABtaAA9gw
         3prKfUfOFBFQhV9lkmQy7QVe6lf0hOOHwCu2rczRF8pI2yC8JSHOFb6sBqAfe09zIKdq
         FgRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768666007; x=1769270807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOsquFlfbEdSJnh/VWU1wTRllSj25sJhCnmfwNw0DEs=;
        b=bCjNbASYf4KJmMU0yYeV14cYV3emt/yLsKLqHH6jdwdHFMm4XxalhYLe8axpnRDSg/
         KAAXMNzU3LBsy365ZJ+eRpttuYVL3/1Z9OXlQAKflLBe/aNeTfRBnQ05o8C031OjXURs
         AFz7SNsf1MLnGBiTps5U+C8TOCu9daKczoLDOyXj4TmZvoNIk8w8kgAXL1YtiGB3N+uN
         ZZ4vZ+m/JiijW/p27N2F/QJe785vEGlqpBfs6TWLbkMFfXEaCLm1whrKolu+ZJsiLsw/
         6JaF4iUiYJq/uPUHbuGy6mFvEPakajTe2XxU+zHVd/fD8ipQzRHNt1C7kWhqQwPMRGzH
         TBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768666007; x=1769270807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOsquFlfbEdSJnh/VWU1wTRllSj25sJhCnmfwNw0DEs=;
        b=DqCh9Fotaseilxh9LCGXcHFT/PPimSmKyuu0DTajt44BWlmxLYdq7HQMT3b/gWUQYU
         mRD62wJ26cLAbTv1Pf2bcEmlVQIOe5xlvOtKwqKy+lSvrkJP63b/vPS9biiVPhKNupya
         OgbEuqumS0mE/8C03rERm304YfRvSn+GdEFvPrZBtrZiSuolSQXfWCugmxvibDmhtT4v
         ZAFVPm2uh4zjhUNygp9RN9YI2CiklN5k0gRaTOOXsFd5q5d/cLRvJcu7DSw0AHTLdr6A
         AwgK7e6gQcGCg3zcGEyIpiT44Qm3gXkz+Ke6+sHL03YMEwE+rTC3pr2x3o2AD2GJgFbC
         BzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY6L9hSujYZZW3NfSLgOaEa9YPEuYPgfSAoEOq+PGpHuihuAN/m3Zc8ZuNLjA4RJRFNLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzW0xYlegjWMEXlpB24MR4RiEw308b5Vt2IHBRjwGIwLTGNAm2
	2BAJcA5C9WCVAe0qGt7ixxEQ1zH83hdVo6IoWQeCzaGnrlkKjoKLgTfjUBpakONT4X0c2h32cpq
	pBbsYkI6l6YLt/6FFCptlhcsmxE2j/M0=
X-Gm-Gg: AY/fxX5R1X1IXd1Fiw/4uceftz5LjndKa2OaxSAW1252bFO36/BasdklefEMqwam7xv
	XWAcC/5H07hc4OviGWGr/Mga+82Y2jWmy5Vj7dkjbpdd+GEpyqEzh46J7leI8OitbRLNT6pOkFV
	2xoGLqbuD6/kzUp/Pjv+O64eUVwIho7Q9KLbbFGKYbIO5irQpuEN+iCWp+tdGbnZZ07CCkTtT1+
	p9tnP+NYbWHCqDm63X+TGfc88qKxiz49CJYSt0cHm5RiqXPPTOa9SY/ExfXjwPGuKkfgog=
X-Received: by 2002:a05:651c:221b:b0:383:46e:4b50 with SMTP id
 38308e7fff4ca-38384335b6amr22846281fa.40.1768666007412; Sat, 17 Jan 2026
 08:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <xmqq4ip2ndse.fsf@gitster.g>
In-Reply-To: <xmqq4ip2ndse.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 17 Jan 2026 09:06:36 -0700
X-Gm-Features: AZwV_QgpmB-sUbr2v3NqEB7UJY48_wpBJI3FuRGXJuESLbxCOxbEWVMpeC_IhTA
Message-ID: <CAH=ZcbCfRziL7Aimq_9Z0k_8MqLRRy_NnD=HRhySYvu3HH3Y6w@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 10:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     if (new_capacity =3D=3D 0) {
> > +             free(self->ptr);
> > +             self->ptr =3D NULL;
>
>         if (!new_capacity)
>                 FREE_AND_NULL(self->ptr);
>         else
>                 ...;
>
> > +void ivec_free(void *self_)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     free(self->ptr);
> > +     self->ptr =3D NULL;
>
> Likewise.  Otherwise the code will fail coccicheck.
>
> > +     self->length =3D 0;
> > +     self->capacity =3D 0;
> > +     // DO NOT MODIFY element_size!!!
>
>         /* A single-liner comment in our codebase looks like this */
>

I will make these changes.
