Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621622500CF
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042908; cv=none; b=GIXOv10cp5vGZrrO5kS/qSBlvzOLfCEhK8poxhDWeNagGUc3vQgFKEYJ7Kn4I3+yCBIdHCcy7vqdDWoVM03P57hl2zvHnjq0y8llEkJ7GPPtx3Qv1Vs2rnJH4vfOsS3/T/tCrkzGNzZ9pRJ7fxaC4pIJZtldjW2OjMAwpJh53L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042908; c=relaxed/simple;
	bh=UtPoBDwLGpksqNJYniYhLT6O034VrpFS9Qh+u//9TuQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQrGrqk89kFLxVDsmNqbF1MQ4HZD0MS/oLiNLHgrd5HSr1oViv9u5/pbGPom56PkXZNwfpSzjdPo+ze6x6GfpD4g8xtmtLN5wERvJadml0u689jFMq3KoZEnXr9s1djPdDvnaECbuIHRcagLg+Nz9gWBBHLjO+DQVjXLUc+jBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHK9nWkf; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHK9nWkf"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72b7a53ceb6so2603745a34.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747042905; x=1747647705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xy3xJ0wtGtW1iBl4qiht0Cq3bCOTlhewiLxoUjtRhM=;
        b=gHK9nWkfal6bF7AZ9XjkC/3YvhP+9aZ9brF4av6SyFhdvlN4xxg1OsfX9ZVlI6jdAj
         v37Pm6ntM8IdXAIoOf2Im6m02OHNiMnLVrNYSJuYj5KC3h+7b7CzEW8Y7spFa+kerUii
         dmcDdpIjq0Ztf1iVDSwv3tz0Vgv758CXqvdCBdL5vFBhzBEbFe/bAzYtLu5ohm1WhiOo
         pk9ggHgYucE3pcKmLNLcky+b77XCIX2f1cHcSSF6nSqQrmeoy87yny3iOtJJVjy+NYD/
         oLr0L2yuEs2dRXDI2pDal6G97+N9Ocr6im7jK73vuEh/sPtoMkFYduzMSTIHcb3SX8jp
         iszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747042905; x=1747647705;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xy3xJ0wtGtW1iBl4qiht0Cq3bCOTlhewiLxoUjtRhM=;
        b=VaQahq1dttT0OE/VL1gv3Cfr2j0/SMTvCuvKfXcrQ3HP708ry4RO62KC5e/nMjvAnG
         CN3ZsXpAZ6kYYJfH+JIEirCyyep5FaNBU8x4jjxgV5UFtxHfClDDRPcRXGcyv3I92Wfa
         G4bua4TBxvMMDKQozbUOtKzS7QoAsY+I2mfEX7jutqtuEmYr04va2yScjXO38oZwhgIT
         +FcDRTxGlRMHwfNHWPYN6nfbFVLIwQsiRG31IuOTjQhWGNQTj0i9ZNOYD2x21dh9qH/F
         XERgt/eVVteNLmc2kdqhcsxE0DtOqhvPoce6Nw/+oXKm/P4AMhikJ5Swz6uc1Xzq7jEg
         wULQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvzzGV1Hy1+omeCquY9ta4aH8S6DXm4t/Pkwv1ZSLWpMnk/YsNei5sclD/XGM0V9kzJZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6nVCZjSFc/RlU3jY5EJtk1fqltS5b6E9TEC7/6Nkhmp/tPy5
	7mOfgUNhSPboDBEHO92hAT7PACQBMFV706TaE5OYSOuLVBrGl/sI6688HSNreFt7l/Xxv7JpNor
	netxE4n6xZ7a7ETX/ftMxBm/5kgD+J34u
X-Gm-Gg: ASbGnctkMwyzpV2+MENRrh1tqbjvZbumHTvkmqMXZf+6anecb8YA8M3LEhXclBpk5wd
	4XPrJ9oExrIi2VqCd9OJ8QkVTCySP9eXD4N4/FzGGBTXltEF09RiUcICnxDRjZQmSJqUikT2klL
	XN2Azu600tPt0/M2xGP9ZTSKAxbhkEMkiwX8n9zw9UIeET027ec9VevtqEXxu2fGJtOULD9VT9u
	OIy
X-Google-Smtp-Source: AGHT+IF2w7HDfH//+vpnOR4rHjzUT7ctYa1qPtSwb45I0coyTiqmA1p3vDbT+85m/4RaElzoBaG5eKy+ER4/BHsyHvc=
X-Received: by 2002:a05:6122:82a6:b0:527:67d9:100d with SMTP id
 71dfb90a1353d-52c54c9b8c5mr8256112e0c.4.1747042894430; Mon, 12 May 2025
 02:41:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 May 2025 02:41:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 May 2025 02:41:33 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250512020935.73140-3-lucasseikioshiro@gmail.com>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com> <20250512020935.73140-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 May 2025 02:41:33 -0700
X-Gm-Features: AX0GCFupqkD4HhacjswAYKLcLSzwHs4iUPzpXnDFRPgJTVzpfOYvZQ5izEwXwYw
Message-ID: <CAOLa=ZQooC0TsjGG109MY_njoTm5GjW-WNf7-L2W6BN8umRL2Q@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 2/2] json-writer: describe the usage of jw_* functions
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000002162ba0634ed1f77"

--0000000000002162ba0634ed1f77
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Provide an overview of the set of functions used for manipulating
> json_writers by describing what functions should be used for each
> JSON-related task.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  json-writer.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/json-writer.h b/json-writer.h
> index aa513e86cb..8b7470af67 100644
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -28,6 +28,34 @@
>   * object/array) -or- by building them inline in one pass.  This is a
>   * personal style and/or data shape choice.
>   *
> + * USAGE:
> + * ======
> + *
> + * - Initialize the json_writer with jw_init.
> + *
> + * - Open an object as the main data structure with jw_object_begin.
> + *   Append a key-value pair to it using the jw_object_<type> functions.
> + *   Conclude with jw_end.
> + *
> + * - Alternatively, open an array as the main data structure with
> + *   jw_array_begin. Append a value to it using the jw_array_<type>
> + *   functions. Conclude with jw_end.
> + *
> + * - Append a new, unterminated array or object to the current
> + *   object using the jw_object_inline_begin_{array, object} functions.
> + *   Similarly, append a new, unterminated array or object to
> + *   the current array using the jw_array_inline_begin_{array, object}
> + *   functions.
> + *
> + * - Append other json_writer as a value to the current array or object
> + *   using the jw_{array, object}_sub_jw functions.
> + *
> + * - Extend the current array with an null-terminated array of strings
> + *   by using jw_array_argv or with a fixed number of elements of a
> + *   array of string by using jw_array_argc_argv.
> + *
> + * - Relase the json_writer after using it by calling jw_release.
> + *

s/Relase/Release

Overall this looks good, but I do have to wonder if it is needed given
that your previous patch already has documentation for each function. I
think more documentation is always better, but it shouldn't come at a
cost where we need to ensure that multiple sources of documentation need
to be updated to stay consistent with each other.

But I'll leave that decision to you.

Thanks for working on this!

>   * See t/helper/test-json-writer.c for various usage examples.
>   *
>   * LIMITATIONS:
> --
> 2.39.5 (Apple Git-154)

--0000000000002162ba0634ed1f77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 20e2dada6fb237d8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1naHdrc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOG5sQy80djcxbHpmRThENGJRZWpYZTlUeWdBNTJZUAp0NDdVaTZFZ1lN
UEEzdGpmaTI3STIyYnJNL2NudHhLOWtiUGRXdFJJYVVsVERxVlNobDV0TUVOYU04a1RXbldVClBi
SFp5b0oybHdVc2RvVlBETUhwVHNRSFFZbG15YzRPZ0xCOFRPY3J0T2FtN3ppSEljTUppWnlUeHBm
QTYrTUIKejVyb0VnRnF1ZXYvNE5rMkR3Vk5na3g4V0FTSEZ5eXgyUEVhR0w3U1NYZTJxM3NWRzZY
ajFxeEsyMDdJOHFaMgpuZDY1YjFuNDlTS3hBN3ZZeVU3SHJtbXl4eVZiRzZDT1pvOWYvL3pXb1NT
TkRpcldwZCtUNzNLQWRaSnNvbXpYCk42SHJjckpvdG1pUk5yVzcxMit2clBmMDZKYW1FZmpZR2M2
ZE93LzhaNHdEeHRpY3ljbXZWQ2xUNy9NNzRtUSsKbml6SEhkRmFRYXBZRG5ZaTVaMDl5MUZPRGNR
cFFsME5BSDF4WjhDYjRxNHJJd0x1YXRYb2NFUmxrcjYrMHIzWAowOW9UdDV0eXRBWUpuTyttcTRY
aWUwcVBPdnBIM001OVllTlJwTzdqR1puS0xHeUNFV1NaazhQVU52UlRRRHNyClJGbitwa29hSzV2
V080cGIvcU5TdWhjcVhzdXhVRDdyYlRvSjQvND0KPUl0bWkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002162ba0634ed1f77--
