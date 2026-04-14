Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1F35DA4F
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156319; cv=pass; b=Iyg7yx7g3GGaKysO9+09yNPTlVoBTSrb+InT0wSGZblgGfaHBkF4Zic96F/dAJM8YHnjyZ7TgOhWIcyAAx9RgTdUUlZDa6hhR/MdWAK66/DmDh9uIVV/UfcPhjnDGl0P/h2tM/K/40ldS4gNVKVDc8+LnbP4M6GV3Oxi42jzQj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156319; c=relaxed/simple;
	bh=AJUccvKdEQkwRju9DxDUITzQmNRrUxOxNTXl+nCibFE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFCxbeIFcXrhHarLFXwDft5eRqzH4Gv/SjEL/soJwJheHkp1hB+F0XjFZrcp7u2zNuVk/m7Eo9QOnGRVBm3/mxDZgZZLX3mEMA3QsbVNIoSqUTDDyQHlJpTiKC8dMH2SACEwynWu7e/Eye5URd2OqzY4ze28D7VdTVSVCpvyBs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL4Wckp8; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL4Wckp8"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso2965646241.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776156317; cv=none;
        d=google.com; s=arc-20240605;
        b=ad7MEQ+ytEPt4kzGVxwXhTWMql/1ku3/KeiNp8iEHJlVahVe1h/9ibGCk78Ksqc8eJ
         RZVn+WKSlgrWZBBH6nAHGdMzJnw0KmwbriKtGmnc31rGRm2emfUoGY0h8llBI6Y90bAE
         2EProkEZOnomV4R0tiWYTpR9dhlnV224G1N8gvv6uuYfh/OAWFwA6uilNcRagqLlcJ+C
         KMBaU6kQWenOc+cjjNpdKvsobt2oPLf7ps3oS9ciITIOiBGUThREluAGSgcF8fN4yWG2
         LS0ttkmNcBsMYeqaimtxYkRrex71eaEQ2lreAS+wMkT+U27FK6wFgBWmprMhzxMh+84+
         kBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=AJUccvKdEQkwRju9DxDUITzQmNRrUxOxNTXl+nCibFE=;
        fh=FVxL7Br9D6raqg40xvxSjkHr8mBJw5tMzAJR9AXuiiA=;
        b=BCZnL4EhblQGM0tixkqQthv2a8i7ZxjGBFTv+5whe6f41BelmynJPJHZlSEbzRucEp
         BJcP7BWIHpx79vQjc2wCO9QeY2KqQ8T66SlBn4omBBI3Py0wcT8EYPcwxgQ4XAZlxLVx
         weF5uQt6Wt4g7SmmaKnaX2WZP9ORK4iGIqKiE8bbcm6tzXilQU+5tkJKB5neDZOHlgRX
         uzPshZ0hyNBlnWVg7cIR/3huK6eXer1hLfeuCwh2lE6hFpa3eg3M20qX2n50L07pDhK9
         HmAiiPrZeW0COX3lHSjyrDgytTXs6dDouAipHH/1jLLGwQ5mCh7HqNwnQaG/S9+0jWJL
         qr+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776156317; x=1776761117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJUccvKdEQkwRju9DxDUITzQmNRrUxOxNTXl+nCibFE=;
        b=kL4Wckp83YBJN+kD36qDVksu4uVvRHy6gmXurqpxlEeMQKuQqB71bw0yEYbBBzPOLv
         R51N0FazRLA+Fagy5f4zxLCBV2Kdeh4zbibUv+amzcuQ5VTM1F6AodviWZThz1Un4N8W
         Dc58bbxGelWvzo0ZvuiXJQnO8aeHh5V0EnaSe6xsRPfRazZ53rAJrxF5BgVVUlaM2s/W
         MA2wuzED9huC4i3y7PD4ZeFZffm3t3RVjFgsbp1kiPfSKiM3DZ5EuON5oh2rnF1k85iH
         6QAaqMChBCOsVQdbke62MhQw5bYuvRVOzFgYl8oNSVNE+1ILys5JWQQggmTQ1kKYFRC/
         ASgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776156317; x=1776761117;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJUccvKdEQkwRju9DxDUITzQmNRrUxOxNTXl+nCibFE=;
        b=OAxPYKy9b2etqwBfuGI4e7iNuY8Qico2ngXWusbUo5JrB53KPpZKgiKNstj0w+cy8Y
         B/e8g8+0Wa5BM7jKskWgPsrdlOft1cGKCkvXsyipMB3mKFiaU6Ps3uX/ra1owqfzv13p
         ZCYnbKnoX84GXfs2HFUNFuIov8vwZW/b6vgTlqDF0PPwB/MXrRn8EI6ySNJHT72gJ9ZA
         M2HOyU0gLUkB+E0r4u6AiPHCyy/v6jk2vpx3K+WMTWj4GfIqUWI7W1640AQVcj2WFp6D
         SZ+N3bYUFUwy2M8qQCaH/dj4n/zUUA7QhCUgMsghvU13LJ/KWKMSf66eMmmOovL0CNZQ
         WaMw==
X-Forwarded-Encrypted: i=1; AFNElJ8HOcTY59hjyBGzL8jelOhTp5ftG/6gEdXj+sKWzYOVxwMYKSGR7ExK3ePq1lRpPC8REqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDgzfPGEu629GJ+wJl0nxGpEVcnyaSAmM6tj13Cpz+obFHUw1e
	n0SKr6RznExoXB4gjr91mlLpcw9f2/+/zP/Ljt3SajqZSZ9WOKA3NqTkpCOQpFYlf8VroQ4LUYu
	4WP5q1cy62F+9WXXTW4atLNAccAFNny4=
X-Gm-Gg: AeBDiesKsQQBzfewIXi46FlDj+4B+xEpA2xHLY3pyohNJ8f1qFmlaxirPxfRaifO5f/
	Z0+uqCwOkuyz56EOPlkX2rPvfwT0b46yLi6OZzdN5D2vCvCpdLIXVR4EHWIy7erMHdi+EMczzog
	VnBB5IJYUfu5nT7v7Tk256l+4hoduI0BRBG8ERS80P748BqipbP8XGa4Ac5cPqDjmx5+j3nsrv/
	cyIT0ozz3r3pQ1JHgYnYXGm/xpoP8J3KrTG1LvCZ1qFtOUf7QV/5HahCj+w+PmguOaffG7/Np6Q
	HbBaZPGj
X-Received: by 2002:a05:6102:8016:b0:605:26eb:cc15 with SMTP id
 ada2fe7eead31-60a272995femr7874472137.32.1776156317203; Tue, 14 Apr 2026
 01:45:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:45:16 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:45:16 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-17-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im> <20260410-b4-pks-odb-source-inmemory-v3-17-22fd0fad58fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 01:45:16 -0700
X-Gm-Features: AQROBzB9UacaLWHUgKvMVHjzAWU-MMpg7RhGhbaX-UAfjJ0-otg_xzJem3ho-bc
Message-ID: <CAOLa=ZQnrtU5MP-J2-8rffbBacSUbm=m503k_v-TYSR4Qy781A@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] t/unit-tests: add tests for the in-memory object source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005a6e7d064f679e59"

--0000000000005a6e7d064f679e59
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> While the in-memory object source is a full-fledged source, our code
> base only exercises parts of its functionality because we only use it in
> git-blame(1). Implement unit tests to verify that the yet-unused
> functionality of the backend works as expected.
>

This patch seems extensive and good!

Overall I'm happy with this version.

--0000000000005a6e7d064f679e59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b4739a65c025e2fb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZC9wa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUE5REFDQXh0SXFjN3lMRkgxQzVMNnJoOE1rUUEzdwpDR0dCSzJwbUQr
RXFvYlcyRTZxTU03eXgrVHVUUzJNcG8rUDZKdFZ1Vzg3aXVld2RsdURXaEkrYVRDdW5meTFXCmxN
THhVd2hmREdlYmJsNkVNeGNlMkFYdWVxQWl0RWdEZ3owZ2NZU1l1cGF0V0dwVE5qOWo5RkxNa2lL
amV5N0MKaUt6S3hjUEZUYWFoM3BFc2wrZHZ6bjhCeWIybktEcTFvUjlWNUVINzdMdDllYnJScVdu
ZlZCaEpPUjBBWU1NNQp2NGlLVzZ3Si9obGkyVURoamdON01teGo2ZVRGR2VnTDlzRWVMU3cySHBE
SmFBQ1FZZFJ1R0RyTmo2M1lzRTlJCkMyOERnR0xuanVTeVZvaXVlbXE1WlJpbjBtWWRMS0EwYVpR
bUl3My94bEt5UmpZSG0vVnRGdnhObjRNUmdtVUkKS3kwRThwL3JGQUdNd01oNCsrblJPUVZKWVl4
UkR3NUNKeHRKcXUrYVVrejBvOVN2RzUzUTZlMjFubmlRNU05Qwp1UnNoY1pReFZmWlMzcTMrMXNX
UUtDcnBzOUpIRUc5UDg4UlBhYjFINlR4U3BnZkFNTitjNk96SVNKSWc1RmhoCkFxdGMyOEZVQWwx
ZGxlLzlibk9RbWlyZjBkdTNSSlNWSUlLc0hRYz0KPXpucWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005a6e7d064f679e59--
