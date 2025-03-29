Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE35149C55
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237774; cv=none; b=LKprHAxZRAJOFxgNcxGQ3TOeN1wS7eCkCttkqsCKtIFDVRTUv+CriBynRTqwllSYQWyEW+2+vSX4EB93iNzjaIEY45sBxZxu6q0IchLVdVqAnWEiuJHjMjsCF4/BVc68bY/AHxUDU0Gx35df+fnTO2BvbfxsT1241XOtT8IVstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237774; c=relaxed/simple;
	bh=2nPv+LjIkN1+aDY0/RIA8cbXGrEV/2w5Hbp8mYajoTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brJKRTcWTplmoasxnfjUMHCvegXUkD5nRpoA12cRk/ufEnBXgy+K2LBcBexZ15s6aagXtc7ngrDWaCNXnhrSrDE2a6KR/CEOtmn6O1cK+FKPPPVgfEXwzVssGh2c3IWIAbQR563U3VnW4Y8Nd96px7/A/X60AXgu0yCKH8pIVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK+jPwna; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK+jPwna"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso7287580a12.1
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743237771; x=1743842571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnxeTZJaQj3eIEp8wv53UHTMUTAsXb2y8FB/dEbR1+I=;
        b=RK+jPwnaFYH7ilxVbFR2UdKqtdBU9Iu9+7WgVVXhCODbKZQGvhiyLGzl30OrbXJy66
         DTsf57c4IhkczLEwH+osh1jDMN2APwmtlKfRepKLPyoWQTjLuCV59ggWhnnBb159/0Ut
         Bi9qaE8Jq6BmSc5HgpFmReitvGCe0vQD2OLDNGFvezllKoegL+VDExphOcm3Gg+7bB1/
         jZtooHQcP6x/lHkq9zilbX1Xz6fK75DSCje/Y4C3KWULbKxOtdb8BJg5jb+0xK059cpT
         NOgjIkC/GkxHYkCnCR9k0ZIciWrCU2l2m5MNGDorcNcESGbz6q9GfGA0aylrERlDCLJS
         97aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743237771; x=1743842571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnxeTZJaQj3eIEp8wv53UHTMUTAsXb2y8FB/dEbR1+I=;
        b=s44OO3W3i7bn5aPtMyn1KfgH+jCmX0tFRsmISKKegpq509bX1xUDEXbDPNAXMRSJ6c
         FC108z5ir3Y8FkjWNQOHbIJbllGARVWzIt6OETdAyYSRaJfI/EsmzejWB76zbug31PEg
         oHjxGjos1S4SCzNVN6O6z64YkTuR2R0zlu/Wl60OdRTYqfG1fykWRmN2a/EkcG7TiijL
         LTD1Jc0KMEuSIr2YxW91RisGKEytmUcHwjmIdCS2TWwlRH3Arla6KZhFCWFff6GOPw3m
         VwRCuC/S70Wl5QeqGe4KAV4Eh/Ger5EiTx1Ty8rfrcPtTXwIaVOMcVWcpWuKG6vn9td2
         Jj0A==
X-Gm-Message-State: AOJu0YydfAOmSntlPdjmjmB0OZhzMmXmi05M2RN0f6B+PZTRY2+2x37a
	7Aky0gfAxLxnp0OmpONXBWmx3aeHbe/vTRJaFpKhFNKLPGSBIC8s1dPP5+vq5aFM2ybPWTFj3jH
	cio+d/aPpzB0wJ8WoslCIFRsw8nHjZHsb
X-Gm-Gg: ASbGnctLd6qjSNN7eZ5zc8sOjGp6fvBHO+3PQaKw56Awr4o5nkVl/LxBZiAtK5yLa/c
	rbZDg7JmkwriIk1vFHt9D22+bmM6QTjajioak69CHJ68+EhvxzihgbQ554nmpftVb0+ujDZrIY7
	sm74jgJIvYQu3nORbiR+3koig69JVd
X-Google-Smtp-Source: AGHT+IFguS0rff5fJjqrHFhvmOI2hLcieFsDQ1bYYq9Y7L5FVpt7PlclQhyraNqsNlB6oReTxSI9RuEXAuFTcV0gMoc=
X-Received: by 2002:a05:6402:5cd:b0:5e5:9c04:777 with SMTP id
 4fb4d7f45d1cf-5edc44cbe91mr4964890a12.6.1743237771210; Sat, 29 Mar 2025
 01:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328170121.157563-1-jltobler@gmail.com> <20250328170121.157563-3-jltobler@gmail.com>
In-Reply-To: <20250328170121.157563-3-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 29 Mar 2025 09:42:39 +0100
X-Gm-Features: AQ5f1JrDO4eJjEf92OTJCyMbQsaUfim9JBbl7IZdiciv-WkUOppVi9f_qTYXSD4
Message-ID: <CAP8UFD3tXtoCcCt0+=SVh76JNvRGL7DOH9Td3igKn6AS07bfiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] help: include unsafe SHA-1 build info in version
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 6:05=E2=80=AFPM Justin Tobler <jltobler@gmail.com> =
wrote:
>
> In 06c92dafb8 (Makefile: allow specifying a SHA-1 for non-cryptographic
> uses, 2024-09-26), support for unsafe SHA-1 is added. Add the unsafe
> SHA-1 build info to `git version --build-info` and update corresponding
> documentation.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/git-version.adoc | 3 +++
>  help.c                         | 8 ++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/git-version.adoc b/Documentation/git-version.a=
doc
> index 80fa7754a6..53c8ba74c1 100644
> --- a/Documentation/git-version.adoc
> +++ b/Documentation/git-version.adoc
> @@ -22,6 +22,9 @@ OPTIONS
>  --build-options::
>         Include additional information about how git was built for diagno=
stic
>         purposes.
> ++
> +If built to use a faster SHA-1 implementation for non-cryptographic purp=
oses,
> +the implmentation used is denoted as "unsafe-SHA-1".

s/the implmentation used/that implementation/
