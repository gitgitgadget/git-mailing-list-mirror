Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFD1487D4
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307578; cv=none; b=hDkY+J7hl4r0hoxkGokffp94LCy2uGFEfIk3014jKTPpJDFDILW4ch6dYk4tTEydxrWUJm7ubBOgwF0prcAUVIG8D/JojAvu3JFegIPmYokOdVQ+SfOUZrO4zj1U0O4PMdPtpcmRUz7f2A5gdrvMGFoh4GTyC8cCp23ntKr4tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307578; c=relaxed/simple;
	bh=gTPgYe1MvHT0IFnQmh5t97VlYCyBatiq8xewHtxG7Dw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJH/TZCV752T1gH2YtF8DgbXTir4qlD1+Jb9gtcXMUr5vvJP1YgMuIF4cdMp4s010HXiequhO1XFZdYZdKFrstjEv3BbK5mAWa8curQ8XV1QCjexybEodQpWFOd2MrG6Wvz12Qso0qRMf84O4LngGkxKGlWTOZ2UQuWgq8ELsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhJ7wwDq; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhJ7wwDq"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7005c84e525so3162270a34.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719307576; x=1719912376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ovh9bqj0JSsUv8L05GrIksbBn7Fw9FhFYI/A0sgsik=;
        b=WhJ7wwDquR/0v4QX1COWyTxT5TQWD2TF0i0hPHCgpQ9TaX5AGYNkQZv0Ozp87VzxBe
         b4n8qR6c1ZzoWnd67Ta4WUVGYV/ZCJ662So67cdArfAWwZfVtirN46A75XNBy/sPOTCe
         bmuU1HtLEgavTRRZUkSr3HC4uMTseyDkWKZwiJ23BNRr72Nxax3MO+3ALSzAzDMqPFkt
         Bcuyi8e26cFzTRQ34yo/vvb5Xd6coQvX/6RElWeYcjShC+yL00Vw3d6qk/9kI8eqtC70
         +lIeHiyJqF8XGNIyCM9GJLT07thMXrerzIsaKMZoDuUG32KPuCAPCclBm2jtY6WoTPJE
         k21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307576; x=1719912376;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ovh9bqj0JSsUv8L05GrIksbBn7Fw9FhFYI/A0sgsik=;
        b=Er+aSo8U702Z+CZeOg9ASGILjk+XvwnLKA0uG7g1iozTFZJ1HSAR66YWNDuPtEWSBf
         9D2r01vY2LYpERv4lohV/xI7wBZM5RQrsVuYmDiUdwvLwnJWCpkEkF2Qw49KNByqnlSC
         PdAFzXLGKLqXDdDOzWzrfGz5jgt6yPYLgTWvmj6V9H3lXf0d+7WZMqPMmMxyngtl/tGX
         5NEFzc9qVpN5YPdDap2N2DfZK1QxtMtsDAVecOGyQSTSUfMrJ64zETU9MAbhyv9uUM2R
         7rvWqi0Q8ygmV1X6PtAZWzSI9gb2l+E61nS05TBc/oph/BF4+L0UUV3d72iyjHDJt3TR
         BiTw==
X-Forwarded-Encrypted: i=1; AJvYcCVrsr/JBBi1QofdmbNDETLbwxurWBSpRy1ZWLRZsiYJdqkm/pJl9RcyZtvoVFP2WLkf7CjqV61JitTmiPsBjhRyRUL5
X-Gm-Message-State: AOJu0YyxjacML5R5RoOPLvKWL99liC59yRfJc63CshsL8tuqcrYUlk/5
	V1tcyWggGzvNb9mPbtKnSvc3YsIvcrZA487wuEdYu+f2RreLKB4+lLK2WuAEDyDWN+yqHMRUQKW
	OdXrIZpYyMkvaBYgEDs1HiPLBlBM=
X-Google-Smtp-Source: AGHT+IGvHXsORR4HJhxNaoHYvronUGAt8A1bM1dMrDwjx/yIPYz5JP2bD6GKl2w2nIra9yWPLmGV2wVUvFwRHGc5wq4=
X-Received: by 2002:a05:6870:611e:b0:250:70bb:1a97 with SMTP id
 586e51a60fabf-25d06c34e63mr7302878fac.24.1719307575631; Tue, 25 Jun 2024
 02:26:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 04:26:15 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240621115708.3626-11-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-11-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 04:26:15 -0500
Message-ID: <CAOLa=ZTnwA0gYeDo3m9ZZD-jJJN=+FdVKTLDKTG4x-vn6wC2jg@mail.gmail.com>
Subject: Re: [PATCH 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000004e4316061bb37da3"

--0000000000004e4316061bb37da3
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
>  t/unit-tests/t-reftable-record.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index 99ebfafe0b..b949617c88 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -101,6 +101,23 @@ static void test_reftable_ref_record_comparison(void)
>  		reftable_record_release(&in[i]);
>  }
>
> +static void test_reftable_ref_record_compare_name(void)
> +{
> +	struct reftable_ref_record recs[14] = { 0 };
> +	size_t N = ARRAY_SIZE(recs), i;
> +
> +	for (i = 0; i < N; i++)
> +		recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
> +
> +	QSORT(recs, N, reftable_ref_record_compare_name);
> +
> +	for (i = 1; i < N; i++)
> +		check(reftable_ref_record_compare_name(&recs[i - 1], &recs[i]) < 0);
> +

I understand the intention, but using a function to help sort strings
and then using validating the same function with those strings doesn't
validate the functionality of the function.

I would have preferred to see some hardcoded strings and simply
comparison between them. Also comparison's where
`reftable_ref_record_compare_name` returns '0' and '> 0' values.

> +	for (i = 0; i < N; i++)
> +		reftable_ref_record_release(&recs[i]);
> +}
> +
>  static void test_reftable_ref_record_roundtrip(void)
>  {
>  	struct strbuf scratch = STRBUF_INIT;
> @@ -501,6 +518,7 @@ int cmd_main(int argc, const char *argv[])
>  	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>  	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
>  	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
> +	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
>  	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>  	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>  	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> --
> 2.45.2.404.g9eaef5822c

--0000000000004e4316061bb37da3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 35d8beb7e36f9608_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNmpUUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXdhQy85MGtVMFQ0d0JWRWlCbFY1Z015bmFaTk9EZwpyYWtCYkVDZ1BU
ejN4TXVBZDZnYmMzNFJGMXVJYXdFZENqNm1yYy9zVGtFM1hNMDVLMGl0dFdWVkttSmltUk56Ckl2
a0Z1VzBSTU5mWnAyMys0YnlMZmtpQjlZSXZBWFJIQUlNY2wyVnAyYTFNMUt6VkdRa1ArSHpyWXhV
NVFyU0EKSEI1SGExV0J3b1RLcDhhNnNWTEZsNnFXazVYd040anNMSk1jK1hWUEtnN3FKUG42eU9o
N0MwbUtxeXloblY4TQo2RXpiUUlSL1BYMzJRaTl4Ry8wN0dvK3dHNWpySDZMMUJRNUR2emhsck1K
SElTclVRUU5uVVAvNGNlaDV5WjA0CjJmMXl2VXJlTFR4NU1GTTgwWkdpUStmcTJNTEluVzBldnAw
Z2xJc1NxM2ZjRnc5UDQ3QkwwbWhGRlYyQ1BveXUKR20veU1XU01RL1E2Q1VGd21raWZscy8xY2pS
dkhrME9qWlZlTVhGNEhVeFh3M1oyYmdYT3B2WElidGQ0WlFFWgpvNmF3dWxNNG1hYmlJTzNKRkpY
TFJIOC8xS3RBUEk3QVNTeURDb1RFdjIyTU55T1pjc0c2NnBubTJMVkNxQUd2CkZPV2dldEVyMEZI
cXNieHpwM015Zi9VdkllaVl2amtQSVV6MStTcz0KPWhrZXIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004e4316061bb37da3--
