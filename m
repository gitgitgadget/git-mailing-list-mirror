Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2418C336
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338639; cv=none; b=sk2yjebTWXeVrj8BsmjYzuGEKiRZX8QSBlUF39VaJYGVCQxsWt+BFBuOXHZ/nIJr0bYwDlur8uWvRfP7Ta5BgLr+8rtpZhDHgQbHwhQxsVZNR7yNJgx2YoBv8Qk0IbrA75utMMLmmCa7uBjjfyGcCYh1YjFZT7W22QhwzjjKmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338639; c=relaxed/simple;
	bh=n1rljVErqXc3UO1mUqGHZWE+QJCuNR1+RQf5/V8bvsI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=bu0CSysESH/+JF80rlwt4T50FYs7Rz9IDb9J12XrHUBeToKz6X7vqQLKjiGO5+XVsGeEt7bgged0jM/mFRTRDS44023GsIbqa8N//4t1EWpvYdGwnP6zhnxR/V+IeInpGTg+HoCs7Mz6dvur+JqGFcQs9/hAuShXfQTdAUnVS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnkS5Cq4; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnkS5Cq4"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093472356dso2513316a34.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722338637; x=1722943437; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1rljVErqXc3UO1mUqGHZWE+QJCuNR1+RQf5/V8bvsI=;
        b=JnkS5Cq4Nb9BySe3WsZv3hCnUtSSV1fH42w10moq01R2W4DiFUb7CBbifzkvgOWSZr
         z+mteSY7AUDK5ejieRh92B8/3CE/5UKnc7JbTiKGXZgnUvZhOctJcSOObUR9d0hbYbWB
         dMm1cM/nREpMrgvPPXZh8gS4Yt4AiCAv7mxtrhg57/M0y5s/jvJsVf+mCCUkprNdePW3
         OYwo6PPHf0SWqP8vwiiMGjpz7O1wPE383f0cHE/zbc8eVHdIS4yCe2KgegZba4YwDx0c
         VfJUElwAsPgugvZPD8MjkBT5yMcLu6nYmroV9hQdeH8g92l3gHhu/zsJGhBWL1LA8EH/
         nabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338637; x=1722943437;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1rljVErqXc3UO1mUqGHZWE+QJCuNR1+RQf5/V8bvsI=;
        b=JBWmz4oV0NOzfidGSLX210pPjCZ1LxuHa1EzTNp2pyd3DzX2JJ545mOUFdvDEXpMXX
         HGa512ZcDX9J47OlRiQbbIFuBDaYDmlGsJXCq1r9NddqT6oNBkKoJPQij9PlMJg4GwFi
         K/w1/DQUYW21HsR6hPN1/51t5puZ1Ivu7/o7D8V0Apk0VY0D9mch9cQSxwfL051z4EOo
         7cJ+uDdB+pOq4G5Mm1jMCHB5Dph23Fnz86CZfCkuZ9BUwu1887ALY/a932Z8SL9e0cYk
         CPxFPGPFP79MzuNvrn0ELYNAaamgVTAnU5H5vdkl97SwWOcVgvDIP0xb3tFBhuINzgoN
         TDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn1UxDmbJudNJFxEd5ePQ4nMzAyU/EpbV6hycUSAEylAHnrJFppuFi8obCO5y9tksHf0P8Fy874yE5x87EB1gy4CKs
X-Gm-Message-State: AOJu0Yx70CnQUxBKc2j0bsO4iA/saBBVz7DN3qMC+36LIEayjiRNjfov
	pzcDYoSB6Gv0NEBfwQalSLrcj7FfLU0nziOPZkCUYB5Z3T8ijrzGVR5WC9TBDrI8KGOqXma7bi4
	vakZ7GvT6SWCZeLduQAYQYl+yeNAX6Q==
X-Google-Smtp-Source: AGHT+IGgGvZSEB7M+re3f/HvqbVCh0bTLQghXPXhHBFvU3f1x2VoPknozpBqkAGfmUYtBZLr5Lzpm4Mvq+ixpZkZew0=
X-Received: by 2002:a05:6870:332a:b0:261:142:7b95 with SMTP id
 586e51a60fabf-267d4dd3f18mr13059493fac.25.1722338636892; Tue, 30 Jul 2024
 04:23:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 07:23:55 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <d164cd3aa12b67ba98c9b878543497482441ba2c.1722316795.git.ps@pks.im>
References: <cover.1722316795.git.ps@pks.im> <d164cd3aa12b67ba98c9b878543497482441ba2c.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 07:23:55 -0400
Message-ID: <CAOLa=ZQqh7x9xaZXenRoMM8+fE+c5jOG73J5hPg-q=b_s+vxXQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] refs/packed: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a2ae63061e7536c1"

--000000000000a2ae63061e7536c1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Convert the packed ref backend to stop using `the_repository` in favor
> of the repo that gets passed in via `struct ref_store`.
>

Nit: Might be nice to add that we move to using `get_oid_hex_algop` in
this commit. Since it was also mentioned in a prev commit

[snip]

--000000000000a2ae63061e7536c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be4943da5746528a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb3pVa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3A1Qy85Vm9wamdJZUhZWHRuZlVTdnpBZEpZeE5KeQo2SzNHVzE4cVV2
SzFiQ3BNaWxFY0dBN3QzcVp3WlkyU2liUlhadHQ4QUpkeS95VTZ2bEJrNWZ6RmU3UGJsS0hnClpj
QVVrZWhROVZGSEVkcjYvY200YXdobmo2SHk1bDJlblVtNnluSTNYUW1peEtWRFF4Qy8zNDMyNE1M
ZURaa20KWmkvbHdPV1BHVFZyaDdzNkdad1dHdWo3NlBoUmEzOCtrbUVDeUVkd0hIWDMyWnNUUTgw
cUk0VHd3UUlHY1JHTQpoTWgxRVM4WSttZXErejZITG9VN2lIYmFxT3hFVXhaeFBVRGlXR2UzSVNY
cXYvN0JUNkFHa3FrRVRrSTMyMVB3CjRPblVjRXYwcjg0YlIrUU9ldkJGZmxOMEYvVzBIcTRYRWdv
QVlwcFhDeTlkWEtPL0VSb1o2RXAyU1Z5b09CUncKQzI5M00zYVZBUHFpQVRmTjF2Y25iZjM3d3E2
SVprc1RES3hGYXU4djVGWnljOEE0dFQ3VjZCNFF1c3NkMGk0ZApxU2dtT1ZqSjVMdk5sY2pXVzV2
aTE0K3lFL3hSRFVySCtlYXJwSUlHeUJyYlJwUzN4VlQyWjF2NkdxRlprWWRSCmJQUmRtQVVSdk5w
OEloL3hzaVZUWjNjOE0yM25pVC94Z09iWll3cz0KPXRtSFYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a2ae63061e7536c1--
