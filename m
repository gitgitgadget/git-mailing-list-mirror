Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B580364024
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996997; cv=pass; b=BHqhBTXbaI5jaUbAmJ0DQ8BvfXnOMyrVidrsWCmGEPwSoUjraYDP/FJv746k4lAB0RP6K1oRdBb/F7pn/eFUhSlDWQr47wGaPuPWMPdb4M/9/jpltDChDM0JYZ8USwK8wACrUMXaubxXJuf+7Zs1GFIdGArFA6ypMutjK1eEz+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996997; c=relaxed/simple;
	bh=XQ9sv/oj5ttXg9USeSIHvieIClh3kD9D3Dx1EG3vfXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVhqvUu+h668vbes2jnqJCKswwzY5/nZfdMhtnEgLIMh7wTdjm9++J+2SW3GFxSQHU7HJb3vHq3zS2c6iebXTAGN5+T/Q5ObdbDwhpmdrvNC35n+KNRdFAc6zbW/At7uoZsHpd3lkIUeRMtm561AVHJ223ctn23qUur0+1VN9iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgiA0oAl; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgiA0oAl"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e5f52b13eso1044013e87.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 07:36:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770996993; cv=none;
        d=google.com; s=arc-20240605;
        b=G95vob7K9jK+hUK9RjZU1d4rzVhhlAUw3c5ROmsNyDSTaPwoUPkZyU8HSaU1crPVJV
         q6aYI/1uCB2sA+y3fqWo4Kg+QtcbeSoaNKUu9aQB2Qb45NdNIHN9vbBIXhws26w3F1mH
         G2B5S60TOSbw+adn/WH/OonvgoBYGDfzh9tVdgOcB/pevQe+IqONUtJ84Njoi8l2huWl
         cwunxUkxwlsFhSgccS9dUYpxmIXwBJZJBThKjz4+grh1+JvjRAggY4XnizBaQtK/z+ti
         1bYsYz2E/OkCkttYRGspBvhBxRILPM7xblDtS78WVeAKbxspfCPhmIaYc98OYDhaBwOV
         GT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YvKkAiMmosRw4wv+iahA+CRinvN0vRWm2oZFGXTCDME=;
        fh=V2m9a5jGMgYlM90uz0b1m6stuFGrPJdB3Z0gC2OAg2A=;
        b=ImLQ3dDTCZhH+sSClavlb374OV68RCRpDHG6/RxM+Uu6V4sgLKymDOWMeQdO5ux8FZ
         v0QkUqtiiwtxYDi9WfD0/eD3b6fS1XKjmsMF6wLFdsPE5u1eSOTINL7AXn4hrV+5eNpj
         tIWgQJ6C4vVjOETnc28EIWemsreVHZ5CXWqv1GyX545tqL8WfrLPpDT7Fgv1dYuyUpDB
         jmEMuf+lMVLxtfclAiVJhIoUFoVGT4jMYjspoOCUKTEMFfcuOgBruLh/JW5C+30hGgMq
         7kLeXzEPOjszt7ZopT9jEy71Fo/orApTZ6mM0rkRj17VzZMkbvBD7yyDQp4aSzQTo3VH
         H8Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996993; x=1771601793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvKkAiMmosRw4wv+iahA+CRinvN0vRWm2oZFGXTCDME=;
        b=fgiA0oAlZZ1xNLE75y4bqYGUsEXwq5FVlaWvcgk68dd13qw+qKKJmRaaN6xbRUTYje
         qo91qXA4iPwNbupv7kHEbnusoFHDHIfxyUJjziURMuinHqEHttclfgDKd7pYBKgvmayl
         TIV/HJWbpNd9hNO5YcYgic526wQcwKAchxY9NG/FR+lsVhj/VYqJ0QtIpXReLRzzWnPz
         ZV0mgdjyoghO8ph4Uy4aGWu+7CdajCiC6l0u6WROXlTRQHY9NHyfkG2IbRNCNauI5HZh
         8yQLGOdgVd/S9p0vtA7lTXFUxjRTMitSdcHnmtTSx3BqsX4tbMEpYYV+uw7CGEzZzXe4
         85JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996993; x=1771601793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvKkAiMmosRw4wv+iahA+CRinvN0vRWm2oZFGXTCDME=;
        b=ZbxMlsYDXheEidF+v6Hl+LdkX101A4vKavjyV5P5eGyw8B1uueDZzzMGww8EDV6XI/
         UW235MIBq6m7li7gtnRiqUdJ4uWC/YRwWEu2AXAXXaqfJ3/DUUhjOaNcIbJlMWjXIS+Q
         RdVisR3IJO3BVBmvNUZHUAh7Mk2uOyae06UmXG6bP9/ki7LX6wCxicisXq/fSxJ8ANX1
         cwU0gPp0zl1Fo6INVJ9F1fELQu4gH4e6T5x+NTPNam9ybC+go5p3Dxe2Ss2TtiH+9VFh
         YPorJeIVWdmu3jlyfQUVhU6b2vIExgH2JRzmxrcGn+FbmgeTRaY7yOTWScHTwmcQntsy
         xd8g==
X-Gm-Message-State: AOJu0Ywbbj0JAfBYZKZLvbCJzJOwYO8DJZoCu1EZPauCBCIvb6TqwwGW
	x5gRskzUlpHpMrt9yQFVgLbU4R2vKRR9HwoX0ratmwQLFptvUJIlP1UkhNnkseGJdzrNCmWTkot
	PDrVtaM5eMsatLy+Q33CH8bMk2wl6uoo=
X-Gm-Gg: AZuq6aL6G4rvBFh1fyFqW/Xo5FjmCCHYOR9xP5VKQaEOUC0NJAOUzlMdG2Lu8roq/c7
	GSncNKLC00E3/SAAiRR2cvPMlMIZ4T0qUdEWfBi9tDETuSslnV7NznmVMfy20k8W2tLue3iBK57
	kGy49O84RRXbwSJLOmGIlLH/0cG92LCnhVc5hmLtBg5Q3ihN1GK9W2oK9DzsfY2WlTux4sqPBDU
	zlgjYdso2k37lYBDFSTivICGNcL1AFnJz/3xS5TsOW0689Vt9K4QRVaHWjcOr/yBBm1cWygUv9r
	8sd2xRbabJd4Qkq8uRY=
X-Received: by 2002:a05:6512:1188:b0:59e:5ba7:1a40 with SMTP id
 2adb3069b0e04-59f69c26371mr755988e87.15.1770996992956; Fri, 13 Feb 2026
 07:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213124656.218396-1-integral@archlinux.org>
In-Reply-To: <20260213124656.218396-1-integral@archlinux.org>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 13 Feb 2026 07:36:20 -0800
X-Gm-Features: AZwV_QhBN9W3iVMwBFZCZRhYsh50VjVtmth6pasbYcxu_5dogGITBfyEddOQnu8
Message-ID: <CAPx1GvfsnZiUkkXJSAtt4HECT6f+zb1+vtiT+UikcAq0WuFR8Q@mail.gmail.com>
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on Linux
To: George Hu <integral@archlinux.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 4:47=E2=80=AFAM George Hu <integral@archlinux.org> =
wrote:
> The `sendfile()` system call copies data between one file descriptor
> and another within the kernel, which is more efficient than the
> combination of `read()` and `write()`.

sendfile() is found on other systems (notably BSDs), so perhaps ...

> Signed-off-by: George Hu <integral@archlinux.org>
> ---
>  copy.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/copy.c b/copy.c
> index b668209b6c..d4b7cde764 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -7,8 +7,23 @@
>  #include "strbuf.h"
>  #include "abspath.h"
>
> +#ifdef __linux__

... this and the subsequent ifdef should be based on the feature,
rather than the OS.

Chris
