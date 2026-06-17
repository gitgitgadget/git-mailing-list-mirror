Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19583E639F
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691410; cv=pass; b=HEsU7RukWCzg3fkLzN6JAYD53NttSox0gWCCTnev/Vk9yAjeWk9zGcFgDLSjikl3DIv/n32VtnX4XMLkxmLqYA7ClQ1B6zxa/XLckEt+h/3O6Rk4SkzWuxvUNIqMTrNAL7HWJIJM7n7Ltwp8lNXwAVxOgVVvIvvUUL+eWhHbu/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691410; c=relaxed/simple;
	bh=qR+Snom7UdewdWUtdcPleqXjG/MR3cFNSAZmnfRFdKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPcSwUhS1r1KZI07IGEMLpSqfwxxBZQgnSEGMx6on0xkfjNKSuA25ihfYvXYEtapRxI0Vrb1iEovMYgiry3d2yHesTIblggKurqtaLtR57qsHJLiEcI2w94BYYLAKgvtXm6KMfOewp1ULDNF+tDL1U4O6ceuedwjva8+TPvFY2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZezNhbR; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZezNhbR"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec429c2bb1so803522066b.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 03:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781691407; cv=none;
        d=google.com; s=arc-20240605;
        b=YzCuoxuj2HsLnL2b+49EgSaLlpmm1VV9IDy4rk9+HtS93pairWhrNVDSyzRFijL1nC
         ikzr1YSOEZZB/yxsHubK39X/OjmS1sIc94LtwURqIGCOyo9x0TLU1Vz5Lm8MCBTITgTL
         /UqdNaaG1Q5F5ttEAy+v5dpcw6ccKwIo4pRvx0MWTjEYPQqHBByBDzYOwtxKtmyPzdDx
         sHHbwvnGekFQ0y4HhKHLFhybr4m1eeyEnsP6u5SBqcCBOAFE7y7AIfYgzoDTKT93ZWN0
         UUpmbasn4/ceAjGH1jM1VWZRkXvtY7ZB6D8UXJkRJrXlnwJL8lxtnI6/R3A5wOODUqoa
         Ty7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kXn4OjB4fJ8uQVDQwWB18MesUP063fF6uePsi1lJCaU=;
        fh=bMXS+SgInGttQk4AWMSLBP7PahZdl9ByyX8qcbQ9DUo=;
        b=KLGhUQNXpauezf/Rhqk2CyEIbYbe/UJkxXp1i3WpLPvnUA+j3TX6agUbQwcu/aJma6
         O0OWkV/2ODA69+8nntVL1mbtzz7s4HPy7KV44CLc84SpLYIJv7ZSqtrjseFmODnR++Bk
         Z90xlcppr3jLbqWWJ4jXxUYfuGC+Ow4lHRegwGN3UNXVluJXNCAR4RjKsjYjW7xDtEOp
         f00gtOIf2+D4XLlJIy5e/Bpw75gZqdHQqDgHqnLM31C5fP0JR4E8NbQp+AZukmxs0AQ7
         xVsBU1B/dyFrwJ1swlDyqD3GWT+jjH6nFbov5vHFV0kXSJQbT+VFeEUiZt0d7SXHafSz
         s5Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781691407; x=1782296207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXn4OjB4fJ8uQVDQwWB18MesUP063fF6uePsi1lJCaU=;
        b=eZezNhbRJIT1t7A5gdPilRadHnuDlosfn2rsO5PLRMmr4J+6M3fPwJrtHR4GsGG9i3
         gs213TkJiYBISEvHduFg3Y1fuOaJhv1cfvBnBbPd/0GXl863n6vhqv4qa8ZnR8bwMtiz
         +uEYeaC1gxu2qzlTdo9ESBpvE5IVDKdPZZHIrLyeloDmXa8ahSDstVq13rFRjRQ8husa
         vYJxlXWSDtwQl+tmu9DIvFlm72ERRcHo/gZUWEvuMhrX7L3u6dXiu1OL0jktn1CLm2dG
         qFszYPx0lxXGHSJ97X0BcBPLrL8imPa1zPdEeuNRdHhUdXGkLm++UmgJrU8t597G+6ra
         9ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691407; x=1782296207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXn4OjB4fJ8uQVDQwWB18MesUP063fF6uePsi1lJCaU=;
        b=AW2QyalWx28SOmGznzk+3s0MgQvkD+ukXYOUXj0WFDPWxxcwB3JzmXaGUhu//JPSpf
         hqaplPVcvWk4fXBajeQvQL4/RQKMyFvlQJDVmb1VTWYSTdaVmv7Cuoob4HVPolFBaXEP
         BBY4thxHpONiC82ME0PRTgIoQe/nrbkP3l5FYOoF5UQ74KV94Yi0r/fDO29TPcxdHSer
         R/84pOF0eD+6egJ947/4YfyI4MV2uc3Ih1LSIfHo6lUyUpSGgK/DHoNPkk7m25EIVmJj
         UBivtsoX4SzhFr+5ii1wTnowNLEW8e+UeVIAOvV1u9hITL1XwOTQF0Q9DcBDRKZejShA
         C1qw==
X-Forwarded-Encrypted: i=1; AFNElJ/Yywcb2baVqdeY83LDDb2XfhqTiNa5YBeiejUnrE/AE40fU6ythO12rv/G5l2yS9udATU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1TvNzlg0O9D96pgVPewuLKDLpJRtPvNwyzGO5G11vA5F1VQv
	O6qkQbuI5SYm/RJ+CsiZ8ZYHcwCFUpLXLr7g2h8NHgOOKDQjmPLmnhhk2tCPDHdq2Hqkojt7HS+
	+XzkMwfW8cuE8wo6Cz5+BXXyoowO2oX4=
X-Gm-Gg: Acq92OFX3PuiEeFYpRPyiqCqtFfZZJ4lSxLruCd+oNb2MBgVb/IjUy7mgvWtUUUtd/Z
	atwZAXIFEDTL7XFiZHJb58lQZuRuPPfs5wwTofEAHmbcIDd3NGX2fYNZwrx47lIKzzWhkxLEaeK
	75rnpej30ykRzqwBn3SW/sPrGKCnuylQpUmkDYJifTw1HB3TCLOfBJ6Esai34incMqNbSkyJiK+
	lcst32sNg03hRzp9cuLvRzPmh1jRiMjRhDRNOsEx3vNfVZAoeEegEJWNss1iFTulOGguB1VS0fI
	GH1AEyjKqHazScY3sNT3806X9AJSRU+QdkuDsyYZhuVSs7CH2YYgMisgtn4N5wICC85PeN07hlW
	Gop9mzvJge5k=
X-Received: by 2002:a17:907:3e9d:b0:bed:d329:1ed9 with SMTP id
 a640c23a62f3a-c05a6bde8b2mr217343866b.33.1781691406921; Wed, 17 Jun 2026
 03:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260608-ps-eric-work-rebase-v12-12-5338b766e658@gmail.com>
 <CA+J6zkQ22en2HgH03EedKOfC+jLcHH2UbwpH0h_bDEAHR6B2pg@mail.gmail.com> <CAN5EUNQHSd=0z26iG0gk24TEtgg1n8CC+H9bkqRACyErNgLxEA@mail.gmail.com>
In-Reply-To: <CAN5EUNQHSd=0z26iG0gk24TEtgg1n8CC+H9bkqRACyErNgLxEA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 17 Jun 2026 15:46:20 +0530
X-Gm-Features: AVVi8Cd9gH3BYf8buE7tW_UJFv5eF1P-UcLrGuqDrFJ6ABO7WrKTJfN9cfhnYFk
Message-ID: <CA+J6zkTrBO9paxkMtnR1cDtD=LQT8dzbVNxgzzYNz_bpzrvcwQ@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v12 12/12] cat-file: make remote-object-info
 allow-list dynamic
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: eric.peijian@gmail.com, calvinwan@google.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 23:04, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
> [snip]
> > > diff --git a/fetch-object-info.c b/fetch-object-info.c
> > > index 51a898430d..425929a269 100644
> > > --- a/fetch-object-info.c
> > > +++ b/fetch-object-info.c
> > > @@ -39,6 +39,12 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
> > >         case protocol_v2:
> > >                 if (!server_supports_v2("object-info"))
> > >                         die(_("object-info capability is not enabled on the server"));
> > > +
> > > +               for (int i = args->object_info_options->nr - 1; i >= 0; i--)
> >
> > Isn't args->object_info_options->nr of type size_t? We should probably
> > do something
> > like:
> >
> > for (size_t i = 0; i < args->args->object_info_options->nr; i++)
> >
> > instead.
>
> Hi!
>
> void unsorted_string_list_delete_item(struct string_list *list, int i,
> int free_util)
> {
>         if (list->strdup_strings)
>                 free(list->items[i].string);
>         if (free_util)
>                 free(list->items[i].util);
>         list->items[i] = list->items[list->nr-1];
>         list->nr--;
> }
>
>
> I made it backwards because of "list->items[i] = list->items[list->nr
> - 1];" If we made it from 0..nr and we delete the first element, for
> the next iteration, the last element is at [0] but we are on [1] and
> that swapped element never gets evaluated.

Makes sense now.

> About size_t, yes, it is size_t but because we go backwards 0 - 1
> would fail, also unsorted_string_list_delete_item() signature has "int
> i". The options that can be on that list will be a small number so
> there should be no problem, should I cast it explicitly?

Yes, I think explicit casting with a short comment explaining why it is
fine to do so will be much better.

Thanks,
Chandra.
