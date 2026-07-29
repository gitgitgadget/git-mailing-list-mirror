Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADCB47CC9E
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326881; cv=none; b=heGVwheiq39TcqzvxuXvr+VNvNFVRZzW6Xhe3xHiCVuOTKE/1ADUIWr36lC8TCxyoJfJCnfh6bGG7k9Qd/5BJ39h1kvcv2c5zwlSzG4fJmLzgl1oZjZZc/ruBvQWxyBeyI6T3pBvOORX+4vFCjz9oORAMJtf961saKOqXOydrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326881; c=relaxed/simple;
	bh=fSz64Gguqh/NICJQo2FVhNDNM/rrC/IMESjCVE1sV/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=tIp55IYgrixCYEJZ2Emibq3t9p3IYa6VcubjlKIdIxpYthA4NmOQUX7GWan9SwV7S5ir2DlpWw5B8RYMNZU6av/4apysLbiXNyN+vZ0yEdD07HVeNaQMSow9+vBlOlovDT7vaf/jYwYulDYonpdZZMrvUZ/FcUhvmkrlNCvs+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVJ/MuXw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVJ/MuXw"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f71156e1aso491908f8f.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326877; x=1785931677; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H3xRV1n5123gvf6MosLy4rxkuhLHhqU5DN9+kcntMGY=;
        b=VVJ/MuXwf6jZvI3fJBf0Jk4AeMOZ6uLB5ybgccYYDEw9IbE0BnfRQAJUggQkgEm8B8
         NJa54WGLj4J/Rzx+S/TxV3E5em71QuEA5jnO//mG70BFswb+EytdcDomr1j7HpZCnj91
         HRnq0bsu1D35tX7fGAInp0cxlw/YnSV3kyJm12rff1KfmF5V9jOjZDcu68J4GnIZ5ZvH
         qO1N1tl2TiowplfGvSV57JhU1do0POXcNwmbQoyWkMYCbEwqyYvoA0yqTBRJg4Wa+FpG
         Lw2MEuaNKrl0H5cyXcqKoSmyGJF4VDDwiZ80A356le5j/Y34UaGQF0ShehnNw5yxWgUX
         CZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326877; x=1785931677;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3xRV1n5123gvf6MosLy4rxkuhLHhqU5DN9+kcntMGY=;
        b=RG0tO4ZfhMaA1b5aYH8u7LryzUq+5SkMop3PtPvMHPVGDki3HTTnXQkfWkmkyibiIC
         1eBvUyAE+TZrsMKvJ3/yN9geoA2VnFMEk6nxFsWsAB9WOhhy3pSHGIj9GmDrId61b7Ka
         M3qDs3OkqlS8t6dbxhosYdJ2WQS1Y5WnYZsHRnSmBU18cnDwODX1+TE+TjBfQbnqhLmu
         b1QSGDdK6f6fKTC8JoVp/AWBimf/Hbd1wZPft+dKTmGkdxf6zZIgdDDSSXrj7eBwUAm7
         tXAfQ3SlbIasurfs1uzKzwNokxRMGMtPupq1RMBWagMo/+KNxwdMWdyOtXhfwYWLUF5u
         R4Cg==
X-Gm-Message-State: AOJu0YyJM6FCgAfP3dB+KFYlm3x1ry49oGfK1mGNOsdvtsJDvYjP9psN
	+Yf6mMbfgC8z1tB09imjsxURt2NAAxWpjHzHuqWKQwD6WKBx8xOP5xDT
X-Gm-Gg: AR+sD134tEkAS99+uuY3rnFCO149P4W1YNYv66mj1UvMFg+v1aeFLW49C3Me9W0pc0z
	CoVpFvOCQsAbP9W+tTwoyXb+4bPjccptzhmxyMjbsfv2HIFfn94EXpsak3xfYkjG98LjjcDLj5G
	FtqUDK9xf3qVVX/qFy48KOFfjrva5ZJURFbeLERORV9G1MCAyTYnMxO1y6KVa4ohTvSUPOrCCQG
	d3QtkvhAUN0Oy90m3Y+S9cyh7jfX0+xxp/aIfobJGV641L4ASD7d1X3+T7q0qfPh+ZoG0H9aqb5
	zcJ+/8kz0XnJ7k088xqFqpweybUv+bro6XJQ2WIaJRtNeIIkZ4BOpOkU/bl6MS+g7FRtZ5LPz/K
	SKVMflgWvIjoBvbp7Yxkqc4f1LcnS24fqYzFhdaJpad6H8slBoNHWD4sNbFE/oXEFbyjcMf+WSD
	lWoGRCz/UkHI+OniNsns15wHFdUHNEiclns+4AYZGeK4y/Wc/wiTz5H8JVZX6wceixue/kUzxPR
	uLEAkmzUVVSEzWTHp5pZPM1tiPODaUK0RuyagqYFhMQuK+5EYhzZieX9dAv2LdGL/nrh4uHy8r+
	FJh95WNhIbsNo8UIjRCbi1fxIkv1/zZyntorHT6133gCFP5ZD4eGRZmvUhyetaP+DQ+F2nZJKkU
	=
X-Received: by 2002:a05:6000:29ce:b0:47f:b452:49f1 with SMTP id ffacd0b85a97d-47fb4524a45mr3999064f8f.2.1785326877416;
        Wed, 29 Jul 2026 05:07:57 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6acb6c9sm8347367f8f.13.2026.07.29.05.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 14:07:56 +0200
Message-Id: <DKB1K4BKHK2G.2HZ0HM22UTWXD@gmail.com>
Subject: Re: [PATCH GSoC 3/5] fetch-object-info: request all supported
 options dynamically
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <karthik.188@gmail.com>, <gitster@pobox.com>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260725-objecttype-support-v1-3-2d4ca3bbabf1@gmail.com>
 <CA+J6zkQCa-rCJYQgfsjLyyJqrW+0-Z8pUJ4EJxY9HSTkJH=u4A@mail.gmail.com>
In-Reply-To: <CA+J6zkQCa-rCJYQgfsjLyyJqrW+0-Z8pUJ4EJxY9HSTkJH=u4A@mail.gmail.com>

On Wed Jul 29, 2026 at 11:57 AM CEST, Chandra Pratap wrote:
> On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
>>
>> In send_object_info_request(), size is hardcoded to be the only option
>> sent. In order to support type and future capabilities, replace the
>> hardcoded size with a loop that requests everything on
>> object_info_options list.
>>
>> This is safe because the list has already been trimmed previously in
>> fetch_object_info() to only contain options that the server supports.
>>
>> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
>> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  fetch-object-info.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/fetch-object-info.c b/fetch-object-info.c
>> index cf6b94afb8..e5cfdafe68 100644
>> --- a/fetch-object-info.c
>> +++ b/fetch-object-info.c
>> @@ -15,10 +15,13 @@ static void send_object_info_request(const int fd_ou=
t, struct object_info_args *
>>
>>         write_command_and_capabilities(&req_buf, "object-info", args->se=
rver_options);
>>
>> -       if (unsorted_string_list_has_string(args->object_info_options, "=
size"))
>> -               packet_buf_write(&req_buf, "size");
>> -       else if (args->object_info_options->nr)
>> -               BUG("only size should be in object_info_options");
>> +       /*
>> +        * The list is already checked to only request valid and support=
ed fields
>> +        * no need to check, just request everything left on the list
>
> Nit: ...valid and supported fields no need to check.. -> valid and
> supported fields.
> Just request everything remaining on the list.

Ok, will fix it, thanks.

>
>> +        */
>> +       for (size_t i =3D 0; i < args->object_info_options->nr; i++)
>> +               packet_buf_write(&req_buf, "%s",
>> +                                args->object_info_options->items[i].str=
ing);
>
> Perfect place to use `for_each_string_list_item()`.

Didn't think of that, I will change it, thanks.

>
>
>>         if (args->oids)
>>                 for (size_t i =3D 0; i < args->oids->nr; i++)
>>
>> --
>> 2.54.0
>>

