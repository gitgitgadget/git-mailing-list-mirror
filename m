Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E549656
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307618; cv=none; b=LQ7TNp8TNIjm4U91HBEguDOODutdhXxadTDAoSDB5Z3fsiw6/kK0FKoYmEMO/sb+8l07iWL7YjStyS+9Io85vBMKfAw7iDxZXWeRZHm3OyDiAYFzwFZ2gXW0ty4sOBb7yrPDec6XVYRy4eK2Dv2jrrtTL1QsyjmGkNk27sj7cTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307618; c=relaxed/simple;
	bh=09kv6puOuCzZGFoaV34hoH38Z7skHgnH+pjF/gtpSIg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sh8caFdaog3o4uDFvzinKBZrtvRCrrsdrCIgyEJPgOug0ZjsD7QRWE/xe/HJK1XHILHlE30Zwrnc2ejWTgVTZ4CgWahVhqW77tELs41Cs11hn4w0z788WOK8aI+BGuQWWZff3ko+MBcWVz7YNUSAqq46IQxWj2jVP67r4Eg5TPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oyt9/NMl; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyt9/NMl"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d24724514eso3138786b6e.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719307616; x=1719912416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vs4tfYSEwnXVxRVZz4ERTGMhsgnCdfMl/pyE24vgalc=;
        b=Oyt9/NMlgVjI3cZAhFYo+9Y6+R517JN3hKXJINisJsXCg/9ET6VSX3IjO8F0fw2OB2
         2R9kdcY2JXwBUH3SXzkamPxmdMuqkXAZ/MxM1sHxK4xxky3N4g+kIPnt31RMFpyTqEP2
         Q13I+VgNp6vyLShwwtBuQtKUtmJuinpKotoyv6aroYGmydl3/eFyatWMpngyglbDv8Sa
         O4F24lpNO+offiCG8RpyZkDJCwPmnV0YYb0FLpl/gjw4ldB8tg6Kch++Vc4BX4AvBxpt
         z9VW+RFqsO/dlZO8M6kLCj+pu8oemZH9thW6fiSDeCQJUP1gFpdsppWqBaYrdW9IqxTP
         t3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307616; x=1719912416;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vs4tfYSEwnXVxRVZz4ERTGMhsgnCdfMl/pyE24vgalc=;
        b=f0Rozc2wCVTk6U5V/97DwWaOfyDd6Hn7BAv0gFxjRcLqsLVGn4/UlxBzuQdR3ErVXu
         tv5ZXqHKathSTpLKQCZAn/Y+3+NV+r41sNG0/gnCxmKclmSp4vE8YIQLOZGV0kjyoXON
         JVa532DK13yqZUO/Jbu1Laps+8FNrwDzp4sLA0YObOi0/X4rDvrXC7CBY+xBrJ5vfxjy
         gOfZtYKq0q5X4LFSQum6p0h0I7/FyjldSYJTDkEohIt6PdItyvHwua1VBQj4dAf6pmsQ
         ygacFwP7z2/MoEpXsZOaCEj6LAgeLxMCXv6lCrFUHZfQwIgqfK9y1/zOg+4lhirMV0kj
         sRXA==
X-Forwarded-Encrypted: i=1; AJvYcCUvWI3ojj4R+8CKFCh9Ny1XIWqVKl4uGkN8iVA6O19/NapKZ3h2lSEVxCuGH0wBHYvrdntTIEnqAVJg2yeYkPPrNZju
X-Gm-Message-State: AOJu0YxS7xvHu6aXcX/xnUCrzE7Q/dZhh6BfvBMxW/nwEXjOjbsJalcM
	YvpXSfCQ//IVFGgcin4vLVrFK4z0rKPwZvVWhLfGM7JHKsY2hv+QYNpLakGLzP95lfaKPlh4b86
	vOkJHTliyBQDaMER4laU+R2o+UkoEDQUO
X-Google-Smtp-Source: AGHT+IElBQYCEiRIT7vLx0EMSp3KDs1kVupr7/gT4f9Kj4uIn3iva91pLaoKVPB2QiCxdyv3UZwmT+9hYvvp1Hn7hX4=
X-Received: by 2002:a05:6870:b50d:b0:254:b5b9:354e with SMTP id
 586e51a60fabf-25d06c1c95bmr6800218fac.19.1719307615741; Tue, 25 Jun 2024
 02:26:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 04:26:55 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240621115708.3626-12-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-12-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 04:26:55 -0500
Message-ID: <CAOLa=ZTc9uako-WzhccRb-GxjfaA-BN21Q5jV_xzquVgSptYKA@mail.gmail.com>
Subject: Re: [PATCH 11/11] t-reftable-record: add tests for reftable_log_record_compare_key()
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000b241cc061bb37ff6"

--000000000000b241cc061bb37ff6
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable_log_record_compare_key() is a function defined by
> reftable/record.{c, h} and is used to compare the keys of two
> log records when sorting multiple log records using 'qsort'.
> In the current testing setup, this function is left unexercised.
> Add a testing function for the same.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-record.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index b949617c88..d480cc438a 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -214,6 +214,30 @@ static void test_reftable_log_record_comparison(void)
>  		reftable_record_release(&in[i]);
>  }
>
> +static void test_reftable_log_record_compare_key(void)
> +{
> +	struct reftable_log_record logs[14] = { 0 };
> +	size_t N = ARRAY_SIZE(logs), i;
> +
> +	for (i = 0; i < N; i++) {
> +		if (i < N / 2) {
> +			logs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
> +			logs[i].update_index = i;
> +		} else {
> +			logs[i].refname = xstrdup("refs/heads/master");
> +			logs[i].update_index = i;
> +		}
> +	}
> +
> +	QSORT(logs, N, reftable_log_record_compare_key);
> +
> +	for (i = 1; i < N; i++)
> +		check(reftable_log_record_compare_key(&logs[i - 1], &logs[i]) < 0);
> +
> +	for (i = 0; i < N; i++)
> +		reftable_log_record_release(&logs[i]);
> +}
> +

Same comments as those from the previous commit.

>  static void test_reftable_log_record_roundtrip(void)
>  {
>  	struct reftable_log_record in[] = {
> @@ -519,6 +543,7 @@ int cmd_main(int argc, const char *argv[])
>  	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
>  	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
>  	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
> +	TEST(test_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
>  	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>  	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>  	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> --
> 2.45.2.404.g9eaef5822c

--000000000000b241cc061bb37ff6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f1eb7b3a5ac6536e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNmpWd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2hEREFDRVdNSGhDR01DOHQwTkZnWFgzUmxmbTRHOAo5VXRPaFhHcDRL
SkhuM2lYb09mYlV4dFZ6Mys5QUgrVjFxTHk0RnZaUWxwZmpReGJqRS8welVMVngvYktoZ01BCkRx
eGpDbnlkQUZOYTlBS1hkYW55UWZnTm51YzRyWjhHWHM4VjN2M0tyMFVtVm1UMmdrazlocENhSmlE
QWFaTy8KMkJzYi9rMHozOFVPVmg0WlhCNkNhWFZaV0ZTWFkwYmNMaHI4RnlvV3lTeWdRcC9jcnBV
ZUlGektJeWlJeXR6OQpWTnFHMGJOMlBIcTVOaVplWHhFUEhGMUJrRzNqN2hPL3JiNUdzN1dZVmps
ejVKSkxERXArSXEyK2xOUlZGeU9WCm5DY01RSFpseW42MVF1Um01SE45KzhDZTBHQzdkaGJ2YVNl
TjEzZm5YK3ZpblVqay9DZThEbEdqbHFXaXZmMmsKaVkrd0xGM3pOTnA0dVFwZjd5YVVrbmc3ZlJw
MVdZNXlENTNWb0RVN2JJQmNwb3E2MkJRUmo1SFN2SHdoTDlGTQpLYmxFRU5FNU1QRUVkSDl2cGU5
b2RLWVhEQVBCMFkyNElzWVpGcEdQNTBTTU9KeHlDRXNaT0tFYXRXeitONWk2Ci9sTGNFLytLWGxq
bUUxaktub0VMYTdONWVvTGRDZUJQWjl4NEhVTT0KPTRWaHgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b241cc061bb37ff6--
