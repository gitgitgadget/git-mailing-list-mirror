Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE333F39C
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715485; cv=pass; b=WFcJzIrEvMk04k54DLqqBqe7MAoBOIGYcC02GOeTezhhYBDvT+xZZ+dhLXk/lyRUWWEt89JE6U2DnVLwuOeoj3bHw3tTRQdZ/mrCCOtkehj6PKr6j9Ev8VtBJ8KH/M+XRp/gjaOTfSkltU/fe6hLkEX63McrYaO99yRW8SeFlkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715485; c=relaxed/simple;
	bh=Ciz5JtrOdWH3tJwyurxpatWOHFC/NcgofHnMjL/ytjk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=H6caVDyWLfnh3ZP6oh0o4EDbBybDEZ+iFCJUeaq5nwyDpU4KAdMwsqlLwM5vXrUIG/riRIJdvVLmEzqySm0vCXUArVMLctf21ZGTP2O9CCjkgumDxF7HvXid1l7pU1z6nPPZSvSeRPoOHqOXFr74aw+/5alf9QzfuqdUcRt4hT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Csi6os9W; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Csi6os9W"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so1967953241.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 01:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770715483; cv=none;
        d=google.com; s=arc-20240605;
        b=XYD/GFV/lgqAueDP26PxQLDMfcuiNajH2c3oA0HTYtFu1AqPKhLtSIy2+BcIblkGvw
         x2dj6O6b4V0/LxIOvtOIyPTf7q/CaXAFm9y+tJCrxh/CURfZGd345yxBMXFiO0UeiIZJ
         EbdaStzU53i8uQpwNT3jtL9qaJXxyVUzALymBGlurTuqYlFhMOtvgYp+pNiQd+bjs5Jq
         4w4yVleedlSu9vEmcEJn2sJ0o4ir5vOrl6TSLWHAwNWcxiSqsHqdU74wI47uvUrjmF+a
         y061KHde23HMoAHVxwdsXs6tAQCpbklaTuykMh2a/aQdHG3s8Bk94D0WH1KBNhPEAKYP
         A1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=rIWpZFtutMWzDZc8dmKvQ3D8eV3Gm/nem539QlHXn8U=;
        fh=F9yksAPJMt6RfhwxGUJV6S0MY1ZdNsDtCRfZNORhjWI=;
        b=BDNm2Z55PZzsr5rs9dUsknInrMivnoQu+HZ92mivp/OFeeFLFqHrQRu0AnlRe0zOVB
         m9mbsf+UwYg9EfaEOO3DfwdQ5yzkJvDYap24UhB1imT5HvmITUEzHvJoYaNFaLLct9fC
         ahei/08ZXdB8/xOMGYP7F+aQ6gWnNeM/EVQsIQdgULbN9UC3WwNZe/19d6++p0v5xHyw
         8gPaep4As+U1za2r28zMnaezBJNKFwSc8I0VvG3YvWOWcvrgqLlgIe3GttBrTrbFPRqa
         3+maZ2tbNNwY4TP4myoSFkC/eIjgGebgrbKsQpO3omo+OMLQcxUNw6Zu/qe9cUM7zv5i
         R+Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770715483; x=1771320283; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIWpZFtutMWzDZc8dmKvQ3D8eV3Gm/nem539QlHXn8U=;
        b=Csi6os9WMbMkLhtMv+ylj7WiQaivucSUkH9XkN7Y3d4MG0OMZgrhrjo3gBHxrcbab/
         Cc7XZJ8oOy7ee75lvhtWx7T5fjV1UCTI5Aaui8hSrMnNyaiMTbnP5QnuptfBkDqB/raU
         ffyZPqt0Gebso35/V5FSpfMgOqX/DXSS7b9Nnz7qJYHsdKdhVBZjG9sffyjj7Ms79CiY
         cLLFVjf06sibIWKg0LhQ5BLl0kTX1yO9udhJ0HG2SQAAhCdk+3XqY+VYDrJW46NCNaeq
         Ld7ebwbfnKXArad3pHxAgo8nRZkd82cub5p9mVoBDGX2Trs8gshjfJ+Iy3bqfI2Ih1pu
         enCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770715483; x=1771320283;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIWpZFtutMWzDZc8dmKvQ3D8eV3Gm/nem539QlHXn8U=;
        b=l/vS1zqkzIJf0sLdZFgpwTIRmj+y5zz5lasYQkJ+kVzV67S2FjdFEp/fcv40y6cXlX
         56AsyNHyad/YliaTBxnHiv+53HZBq3cFd6pzmiO1NtliTSeSNymoRkBD1IlJKxaikHL+
         IiPEkwnlXPz9n5DrbWji+WC1H6OVlUP4LoqD7gkHfYJmbmtN/zLhk8xxCVAVorVZljXv
         zV0gdJkugGn0RdeDFx+6Qz1s5DCkLAU3JjDmqzkRZQjISP8zK91kYskYk3G3Bm5KuCuC
         oQELyULcKuiGbniY1yvqW0ZEijCrFAwx+VrkVtZ6SATS5wiI5pWgKtWIXidnjtspgiwd
         O7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUN3+lwXpdhFD3KJQazMo0M8Ce7bZEchRMW3+sT1Bz5USLZPeI5ymkTNIt/xVuOPL257+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEX3xStTOlySSFz8CLrM7E78RTsFE83wVsCSGnleRG5bYXHcd
	wmNGLN4UEWX238AS0IHLzyEIsssFW1AD2OV0dgQFB3sv6NBqapqwCFYcFGpyAvi3LahJ6gvuoHY
	aMR5ZEcRE8zzuD/3htT7tyCBscQxr+x74DR7r
X-Gm-Gg: AZuq6aKHOx8NCyhYeR4fvTaF1u80ojCAvLPHRMS7bEWEm2E6gwcngVdLehUfydplIAT
	4jh5iebHVWmCDdZNjUdcJ1HYpK+7QmlnpNPmzEF4srEST/NOWhFh6gvsa524GXIJ+mkWBKeABMV
	HlAHClr5+2vrzbl9qEvVmwjJNsP63ODxm1rMHkOxi7h+V/if9soxv+FgJg/WF+Pmi4sT8iK/6la
	epsbYTZyRI3XNGiDc+Cms5zzD1kWoxdmEyQqtQM9fR6dJzayZBNMvxJWN1fh7Cgxpw3q2Tpt0Fk
	mZ46oNrJqASJe8MMpG/tKRBi8wNjYIp4/pb5QhRDkw==
X-Received: by 2002:a05:6102:3907:b0:5ee:a6f8:f93b with SMTP id
 ada2fe7eead31-5fc4672b990mr559384137.2.1770715483107; Tue, 10 Feb 2026
 01:24:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 01:24:41 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 01:24:41 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im> <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 01:24:41 -0800
X-Gm-Features: AZwV_QjcoG9CiWLAoECcuSom742AW66cn1MYoa5LCvurXQpXj8_Zf65rL-o2nvg
Message-ID: <CAOLa=ZQeDTFkVjJcmY8VOeR_F1E8c6dcc+fcMbUdcWcw2DPcGQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] builtin/backfill: fix flags passed to `odb_has_object()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005e8a77064a74d3ad"

--0000000000005e8a77064a74d3ad
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `fill_missing_blobs()` receives an array of object IDs and
> verifies for each of them whether the corresponding object exists. If it
> doesn't exist, we add it to a set of objects and then batch-fetch all of
> the objects at once.
>
> The check for whether or not we already have the object is broken
> though: we pass `OBJECT_INFO_FOR_PREFETCH`, but `odb_has_object()`
> expects us to pass `HAS_OBJECT_*` flags. The flag expands to:
>
>   - `OBJECT_INFO_QUICK`, which asks the object database to not reprepare
>     in case the object wasn't found. This makes sense, as we'd otherwise
>     reprepare the object database as many times as we have missing
>     objects.
>
>   - `OBJECT_INFO_SKIP_FETCH_OBJECT`, which asks the object database to
>     not fetch the object in case it's missing. Again, this makes sense,
>     as we want to batch-fetch the objects.
>
> This shows that we indeed want the equivalent of this flag, but of
> course represented as `HAS_OBJECT_*` flags.
>
> Luckily, the code is already working correctly. The `OBJECT_INFO` flag
> expands to `(1 << 3) | (1 << 4)`, none of which are valid `HAS_OBJECT`
> flags. And if no flags are passed, `odb_has_object()` ends up calling
> `odb_read_object_info_extended()` with exactly the above two flags that
> we wanted to set in the first place.
>
> Of course, this is pure luck, and this can break any moment. So let's
> fix this and correct the code to not pass any flags at all.
>

We do pass the same equivalent, no? I mean `OBJECT_INFO_FOR_PREFETCH`
does resolve to `OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK` and
calling `odb_has_object(... , 0)` would also eventually set the same
flags.

I understand the issue, `odb_has_object()` should only take in
`HAS_OBJECT_*` flags, even though internally it converts them to
`OBJECT_INFO_*` flags.

Wouldn't it also be nicer to convert the enum for `HAS_OBJECT_*` to no
longer be anonymous and use that in `odb_has_object()`?

The patch itself looks good!

- Karthik

--0000000000005e8a77064a74d3ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 353fc946c0585936_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSytWTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzd0Qy80MDV2UEV3eW1Mcjc1dEdFMWIxVHIzNWJqaAorZkVnOXhxa1d6
NEpkcW9oRFQ1WVRDdjFxV3B0bWgyLzRXNnVtdTBhMEoyNnhVQXk4SlhVQnRWVEVrRHREWFZFCldN
aWxlY2ZiR0NJclA4SStvczkyeXFndW1iQ0tMWGF6RnVDRWFKcmtKTUtyMTR5V3lueEoxdU5jcUFJ
NS9zczgKZHFKU2dVa3pXVDdZcUphTmo5RGgweStERi82VlVoNUJZK2ozV3NUbng2KzA3bFQybVZZ
M09tNktaR0tOUlBPTApaQzh2RDAxZE9JRTZoNjJjQ0h1SmRzY25OWTRwaHk0U3Z0N3lMZTh6MUlG
QktBcDZ5RVRDMVlHYk5BbTJTNUwvCjhLTjRIcHlXbGg3WDFDUWVsblpCVFlkMDc1TndOY08vYzNv
d0YzR1hsRjI2S1dyeWdIbmNQdzl0Z2hnYW1YNjYKMjR0eW55ZWpSSDFyNHhqdDl0SUU2UW5zc1p3
TU1waGRFVXNFL0V3Zjg2T0RNcFZKZXB1dFdnV09jYnRaWnk0TApJek1HWmpEOW1aaWllSzVFVzVV
enBqNjlwL09PK1ZBbjI5ZUNtM3pDYTNIRlJtdU5CZXBDb0xDdTBKTnZYdS9xClBGK3RTaDJqVmpY
bFRwSjBzNVhJUWRMRk8xUEJLV2d5ZVdCT05lND0KPS92MncKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005e8a77064a74d3ad--
