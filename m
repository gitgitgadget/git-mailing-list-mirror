Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08603314DE
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400707; cv=none; b=PPx9PAFXc5itHRhoCwBS3b7Lf+vtR/zQjdV6VOPySwlI7/+M9NWT2R88mQy7MB2OLCAhbPof+PBfxrR/h4HykpOmxh3pXvEhN7kB9XyzSegUdSxcmatlz2rPI8Tv7SVHtK2iyNuVjAV3jfMZFIY4Zl8WKCNb6Y9wkVuAMf8rfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400707; c=relaxed/simple;
	bh=w3+NmWtTPFBxpAWuGFsuzW7LFIao4EafDa2whAZA6qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsbCWYX+qYlw5G9LC/6tmj23vTW733zeocoHCqoynllXRDooDcNSU7uXKlCX0VK0xhkWeFIA+iD7wv99u4qwXUMtTccoCrprhH+ZI4/J6DxDky95a8wOYL2KRoNgAnKJ2QiV3h49vf3twCfXmobkWhrIYDcNFmniXuh6erKW8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXfWj8E6; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXfWj8E6"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3f23f3fc686so2235055ab.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756400705; x=1757005505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeu1L+CjBHDL2PYbBfmP7iBe/x1sqwNnetQDiLuM6MY=;
        b=dXfWj8E6oxOBNvd3Ov5OPx6CsTyQ9hwQaFne4IEXBQz4ggd89/Qqk3V6EVsbVF3u19
         h8oI4sD0Sah/cUiYUf71AiQqF4/kfjHVfEATb99uomkun2w54NT9FCXIseToMd7bA9SE
         6aeSP4ijiEOlLkdQ5XwB4xCXj5I6p60l3yuJMCtHHbUoeaL1rLCRIFDFI+YW/kmLQqN8
         /Ko2wUku3rHqKCff4ARHQXzz8XZJBt23+ZLAEcYf3Zrx+T6TiGgJj6NseAl3n6nttErZ
         39bp8fV4ZnkIl/M2ZrKxlNMwUVL/GNMwmy9F5tJaRUpgf8qk24jlF8WJs7vkOruazVwi
         N71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400705; x=1757005505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeu1L+CjBHDL2PYbBfmP7iBe/x1sqwNnetQDiLuM6MY=;
        b=IOMW3Peo4cLmAdHbbV+v/cfcN7ib5UB5U582QUX6Yj9EJziAGecSMxH9IT4t0JxNrZ
         H8D2oTGZlxMG53FYPbdZcEpPJfwl6P0feg+Fr/BA8DQ7FzCc22VW2/AJ8sbpETKe0VWh
         e+1vHCfoz4LokC5ZaRUNEcKhcMg400Z2YmEaWLfuwjje98dnu0PqnlHyMG/Ubx/DF9aD
         ED2lAE6AHpeixAOe+KrKFrDmzXASsnh3BDb8ykMdmI2S8yQXrLbXUbm9CIvwC1aC97dn
         5crrtDI4eKg1Yy65I1nqydJ3aYSR/6kM4+0icuewK5b2kIE58eraIHcvAL4glqUy2vSy
         hoZQ==
X-Gm-Message-State: AOJu0YzlzOmJLj/qKAMfNVE1L12qoLaQl3URR9t5xNtqudnMXXZNKi2I
	1J3FUt3+EdUpwPuV8vGwBqvpy67NmEvaDaqqJgRXvhCd5LxdNVAbql2TsPUFPODutMpuJslDCeI
	JxK7AJIMSIR8msRMS27TSzQPksV3G0oM=
X-Gm-Gg: ASbGnctZEGTGbrPAMrw2A4MCqO5ArG0OyzRQ+3DCEoStpns/QskDl47l6ppmrBkjTiQ
	EpslhsfU1ebcN6Vbmb8/ZU1F+qjYqQ2VMsDar0u9hY8NijLMmpsJ8QcNErX6jfU+oOcO3KW1pYY
	5EiQNx8L7IVjIm0ookEMIHz4dXwY+6emaQEuGvfcKrPBOWu8FWtjTslxIQ8IcGaoanFkcC9ZW+F
	S2gRJI8s3/HX59RkiPHb1/15eMwFuMwMZaT+kTAm2ZqHL0e2KzLKL0pJYXAaA==
X-Google-Smtp-Source: AGHT+IFNMlXtWFoOnEp9pXsyHh+JPXFvzs62Q6C7LtDqv10RlIW9Iy9yYYrKpAbCuh9lY5pWjNpJX2W3fouxBMCEirA=
X-Received: by 2002:a92:ca06:0:b0:3ee:94f2:486 with SMTP id
 e9e14a558f8ab-3ee94f20832mr146891485ab.29.1756400704703; Thu, 28 Aug 2025
 10:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
 <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com> <c81f920fee0ed8672783728fae70b6435e800f82.1756370289.git.gitgitgadget@gmail.com>
In-Reply-To: <c81f920fee0ed8672783728fae70b6435e800f82.1756370289.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 28 Aug 2025 10:04:53 -0700
X-Gm-Features: Ac12FXx48_j3zcDSlQNpMtlIFY9vbPOq7lPAYDshwCZ2F5bFQDrS6Gm-USNEX-Y
Message-ID: <CABPp-BEDje5dYZHEyYMN6j_LdR5CqRN1cxc0riRK06qK-OxiTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] range-diff: add configurable memory limit for cost matrix
To: pcasaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paulo Casaretto <pcasaretto@gmail.com>, 
	pcasaretto <paulo.casaretto@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 2:00=E2=80=AFAM pcasaretto via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: pcasaretto <paulo.casaretto@shopify.com>
> Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>

The names (and emails) in these should match; I believe the name in
the From field is set by Gitgitgadget based on your profile settings;
see https://github.com/settings/profile and set your name there.

>  static void get_correspondences(struct string_list *a, struct string_lis=
t *b,
> -                               int creation_factor)
> +                               int creation_factor, size_t max_memory)
>  {
>         int n =3D a->nr + b->nr;
>         int *cost, c, *a2b, *b2a;
>         int i, j;
> -
> -       ALLOC_ARRAY(cost, st_mult(n, n));
> +       size_t cost_size =3D st_mult(n, n);
> +       size_t cost_bytes =3D st_mult(sizeof(int), cost_size);
> +       if (cost_bytes >=3D max_memory) {
> +               struct strbuf cost_str =3D STRBUF_INIT;
> +               struct strbuf max_str =3D STRBUF_INIT;
> +               strbuf_humanise_bytes(&cost_str, cost_bytes);
> +               strbuf_humanise_bytes(&max_str, max_memory);
> +               die(_("range-diff: unable to compute the range-diff, sinc=
e it "
> +                     "exceeds the maximum memory for the cost matrix: %s=
 "
> +                     "(%"PRIuMAX" bytes) needed, %s (%"PRIuMAX" bytes) a=
vailable"),

available?  I'm worried the error message will report in users
checking system memory, claiming they have 14GB available on their
system, and then reporting a "bug".

Perhaps something like:

+                     "(%"PRIuMAX" bytes) needed, limited to %s
(%"PRIuMAX" bytes)"),

?


The rest of the patch looks good to me.
