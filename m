Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9813C9D5
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723191; cv=none; b=R4TvqFER7y6fXLHxR5hc+Q50ufEyjP+Vpp8uRHMAC+QS4LPBOV7yghFbClhtdK/tkMVLnaZlVcY3Du0V7LcP3XAWurqL5Ek8juAkVkvOngPjlPQeS53jS26TZuiiNbyhob5QD10Frhct8Qxk30bdA5J6VB16Vvr1Q/kCLtJPOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723191; c=relaxed/simple;
	bh=qwzdXoKZnHHPOejtSzAGhkHki1aSsSWg8VvUg8bLtYs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHke2TqCC3Gqwf0B8zVSdgVjAczDf2Ljz4DtkLpQx1gNjjKzhINDVLVpKKOiAFJ0wcLZepFWXIPM82WiVEnr76Sb6Qby3X4bHG9yYgxBTe8QRxkBSeIFhn9bSUyLE+g8dgN+R5sA5ApC2l1FLkMBVLsEtE/9pnadsJ6AGegUCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHismG1T; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHismG1T"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-703631c4930so2710355a34.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721723189; x=1722327989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTsH+dzwbkNrD5a+isx0J4/fOFTKqknzZNwxX6lQ8o8=;
        b=KHismG1TDlIT/ZwjoqlAPTdQiPV7FjUEtqlKo6Cx7QBjPjbFPADP8hIAu44QJ8yQyP
         d1yTI8ZrAAbPDrGNo4T1cAYcoLJdE4KBxjFw89n2UwUUqsKeIYeUXzR4eyh0K1MJPS8a
         oXbkIFrosxZE0boRv4vyiDRzyyFXDShjiwfCLEbM6kq0JmPMqBoMRVtUHnDa5xmjQGas
         H9wxJzcaI+Z/bF0F3ZLGu83ca2qb/YMYYTLD40P6kxeVTaqoZNke2y7yXwGAjrU/I2Nv
         JLlaOY8lmaxdMMuIr4L7CmcWhKzbalhXQtWeTZWkZVvHq8dfqrnvsbOfVECF6IN8lPwE
         xaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723189; x=1722327989;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTsH+dzwbkNrD5a+isx0J4/fOFTKqknzZNwxX6lQ8o8=;
        b=DsqgGl4DKrTVmJPYUVhH4e6evRr0R4BNXHdtBr2QuJKqEaKp+vAoXgOQt2JCn0NnYi
         VL0N2NY7Zzyncc6l6U8Hvh+G4S8Ruxgjq5V563jLYG5DFdjAU7E9G/p4YQP+bTznNtaY
         h84ieepVPFEE5G3LNuWSSQxn3bQ6qoBoBPU7MHDCCu4WO2++YsyUr8zmUkNm5Vmj+EbU
         QCJCKpTNH75Qp52/DsspknD2g4anXLX+lOFuoqmWOB6ZeCwAEJnkS84Rpf9DDCnSw/Qg
         GRhmbD5j0rcMS76bUh7SA8PSmJaNiyZqPJNNnwGsJEYHpCFpeFLXTxkRLwoMyolrnuqw
         siMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWelaloTNgiliamqe8eZI6hYW8ZLA3KpJ5O7Pybfsdssq79+DKa95R4TH1NSaxS4VB4jR2YNjA5X2+ChL7t7VQJPknn
X-Gm-Message-State: AOJu0YxWswtGXTqVEHjJ8UOEXgl7VHv9zbhP6/KrB9rT00UHj0RE8i43
	aMyJkVlq+TyysAnsZ1Ydd1QFkZ361Gt7gdwSrr9cGYD11hR6SM8L64zXCuw5ZtAh3GIQQwyruh8
	G4v/z3MnnTI4/s8Y8BoABLqCW24k=
X-Google-Smtp-Source: AGHT+IF/5Vb9LMIDlE5Bqj3FxB1Sk7m3IAUi1d88hByf6JH2yk0CCyuzzCE2kaPoPa5CIvAn33W6S9l9XyIy4f6Z2ic=
X-Received: by 2002:a05:6870:831d:b0:258:42bd:d916 with SMTP id
 586e51a60fabf-2646906cc06mr1834092fac.14.1721723189150; Tue, 23 Jul 2024
 01:26:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jul 2024 01:26:28 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <D2W30F19QN7J.146CV16OMTO6M@gmail.com>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <CAOLa=ZQ8fuCksk+CGP2thMqKnT_KME4goLwEt6hKYvt+Gbn5tw@mail.gmail.com> <D2W30F19QN7J.146CV16OMTO6M@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jul 2024 01:26:28 -0700
Message-ID: <CAOLa=ZS_rNEL66aJJgjdq8p-1dLBm22xPJWYH-iDNLO30E6Dew@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001762f9061de5eb49"

--0000000000001762f9061de5eb49
Content-Type: text/plain; charset="UTF-8"

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> Karthik Nayak <karthik.188@gmail.com> wrote:
>> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>>
>> [snip]
>>
>> > +static void compare_normalized_urls(const char *url1, const char *url2,
>> > +				    size_t equal)
>> [ 5 more citation lines. Click/Enter to show. ]
>> > +{
>> > +	char *url1_norm = url_normalize(url1, NULL);
>> > +	char *url2_norm = url_normalize(url2, NULL);
>> > +
>> > +	if (equal) {
>> > +		if (!check_str(url1_norm, url2_norm))
>> > +			test_msg("input url1: %s\n  input url2: %s", url1,
>> > +				 url2);
>>
>> check_str() checks and prints the values if they don't match, so here
>> since the normalized urls will be printed by check_str(), we print the
>> input urls. Makes sense.
>>
>> > +	} else if (!check_int(strcmp(url1_norm, url2_norm), !=, 0))
>> > +		test_msg(" url1_norm: %s\n   url2_norm: %s\n"
>> > +			 "  input url1: %s\n  input url2: %s",
>> > +			 url1_norm, url2_norm, url1, url2);
>>
>> Here we use strcmp and hence, it won't print the normalized urls, so we
>> also print them. This is because we want to make sure they are not
>> equal.
>>
>> I don't understand why there is inconsistent spacing in this message
>> though.
>
> That is for alignment purposes, so the ':' matches vertically between
> them. I.e.
>
> #  url1_norm: https://@x.y/%5E
>    url2_norm: https://x.y/%5E
>   input url1: https://@x.y/^
>   input url2: httpS://x.y:443/^
>
> Thanks.
>

Yeah makes sense, I was expecting it to be left aligned, but this looks
good! Thanks.

--0000000000001762f9061de5eb49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3db3a8cbd0ab549e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZmFUSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXpOQy8wWEtYMS9WL3pXMGlWNWkrZFAyemhPenplSgpLMnp3UTRwUStO
SENvbXhCdTd5WmN4L1J0bHBlVm41ZDlWMm41dWh4Y2E3OE94RmRwdW9xTVNTd2ljRmcxNzBTCmZr
QnlDOEVVM1U1K1FoOWZRYmlMeEFYNEk0NVlLNkhIZHJnMTNLR2J3RlBMck92UFdtQnBrcFFLNCtT
eE54QWYKSE9wUm1TRCtKWDN3Smc3QlN2dzVOcFlmeVh3dEhVS1ltZWRSMm9CaVJEb0g1SGNPcEJt
ZjFZZjZnTDQ4UzdNMgpBU0RISjJkdFV6T0tXblpjcDMvM1ZHVStIRGowM0hIbE9NaFhHNlVLdndW
Rmk1Z3N0TnQ3ZmxOUERSbjVOdU05ClI5MGZYeUxiY2JqR0JnMTBnZ0JDMlVELzl0N0dGRzdnUUNz
cnQwNml0RHVYazBUZFRMaTJ1SVpzVkc0c1U4Vk8KVnd2ZHZpK2RZM1JYTDZ6eGJpSHlnWDVndDVY
TmZIdDYySzdnanpyb1BqV3BDNmlwU2NlRjBRTUwxdDBPZXFoUgpFdy9DaTdsZGc2Y2FIZlEwSU1H
djA3SUxCdmEzZ3FGamgra0pOR3NHeG9QSDZJYVh4bk5BNlVkeEllTzNUbWVkCkVYNi9HQ3RWNldn
SjFWR2ZZbkZ2eVdZaVZuOEcvSTY0dXhsNjN6UT0KPTRPMFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001762f9061de5eb49--
