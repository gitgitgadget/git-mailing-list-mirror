Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BA18EFD6
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135935; cv=none; b=CMkMp8Wex+fx18rj9jBBsqbohHrH8DLUaiqqkotFNVAdJdQJe/rBGgEe35BlRSahRb0SNM31tsjJ0Kph/FQmCxpW4FCou3T4BcQTvUfd5qLRL5IbPO0GFVtIEOwQCVEyrrABVUGzRJVBCWfVjpFYrNXyGOsBN0M09L6O0efy57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135935; c=relaxed/simple;
	bh=pMgFCdGHHOTK/ENSsdUsw58GQeS7+ZBNsPAugBTKsGM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSZSuuoNQ+WrOrc8TuqkaxU2gTYaBTW4Smijl1LSX6RXvcx7y3UCZAosVQWMuydXUDpxB/FCHBybp6Ubber57BWHp/r7K9r6Z1ONACdo672fYsCiiq0jd0AYQtZd39Q5DYq9g4wLUNN7eQsI+776MVxOv7Kxmb37Z7Ty4CL0/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUlRKVmT; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUlRKVmT"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5c7f24372so681964eaf.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723135933; x=1723740733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NItU0TRSVPBA8U1CmF/Tic2oFJEq7ipLs0bBbxNpyG8=;
        b=bUlRKVmThMZBo0s+FqJgZ6OFJitwie+ZT8MqNmukpXG4/Zu0cUpXFQPyAHOnG2Dmk/
         3xD0W/Ro3LMsFEVLLB7xceZ0CXYkMor7C9Xc7FV5ELuMuOziBPmy444anAyv97b7pW/k
         m+T2bVZ0qY8LvIj6AeSTz8DoLYCCl5uVbs5h0a9PQUO1tK3wotWL6Y9o1eZhn8oitrGz
         1dDNpWF7LVFx0pWTR36bxw7P8cHYRBb62aR6Qj3ehIM+u7PU28bEPHewILpTnqr3pXGl
         PXqobtppd+hwSSJBCJaN62A3bF+zOA6eka48g7ifoOEaE+ivBxyiN80D8OK7nIwOSKJf
         902w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135933; x=1723740733;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NItU0TRSVPBA8U1CmF/Tic2oFJEq7ipLs0bBbxNpyG8=;
        b=wjDKuO5IH0WH8QiE8uJP4w/hXrBlq66bBCj0hnBEFW8MaboinZpbP77giP8Expvvj6
         rMW4bfZ3Mwf6ED+JLxKHScGGcFWB9JTgW1mZojXxG40k7pDSLQO1qjRBLnjStShgTpZO
         9MJzlVuSzOPXag5WZ4p2KMRDhoe0q9o8cm7CKgADf8pQKYjZd7k4LnwDSYSMbgKJ7ul3
         KBGCfPZElGS8aX8beo0Z27TpS4KiCtPPGwHyEMboUJl8L5ikLdWDe3B2SNxqOziqnBPG
         0rn3pcvO9DMWS0Bx7XzRj4ILRCea22vYcuUs3peKXByXNrofgX9U+XlfW8fsrVq0+AGE
         /MSg==
X-Forwarded-Encrypted: i=1; AJvYcCUwj2CInFvJ84Ncyvr6Zln5rAKTDU4Q8mrVSIZxx+U/6/lsu3rP7S+TLyw+4TmizlNiKLnRN9kciCmgOXGZob3AJuLk
X-Gm-Message-State: AOJu0YyCyQT50Asb8Iw7+0L+OlN+ItnH0t6du7fWoEC2LLqLysz6iVGQ
	KWbgP1960ngUfnQgT7PkkX5foIH85CEFxYa5uj2AtydM8ucPIZt/m3dZXTPYA4a3u6yG5FTVF1/
	ICFXBnVwiEKNasgcsydjFDKM2izk=
X-Google-Smtp-Source: AGHT+IF8poT9sW3rCN5GCsnywZZacek9NG599TXUqLeQCugLJwvywOBmFhN3qRm3NhexFU9d+mK7MoLTJ5/Wtq4puqI=
X-Received: by 2002:a05:6820:1515:b0:5d8:d4a:9509 with SMTP id
 006d021491bc7-5d855c1c20dmr3635047eaf.4.1723135932750; Thu, 08 Aug 2024
 09:52:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Aug 2024 11:52:11 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im> <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Aug 2024 11:52:11 -0500
Message-ID: <CAOLa=ZQ1hYtj65ra+s2Tdmmvs4xiy-4tL+KRU_f_7Z9NaUknYA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] reftable: improvements and fixes for compaction
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000002bff14061f2ed964"

--0000000000002bff14061f2ed964
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that aims to improve the
> way reftable stack perform compaction.
>
> Changes compared to v2:
>
>   - Drop the unused `reftable_write_options` structure in
>     `write_n_ref_tables()`.
>
>   - Fix a commit message typo.
>
>   - Reorder some variable assignments to feel more natural.
>
> Thanks!
>
> Patrick
>

This version includes all the suggestions I made on the previous
version. Looks good to me now!

Thanks

[snip]

--0000000000002bff14061f2ed964
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a1f92a7d835794d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hMDk3a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3VVQy93TUk2ZWNDMkl3eXJJVm50UERXRkxYN1dlZgpqRUhaY1dtZTkw
QkZSVDlEa1FoOGJkc1N1QTNpYzZ2Ry9LdWp1TXgyUEE1bHRsVStuUUJFbXlMczBPSmtFdHlZCmJz
bGJEN2JmUDl6SS9VZE1yai9qeWNpK3M5ZXVzdjE0UGFLMVZGZ1d3eWtYSkpsVEU0amR0RTE2U3Fu
d0pHSTkKSWdmM1d5QjA5bXFmU0hhL2ZmUzk5aTJKZm9oODdGZ2RUT0tYa1RrcmpqOGx1SnFTMTNM
N0dnWFEvUlJETm5WdQp2Qnh3Y1p2dWtaa2FOTmxiWE5rU2ErTWJJNTR0VmMybGpCNWM2Z3hXazVK
SGJQYzZ2aU14MXYwdDdZZGhIMXN0Cll2UG5pcitKRDBMbkRtQ3RYSWFPOXZweFpwZnEyOVRRdmpy
MnFJbWpiOFhFdFExc2sySllNZG5HT1oxWlBlMzUKS1V5SUdraFloeVJQMnRZdnNCOE1WelZ2SXMz
V1V6YU5LZ1hUYlNJTnRFMXljMkdIQnBFcUloRUhHdXVKQ0JTLwpZTEo5YldiREUvUG8yYmkrSW9t
U1Ara2RvK1ludjdDSU9BcURCV2ZMblgzbkxLcHRtclMramtWclpiNkpkbmJCCnBVWDhnQzlJRlI2
VzluM2NjaEJvRmdSbHFvK1dTZHk0TUpLL2NUZz0KPVVPQk0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002bff14061f2ed964--
