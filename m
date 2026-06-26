Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B443F23BE
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475217; cv=pass; b=WEDoRI+PbbTr5uZnnskd4RR2SliJeG+QBjMnHOhLtCzH87sRQQ7/moZRFQpL+IVg8RCx1UOnV0+uqbsiWg18J9JjwfE6diM3ZNs9gBezh3onyLBCmpEZprtMorAA3mCXDCOZJHUdTfa8uckl6rWsVAM4mxEPMTtSVWcH2EZjgmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475217; c=relaxed/simple;
	bh=wB4nbpt2L4pxsOlKUki7VzgYegXpeEx856NT9c2fFB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZ7aGrx0en9K1SgnFAPhBUdH6oEaOKrWmQlrIUglUPXrHxXKLqjSfxd7JzIbQoSnKrpe5Wy3yrXtU5QquWxJyFTYWk6BLqS3lN5soDQi3OFTathUx4TgwwHDTCXC7Nm7lGRDQUpcVCndShsXb6JxlqamOxLCPDGUkT81p5tfJDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvT6qeTD; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvT6qeTD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8000e21f014so12069447b3.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782475215; cv=none;
        d=google.com; s=arc-20260327;
        b=FkNLIl5/TJas/mt+JNpaWaGk6DuQHjS5Gu4bnhxZ8dmFDRp1OLFrPC8e9v1ZnwKMvB
         6KhcK6/+0PycDAmMV3KlKx8yv9gSQd843tQVRbaitXsdYF1zFfPg46KM1Y9DOUhWKRk1
         CnYsDWxT9UzgB3BJpeuEIdnV6slyWL3qAbCApxJOPB2xmhQzd81J4mKITDPZQZsQEWqT
         Mvhw+OWJN7PhtmSU5AOwzBMXdeTg4hDf0Lk4Oz3xIMCFXs1EbZ8rYsfmkQrU06a/fJsi
         UPj3uf1TTuBSxV3Ejxe2mia0/6oy1URhBhT7G3l5vHkYTfFk++5RtvkrT0M1sEW+M3Nt
         QjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gLB2ValukT3Nny4k6Ipn7aMEfAmbf+ewuiCMFnxGUBI=;
        fh=BY0PJxl/9NWRhq6Hk5NfDhGbQiIoMa5/xMUI66hWeLM=;
        b=cWaKYNEuLhXCbuLxAdws7pGywcL5GwFkaUh0lZSx6+9d3fwdRYMAngrmNUtninipII
         E7fAGpJksnLzTGWCxdMY4S914EuG/oXNrbHe165TfYB9DXpUIBByIv4MH8SCiZNXdNnG
         jOIX/7NenYeev1Bcj0nW1+Xmt0vrTAdt2cX6lyl7uCqdUPEESkj0a3CuOkNS0rcceanO
         3jiNf+VhcckTo6rjStSGgpoTetWf+jYb84uKs5RYbLc8p+zzwkaZs+8AQM3l4M2yjcSL
         qU5ESIMzSTZNzTc4QN/wFeJeL0/odnZIvtgXQDIA0bbEaagqDd9NoRJ1WRHUSvu+PQHQ
         gqRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782475215; x=1783080015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLB2ValukT3Nny4k6Ipn7aMEfAmbf+ewuiCMFnxGUBI=;
        b=OvT6qeTDxrqBSYHjlZvZ6cc+QxK7K1R6SyFJ2RVeyq9U3QntX3ORmf0bcT3MLjK7gv
         tKTPDxhpYO/QaopJhW9W0Tp6L83jSnvMYd9Px5h3zbebqRSyTWXnZlQnwW+YPL2yTMX1
         P83VO33Axbw0i8qwBz0k3dFUUO3GI1pNDyLzYn9+trskPUUwGy0g4QBmGYe8FzgkdKz6
         aVQmSDUuorWUQuaVt7+VAd0HPxRM/3vH/nkC2lsNBIqOuqBnIHnixSwEgwJ9LCSG7ENN
         uOGw07aTuj8w/omfrLnsg5Wkmbw762OU3Z6HqdbTUYXycnXVsVg787z7mzgaNDbIAo+2
         ZTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782475215; x=1783080015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gLB2ValukT3Nny4k6Ipn7aMEfAmbf+ewuiCMFnxGUBI=;
        b=AhLDT9elsCHn+gVVix8EpuAWw0Kq1T+t/HfyGTyzt25JIjg3BI6vn9P39d2OpbsCM/
         1jZSYVc3AilnuGOx4+h0nV1OclOQOjiyYMmyD9N8/+paPO9D+gjqNdoY+Ugs5vGPIli2
         NVF+sPSPTkcewJsy34xIqQGhIQq7NW0iQ2JpEhZFVLLVFkGR8zUvIZsqENWz9iSWVz+1
         kB4a2OnNvbcFpwBDkBm26YcKcTy03X/iQTNAAkayZT4HxYfetwqO8nDqunclIEZjk+Tj
         Klfta1UZ9sFwDiPRw5eFhFCYURKAUeNYt1Rdg7Kzsddtu4vz9NUcg62MPJ10LbknFSgF
         wmCQ==
X-Gm-Message-State: AOJu0YyyHTa0zdxxLZGnBeQxZis0Z5Cwr64LY7tTET1BXq+ZA/V+dPKB
	0I5RFudYhKsxgdeMShHM/W1hUkv1AEFe8WL195KR5Ti/r6oQtrW3RZKectC4fUzYX/PZwwRitbJ
	vFbyJ6Dp9hxM8yjUnhzgp+mEHCEVDZ/8=
X-Gm-Gg: AfdE7cmVTbSdCgY3EqaCcLipbmTZ8szeOeRz3GyWbV0wVLWI9Kk/DBIEV3BDqoczcTM
	RVGzCSiWSBZym85daYi2Cdb8G9uT8JtuUJxz2GEM44o/eI1bBjk7La2sgMjcyAn55nv6kvp2lyM
	VHFyt9c0oaQMmzu3LdPF1arbQCfJKuZaslP3KW4ax/cFngLFccvDdXGbkhcXiCLq5ZDqzZqhk96
	6nz8YdwTKHvPPaKA/DO222pEg4oi1hFM/MdOfd3tZJRJKfR56kWSBBTyQY1kN4dGWl2p6TWOdqr
	IEU4SWuC42eMhfjlnlV8cwtxmQKFp3OHchCg2HDwOfKW4cRakWOO+FgKNIY4yKZ4wg4y9Kud5qy
	YjQj4XXcHgasV+smJkr4KkZhUBwbhmVfOL43dgaFI3sDARZLBq0BSrqmbUEOVv02tZECGmBM=
X-Received: by 2002:a05:690c:c:b0:80c:85c6:898b with SMTP id
 00721157ae682-80c85c68ea6mr695257b3.58.1782475215024; Fri, 26 Jun 2026
 05:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-2-09f7ffe21a53@gmail.com> <xmqqjyrme393.fsf@gitster.g>
In-Reply-To: <xmqqjyrme393.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 26 Jun 2026 14:00:01 +0200
X-Gm-Features: AVVi8CfXvDjljSWCE778ckN2pqHPyZ4huqtE2p-vj5hICPfAOAg4yBAqsC3aeAw
Message-ID: <CAN5EUNStfvgBCpwokfooa9MY3ZGSf9f=xok+aeKXKK9Zv8uSgw@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 02/13] git-compat-util: add strtoul_szt() with
 error handling
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, jltobler@gmail.com, karthik.188@gmail.com, 
	peff@peff.net, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 25 jun 2026 a las 23:09, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > From: Eric Ju <eric.peijian@gmail.com>
> >
> > We already have strtoul_ui() and similar functions that provide proper
> > error handling using strtoul from the standard library. However,
> > there isn't currently a variant that returns an unsigned long.
>
> But this one no longer returns an unsigned long anymore ;-)

True, I missed that.

>
> > This variant is needed in a subsequent commit to enable returning an
> > size_t with proper error handling.
>
> I think it would allow a lot of code paths that want to deal with
> size_t not to worry about "is ulong large enough?" to have a
> function like this, but for that to happen, the implementation of
> the function must carefully think through if these steps do sensible
> things on platforms with too small ulong (which often is OK when we
> are coming from decimal string to ulong and then to size_t) and too
> large ulong (which is not OK, when coming from decimal string to
> ulong which might be fine, but will bust the size of the final
> type), etc.

Ok, so the strtoul_szt() is not a bad idea but it is not ok how I did
it. What about using uintmax_t and strtoumax() and after that (before
casting) check if it fits into a size_t?
Something like:

static inline int strtoumax_szt(char const *s, int base, size_t *result)
{
     uintmax_t val;
     char *p;

     errno =3D 0;
     /* negative values would be accepted by strtoul */
     if (strchr(s, '-'))
             return -1;
     val =3D strtoumax(s, &p, base);
     if ((errno || *p || p =3D=3D s) || val > SIZE_MAX)
             return -1;
     *result =3D val;
     return 0;
}

Alternatively I could go back to the unsigned long version and make
the relevant checks on the caller which is only one place at
`fetch_object_info()`

>
> Also, would it make sense to add yet another "static inline" like
> this?  After the dust settles, we may want to rethink these strtoX
> wrappers we have, benchmark, and possibly make them into a proper
> library function, not "static inline" that may bloat the runtime.

Yeah, I thought the same, I kept it on the header also to avoid
bloating this series too much because it's kinda big already. But a
follow-up after would be a good idea tho.

>
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 8809776407..7f417f1acf 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int ba=
se, unsigned int *result)
> >       return 0;
> >  }
> >
> > +/*
> > + * Convert a string to a size_t using the standard library's strtoul, =
with
> > + * additional error handling to ensure robustness.
> > + */
> > +static inline int strtoul_szt(char const *s, int base, size_t *result)
> > +{
> > +     unsigned long ul;
> > +     char *p;
> > +
> > +     errno =3D 0;
> > +     /* negative values would be accepted by strtoul */
> > +     if (strchr(s, '-'))
> > +             return -1;
> > +     ul =3D strtoul(s, &p, base);
> > +     if (errno || *p || p =3D=3D s)
> > +             return -1;
> > +     *result =3D ul;
> > +     return 0;
> > +}
> > +
> >  static inline int strtol_i(char const *s, int base, int *result)
> >  {
> >       long ul;

Thanks for the review,
Pablo.
