Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5E3C1FD7
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900599; cv=pass; b=rEu1DUmDV5k9wzsXYAmCbU2t1cV3DsCKtLzZgCk/mzrcMEP6MfBW6yHmlfE8i7O8ViO0AOkog1fGQVmQ13nWAMZeascK6XX2ic7l5Mm/bx8+hsAyOVEzD0+BVX2CEXmsGEPA0Zbv0fO9MUbjrhstn8YabidhDtivOXM9aAJnn/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900599; c=relaxed/simple;
	bh=WzCP7fdaUh3OtzXOJ6IawNV3pRFNlb29sEQdcDpK10I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=eGYNNXv4lKJEqCYYNawI56Bjd1+Lh4AtWFroQ2cPJlDW7DN2w5LEwM7xyJPqho7yeOqejSvAFdEPHmwLhYWDEX+wtxvY26vgycLnpMFItrFMJb69PH8KLpnNgr1k1TDbU9UZFFzrbGUISgCfNcBm1JxNuHzkJfyrizsjh9pzFGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlXHq62Y; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlXHq62Y"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5637b96211aso4479523e0c.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768900596; cv=none;
        d=google.com; s=arc-20240605;
        b=ApzwQCfmKU5PGmDvzWI/Htbe2M9Zih4Ek+Wxfd20PE0IHt6spf6KrwFrTnaZYeg751
         x+wojJJyHhntyq2c7cvynwNka2ITWUEEFS9N+TJOE8OxjjHS5ZAegFWi8LlLg0T7MG7/
         ZGsB8Cdn1nwelRc+29DowZxM3Dgw4+Tk1ggPEddI4uU2gwF8vwJgWCwirtUqo+9O/2qU
         pc8apiKoDfgkM9GyqRCRJGLKKQk+vKaxcl0gNNQKopIzRKvSsUY+DS1X4hE03Ja0V47B
         VgM9jzI+bI03HMmPHbGkqjsCETncFjG4YicxR0QvNCj3+Nm5rrCHym/XgmfDNmM1mKUd
         F8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=J6lP7smlx0cPRtO8BCk2wptRzub5kJC/33reRSUMcSU=;
        fh=D29SPazCqcLdEovdlvKxs07csSUIecPhMsPzE3oenu4=;
        b=EnaOWv/Ij4o8x3YehWXBtlKB3PyA9DLslKaXLxMHdRZm60mg4YcTw+I6dIbbyfD690
         6O7cD3JqQ/qteWDSPfhhc/NTx0u/KUnwIJEmLxqIqUjSTRvkUVlW0eberrcmQ/662Gis
         0NdGoh2xjHPHT8Qs8dADAsCpMUfECTNP+3RXu1kiQqVS0iuHGpXxTG28Itr2cZOIcH5K
         cHXZk3P5Qm8ehmmxj+evNC52TSiONaDvqyh7qwlp7Hzso8Oyf2nAkmAgW0z6+UzVcgC2
         BbNyyHjmRqVLabL0SOCUNOieINA7LdOEZgTlBesbRXzi3tE0YnX0zhgWBc0zj7eYDN2w
         qUSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900596; x=1769505396; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6lP7smlx0cPRtO8BCk2wptRzub5kJC/33reRSUMcSU=;
        b=XlXHq62Y9PA7OVmjHek3xVkJ62NKmoK54C1XN/9+oTb5fJqxdWINJ28OBvVsr+BZwq
         sZS0QdGKg9GkHqkT6Al7RxKvXIW7eDH7cEM91J2vFRTktDUGtsffjsaL5TgUdDJrE+A0
         ClCsdbdsxQaf76o3e6FegD7K0jBIReaEaZSkWrB1txpaOF3QvyUYc3jglJOVWBZteXmj
         ffT4iBvw/FOPr6t8LNhqQzbc0rPC1/3fuDttTaTNbdzNDcl6avqRW7kAmRaesyB7idpM
         T5XZZlk947RGXTpym6wJVSC/v6CLOyqI8Cagg6oerpPUqlVZjIcagg3WBDlSGO8ZEOoc
         8JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900596; x=1769505396;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6lP7smlx0cPRtO8BCk2wptRzub5kJC/33reRSUMcSU=;
        b=rDmXkuxNRP1d+sGWO+RFEVMSkG9a5cB1qpyj2KzGvq5xiytHJhf6S5Yh4Gio9JuYQT
         yVqHAP17SGfe80XeGnGm7fyrHYBZ4xAlz0sR9BxFMpRATfvLpRMGGK4JVgzOrcauHxeY
         bvDA9Y5UBEndquDr1EphNcCaE7fru9yBwvkRXhRGYMwqqgaNm932Isfo02EeAuJ91MMQ
         SIuM792kLTfJi3fm04Yz61xzExjU0zhR4vQSfmIdEdKo5nu/cjqJu8ljF/nU6EvyVTIl
         Ak0SrJ3jBvU+ClJj99GPtH9LVaDnHDButnfRYFW0gbWoMr7mVCaySjDrf0JI5fyOg1e+
         8Iyw==
X-Forwarded-Encrypted: i=1; AJvYcCVDFoI+cuAGJ3yXfkD+Xbceu0cOE4h7ESkpTiUPYTPY3Hi22b1x3I8TeurVXmUq/wgOrBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpdOpu3xVvPpeKvo9dCWTlD0iqj4FTV2Mlw15xxcTWxuPObAY
	vCvaIop+yTMJEpfhmz5Lkmqq7xMCFEfev9pFkuSmaSd43ZgrkZKYii6lxBrSVNtLpZ53xwOYtwz
	pmjgVlFwLfWTBSHqLwo0XoLanxDuNjaiFzQ==
X-Gm-Gg: AZuq6aI6xrf619hmvANyfI0KSH0Tk4FtYLMdoynQauhHCdODJNBOOP+4bZ9p7OKP5gp
	2nn7Knq3QT7r+jcB08C+Lo8GdsSt2q5AUVyPACsHWkhqCB9CLWUROcmGuc6w2ZHpEShXV+uaeXC
	SQkTnAm6rIPStpL9aiCKSkU5J+5B4KUjRgL41YqE7m1OZvoy6Hirw5oHIbJI2e93UBCUhA6rxz2
	n08g+D6k9a0d5DVkA1XZ+jriSOvlY7r1yVi4/nvVlj1bPz0cot+lYr1b9LHLf1+I77CgAchnUYh
	gRz6jjKrQyvwSv2HvMcZB/CNDnOpdg==
X-Received: by 2002:a05:6122:8c16:b0:55f:cae4:250c with SMTP id
 71dfb90a1353d-565de441249mr286882e0c.13.1768900596537; Tue, 20 Jan 2026
 01:16:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Jan 2026 09:16:34 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Jan 2026 09:16:34 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-4-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im> <20260115-pks-odb-for-each-object-v1-4-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Jan 2026 09:16:34 +0000
X-Gm-Features: AZwV_Qjnw4fEhZ0dtbzoprRsOXicMRY7wpKABso-nqKOHl7uQOUDqUeOdYGDnFI
Message-ID: <CAOLa=ZTupfCEHFHeGtA-r0g5KfghRL0X3BoH6zVTMg-GMZsodw@mail.gmail.com>
Subject: Re: [PATCH 04/14] object-file: introduce function to iterate through objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b33a3c0648ce43a9"

--000000000000b33a3c0648ce43a9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We have multiple divergent interfaces to iterate through objects of a
> specific backend:
>
>   - `for_each_loose_object()` yields all loose objects.
>
>   - `for_each_packed_object()` (somewhat obviously) yields all packed
>     objects.
>
> These functions have different function signatures, which makes it hard
> to create a common abstraction layer that covers both of these.
>
> Introduce a new function `odb_source_loose_for_each_object()` to plug
> this gap. This function doesn't take any data specific to loose objects,
> but instead it accepts a `struct object_info` that will be populated the
> exact same as if `odb_source_loose_read_object()` was called.
>
> The benefit of this new interface is that we can continue to pass
> backend-specific data, as `struct object_info` contains a union for
> these exact use cases. This will allow us to unify how we iterate
> through objects across both loose and packed objects in a subsequent
> commit.
>
> The `for_each_loose_object()` function continues to exist for now, but
> it will be removed at the end of this patch series.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  object-file.h | 11 +++++++++++
>  odb.h         | 12 ++++++++++++
>  3 files changed, 64 insertions(+)
>
> diff --git a/object-file.c b/object-file.c
> index a651129426..65e730684b 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1801,6 +1801,47 @@ int for_each_loose_object(struct object_database *odb,
>  	return 0;
>  }
>
> +struct for_each_object_wrapper_data {
> +	struct odb_source *source;
> +	struct object_info *oi;
> +	odb_for_each_object_cb cb;
> +	void *cb_data;
> +};
> +
> +static int for_each_object_wrapper_cb(const struct object_id *oid,
> +				      const char *path,
> +				      void *cb_data)
> +{
> +	struct for_each_object_wrapper_data *data = cb_data;
> +	if (data->oi &&
> +	    read_object_info_from_path(data->source, path, oid, data->oi, 0) < 0)
> +			return -1;
> +	return data->cb(oid, data->oi, data->cb_data);
> +}

Okay so here, we use `read_object_info_from_path()` since we already
have the path, we don't need to call `odb_loose_path()`.

[snip]

--000000000000b33a3c0648ce43a9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ec1dc62a030297e7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sdlIvRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1pTQy80K0E2eGVwRUdSTk44RmVlV05KcmY0L3dkWAozd05OZWhTSDFy
VVBjV3gxcEwyOUFrdXo2VnpWcjN0M2NKVktYVjhrRG5uNG5lWlRHTnZvWlpjSXlBRGJXRjNaCmhj
MndCbFpEcFRCS0FTKzhFSjZPK01RVmR3c1FqWXA2N2x3UVJKb1FaMUlwTkI1TWIrM21udmNSR2Rp
TCtEMlYKaFFabXJGemgxcGgzc2xDRHhRcklsZU9ZU3pGSWRwWFNQVUZtUXNjOUdTR0VLazZIemFJ
cXNnRnl5alo4dU53bQoxTW4vT3JZR0RvUnBCNGNPT3YzUFR2WDFjeHBNWnl2OUtwRXBLQVJKZDVB
NmNtY2JvSHBGa0E1cjlxdml2L2ZICmlwY1U2WURyRitJYWNCa1dsdzgwNGVGcVllenpBdElOaTh1
Nmc4MHIvUTJGeVkzNDlRZE02UHEyRkExc3ZyRUYKYnpZMkJSbFNCR1U1TklhTmlxdHNrVHI4bkY2
cTNBUTBlRVJSVVh4ZVo4d2NsUUY4ODl0OTY2Rkk3dzBpck5DagpESGxtNjZ1bVNidTJoc21YR1Fw
QVowcnZKSVgwOXdCajcrK0ErQ1NXZlN0MDN3RjJub1B2MytzaDJuWmdIZFhoCjNRZ1N6VUJGd1hy
Q3ZoOXVpZlJIeVhDWHRLYVMyUVZxYjdPNXBqbz0KPWlYbTUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b33a3c0648ce43a9--
