Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E923370F
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122912; cv=pass; b=P8k41zWKAu7+wfqIxJg93dFH3hicliVRp6wPFaMI8m99yrzgBbtjWwjxKgXtXEJro5iYz8lYU4AhGeYJEbe3Fz3yeSKjt/xjFY5BXFML9vaFsmj2U/JEcBPbqjkDmO4j75sTJo8Aj8ZGFzLMmnSkb4kx4OYDPyoly0SQC+sUuSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122912; c=relaxed/simple;
	bh=peS40XZpggvwsJclIk71wRF++kQbT35iqzzmXGZqNz0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iey5U9AidU/AaLeXLw1CvRuUSeahTvF6vUfFrne3sw9WKkjwuGumWXjYTXTkAFQdTrE2Fl+i/Eadc4OYTeekNURI2LdFX4gHiDVmruB9z1rIb7K45jO4vNCwvVN8RCjUznS3OHT5mBI5Yn12Z4oBlcpqXXIkbVMcpBcQXzOc5RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQKPc/mc; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQKPc/mc"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9638f7e9896so3659544241.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 03:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782122910; cv=none;
        d=google.com; s=arc-20240605;
        b=HtB/rjihzE990CRRdnIfnKOkgEAdZLhlSkwdigwnKKXD8hlLIWJCtF5VdxnjlmRw0q
         P3xnaI953CpXV6IHzIaHX2nUIHWBUc1qgU9f69i0t5urKLRimbA8oEe2ala/D82+Ih9i
         K4zag4jPKpAWFwctspp/to/4mLrbAeXjk0A5crgrhdb7hSWLlWHOcmdTwz2VvQf9Ff/z
         XMRUEKjOMJDpa4HXl6Zi6/260/Zqb+6B7BizLkmTIsuulUgjADoCaGB+r9OUTjglDNI8
         /1hHL1DoxZ7Zhg22GWj3//AwMORS2dXU3vRaultR/3RCd9qL+iRiTVJ+RbBQcTKYWrDG
         840g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bjtIQ8p/2EUdeN564hdAFjKSWwOJKzqba/cY33/mb/8=;
        fh=k9UEwNzYTXXzPT+1Rq6ZdhDkDuWmPVruqC/WMKn/8FA=;
        b=VVhbrIZTqo+pewj9Mua3PXooR0eAgcbhZPnOoKHyTgjFY8fKyTe7MftZlMvjawYdKt
         Dc3nhYEJcsZwJk/qo/yQVZ9HHOGW4vGqZAbLGcMsnkZ/jEUFrYliTiPBm3CBPj3pA7oL
         mPuXtX+fcODOWCfXwqhE1kp+LOdDxcHZilwxH+ncfVm39SIGtJR/RovkbJZr09NqKayD
         qGPjsnI4/cB398h/8Ys6LYlrpB24USuiDskFr+d+lynWS74ckOUnZGWJ2depL87SjL6S
         5n1kJFbE1kJ3DUVP0fAnZrExAAzOaaQpZYujyzakLSmQjnlQx27RE+m7sFEMohCX5Dv+
         3DcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782122910; x=1782727710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjtIQ8p/2EUdeN564hdAFjKSWwOJKzqba/cY33/mb/8=;
        b=KQKPc/mcdyQppmYXB0g/CozXuP8blxYC8Qwddi7plCMMIsIMjd+oPv1TvkJzV4w01m
         mElnnu2Z9T/DWGA19RVVHDgiypIAIiIEQBG17qedLBivB9u0QFkSU0tihRuIZGgYz7Pc
         ItVe8QKxkkl1Zen/FDcMJJ0UU9Vf0aTgh/RkAKqkgXAN7eLPrky1qwqrI94P8Ne1P6Ls
         +9t8GYCkDUveqcixxz1ajTUpaSCPcKSP4ZOzkHD3s8jU+sYVApAquE7q7v33sjPhkyWQ
         erJmQAp/mQrV0gVM1Q1OQmP8W3zSwG3XE6yAauidJUAHX4ucSaWb7Qr1I910/Bfb5Qd9
         aA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122910; x=1782727710;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjtIQ8p/2EUdeN564hdAFjKSWwOJKzqba/cY33/mb/8=;
        b=fJfKXMExy0XUoaPdEHQd8YaBVD2VSXvTW0tsKNXBrT70+/A6UTY0zC/Ax9+mmrm1KG
         GL5LIV4I5T8wVE97TXhdfbuhwkD1xaPTlyIyDSsRE3pawnVtE2CwtjtcU5dOFpeq2MNL
         T9BM4V37JPH9vCJuiI8aWi5f4tn/zQQVFuoG0RhEW13+VwOOXewm1SoQIXS8BLy+sJNB
         oImSSbefu4peUpMu1J3RODXnKbvbdEIY8VgCJuAKZu68fE6yzd9fsqQl7adJ8Lf8lQDR
         LCcH2Fjovasa175IkifbFR1qc60ismtIfchEaqsOt4ePuJyzoojYrL0p6PIOyYjzRYIE
         StSw==
X-Forwarded-Encrypted: i=1; AFNElJ9xJEUyLHFk7nn1+b9cdz8QM2NLm+cHS4Q/0HZS762Ju+++phbqrKalIvtr2LKZ4PZBnHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSnmSURXpfo90NtPftNC92+8+oisENmTVMwa6WhedGmibNszsH
	ze5SH93Yfyh5EvtDqZdkVC4NaLxF+KlIezpyiEJnv98aUm5S99Tvj59gT3acpe7/qdTWKzQFlj3
	uOz6B6wwQUy2QA8yotX/BnwbtthfkmXg=
X-Gm-Gg: AfdE7cnTW4U21M+iidz6BCGDcd69omR2h7MEgoGc6PipRPrv0hhU0vzRUVohOrGNZky
	cf4ektWqptSWp6eB1mPLelYCAxVh85CL4JfAdf5iJHelX/4B+WM03OSHErYEy1r86pE55luvInV
	y59Y/EAlQ/DMS/rtUjs/cs52OoSNyxY0sQQTpkwXlpPDaZsl898iWsi+UoBZ6keIxi9v4qnS1Es
	m18SFFHU5phLAWDWIp94JMUmxr31vWUoydrDlLEWG+8zyNPu2WqyP8hPilKx+Os1WxtMkfRujD9
	fpkJ60S79vdona2hCz4WgquSsF0Xa8T9KJtlPIusP3UqWhhMPhfRlTzd8YahutI=
X-Received: by 2002:a05:6102:5486:b0:634:420a:ab25 with SMTP id
 ada2fe7eead31-72a28ed49f1mr5233754137.9.1782122910276; Mon, 22 Jun 2026
 03:08:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 03:08:29 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 03:08:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-3-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-3-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 03:08:29 -0700
X-Gm-Features: AVVi8CealmkuM_B7p2aji4tMIgrBsjaqknSXF-naWQSf8Os7GOpL8vYk4t7f8Ag
Message-ID: <CAOLa=ZT_CGe8JHeRS+hv+i=Xipo4Lz-kYqQu4zwvo-u+BmakVQ@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 03/12] cat-file: declare loop counter inside for()
To: Pablo Sabater <pabloosabaterr@gmail.com>, gitster@pobox.com
Cc: peff@peff.net, eric.peijian@gmail.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	chandrapratap3519@gmail.com
Content-Type: multipart/mixed; boundary="0000000000000379220654d4d352"

--0000000000000379220654d4d352
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> From: Eric Ju <eric.peijian@gmail.com>
>
> Some code used in this series declares variable i and only uses it
> in a for loop, not in any other logic outside the loop.
>
> Change the declaration of i to be inside the for loop for readability.
> While at it, we also change its type from "int" to "size_t" where the
> latter makes more sense.
>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  builtin/cat-file.c | 13 ++++---------
>  fetch-pack.c       |  3 +--
>  2 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 446d649904..fab55c11de 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -723,14 +723,12 @@ static void dispatch_calls(struct batch_options *opt,
>  		struct strbuf *output,
>  		struct expand_data *data,
>  		struct queued_cmd *cmd,
> -		int nr)
> +		size_t nr)
>

This is fine since both the locations that dispatch_calls() are called
with, supply a size_t.

The rest seems to have been already validated by Junio.

Looks good

[snip]

--0000000000000379220654d4d352
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 85666036674aa19d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vNUNac1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEthQy80N05MMXhFZmZkTHp6TTM0dk5qR3ZDYUt4bgpNV3ByK29YdExU
blF3RHJNN2Jad0hhZUpjN1V0aWFRcDBEYXViZUxjTlo1V3J2bTA3Q2hmTXZRVEU2NkRiNHZsCmU3
QStUeGVyVm5jeVJNRVpVa0dXSzh6VnZ1QWwvS0FzNkVVZ2ZQMDlsM1JwU2h1b3IwOFVvaUp0YW9v
L0tBRS8KTFRJOG8yTHQyMXlHZDcyUlNWbThYMHhpc1RGUWVLZE02NlJKL1FJd01SM3hySE40Rkgw
ZVRHWHRnSzlkZlkyMwpzbXNueHNMck9HeHBPZEEySU05SWdtUjh3VVUydXBKZytlNEE4bzVsQUhE
UlI1eHRwRlJhcTZESDAxb3E4Z1NGCmtDUkw5L0RNY3dMNjNBUE8rRUsyYTBYWkNIcDNRWUhwNFRH
ai96K0dOTUVFaHI3aUFvU0NxMEhqNXAyenpocSsKak5UUFlGZWFOb2d1Kzc1My9FVk5OUmhpK2pI
K1UwVGc4VjRIbFpRQXpzSWpvbHhOZWFGODhaVHJlc3BxMXNGZgozVzlKTVpaeCs1bWsvclVGRnVO
Y1E5c0dUVUppYWJHd0tmTUZaWU9jVzdpVkNvNmlGdjlycjFjU3ROdGNORXVwCmo0c0kySlEwYUtt
TTRYK25yVEpRdXhkQzJGRnc2SDFDTDg0dzViMD0KPStXakYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000379220654d4d352--
