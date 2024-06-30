Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972B39FCF
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719773959; cv=none; b=mpJiUKWOVAA9Pd5afgJhBUfMHJLXQfAtjSIIkBm44d61uRa9BxWo0MdqeSY3/zlCN4HTsxDzQbl0Q1+zXe5+mOtNs5h8L/6Ccx9beC3JjMsOhrCBaWM+u8a+wlCV0TY1vsCmfeI1A8bAePml1DJbsrjwpsNEkpx58+amrvl2tO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719773959; c=relaxed/simple;
	bh=6cB7Pq9Mb/tBLNUiCgrtvjRPXQCwwKDK8Z5mFRHh4Vc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWgd9gaua6yDpKQXlM29JtzDrc7eUGCqrx2Ym4tEggdwGNS57W95DJOz4386adg68jgx/+APw+mjK6o+Ez+S3MBWkfAu9Lz4S5D2WiNKiMkQC+o0Uas0Oda0Bv2egGgsVJwJgSqx7kH/lJxdL/NFDKDauR3Exb2+sL3051+gTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbTAPZOy; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbTAPZOy"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25cc6962c24so1002558fac.3
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719773956; x=1720378756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvGuoMrYzO6W0ixgRN9TBGOd66O/IC9QjRfY52ufcPw=;
        b=lbTAPZOyMEYzQlCqSJ8gWKRcs1LHY965MNAq/oFB5E+5A18LeT/NCkInlVUSjxSstg
         dcAy6/W/xE/jmepvqYQMy79qnP+dNeeuXx7ddRE8vAYFcz5qOzjSmxhldTDjCfZt3xkQ
         9tmGLEcew4ZERiK+3b1tOEQ62Esf7G+EPYInQXxM+yciixivL7IpSTQG//2G5X6sViuC
         kKNjnKVKHu5FnzBgO7dJWliaUc1m6EWbg66Qs9sb87Ww90AWTHtOUPBwnWFUO+guo9dz
         Zs89C9w51ri3/zrPhUFI4kZtii1cxxWTkyOPOULrAITraiBUf1He8xKPM/WrAi+FtRSO
         iNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719773956; x=1720378756;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvGuoMrYzO6W0ixgRN9TBGOd66O/IC9QjRfY52ufcPw=;
        b=ct2Ub3ZZcdtRqDiDOSi1AxSMp6jVMMzjQiH6dyPJYVKPSEE6hZGu2h/vXB/TVpDjaT
         lIY6iposXJ5VRIaP0vsZGy23Ma14TR4DoYD3Yii8eZ9jss3rDvDpiEOUGlZWkMgnc8av
         G6Kcu4BTTi3Indoaivb333PSXHsVx8R/rxMO3CoR9cKZamO2FizW6mTqDJySNcTE+Inh
         lBNx2+yk6tego8j65tt/PEd6yu2Dg26iVnBNgNlQXzJ9oMEuhXah1JdQXm/9J2k0af2A
         jzL1Y9NsgGhDjWNFDYLZKjA8tgYBIFDKiPWoy1SqyWDTkME/h7dI/XYYRpO4NTNbWelk
         3/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrDibp46c/3NNMVt+RyZx6YZgw0nB992wM3pbxO081JSitCN2IqI4EDEetHNEnBwha9ZdbQMpPaVh3gU3tU0IjuVLS
X-Gm-Message-State: AOJu0Yw+PJwZnujDj/Qrla7M5ygLwvnk2Lbe5MZZDkpyXzhRVbnFZRcM
	0mkwVeP1+MbVBLPwhic2NHnoMaVugf9TMF9nGfWUhy1/BzpFHYeMbVVPpYQhEnARTkn4QvCTRN2
	qIrVerg8zsOGR0ZWZffbO7DHTGfU=
X-Google-Smtp-Source: AGHT+IE6yxA2EVzV0aON4w3qoLAWHci0a25E5x3XbZI8I9RFH2KiY6Xwz70ClpnwuQ4oZ0Ws04+dcXMria2u/VbfVlI=
X-Received: by 2002:a05:6871:3a20:b0:25d:7fd1:cd17 with SMTP id
 586e51a60fabf-25db34a9368mr1928056fac.6.1719773956511; Sun, 30 Jun 2024
 11:59:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 30 Jun 2024 14:59:15 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628063625.4092-11-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com> <20240628063625.4092-11-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Jun 2024 14:59:15 -0400
Message-ID: <CAOLa=ZRx6LQ26U-00UUttjo7sitLZ+gWA7FX0m3p1nQGhGF7Zw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000c5bd68061c201377"

--000000000000c5bd68061c201377
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable_ref_record_compare_name() is a function defined by
> reftable/record.{c, h} and is used to compare the refname of two
> ref records when sorting multiple ref records using 'qsort'.
> In the current testing setup, this function is left unexercised.
> Add a testing function for the same.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-record.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index 55b8d03494..f45f2fdef2 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -95,6 +95,28 @@ static void test_reftable_ref_record_comparison(void)
>  	check(!reftable_record_cmp(&in[0], &in[1]));
>  }
>
> +static void test_reftable_ref_record_compare_name(void)
> +{
> +	struct reftable_ref_record recs[14] = { 0 };
> +	size_t N = ARRAY_SIZE(recs), i;
> +
> +	for (i = 0; i < N; i++)
> +		recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);

This needs to be free'd too right?

So we create an array of 14 records, with refnames "00", "01", "02" ...
"13", here.

> +
> +	QSORT(recs, N, reftable_ref_record_compare_name);
> +

We then use `reftable_ref_record_compare_name` as the comparison
function to sort them.

> +	for (i = 1; i < N; i++) {
> +		check_int(strcmp(recs[i - 1].refname, recs[i].refname), <, 0);
> +		check_int(reftable_ref_record_compare_name(&recs[i], &recs[i]), ==, 0);
> +	}

Here we use `strcmp` to ensure that the ordering done by
`reftable_ref_record_compare_name` is correct. This makes sense,
although I would have expected this to be done the other way around.
i.e. we should use `strcmp` as the function used in `QSORT` and in this
loop we validate that `reftable_ref_record_compare_name` also produces
the same result when comparing.

> +
> +	for (i = 0; i < N - 1; i++)
> +		check_int(reftable_ref_record_compare_name(&recs[i + 1], &recs[i]), >, 0);
> +

Also, with the current setup, we use `reftable_ref_record_compare_name`
to sort the first array and then use `reftable_ref_record_compare_name`
to check if it is correct? This doesn't work, we need to isolate the
data creation from the inference, if the same function can influence
both, then we are not really testing the function.

> +	for (i = 0; i < N; i++)
> +		reftable_ref_record_release(&recs[i]);
> +}
> +

Nit: The top three loops could possibly be combined.

>  static void test_reftable_ref_record_roundtrip(void)
>  {
>  	struct strbuf scratch = STRBUF_INIT;
> @@ -490,6 +512,7 @@ int cmd_main(int argc, const char *argv[])
>  	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>  	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
>  	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
> +	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
>  	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>  	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>  	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> --
> 2.45.2.404.g9eaef5822c

--000000000000c5bd68061c201377
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 37068b7fafe25420_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hQnF3RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUpiREFDanc0MkgxMGdOSS9rUWhOWVZvYVhvOEQ3VwowSGh6d25JTStD
K2NhenphcG94VjVwR3NFR2oxWHozSEp4NFMwZlJBd3E3TUFVZTdsUWlZWXRDYW16czUranpMCk51
dDRMR3QyNXNFbGx0eE9RODZsV1ZPZDBEbHpSMWl0Mk9nRTY4UXpTRmxCMHplOGNvNWVtSkV3MXdn
eDBORTMKYk9DL29jSTRUWFZ5SGVpMTZXcTZmTmhDdWxodGlwUVEzNXVIVVBsMEdUNXFBRVU3bDBX
SFU5OGxXcWJ0K1Vwawpqa08zd3BiVU5tM0xrSDIrcFNGc1BnaUQrZjltUXEvVFZDZXlEOTU1S2dK
UDh5NVJxV1c5dmF3NlZIeFdHSEw3Cm9uYnh4ZEx2bkJrV0lzOC9lTURjTnZYdTYrM3VCbm1zSndE
aFNuaVpvem9KUUxuRHBLZlpmT2dvTGVZa3JrQkkKNzNnWTR5SW9aSjBhcVQxd0VDaWtxQVh1aGJ4
SXA4TG91bUU5Z2MvYkVrWmZ2NzJKOU5lbUwxem9UeEEyeGp2Zgp0SHJGY1RseDhoV0NUNUVqdnpH
U0t3dWFOcklrRWV6VXdNdktVUk5MdjNHdW83cWQ4YUFXcFdQUFVZK0dxNzhkCjlMTkU3T01BRFB5
cmZIZ1E0WVlSemgvM0FlNlFINmU5ZVRicTZjdz0KPXJXTUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c5bd68061c201377--
