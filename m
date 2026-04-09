Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AB36E476
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728175; cv=pass; b=SlO0EzGL2d6/J8b8XhjQYRZgBdwdhrdXpQpv0mv10TXu8k/l1J66Z6BGgvJuK5uFEnC+WKahXyTfIwtKWGP5DdCgk4C/1yb4hQ5OdDHC3+FKlGVWJ4pzrsEN/ne2rGz4GK1t4BKuDkUQ6JuwIMGpjaJUCdh5vxQ2oWQ9D3AEPDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728175; c=relaxed/simple;
	bh=Ce5mmliIliMGA6rSCkhB+yUJ5BGypq1u47AdsIlApmw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pa1qON+242JhH7w1YqHXykugFzh+8DSjwAGHncXFNKMj7D6nY8CPTTKL2qv6XaN/Hn/9TTzMWRCxNoTE+PIe2WUdIMxPnAjUpEqKYNbUHDTvMCkHEmne2KIlQD7aAERXb5XrtffBMnd9eAJgP27TQrJuIKzZv11TdWCxqGOsT+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDiFbeJ9; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDiFbeJ9"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso228000e0c.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 02:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775728173; cv=none;
        d=google.com; s=arc-20240605;
        b=liUMRlOoFZUI4cZw4aAIPPo8SfNIXh33UCSmyWsvUXoHmH5m7fIGlgqcVrOh1m8Nb7
         Cez8u1vuWJDNKAnlg1CG0SCjOHkHsdOB5XXp7Q7YurTanBcTdKmCRF8pB6yJFRfsP4lR
         mqye6daWaHcmwcrnpNnYb0N9wPiOdenUEeagFSz4cFA0uZRtOXYDG/ZBzJ8Rn3OCU9rw
         +UqJib8a6L6erfDyfknsAWqN9nQv0AprZQwBHVS0OvWGwwAsmcmfC7UB1Ay53/v4X3wM
         KmvwOVgZM93kLJqrTYOr/Pb//fpPOpMTHdCRQnBuY1ELTIMh5nblVChZrc54mqAcziDt
         Shiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=G7KjFq4q44YpO/o2LxU7BYbJXueWiQrNO/rfCXMPVlA=;
        fh=wikfRd3LKV1pMTCnH48n+XuyS1M+529ecCv/GujeVSU=;
        b=ZMk85igBL6v+dJMgLuD6Jak7P2RyLEL3dvaspQN5U3IiMJhEaY7uzJWOyClt5ocLTP
         YjDKciJrz4Voq9aT9izDB89P836dvpRJvVc5+WQZWUuAErRRZuJHDHALtwwRHgjzbvTi
         LyGYg+VkQ509JdJXqieLXytPfvYcC89AjNXUTdE31WoOYWlCrd/KuXPeEM9kvf7BjQRy
         EZOzEhuSlZ5CcLhQMByDHELiZc3mhpOOqIdsCg7Fyn3X3XfA9xbQqc/m3aOjMRgYiNR4
         WKbxfK48tlR3RK1r8pZxKmH8vR6LEf7JNqvry+NlhDK2TYUH0i/LWwn4RcfaY/3HQqWE
         RmHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775728173; x=1776332973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7KjFq4q44YpO/o2LxU7BYbJXueWiQrNO/rfCXMPVlA=;
        b=CDiFbeJ9+wznHGtAKIYMtiia/YrOguY/b7VH2uoVyr0nCXVHGqTcP+Tl6D6ZL1QKpb
         yIT+MPf/BvA9IWDe7QqRlEcay7C4tQKS9UDfxbX5o6/Z+dHxe6VG/ZxAcUc6dhKGD3BR
         9GnawH6ONufDoGYwCn9KqPKi9zrdU49hQKc97HUPH/8rStcJ9M7449633CH++lmkt7/y
         GmrFypKFCwaKLzIbwZswVf8gFbaow5ep2XadboGwmIy4JbNJv40+D2wL410ajgLAfytJ
         O6Bl4kPlhCrJhXzcowl2xqxmZO1nKhPR55Q4Ae3vjuPzrAlTKUDVhQcsXanv5eMxsfLh
         Kyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775728173; x=1776332973;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7KjFq4q44YpO/o2LxU7BYbJXueWiQrNO/rfCXMPVlA=;
        b=fDcWIVM5IChE0PMYlln7kxrEJLmR6P5hHJ4Q9VSSaf11rTg2gjZv8f5aT10pLjcEuj
         EBCeHKpgNc7h4fX/aFu7lLDJgfE9Fr3wfgkmZc5KKY0A33TOWRUcKJcIqVD46gd3CsNM
         O4CfCjlc1qHl5MBVCoO7SYgMSv4jaNaF5NSPoeBULUsjJqxJ9fJ9C4sTox5VP7rx7s5v
         eMA+NLTaEza076NdtwHqRBQK2olyNY6eWqyFYwyvwBZtZyOWEgzuOjnCFp3uWWuj4WdA
         Ap6DkuyNRYsZN6IRFsX85rdOAJhkUc5yhybc46BCog9DcDtlqM2dKXPo0dqlxbmAWlXc
         zjsA==
X-Forwarded-Encrypted: i=1; AJvYcCV5f9sP9SoEq13tIMIPRJPtFZDlSoGiNRjoBgYPbcuUuk9SX5/EYlYppLje5vRZUGaRK1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5tUxRgTBzv/OirZ5ZYJgPUwB+VehLB6ca+Oe0W3UYFaklecY
	vwwDyFPfSLoV+P32eqOPDbK1evSOppMXY5PZRM8Rt9Qmv1LH0MnTNKyY5cMbC1M0nyE2uZdkvMv
	33Od/nhe5ec6h+uxY1Uejb5Pc/9Oog50=
X-Gm-Gg: AeBDiev7yiiPhX/mGoUbLsN9VMualbdLeGfaCieF7cIROFNRdml24T1TXLdX8cc0Iyi
	rvcgEdNU/OniKU9TVKodk/rugroSqhP5MREfA+W+bmeTsO8HPWEiuNwOPvdbkLWFFx9t5s8RUSa
	wyUkWXramOLn/fdUSoiwZk/GqlfjvBA2FqipCR6ougSz3QxKGHq9MG6QwMbsiWX4FyU8irsx9uI
	8/3IE0UBL/BcBY3h+j0VAFPoV3+4M5QY+RBAHU9ClvUBX6/ydvln7QQbUgrBGs7iCEnwvqIjUk5
	yi8TZz/cvgSIO1WJ9Q2U7IWL4cAmw3G7iMxLldl1
X-Received: by 2002:a05:6102:c52:b0:605:6650:465c with SMTP id
 ada2fe7eead31-6085c82fdedmr1448509137.13.1775728172975; Thu, 09 Apr 2026
 02:49:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 05:49:32 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 05:49:32 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-5-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im> <20260409-b4-pks-odb-source-inmemory-v2-5-f02b4f1c0f13@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 05:49:32 -0400
X-Gm-Features: AQROBzAFfHifN_aGSMOTNyPPwS2upitYMjqWe3R7u-7QDBw35vvryEu0o72u1gM
Message-ID: <CAOLa=ZSHAF25zbJ=KHp=u0pFCpAHb-jd45A3dxTSn9pwKHkxFQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] odb/source-inmemory: implement
 `read_object_stream()` callback
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f7eccb064f03ee94"

--000000000000f7eccb064f03ee94
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Implement the `read_object_stream()` callback function for the in-memory
> source.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-inmemory.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index 12c80f9b34..4a68169430 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -1,6 +1,7 @@
>  #include "git-compat-util.h"
>  #include "odb.h"
>  #include "odb/source-inmemory.h"
> +#include "odb/streaming.h"
>  #include "repository.h"
>
>  static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
> @@ -53,6 +54,54 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
>  	return 0;
>  }
>
> +struct odb_read_stream_inmemory {
> +	struct odb_read_stream base;
> +	const void *buf;
> +	size_t offset;
> +};
> +

To stream objects, we have a new structure which is used in the callback.

> +static ssize_t odb_read_stream_inmemory_read(struct odb_read_stream *stream,
> +					     char *buf, size_t buf_len)
> +{
> +	struct odb_read_stream_inmemory *inmemory =
> +		container_of(stream, struct odb_read_stream_inmemory, base);
> +	size_t bytes = buf_len;



> +	if (buf_len > inmemory->base.size - inmemory->offset)
> +		bytes = inmemory->base.size - inmemory->offset;
> +	memcpy(buf, inmemory->buf, bytes);
> +

Shouldn't the offset also be set and we only memcpy offset onwards?

> +	return bytes;
> +}
> +
> +static int odb_read_stream_inmemory_close(struct odb_read_stream *stream UNUSED)
> +{
> +	return 0;
> +}
> +
> +static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
> +						  struct odb_source *source,
> +						  const struct object_id *oid)
> +{
> +	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
> +	struct odb_read_stream_inmemory *stream;
> +	const struct cached_object *object;
> +
> +	object = find_cached_object(inmemory, oid);
> +	if (!object)
> +		return -1;
> +
> +	CALLOC_ARRAY(stream, 1);
> +	stream->base.read = odb_read_stream_inmemory_read;
> +	stream->base.close = odb_read_stream_inmemory_close;
> +	stream->base.size = object->size;
> +	stream->base.type = object->type;
> +	stream->buf = object->buf;
> +

So the object is simply mapped to the structure which is propagated in
`read()`. Since we don't copy any new data over, `close()` has nothing
to do.

[snip]

--000000000000f7eccb064f03ee94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cdca028dd47ed402_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGRpb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzFQQy80anB1bHg5OWIvY2xxeTlKQ3diMjZVWUd1aQpOanFheU1pVWtz
UHhFZ0pRRTVvUExXOVZ2RUlXUFJPSksyQTBTNEM3Vk1tMmhmWk9vYWRHLzRIUWNGNlZITFQ0Cklv
cGpuWmhGUjIrVFJTV1VtVDdxKzlLS2dlZWpoMlhHN2VPcGFNSkxDb0tFczhhZVRXcWVUNWl1SWVm
NEFSYSsKN3JBYklBOEtES0dBWWNDUDhBY2pjcXdUNlBkeThmaEt2aHVxdE1xUGJsRGQ5alhzUVlN
djFkOEc0YXVYYlFXegpnaXNtdU0vV255ZmtsMW9Kc0szTVFVU2JGVDNGdUJuZ2lCQkJKT3dJY1RP
dmVFc0k2WlBRYWIrUDdFaXJNR3h6CjR4aFVlcXhBSkkxS2JFWlBrTGJLcG15bzJ2aFh6N2VTU05n
Qkc4Z2Uwc2xnNGR2blB5UEV0NlE1SXZMSUdOS04KSXdraThKdHppWGxMN3ZrZXhqV05ZSGUzd3dx
WmZRWkNJMjArQkh5U2dRbkNsQ0l1VHZWbEMvWmQxalEvaWRQUwp3bndrY2RzYWllWTYrVjVJTHFP
d1gwTTNXQytGMi9UMEpHdHY0blFwWndVM0NhbkQ1NEtYeERGbG0vS1lxN3Y0CnQyUVlHVEFQT3Jn
Ync2c1NoUTVnb1hJZ21CS1lBd25mS3hPVitaVT0KPXZZQUcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f7eccb064f03ee94--
