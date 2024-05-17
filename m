Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D010A25
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933662; cv=none; b=jcx9Q+4sbyjCUvY76wWxZbyE5QUbsLMTa2Q42CjBFS9CrMF/ff8cRo0l1w4LuC3TLN/5k3AoU6nJ3rSR0/L7Ph+0om1l1MfVbWJ1bwM8Yrv7UrHVDL9D2a0qz1GZh+BVJEMkZSKTtVC33KSrm0YRgA5RWdrgcfvsgW6gBtlwshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933662; c=relaxed/simple;
	bh=rFVMZnCwOnKubuVk54Q/wer2qrhTHOqrP++eOza7VIE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjn0J73fi2hdmT9czJJj3imhSseyxqdYih9Cbm03slFh/VFIBql3u9LMVfq1ZANjI3lgQoBwdAabzM58VJ88bqcl8wbrC5V2fJJCAv7F8Gkj0joR++eP62SBRO8EtWPMiGhl2MT03xN7dSxbNxpv+LiWh4XDxGr/eKosf58NLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECm4mqpz; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECm4mqpz"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f12ed79fdfso698350a34.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715933660; x=1716538460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0SkzSLq38W23FowHPXCTyV+yUmlJjaVzzVg4jpllOw=;
        b=ECm4mqpzmpYqNQe81wtQN9MakRghBG0gUD8vGD8UkIHoovVbP2eiBJS4YNoSpNZR7q
         RmrobDI5PUZf8xKrHkh/ZrLaF/Vmsh1e0u6bNM4DyYdmoFDz7iO239Udfyl9Kf8Vfvv/
         JtvCMFuZY0JYQ9mfhouVWFYDHlX3gjmnR9whXPGiPJOV/DL7nPQ9WVWrCCLpHdRaKhUc
         ZMikZJ/t2WHZcFZce0N8BiI0iOpPbLin2fe+/bSk5w0vsjy69h+9bvE2xYDkKkkHuYuw
         9r1vwEsW0gAcYgTLLE2IXl7J6M8rUVLG4zIxrY88ftNg0ccfjtXMUR/BI2ZWLqP4x28G
         fLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715933660; x=1716538460;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0SkzSLq38W23FowHPXCTyV+yUmlJjaVzzVg4jpllOw=;
        b=fClrUQNyZB5kRaGJxZoq/MRwOKQ+F5JHeIbc/OLteN+zZLg33z9j19KcWtzO0dVutP
         uxFSQwi5XUXsHClrccBMPGHnR4QYPn4N8DeRAbYuXwehKDIXtbWrNQizPfFN3ouQVBTM
         1puqSKJOHf6o6pWPpYpHh2vs6F0q6lxSZLziH6SP9t9rngaHnT/9WpGAsUn5gpF8vD7P
         aO9BLP0fnCNBLCKLT3usEwra6S8VAgEPnZvN7YF+v6jPtrF39YSDF9LEoDVFP15DzljP
         8IKz+xcow77P0H2FmYBI+bwlloCFe938F7L5uv6LzTAihqC0WOgmlZIhaBTO7rqOLYZN
         mrEw==
X-Forwarded-Encrypted: i=1; AJvYcCVwGLapgK7Z8E/dGN95OKKREB4vDfgnVkUkfqEK+r5I+ZEDRS1U4J28KIktdEsK4/zHOmZYIoWSvb/Bgz4ko1X/4OLk
X-Gm-Message-State: AOJu0YxZgamsZ5XswKkDY6dYx0jOw49gCewNAhMwJg/hD6GY+W+Ylt6l
	x2dEcmCPwMTTCaxMgERuz7ZdHYeY2i6z3YIC21bzS60dbkbR9sSzsU0VPx7fF5Hwg2TelvspgBt
	+SfX9a8ws+EVZgJOrySS4Mr/3C8c=
X-Google-Smtp-Source: AGHT+IFzsPw+4EkeIQehcCQqQ1RZ74Z5APeqG3XbvGw0QB9GWkE63oy1y6WTM9s6/tXmoF0Ob09NjGMVu34XW4Z8aAA=
X-Received: by 2002:a05:6870:1715:b0:240:f3ee:6fd8 with SMTP id
 586e51a60fabf-24172be01aamr24406049fac.43.1715933659914; Fri, 17 May 2024
 01:14:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 May 2024 10:14:19 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 May 2024 10:14:19 +0200
Message-ID: <CAOLa=ZQE2mFrDNGyNEwYXneW3Vw6wqg160WOpFL7+NfSfOfDhg@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] reftable: expose write options as config
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000004206ea0618a1f02e"

--0000000000004206ea0618a1f02e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the third version of my patch series that exposes several write
> options of the reftable library via Git configs.
>
> Changes compared to v2:
>
>   - Adapted patch 2 such that we now pass options as const pointers
>     instead of by value.
>
>   - Removed a confusing sentence in the documentation of the restart
>     points in patch 8.
>
> Other than that I decided to rebase this on top of the current "master"
> branch at 0f3415f1f8 (The second batch, 2024-05-08). This is because the
> revamped patch 2 would cause new conflicts with 485c63cf5c (reftable:
> remove name checks, 2024-04-08) that didn't exist in v2 of this patch
> series yet. Rebasing thus seemed like the more reasonable option.
>

I did go through the patches and only had a small nit, but not worth a
re-roll.

I was also wondering what happens if users tweak these values when a
repository already contains reftables with different values. Seems like
it'll use the new configuration during new table creation and also
during autocompaction. Which makes sense.

Thanks
Karthik

--0000000000004206ea0618a1f02e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e4aa48c63b77a3be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aSEVka1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXFqQy80czJ1RkFkQkprWHMxVDVQR2lXL05SdzdvagpBNDAybTRDMVJG
WXdJdFJJSkpmQngxN294VWJWMExqaU9VZ0Y4aUdBK0pDNkhuQmNoN0N4c0ZRaEhiS0pqYm5iCnlV
REFYdW94SENHV3d6d01kNVNqTnIzYnI3cUU3NlFkUXM3QWt6UHpWbTVQWWRVTlYwemFYNHpvaHRi
V2swZDQKRVgyeFJGell4cU0xdlVwd3JRRGZpWnZHRitlMEpURURldy80M3hKQ0RiMWRXTngxb3hV
aWd5czZSbG1RMDFESgo5ckFRL2srelpPbXFodFhxbDJJMWZtc3UrMkJreDJ2N1lQaTdRb3BuQUoy
aVRxTkxTOGZ3OGV6N2sxN3BGc01zCm1Rb2VFZE45N3FyT0JRMmpacEplbUZzSFVwaUdUaEwxNmxr
YzB4dzdhQmdTNVBkWEVSaFpVVmw0cW5zc3NiKzIKZk9ZUkplMkJ4UWFQRm14MlA0UUVDbUorV0lk
Zmx6b09ySGRIR1pObXJ4MnJBenVVWTlEYXdBd00zM0dPbnA4dQpSYVVReHZmT05oRDVHK3duVUFK
TkNMTnBRUFNlSW1CQjFTRlVwM3FyaEdOS28xdDdyQStUaGdmcy92azAvU3pTCkRUQ0lSUTBQcTJl
RTZCNk5XYTkydjE0SFl6WWlaZ2tDZFVxU2lHOD0KPXV2dHkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004206ea0618a1f02e--
