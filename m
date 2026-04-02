Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FE333442
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112924; cv=pass; b=YZT9/BcAx5vOJGfRKI7hehXUnJJRnwIoVYnc4akBevxObnEtNarG7kIJ218LiLSQIlYzhf1AG/pT8XCaJgvkqLfw4+PAdCgyvb022eF2uEXn6MxZimiS26KTHaIva2KqLKR/AZ56H6BAo2eo2DSd5SZ6fxWp2a4bxJ8d7bHncV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112924; c=relaxed/simple;
	bh=iRL4kOYAmqOuuOm3hXUyx05H7F2iN3Ig+np0b9QNt5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIswNyfDZJj68/bsZ9f5RQDLwWAKsJvVYtQc1n6txgGio0+7yl/U3Qoilotat5yCbM8ybNNZw6c1jfzEXlz2YUbbDyu30IW+r7l8exFmsw+Wb9TJfrbQMMQJXOtmOul+hyzH8MliibbQep46quX/nWPiWl6oKAViNw0XZ25hEew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3VqTMdg; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3VqTMdg"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12713e56abdso264290c88.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 23:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775112923; cv=none;
        d=google.com; s=arc-20240605;
        b=Uru+pfIpj6lORAy+xknPaZ5NDrqMRrH6DBomqqpgmZPEezwhTt9eye3JtQUAcMASBG
         Z8Lk95oP3LbvAsg42PURwHVUuwKdemh9zkDqQHtzDZd45tTGT3PXVfJCgBj1K0QixRPN
         paKmEAqE41MT2cU0+rtk99RzfnFKzsZhhG6xpfWn32LPD+u5huOLios07oJ5cvTqdlQA
         QFiC9AaMc3jyMBLV3ahHN8jJsIB9zoOvHBHFUdxyfSBItSTmLugIXEPq2L+ivDNiycpg
         D6Wp/7PDZYeQg/9qZ0x151KZgiMSu1J3ObeUhCFeb0jbxFH3YNskjJ5HqGVCU3TOUHhK
         7OGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFdmnwReGIYrvYD9WJ5/ODzJhEKJpUiXmr17DtsAI7I=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=alTKjVzvpGWv0U1RQE0EGzsdPfuFDmOs7BYagXo+rs9nJ86+NXDRUFf9r4Yqxhis9v
         7VCR4QxVquSo+8fWXZ1d4D6XeejJG6ijHw4edV7z9WW9xDWifBkifECbYIKA3ncilLZb
         ve94q1AtMrhAOmE0ocTU5sncOny3BrxiuvX9k07nLZKPWL9BsS4ZWfMEM/dEkjXEHnPL
         cLsQzqoA9XxjUS0lemi3nk5kOkFGvAiK955jHXPalV2w92KbCiQJ1ur4G0fiMog8uuup
         moR47KKLggqyMe74IlEhAPh/QHlQpPqf4asLtdfwIriCdkH6T1ZRz8yigr+u0Zr0TTgA
         SoYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775112923; x=1775717723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFdmnwReGIYrvYD9WJ5/ODzJhEKJpUiXmr17DtsAI7I=;
        b=c3VqTMdgk7cYLy+FUF6ckidefzEPFnZKV05wbLktQdzNeXpo1QTRkcoFiVMAtCQPA0
         dnp8/Bz4EACqvkNB+AGGd05ON+6LVRbuRgETI1YWxg7XEs1YuI/qj6QStoa8BrN/zMDc
         rxLGTjGHKwu0CLKMlVts75AVAgfi7k7Nmj74dMyJTiPYkaNv8okkYgi8lwBRVTi/zyJ7
         XcWE62d2DAJtDsiompwvGzMrDB9joQqsQUJKc6NI9rFJVyC3WM3eGbrQk10OOBSqbYl7
         cTCXcu3mSTdEr/Ryf5V+GzGkDC5B+qfaHJ3LlFr5gRJdZLXxh6+QvVVGTnYlf8NF6jgp
         GnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112923; x=1775717723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFdmnwReGIYrvYD9WJ5/ODzJhEKJpUiXmr17DtsAI7I=;
        b=Cr51GhIhduYTJyOsSNpc68steu1jF4M8Tx0eC+pUQXdiVOXSLnp83DGU8pKp0ZP2Y6
         wuIti5RWkx44bDSu8nRsjP870sGC0caH1p5b03q+g2CFxBrq4OnTcb4DDHqJbLXiTOIl
         mQey5inhyN644KhApPwdGINk6mBiY8jSfU/rP/ZY1osKLz7Rbcw3P4pF1fLK4V0mMR2A
         kNXJ7Lqu51Gnot6zJwro5FhJ2S3fsmQ23717pJoER0F9KVnSPh5HAM/nV8zIsd9MdKlm
         soa2rbBKHprr89Ol//obNYQ3JjZ1AYKmolFTKwKy0VnnSkSES4CQHk+Sc2jPjjkmSpFe
         mCUg==
X-Gm-Message-State: AOJu0Yzo6dR6YFPZK1XfmTqj4D3+VwLErorFcG1a3Hhr6Jv5opJa8Vun
	+GUhYxgNOsB6FMadfavs6S1BvopX25AxlOtTstG7qJdQ/nhOFz7+/Wil2Xm3XTfuq9b8cOEKZaC
	vdc3ge9k9YSl99gzEO8zH3hKR3uj2yzk=
X-Gm-Gg: ATEYQzxVR6yxm/OXH+lGehKrPf/dTAUcnA1nsF8TywBsMZez41a07MTH1UrXbEOuwwN
	TI7J1JELEzx1V7wrckRgyzkIOadnuk78hqH1LcTmhH1xU+vbuDl3Oqf8fbEOJ0vo2PwfEvh8PEr
	mJVOfrUE+6MONry/FqOCaz8X7UJtjYVHTpdmiZVhccbQ6JPENR73hkpFjk35e97NQM0wNajXwC3
	rpSHKEkYjp+jK0j6eMr6qluT+GS8454B0YFX1Y2N3Jp42OhYYb4utuJqnBb+pRJGICGaVTza3BM
	E3J9ZS6W4j0vPj2w4126OheHww0C295fGhE0babD9/g3qtEboRTgcqB5Exhyekqi+eYl
X-Received: by 2002:a05:7022:418c:b0:128:ceac:6db4 with SMTP id
 a92af1059eb24-12bf07bd928mr479986c88.6.1775112922704; Wed, 01 Apr 2026
 23:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-12-christian.couder@gmail.com> <acUkwrm1rN4l4qgP@pks.im>
In-Reply-To: <acUkwrm1rN4l4qgP@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 08:55:09 +0200
X-Gm-Features: AQROBzA4febzXQz3fy1ZZmGY6teXuY9s4tpQZExOtpjOg2IrwMwtTPY7NSoiZSo
Message-ID: <CAP8UFD1G2np6dJX_J6-5-Pxn=j_GgJ2BVdDkaxVw34EU6DDCLQ@mail.gmail.com>
Subject: Re: [PATCH 11/16] promisor-remote: refactor should_accept_remote()
 control flow
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:14AM +0100, Christian Couder wrote:
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 8f2c1280c3..c2f0eb7223 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -665,6 +665,12 @@ static int should_accept_remote(enum accept_promis=
or accept,
> >       const char *remote_name =3D advertised->name;
> >       const char *remote_url =3D advertised->url;
> >
> > +     if (!remote_url || !*remote_url) {
> > +             warning(_("no or empty URL advertised for remote '%s', "
> > +                       "ignoring this remote"), remote_name);
> > +             return 0;
> > +     }
> > +
> >       if (accept =3D=3D ACCEPT_ALL)
> >               return all_fields_match(advertised, config_info, NULL);
>
> You mention that it shouldn't change behaviour in well-defined cases
> where the remote sends non-empty URLs. But does it change behaviour in
> ill-defined cases where the remote sends empty ones?

Yes, it could change the behavior in the ill-defined case where the
remote sends empty URLs.

So I have added a new patch to catch advertised empty URLs and empty
remote names at parsing time. It is patch 4/10 ("promisor-remote:
reject empty name or URL in advertised remote") in the preparatory
series I will send very soon now.

> In other words, does this fix a bug that can be hit in the real world?

No, because I think Git has the only implementation of the
"promisor-remote" capability, and a Git server doesn't advertise empty
URLs. (promisor_config_info_list() ignores empty URLs.)

So the ill-defined case could only happen if people use their own fork
of either Git (with a hacked the "promisor-remote" capability) or an
implementation of Git (that implements the "promisor-remote"
capability differently). So not likely in practice.

Thanks.
