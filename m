Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648512B7D
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972854; cv=none; b=sYp7UIZjtFu9Dno4VoRwyc+CI2xn69LwGG7mVN38YEekzbetxRD9kO5zASJkkd4VUDEau1QeLAq6EdvP/A/pq0M4s7xynzeXGTKeQPuILbS6EBUzmGYBRUJ5gLvb2ja7qjeM1YdeHr9Dz1XFiy72ao0WHFxdZ9dqQnD4NYOHpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972854; c=relaxed/simple;
	bh=AK9T1L7TVmQgxXpa80wkvQlnAxlAXM/LoIes5Wu0Uwk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q28/p+ErSF9quzDcTtn/SNzZpkPDfeYZqfS6qvU6YFIVvWivGsxf1i3bgJd1GNZfK2VOyAUDCg6SLlzUp7Cog6jViKjEAPVDnExVo0eQVWjZk21hN9Uhjfy2duiocxzBndmVBm/SFyMfYQmdMa++cfmHQbugjQeIOsDpfFhhIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRqKgE/L; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRqKgE/L"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-221a2d0c5dcso237371fac.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710972850; x=1711577650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VuOku4II158HjD2Wn3ErvGjorL/L4fTUh8nIbZ4vsyI=;
        b=BRqKgE/LT9e5hTHNfx1FuLKAp+wKTU2qbWMbZUBy0GveqWLmRc0/I9dzJNC6xBUcZa
         vKJ+OBuyxXx6QTZCMPqAM3ZyxVn20NRbO3qi/4NlPxbGfx3480QI/5oCkGBH6YzsQG82
         c/rpYn6WsOYzb7pBr4V7mzCtZHvyY0C/9SHuJwQA61Np6N/n8YfJ2DHAt4LVxqbRNx02
         62bNggVv2jeevNBKkLCLsi2coH85lQHjIidHfgyyJ76P5bp3PBva1bp/lXsMQVsFm7r0
         Y6fswHLFYcLAjTRnjsTkNTicyygpzxQPyGsanTZ2VZ3+TQxi8o1fst6ED7vQ1hhzp5KH
         HpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972850; x=1711577650;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuOku4II158HjD2Wn3ErvGjorL/L4fTUh8nIbZ4vsyI=;
        b=wiwRW+hkJ2BJ07BM/rwysayioZ99yF2StNeGUjrvdGriq4hEMbyBofsjrArtHmyjMi
         y4N+Xcq4Su9Akifb/3fMOxOGlayXVAJCP15t9Gs8+qYt1lEeYe0TV7JT4ie1QpVNZ+K0
         xi/MalHjeovzVnz5HuNyh1nuhVtNAEH7t7NDJAQ8Bgb5YRHLZeDPfodPtfeCLJPLV2at
         rbyIrNaJzYpMB4C2J1nnZW2fourej5HNE0wMyJM2ex2WQVMhyzLABVvhib7Mr2GUUDC7
         1gQgz1bKifcV2OVGiQsPoZ9DrCM5GtqKKX3GCWW+h3o39OeWifqBVMX9J77vGKG9QnrY
         UpMA==
X-Forwarded-Encrypted: i=1; AJvYcCXj5aLHmUtnLPdwO8ZYsJAfYNfXLtZfLjZHlE8Hidvwv8p4m+qOSDV5VQrPg6KnuApEzzp6qAO49oE8XvpMrYXLt27I
X-Gm-Message-State: AOJu0YyK881P3IqxvvdNGSky5f26x65SX/laQWDmqJECEQX7a2NQPM4v
	RuK9djZDP+3a2nV2Ao/3GRKo+RkCMSr5HquUk+KYfwpIuMdW0TpINnZvTkDnVMvXc2K8C46jrMe
	a/ZRJB7QmyCGB/wb87t2BllVa3lzBxsuUGWRibA==
X-Google-Smtp-Source: AGHT+IEg/gHAKI3B7i3QMXAibibcSRe0lFcN/qOM+GYoDL8WTYQMdzEb/siTa/h3FYCKerW6a/WGrBHfTC/hlIxoIp4=
X-Received: by 2002:a05:6871:6207:b0:221:cb6b:61d1 with SMTP id
 rd7-20020a056871620700b00221cb6b61d1mr493656oab.14.1710972850691; Wed, 20 Mar
 2024 15:14:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2024 15:14:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ae2130ffda2135bdea11ea6764c08e98a2cc4905.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im> <ae2130ffda2135bdea11ea6764c08e98a2cc4905.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2024 15:14:10 -0700
Message-ID: <CAOLa=ZS6uF3fuor3V2F_GM__JNRpUAyLcrVDbCHsJ6JStL96cA@mail.gmail.com>
Subject: Re: [PATCH 03/15] reftable/stack: use error codes when locking fails
 during compaction
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fc7d5706141ee8d7"

--000000000000fc7d5706141ee8d7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/reftable/stack.c b/reftable/stack.c
> index eaa8bb9c99..ba15c48ddd 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1003,7 +1003,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  					LOCK_NO_DEREF);
>  	if (err < 0) {
>  		if (errno == EEXIST)
> -			err = 1;
> +			err = REFTABLE_LOCK_ERROR;
>  		else
>  			err = REFTABLE_IO_ERROR;
>  		goto done;
>

The comment at the top of the function now needs to be re-written with
this change.

--000000000000fc7d5706141ee8d7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fb02cd6a7a350641_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YN1g2WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL25QQy85eVhkZGRmYzNkV3lkQW1vTDRHdVg5bTBEMApVMldBT2E2RnRQ
MWhxdzV3Z1pHcWYrU3FVaG9PM1dEaVNiY3ZIU0xDcHFwSm5XdjE4NjBKTWdJNmYwSjB4eEVDCnJN
UVVvczhnQVhvTk9PR2tqY1YwaTJ2R2hNU2dUZ0xpalhDa3ZuRklhSkFIQ3pHei9hRzd4MVVoVGdp
ck9yZE8KRlJ2aHJoYTBIRWl2SkxHYVRZdDk2YURQRkxDNVh4dDdPbzErWEU3NFpna05lRTBoUHo4
TEpubHhRZnFZenBKZAprWVpBd0dKLytFSldIYXRIM2g5Z3J1VUpMbkttY1VHQ1NEM0V6ZjdFK1Qr
T1hkS2MwSnVpVjFzc1JWNnA5Sk1pCkFWMS93eXJPU2djNTJ6RHVPVFMxUFJQbUtiUW9wN2lnYkUz
Y082Y0s3VTBwTVdEUHg0dC9MZFNrYlNpNm41RmwKUnV6V3VYSU5kTmVRVnp2WC9MSXhXNDlxN1p4
Z1ovSmc5TEtOaThGdVhGNDdUaGxjbjhzc09kTjZxRFR6OGo2VApnYVFybGRXQjJhUjFHWHNnK01a
QjBoMVVraXBFdkE3MmxWU0RSRWtUaXo5K3YySGN2Znp5cmd0VzNsMy8rdkEyClYzRjBOVExiaVZQ
VTRUdDJub25BbE5xaXZWdlQzSm1VYXpON2crST0KPXROaEwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fc7d5706141ee8d7--
