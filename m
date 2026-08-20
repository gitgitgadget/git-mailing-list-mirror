Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFA3ACEE1
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221021; cv=pass; b=Ha9X1Nt7cwibSZhUYH0yQbo9hh/sSGueoJpW2V0BtCf2NhCI7qP1O0cmEDiUNS3JoA22hH/77mbKq+1kr5Ohq1O/W4LcJ6KnaNQ4kByqnXsT1ju4TwXp1uRDARk/UfVvMB/g2eLH3OpNSuir1oImSqJWrg6i2Svv1DUNRg6RFfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221021; c=relaxed/simple;
	bh=5my+h8XsTS/9c5Q7yw1FYUelo2/7PQir83LtWxuGWWo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUdu7FDMMjRxeCk8rtU4x7itrx+4P3IqNptVEYqKjyc1lkLNUJP8cf+XFtvETFnLv8Mveg4Biz/zuEYdmvbdzrFme22LtdjfVR96lBSVGVJ1mCe4EegZt0xX+AtNz3oHvieZrHlBdaaTpneNSyoByr5dsV+1cNWPAg0ic0ms/iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkIyU079; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkIyU079"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1391944a91.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 03:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787221001; cv=none;
        d=google.com; s=arc-20260327;
        b=eSpu7WH0uov3TCDxrx36oa+XTngYn9zXGjCcebEnyp6fx/jqqiyAyLrbvYwsCCheA+
         VOi7LzpPmd3eVKWc0V3OK5XztxK8izq8hRwryXSItt9IARP2KlkXn1SvVJnNT+9mUIhM
         XyxruFy9hoTlTedrhr075fmXCINtZeR5DVPcl9vKLw2hW+vBiitpY15aA6Rm6XGTcDDk
         zeBNOmT27pORlSBLmCIqfaIZao86SnApOMdoJTMcaUNY1/C5O2cKScE11dp6JKjnCE30
         PLuzxSspQ6gF4PdGpEWGkOiOWviLu86qBHOmobzvJ3QbTYMoSh9vJbmrArmim9iaRiBj
         nLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OiP5uKwakLd8Sqr87WmeLwZCNal8g52YQnoJRDuCSw0=;
        fh=yXpIQfS9cvpnUbPjoW+1YaFCp82UiSzkAnS4tAxFXvs=;
        b=Abyd3lj1yRqrGH5GyOWQlG/IeZInWitTnQRki7EdDKBMXU3++laAo1aAnb8ZTPvsjm
         +fjW7xRbQVeScLi9Hz0ULCJ6HAS5ShjMEIBasTpbqwjIrS4re2GpFLkS3k43OU54UItH
         MGhy4rkNIZr0q1nkJtMtqRw1veenOxi8ERLprIw1gRkpD+cJx8TjrgDJawW9PAROnd+K
         Be1TlZ4yvkT8jFUwbIPk7tmxs0Z7LnX+UVtOU75OPejLE3x6z9IvJL0aljf4QaEDTNiX
         gUTi1hoi1DNNCSpNV2XS9NBh30yCWF1Oc/RAmV9BY/Hd1eLfPNC2NSd54RLS5cbf6Bdr
         7EZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787221001; x=1787825801; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiP5uKwakLd8Sqr87WmeLwZCNal8g52YQnoJRDuCSw0=;
        b=BkIyU079qig8QDAcv5FFpNkuW2irPxhdbVBS1Rv5yK9qYIM+sqoF5azKbe7VB1SDax
         PIK7J6IE2Cg4Kbnhk5G4v0jlK0GOKHwx+KwBl31Sgyve6Y8IpQEtJOMCgDn70Z3p/lK+
         9qRpPkKEsmZBpF4HJrSqTceplrwXw1hrciNItqSrp0Y+q9qFkWtgHiH5bOm5JkOL1cJn
         3XFFV0/PGUYkDcRppfxzNYVgmUtSjui1YaczTK4gBRJ5qFTw/o4SBXrGmpeo3e9Ym9SW
         czzlRUn/D+4oz0VDNlHKD/AiSzuLiSu2Ew7uf6E/sRnoPP5QjD1EgVi5CUyr/y14zjgZ
         RVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221001; x=1787825801;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OiP5uKwakLd8Sqr87WmeLwZCNal8g52YQnoJRDuCSw0=;
        b=l7GNetdBVXDzFJEz0cuLZukUJU9obaJwFJvn54lU9+jhubGR17XQPrK8K/187O/S7p
         teGUXVQq/i6fTL9K8aLmpgAuj04Q6WcukHOcpLGqnfsXouoRReotLxuo2MqkQWK4/owA
         r6BrAsKhFgYmBdNuMtBYqSicRnOIHWNBN0yr3teRcykWGkMquRYvWqRLL6JoIJxM1BHp
         QSc3/qYS5kK165QX9B7e2r5m4oMu+SWpx0Z+TLjXPOQqzF4mrq+8QkeI+yVit3C4gv/p
         ywZyhsBdjXSxyt+/NuFT811d5K+ezaT6tDKzEaBf6p6el5ZINluE1uLNJawCvbHXORZM
         P8bw==
X-Forwarded-Encrypted: i=1; AHgh+RrYMgrKlaEBbd/uL0L1YKaPRNA+wPahpGJtVWHYbCsJXV+AyrtODKhAZ0PGg2ltQ8HKN/c=@vger.kernel.org
X-Gm-Message-State: AFuF++mAv3co+Pu4T+UwsjKU04UVho4zZ7HPzXzEcwcf96uVNSsnhjc5
	Fl0iZFbUb4yW1nIyhgbzQ72RX8HQWX44v0b7Hu4b7NDkS7cfIuLyCsMc/alui6UjhfFQUzHlrdE
	69yzIBA0i7wQap/VSMhiRly1R2dx8KcE=
X-Gm-Gg: AR+sD10EmLQL8V5OTKItr1l69VkSMAVrn/Z6ZqUMfZxohEpc35MiIlAraCc0WQdbQHK
	VyCYUG7CPElKO5roG0AGLcUJ6gulOZ3ZKSmz9gEcbUyykjS5H7dITobi7gm13WYPrM91MY4J3p+
	Q5WyNLcMqpqMoFv663ugtz9S+H/DxlfgAxEOx/QK/L5OqQZ45Kpib9wmekRqa5C5cUHaU+7Wn4N
	JbmfOEtCcRHAewRhHjRoKLkcxhN0KRA+vmos8si8SyJ19TJqnF/gRHli4kUqDmrZAqx2CFlbpQn
	JeCLUeDbHPhSTYlmjVcKWxUlpdo1XnhtoyweNw+okdHe8E0No7Gwo5ohG05aqai1L8l2f4Gamtb
	/OvAIWBDKPZXDa6mOy4vHbHQ4UzrB0WlsBfTWFGXHGiu/YQ==
X-Received: by 2002:a17:90b:1e4a:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-39580a79277mr21433618a91.5.1787221000804; Thu, 20 Aug 2026
 03:16:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 03:16:37 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 03:16:37 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-1-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im> <20260820-b4-pks-odb-generate-pack-v3-1-bc42252f6169@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 03:16:37 -0700
X-Gm-Features: AcwNN1WpCwFvEMb7yRGDdj3K_rVLfpCxBZ185yghuXC05Lx1p44oQefPV8b1NLY
Message-ID: <CAOLa=ZSYyfOCs8Dr0Xdhv-=Q=j0z7vtfYqopDb07XuAm2PU84g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] odb: introduce interface to generate packfiles
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e3a92d065977d00f"

--000000000000e3a92d065977d00f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Packfiles have two primary use cases:
>
>   - They are used to store objects at rest in a Git repository.
>
>   - They are used on the transport layer to transfer objects between two
>     repositories.
>
> The first class is closely tied to a given object database backend, and
> as such this use is highly specific to how such a backend decides to
> store its data. This shows in git-pack-objects(1), which is used by
> git-repack(1) et al to optimize the object database, which supports lots
> of options that are closely coupled with how data is stored.
>
> But the second class is quite a lot more generic: we don't care about
> specifics of how the object database stores its objects, but to generate
> the packfiles we only care about the object graph itself. Still, this
> use case is also coupled with git-pack-objects(1).
>
> Unfortunately, because git-pack-objects(1) covers both classes, the
> result is that it is very hard to port the whole command to properly
> support pluggable object databases. There are simply way too many
> options that an alternative implementation will have a very hard time to
> support in the first place.
>
> And despite being hard to implement, it's also quite unnecessary to
> implement those backend-specific options. Optimizing the object database
> has already been made pluggable, and an alternative implementation is
> unlikely to care about cruft packs, unpacked objects, keep packs and the
> like. But we still need to make at least _parts_ of the packfile
> generation pluggable so that backends can generate packfiles for the
> transport layer itself.
>
> Introduce a new interface that lets backends generate a new packfile and
> implement that interface for the "files" backend. The options supported
> by the callback are exactly the set of options that are required for the
> transport layer, but nothing more.
>

Okay so we also provide the implementation for the files odb here, which
calls 'git-pack-objects(1)' to generate the packfile.

The changes look in order.

[snip]

> diff --git a/odb/source.h b/odb/source.h
> index d69f8e2d1c..e2129766fc 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -278,6 +278,23 @@ struct odb_source {
>  	 */
>  	bool (*optimize_required)(struct odb_source *source,
>  				  const struct odb_optimize_options *opts);
> +
> +	/*
> +	 * This callback is expected to start generating a packfile with the
> +	 * given options. The pack shall be generated asynchronously so that
> +	 * the caller can consume the pack data and progress output while the
> +	 * pack is being generated.
> +	 *
> +	 * This callback is optional. Sources that cannot generate packfiles
> +	 * shall leave it unset.
> +	 *
> +	 * The callback is expected to return 0 on success and populate the
> +	 * `out` pointer with the pack generator, a negative error code
> +	 * otherwise.
> +	 */
> +	int (*generate_pack)(struct odb_source *source,
> +			     struct odb_pack_generator **out,
> +			     const struct odb_generate_pack_options *opts);
>  };
>

Nit: I see that `source` is unused anyways, do we need to pass it in? Or
is just for consistency?

>  /*
> @@ -520,4 +537,20 @@ static inline bool odb_source_optimize_required(struct odb_source *source,
>  	return source->optimize_required(source, opts);
>  }
>
> +/*
> + * Start generating a packfile from the given source with the given options.
> + * The pack is generated asynchronously; the caller is expected to consume the
> + * file descriptors exposed via the pack generator and to then wait for
> + * completion via `odb_pack_generator_finish()`.
> + *
> + * Returns 0 on success and populates the `out` pointer with the pack
> + * generator, a negative error code otherwise.
> + */
> +static inline int odb_source_generate_pack(struct odb_source *source,
> +					   struct odb_pack_generator **out,
> +					   const struct odb_generate_pack_options *opts)
> +{
> +	return source->generate_pack(source, out, opts);
> +}
> +
>  #endif
>
> --
> 2.55.0.822.g20453c30eb.dirty

--000000000000e3a92d065977d00f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1ef5ebb30950a51d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRzFBTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHkxQy93TlRWS3gwK00rQzlvVk9qTGlOdUZTQ3lCRwpFNTV1ME42RXVI
R3ZMYm0rZjVnVldRbTc0Z1hWMzZiN0YwSFppTm0vUFhPUktGSDVxNnpRT2JMUVllZ29JN1MvCkts
R3gxK0F1cFJLUCs2U3YweVhtWU8xQ0JZMEhZZ0MyNE9kRGZsNEN4dmpmNXROQWx4RW9oaVQ0RjdV
TzhwdTgKZVpJL0FKMmRsTlE5czJBN0hSb0kvQ3d4eHJ5d3Z1RitoNGVzY0FZSGlkTDhVYk1URDM5
b3J6OUM1MWdWQWg2SQp1cUhXbVl5cHVOeENJWWwvNmdHcmFxcjZBN3RPWWk5YlZvc0V0QUFVQjhR
dHlPS1RlUHM5SGRjSmVPcWhmV0N1CjdnczNpakpWQjB3UzVodGs0UjdjdWx2N0RCaXBJUGYwWmxU
SXhIZ2d6OXpVOXN1MEFoMUhrU2VzOFVEbTBFRG4KTXNtbDFVMVdIbUpHNlJNZithSEpmREpqR1d4
MXJocWU4SC8zYzNtdnZXbWZVM1hHY2ZHbitDMkpNaVFGNkZ4TwpRVXVrblFsbGlJaU8zQy9SbnJh
YUJYdldZa2ZMTTFnamtkOStnY2ZBVlFwNmZmK0huSG5lZXVISmNTbFI0VkZxCjdxUDUrcWVFSXlC
emNmdUduZ2NUUjN6RHJpbVhlTXRxQXVvRkFZaz0KPW5Id0EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e3a92d065977d00f--
