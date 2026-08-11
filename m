Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D54052D0
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441902; cv=pass; b=B4E7Zl+DxFPmVdDjjF3E6UCte/E946WM0SgqXwG7Oz9EE5n9S7KUXf6KISe1vIwK4+QAKhYE68xdPBQLN7OyZjoN8mT9zJsTRnPund5FkbXkTnB+ZBtOC+XF/mRCEY/B2TB+sZ7fyus0naMR+AOYJbKLHU+PAHCU7/wLijy2FKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441902; c=relaxed/simple;
	bh=c0fsPgjMc123BoEjBuZ3se92qSGxedYfHx2Tear4VMw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhuzZkxoX+qluZdHXlEGGlHwuW6kqd1ExENJPQJDbKNshyngibXDY680DwkFDX05DJrNecEBscc3Tf3EDtMm0GjiNIj2qEsabZq4nBY1PZTMTfI6xe2czKOM7wcmtAJzZudQ42XjBCtPpWEdK5kYxBZCMfATU5M4jC10/KvDB3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4Dg9/1H; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4Dg9/1H"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c3fabe908eso175606e0c.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786441899; cv=none;
        d=google.com; s=arc-20260327;
        b=NT17tEwKp1t6GFzQL/ove+I3lz3cAkHoPdONv8Av05Wg0J1urLUL4eCsqsB7SpSJWo
         +lfO9cpPiP2iAYeohjkdv4kZbOJKHrkZDOrfM7OklJp1bgO5tXLYnqCPQJeBiiaSDFrk
         R7nRLv6CdYOOQu2py2cG9MIx/2yOMU67QxBjIMaNgd7EIdSx+tPx9r095Vz6mnCUJvqn
         A90t1NhL/kFOYHW4vvpxL9zcGwoUpKuvS4dfs5lIIBj/q+DwiMjC5aaEEjGk6FkSdOi/
         ypTvWyyDlxlOTKPs3+ZaLSzruX6Dalc25PHbSe+0Rb38XvXgxlIYBnAw8l+3uYw3BRp0
         UJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=IgGN61JlpqKj+CNkfImXMg7BxyOAZLtrQi8r/+ig1HE=;
        fh=P5ztB4uqeh4ShOoL2vKFmnO8dGt9mUBUXB+KdCHlsL0=;
        b=fya+1YQi4X8CbejfypwjJeCO4wSFnCqVqXdTvijxH7Cp7RToDkJvA99inQmLDa2GOA
         CbssKV57g2GWlW97bAuTdUwy8xwRhFXwYsvhjJCqfE8B6n9Xjlj4HrqwwKrpH3zEsBGT
         JE8ifdZUqfLr8PneHOF+59RLrQd9Hm3uDuHu6uP71EnweHd0rDZdkxAC5FAvcD+vYxVG
         V1WqyhoMQMGVsHuTB2q6oZfCWwsgI67WADugg858ivsJzyIGz0d31p0iv6z5uRjYRDAj
         1mKG0Tp5TxxV40L1ba19/UfExvWlUggWHmG1PExBP9Su7J0bb1F4skB5VD5e/u6tzp+c
         kOkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786441899; x=1787046699; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgGN61JlpqKj+CNkfImXMg7BxyOAZLtrQi8r/+ig1HE=;
        b=n4Dg9/1H4N//lkxbnm4a8w/m5wDBiIyHO0ylTxii8o/tCh8QPf+q2HaTOhbd2LePzJ
         nqzTBuH8ayfDpypjCOzcY5/B79SwXXfpW3Po0ulL6AQhXe5I0YM3kBfAld9AehpIDdn/
         FVYS/yNKmi4x7v15SsXiipwdOcKRyWTJkVefB5BF+ZpnjsQD3ZX7jjCopcPF3fP21w5y
         bpyJJH1+i45wPsSoImBDguXuucB2mdepECaEvUqdA65uals6FITOjs27lyjd5ywP/KAW
         cIf/Jk1OBppajRbaFw9WCXBfdqKjTa0pEbDzdsaJdfxdiQsBDqO0SIp3B9pMaYAC6DTy
         voyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786441899; x=1787046699;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IgGN61JlpqKj+CNkfImXMg7BxyOAZLtrQi8r/+ig1HE=;
        b=hm6SgOecVYhDsHacnMcv6E9+wMDLAOv0f4MvdTX+cbOfgGY7du3zHgfDxdjuU7Xyhj
         VvuL73UQN0r4nJRwkMkSDwpRxoeH/BKn3gkQuD7PUYAaqWhLyYEsG5v0iPW+YMFn/O19
         phjB6aU0nKyyPvz3V/QCbf74vrfY8MRcPqvx5Ip3mmwi9jOZI+V5M7kgKIdVQJdbfIwL
         oGZ31npg5wKJjmN5y8Z7KdA6YS118lPnjTzdj23poWt1C2du/y/oK0xD0vdYes53Z8Y9
         kfZkqvYUDy1GYucig1vvxgU0IZ1FO/ZGE9eznD+ZNKTLDqepg2kYbsPzC6plpXPyfKHs
         R+XQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDwaEr28WNpAlyd0ZyajqstCDvnBZ6f6Vm3Ss7PBHQ/6p+wPnKK6/WBqfyJxcDcvLFHeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9AVG8kyqaMn1BSUYRMZDNo1h9nRQ8Wm7Z3rz0Kf7mBfOPhhG
	f/SOjvAZXOqOu6suWJQdHOc78TURjLK/hVtrxYdSIx4IdeR3WT9PtsYA4sspZOIaWyjr9v103RP
	g0j/2WPqfCtXGe57vG4P7tHOCduJwqL8=
X-Gm-Gg: AR+sD1301JlskW5xkc37wlipPPlqmLdoC3GUbaHCzV8Zs08lNc9m7FyOrcai2jy7u8j
	E/qoEganA52QmK9pUe22ydeSon/RoKDjwzsqMXFkf/vMpWEmG8Lf+KmvHONTBOJu6UhwADR7E7J
	5UzFPf4N44brSvujkubI63byOH6tx4tRNbhrER/ViNtbmO0JPBbLxIS9Pm4ktDp6AQmJNd4kv4x
	Y+Ji0lujwYTujw4FAHw5RgXrkYmhdPcyGozYoT8eGpj5YqjrTmH56UwLZWc6IWQDLMFJrS0qvWe
	hLFpcQLLwlYpDui6Nr4f/g33OzNd2czSgHRoxefQXNndhb2TvPnn7DNlmHizFhXvRFtyoiJYypc
	9Cna+WUEzWZwM1q4QPt33CBRSbXGdGMAXZco3mtM00hEauA==
X-Received: by 2002:a05:6102:4b1c:b0:738:9bf0:f80c with SMTP id
 ada2fe7eead31-76b576c23c9mr452273137.9.1786441899492; Tue, 11 Aug 2026
 02:51:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 05:51:38 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 05:51:38 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-1-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im> <20260805-pks-odb-stream-unification-v2-1-b8c369564641@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 05:51:38 -0400
X-Gm-Features: AUfX_mzOPOMCG-CqWA7LVV5YoGYRTTt-TaIRwLSgOmvwVMqkmZGmttfNNNDln98
Message-ID: <CAOLa=ZTHaiARd2F7BL+uwN8ANNb6=ovfZ5v4=dMkgCY=N6qa7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] odb/streaming: track write stream size in the structure
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000d4e2a00658c26a2a"

--000000000000d4e2a00658c26a2a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When passing around a `struct odb_write_stream` we typically also have
> to pass the number of bytes that the stream will yield. This is required
> because the object header itself contains that size, and consequently we
> cannot write the header without that information.
>
> Move this information into the stream itself so that it becomes self-
> describing. In addition to that, this also brings the `struct
> odb_write_stream` a bit closer to the `struct odb_read_stream` so that
> we can eventually merge both stream types.
>

Okay, so this will be similar to `odb_read_stream.size`. Makes sense.

[snip]

> diff --git a/odb/streaming.c b/odb/streaming.c
> index 20531e864c..38c2f6687c 100644
> --- a/odb/streaming.c
> +++ b/odb/streaming.c
> @@ -336,5 +336,6 @@ void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
>
>  	stream->data = data;
>  	stream->read = read_object_fd;
> +	stream->size = size;
>  	stream->is_finished = 0;
>  }
> diff --git a/odb/streaming.h b/odb/streaming.h
> index c023671780..4d7d31b5aa 100644
> --- a/odb/streaming.h
> +++ b/odb/streaming.h
> @@ -55,6 +55,7 @@ ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t l
>  struct odb_write_stream {
>  	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
>  	void *data;
> +	size_t size;
>  	int is_finished;
>  };
>

Okay so this is the main change. Looks good.

[snip]

--000000000000d4e2a00658c26a2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d94e1912aa7855a4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wNjhLZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFJZQy85MkJuNDluOG5PUTJmRStvTklMWFFaREtXWgpwMmJpakFCM2Er
Y2xzQldCVTdMdVZGNmNBdUhGSHhFdUlsUVBORzhnWVhpeGJ5ZTVsWTRMQnhtMXBXLzNzSXVpCkpC
OGhGYUcxdk56bmlqamZFYUtrUGc0MXBwM1RkaGlqV1lPbFdnd1FROE1MdUVsUklsT1cvQnJVOE5n
Q1pqdXAKQlhldnZUSlJMdncyeWJUL3ZpM0hDZExRd2F4bTJ6VlJpTXZaN0dSOHE4MXVXME11QlJW
NWQ4ajdyUTFrZFIxagpiNVZreTJ0OHc0UUM0V3h0QWtONUVocDgxZGcyWnFpVWg0VStTN21abVhz
cXlEUTlNUXRTczJkdVpHQWJVNWFoCjBOSEJkRFdwWk4ra1lRekNGOWRKcEk1czJFbXBRUDVBZWdi
d3VYQXNqRTNJMFBqaEVjcG9xblNmWHJYY2hkTEsKVFpRZDdoRzdzVEdpQ1pvRTY2dTFXVDZrVDZR
R0lrTGYycHJJdGdKMjcvNTlKVnA1UUV2Rmg0MjhtUUxSR3JUbApveHVoWkZSb2V5bXdVZVpCQ0Fn
V2Iya0lHM01HTnlaRkdYQkRoVjQ0MzZMMGFnYjgyRVkxTTFDdWxCZDBWWlNBCndYaWNlWEdaNFpW
aSt6bVBleWVHbmFpYlhFMjJtcitPTXNhTUppVT0KPXlYcisKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d4e2a00658c26a2a--
