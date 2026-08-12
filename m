Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D81474267
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554566; cv=pass; b=moeYSECJPfCWLzYOnT0xb7269ONkwenKU+JU9ask9l/sVJT531lpcOzN26h5cpGVSGDGlv+Gk4Pv6tRIVAi8jHQGRpySRfyq9Mn+yYwM8t71GIKiVsBh/0LDC/s/6aW4gl+9mtR0mi0yChcb0dzCtp1KbwNUIoeo5COFdHmgJD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554566; c=relaxed/simple;
	bh=U7+QIkT9YyEt8qOd7CkVjZ1L4voY4RE5lW2LhbDcj/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPzCY19Y7NcqOSJt224Wdnpt7m/RY7i1IlXTg1Vau709b2eloCd9WuvwyIOQA2i3F3MyyUSEAt3XQj5n5RVLs7P2YjjOSELhDSYv5Au/xKzoy907ta71gmBdZgkBr/pLFDE6LHLRqksNUKWR5DPMnncxJ6fD/2qTFF4qE67JbHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1zkSsBq; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1zkSsBq"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381b831d535so2105455a91.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786554564; cv=none;
        d=google.com; s=arc-20260327;
        b=e1OezcJq6V4S4uA2MXIKIGyIxw3Rreh0VN9gQYZEzT9hog8R9rdDeqh1uDCqVyfYzI
         HOQAd493TG+o813EbfD+Qr/sFNdrwJJwl9AG1gZIZY1gUS3/2KjI3wbga/3blHTEQvo+
         CnG16QdDe1XLZ+RI7Q/EMI9j6exuO3E1nSQtb0POWHoYf0YovWKFxeAlWEll/Bn9wkJD
         Zue6ai2co6rSi/3PJOSAvGOWi35V30Q5u5sQf+M8ZHJCh4PfGmFmawTS0JjEQR14zWEz
         QsBzDa1k1wpXIWQyYmcG/OkDFV5f5o3G+UIfKTiq7+xzetsfsaXTGNej3WwV3QVG180+
         MW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/RTcVCtso/zWUhYrP6JihybQaRFrMSou9IPlKzoeSA=;
        fh=pN7wu1zwD+xcQsXWuh1aXLiVhMCtwuxgzoUDjuwgVME=;
        b=MnJw10cjtQNXQp8rbpGTXStgZitORxs2FfzA9+kjRZvavnLJSCoKgdPAd4JOOXBQeT
         gI4OU11CEbQbeEcasd057FyiQMQ9FewaHGnA+mDuLjy/GR2HlYb7a6kcn73sOUnA2lQr
         elVK1+vmOjXEssoCxbaOGvQtVvxw4B5U9898hHhOHWLULmgAC3jzjKz5TclaWxqGiqVg
         XKbSxI2Vs3DcjkdAkTwrvgTYWJrZeE8oDP5U07MMmpGKcqYruvJw57nM3wbXkML+TgW6
         sgKuzw6b91S1NqE7aXV31oiRv0nIVZXe7hrPhjYsaezz30m2vIlfr4ks75Mnffd0A+lf
         Ag7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786554564; x=1787159364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/RTcVCtso/zWUhYrP6JihybQaRFrMSou9IPlKzoeSA=;
        b=p1zkSsBqQ9h73P3XKKbnO9kPRRAAXlwDf0MM7Daaps7Eq0F9Alp1i0ENuJJg1Gej0F
         F8nv2IH/yU23/wM++zLgeMjrtD6uw91F8rnN5Nqnbp2C6K2c7KpiKDFxV4gLFgbHiU7q
         GJIhpJKu4YcBh9b7fNrVF8NaUlbjyhl6vPUu44D/rfqXaqpYS5fdS2AEXeXqKUYLc4rO
         Nrs+I9n8CCl4xHDMJBoR+vzToFzKVUG5D2KbKHgamWg2cUo838KIOq6Sh7lBQKpKqntt
         e6t/OTc06kcg5r5KzRL2qvN+m69MpgOBGuz3iQe+Qpoi+nltB38eQGv5Tzl8e1x7Rtyy
         2YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786554564; x=1787159364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/RTcVCtso/zWUhYrP6JihybQaRFrMSou9IPlKzoeSA=;
        b=bkhq5X9AzZg2M455deCXnLm5ChIPouulfF3J83S4JVUx5nTJaXL5wq0Vd8BMijKSgr
         Fccu39yvUw72nbg7QMOrup03gnHfWx9U66YBaX6AkvQzk0T0XAK0ZA4MYdG/VGFUhbpA
         OOX49KHBbGWVSOlGfbzbWG5j7S1JcYkTxP1brrmcIncqNZ/WMPMy00eWG59/Z//s/0Yh
         +0L284kO4RQaWgTWslUGxwaJaHwRhMapP8AQRSJ59NBmF7Ut3gj3xBGP/oOdBUHxTnE9
         OmIK8+tA+gI3Zhrg2DAulciQndQfUF5VtdHwu7tgSy+chK+b67Ld9u4yaB4MRJTA91qd
         Lgdw==
X-Gm-Message-State: AOJu0YzCpjk8t3L2N4zgtuKCWLxPlfCjUiPO7vNR5MnLkI1EFS3mQnZR
	rooSolFjsi+SHkolYTLNi73Iwakhp3kcAuusOJqKBaCP3g5FWEknhLLVoz80Kt9KIrSrcuf1ds1
	7U0IWVU0oBpS7VbvdQI3/gTFcYqZBNnI=
X-Gm-Gg: AR+sD12K5pq9VXTDYIJp7j3o5Qx0g04LAM54fkTmPrete8RjL5UELDJ1LV8WbrkTjjB
	FJrIRVTu8M8KxkscojFUYAcaNI5QM/9xoD/6vyVZyvqw4UT5FxPOWu7r83D/dI3JLhvqBUN5bMB
	HJLQGUNhRcQBMSMZO+Sw/D0TIllbYbYJE7fCKQHhOpP0JpnqLF1NrnYWK28UJlaKXDOMkZ3R6y5
	qxPP5Hfl4pC9QpoKZBqg8RTk71iMDWfsmA6jCSbAdXyKrjuFrZajuJp8VB7l3WZCxr7i7yf47OE
	rD4+p7fosYyMZTBQi95n57MAA0VV189VTD3qB5tJO/rtt+C/tBqVs43uRX6F16XHOypo+rt7bpN
	V1hHTsALPj84sPsugPKN78o7KlFjG3GI=
X-Received: by 2002:a17:90b:3807:b0:38d:f096:a1dc with SMTP id
 98e67ed59e1d1-393013e58ecmr7761558a91.11.1786554564035; Wed, 12 Aug 2026
 10:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <20260810174047.6524-3-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260810174047.6524-3-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Aug 2026 19:09:11 +0200
X-Gm-Features: AUfX_mwYeldCzWgNbqOoXNdRXW-1r-3yW1J8bEWi5VKv7q4AEWl0BLfgV2J5rhc
Message-ID: <CAP8UFD0i6zo1pLLeKS4oGismNvadZ2Xc_QC1tt_9KuJiMJq40Q@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 2/7] list-objects-filter: add list_objects_filter__filter_oidset()
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	ttaylorr@openai.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:41=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:

[...]

> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index c912ff3079..6a2e9d5b24 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -828,3 +828,48 @@ void list_objects_filter__free(struct filter *filter=
)
>         filter->free_fn(filter->filter_data);
>         free(filter);
>  }
> +
> +/*
> + * NEEDSWORK: this reimplements the blob:limit size check rather than
> + * reusing the existing filter machinery in
> + * list_objects_filter__filter_object(). That machinery is currently
> + * tied to the object-walk path and cannot easily be driven from a
> + * plain oidset. It would be nice to refactor the filter code so this
> + * helper can reuse it instead of duplicating the size check.
> + */
> +int list_objects_filter__filter_oidset(struct repository *r,
> +       struct list_objects_filter_options *opts,

I think this could be "const" like "const struct
list_objects_filter_options *opts," which could avoid a cast in a
following patch...

> +       const struct oidset *in,
> +       struct oidset *omitted)
> +{
> +       struct oidset_iter iter;
> +       const struct object_id *oid;
> +
> +       if (opts->choice !=3D LOFC_BLOB_LIMIT)
> +               return error(_("filter_oidset: only blob:limit filters ar=
e supported"));
> +
> +       oidset_iter_init(in, &iter);
> +       while ((oid =3D oidset_iter_next(&iter))) {
> +               struct object_info info =3D OBJECT_INFO_INIT;
> +               enum object_type type;
> +               unsigned long size;
> +
> +               info.typep =3D &type;
> +               info.sizep =3D &size;
> +
> +               /*
> +                * Use OBJECT_INFO_SKIP_FETCH_OBJECT to avoid triggering
> +                * a lazy fetch while inspecting candidates for removal.
> +                */
> +               if (odb_read_object_info_extended(r->objects, oid, &info,
> +                               OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
> +                       continue;
> +
> +               if (type !=3D OBJ_BLOB)
> +                       continue;
> +
> +               if (size >=3D opts->blob_limit_value)
> +                       oidset_insert(omitted, oid);
> +       }
> +       return 0;
> +}

... as opts is only used to check `opts->choice !=3D LOFC_BLOB_LIMIT`
and `size >=3D opts->blob_limit_value`.
