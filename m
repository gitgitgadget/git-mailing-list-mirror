Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00933062
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971448; cv=none; b=RAVVx6D82QozsCv+eCoqZIl7enWUyU3v480NYd4ETUiYq5L10NfvC8wJ/p82JQrwH4kdr7ucxd3gqZiC2E4NSU5H1a2+EZ+XGI2iJgFjxBfLqnKCYiI0GxM9aGStU2F4kHY1LQXYNpd/PtEt5AC+t/4LOBAJEYDKrCm+l8oTnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971448; c=relaxed/simple;
	bh=lW2UzR/mvsVYIPQ+eItDxfLwREXW6Kg1vVi0rzC3y2k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prYe9Mgv2HTD+75tr61HzgTyC+0qTv41vKk1jSH6xu7R/xaAexMZ9YdD9Wyq7I9JZvxulXnudgND1h6qGiPIoMj/NAUNd4Af5ryYqfd7e+HDQgVONjaDQmdQX3qZdh46PY8MKFoUotUe3CqNQgftzkXrJ8eA/olwogki8gE7NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etZ8hewZ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etZ8hewZ"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e696ee8fa3so719323a34.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710971445; x=1711576245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6719OMYU7VRqgFec92KiSxo2NFDRT8EgbQ6litn+IYQ=;
        b=etZ8hewZmzBtSBmS73n5Z1T7fjqC9uStSkCDNrloimCs3V0uXrQJcSe0XeeJWwfnqb
         vdywk4u+ipCQOMa8U3c5JmpLc7qi7K3MXCpZxolDRdp/yKP1uoKLAZ6GClP79OQ/PCqw
         0DPIb8NT50U6IoNcFCc+qbntqe9MPLb+OU7PUCFy3gYPHXglClVeF9gpR1oY9qrYpbSk
         SD1I3/5RH6mXSE1EGDZY5Obeawx4QNHGXLyU7hsPtDlMWzpuBOH8YgcAY+ZV2DxtVvy5
         0U/nE83atmukPizT53Hfldy+WqSbTizkwEtIiXzXWktV7gqq1WTUQZ8GzWkwRRm5reIN
         lOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710971445; x=1711576245;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6719OMYU7VRqgFec92KiSxo2NFDRT8EgbQ6litn+IYQ=;
        b=WqXpKpPnK0rBFJogjDkNpSf4yOyXyRQY8JwCZOkVmQ2v28gSiSMNBYFTKJzNVQcivQ
         rxd8/LI0S8dVKB+10QYrLTl4FkUK061O71SAMBdVvyWgYaMhTz5wXen6Ha/syTDRcQ+A
         gr/943mM767eGDlJeoWq/UCNheJ8I4SY+lMaHBB8Sz6maj6Nyt13Y4N4+zRBOS78Owbn
         yl1OAAUCQ6EGLKFX3d+ROg6u4Rr5xFFliHiuSQndWLiyfZm/m4nY6CGoFzz2AAtb9xq4
         djtWqOlppuKlQ21fNCFwkKO0Qc4wlCkt5NWvPTtWLRHxVzy17Ljejax9L/FgZHd7b+4P
         GtvA==
X-Forwarded-Encrypted: i=1; AJvYcCUsFiUcjCLg6ozWQChggOGiDBpXFddXcBG+AV7Fe29YBHzLAqE5AJDDU9qMAEDv5X5mbt5+c7NBIUjylcke0qo2mb8W
X-Gm-Message-State: AOJu0Yy4vb5OBQTJmOslsf+/5OMrcqlAyW+evUspEI5gA98lV6c1rn8H
	3UtUXb1iAaq3GuWymmjO8778BykqVnloAwqxFeRMehPoCrqns1z/rBV/zzrWqbzDnpJP+6paEg9
	UeBO2Av4P+5A1Amf2TP847vEkU5H703W4KaGd0A==
X-Google-Smtp-Source: AGHT+IFoCvy0kHQFnlNvlocA5hoapH5HQOE+XRVCgxL3dHan6hZij2BHYEd8Klctr+F+bFgQBow/H3GcQQqkIXKfwJk=
X-Received: by 2002:a05:6870:3926:b0:221:7fc2:94df with SMTP id
 b38-20020a056870392600b002217fc294dfmr417129oap.3.1710971444902; Wed, 20 Mar
 2024 14:50:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2024 14:50:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <1e39d93a45db502280ecff383d53e0294f969719.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im> <1e39d93a45db502280ecff383d53e0294f969719.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2024 14:50:43 -0700
Message-ID: <CAOLa=ZQ5wFCqWZ4yjMzUg5Yz1UeVpwUap0z9Lx9EfRVKnzHttQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] reftable/stack: fix error handling in `reftable_stack_init_addition()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000031d74f06141e95ca"

--00000000000031d74f06141e95ca
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 1ecf1b9751..92d9a7facb 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -590,8 +590,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  	err = stack_uptodate(st);
>  	if (err < 0)
>  		goto done;
> -
> -	if (err > 1) {
> +	if (err > 0) {
>  		err = REFTABLE_LOCK_ERROR;
>  		goto done;
>  	}
> @@ -713,10 +712,6 @@ static int stack_try_add(struct reftable_stack *st,
>  	int err = reftable_stack_init_addition(&add, st);
>  	if (err < 0)
>  		goto done;
> -	if (err > 0) {
> -		err = REFTABLE_LOCK_ERROR;
> -		goto done;
> -	}

This changes the behavior though, since now we skip the `goto done`. It
would be best to change the previous line to `if (err)`, which is what
the other function (`reftable_stack_new_addition`) does.

--00000000000031d74f06141e95ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 547e05088620266b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YN1dpMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzM4Qy8wZldvRllrRDZvMlJxUUt4OU5ZeDdDMmx6VAowZlpERkhuRDhp
QXhCb1QzQ1ZrWENMbEgyNEkrT2h1Y29yYlpDWVVjeGV6TnhXS2Rwek94SEpjeitiNjFWWVVzCi94
TGlTOHB6dXZjS0tweWN6V3AzdEprZ1JaN0xoL0cxVHUwQWU1ZGdWTlRwZlNVaXNTdUo0Mm5zclNr
WUtJRm8KbXMwWEMxRE1vNnJXQlBkbWVCZ256Qkc0aUhRem9CazN5VlAzOVFFWXIvS0VSMmN3OXhL
YVpJS0toTE15eENGWgoxWGNRaWRrd1RmdWc2dlZrRHIxaXUzRnFSOHFIMlp3azZyZUxROWkzeXRJ
a0NTa2M5cUNxdFd1a0FCcUJqMlhPCjJpZFJnZjFnWUxWUmROakQwMDRJamZMaWlDelQyeklBUFBV
a0dwNmVwcHFZTXhGdzJlRVdqSTJPQWF4d1dKZ1YKT1hLd2gzeGdQcVc3UDNiVHMwdTJkakRmaWs2
T3RnTDRjdVV6TkF6VSs5LzBPckxNS0o4cVhobGQvbkRObnBwSwpMTm5VUzFZWHdLcllSQldKSEtt
c0lPMXZGdWJJU3JVOHgyVCt6WGt1RWRVQ1h6MUtubDNualB3TVFHbWxlTFJRCkVqNkJ0Z1hUUmo1
S3VWV1ZsWUMzbEFZTHFtbDBZeUo0ODBxR3JJTT0KPWtQTEwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000031d74f06141e95ca--
