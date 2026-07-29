Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB4448B82
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319084; cv=pass; b=TgM14AQ7L5iwTIY4ownhPpospfkWM3qFZjOna/cL5gPHXu4WBj9TLaJNeJ9kL5j48DlUZWuj00TUE00NorMfnleekZBTCovMSVdQ88uH7WMBTE/OfoTclBCQFTlc0WrKLgwXnv2YeTap3Cago3MKjeJvrtAsctICCmHSqCUE+xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319084; c=relaxed/simple;
	bh=ClsQwHmf8DZBcENrFbt/tbGP8JUyoSFrTXcajstFYvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPFKSUEwr3gEzxea51BzvZmtUmVPiROR2Zd6lwVRpIqdfnZoQqcACb2xi3fh73WM9g50Rhhg1DfS/0yly+ywmkLYU7awG4pcl8wYxoqrbdmd+grg3L+X+THdff0uTb7v6hws/b+js5yUdarFJmx/IDqQXT6QRZghSgQOvD4aXl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2SWPFcm; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2SWPFcm"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so1257727a12.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785319081; cv=none;
        d=google.com; s=arc-20260327;
        b=nwG7J0chL4/aDCofENPPhm8TIjl0Fb/lHPONwXip1Z1Z0iOLveAzvCAW3MJnbelcE3
         Bwc/HcubBX2oFRCHk7H10wUjE0Nys8uj+L1SijCpsS8rFieGKy8NQrDEMsxUtWPi5h1N
         tPw8Vvp3M7UPJrt1aTuw8psdm5FdI22BhqbzqBeMBQzd+ZJCauXIfxdAX2UVJQ58v8ti
         mqwe+6dx10aI7Rvm6/dkA9CJxZFz6WaTjSEkPCwqHGWSli3K3hXXDykmBJH/HJv/0eLv
         4mzfmYgDhvXcQiBEueEfHeUyotAsJfAEgwAQ4foPd5VC8ocG4m2G/EAul44HhW9eubtR
         COuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mnNT9OiQegupzRvZwdDjUBtZvDnrVV3BYXcedcSkU/w=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=gI7br11FQvLkHc38RhAXg47VRVJrnPvZ2XfHWKgUizDftJIHgy9x9gEqN0hqS7o0uq
         tdsinGZwTsfa87q3Z5EFXEQGsJ9oZEKztKvYiZn9rhlusEy2d27gM7X/pu2Ew1O6vbmR
         a+uYA0rxPSZVyNLaUMKn3LGv+Eh+1AkHiiJYR0RnaExT9iXGeaLe7Mq0BkQlWqJnlIWJ
         /l+oSMIqBUzUnBu4FVA6SiZALQelotP0mkoO4xV8Y1MWx5Xnh7lZy0QENoksWZs76yma
         ESzd48j5rfHR1WGZFADn30SCHoY9aonFSskBRc9vE1pPxgnhL3ppY+IieNo9SesdLWwr
         ETSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785319081; x=1785923881; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnNT9OiQegupzRvZwdDjUBtZvDnrVV3BYXcedcSkU/w=;
        b=h2SWPFcmrJkyCKsvDg9yrjDe75Mei2vXxis39+RGfTY5QY8yUKTs/ke62i4CS2/Yem
         jB9iMfTDCh5skTizIISj5+qsyx1qTQVGxY0AVBsDaBA0kusgqIBR5JPm4TFMYXSIu2iM
         8MgxAvXkkLG3HgqBVYOPATmktFmqXrpg2IDC6lBp8mx6WLWWNmSS3wqYYTLs0pRXoFIv
         H4GUn8g4R+/1qYJjX6Ich/konJLYWQ/9WC92qM9+v+UsIoa5IkBbCI3lK+aV2lN/lm/1
         hG5KtAKt+6Gsk3L7xyfVED9T7tMia74Xfmn6lEcWUPFEmvWbFJstsZvDNEERJlTI3PRS
         28BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319081; x=1785923881;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mnNT9OiQegupzRvZwdDjUBtZvDnrVV3BYXcedcSkU/w=;
        b=O3ntE0ieRRicgUND/aR+jgCpjfwxyLLCUDzGKQ22DWMyNam5VB/gBqfMN/IbzSAlw5
         dkVc8jlim3JtgxtI4ZjHxmPC/ctNY93VD0kWOSceb1hXACTkf58sEIMTstmlI8ikY3RZ
         D4nh7BC6slh/8CiYMGIfblWx0hIvuTG0ngmlrYWc9/ioh4C57sQjydpCEvfOmAlIjrT6
         2/T4pQqRG4o6x4EKTamPtEG1n9kn1hLVjznBFkLPPH82UbmT7qOEq97MzJr3dnv2vmMM
         rBi32GZZS84mQfvUyyY3gO9kcjyCkdANX06BvQm9/pOPwsycYrLM0mH4iUyNcnMdXl5m
         MAqw==
X-Gm-Message-State: AOJu0Ywq5vNQxNADcTW3neO1ULTcB+jMkd/kvBaG9bX8qOoyE8VmnMjn
	916vIepUQtyHnWO+IhkaEFUbUqPIonaKyT780vV8cqrwGUybbc0n60IHsZdEKB04a5UhJcmU94H
	dl70OKfc8hxFlXrgXL8Aw+QuwOS5AVVk=
X-Gm-Gg: AR+sD11BI5entzK2rN/oNE0zGQ128D4jWJ7d0qJARNAH5Q+Dhqcpf4NoVFAP1UUTlDG
	BCN/l+n3OCsrwnofbbs9jsY1ZL/qP07l3aZKZWUjaAUbO1Q/V5If3fik7t/hV9MGCj/xN1jViZa
	QM+AM7E1Lf3f61DilirTEKN9CRWooQIalB9gq+XhWX5H6wFI6/WhL16+WpwBpBFl3k9lw238miq
	CULtE6KktCi6SEDicKpk+ew8r5eE/Ime3V8A+Ktl0Vt6sH+5fcCFQKojL7zwyWVWjSplXo1OiGe
	xEMMrTAIh+OkDAuz54GQSDFAzjR+7dQ8eO/p1hE0+HsRgPNLkkNA8yr1VniEfToGgAXSKMRAkuL
	W87+ocbxf1Y1QP6mVqMazSeKf4kUDJDw1jQDOdZyswgEyzvgMqeBE1P6WVg==
X-Received: by 2002:a05:6402:40c5:b0:69f:c7ff:a755 with SMTP id
 4fb4d7f45d1cf-6a034a8ae9dmr3257324a12.31.1785319080788; Wed, 29 Jul 2026
 02:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com> <20260725-objecttype-support-v1-3-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-3-2d4ca3bbabf1@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 29 Jul 2026 15:27:34 +0530
X-Gm-Features: AUfX_mxhZOYwLW0wMjebzlHvP6MZWJOZXyJ49xKSetgoqi2XhjI42xlWmSK2IG0
Message-ID: <CA+J6zkQCa-rCJYQgfsjLyyJqrW+0-Z8pUJ4EJxY9HSTkJH=u4A@mail.gmail.com>
Subject: Re: [PATCH GSoC 3/5] fetch-object-info: request all supported options dynamically
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> In send_object_info_request(), size is hardcoded to be the only option
> sent. In order to support type and future capabilities, replace the
> hardcoded size with a loop that requests everything on
> object_info_options list.
>
> This is safe because the list has already been trimmed previously in
> fetch_object_info() to only contain options that the server supports.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index cf6b94afb8..e5cfdafe68 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -15,10 +15,13 @@ static void send_object_info_request(const int fd_out, struct object_info_args *
>
>         write_command_and_capabilities(&req_buf, "object-info", args->server_options);
>
> -       if (unsorted_string_list_has_string(args->object_info_options, "size"))
> -               packet_buf_write(&req_buf, "size");
> -       else if (args->object_info_options->nr)
> -               BUG("only size should be in object_info_options");
> +       /*
> +        * The list is already checked to only request valid and supported fields
> +        * no need to check, just request everything left on the list

Nit: ...valid and supported fields no need to check.. -> valid and
supported fields.
Just request everything remaining on the list.

> +        */
> +       for (size_t i = 0; i < args->object_info_options->nr; i++)
> +               packet_buf_write(&req_buf, "%s",
> +                                args->object_info_options->items[i].string);

Perfect place to use `for_each_string_list_item()`.


>         if (args->oids)
>                 for (size_t i = 0; i < args->oids->nr; i++)
>
> --
> 2.54.0
>
