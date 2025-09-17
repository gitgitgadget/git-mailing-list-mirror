Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72D27FD48
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094640; cv=none; b=t4joMSawSBSSoQrWDd4DG2bM3Z5wR3Pn7X+/aeskr2HlRp7xuQWoart1prXmm3C0cFlhiFHefa7MB6kjt56oajQjSN06psxn2nkiA5G+tvrP3Pgue4bFi5KC7HwO+KLv4cy+wfXkYHfRHeaXgDt+X+LLYLxugKL/FItuHRjZxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094640; c=relaxed/simple;
	bh=ytsjf1yvC4AVqnuCOAAIUhglF4fkyUTTdmVTrZKwOjk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McIsCaEX/FGGo7v3eZWzI6T7WyVtJ0Anxq400/Net2hoqoXKAwVfrgnLJC4BTwrCYLwbdEVLUNmU87s0PYDdFf0QYLaAHCiNlOktVE2tqxSTqk9keIS/dRfKqxlZLqKW8Jq0PQCMtqirEwgJXJb570rYJZ8LZIYCWXXX90wE58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3t7cgeX; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3t7cgeX"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54a2beaa29fso1416084e0c.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094638; x=1758699438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYnk+X21SrOxuNsP9l/5QiBJTCd9wGwvlXuYwmdgRvw=;
        b=C3t7cgeXp6oMEbqgTp28/BEvX8T3TUnuJnIIY1YD4scXffle9vHM+eCwT/2QAia3RN
         RojsJ6Z0K1d7z2zkuqQhMDaDnIjk14uuBgCZAw5A0ap8veV3HJyMl1dApAGlUwoNg99I
         g6HIykIhcL0u0IVtExuHqk+USOiKGarqFNbAg2minuoiOGIguP62qNfCm6NuDeRsOqSk
         kwwG4FEZMKBNH0eO7YxGqhpDigvuldtk3PFnCxbf+bMeBtG2BNQnfUi9VLf8s62IJGgx
         OqjZ4ly7BNrn7KZ242Uz+oKWPeKx8rq5pIzlRZOIFUfw+X2I9P6IqkaTDf33G+DButj7
         khIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094638; x=1758699438;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYnk+X21SrOxuNsP9l/5QiBJTCd9wGwvlXuYwmdgRvw=;
        b=t5WYKNo1b8jxH09Fgt8h7QuZ5ie6ncxrHQnCoTmgWeZq/Rm+L+l1YC3rifmFXlwFGg
         QkPmGHk2IuhKe23wwLuFye7vqQKg7CCKhvMNJMFx2eP92NjwBrwap/vps4jt9Z9BmD76
         /6737ZZY/CY+djnY/rC9WpR4o7hZbWJ/yW3wfrUVRnxYTEoPSe39VHmyH5W6iwlV7Wr+
         WWD48MwgZGKv15cio4lWTVS/XbRtqdZewB73Yorl2v8frytzNTpSKXjuUftGN/Mt0fyl
         PnFvdknrJP95cSL3SiP9G0i/BPZ2kWSUhZ18SzO3K1OLnKrhhyKa39v6r2i98+o0VDIO
         D4GA==
X-Gm-Message-State: AOJu0YzZHWyMBMQtrXleQDYoC1ZaXND0CVmcDIUQoxHsJlKuOe1EJpyA
	AV6mLVnu+DAe9y4RB71+0xTN4x/kev5NDp39N3GjQQWxhSravR4AowupKMPwbxXX/vgnGcgtMRO
	OGYxUvoghLXIxysn/nlRyHMPATPb8Jjc=
X-Gm-Gg: ASbGnctU6dBZfNB+Rcoz3njo9+Adw2104tKweeaemqxrq4Mi6faruw9izoAaJOIvIcm
	SQrrMxkvobufcxqrn6O8VO3y9WTzfcq2plex8KCi+hUkG9/SAwXCNpK4PnK1nRh0A7DTWYgz5q5
	MQBh8zIuOAr4oVL2qzxuMyj+I+9/6BpZGleLzQHEKQ5H7PV63pVjFLfohnSw8Hten6u80b6ekAK
	gx4bIJb6RF2s5Ht8uO0vNw+c/x5XVPdDwWQ/4P07obJpBpVGaY=
X-Google-Smtp-Source: AGHT+IGiE8HpzNh3G8w8Yze7iz+7KbSefV/DQZNsnDjk3S3Ukp2mSsDigY8w7HSn+vBCC3fn2u3UxMWH7amSUeznCzM=
X-Received: by 2002:a05:6122:2190:b0:538:d438:15bd with SMTP id
 71dfb90a1353d-54a608e6bb0mr371093e0c.8.1758094637845; Wed, 17 Sep 2025
 00:37:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 00:37:17 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 00:37:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aMkW-HOAsU8YZ8Lp@pks.im>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-2-195569740b57@gmail.com>
 <aMkW-HOAsU8YZ8Lp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 00:37:17 -0700
X-Gm-Features: AS18NWBPDxTtYGd-dEl80cyGoB7_qevA9Qr0NbX1PXsB85ARXIjUqRkYsTXeB8Q
Message-ID: <CAOLa=ZTeduuWYmkbOknxGhAQ6QOazPSFUU=AbeBg7Bs_fru2BA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] refs/files: use correct error type when lock exists
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000005ef07d063efa4e77"

--0000000000005ef07d063efa4e77
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Sep 13, 2025 at 10:54:30PM +0200, Karthik Nayak wrote:
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 01df32904b..69e50a16db 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -797,9 +797,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  			goto retry;
>>  		} else {
>>  			unable_to_lock_message(ref_file.buf, myerr, err);
>> -			if (myerr == EEXIST && ignore_case &&
>> -			    transaction_has_case_conflicting_update(transaction, update))
>> -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>> +			if (myerr == EEXIST) {
>> +				if (ignore_case &&
>> +				    transaction_has_case_conflicting_update(transaction, update))
>> +					/*
>> +					 * In case-insensitive filesystems, ensure that conflicts within a
>> +					 * given transaction are handled. Pre-existing refs on a
>> +					 * case-insensitive system will be overridden without any issue.
>> +					 */
>> +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>> +				else
>> +					/*
>> +					 * Pre-existing case-conflicting reference locks should also be
>> +					 * specially categorized to avoid failing all batched updates.
>> +					 */
>> +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>> +			}
>
> Tiniest nit: I think it would be preferable to use curly braces for such
> multi-line comments. This nit isn't worth a reroll though.
>

I did contemplate about this in my mind, thanks for raising this. I will
change it locally for now and push a new version if needed.

> Other than that my feedback got addressed, so this looks good to me.
> Thanks!
>
> Patrick

Thanks for your reviews!

--0000000000005ef07d063efa4e77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 342355e721e02efb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qS1pTc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODN5Qy85M3BwRU9TSC81RzQyYWV2bnJpdlBIUHFuOApGeExQUmY1cmZL
bHI0SUZlMk1TNUVVbzUrY2NEZGFucmp0WGpkQVNUQUZzcmorS0NUdDdoR1pWK1NLQTZxQjJ4ClVh
OFp1Y2hlWGRVeXRrbkx0Skg0eFVqajRxZytwQ3hReXExZnZucXZIbVBiT05MRks1eE8xQ0kyY0pt
Y3RMT0IKY1Y0eHRrRW5hNFJ5bVdDbUIyLzgva0xrZTJiNVB0TkwrWkVIN0prVkFIWGtTK0hJR0dq
NDJWdEFHOGFEZ2FGTgpuNjhYdkNXOWlUdXNMaWdUOUt0RWUwOXB3WnpsRzFXaVN2Z2dxcFBVTmlm
K0RheEwxSm90Z1JSaERWS1Q1cjVZCnE5OUJrMnJ2RUJVdzhtODJPZDg4M2FGVy9vM0VETVFYTVZn
dkoycC9mM0U2VlZuOHdxVlZ2WHFrTG1qQlRPbG0KeVVhNXNGZXNQU0dIbUppYThzdmMyR1dZY2dr
a3dUMngrWVRvK1FyVXJhUTlrbjVCcUtCNGhPTGY2Ny9MK1grYQpLOUJQeG9lSVMzVWpjMkJreGxE
ejRVZURsYU84c0JyRkNWNGhhNitNc2dMRkljUnI3UVBrZXFSTG5ocWtUeHNxCkIrbXMrQUtBTTBK
alFvYUlUSDVuL2trSU1BNGQvNEZSdUdDRlFIdz0KPW1PVjEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005ef07d063efa4e77--
