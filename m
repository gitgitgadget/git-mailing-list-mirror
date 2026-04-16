Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768112DEA9D
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380024; cv=pass; b=Mz3PnLaairYSqfDAntIoGLAi3a97bXoHjMHdNyTwUuxXXEgZ8Xk0xufwQgGiKWz15nq5nQuJCx0rbuuKegwg7fmqgG7psjXPfT+h6nP9ewpKiUv1d+ImYJTHbhS07x5cKTEq5dSbv0zoSVSNTznUA4aCsW32/9ivUiZMpa2ILmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380024; c=relaxed/simple;
	bh=f6y/MNMOocyxR/Ac3ZF1v8ZvGR4DzpQzqtXgOjjRrgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loVs/MjDX3L1ToUgpRzqONJOtaruy0g1v3tyZXwuHqNAwutz8q7diC7Nh808LiURoqdGP2MUtSB9vHn47ygkKoSWEdtwtM8aPWWR3bRIO/cP4vzbULNUDNpMxYMY6gxMZ7ccCZioEe5yBDbPqtP2PPB09SOHBJePtBg6G/VHgc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ1QmWQB; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ1QmWQB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so36123b3a.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 15:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776380023; cv=none;
        d=google.com; s=arc-20240605;
        b=izRLpgPZTbNTexhuPf4u+k+08f+t06lslXn5nhvA7km/JVCJS4MyTtELletkek2Hqc
         1pS3O75xSkAFLswr0PWeQMXNQLabO+O+IoFANGrlA4D0Czq6zkjkmUyhl2ZsRN/642pd
         qulUlVUElipYQueP28Nsp14WXnxVivm0zV/AwVf+FmQArb8kUF6rmY4PkRW9JIPqYTsF
         8NnE6q9t8ujOY8rarBFqW/SxK3b7dsh2V+QdTQxreF9BqZ5j/qZqgpqfHnIKMcY9uAL3
         SzMPScoEDPA2LuDjOD484k1iCOkA7fPD3uKK+skXkByMsVdU54Cp8jxRBobfsbCRv0KD
         A60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kddcnLx0Tuv6MhAyS4qb6hsPmbVSzPque4fReUkaNVc=;
        fh=fDra5E97jdgrddDfDvRTGbshnji+3XysukvVq5At42I=;
        b=VNhqy19+HC8wfiTfl0+fGvO2d4Up6f9oKDviY6hRctwnnnOg5vSzS3glpRYcswT694
         0nim1Ft0BxV+5DZWPR2jgdaFlwuqWfQb/UdQoOJbFzql3h7h4Frw80tISMMQvRj0gLkE
         lr3VYDtdFrLe61xJ//QIII89OAqSfsvQy3Gf6JFliT9I7ijVsaYZfKAL7wj3yEK1HnrW
         NVYLCqpvGvO6UYvQ7YIlfRY4U0as2mg/p4isiX1vl/bE+ajRhH0sdSRx3YLicss1jZwO
         4HupKTfF/IjZD1gOZngNfnAzKd9G+7/jLNMYKAX5MaxgM82L+RNspmCk79elqcZINFYp
         5k0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776380023; x=1776984823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kddcnLx0Tuv6MhAyS4qb6hsPmbVSzPque4fReUkaNVc=;
        b=UQ1QmWQBtCdAndT5prn4VDDyD4WmCw06soD2avQe+kdMJZVugLBlOR1qMlC5jaoS51
         iMBWEFVe/lF02/l3Q0amEdXOMhG3LXwPVidQ1XS+urahJjMdQK9chVOYqhHhmg2guwDi
         /fPmC8HjfY65bFv9KyaFjKLJUfZ0t/ljBOKesA4z/6rXr0ww8tXmpQhkYTsjPWpgcFYr
         SCLz2sCl1c08vTUgDWMAenjGhOI/ASnRBWfN70bIf0VSsuCbyq25OTnQICOEMWKZIEsp
         KMpdtHdf3S0/sfobhTjmDWGutKB8TEvr9vC6G9+9aa0zBORi+LOfTZfT0hufCfiDdC2M
         aQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776380023; x=1776984823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kddcnLx0Tuv6MhAyS4qb6hsPmbVSzPque4fReUkaNVc=;
        b=IuBoIrXE1P9GBRwJLmdimZf7ljLtud/hkFUmazjaALZo8ie3Lgp7NgxFiLEnXSQtIo
         YMYt4cDbsdEV1Kw8VXeFNK2J3zhkxkig+3BAc7fwy9Q6ntmGMaDPh5zofpVl/8bWvZE3
         RdfUrR8tuE4tG+tgIiAoIfn7sy8D2gA0PE45E8KKPGQOk8tniyxpmt2+1OHh3604FgkQ
         /6d12GZ/YbDdQPYV6Xwghqx1iNNe2BTvQYzy+buTi/DFe4jNbNAt7NIEDDFdOSh6Qq/i
         FFJ/F7m10fCYM0BhjXEbNq/iaK7C+eQGaUBRVbir5fM3MP+bOaRtFql6KGdPCni0qlNL
         So5w==
X-Gm-Message-State: AOJu0YwrWsb/JJEym3RFHQthOKdc/ZodTHLodNxdVjuLFGsnYP+j6908
	fvkQtzTnqk7FUjiHVK8GlJxbN345gbk1RxhNtodmMl3XU02rOAO+14E/7usOQvxce3agh3UU6NB
	RfxVPmqNPYrsGCHnhGyeth0204i1Jtig=
X-Gm-Gg: AeBDieuieC3ZGvA0YYzpGwivRAYPFwkBW+sJsN2RwzhD0ddCgw8lV40baEam1HOl+vZ
	OIODPdGZFAobI4j5ufi3fcAlG9xMoSI9KhufD07TkwVrHA7318hWNI5PmvBwfTbO53FuUGlOpwu
	30tsFIWOE1g54FWUHJ8qsrrQME2m5KbW3LghO47LSyXTqKjFltPeUYEydkWhwlb8+0diownS+sC
	5rLP/ybkgoH5MQxUxaZxjOR4V2u5MumI7+hzPHkRNk0QOu6kOCGZKJKpaN9Hn27An7jckmW9ax6
	3/qlaP66cuJGLKLkdi1IBV44zmk0E8OxWvNKKfQd6aKU20sis20geJlHi/gRnsxDIcZj9RIvrpK
	Amf8/hG89EsgCGgHBS/1wfa9wIP9TiPq/0WdR
X-Received: by 2002:a05:6a00:4fcf:b0:82d:785:f64f with SMTP id
 d2e1a72fcca58-82f8c90c38dmr168808b3a.40.1776380022726; Thu, 16 Apr 2026
 15:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774820449.git.me@ttaylorr.com> <e8e22d7958d513c3b7d4165857392a19277df65e.1774820449.git.me@ttaylorr.com>
In-Reply-To: <e8e22d7958d513c3b7d4165857392a19277df65e.1774820449.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 16 Apr 2026 15:53:28 -0700
X-Gm-Features: AQROBzBT4o-BtGpPuLegbgP_6k0FP8mrQgBXdkxzQQ7dh6VP5yaHv-OVKUmrl5A
Message-ID: <CABPp-BH-Wd5vwxHCx8BXJvCANxTzD=54DzB+YCME7bL+xnQG_g@mail.gmail.com>
Subject: Re: [PATCH 15/16] repack: introduce `--write-midx=incremental`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 2:41=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> +       if (!strcmp(var, "repack.midxsplitfactor")) {
> +               repack_ctx->midx_split_factor =3D git_config_int(var, val=
ue,
> +                                                              ctx->kvi);
> +               return 0;
> +       }
> +       if (!strcmp(var, "repack.midxnewlayerthreshold")) {
> +               repack_ctx->midx_new_layer_threshold =3D git_config_int(v=
ar, value,
> +                                                                     ctx=
->kvi);
> +               return 0;
> +       }

Should there be any sanity checking on appropriate values beyond
is-an-integer, such as requiring midx_split_factor > 1 ?
