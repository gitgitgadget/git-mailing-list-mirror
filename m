Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1D1487EF
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306893; cv=none; b=F3NGiEVz3NBFoNPEf3Ug2F9T6HOp71priHoCa5+3E/TCdpdYpJF5OrqkX6rrQ/xqSWosoJBI9NAxkJXk0laBmw+TnVp4gffras7m56a/rBLa47epb+V0i+GqDUzwpeFaSmDeJtV5+e/LHWXLGFD4LcMCdntQ/vDiQxhTKWtoO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306893; c=relaxed/simple;
	bh=8VyreslyWxVboI1DSynvvLRbgoyRQ1NOiM4yZpAMnWE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNAdUkBCOYdWUFibUzG0X8gDk4K87YxJpbZjhuXwB3wo4hQhESQyL5WL8qao5YnK0FOTtg6nsG/PTAVtje2f/bLmoS4YNxIIPZS2wYN5CmTroC5MniKeyT7x8BxyIooBCHcJbGYdIos51+atOPgrECLkcg5OXPyH5x/fw0rjdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWxWqo5W; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWxWqo5W"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24c9f892aeaso2772096fac.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719306891; x=1719911691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7JtyisK2gDSrUqUpM5H8rkZDka/gikTkYvlcLz+BvOE=;
        b=TWxWqo5Wjjyfue2G7AEc8Xm4dCbva6Faq0IuEG+D7WYamSzE5GCq92ZLUxdNPTzHqF
         4Zl4Dab4v7M9Dl9qKGSK0gKAHk8zdvU16V7JuAwR8K+fHyp9m1j2SSQgW1UkW6vsWzEY
         3ZC6zQNG4PCcz6+Dv4zcSGLOU2KxK3Gs/FNZiQHl7C9j65NDHM2mL7HOwGzxro+SkO1I
         csm53Nk5GOsLbcZpXEQUdGCaoO7XT0IspzuqwfPXEKrKx7A8/umIgVVQaWGQ41NmUwOR
         rqSI0uH0jXeZnio8tYbjdcPoZV5aT21Mz01J9J3k4lKzPBNxew2bCqqHHOBuk+Xcc6Ab
         hCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306891; x=1719911691;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JtyisK2gDSrUqUpM5H8rkZDka/gikTkYvlcLz+BvOE=;
        b=lqP8aiK6jcKlGSlSgxDpU3YIfT7VwHh7P+SGJDhQxybvod5zEay11oqhpw9Enj0RtY
         Nem1r29t6UeD/5GT5vVZUzRlDeDkIXjneVBEagNYrFXUteZUs/QN+Ftjs8ApLSOZotE+
         MeqlSyRUPeg/JFRJDddJWfgNdrsuYqVNliecDsKSu890N+P4+RJrK3gA5U3fbP0/y8+L
         3tigEuqspnT/yTRMi5Ft+QWf0avPtH8U1bY/WqI2x6YKMBbQXfjv6iLNpORbslGm6/Bp
         YBntf5WZbivKpER3DA2HRc0btVCb8FXmFekrwQyKPikUOwdpK2MiuvTUZzmglaKNbBHY
         n9gg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3A0MiCJhBTmXwGBMq/cqbGAirdUfU53YzbIaQWXVYmVf+WNTBb+lt/xKjOSMiwhSWzbgty2Xgpi1iQKWACaOJvCc
X-Gm-Message-State: AOJu0YxaUgJ6fSETpy1idtb28LyXt1BlhNbT1Zn1q4GTESPZ5/K0LJdH
	W9p+M2RdPLzbdOquEYrK7DovNw2atVC7CWS68SmCTgATN7ktx5i6Zw12d2+ZjHnchZ4F4bbYQ2Y
	bnwIS2qh7fs/tURZVoXwDprdkqrc=
X-Google-Smtp-Source: AGHT+IF/VjNspgBp4x6iYFVTq1yDCeg0UC3rlPn5F2drmHzRB7UzL4lwNBBtG6Fm60V/VfOQw0WDy831QL+FKpFoL0A=
X-Received: by 2002:a05:6870:200f:b0:254:b14c:35e5 with SMTP id
 586e51a60fabf-25d06e5eacemr8428597fac.36.1719306891050; Tue, 25 Jun 2024
 02:14:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 04:14:49 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240621115708.3626-7-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-7-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 04:14:49 -0500
Message-ID: <CAOLa=ZSKcpOVv8wcDpe8mgtu53aWrCKG+scMqNix_BfBrT=KkA@mail.gmail.com>
Subject: Re: [PATCH 06/11] t-reftable-record: add ref tests for reftable_record_is_deletion()
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000008061d1061bb354fd"

--0000000000008061d1061bb354fd
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable_record_is_deletion() is a function defined in
> reftable/record.{c, h} that determines whether a record is of
> type deletion or not. In the current testing setup, this function
> is left untested for all the four record types (ref, log, obj, index).
>
> Add tests for this function in the case of ref records.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-record.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index 1f9c830631..cbc2ce93b2 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -108,6 +108,7 @@ static void test_reftable_ref_record_roundtrip(void)
>  	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
>  		struct reftable_record in = {
>  			.type = BLOCK_TYPE_REF,
> +			.u.ref.value_type = i,
>  		};
>  		struct reftable_record out = { .type = BLOCK_TYPE_REF };
>  		struct strbuf key = STRBUF_INIT;
> @@ -121,15 +122,19 @@ static void test_reftable_ref_record_roundtrip(void)
>  		in.u.ref.value_type = i;
>  		switch (i) {
>  		case REFTABLE_REF_DELETION:
> +			check(reftable_record_is_deletion(&in));
>  			break;
>  		case REFTABLE_REF_VAL1:
> +			check(!reftable_record_is_deletion(&in));
>  			set_hash(in.u.ref.value.val1, 1);
>  			break;
>  		case REFTABLE_REF_VAL2:
> +			check(!reftable_record_is_deletion(&in));
>  			set_hash(in.u.ref.value.val2.value, 1);
>  			set_hash(in.u.ref.value.val2.target_value, 2);
>  			break;
>  		case REFTABLE_REF_SYMREF:
> +			check(!reftable_record_is_deletion(&in));
>  			in.u.ref.value.symref = xstrdup("target");
>  			break;
>  		}

I think it might be easier to follow if we just move this outside the
switch, perhaps something like:

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index d480cc438a..5cb910f6be 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -139,19 +139,15 @@ static void test_reftable_ref_record_roundtrip(void)
 		in.u.ref.value_type = i;
 		switch (i) {
 		case REFTABLE_REF_DELETION:
-			check(reftable_record_is_deletion(&in));
 			break;
 		case REFTABLE_REF_VAL1:
-			check(!reftable_record_is_deletion(&in));
 			set_hash(in.u.ref.value.val1, 1);
 			break;
 		case REFTABLE_REF_VAL2:
-			check(!reftable_record_is_deletion(&in));
 			set_hash(in.u.ref.value.val2.value, 1);
 			set_hash(in.u.ref.value.val2.target_value, 2);
 			break;
 		case REFTABLE_REF_SYMREF:
-			check(!reftable_record_is_deletion(&in));
 			in.u.ref.value.symref = xstrdup("target");
 			break;
 		}
@@ -159,6 +155,7 @@ static void test_reftable_ref_record_roundtrip(void)

 		test_copy(&in);

+		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
 		check_int(reftable_record_val_type(&in), ==, i);

 		reftable_record_key(&in, &key);


> --
> 2.45.2.404.g9eaef5822c

--0000000000008061d1061bb354fd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 862df7d9e96bbdd7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNmlvY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1RQQy80L2JQNCs3bnp2dzlQTjBaVnBpZXRFMFBoQQpJeU9Oa2VpSjFU
TjkvcGEvdHR2Z3FXWHUwdFQ0QlZwRzd6aTBkMHdXVVJ3SlVGYU02NTVka0xlNXQzN29qdkY5CnRh
SUNvb25SQlk5VVJSaExrK09TMmRzMDVTK3NoMFhoOHFtNldDSC9RV3lWTEhaUXFyTWVpclZoRGZW
QSszdlAKT0hQcDJXOEJPWTF0VGU2dnFucmFJMzQxaVlmRHlRUkI3YXdFUGQva0U0dlUyKy9qandq
ai82L0RtN0MyU2VGVQpQUmZBOUM1WXFTVnA2MXlhYTNVR2pIanBOTFB0aFZhRCtVMGsxQ0NGdjAx
Rm45ZElrc01pZWkzbGVuUmlXdHpzCnQzTG5iWnduZy9GVTcwNzZmQXAvOEVFcWpCMHNQd21xc1JZ
bGY1aGNSeDk1QnpjaWxEUnNvVmJ3OUJuSTVRRFcKajR2MEVhSEJtNDk4STM0dzh3VVVXMTd2NThs
UEJBZk5pVWRlRnlwcWFVSGxTZHdZMCt0M2NxY24veU5wblFqMgp4ZzhnelJ6RUdIbWN2bUdSNm9i
L3BnV2IzT0d0cGdML04vTGxDR1BRM21FdHRoSElXOGdwQUlFeDZrRUllZDFUCjVTQkJqMWRCQ2xh
WVdxQ1htYm9tUDk2SE93UloyWlI5UGVOejU3VT0KPUdKZmEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008061d1061bb354fd--
