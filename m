Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518F14831E
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304611; cv=none; b=qsAo0plvPiIwffSrDOlUKhs6Vy/4T+2hA4YcFNdZ6i9mmeW6OHG29f0Lw0r0LPcv7GpmB6IlBRD09huLAV2EEzAyZ1wk3CCVTy7sLDqRYv6RJIrqnZwxsfkN3Zx8sJ792xxRqtvp6Zx4mNh3rLBZZb25QGRWDw3/RZ/X1stVdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304611; c=relaxed/simple;
	bh=9K6f7qVelniFT89DSvsu6ymhW/XZsGMswH/zqLcrOpM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iboHmHgsd9s3u2Me0hFT7GNjEZl7BfcE4VpmuuLXD81lD8BHhMGUUK5ecybdQbYfK/IK3B4C0owBzl9zgWmZRqzBaoc/Sc87Xl78V3F6Rg3qa6JMktlMe9vKEeaZWBhqzS2ropAd+W2S2ma3m7g7RuO63fbZDAXmQ43iC5AzXIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvc/DYPE; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvc/DYPE"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f8edde24b3so3260014a34.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719304608; x=1719909408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTs3+5kXraIQVSpDAbu6gAFkD3ytE+FEwsS0kVuSmTY=;
        b=mvc/DYPEwIO3weu25YPN6Ce7Fcaox8CBe48TmDWihlZRkKiJtmD4QuYrP047mbzEO1
         Wr93V4rtgbZAT0B16JHGW5d2b8D7ZX+yIgMVxwHc56xWOLgkRa/d2FpTdU0J4tbnywmj
         u1invMlIYylL+988y08nt7tyTY9wN7unrUbZcwXMSZNQImCjefvfCsLpRunKEbWK9ckI
         VYvXHSnKY45qfrqCh988sA2oZ5BOAde4VKfBEFbthSM0A3cZVX2K+UJkMpWAXEbM7g6u
         W3HHOf/FaiBH77vu/gUXEE/ybuv9eTK9p2ZgR0MJRxxYd0old+lH9OUdLiqEFRn9YUY1
         byVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304608; x=1719909408;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTs3+5kXraIQVSpDAbu6gAFkD3ytE+FEwsS0kVuSmTY=;
        b=f07UmzM8MkfEKvIA4vQDK2G4bWkDIUXk8iv/xEuk/440oJ1/cUJu+SFE7r+NmDSL+a
         VAgDKeTQnHSXv3QULL0h0iiZVMIlm/ufVztB/vBiQjSuqFHox0pDUpSXcVYiAyJF0y7F
         jbmUm/qwmgkV9nI7vhJlkIuGTL1AY6YAwLyAdY9AY1HR79sGszsyBZ/L2rO9QDsqIarK
         iUL5yAlACnPpQHbyAMhSi3UGaKyxavyo8J7+KTUfadRwO/BVQBf26vKQ1cQd8g/rU5I0
         UE6tqkniILpAOgUORnT0aVRhTfJSBgEfBK5DsBXdDNv/ONEN5Oxa6E5YEeLLCMOEOMz+
         3FLw==
X-Forwarded-Encrypted: i=1; AJvYcCXoCJJUiBeqqYGwurGa9uhZcnJLcd2MyUiAuHaNjocLWf1VBjDC2vnBv7ZpR5a1tIMJ3ixb9MhnqQhLJdobegyefvKX
X-Gm-Message-State: AOJu0YwWKt960JsJriCciLkOGCX1KyKDOCCYthpdDpq57VclsIPKH51k
	p3yhZJYCAo/IKbmjDRrEP+ULi7srU0oRz4HOkdXo+B6UZ4VEzhsX3NsL1afJIIZxr5bABEscv0G
	QAftKvGgYBl63eqTWf5vw/I2BkoRDm8Sy
X-Google-Smtp-Source: AGHT+IFQ5tzIogqpuJt+gYaOwdcR3SzsZ2ULreOpBAo+SN8Z/rM060zVXMgJVFlZyY63GmEIUwX2Y2/o1Jia/BRhPIo=
X-Received: by 2002:a05:6870:a714:b0:254:c777:6327 with SMTP id
 586e51a60fabf-25d06e58cb4mr8146343fac.36.1719304608564; Tue, 25 Jun 2024
 01:36:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 03:36:47 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240621115708.3626-3-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 03:36:47 -0500
Message-ID: <CAOLa=ZTVv5wwNVUA_g2-t37+B=4i-Bs=kC2JxH3m9XMFGxi+Uw@mail.gmail.com>
Subject: Re: [PATCH 02/11] t-reftable-record: add reftable_record_cmp() tests
 for log records
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000074936d061bb2ccdc"

--00000000000074936d061bb2ccdc
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the current testing setup for log records, only
> reftable_log_record_equal() among log record's comparison functions
> is tested.
>
> Modify the existing tests to exercise reftable_log_record_cmp_void()
> (using the wrapper function reftable_record_cmp()) alongside
> reftable_log_record_equal().
> Note that to achieve this, we'll need to replace instances of
> reftable_log_record_equal() with the wrapper function
> reftable_record_equal().
>
> Rename the now modified test to reflect its nature of exercising
> all comparison operations, not just equality.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-record.c | 40 +++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index 1b357e6c7f..0cf223e51b 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -123,24 +123,38 @@ static void test_reftable_ref_record_roundtrip(void)
>  	strbuf_release(&scratch);
>  }
>
> -static void test_reftable_log_record_equal(void)
> +static void test_reftable_log_record_comparison(void)
>  {
> -	struct reftable_log_record in[2] = {
> +	struct reftable_record in[3] = {
>  		{
> -			.refname = xstrdup("refs/heads/master"),
> -			.update_index = 42,
> +			.type = BLOCK_TYPE_LOG,
> +			.u.log.refname = xstrdup("refs/heads/master"),
> +			.u.log.update_index = 42,
>  		},
>  		{
> -			.refname = xstrdup("refs/heads/master"),
> -			.update_index = 22,
> -		}
> +			.type = BLOCK_TYPE_LOG,
> +			.u.log.refname = xstrdup("refs/heads/master"),
> +			.u.log.update_index = 22,
> +		},
> +		{
> +			.type = BLOCK_TYPE_LOG,
> +			.u.log.refname = xstrdup("refs/heads/main"),
> +			.u.log.update_index = 22,
> +		},
>  	};
>
> -	check(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> -	in[1].update_index = in[0].update_index;
> -	check(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> -	reftable_log_record_release(&in[0]);
> -	reftable_log_record_release(&in[1]);
> +	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> +	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
> +	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
> +	/* comparison should be reversed for equal keys */

Nit: This is because we then compare the update-index, would be nice to
add that detail too.

> +	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
> +
> +	in[1].u.log.update_index = in[0].u.log.update_index;
> +	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> +	check(!reftable_record_cmp(&in[0], &in[1]));
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
> +		reftable_record_release(&in[i]);
>  }
>
>  static void test_reftable_log_record_roundtrip(void)
> @@ -362,7 +376,7 @@ static void test_reftable_index_record_roundtrip(void)
>
>  int cmd_main(int argc, const char *argv[])
>  {
> -	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
> +	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>  	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>  	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>  	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> --
> 2.45.2.404.g9eaef5822c

--00000000000074936d061bb2ccdc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 33f0e984d39579d1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNmdaMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXVzQy85N1l4QkpuczltR1h2bk1mOFdwWFcyZEJ6MgpyUUlIdmhJempB
Z1BGd1d6alJPclJJcFA5eDFGSTBDTG91b1FLanp0Mkt5d05DZU1GdUM0VklxclZYTzdYYjBECnRa
dlFwUG5vTGI1ZHdYWTNrdGtMcFk3SWNaVStXYkgzc2Zyd3pIVU5tbFBWRHMxejVNcGhvUTFNcTlM
OFJMcjgKeXVnNlhUSFdZZzV2NmtRWG5hcXJ0ZGZzUERQaG96MTZZak9Wa2JoMjYvUG15cjdQSjZK
RkdXL3ZJTkRONVN2dQpkR0hPQSsvUU1sYnZlYk0vUDJDb2Z0U2kxRS9NUjNvVHF4RDNaQ0VhTlVa
bTJ2dnB2ZWZCSWt1eFM4K1BqOG5CCitJQ2cyWHd0dm5MTG96ckM4anZHc2VaNy9EWjU5eXp0OWg0
TGovc2lhVzRqbDRyeVczVXlOK1dTZlNmbm5RQWYKNWcwc0k2ajF1OWkxYmRyZ2dzWS9rZ0VUVkNo
RXRJQ29Nb3pESk5iT3lPK2I0K1JRNFdVQzNzQ1p5SFBYWVl1WApDc1M5L290aHZnSjlFdHZzWE1X
RWxzSmRpREI0V2hLNGRXTSt2b09HLzJyQXZ6dnFsd3phN1Z2UHNHSndMN1ovCjF6Nkt5OUFvYVc5
WkxCOW5sRldmZ1Zoclo3STVmTGExSFljd0d4dz0KPUhJejAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074936d061bb2ccdc--
