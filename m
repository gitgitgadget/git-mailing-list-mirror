Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3322084
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933371; cv=none; b=ks+YOiDwSgJp6DWJGxPXtpvyA1dGKouDjlZkjytSlycST8Oe777y2zK3VV4HOkv/h7k97oBxrKu9xJViVJAXrGU14PDGHJxDtRKwKG3QzZ3CUMc6ctazmf4RyKi27rbcs1T5o6i6PNuvilhfc0BoCq3WzVXoazitwUU+tT3/Jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933371; c=relaxed/simple;
	bh=tlyyv4wjTGiJWSOVQde8xQIpFyrM+m6LIkZfJgDYxUY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtETQRfmiIMV2byidH9aKwz1IZld9Nb2is2Cr1lKkm6KR0jbF5MYeckAU0R336g5qAviuCtbViuoiPi/GFPHB3RDnIgrcQLMbXmoblTIgF4H9+VGkpFRq/uDECw8I7ebalxiMDUmHSj008voD9tti6jSMs6AR178UlnJFdD3GAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyBcXnbY; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyBcXnbY"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f1239a2e83so693568a34.3
        for <git@vger.kernel.org>; Fri, 17 May 2024 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715933368; x=1716538168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RSohVNPLf5rgUFDSuWBd5o73KEZF94ELauQJ9cst28=;
        b=dyBcXnbYPmCr7h2fPiqgdWhcCN94riRwbNEWGJ6YgoOqtpz2/k8H7ZU7keWKIvqR3N
         wzmsmQYIUphRV22fYK7Z/D6NlICcUMHm4rPDsBOJQK9Em7lxbyo/daljjpfbeEZUbnzo
         KkZbu0PDfuJKps3joOUKypH3x/ld3s6Ic/RTeUvUJY3rfzsmXRUrrYDkpz+uK6H0Eki6
         aKPS9V0z0eRcOLorKeqel1Xmr0Ac97kz0jPFQaVYk/bM6CII6lY2l3bGFviwLTZd2xNc
         fqFIbw7ZVsSHyNhYwzGjlLgixfOYlFErqFgyWvafzA00M6KORWGx2RAXvg5Djn9+eTpn
         lMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715933368; x=1716538168;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RSohVNPLf5rgUFDSuWBd5o73KEZF94ELauQJ9cst28=;
        b=sajzVZz2j2rzhuT6a2e7In/C39b55GM0mNIeE9On3H3Hh2tMEooV8FTCBk8ru151Uh
         932LhyWVxOPfdtEQfqA1aNjeY/QKH85CT3gvf2zhgO1oSAPd7Ht6KID4fWFUSq8FknUf
         2/MddxwH6EsTvoewSjWk3Me38NzqrM5oZKSPYNsnnrS4dBC+r0eYJE3Qs/ENPrn8Vl0f
         f8iTx759dGwiQRwij2ez8d+5VUxHrOH5WTBLKyp4JZlCddWbBRgwocXx1LhltiGYCDy/
         fNIh6k8wLsqQM0FnQM3IpW501yvnMYacWEyrp2yVt3uNW0DP2GyVVrWPDXYlL1wpZbe3
         ObkA==
X-Forwarded-Encrypted: i=1; AJvYcCWYA6rmTzvZieKQrD2PF2VZaZMXM1XOTbBC0iCAy5v3ZxTnG0vw22IxVYwWv3znPRqwkFLiHsqnafFuk9Htk18GXqpC
X-Gm-Message-State: AOJu0YxQbN9u+RLruV1vQKm5kKFPhQr8B70r6ocOkACu252hrmM0DWNW
	vpgGQ9PQfJa9gdRue3NnWmJbXEgzb0bm6gncRJn24jN7VzeznuCrRsdCKUrHvh052ec85f8izRg
	n8g6LnnOpNW5YJT1T/vVNmLg1oZ5a0g==
X-Google-Smtp-Source: AGHT+IFhXZFVIOK0K4DUa5bGqsWIG/wo8UIQPvNaoyailN3DpJ61zb+KDkkFPKECC49r+8/Y+BlNCDn+SHdEljm3VE4=
X-Received: by 2002:a05:6871:5d2:b0:240:889c:4b26 with SMTP id
 586e51a60fabf-24172f713a6mr30511615fac.46.1715933368452; Fri, 17 May 2024
 01:09:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 May 2024 08:09:27 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <70720af4d3476e30eba2a85c2691d664e02ade31.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <cover.1715587849.git.ps@pks.im> <70720af4d3476e30eba2a85c2691d664e02ade31.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 May 2024 08:09:27 +0000
Message-ID: <CAOLa=ZSkuQ07BbJx-eSaui3WSZZTup54WnPkMSXnWwwnM=LATA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] refs/reftable: allow configuring block size
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000e2bae60618a1de82"

--000000000000e2bae60618a1de82
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Add a new option `reftable.blockSize` that allows the user to control
> the block size used by the reftable library.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config.txt          |  2 +
>  Documentation/config/reftable.txt | 14 ++++++
>  refs/reftable-backend.c           | 31 ++++++++++++-
>  t/t0613-reftable-write-options.sh | 72 +++++++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/config/reftable.txt
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6f649c997c..cbf0b99c44 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -498,6 +498,8 @@ include::config/rebase.txt[]
>
>  include::config/receive.txt[]
>
> +include::config/reftable.txt[]
> +
>  include::config/remote.txt[]
>
>  include::config/remotes.txt[]
> diff --git a/Documentation/config/reftable.txt b/Documentation/config/reftable.txt
> new file mode 100644
> index 0000000000..fa7c4be014
> --- /dev/null
> +++ b/Documentation/config/reftable.txt
> @@ -0,0 +1,14 @@
> +reftable.blockSize::
> +	The size in bytes used by the reftable backend when writing blocks.
> +	The block size is determined by the writer, and does not have to be a
> +	power of 2. The block size must be larger than the longest reference
> +	name or log entry used in the repository, as references cannot span

Nit: s/as references cannot/as neither can/

--000000000000e2bae60618a1de82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 11db06d0252bb028_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aSEVMVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmExQy93S29LOG1CQWsvaitrTXBXSTNyT1lnMjJ0ZQpWN2thQTRUN0ll
SXJGK0xKSW1pVE9oVDVZTlg5VC9qWHBNd0ZjYnBocjMwaDBCQ3A0YlNFZmJsZVkybllFR3dOCjE2
ZVlJUVUyUm0vYU9xc1N5bkphSDR2Z3krT21LSFBsU1dTRmNTWmdxa050SWhlTlkvOUs5VkFoSjY1
a3oxWCsKbGIvREJUVUhkUUcyOVBDd3RGM2FIbS9yVWFLd3dZd2Z0QlQwTDZMU3JJKzZuV0FsVUhk
dUlkdGFOYWlic1I5RQpQQWRZVGRqNVZsTk4ySVRCeXo5Z0FPbndiU2JnS0RSZUc1TTc3UTBCTTJ6
Vi9GTlAzS3BsT3pSb0JvM0ZQSW5tCjBVcDJYTDdJekJwN0ZnTUF3d1dVbzYyczUzMTFJY3FxZ09S
S09UUXpmN0JhYzR6czN4RmFSbHl6aFdIM29sWDMKbGV0VlAyYXVEK05KQlUyOVFBbHM2bzFpazVl
MEZldHZqazV1QzJvNHkyT3NLSkdsWmNlN0tSRVJjdmFnQ0lldAptNnF3M2xodkw0NlRKc3E5bGJQ
QVJ0MERpcVdvdFd0MFlaTmZBM1BINFM2Q2VKRUcrbkU5anhQby9FbC8wa3QrCk5QVmlpUmJ0bVhY
MGI3UGRhb0wzaFI1b2R3eGFNKzFPajB3SXpzUT0KPUVvK28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e2bae60618a1de82--
