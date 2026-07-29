Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0A24E4B5
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365240; cv=pass; b=mAwJe01DgZidjwMqXZLJR/EnGk6pTYvXWjXoQOEJZbubsXRPtY4YrpFRk/0HHrTWtLO3LI4z/xI3+Cc8XgEZtLY5CWjon+HhN4WfiovJPFAsMBrbgUMzvvsaaV9wQVwsNbSQDkwsVdt4Y28PBMRyU4nx7e+HpDQq1WiyQczM+d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365240; c=relaxed/simple;
	bh=DO7XNOWGszjUShBnPweSUqYi3bMbI6UEr1bd9wfZYIc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciMiovGI71NB8/MeXERv2jQZFRnbSknMqmQ54AnTlANxaR9G2MRkXIOlUM2h/2eD+Ch0iVv4234dDs96qLOWinVorxws6lQz0h2SLKb/6had3WbVP+j5wvoaj9gV1bxH9Fkal+yhYyIyADfRlG4+NqO5CxRhT+scQUJdpI57Uvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Yy8bJX; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Yy8bJX"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9773507d36aso901591241.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785365238; cv=none;
        d=google.com; s=arc-20260327;
        b=kFkR8yognkJJn2W+P07uvrjfCH6Gdlo9pO67Hr5BlVLmmp1emjUXJnUHCy+yONtEgW
         o+ejgOd8Ivx5LXwClqD5JhEYXar1aEb4Nkl4qQG9bI7Ms1px7UsYqmKEYXxYnuA4l64M
         5fOzxrik+5XCZmpS3d292YVb3zwnKs1LAfvnM98Si+ImIqAJUt/UFDUfvO4LtzkGE9iz
         6i8/ZaH6E2u4A1SsjnxGuCVDWKXryi97e+U5JnR5/KBrOSSzE1vsI/1KMlVVHUenn+ZX
         3wP5k3Rfn+7olCFc06O2cCOAYORzljbo+sPZsEu1XLbYEebcJFa/i01tw2zQU8R48G5C
         3LEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6ZEWr2tCfzauRkucxzvWNd7WkV7ZoYtEEqs5xTVikoo=;
        fh=E6drYL5KVidDJZ6We2jJ1IDrMF5BmMKSNqoo4yWzMVc=;
        b=ZnNn1kT4xEwsXkWH/xnVJ/7AoN8zneExpVfECUaljSOYn+GyR9BXBP91DYeQDTT+pe
         IGSIRr6O34KS/e1o0UPWgZOdSVDAhfkpYH87mSSpGRCPtj35srylMXOwvsh9ToFiyumf
         ZEdzgZWh7VAkfvGFASX4AQsxBiVFWU+xedPAdDBzFoHnMNBdGmVm7xu6YYD86+mkqEYm
         a0WrNVwgbqqKJBuo56+8FaAQJhQEhDXLJmL6nPmVZnkI4xue9pSvtbXFiNurpOwucLEX
         EgYksVNfbDiy81KfoEC8MpAPPFio0RsfaaE92cuoXJCJjOUAtUuamMXhlhWbXfVGJcip
         tG9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785365238; x=1785970038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZEWr2tCfzauRkucxzvWNd7WkV7ZoYtEEqs5xTVikoo=;
        b=A0Yy8bJXDsfSsyl0Fw5mXmJkiw020fV9RpK+4RGPmkLazr+7Zq/dsfrN3g3WAywqvw
         7hsmYjTI3jYXsmWZc+vcJrK3f9ywG9Z+R9xNbM7ReiDPPtGNmIm5E8o5/N+PnhK5FPyJ
         +oG0ZXYK6ncvcXG1Xz0OXgXdfAxx6ZSSQo8N7Hy7BDvMCKbBDlrzAaVOsUBQFXeLWPoU
         MqgIa/dRgv4uUxDrO/zgsjyr8xdY9MquUgPNpoCNo5J+4QiVlIIzyiy2f8FLcPWhWvaq
         la9Z90xyi795MWgdjSR45MTaS+yuaLFaiuH5Gc4/hJ09BFZGq9wZ1N5kDy0sHGtGKrJk
         MIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785365238; x=1785970038;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZEWr2tCfzauRkucxzvWNd7WkV7ZoYtEEqs5xTVikoo=;
        b=N9OgrVQ8JDbMXrh/t55p/thG7Tu0GSvDIGxE3QLSmXIABdZ81PT/LCxvMbH+F1wkZy
         BCNMPx83T5rB3yFUqAajCUC2xNvBiutR/ZLYK6scOknwEvOzYiRr15oAcchynXCQHUX3
         X+agYcWDVuYHMxBipLrlGbFE+kSz27f6JceRnyddolSWnLBYauMW/PYFtQ6AFhFoNYYM
         Furk9AdIBmk4XgeN/5QpSgi4P4SUrERpLhLOexo6PGupIQ9gfPyi6Av9MDSks4IjbwPo
         inAN89iVNEymKCemZ7l0xzOXZ1MDx7cr7uLKm7srUxLJm7Y6YCu/jmvOOXvBmQ4jcgSn
         Qd5g==
X-Forwarded-Encrypted: i=1; AHgh+RoV+Gnj2KI5zCWv42jlj9J5OfluvtIwFgkiDn+25ds655VU52mKEQP6TZaYpmSdstzyCrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEYrQmeM5aQ9pJDmfpp0mH4m8SjUcWki0D6lgvQmEK+toGToJ
	iM74Wm2pW15bCFX8OtrF2Aw4EB7uJEsEcJZmXbCAZeIbn8elG3zl3ORA0qx8NJxzhZIB0npGGC+
	ThOTwSDMvLIinPp9cwGOgguOra1//C/k=
X-Gm-Gg: AR+sD12PKwL9OTj8i6NAQJ84wnRHsMVm6MGxdlwDzvIQ4xlPbRXmFe+JQBVB38S7S6P
	ourziXedMNgK9iBQocmiUyccVqAbCYR1prtvwTEZL6jf2bh9mtwNAdO9xdPvCBecjwL7qVNGqod
	a2GbmDz+e3JgyxLzt4DmhJA5jE3L/fcMCqtOkTFl1murL+X5DTNwaQWbffE5VjLkoMkT/Y/HbBg
	nGEgnpIVGvjZfNLc2RSSZgO4QmzT5K2EiCSy5UKdc97S3Mr0Q0kFMd8Fop7vUxjT+eQFOEfVsud
	Dh//LRwqDZ7cmtylbAhf/HJOG3UcdwD79Zg0BMAQTRWiEuxz5IqHp0S5zdaEXqs0JacT5EuRjtc
	iUiJZlLk+qqBm0Y7Av81BbpA+4pzI4BK51Q==
X-Received: by 2002:a05:6102:3f52:b0:737:e816:b26f with SMTP id
 ada2fe7eead31-7574e3cf31dmr106011137.10.1785365237990; Wed, 29 Jul 2026
 15:47:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 17:47:17 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 17:47:17 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com> <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 17:47:17 -0500
X-Gm-Features: AUfX_mzkrwHC0p2MbCJKJ55E536owh5Ub_rTJ91tp_-lhIpWKC43VSWI6ssNLLY
Message-ID: <CAOLa=ZQbf2vdYOkFBHQ2Kkk=Yc0uSZXEPy+FQPyzp9C8=sUFEQ@mail.gmail.com>
Subject: Re: [PATCH GSoC 2/5] fetch-object-info: parse type from server response
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000ce24630657c7bccf"

--000000000000ce24630657c7bccf
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> The server can handle type requests but does not advertise the
> capability yet. Prepare the client to know how to parse the server
> response once the server advertises the capability.
>

Nit, I was a bit confused by the flow from the first to the second
sentence. Maybe:

    The server can handle type requests but does not advertise the
    capability yet. As a percursor, prepare the client to know how to
    parse the server response.

> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index ba7e179c44..cf6b94afb8 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -50,6 +50,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  		      const int stateless_rpc, const int fd_out)
>  {
>  	int size_index = -1;
> +	int type_index = -1;
>
>  	switch (version) {
>  	case protocol_v2:
> @@ -101,8 +102,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  			for (size_t j = 0; j < args->oids->nr; j++)
>  				object_info_data[j].sizep =
>  					xcalloc(1, sizeof(*object_info_data[j].sizep));
> +		} else if (!strcmp(reader->line, "type")) {
> +			type_index = (int)i;
> +			for (size_t j = 0; j < args->oids->nr; j++)
> +				object_info_data[j].typep =
> +					xcalloc(1, sizeof(*object_info_data[j].typep));
>  		} else {
> -			BUG("only size is supported");
> +			BUG("unexpected object-info option: %s", reader->line);
>  		}
>  	}
>
> @@ -148,6 +154,10 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  			    object_info_values.items[0].string,
>  			    object_info_values.items[size_index + 1].string);
>
> +		if (type_index >= 0)
> +			*object_info_data[i].typep =
> +				type_from_string(object_info_values.items[type_index + 1].string);
> +

For size, passing the value as a number makes sense, since the value
represents the field directly.

For type however, we're passing in a value, while the actual field is a
string. We rely on `type_from_string()` to make that translation for us,
which internatlly depends on `object_type_strings[]`. What if there is a
mismatch between the server and the client? Shouldn't we be sending in
the string itself?

>  		string_list_clear(&object_info_values, 0);
>  	}
>  	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
>
> --
> 2.54.0

--000000000000ce24630657c7bccf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a8947aad497d2883_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wcWd2SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meE9OQy85enlmdHdIcU5pRGYrOTZVU2ZEemhZdDd3SQpQMlVsOHIxRTd5
V3JTaHlTVkNqdnBQRG9ybXU5U1VZMnZCZmtxQkFGKzNwNUpUZEpVMXBPMXk1d1BZR0FkbGdvClM0
NHBmY1hscEpTK3ZzdUpsZVAwODN2L0Vmc2dNOTBDektiNVdQbEM5c24rczFBVFp5eEJKZXlZdnh5
b01aa2EKZ0hsb05zait5RGZKYzFEa3kwSit3ZzFNRUFwRzFweWl1bUNPcXdsVit2MVhwOFM0V0lW
a09QNGlEdVZLYmtDUApZM3ZCZmJ5a2dvUWZMU0RmakFXUlB4bWxVY1ZMbVMyOGpJN253Z0pydUZj
UUt6L3F6dXR3Y1lLUkJOWkUxNzh5CnFKS0NEUHB1d0x3WE5QWU1QQkhscUh0UmdPL0YvQjVqbjly
REROVHBKdDcvQnVzNFNtOXRReksyU2E3UHNuUTAKbzlrMWtTVWhPQWJPT0VONUU1Rlh3aDh4NjVj
d0FneDlOR1M2bVVObi9qRU9VUHo0SkFlM0ovTEhsaGczeEZaWgpTcUxUZTNzeURXbnJQelJYZ29k
U2hyRzBWYU5xK3lxdGI2VGV4aHp2aW93OUp0VTcwOWk0NXZvQ21YZlY1K2tPCmdwMHZWcmRKVmd4
TFFsUGNKMFVidE1NYTZVZGlZa2V5YTBabk90ND0KPUVrTk0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ce24630657c7bccf--
