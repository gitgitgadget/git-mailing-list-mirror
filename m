Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793013761;
	b=lRIPaODPYclpcn7TD1EPbdSGPkDQj5QwcovBHH6iHdKD6QalN8dcHHC63XNCctkNuLI9
	 iHqiLNia2gJ1m/rHYRdQGISjboZcHHbVOBlkWJRMp5JNHUASdFwkXwOuXWFbMBJjjZwLm
	 p6W7T7fO7SLXKft4b1AOTvDZyHsrFVAy84MIAxLggE1F55J5k41/mc/sE98SL7pY6OVia
	 SdjbFLYuie4oh0zqrzxXtfDsiubrEXxV9Lx7CJLBMRqFNxpNmGzQBOaMQBVyhHMMCN4OH
	 ViB6aiW9ikRQoW0JP8/goYS10+HEgF60VRIy7dd3Gfm9w4g3TPaiiu+qDyry5CHBGng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=GXDN8Na7gVnqQSQ85rGmXJ1CSCBql23ctgmzmkb//gQ=;
	b=BMGtt0Hbd19y3l2wIz2xXgKPtevAHWemX4BJh8KG+v/t/DpMDdwKh+gQcbyZ5tXcOx1W
	 kyJWSWe4jEVAaaYP3fOdg9tn8TMXdSDxcqTqr+fngKN9R/tKkKWDWn6U6erBDBdpidhw1
	 5MvQ3PjXw/o/YoJ0m7komaHEYDufEXpIZiZfATTaY8jk40hmC59MzOnTINo9sTrHr+avC
	 eMty4XgjRe/nWOV3TQbnFYQvWddtsAGooDLvTK8QCDfovLdeIHfun23E0Fcy3hbk26yEm
	 XeLGLRtjEqXBEWh6ANfcHRcfhzV/C5OQpDELJxNAB4N07zVjWUtVIBJcnzkDxjHn9WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSSGgWcZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E97606A320
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40E97606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSSGgWcZ
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-99061e2171cso656432241.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793013760; cv=none;
        d=google.com; s=arc-20260327;
        b=stmnG2UBucE16JZzh8HZ2H1IQ4O8gRtG4jbsKOPAWiFyW3rGfj+1koluA7uHjiOxT3
         AFth5t/yZ1zlFnU9OujKOpB2lvjy5EMe7OvQqNV/8gS1VTOp7vin/G9h8y57iZ9M3qBI
         1mfMMtOmvZYVNhrfSSdnfHW5r4bygKmwk/BFLsGrYMUBlC56nG5wst+oUrlRN7IfhNcN
         GjqlmxKkd7dU/YGdxM90grQXl8O7IfenuYA+P9VBbrArj6m6BHr9JNU3G63lDLNmLMHD
         EwAWz+qaF8MXXTkh7ZdMU19zn4La5B11iXue50jn9Of5o+nlRl+X+w/Qz3+CMbp1Slef
         ABcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=GXDN8Na7gVnqQSQ85rGmXJ1CSCBql23ctgmzmkb//gQ=;
        fh=dBqQhkp0iRqW00xNMQzjtEYKhRvZxWi0iM1EVIh8Npk=;
        b=SymG2f0DMaQPP8ibI+bn6BxieNLzE06KgfIyAeJAee+yheajvpxEdnEt8d2ku/PiyU
         8s1WHTHsHdHa3b3JzwxWsbuzRsNNJjVt0H5WzEzYsOtUJ9yZFk9G7dEo5T1bYPLJqSTy
         tAu6K9HEZnzqvwsGZOAgnkBhiI0k2PTje8Gey88vt3qIiJEoQ4nzikwJiXcaceGv95vJ
         e2BxRyXxw9kzvE+jDB6VKruDuqNGkiXMnqoMMZP/ZKXv91vtyThxDlW8h8Yn+SeZkw57
         hYozxRFOzt1rsZInMLtjaDUB9/jc3tm3cZwiAd3i20XnzccCwG3xX+rdaWNmQ+B6U4gW
         5BYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013760; x=1793618560; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXDN8Na7gVnqQSQ85rGmXJ1CSCBql23ctgmzmkb//gQ=;
        b=XSSGgWcZbA5m6U/KLbRjy0Ncrq1Bbz3ROxHyx30K6P3LX14ROJaXBmHBuejBMdTHRQ
         +nP0oTZeeb2kDpfeNbGc1N3Nh1B8GQLdaMX+yEvI3tEXmJr1KjfX4SwgwykPWBsQ34Ug
         sOEhxfVg736U7s3/nt3m8466y7wPqrY+aGHeQn2RXMihQcpTLv/rkLqjNCuIcrpVv/En
         0l8Tl23vmWaG9bD3nwcfPtIgiECmGAovkHfyBhIvgMHxi5xgNGvFV3ALaxFyS7Gspprp
         EnObWfXBCK8WjPnq31H3NISPVEco42qhuTZ8TQlnFcWIyTyJuboqnhV98EylC6FX7b/7
         yTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013760; x=1793618560;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXDN8Na7gVnqQSQ85rGmXJ1CSCBql23ctgmzmkb//gQ=;
        b=XQ/wZt8Bg3KH/vRf4zqZcX/ga2+dmYTgy3Z+Vul5quuPi7ggRb/Dvp76k7ij7e3jpv
         bwuDNJFfG5ityFHOxn+3O27NHkrMWe+AOjeiN2cOYQXokPvgChDOV8TfZhAueZeMQnnQ
         iHHs/oMrIIpGM4LC1l17zQv8GcVr5GZlGR4cYuhZNmMsiZx+gUkkLCvEsEE8B4R/ihSi
         3DXacsS2Kl4in/1mbU5gGZ12lLyQ97J8x4MLjLCc3ak6PMGtJvkhc97l+64IQnxwxzSa
         R4C7WT0YRXmgO66DNprs4wEq9NnDIVrcjdcbPQ8xxV2dckcMWgsN7C/iuAG3yCNa1w1j
         fUng==
X-Forwarded-Encrypted: i=1; AKwUvByEWJ+lSfAKHLINlnQ33+m4wtUASiKyccy0MQKI1vP5wWp/dqd8rmeXhUXiz7p3a9rQvnc=@vger.kernel.org
X-Gm-Message-State: AFq9FYITd1i/LRO5Z+LGs0oUegoL4CDubC5IWiHWkImTBgL7OjHELD49
	5082OLqrf9rcZp4IPg8X27ASqY+4eK775O6kYPNrfnAmd7LrMJAQYKGzFW3PpmIu39iXdlrbIa0
	UzmGVD80VvGJT4KqGHL91fSqmmtdZ3o0rEg==
X-Gm-Gg: AYBFou1UFXjCkEjdkfw4Wy3EY6D09PJKDQ++x8XWnXQrSlpebwSAqIFpyQkOypp7HHZ
	VZ6ZHcTt7WYMU1zJJGnRDvBhHLZh8nUC9AEZgA/sCL8oAUhHd9g2XhJxvrDsPkDjB/rIv3cANBg
	Unfb9Jc9ppbzNWCXqMYzNHcBoR8g81Vj/P0kuaZ8Qn4YAKKMsaFI+EFTVsgMXUYV+pQOVb2V5Ok
	E5ay8Gp1Ray6m6ES74eHLjeo0l1WKo7cNZFTAwKOQUZ4z5/2mrVvBvMB7UbvJ/F1bwQdWUq7OL8
	y/sr6qPLM7Bj+Eh1Zx8pO8O/C3e3/MW7SJP8B/xGg0aVj9ppnprM5/rTkRTLpuaOlmntTsaAhfp
	G7TFKAJfm+uhia0Sfcj3zjd7q9fDpwHG+qSkm4QwvxJAqULVeHCTbGru/qtVkHKFDiB8d63H1Jv
	KOo86y0ACWkZe5DMttGbmVlHpXxkWp/zoDcHmlvE2phFlbMYlqSw==
X-Received: by 2002:a05:6102:4455:b0:7cc:1045:610 with SMTP id
 ada2fe7eead31-7ce5cdcae84mr1115449137.27.1793013760131; Mon, 26 Oct 2026
 04:22:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 04:22:38 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 04:22:38 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-2-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im> <20261023-b4-pks-odb-extension-v3-2-b1bb30a006db@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 04:22:38 -0700
X-Gm-Features: AclHuK9GbKPR-kDHvwFg9Ti_4G98dJ8plRDn5YHMuNjRIYA65E8bR72VTftNEIQ
Message-ID: <CAOLa=ZTwedYbV+vFJcrACohX+epp4hUXSFXYvRTZ1tJPSNaj9A@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] setup: introduce object storage extension
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000402a0d065ebc8c03"

--000000000000402a0d065ebc8c03
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/odb.c b/odb.c
> index 98c5c862f5..0649622bc6 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -27,6 +27,42 @@
>  #include "trace2.h"
>  #include "write-or-die.h"
>
> +static const char * const object_storage_name_by_format[] = {
> +	[OBJECT_STORAGE_FORMAT_UNKNOWN] = "unknown",
> +	[OBJECT_STORAGE_FORMAT_FILES] = "files",
> +};
> +

Super Nit: I would have dropped from this, as that is the default, this
makes it seem like it is one of the backends. Feel free to ignore
though.

> +enum object_storage_format object_storage_format_by_name(const char *name)
> +{
> +	for (size_t i = 0; i < ARRAY_SIZE(object_storage_name_by_format); i++)
> +		if (!strcmp(object_storage_name_by_format[i], name))
> +			return i;
> +	return OBJECT_STORAGE_FORMAT_UNKNOWN;
> +}
> +
> +enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload)
> +{
> +	enum object_storage_format format;
> +	const char *schema_end;
> +	char *name;
> +
> +	schema_end = strstr(uri, "://");
> +	if (!schema_end) {
> +		name = xstrdup(uri);
> +		if (payload)
> +			*payload = NULL;
> +	} else {
> +		name = xstrndup(uri, schema_end - uri);
> +		if (payload)
> +			*payload = *(schema_end + 3) ? xstrdup(schema_end + 3) : NULL;
> +	}
> +
> +	format = object_storage_format_by_name(name);
> +
> +	free(name);

We need to allocate since we only want to send the format and not the
payload, makes sense.

> +	return format;
> +}
> +
>
>  int odb_mkstemp(struct object_database *odb,
>  		struct strbuf *temp_filename, const char *pattern)
>  {

[snip]

> diff --git a/repository.h b/repository.h
> index 2a348012e8..8c4437762e 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -694,6 +708,7 @@ static enum extension_result handle_extension(const char *var,
>  		data->submodule_path_cfg = git_config_bool(var, value);
>  		return EXTENSION_OK;
>  	}
> +

Nit: stray newline addition

>  	return EXTENSION_UNKNOWN;
>  }
>

[snip]

The patch looks to be in order!

--000000000000402a0d065ebc8c03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78afab1877c7ae51_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yZk4vMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDViQy85U1NLcE83N2NXNCswd05waVlWamVJcVJjMQorbGJLZDhVcGdE
WFhpRk1qUlMzOVgwc2hVK2w4NGdBQnVUay9lSjc2SWJsTk9nMWNIOE12V1E3UU81YUMrNERHCnhi
cGZSUFBFdzVxc2ZRbnFwc3djd2NreW0zOUVoNDlES2F6dGY0c1RXQnQrZFZ0TW5xc2l0K0lLOW1D
azdhMkIKKytQRTBacENWazBNbEovM0M3QkNVK0pUMVpjTzd5SFBrRE14YjV3VzFqU0tITDd3TnNh
aGZmYm96ZkFJdDRpUwpqWVNMSXJTOThpYjByb280SjhtT3ByYW1HUU0yamxyNHpGMFFpN0dzSjJu
aWtKSTY2dkwzRGIrN3R6V3NVaDM2Cmg4cnFKWmlTaFplWjMrLzAwejduRXYxME5WRWhTaWFmdXFh
c1hFNWhiL0U4RGdVeklLV2RFYjBWa1ZYYjFHSmkKVWg2NGhVaVJtOXVKeGZFaE53VHQ5Ly9FZWZa
MS9WOE53WFBGT3Jnczk0a3cwZGE5YXpIak12NTIwWStrYWV0TwpsbEhudUNqME92WVlRSC9IRGVs
ZktuZ0dlclY2aCtZN3NsaGJHbDNyUUxuM0NqQUg0TzRyRUsyc0NjYVdaTFpLClAxMlhmb1Z2UjRz
S09oK29od1F1dUZBNUI4RjVhZ05SZmNnTTFXUT0KPWJxZjgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000402a0d065ebc8c03--
